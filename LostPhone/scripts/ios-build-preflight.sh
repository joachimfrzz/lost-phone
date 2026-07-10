#!/usr/bin/env bash
# Fail fast before xcodebuild when the tree uses APIs unavailable on CI (Xcode 16 / iOS 18 SDK).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SWIFT_ROOT="$ROOT/LostPhone/LostPhone"

echo "→ iOS build preflight"

failed=0

for pattern in '\.glassEffect\('; do
  if matches="$(grep -Rn "$pattern" "$SWIFT_ROOT" --include='*.swift' 2>/dev/null || true)"; then
    if [[ -n "$matches" ]]; then
      echo "ERROR: forbidden API « $pattern » (not in CI SDK). Found:" >&2
      echo "$matches" >&2
      failed=1
    fi
  fi
done

if [[ ! -f "$ROOT/LostPhone/project.yml" ]]; then
  echo "ERROR: LostPhone/project.yml missing" >&2
  failed=1
fi

if [[ ! -d "$ROOT/public/stories" ]]; then
  echo "ERROR: public/stories missing" >&2
  failed=1
fi

if ! python3 "$ROOT/LostPhone/scripts/validate-lpsp-json.py"; then
  failed=1
fi

if python3 - "$SWIFT_ROOT" <<'PY'
import re, sys
from pathlib import Path

root = Path(sys.argv[1])
issues = []
pattern = re.compile(r'(?:static\s+)?func\s+\w+[^{]+\)\s*->\s*[^{]+\{\s*\n(\s*)let\s+')

skip_prefixes = ("Apps/Clone/", "Apps/Sopheamen/")
skip_substrings = ("/Sopheamen/",)

for path in sorted(root.rglob("*.swift")):
    rel = path.relative_to(root).as_posix()
    if rel.startswith(skip_prefixes) or any(s in rel for s in skip_substrings):
        continue
    text = path.read_text(encoding="utf-8")
    for m in pattern.finditer(text):
        start = m.start()
        line_start = text.rfind("\n", 0, start) + 1
        prefix = text[max(0, start - 400):start]
        if "@ViewBuilder" in prefix:
            continue
        func_idx = text.rfind("func ", 0, start)
        if func_idx != -1 and "@escaping" in text[func_idx:start]:
            continue
        # Completion handlers / Void APIs are not ViewBuilder bodies.
        if "-> Void" in prefix or "@escaping" in prefix:
            continue
        brace = text.find("{", start)
        depth = 0
        for i in range(brace, len(text)):
            if text[i] == "{":
                depth += 1
            elif text[i] == "}":
                depth -= 1
                if depth == 0:
                    body = text[brace + 1 : i].strip()
                    if body and not re.search(r"\breturn\b", body):
                        line = text[:start].count("\n") + 1
                        issues.append(f"{path}:{line}: missing explicit return after `let`")
                    break

if issues:
    print("\n".join(issues), file=sys.stderr)
    sys.exit(1)
PY
then
  :
else
  failed=1
fi

if [[ "$failed" -ne 0 ]]; then
  echo "Preflight failed — fix the issues above before running xcodebuild." >&2
  exit 1
fi

echo "✓ Preflight OK"

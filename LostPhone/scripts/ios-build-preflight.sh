#!/usr/bin/env bash
# Fail fast before xcodebuild when the tree uses APIs unavailable on CI (Xcode 16 / iOS 18 SDK).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SWIFT_ROOT="$ROOT/LostPhone/LostPhone"

echo "→ iOS build preflight"

FORBIDDEN=(
  '\.glassEffect\('
)

failed=0
for pattern in "${FORBIDDEN[@]}"; do
  if matches="$(rg -n "$pattern" "$SWIFT_ROOT" --glob '*.swift' 2>/dev/null || true)"; then
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

if [[ "$failed" -ne 0 ]]; then
  echo "Preflight failed — fix the issues above before running xcodebuild." >&2
  exit 1
fi

echo "✓ Preflight OK"

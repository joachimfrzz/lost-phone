#!/usr/bin/env python3
"""Copy a SwiftUI GitHub clone into Apps/Vendored/ with type-prefixing to avoid symbol clashes."""

from __future__ import annotations

import argparse
import re
import shutil
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
VENDORED_ROOT = REPO_ROOT / "LostPhone" / "Apps" / "Vendored"

SKIP_DIR_NAMES = {"tests", "test", "uitests", "preview content", "preview", "pods", ".git"}
SKIP_FILE_PATTERNS = ("test", "uitest", "preview provider", "_preview")

TYPE_DEF = re.compile(
    r"^(?P<indent>\s*)(?P<kw>struct|class|enum|actor)\s+(?P<name>[A-Za-z_][A-Za-z0-9_]*)",
    re.MULTILINE,
)

MAIN_APP = re.compile(r"@main\s+struct\s+(\w+)\s*:\s*App", re.MULTILINE)


def should_skip_path(path: Path) -> bool:
    parts = {p.lower() for p in path.parts}
    if parts & SKIP_DIR_NAMES:
        return True
    lower = path.name.lower()
    if "preview" in lower and path.suffix == ".swift":
        return True
    return False


def collect_swift_files(source: Path) -> list[Path]:
    files: list[Path] = []
    for p in source.rglob("*.swift"):
        if should_skip_path(p.relative_to(source)):
            continue
        text = p.read_text(encoding="utf-8", errors="replace")
        if "@main" in text and ": App" in text:
            continue
        files.append(p)
    return sorted(files)


def discover_types(text: str) -> list[str]:
    names: list[str] = []
    for m in TYPE_DEF.finditer(text):
        name = m.group("name")
        if name.endswith("_Previews") or name.endswith("_Preview"):
            continue
        if name.endswith("PreviewProvider"):
            continue
        names.append(name)
    return names


def prefix_types(text: str, mapping: dict[str, str]) -> str:
    # Longest names first to avoid partial replacements.
    for old in sorted(mapping, key=len, reverse=True):
        new = mapping[old]
        text = re.sub(rf"\b{re.escape(old)}\b", new, text)
    return text


def copy_assets(source: Path, dest_app: Path) -> None:
    for pattern in ("*.xcassets", "Assets.xcassets", "Resources"):
        for item in source.rglob(pattern.split("/")[0] if "/" not in pattern else pattern):
            if item.is_dir() and item.name.endswith(".xcassets"):
                target = dest_app / "Resources" / item.name
                if target.exists():
                    shutil.rmtree(target)
                shutil.copytree(item, target)
                print(f"  assets: {item.name}")


def write_root_view(app_label: str, prefix: str, entry_type: str, dest_app: Path) -> None:
    root_name = f"LpspVendored{app_label}RootView"
    entry_prefixed = f"{prefix}{entry_type}"
    content = f"""import SwiftUI

/// Point d'entrée Lost Phone — clone vendored (préfixe `{prefix}`).
struct {root_name}: View {{
    var body: some View {{
        {entry_prefixed}()
    }}
}}
"""
    (dest_app / f"{root_name}.swift").write_text(content, encoding="utf-8")


def write_source_md(
    dest_app: Path,
    app_label: str,
    repo_url: str,
    licence: str,
    entry: str,
    notes: str,
) -> None:
    md = f"""# {app_label} — source vendored

| Champ | Valeur |
|-------|--------|
| **Repo** | {repo_url} |
| **Licence** | {licence} |
| **Entrée Lost Phone** | `LpspVendored{app_label}RootView()` → `{entry}` |

## Adaptations Lost Phone

- Types préfixés pour éviter les collisions avec les autres clones.
- Fichiers `@main` / tests exclus du bundle.
{notes}
"""
    (dest_app / "SOURCE.md").write_text(md, encoding="utf-8")


def vendor(
    source: Path,
    app_dir_name: str,
    app_label: str,
    type_prefix: str,
    entry_type: str,
    repo_url: str,
    licence: str = "?",
    notes: str = "",
) -> None:
    dest_app = VENDORED_ROOT / app_dir_name
    if dest_app.exists():
        shutil.rmtree(dest_app)
    dest_app.mkdir(parents=True)

    swift_files = collect_swift_files(source)
    if not swift_files:
        raise SystemExit(f"No Swift files found under {source}")

    all_types: set[str] = set()
    file_texts: dict[Path, str] = {}
    for f in swift_files:
        text = f.read_text(encoding="utf-8", errors="replace")
        file_texts[f] = text
        all_types.update(discover_types(text))

    mapping = {name: f"{type_prefix}{name}" for name in sorted(all_types, key=len, reverse=True)}

    for src_f, text in file_texts.items():
        rel = src_f.relative_to(source)
        out = dest_app / rel
        out.parent.mkdir(parents=True, exist_ok=True)
        prefixed = prefix_types(text, mapping)
        out.write_text(prefixed, encoding="utf-8")
        print(f"  {rel}")

    copy_assets(source, dest_app)
    entry_prefixed = f"{type_prefix}{entry_type}"
    write_root_view(app_label, type_prefix, entry_type, dest_app)
    write_source_md(dest_app, app_label, repo_url, licence, entry_prefixed, notes)
    print(f"OK {app_dir_name} — {len(swift_files)} fichiers, entrée {entry_prefixed}")


def main() -> None:
    p = argparse.ArgumentParser(description="Vendor SwiftUI clone into Apps/Vendored/")
    p.add_argument("source", type=Path, help="Path to cloned repo root")
    p.add_argument("--app-dir", required=True, help="Folder name under Vendored/")
    p.add_argument("--app-label", required=True, help="PascalCase label for LpspVendored*RootView")
    p.add_argument("--prefix", required=True, help="Type prefix, e.g. VendoredDisney")
    p.add_argument("--entry", required=True, help="Root view struct name in clone (before prefix)")
    p.add_argument("--repo", required=True, help="GitHub URL")
    p.add_argument("--licence", default="?")
    p.add_argument("--notes", default="")
    args = p.parse_args()
    vendor(
        args.source.resolve(),
        args.app_dir,
        args.app_label,
        args.prefix,
        args.entry,
        args.repo,
        args.licence,
        args.notes,
    )


if __name__ == "__main__":
    main()

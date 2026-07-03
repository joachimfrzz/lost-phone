#!/usr/bin/env python3
"""Generate LpspAwesome*View.swift v3 — composants extraits des DESIGN-swiftui.md (Spectr / Meliwat)."""

from __future__ import annotations

import sys
from pathlib import Path

from awesome_templates import category_from_path, slug
from awesome_v3_assemble import assemble_root
from awesome_v3_transform import extract_swift_blocks, transform_blocks
from generate_awesome_apps import APP_PATHS

DEFAULT_SPEC_ROOT = Path(__file__).resolve().parents[2] / "awesome-ios-design-md" / "design-md"
REPO_ROOT = Path(__file__).resolve().parents[1]


def generate_view(
    app_name: str,
    rel: str,
    spec_root: Path,
    out_dir: Path,
) -> bool:
    spec_path = spec_root / rel / "DESIGN-swiftui.md"
    if not spec_path.is_file():
        print(f"  SKIP {app_name}: spec absente ({spec_path})")
        return False

    md = spec_path.read_text(encoding="utf-8")
    category = category_from_path(rel)
    prefix = f"Lpsp{slug(app_name)}"
    blocks = extract_swift_blocks(md)
    components_swift, token_names, font_names, components = transform_blocks(blocks, prefix)
    root_swift = assemble_root(app_name, prefix, category, md, components, token_names)

    gallery_slug = rel.split("/")[-1]
    body = f"""import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/{rel}/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/{gallery_slug}
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesome{slug(app_name)}View: View {{
    var body: some View {{
        {prefix}ShowroomRoot()
    }}
}}

// MARK: - Composants spec (préfixés)
{components_swift}

// MARK: - Écrans showroom
{root_swift}
"""

    out_path = out_dir / f"LpspAwesome{slug(app_name)}View.swift"
    out_path.write_text(body, encoding="utf-8")
    print(f"  OK {app_name} ({len(components)} composants)")
    return True


def write_router(out_dir: Path, apps: list[str]) -> None:
    registry = '''import SwiftUI

/// Routage showroom → vues Awesome v3 (Spectr / Meliwat DESIGN-swiftui.md).
enum AwesomeShowroomRouter {
    @ViewBuilder
    static func view(for appName: String) -> some View {
        switch LpspAppAliases.canonical(appName) {
'''
    for app_name in apps:
        registry += f'        case "{app_name}": LpspAwesome{slug(app_name)}View()\n'
    registry += '''        default:
            AwesomeShowroomFallbackView(appName: appName)
        }
    }
}

struct AwesomeShowroomFallbackView: View {
    let appName: String
    var body: some View {
        NavigationStack {
            ContentUnavailableView(appName, systemImage: "app.fill", description: Text("Vue Awesome en cours"))
        }
    }
}
'''
    (out_dir.parent / "AwesomeShowroomRouter.swift").write_text(registry, encoding="utf-8")


def write_catalog() -> None:
    tier = [name for name in APP_PATHS if name != "Google Maps"]
    lines = "\n".join(f'        "{name}",' for name in tier)
    catalog = f"""import Foundation

enum AwesomeShowroomCatalog {{
    static let tierApps: [String] = [
{lines}
    ]
}}
"""
    path = REPO_ROOT / "LostPhone/Core/Services/AwesomeShowroomCatalog.swift"
    path.write_text(catalog, encoding="utf-8")


def main(argv: list[str]) -> int:
    spec_root = Path(argv[1]) if len(argv) > 1 else DEFAULT_SPEC_ROOT
    out_dir = (
        Path(argv[2])
        if len(argv) > 2
        else REPO_ROOT / "LostPhone/Apps/Awesome/Generated"
    )

    if not spec_root.is_dir():
        print(f"ERREUR: dossier specs introuvable: {spec_root}")
        print("Clone: git clone https://github.com/Meliwat/awesome-ios-design-md.git")
        return 1

    out_dir.mkdir(parents=True, exist_ok=True)
    print(f"Specs : {spec_root}")
    print(f"Sortie: {out_dir}")

    ok_apps: list[str] = []
    for app_name, rel in APP_PATHS.items():
        if generate_view(app_name, rel, spec_root, out_dir):
            ok_apps.append(app_name)

    write_router(out_dir, ok_apps)
    write_catalog()
    print(f"\nTerminé: {len(ok_apps)}/{len(APP_PATHS)} apps")
    return 0 if len(ok_apps) == len(APP_PATHS) else 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))

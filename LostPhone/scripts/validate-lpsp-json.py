#!/usr/bin/env python3
"""Validate LPSP JSON files — quick preflight for story bundles."""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
STORIES = [ROOT / "public/stories", ROOT / "LostPhone/LostPhone/Resources/stories"]

REQUIRED_APPS_J3 = {
    "Banque", "Plans", "Uber", "WhatsApp", "Signal", "Instagram",
    "Spotify", "Netflix", "Fichiers", "Rappels",
}
LEGACY = {"Crédit Agricole", "Google Maps"}


def check_story(path: Path) -> list[str]:
    issues = []
    try:
        data = json.loads(path.read_text(encoding="utf-8-sig"))
    except json.JSONDecodeError as e:
        return [f"{path}: JSON invalid — {e}"]

    apps = data.get("manifest", {}).get("apps_presentes", [])
    content = data.get("content", {}).get("apps", {})

    for legacy in LEGACY:
        if legacy in apps:
            issues.append(f"{path}: legacy app name still in apps_presentes: {legacy}")
        if legacy in content:
            issues.append(f"{path}: legacy content.apps key: {legacy}")

    if "j3-louvre" in path.parts:
        for name in REQUIRED_APPS_J3:
            if name not in apps:
                issues.append(f"{path}: missing apps_presentes entry: {name}")
            if name not in content:
                issues.append(f"{path}: missing content.apps.{name}")

    return issues


def main() -> int:
    all_issues: list[str] = []
    seen: set[Path] = set()
    for base in STORIES:
        if not base.is_dir():
            continue
        for path in sorted(base.glob("*/lpsp.json")):
            if path in seen:
                continue
            seen.add(path)
            all_issues.extend(check_story(path))

    if all_issues:
        print("\n".join(all_issues), file=sys.stderr)
        return 1
    print(f"✓ LPSP OK ({len(seen)} stories)")
    return 0


if __name__ == "__main__":
    sys.exit(main())

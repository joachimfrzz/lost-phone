#!/usr/bin/env python3
"""Repair vendored Sopheamen Color extensions: wrap body + prefix all static lets per app."""

from __future__ import annotations

import re
from pathlib import Path

VENDORED = Path(__file__).resolve().parents[1] / "LostPhone" / "Apps" / "Vendored"

# app folder -> type prefix (VendoredWhatsApp)
APP_PREFIXES: dict[str, str] = {
    "WhatsApp": "VendoredWhatsApp",
    "Instagram": "VendoredInstagram",
    "Snapchat": "VendoredSnapchat",
    "LinkedIn": "VendoredLinkedIn",
    "Facebook": "VendoredFacebook",
    "Messenger": "VendoredMessenger",
    "Threads": "VendoredThreads",
    "Gemini": "VendoredGemini",
    "Netflix": "VendoredNetflix",
    "YouTube": "VendoredYouTube",
    "YouTubeMusic": "VendoredYouTubeMusic",
    "Phantom": "VendoredPhantom",
    "Uber": "VendoredUber",
    "UberEats": "VendoredUberEats",
    "Airbnb": "VendoredAirbnb",
    "TikTok": "VendoredTikTok",
    "Gmail": "VendoredGmail",
    "AppStore": "VendoredAppStore",
    "AppleMusic": "VendoredAppleMusic",
}


def pascal(s: str) -> str:
    parts = re.split(r"[_\s]+", s)
    return "".join(p[:1].upper() + p[1:] for p in parts if p)


def prefix_name(type_prefix: str, color_name: str) -> str:
    suffix = type_prefix.removeprefix("Vendored")
    return f"vendored{suffix}{pascal(color_name)}"


def find_colors_file(app_dir: Path) -> Path | None:
    matches = sorted(app_dir.rglob("*Color*.swift"))
    return matches[0] if matches else None


def extract_static_lets(text: str) -> list[tuple[str, str]]:
    lines: list[tuple[str, str]] = []
    for line in text.splitlines():
        m = re.match(r"\s*static let (\w+)\s*=\s*(.+)$", line)
        if m:
            lines.append((m.group(1), m.group(2).rstrip()))
    return lines


def fix_app(app_dir_name: str, type_prefix: str) -> None:
    app_dir = VENDORED / app_dir_name
    if not app_dir.is_dir():
        return
    colors_file = find_colors_file(app_dir)
    if not colors_file:
        print(f"skip {app_dir_name}: no Colors file")
        return

    raw = colors_file.read_text(encoding="utf-8", errors="replace")
    statics = extract_static_lets(raw)
    if not statics:
        print(f"skip {app_dir_name}: no static lets")
        return

    mapping = {old: prefix_name(type_prefix, old) for old, _ in statics}

    # Rewrite theme file
    body_lines = [f"    static let {mapping[old]} = {expr}" for old, expr in statics]
    new_colors = "import SwiftUI\n\nextension Color {\n" + "\n".join(body_lines) + "\n}\n"
    colors_file.write_text(new_colors, encoding="utf-8")

    # Patch references in app folder
    for swift in app_dir.rglob("*.swift"):
        if swift == colors_file:
            continue
        text = swift.read_text(encoding="utf-8", errors="replace")
        original = text
        for old, new in sorted(mapping.items(), key=lambda x: len(x[0]), reverse=True):
            text = text.replace(f"Color.{old}", f"Color.{new}")
        if text != original:
            swift.write_text(text, encoding="utf-8")

    print(f"fixed {app_dir_name}: {len(mapping)} colors")


def main() -> None:
    for app_dir, prefix in APP_PREFIXES.items():
        fix_app(app_dir, prefix)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Vendor all SwiftUI Sopheamen Patreon clones into Apps/Vendored/."""

from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

SCAN_ROOT = Path("/tmp/sopheamen-scan")
SCRIPT = Path(__file__).resolve().parent / "vendor_swiftui_clone.py"

# LPSP showroom name may differ from folder label (e.g. Phantom → Coinbase).
APPS: list[tuple[str, str, str, str, str]] = [
    # app_dir, app_label, type_prefix, source_subpath, zip_name
    ("WhatsApp", "WhatsApp", "VendoredWhatsApp", "WhatsAppclone patreon/WhatsAppclone patreon/WhatsAppclone", "WhatsAppclone patreon.zip"),
    ("Instagram", "Instagram", "VendoredInstagram", "Instagram clone patreon/Instagram clone patreon/Instagram clone", "Instagram clone patreon.zip"),
    ("Snapchat", "Snapchat", "VendoredSnapchat", "Snapchat Clone patreon/Snapchat Clone patreon/Snapchat Clone", "Snapchat Clone patreon.zip"),
    ("LinkedIn", "LinkedIn", "VendoredLinkedIn", "LinkedIn Clone patreon/LinkedIn Clone patreon/LinkedIn Clone", "LinkedIn Clone patreon.zip"),
    ("Facebook", "Facebook", "VendoredFacebook", "Youtube_Facebook_v1/Youtube_Facebook_v1/Youtube_Facebook", "Youtube_Facebook_v1.zip"),
    ("Messenger", "Messenger", "VendoredMessenger", "Youtube_FacebookMessenger_v1/Youtube_FacebookMessenger_v1/Youtube_FacebookMessenger", "Youtube_FacebookMessenger_v1.zip"),
    ("Threads", "Threads", "VendoredThreads", "Youtube_Threads_v1/Youtube_Threads_v1/Youtube_Threads", "Youtube_Threads_v1.zip"),
    ("Gemini", "Gemini", "VendoredGemini", "Youtube_Gemini_clone_v1/Youtube_Gemini_clone_v1/Youtube_Gemini_clone", "Youtube_Gemini_clone_v1.zip"),
    ("Netflix", "Netflix", "VendoredNetflix", "Youtube_Netflix_v1/Youtube_Netflix_v1/Youtube_Netflix", "Youtube_Netflix_v1.zip"),
    ("YouTube", "YouTube", "VendoredYouTube", "Youtube_Youtube_v1/Youtube_Youtube_v1/Youtube_Youtube", "Youtube_Youtube_v1.zip"),
    ("YouTubeMusic", "YouTubeMusic", "VendoredYouTubeMusic", "Youtube_Music_v2_1/Youtube_Music_v2_1/Youtube_Music_v2", "Youtube_Music_v2_1.zip"),
    ("Phantom", "Phantom", "VendoredPhantom", "Youtube_Phantom_clone_v1/Youtube_Phantom_clone_v1/Youtube_Phantom_clone", "Youtube_Phantom_clone_v1.zip"),
    ("Uber", "Uber", "VendoredUber", "Youtube_uber_clone_v1/Youtube_uber_clone_v1/Youtube_uber_clone", "Youtube_uber_clone_v1.zip"),
    ("UberEats", "UberEats", "VendoredUberEats", "food-delivery-ui-kit-cart-checkout/food-delivery-ui-kit-cart-checkout/food-delivery-ui-kit-v1", "food-delivery-ui-kit-cart-checkout.zip"),
    ("Airbnb", "Airbnb", "VendoredAirbnb", "youtube_airbnb_clone_v1/youtube_airbnb_clone_v1/youtube_airbnb_clone", "youtube_airbnb_clone_v1.zip"),
    ("TikTok", "TikTok", "VendoredTikTok", "Youtube_Tiktok_v1/Youtube_Tiktok_v1/Youtube_Tiktok", "Youtube_Tiktok_v1.zip"),
]

COLOR_STATIC_NAMES = [
    "primaryColor",
    "primaryBackgroundColor",
    "sideMenuBackgroundColor",
    "blueColor",
    "greenColor",
    "grayColor",
    "starredColor",
    "backgroundDarkColor",
    "buttonGrayColor",
    "grayButtonColor",
]

VENDORED_ROOT = Path(__file__).resolve().parents[1] / "LostPhone" / "Apps" / "Vendored"


def camel_to_suffix(prefix: str) -> str:
    """VendoredWhatsApp -> WhatsApp"""
    return prefix.removeprefix("Vendored")


def fix_colors(app_dir: Path, type_prefix: str) -> None:
    suffix = camel_to_suffix(type_prefix)
    mapping = {
        name: f"vendored{suffix}{name[0].upper()}{name[1:]}"
        if name != "primaryColor"
        else f"vendored{suffix}Primary"
        for name in COLOR_STATIC_NAMES
    }
    # Normalize primaryColor mapping
    mapping["primaryColor"] = f"vendored{suffix}Primary"
    mapping["primaryBackgroundColor"] = f"vendored{suffix}PrimaryBackground"
    mapping["sideMenuBackgroundColor"] = f"vendored{suffix}SideMenuBackground"
    mapping["blueColor"] = f"vendored{suffix}Blue"
    mapping["greenColor"] = f"vendored{suffix}Green"
    mapping["grayColor"] = f"vendored{suffix}Gray"
    mapping["starredColor"] = f"vendored{suffix}Starred"
    mapping["backgroundDarkColor"] = f"vendored{suffix}BackgroundDark"
    mapping["buttonGrayColor"] = f"vendored{suffix}ButtonGray"
    mapping["grayButtonColor"] = f"vendored{suffix}GrayButton"

    for swift in app_dir.rglob("*.swift"):
        text = swift.read_text(encoding="utf-8", errors="replace")
        if "extension Color" not in text and "Color.primaryColor" not in text:
            continue
        # Strip duplicate hex initializer from theme files.
        if "init(hex:" in text and "extension Color" in text:
            text = re.sub(
                r"extension Color \{[^}]*init\(hex:[^}]+\}\s*",
                "",
                text,
                count=1,
                flags=re.DOTALL,
            )
            text = re.sub(
                r"import SwiftUI\s*",
                "import SwiftUI\n\n",
                text,
                count=1,
            )
        for old, new in sorted(mapping.items(), key=lambda x: len(x[0]), reverse=True):
            text = re.sub(rf"\b{re.escape(old)}\b", new, text)
            text = text.replace(f"Color.{old}", f"Color.{new}")
        # Rewrite static lets in Colors theme file
        text = re.sub(
            r"static let primaryColor\s*=\s*Color\(hex:",
            f"static let vendored{suffix}Primary = Color(hex:",
            text,
        )
        swift.write_text(text, encoding="utf-8")


def vendor_one(app_dir: str, app_label: str, prefix: str, subpath: str, zip_name: str) -> None:
    source = SCAN_ROOT / subpath
    if not source.is_dir():
        raise SystemExit(f"Missing source: {source}")
    cmd = [
        sys.executable,
        str(SCRIPT),
        str(source),
        "--app-dir",
        app_dir,
        "--app-label",
        app_label,
        "--prefix",
        prefix,
        "--entry",
        "ContentView",
        "--repo",
        f"sopheamenvan/Patreon:{zip_name}",
        "--licence",
        "Patreon (usage projet)",
        "--notes",
        "\n- Source : bundle Patreon Sopheamen Van.\n",
    ]
    print(f"\n=== {app_label} ===")
    subprocess.run(cmd, check=True)
    fix_colors(VENDORED_ROOT / app_dir, prefix)


def main() -> None:
    for row in APPS:
        vendor_one(*row)
    print("\nAll Sopheamen SwiftUI apps vendored.")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Fetch Spectr gallery home-screen layout signatures for Awesome apps."""

from __future__ import annotations

import html as html_lib
import json
import re
import sys
import urllib.request
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "scripts"))
from generate_awesome_apps import APP_PATHS  # noqa: E402


def extract_layout(slug: str) -> list[str]:
    url = f"https://www.spectr.to/gallery/{slug}"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 LostPhone/1.0"})
    with urllib.request.urlopen(req, timeout=25) as resp:
        text = resp.read().decode("utf-8", "replace")
    m = re.search(r'srcDoc="([^"]{100,})"', text)
    if not m:
        raise RuntimeError("no srcDoc")
    doc = html_lib.unescape(m.group(1))
    m2 = re.search(r'class="phone-screen"[^>]*>(.*?)</div>\s*</body>', doc, re.S)
    body = m2.group(1) if m2 else ""
    tops: list[str] = []
    for line in body.split("\n"):
        line = line.strip()
        if line.startswith('<div class='):
            cls = re.search(r'class="([^"]+)"', line).group(1).split()[0]
            tops.append(cls)
    return [c for c in tops if c != "island"][:12]


def main() -> int:
    manifest: dict[str, object] = {}
    for app_name, rel in APP_PATHS.items():
        slug = rel.split("/")[-1]
        try:
            layout = extract_layout(slug)
            manifest[app_name] = {"slug": slug, "layout": layout, "url": f"https://www.spectr.to/gallery/{slug}"}
            print(f"OK {app_name}")
        except Exception as exc:
            manifest[app_name] = {"slug": slug, "error": str(exc)}
            print(f"FAIL {app_name}: {exc}")

    out = REPO / "scripts" / "spectr_home_layouts.json"
    out.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"\nWrote {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

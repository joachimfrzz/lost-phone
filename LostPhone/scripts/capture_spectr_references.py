#!/usr/bin/env python3
"""A — Capture Spectr gallery home-screen PNGs (61 apps).

Fetches live iframe srcDoc from https://www.spectr.to/gallery/{slug},
renders .phone-screen at 390×844 via Playwright, writes spectr_pixel_refs/{slug}.png

Usage:
  pip install playwright pillow
  playwright install chromium
  python3 LostPhone/scripts/capture_spectr_references.py
  python3 LostPhone/scripts/capture_spectr_references.py --offline   # local html+css only
  python3 LostPhone/scripts/capture_spectr_references.py --slug instagram
"""

from __future__ import annotations

import argparse
import html as html_lib
import json
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

from spectr_pixel_common import CAPTURE_H, CAPTURE_W, REF_DIR, ensure_dirs, iter_apps

SCRIPTS = Path(__file__).resolve().parent
PREVIEWS = SCRIPTS / "spectr_previews"


def fetch_srcdoc(slug: str) -> str:
    url = f"https://www.spectr.to/gallery/{slug}"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 LostPhone/spectr-pixel"})
    with urllib.request.urlopen(req, timeout=30) as resp:
        page = resp.read().decode("utf-8", "replace")
    m = re.search(r'srcDoc="([^"]{500,})"', page)
    if not m:
        raise RuntimeError(f"no srcDoc in gallery page for {slug}")
    return html_lib.unescape(m.group(1))


def extract_style_and_screen(srcdoc: str) -> tuple[str, str]:
    sm = re.search(r"<style>(.*?)</style>", srcdoc, re.S)
    if not sm:
        raise RuntimeError("no <style> in srcDoc")
    style = sm.group(1)

    start = srcdoc.find('<div class="phone-screen"')
    if start < 0:
        raise RuntimeError("no .phone-screen in srcDoc")
    # balance div tags
    depth = 0
    i = start
    while i < len(srcdoc):
        if srcdoc.startswith("<div", i):
            depth += 1
            i += 4
            continue
        if srcdoc.startswith("</div>", i):
            depth -= 1
            i += 6
            if depth == 0:
                screen_html = srcdoc[start:i + 6]
                return style, screen_html
            continue
        i += 1
    raise RuntimeError("unbalanced phone-screen div")


def build_offline_style(slug: str) -> tuple[str, str]:
    json_path = PREVIEWS / f"{slug}.json"
    css_path = PREVIEWS / f"{slug}_css.json"
    html_path = PREVIEWS / f"{slug}.html"
    if not (json_path.exists() and css_path.exists() and html_path.exists()):
        raise FileNotFoundError(f"missing local preview files for {slug}")

    meta = json.loads(json_path.read_text(encoding="utf-8"))
    css_map: dict[str, str] = json.loads(css_path.read_text(encoding="utf-8"))
    fragment = html_path.read_text(encoding="utf-8").strip()

    vars_block = "\n".join(f"    {k}: {v};" for k, v in meta.get("vars", {}).items())
    rules = "\n".join(f"  .{cls} {{ {rule} }}" for cls, rule in css_map.items())
    style = f"""
  :root {{
{vars_block}
  }}
  * {{ margin: 0; padding: 0; box-sizing: border-box; }}
  .phone-screen {{
    width: {CAPTURE_W}px; height: {CAPTURE_H}px;
    overflow: hidden; background: var(--bg, #fff);
    display: flex; flex-direction: column; position: relative;
  }}
  .island {{
    position: absolute; top: 10px; left: 50%; transform: translateX(-50%);
    width: 96px; height: 26px; background: #000; border-radius: 14px; z-index: 5;
  }}
  .icon svg {{ width: 22px; height: 22px; stroke: currentColor; stroke-width: 1.8; fill: none; }}
{rules}
"""
    screen_html = f'<div class="phone-screen"><div class="island"></div>{fragment}</div>'
    return style, screen_html


def wrap_page(style: str, screen_html: str) -> str:
    return f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width={CAPTURE_W}, height={CAPTURE_H}, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
<style>
  html, body {{
    margin: 0; width: {CAPTURE_W}px; height: {CAPTURE_H}px;
    overflow: hidden; background: #000;
  }}
  .phone-screen {{
    width: {CAPTURE_W}px !important;
    height: {CAPTURE_H}px !important;
    border-radius: 0 !important;
  }}
{style}
</style>
</head>
<body>
{screen_html}
</body>
</html>
"""


def capture_one(slug: str, offline: bool, out_path: Path) -> str:
    if offline:
        style, screen = build_offline_style(slug)
        source = "offline"
    else:
        try:
            srcdoc = fetch_srcdoc(slug)
            style, screen = extract_style_and_screen(srcdoc)
            source = "live"
        except (urllib.error.URLError, RuntimeError, TimeoutError) as exc:
            style, screen = build_offline_style(slug)
            source = f"offline-fallback ({exc})"

    page_html = wrap_page(style, screen)
    tmp = out_path.with_suffix(".html")
    tmp.write_text(page_html, encoding="utf-8")

    from playwright.sync_api import sync_playwright

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page(viewport={"width": CAPTURE_W, "height": CAPTURE_H}, device_scale_factor=1)
        page.goto(tmp.as_uri(), wait_until="networkidle")
        page.wait_for_timeout(400)
        page.locator(".phone-screen").screenshot(path=str(out_path), type="png")
        browser.close()
    tmp.unlink(missing_ok=True)
    return source


def main() -> int:
    parser = argparse.ArgumentParser(description="Capture Spectr reference PNGs")
    parser.add_argument("--offline", action="store_true", help="Use local spectr_previews only")
    parser.add_argument("--slug", help="Capture single slug")
    args = parser.parse_args()

    ensure_dirs()
    apps = iter_apps()
    if args.slug:
        apps = [(n, s) for n, s in apps if s == args.slug]
        if not apps:
            print(f"Unknown slug: {args.slug}", file=sys.stderr)
            return 1

    ok, fail = 0, 0
    log: list[dict] = []
    for name, slug in apps:
        out = REF_DIR / f"{slug}.png"
        try:
            source = capture_one(slug, offline=args.offline, out_path=out)
            print(f"OK  {slug:24} ({name}) [{source}]")
            log.append({"slug": slug, "name": name, "status": "ok", "source": source, "path": str(out)})
            ok += 1
        except Exception as exc:
            print(f"FAIL {slug:24} ({name}): {exc}", file=sys.stderr)
            log.append({"slug": slug, "name": name, "status": "fail", "error": str(exc)})
            fail += 1

    meta_path = REF_DIR / "capture_log.json"
    meta_path.write_text(json.dumps(log, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"\n→ {ok} OK, {fail} fail → {REF_DIR}")
    return 0 if fail == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())

#!/usr/bin/env python3
"""C — Compare Spectr reference PNGs vs Lost Phone captures; SSIM + pixel diff report.

Usage:
  python3 LostPhone/scripts/compare_spectr_pixels.py
  python3 LostPhone/scripts/compare_spectr_pixels.py --refs path/to/refs --ours path/to/ours

Outputs:
  spectr_pixel_report/report.json
  spectr_pixel_report/report.md
  spectr_pixel_report/diffs/{slug}.png  (heatmaps for failures)
"""

from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

from spectr_pixel_common import CAPTURE_H, CAPTURE_W, REF_DIR, REPORT_DIR, OURS_DIR, ensure_dirs, iter_apps

try:
    from PIL import Image, ImageChops, ImageDraw, ImageFont
except ImportError:
    print("Install Pillow: pip install pillow", file=sys.stderr)
    raise


def load_resized(path: Path) -> Image.Image:
    img = Image.open(path).convert("RGB")
    if img.size != (CAPTURE_W, CAPTURE_H):
        img = img.resize((CAPTURE_W, CAPTURE_H), Image.Resampling.LANCZOS)
    return img


def ssim_simple(a: Image.Image, b: Image.Image) -> float:
    """Structural similarity approximation via PIL (no scikit-image required)."""
    try:
        import numpy as np

        x = np.asarray(a, dtype=np.float64)
        y = np.asarray(b, dtype=np.float64)
        c1 = (0.01 * 255) ** 2
        c2 = (0.03 * 255) ** 2
        mu_x = x.mean()
        mu_y = y.mean()
        sigma_x = x.var()
        sigma_y = y.var()
        sigma_xy = ((x - mu_x) * (y - mu_y)).mean()
        num = (2 * mu_x * mu_y + c1) * (2 * sigma_xy + c2)
        den = (mu_x**2 + mu_y**2 + c1) * (sigma_x + sigma_y + c2)
        return float(num / den) if den else 0.0
    except ImportError:
        # Fallback: inverse normalized MSE
        diff = ImageChops.difference(a, b)
        mse = sum(diff.convert("L").point(lambda p: p * p).getdata()) / (CAPTURE_W * CAPTURE_H * 255**2)
        return max(0.0, 1.0 - mse * 10)


def pixel_diff_pct(a: Image.Image, b: Image.Image, threshold: int = 18) -> float:
    diff = ImageChops.difference(a, b).convert("L")
    pixels = diff.load()
    changed = 0
    total = CAPTURE_W * CAPTURE_H
    for y in range(CAPTURE_H):
        for x in range(CAPTURE_W):
            if pixels[x, y] > threshold:
                changed += 1
    return 100.0 * changed / total


def heatmap(a: Image.Image, b: Image.Image) -> Image.Image:
    diff = ImageChops.difference(a, b).convert("L")
    base = a.copy()
    overlay = Image.new("RGBA", a.size, (255, 0, 0, 0))
    opx = overlay.load()
    dpx = diff.load()
    for y in range(CAPTURE_H):
        for x in range(CAPTURE_W):
            d = dpx[x, y]
            if d > 18:
                opx[x, y] = (255, 60, 60, min(180, d + 40))
    return Image.alpha_composite(base.convert("RGBA"), overlay).convert("RGB")


def grade(ssim: float, diff_pct: float) -> str:
    if ssim >= 0.92 and diff_pct <= 8:
        return "green"
    if ssim >= 0.82 and diff_pct <= 18:
        return "orange"
    return "red"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--refs", type=Path, default=REF_DIR)
    parser.add_argument("--ours", type=Path, default=OURS_DIR)
    args = parser.parse_args()

    ensure_dirs()
    diffs_dir = REPORT_DIR / "diffs"
    diffs_dir.mkdir(parents=True, exist_ok=True)

    results: list[dict] = []
    counts = {"green": 0, "orange": 0, "red": 0, "missing": 0}

    for name, slug in iter_apps():
        ref_path = args.refs / f"{slug}.png"
        our_path = args.ours / f"{slug}.png"
        entry: dict = {"name": name, "slug": slug, "ref": str(ref_path), "ours": str(our_path)}

        if not ref_path.exists() or not our_path.exists():
            entry["status"] = "missing"
            entry["grade"] = "missing"
            entry["missing"] = []
            if not ref_path.exists():
                entry["missing"].append("ref")
            if not our_path.exists():
                entry["missing"].append("ours")
            counts["missing"] += 1
            results.append(entry)
            continue

        ref = load_resized(ref_path)
        ours = load_resized(our_path)
        ssim = ssim_simple(ref, ours)
        diff_pct = pixel_diff_pct(ref, ours)
        g = grade(ssim, diff_pct)
        counts[g] += 1

        entry.update({
            "status": "ok",
            "ssim": round(ssim, 4),
            "diff_pct": round(diff_pct, 2),
            "grade": g,
        })
        if g != "green":
            heat = heatmap(ref, ours)
            diff_out = diffs_dir / f"{slug}.png"
            heat.save(diff_out)
            entry["diff_image"] = str(diff_out)
        results.append(entry)

    report = {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "viewport": {"width": CAPTURE_W, "height": CAPTURE_H},
        "summary": counts,
        "apps": results,
    }
    json_path = REPORT_DIR / "report.json"
    json_path.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    lines = [
        "# Spectr pixel diff — Awesome home screens (onglet 0)",
        "",
        f"Generated: {report['generated_at']}",
        f"Viewport: {CAPTURE_W}×{CAPTURE_H}",
        "",
        "## Summary",
        "",
        f"| Grade | Count |",
        f"|-------|-------|",
        f"| 🟢 green | {counts['green']} |",
        f"| 🟠 orange | {counts['orange']} |",
        f"| 🔴 red | {counts['red']} |",
        f"| ⚪ missing | {counts['missing']} |",
        "",
        "## Apps (worst first)",
        "",
        "| Grade | SSIM | Diff% | App | Slug |",
        "|-------|------|-------|-----|------|",
    ]
    for r in sorted(results, key=lambda x: (x.get("ssim", -1), -x.get("diff_pct", 999))):
        if r.get("status") == "missing":
            lines.append(f"| missing | — | — | {r['name']} | `{r['slug']}` |")
        else:
            icon = {"green": "🟢", "orange": "🟠", "red": "🔴"}.get(r["grade"], "?")
            lines.append(
                f"| {icon} | {r['ssim']:.3f} | {r['diff_pct']:.1f}% | {r['name']} | `{r['slug']}` |"
            )

    md_path = REPORT_DIR / "report.md"
    md_path.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"Report → {md_path}")
    print(f"Summary: green={counts['green']} orange={counts['orange']} red={counts['red']} missing={counts['missing']}")
    return 0 if counts["red"] == 0 and counts["missing"] == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())

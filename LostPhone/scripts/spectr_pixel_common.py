"""Shared helpers for Spectr pixel-perfect pipeline (A/B/C)."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

SCRIPTS = Path(__file__).resolve().parent
REPO = SCRIPTS.parents[1]
PREVIEWS = SCRIPTS / "spectr_previews"
REF_DIR = SCRIPTS / "spectr_pixel_refs"
OURS_DIR = SCRIPTS / "lpsp_pixel_captures"
REPORT_DIR = SCRIPTS / "spectr_pixel_report"

# iPhone 15 logical — canonical compare size
CAPTURE_W = 390
CAPTURE_H = 844

sys.path.insert(0, str(SCRIPTS))
from generate_awesome_apps import APP_PATHS  # noqa: E402


def slug_for_app(app_name: str) -> str:
    rel = APP_PATHS.get(app_name)
    if rel:
        return rel.split("/")[-1]
    return re.sub(r"[^a-z0-9]+", "-", app_name.lower()).strip("-")


def load_manifest() -> dict[str, dict]:
    path = PREVIEWS / "manifest.json"
    return json.loads(path.read_text(encoding="utf-8"))


def iter_apps() -> list[tuple[str, str]]:
    """Return (display_name, slug) for all 61 Awesome Spectr apps."""
    manifest = load_manifest()
    out: list[tuple[str, str]] = []
    for name, meta in manifest.items():
        slug = meta.get("slug") or slug_for_app(name)
        out.append((name, slug))
    out.sort(key=lambda x: x[1])
    return out


def ensure_dirs() -> None:
    REF_DIR.mkdir(parents=True, exist_ok=True)
    OURS_DIR.mkdir(parents=True, exist_ok=True)
    REPORT_DIR.mkdir(parents=True, exist_ok=True)

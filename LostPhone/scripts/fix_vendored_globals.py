#!/usr/bin/env python3
"""Prefix duplicate top-level data globals per vendored app (chatData, userData, etc.)."""

from __future__ import annotations

import re
from collections import defaultdict
from pathlib import Path

VENDORED = Path(__file__).resolve().parents[1] / "LostPhone" / "Apps" / "Vendored"
DECL_RE = re.compile(r"^(let|var)\s+(\w+)\s*([:=])", re.M)


def app_name(path: Path) -> str:
    rel = path.relative_to(VENDORED)
    return rel.parts[0]


def app_prefix(name: str) -> str:
    return f"vendored{name}"


def prefixed_symbol(app: str, symbol: str) -> str:
    return f"{app_prefix(app)}{symbol[0].upper()}{symbol[1:]}"


def collect_duplicates() -> dict[str, set[str]]:
    by_symbol: dict[str, set[str]] = defaultdict(set)
    for path in VENDORED.rglob("*.swift"):
        text = path.read_text(encoding="utf-8", errors="replace")
        app = app_name(path)
        for _, symbol, _ in DECL_RE.findall(text):
            if symbol.startswith("vendored"):
                continue
            by_symbol[symbol].add(app)
    return {symbol: apps for symbol, apps in by_symbol.items() if len(apps) > 1}


def rewrite_app(app: str, symbols: dict[str, str]) -> int:
    changed_files = 0
    app_dir = VENDORED / app
    for path in app_dir.rglob("*.swift"):
        text = path.read_text(encoding="utf-8", errors="replace")
        original = text
        for old, new in sorted(symbols.items(), key=lambda item: len(item[0]), reverse=True):
            text = re.sub(rf"\b{re.escape(old)}\b", new, text)
        if text != original:
            path.write_text(text, encoding="utf-8")
            changed_files += 1
    return changed_files


def main() -> None:
    duplicates = collect_duplicates()
    if not duplicates:
        print("No duplicate globals found")
        return

    print("Duplicate globals:")
    for symbol, apps in sorted(duplicates.items()):
        print(f"  {symbol}: {', '.join(sorted(apps))}")

    total = 0
    apps = sorted({app for apps in duplicates.values() for app in apps})
    for app in apps:
        mapping = {
            symbol: prefixed_symbol(app, symbol)
            for symbol, symbol_apps in duplicates.items()
            if app in symbol_apps
        }
        count = rewrite_app(app, mapping)
        if count:
            print(f"Updated {count} files in {app}")
            total += count

    print(f"Done — {total} files updated")


if __name__ == "__main__":
    main()

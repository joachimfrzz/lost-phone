#!/usr/bin/env bash
# Run full Spectr pixel pipeline: A (Spectr refs) + B (app captures) + C (diff report).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SCRIPTS="$ROOT/LostPhone/scripts"
ARTIFACTS="${1:-$ROOT/LostPhone/scripts/spectr_pixel_report}"

echo "=== A — Spectr reference PNGs ==="
python3 -m pip install --quiet playwright pillow numpy 2>/dev/null || pip3 install --quiet playwright pillow numpy
python3 -m playwright install chromium 2>/dev/null || true
python3 "$SCRIPTS/capture_spectr_references.py"

if [[ "$(uname -s)" == "Darwin" ]] && xcrun simctl list devices available 2>/dev/null | grep -q iPhone; then
  echo "=== B — Lost Phone simulator captures ==="
  if [[ ! -d "$ROOT/LostPhone/.derivedData-preview" ]]; then
    echo "Building app first (ios-preview-capture)…"
    chmod +x "$SCRIPTS/ios-preview-capture.sh"
    "$SCRIPTS/ios-preview-capture.sh" "$ROOT/preview-artifacts"
  fi
  chmod +x "$SCRIPTS/ios-awesome-pixel-capture.sh"
  "$SCRIPTS/ios-awesome-pixel-capture.sh" "$SCRIPTS/lpsp_pixel_captures"
else
  echo "SKIP B — no macOS simulator (run on CI or Mac)"
fi

echo "=== C — Pixel diff report ==="
python3 "$SCRIPTS/compare_spectr_pixels.py" || true

if [[ -d "$ARTIFACTS" ]]; then
  cp -R "$SCRIPTS/spectr_pixel_report/"* "$ARTIFACTS/" 2>/dev/null || true
fi

echo "=== Done ==="
cat "$SCRIPTS/spectr_pixel_report/report.md" 2>/dev/null | head -25 || true

#!/usr/bin/env bash
# B — Boot simulator, launch Lost Phone in Awesome screenshot mode, pull PNGs.
# Requires: built LostPhone.app, booted simulator (or creates one).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LOSTPHONE="$ROOT/LostPhone"
OUT="${1:-$ROOT/LostPhone/scripts/lpsp_pixel_captures}"
APP="${2:-}"
BUNDLE_ID="com.lostphone.game"

mkdir -p "$OUT"
rm -f "$OUT"/*.png

pick_udid() {
  xcrun simctl list devices available | grep -E "iPhone (15|16)" | grep -v unavailable | head -1 | grep -Eo '[0-9A-F-]{36}' | head -1 \
    || xcrun simctl list devices available | grep iPhone | grep -v unavailable | head -1 | grep -Eo '[0-9A-F-]{36}' | head -1
}

if [[ -z "${APP:-}" ]]; then
  DERIVED="$LOSTPHONE/.derivedData-preview"
  APP="$(find "$DERIVED" -name 'LostPhone.app' -type d 2>/dev/null | head -1)"
fi

if [[ -z "$APP" || ! -d "$APP" ]]; then
  echo "ERROR: LostPhone.app not found. Pass path as 2nd arg or build first." >&2
  exit 1
fi

UDID="${IOS_SIMULATOR_UDID:-}"
if [[ -z "$UDID" ]]; then
  UDID="$(pick_udid || true)"
fi
if [[ -z "$UDID" ]]; then
  echo "ERROR: no iPhone simulator available" >&2
  exit 1
fi

echo "→ Simulator $UDID"
xcrun simctl boot "$UDID" 2>/dev/null || true
xcrun simctl bootstatus "$UDID" -b

echo "→ Install app"
xcrun simctl uninstall "$UDID" "$BUNDLE_ID" 2>/dev/null || true
xcrun simctl install "$UDID" "$APP"

echo "→ Launch capture mode (LPSP_CAPTURE_AWESOME=1)"
export SIMCTL_CHILD_LPSP_CAPTURE_AWESOME=1
xcrun simctl launch "$UDID" "$BUNDLE_ID" 2>&1 | tee /tmp/lpsp-capture-launch.log || true

echo "→ Wait for 61 captures (max 180s)"
deadline=$((SECONDS + 180))
data_dir=""
while (( SECONDS < deadline )); do
  data_dir="$(xcrun simctl get_app_container "$UDID" "$BUNDLE_ID" data 2>/dev/null || true)"
  if [[ -n "$data_dir" && -d "$data_dir/Documents/spectr_captures" ]]; then
    n="$(find "$data_dir/Documents/spectr_captures" -name '*.png' 2>/dev/null | wc -l | tr -d ' ')"
    if [[ "$n" -ge 55 ]]; then
      echo "→ Found $n PNGs"
      break
    fi
  fi
  sleep 2
done

if [[ -z "$data_dir" || ! -d "$data_dir/Documents/spectr_captures" ]]; then
  echo "ERROR: spectr_captures not found in app container" >&2
  xcrun simctl spawn "$UDID" log show --last 2m 2>/dev/null | tail -30 || true
  exit 1
fi

cp "$data_dir/Documents/spectr_captures/"*.png "$OUT/"
count="$(find "$OUT" -name '*.png' | wc -l | tr -d ' ')"
echo "→ Copied $count PNGs to $OUT"
ls -la "$OUT" | head -20

if [[ "$count" -lt 50 ]]; then
  echo "WARN: expected ~61 captures, got $count" >&2
  exit 1
fi

echo "✓ Awesome pixel captures done"

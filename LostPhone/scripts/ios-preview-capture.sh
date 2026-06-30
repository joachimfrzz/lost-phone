#!/usr/bin/env bash
# Build Lost Phone for iOS Simulator (no Apple Developer account) and capture previews.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LOSTPHONE="$ROOT/LostPhone"
ARTIFACTS="${1:-$ROOT/preview-artifacts}"

mkdir -p "$ARTIFACTS"
rm -f "$ARTIFACTS"/*

prepare_xcode_and_simulators() {
  echo "→ Prepare Xcode + iOS Simulator runtimes"
  sudo xcodebuild -runFirstLaunch 2>/dev/null || true

  if ! xcrun simctl list runtimes available 2>/dev/null | grep -q "iOS"; then
    echo "→ Download iOS platform (first run on CI can take several minutes)"
    sudo xcodebuild -downloadPlatform iOS
  fi

  echo "→ Available iOS runtimes:"
  xcrun simctl list runtimes available | grep iOS || true
  echo "→ Available iPhone simulators:"
  xcrun simctl list devices available | grep iPhone | head -15 || true
}

pick_runtime_id() {
  xcrun simctl list runtimes available | grep -E "^iOS " | tail -1 | sed -E 's/.* - (com\.apple\.CoreSimulator\.SimRuntime\.[^ ]+)$/\1/'
}

pick_iphone_device_type() {
  local preferred="${1:-iPhone 15}"
  local type_id
  type_id="$(xcrun simctl list devicetypes | grep "$preferred" | head -1 | sed -E 's/.*\((com\.apple\.CoreSimulator\.SimDeviceType\.[^)]+)\).*/\1/')"
  if [[ -n "$type_id" ]]; then
    echo "$type_id"
    return 0
  fi
  xcrun simctl list devicetypes | grep "iPhone" | head -1 | sed -E 's/.*\((com\.apple\.CoreSimulator\.SimDeviceType\.[^)]+)\).*/\1/'
}

find_simulator_udid() {
  local preferred="${1:-}"
  local line udid

  if [[ -n "$preferred" ]]; then
    line="$(xcrun simctl list devices available | grep "$preferred" | grep -v unavailable | head -1 || true)"
    if [[ -n "$line" ]]; then
      udid="$(echo "$line" | grep -Eo '[0-9A-F-]{36}' | head -1)"
      if [[ -n "$udid" ]]; then
        echo "$udid"
        return 0
      fi
    fi
  fi

  line="$(xcrun simctl list devices available | grep "iPhone" | grep -v unavailable | head -1 || true)"
  if [[ -n "$line" ]]; then
    udid="$(echo "$line" | grep -Eo '[0-9A-F-]{36}' | head -1)"
    if [[ -n "$udid" ]]; then
      echo "$udid"
      return 0
    fi
  fi

  return 1
}

create_simulator_udid() {
  local runtime_id device_type_id udid
  runtime_id="$(pick_runtime_id)"
  device_type_id="$(pick_iphone_device_type "${IOS_SIMULATOR_NAME:-iPhone 15}")"

  if [[ -z "$runtime_id" || -z "$device_type_id" ]]; then
    echo "ERROR: Cannot resolve simulator runtime or device type" >&2
    return 1
  fi

  echo "→ Create simulator (runtime=$runtime_id, device=$device_type_id)"
  udid="$(xcrun simctl create "LostPhone Preview" "$device_type_id" "$runtime_id")"
  echo "$udid"
}

ensure_simulator_udid() {
  local preferred="${IOS_SIMULATOR_NAME:-}"
  local udid

  if udid="$(find_simulator_udid "$preferred")"; then
    echo "$udid"
    return 0
  fi

  if udid="$(find_simulator_udid "")"; then
    echo "$udid"
    return 0
  fi

  create_simulator_udid
}

echo "→ Sync LPSP stories"
mkdir -p "$LOSTPHONE/LostPhone/Resources/stories"
cp -R "$ROOT/public/stories/"* "$LOSTPHONE/LostPhone/Resources/stories/"

echo "→ Preflight (forbidden APIs, paths)"
chmod +x "$LOSTPHONE/scripts/ios-build-preflight.sh"
"$LOSTPHONE/scripts/ios-build-preflight.sh"

echo "→ Generate Xcode project"
cd "$LOSTPHONE"
if ! command -v xcodegen >/dev/null 2>&1; then
  brew install xcodegen
fi
xcodegen generate

prepare_xcode_and_simulators

DERIVED_DATA="$LOSTPHONE/.derivedData-preview"

echo "→ Build for iOS Simulator (generic destination — no named device required)"
xcodebuild \
  -project LostPhone.xcodeproj \
  -scheme LostPhone \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGNING_ALLOWED=NO \
  build

APP="$(find "$DERIVED_DATA" -name 'LostPhone.app' -type d | head -1)"
if [[ -z "$APP" ]]; then
  echo "ERROR: LostPhone.app not found after build"
  exit 1
fi

echo "→ Package .app for Appetize"
(cd "$(dirname "$APP")" && zip -qr "$ARTIFACTS/LostPhone-simulator.app.zip" "$(basename "$APP")")

CAPTURE_OK=0
if UDID="$(ensure_simulator_udid)"; then
  echo "→ Using simulator $UDID"
  xcrun simctl boot "$UDID" 2>/dev/null || true
  if xcrun simctl bootstatus "$UDID" -b 2>/dev/null; then
    echo "→ Install & launch"
    xcrun simctl install "$UDID" "$APP"
    xcrun simctl launch "$UDID" com.lostphone.game || true
    sleep 5

    echo "→ Screenshot"
    xcrun simctl io "$UDID" screenshot "$ARTIFACTS/01-menu-accueil.png" || true

    echo "→ Screen recording (~15s)"
    if xcrun simctl io "$UDID" recordVideo --force "$ARTIFACTS/preview-demo.mov" &
    then
      REC_PID=$!
      sleep 15
      kill -INT "$REC_PID" 2>/dev/null || true
      wait "$REC_PID" 2>/dev/null || true
    fi
    CAPTURE_OK=1
  else
    echo "WARN: Simulator failed to boot — Appetize zip still available"
  fi
else
  echo "WARN: No simulator available — Appetize zip still available"
fi

if [[ "$CAPTURE_OK" -eq 0 ]]; then
  echo "NOTE: Upload LostPhone-simulator.app.zip to Appetize even without PNG/MOV"
fi

echo "Done. Artifacts in $ARTIFACTS"
ls -la "$ARTIFACTS"

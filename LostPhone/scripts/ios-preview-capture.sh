#!/usr/bin/env bash
# Build Lost Phone for iOS Simulator (no Apple Developer account) and capture previews.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LOSTPHONE="$ROOT/LostPhone"
ARTIFACTS="${1:-$ROOT/preview-artifacts}"

mkdir -p "$ARTIFACTS"
rm -f "$ARTIFACTS"/*

echo "→ Sync LPSP stories"
mkdir -p "$LOSTPHONE/LostPhone/Resources/stories"
cp -R "$ROOT/public/stories/"* "$LOSTPHONE/LostPhone/Resources/stories/"

echo "→ Generate Xcode project"
cd "$LOSTPHONE"
if ! command -v xcodegen >/dev/null 2>&1; then
  brew install xcodegen
fi
xcodegen generate

SIM_NAME="${IOS_SIMULATOR_NAME:-iPhone 16}"
DERIVED_DATA="$LOSTPHONE/.derivedData-preview"

echo "→ Build for Simulator ($SIM_NAME)"
set -o pipefail
xcodebuild \
  -project LostPhone.xcodeproj \
  -scheme LostPhone \
  -sdk iphonesimulator \
  -destination "platform=iOS Simulator,name=$SIM_NAME" \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGNING_ALLOWED=NO \
  build \
  | xcpretty

APP="$(find "$DERIVED_DATA" -name 'LostPhone.app' -type d | head -1)"
if [[ -z "$APP" ]]; then
  echo "ERROR: LostPhone.app not found after build"
  exit 1
fi

echo "→ Boot simulator"
UDID="$(xcrun simctl list devices available | grep "$SIM_NAME" | head -1 | grep -Eo '[0-9A-F-]{36}')"
if [[ -z "$UDID" ]]; then
  echo "ERROR: Simulator '$SIM_NAME' not found. Available:"
  xcrun simctl list devices available | grep iPhone | head -10
  exit 1
fi

xcrun simctl boot "$UDID" 2>/dev/null || true
xcrun simctl bootstatus "$UDID" -b

echo "→ Install & launch"
xcrun simctl install "$UDID" "$APP"
xcrun simctl launch "$UDID" com.lostphone.game || true
sleep 4

echo "→ Screenshots"
xcrun simctl io "$UDID" screenshot "$ARTIFACTS/01-menu-accueil.png"
sleep 1

echo "→ Screen recording (~20s)"
xcrun simctl io "$UDID" recordVideo --force "$ARTIFACTS/preview-demo.mov" &
REC_PID=$!
sleep 20
kill -INT "$REC_PID" 2>/dev/null || true
wait "$REC_PID" 2>/dev/null || true

echo "→ Package .app for Appetize (optional interactive preview)"
(cd "$(dirname "$APP")" && zip -qr "$ARTIFACTS/LostPhone-simulator.app.zip" "$(basename "$APP")")

echo "Done. Artifacts in $ARTIFACTS"
ls -la "$ARTIFACTS"

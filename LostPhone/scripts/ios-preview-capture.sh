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

echo "→ Build for iOS Simulator (Debug, universal — Appetize-compatible)"
xcodebuild \
  -project LostPhone.xcodeproj \
  -scheme LostPhone \
  -configuration Debug \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGNING_ALLOWED=NO \
  ENABLE_DEBUG_DYLIB=NO \
  ONLY_ACTIVE_ARCH=NO \
  ARCHS="arm64 x86_64" \
  build

APP="$(find "$DERIVED_DATA" -name 'LostPhone.app' -type d | head -1)"
if [[ -z "$APP" ]]; then
  echo "ERROR: LostPhone.app not found after build"
  exit 1
fi

if [[ ! -f "$APP/stories/j3-louvre/lpsp.json" ]]; then
  echo "ERROR: LPSP stories missing from app bundle ($APP/stories)" >&2
  find "$APP" -maxdepth 3 -type f | head -30 >&2 || true
  exit 1
fi
echo "✓ LPSP stories present in app bundle"

echo "→ Strip Xcode debug dylibs (break Appetize if left in bundle)"
rm -f "$APP"/*.debug.dylib "$APP"/__preview.dylib

echo "→ Ad-hoc codesign (required by some Appetize simulators)"
codesign --force --sign - --timestamp=none --deep "$APP"
codesign --verify --verbose=2 "$APP"

if ! file "$APP/LostPhone" | grep -q "universal binary"; then
  echo "WARN: LostPhone binary is not universal (Appetize prefers arm64+x86_64)" >&2
  file "$APP/LostPhone" >&2
fi

echo "→ Package .app for Appetize"
APPETIZE_ZIP="$ARTIFACTS/LostPhone-simulator.app.zip"
rm -f "$APPETIZE_ZIP"
# ditto keeps the .app bundle structure Appetize expects at zip root.
ditto -c -k --sequesterRsrc --keepParent "$APP" "$APPETIZE_ZIP"

if ! unzip -Z1 "$APPETIZE_ZIP" | grep -qE '^LostPhone\.app/'; then
  echo "ERROR: Appetize zip invalid (LostPhone.app/ missing at root)" >&2
  unzip -Z1 "$APPETIZE_ZIP" | head -20 >&2 || true
  exit 1
fi
if unzip -Z1 "$APPETIZE_ZIP" | grep -qE '\.debug\.dylib|__preview\.dylib'; then
  echo "ERROR: debug dylibs must not ship to Appetize" >&2
  exit 1
fi

cat > "$ARTIFACTS/APPETIZE-LISEZMOI.txt" <<'EOF'
APPETIZE — quel fichier uploader ?
==================================

Option A (recommandée) — lien direct sans piège :
  GitHub → Releases → "Appetize — dernier build iOS"
  Télécharge LostPhone-simulator.app.zip
  Upload ce fichier sur https://appetize.io (sans le dézipper)

Option B — via Artifacts Actions :
  1. Télécharge l'artifact "appetize-upload-XXX" depuis Actions
  2. DÉZIPPE ce fichier (double-clic) — tu obtiens LostPhone-simulator.app.zip
  3. Upload LostPhone-simulator.app.zip sur Appetize
  ⚠️ N'upload PAS le fichier "appetize-upload-XXX.zip" tel quel !

PIN dans l'app : 1503 (histoire J-3)

SHOWROOM — TESTER LES APPS AWESOME :
  Menu → « Showroom — clones Apple + tier Awesome » → accès direct sans PIN
  Grille + dock · bouton « ◀ Home » dans chaque app tierce

Sur Appetize : clique DANS l'écran du téléphone simulé si rien ne bouge.
Les logs AuthKit / PPT sont normaux (bruit simulateur Apple).
EOF

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

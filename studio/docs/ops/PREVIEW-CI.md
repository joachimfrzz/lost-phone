# Ops — Preview & CI

Synthèse des pipelines actifs (juillet 2026).

## GitHub Actions — iOS Preview (Simulator)

- **Workflow :** `.github/workflows/ios-preview.yml`
- **Déclencheur :** push sur `main` / `cursor/**` (fichiers `LostPhone/**`, `public/stories/**`)
- **Runner :** `macos-15`, Xcode 26.x
- **Script principal :** `LostPhone/scripts/ios-preview-capture.sh`
- **Preflight :** `LostPhone/scripts/ios-build-preflight.sh`
- **Artifacts :** `LostPhone-simulator.app.zip`, screenshots, `preview-demo.mov`
- **Releases :** `preview-latest`, `appetize-latest`

## Codemagic — TestFlight

- **Config :** `codemagic.yaml` → workflow `lost-phone-swiftui`
- **Étapes :** XcodeGen → LPSP sync → preflight → IPA → TestFlight
- **Legacy archivé :** workflow Capacitor `lost-phone-ios` (voir `archive/config-duplicates/`)

## Commandes locales

```bash
# Sync histoires
npm run lpsp:sync

# Validation LPSP
python3 LostPhone/scripts/validate-lpsp-json.py

# XcodeGen
cd LostPhone && xcodegen generate
```

## Build number

Incrémenter `CURRENT_PROJECT_VERSION` dans `LostPhone/project.yml` à chaque release testée.

## Liens

- [Preview sans Mac](../../docs/PREVIEW-SANS-MAC.md)
- [SwiftUI sans Mac](../../SWIFTUI-SANS-MAC.md)
- [Cursor iPhone](../../CURSOR-IPHONE.md)

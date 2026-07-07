# Intégration clones tiers (Reddit / GitHub / Awesome)

**Règle Showroom page 1** : ne pas modifier les 14 clones zerocode117 (gelés).

## Étape 1 — apps Apple ajoutées (page 2)

| App | Source | Dossier | Entrée |
|-----|--------|---------|--------|
| Contacts | ContactsView (SwiftUI existant) | `PhoneApp.swift` | `ContactsView()` |
| Rappels | amanbind007/Swifty-Reminder-App-iOS | `RappelsSwifty/` | `RappelsSwiftyAppView()` |
| Calculatrice | zerocode117 (identique AnukarOP) | `CalculatorApp.swift` | `CalculatorView()` |
| Dictaphone | mushthak/voice-memos-clone-swiftui | `DictaphoneClone/` | `DictaphoneCloneAppView()` |
| Wallet | Meliwat/awesome-ios-design-md apple-wallet | `WalletClone/` | `WalletCloneAppView()` |

## Étape 2 — apps tierces Awesome (fallback)

Spec : [Meliwat/awesome-ios-design-md](https://github.com/Meliwat/awesome-ios-design-md) — chaque app suit `DESIGN-swiftui.md`.

- Génération : `python3 LostPhone/scripts/generate_awesome_apps_v3.py [design-md-root]` (composants Spectr extraits des specs)
- Vues : `LostPhone/Apps/Awesome/Generated/LpspAwesome*.swift`
- Routage : `AwesomeShowroomRouter.swift` + `AwesomeShowroomCatalog.swift`

## Étape 2b — apps tierces vendored (prioritaire)

Recette zerocode117 — voir `Apps/Vendored/README.md` et `docs/VENDORED_MATRIX.md`.

- Vues : `LostPhone/Apps/Vendored/<App>/`
- Routage : `VendoredShowroomRouter.swift` (prioritaire sur Awesome dans le showroom)

## Règles

1. **Copier les fichiers Swift + assets** du repo GitHub tel quel (Étape 1 vendored).
2. **Renommer uniquement les conflits** (types *et* noms de fichiers dupliqués).
3. **Ne pas toucher au socle showroom** (dock, glass, page 1, apps gelées).
4. **Ne pas réécrire l'UI** des clones vendored — pas de version « inspirée ».
5. **LPSP** : branchement narratif dans un second temps.
6. Exclure `README.md` / `INTEGRATION.md` / `playground/` du bundle (`project.yml`).

## Supprimé (remplacé par Awesome)

- `UberReddit/`, `InstagramReddit/`, `NetflixReddit/`, `BanqueReddit/`, `MyPlaylistsReddit/`, `RappelsReddit/`
- `Custom/LpspWhatsAppView.swift`, `LpspSignalView.swift`, `Tier/Lpsp*App.swift`

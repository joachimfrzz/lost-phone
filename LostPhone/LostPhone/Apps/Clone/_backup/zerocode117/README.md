# Sauvegarde zerocode117 — Mail, App Store, Musique

Copies des vues originales [zerocode117/iOS-26-clone](https://github.com/zerocode117/iOS-26-clone) avant remplacement par les clones **Sopheamen Van** (Patreon).

| Fichier | App LPSP | Remplacé par |
|---------|----------|--------------|
| `EmailApp.swift` | Mail | `Apps/Vendored/Gmail/` |
| `AppStoreApp.swift` | App Store | `Apps/Vendored/AppStore/` |
| `MusicApp.swift` | Musique | `Apps/Vendored/AppleMusic/` |

Les modèles `Email`, `MailManager`, `Track`, `MusicManager` restent actifs dans `LegacyMailMusicModels.swift` pour le pont LPSP.

Ce dossier est exclu du build Xcode (`project.yml`).

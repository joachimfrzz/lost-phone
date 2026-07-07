# TikTok — source vendored

| Champ | Valeur |
|-------|--------|
| **Repo** | https://github.com/johannpires/TikTok-Clone-App |
| **Commit** | `main` @ clone 2026-07-07 (shallow) |
| **Licence** | MIT (Johann Pires, 2023) |
| **Langage** | Swift / SwiftUI / AVKit |
| **Entrée Lost Phone** | `LpspVendoredTikTokRootView()` → `MainTabView()` |

## Fichiers copiés

- `Core/**` (16 fichiers Swift)
- `Models/Post.swift`
- `LpspVendoredTikTokRootView.swift` (wrapper Lost Phone)

## Adaptations Lost Phone

- Aucune modification du code vendored (showroom demo).
- Vidéos : URLs publiques Google sample (déjà dans `FeedViewModel`).
- Pas de Firebase / backend.

## Notes

- Onglets Inbox/Profile : indices `selectedTab` du repo d’origine (cosmétique).
- Remplace `LpspAwesomeTikTokView` dans le showroom lorsque l’app est listée dans `VendoredShowroomCatalog`.

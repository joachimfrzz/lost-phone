# Tinder — port SwiftUI depuis Flutter Sopheamen

| Champ | Valeur |
|-------|--------|
| **Source** | `tinder_clone_ui_kit.zip` (Patreon Sopheamen Van) |
| **Original** | Flutter / Dart — `lib/pages/root_app.dart` + onglets |
| **Entrée** | `LpspVendoredTinderRootView()` → `VendoredTinderRootView` |

## Adaptation Lost Phone

- Réécriture SwiftUI (Explore swipe + détail profil, Likes, Chat + 1:1, Account).
- Le zip Flutter démarre sur un flow login — le showroom ouvre directement les 4 onglets (`root_app.dart`).
- Photos profil copiées depuis `assets/images/girls/` du zip Flutter.
- Icônes SVG remplacées par SF Symbols équivalents.

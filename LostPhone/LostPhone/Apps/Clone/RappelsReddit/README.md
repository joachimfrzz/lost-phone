# RappelsReddit

Clone [azamsharp/RemindersClone](https://github.com/azamsharp/RemindersClone) intégré dans Lost Phone.

## Source

- Repo : https://github.com/azamsharp/RemindersClone
- UI originale : SwiftUI + SwiftData, grille 2×2 pour listes intelligentes

## Adaptations Lost Phone

- **Accueil conservé en liste** `insetGrouped` (plus fidèle à iOS Rappels que la grille du clone)
- Cellules vendored : `RappelsRedditCellView` (depuis `ReminderCellView`), `RappelsRedditListCellView` (depuis `MyListCellView`)
- Détail read-only inspiré de `ReminderEditScreen` — pas de SwiftData ni notifications
- Données LPSP via `LpspAdapters.rappels` (listes J-3 : Perso, Louvre, etc.)
- Navigation listes intelligentes : Aujourd'hui, Programmés, Tous, Terminés

## Fichiers

- `RappelsRedditApp.swift` — accueil + `LpspRappelsView`
- `RappelsRedditCellView.swift` — cellules liste / rappel
- `RappelsRedditDetailViews.swift` — détail liste, smart lists, fiche rappel
- `RappelsRedditLPSP.swift` — filtres + dates
- `RappelsRedditTheme.swift` — couleurs listes LPSP

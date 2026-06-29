# Lost Phone — SwiftUI natif (base zerocode117)

React + Figma ne sont **plus la cible**. Le jeu tourne en **SwiftUI** avec contenu **LPSP JSON** modifiable.

## Démarrage (Mac cloud ou Codemagic)

```bash
cd game/LostPhone
brew install xcodegen   # une fois
xcodegen generate
open LostPhone.xcodeproj
# Run sur iPhone — PIN J-3 : 1503
```

Sans Mac local → voir `codemagic-swiftui.yaml` et [SWIFTUI-LPSP.md](./SWIFTUI-LPSP.md).

## Architecture

```
LostPhone/
├── LostPhoneApp.swift          @main
├── Core/
│   ├── Models/LpspModels.swift   Types JSON
│   ├── ViewModels/PhoneViewModel.swift
│   └── Services/                   Loader, scénario, adapters
├── System/                         Verrou, PIN, Home (zerocode117)
├── Apps/
│   ├── Clone/                      Apps système zerocode117 (UI)
│   ├── LpspMessagesView.swift      Messages ← LPSP
│   └── LpspAppRouter.swift         Route app → vue
└── Resources/stories/              Copie de public/stories/
```

## Contenu modifiable

**Un seul fichier** par histoire : `Resources/stories/j3-louvre/lpsp.json`

| Section JSON | Effet in-game |
|---|---|
| `content.envelope.heure_verrou` / `date_verrou` | Horloge verrou |
| `content.envelope.notifications_initiales` | Notifs sur écran verrou |
| `content.envelope.fond_ecran.source` | Fond d'écran |
| `player_config.verrouillage.code` | Code PIN |
| `content.apps.Messages.threads` | Conversations Messages |
| `content.apps.*` | Données par app |
| `scenario.evenements` | Notifs dynamiques en jeu |
| `manifest.apps_presentes` | Apps sur l'accueil |
| `content.system.dock` | Apps du dock |

Édite le JSON → rebuild → le jeu reflète les changements. **Aucun code Swift à toucher** pour du texte / messages / notifs.

## Apps

| App | UI | Données |
|---|---|---|
| Messages | Clone + LPSP | ✅ JSON |
| Photos, Safari, Mail, Phone, Notes, Calendrier, Réglages | zerocode117 | Demo (à brancher LPSP) |
| WhatsApp, Signal, Instagram, Uber… | Générique JSON | ✅ JSON (vue debug) → à polir |

## Crédits UI

Shell et apps système : [zerocode117/iOS-26-clone](https://github.com/zerocode117/iOS-26-clone) (MIT).

## Ancien stack (deprecated)

- `game/src/` React — conservé pour référence Creator, **plus maintenu pour l'iPhone**
- Figma pipeline — abandonné

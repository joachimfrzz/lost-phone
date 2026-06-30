# Architecture Lost Phone (SwiftUI)

Lost Phone sépare trois mondes distincts. Le contenu narratif vit dans **LPSP JSON** ; le rendu iPhone repose sur le clone [zerocode117/iOS-26-clone](https://github.com/zerocode117/iOS-26-clone) pour les apps Apple.

## Les trois mondes

```
┌─────────────────────────────────────────────────────────────┐
│  1. JEU (Game/)                                             │
│     Menu, choix d'histoire, progression, sauvegardes        │
└──────────────────────────┬──────────────────────────────────┘
                           │ startStory(id)
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  2. TÉLÉPHONE (Phone/)                                      │
│     Verrou, PIN, home, dock, centre notifs, centre contrôle │
└──────────────────────────┬──────────────────────────────────┘
                           │ openApp(name)
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  3. APPS (Apps/)                                            │
│  3a. Clone/   — apps Apple zerocode117 + injection LPSP     │
│  3b. Custom/  — apps tierces SwiftUI (WhatsApp, Signal…)    │
└─────────────────────────────────────────────────────────────┘
```

## Arborescence

```
LostPhone/
├── LostPhoneApp.swift          @main → PhoneRootView
├── Game/
│   ├── GameHomeView.swift      Menu + sélection histoire
│   └── GameProgressStore.swift Dernière histoire (UserDefaults)
├── Phone/
│   ├── PhoneRootView.swift     Routeur de phases
│   ├── LockScreenView.swift
│   ├── PinCodeView.swift
│   ├── HomeShellView.swift
│   └── Components/
│       ├── WallpaperView.swift
│       ├── NotificationCenterOverlay.swift
│       └── ControlCenterOverlay.swift
├── Apps/
│   ├── Clone/                  Copy-paste zerocode117 — NE PAS réécrire
│   ├── Custom/                 Apps tierces (WhatsApp, Signal…)
│   └── LpspAppRouter.swift     Route app LPSP → vue
├── Core/
│   ├── Models/LpspModels.swift
│   ├── ViewModels/PhoneViewModel.swift
│   └── Services/
│       ├── LpspLoader.swift
│       ├── LpspAdapters.swift      JSON → structs LPSP
│       ├── LpspCloneBridge.swift   LPSP → modèles clone
│       ├── LpspReadOnly.swift
│       ├── StoryCatalog.swift
│       └── ScenarioEngine.swift
└── Resources/stories/<id>/lpsp.json
```

## Phases du téléphone

| Phase | Vue | Déclencheur |
|---|---|---|
| `menu` | `GameHomeView` | Lancement / retour menu |
| `loading` | ProgressView | `startStory(id)` |
| `error` | ContentUnavailableView | LPSP invalide |
| `lock` | `LockScreenView` | Histoire chargée + PIN requis |
| `pin` | `PinCodeView` | Swipe verrou |
| `home` | `HomeShellView` | PIN ok ou pas de verrou |
| `app(name)` | `LpspAppContainerView` | Tap icône |

## Injection LPSP dans le clone

**Règle absolue** : ne jamais créer de `LpspXxxView` pour une app déjà présente dans `Apps/Clone/`.

1. `LpspAdapters` parse le JSON → structs LPSP (`LpspConversation`, `LpspNote`, …)
2. `LpspCloneBridge` convertit → modèles clone (`Conversation`, `Note`, `CalendarEvent`, …)
3. `LpspAppRouter` instancie la **vraie** vue clone avec les données injectées
4. `LpspAppContainerView` enveloppe l'app (fermeture via bouton volume, comme le clone)

Apps clone branchées LPSP : Messages, Notes, Photos, Mail, Telephone, Safari, Calendrier, Contacts (onglet Téléphone + app standalone).

Apps Custom (absentes du clone) : WhatsApp, Signal, Instagram, Uber… → `Apps/Custom/`.

## Contenu modifiable

Un fichier par histoire : `Resources/stories/<id>/lpsp.json` (sync depuis `public/stories/` via `npm run lpsp:sync`).

| Section JSON | Effet |
|---|---|
| `manifest.apps_presentes` | Icônes sur l'accueil |
| `content.system.dock` | Apps du dock |
| `content.envelope.*` | Verrou, fond d'écran, notifs initiales |
| `player_config.verrouillage.code` | PIN |
| `content.apps.*` | Données par app |
| `scenario.evenements` | Notifs dynamiques |

## Shell hors clone

Le clone zerocode117 ne fournit **que** l'écran d'accueil (home + dock) et les apps. Lost Phone développe en interne :

- Écran de verrou + swipe
- Saisie PIN
- Centre de notifications (overlay)
- Centre de contrôle (overlay)
- Couche jeu (menu, progression)

Voir `docs/CLONE-AUDIT.md` pour le détail de l'audit.

## Stack abandonnée

- `game/src/` React — référence Creator uniquement
- Figma / Capacitor — plus maintenus pour l'iPhone

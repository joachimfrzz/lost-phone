# Lost Phone — SwiftUI (squelette)

Projet SwiftUI natif à ouvrir **dans Xcode sur Mac cloud** (MacinCloud, Codemagic, etc.).

## Création du projet (sur Mac cloud)

1. Ouvrir Xcode → **File → New → Project → iOS → App**
2. Product Name : `LostPhone`
3. Interface : **SwiftUI**
4. Language : **Swift**
5. Bundle ID : `com.lostphone.game`
6. Copier le contenu de `Sources/` dans le target créé
7. Glisser `Resources/lpsp.json` (ou charger depuis le bundle) dans le projet

## Architecture cible

```
LostPhone/
├── LostPhoneApp.swift       ← @main
├── Models/
│   └── LpspModels.swift     ← Codable, miroir de game/src/types/lpsp.ts
├── Services/
│   ├── LpspLoader.swift
│   └── ScenarioEngine.swift
├── System/
│   ├── PhoneRootView.swift  ← lock → pin → home → app
│   ├── LockScreenView.swift
│   ├── PinCodeView.swift
│   └── HomeScreenView.swift
└── Apps/
    └── MessagesView.swift   ← première app à porter
```

## LPSP

Le format JSON est identique au jeu web :

- `game/public/stories/j3-louvre/lpsp.json`
- PIN J-3 : **1503**

## Prochaine étape dev

1. `LpspModels.swift` — structs `Codable` depuis le JSON
2. `LockScreenView` — `TimelineView` + horloge système
3. `PinCodeView` — `SecureField` ou clavier custom SwiftUI
4. Porter `MessagesView` avec `List` + navigation native

## Relation avec le jeu web

| | Web (React) | SwiftUI |
|---|-------------|---------|
| UI | CSS imitation | **UIKit/SwiftUI natif** |
| Données | LPSP JSON | **Même LPSP JSON** |
| Creator | Inchangé | Inchangé |

Le Creator continue de produire des `.json` ; les deux runtimes les consomment.

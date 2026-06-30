# Lost Phone — SwiftUI natif

Jeu d'investigation sur iPhone simulé. **SwiftUI + LPSP JSON** — React/Figma/Capacitor ne sont plus la cible iPhone.

## Démarrage (Mac cloud ou Codemagic)

```bash
cd game/LostPhone
brew install xcodegen   # une fois
xcodegen generate
open LostPhone.xcodeproj
# Run sur iPhone — PIN J-3 : 1503
```

Sans Mac local → voir `codemagic.yaml` et [SWIFTUI-LPSP.md](./SWIFTUI-LPSP.md).

## Architecture

Trois mondes séparés — détail complet dans [ARCHITECTURE.md](./ARCHITECTURE.md).

```
LostPhone/
├── Game/           Menu, choix histoire, progression
├── Phone/          Verrou, PIN, home, overlays système
├── Apps/
│   ├── Clone/      Apps Apple zerocode117 + injection LPSP
│   └── Custom/     WhatsApp, Signal… (SwiftUI maison)
├── Core/           Loader, adapters, bridge, scénario
└── Resources/stories/<id>/lpsp.json
```

Audit du clone : [docs/CLONE-AUDIT.md](./docs/CLONE-AUDIT.md).

## Contenu modifiable

**Un fichier** par histoire : `Resources/stories/j3-louvre/lpsp.json` (sync : `npm run lpsp:sync` depuis la racine du monorepo).

| Section JSON | Effet in-game |
|---|---|
| `content.envelope.heure_verrou` / `date_verrou` | Horloge verrou |
| `content.envelope.notifications_initiales` | Notifs sur écran verrou |
| `content.envelope.fond_ecran.source` | Fond d'écran |
| `player_config.verrouillage.code` | Code PIN |
| `content.apps.Messages.threads` | Conversations Messages |
| `content.apps.Calendrier.evenements` | Calendrier |
| `content.apps.Contacts.fiches` | Contacts |
| `content.apps.*` | Données par app |
| `scenario.evenements` | Notifs dynamiques |
| `manifest.apps_presentes` | Apps sur l'accueil |
| `content.system.dock` | Apps du dock |

Édite le JSON → rebuild → le jeu reflète les changements. Pas de code Swift pour du texte / messages / notifs.

## Apps

| App | UI | Données LPSP |
|---|---|---|
| Messages, Notes, Photos, Mail, Telephone, Safari | Clone zerocode117 | ✅ |
| Calendrier, Contacts | Clone (+ injection) | ✅ |
| Réglages, Météo, Musique, Horloge… | Clone | Demo |
| WhatsApp, Signal | Custom SwiftUI | ✅ |
| Instagram, Uber, banque… | GenericLpspAppView | JSON brut → à polir |

**Règle** : pas de `LpspXxxView` parallèle pour une app déjà dans `Apps/Clone/`.

## Crédits UI

Shell apps système : [zerocode117/iOS-26-clone](https://github.com/zerocode117/iOS-26-clone) (MIT).

## Ancien stack (deprecated)

- `game/src/` React — référence Creator, **plus maintenu pour l'iPhone**
- Figma pipeline — abandonné

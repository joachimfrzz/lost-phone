# Audit zerocode117/iOS-26-clone

Audit du dépôt [zerocode117/iOS-26-clone](https://github.com/zerocode117/iOS-26-clone) (commit HEAD au 30 juin 2026).

## Contenu du clone

| Fichier / zone | Rôle |
|---|---|
| `ContentView.swift` | Home : grille d'apps, dock glass, TabView pages, `fullScreenCover` apps |
| `AppContainerView` | Wrapper app + bouton « ◀ Home » + fermeture volume |
| `AppModel.swift` | Enum `AppType`, icônes assets |
| `SystemDesign.swift` | Helpers design |
| `VolumeObserver.swift` | Détection boutons volume |
| `iOS/*.swift` | 13 apps système |

## Apps présentes dans le clone

Messages, Phone (Téléphone), Notes, Photos, Safari, Mail, Settings (Réglages), Weather (Météo), Calculator (Calculatrice), Music, AppStore, Clock (Horloge), Calendar (Calendrier), Camera.

**Absent du clone** : écran verrou, PIN, centre de notifications, centre de contrôle, Contacts standalone, WhatsApp, Signal, Instagram, Uber, banque…

## Ce que Lost Phone réutilise tel quel

- Toutes les vues dans `Apps/Clone/` (copy-paste MIT)
- Pattern `fullScreenCover` + `VolumeObserver` pour fermer une app
- `glassEffect` / `iosDockGlass` pour le dock
- Assets icônes (`messages`, `phone`, `calendar`, …)

## Ce que Lost Phone développe (hors clone)

| Composant | Fichier Lost Phone | Notes |
|---|---|---|
| Menu jeu | `Game/GameHomeView.swift` | Avant d'entrer dans le téléphone |
| Verrou | `Phone/LockScreenView.swift` | Swipe up, notifs empilées |
| PIN | `Phone/PinCodeView.swift` | Code depuis LPSP |
| Home LPSP | `Phone/HomeShellView.swift` | Apps depuis manifest, pas liste fixe |
| Centre notifs | `Phone/Components/NotificationCenterOverlay.swift` | Overlay `SystemOverlay.notifications` |
| Centre contrôle | `Phone/Components/ControlCenterOverlay.swift` | Overlay `SystemOverlay.controlCenter` |
| Router LPSP | `Apps/LpspAppRouter.swift` | Injection données JSON |
| Apps tierces | `Apps/Custom/` | WhatsApp, Signal… |

## Différences d'intégration vs clone original

| Aspect | Clone | Lost Phone |
|---|---|---|
| Liste apps home | Fixe (`AppType`) | Dynamique (`manifest.apps_presentes`) |
| Données apps | Demo hardcodée | LPSP via `LpspCloneBridge` |
| Bouton « ◀ Home » | Visible dans `AppContainerView` | Retiré (volume only) |
| Fermeture app | Volume | Volume (identique) |
| Wallpaper | Asset fixe | LPSP `fond_ecran` + fallback |
| Page indicators | 2 pages fixes | N pages selon nombre d'apps |

## Apps clone encore en demo (LPSP à brancher)

Réglages, Météo, Calculatrice, Musique, App Store, Horloge, Appareil photo — données demo du clone ; LPSP optionnel plus tard.

## Contacts

Pas d'app Contacts standalone dans le clone. `ContactsView` vit dans `PhoneApp.swift` (onglet Téléphone). Lost Phone injecte les fiches LPSP (`content.apps.Contacts.fiches`) dans cette vue et expose aussi une route `Contacts` depuis l'accueil.

## Calendrier

`CalendarView` du clone utilise des événements mock. Lost Phone injecte `content.apps.Calendrier.evenements` via `LpspCloneBridge.calendarEvents`.

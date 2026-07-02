# Intégration clones tiers (Reddit / GitHub)

Même workflow que le Showroom zerocode117 : **copier le repo dans `Apps/Clone/<Nom>/`**, brancher via le router LPSP.

## Uber (fait)

- Dossier : `Apps/Clone/UberReddit/`
- Source : https://github.com/264Gaurav/UBER-ios
- Entrée : `LpspUberView` → `UberRedditAppView`
- LPSP : onglet **Activité** (`UberActivityTabView`)

## File d'attente J-3

| App | Clone à fournir | Dossier cible | Statut |
|-----|-----------------|---------------|--------|
| Uber | 264Gaurav/UBER-ios | `UberReddit/` | ✅ Intégré |
| Instagram | NDCSwift/InstagramRecreation2 | `InstagramReddit/` | ✅ Intégré |
| Banque | *(en attente)* | `BanqueReddit/` | ⏳ |
| Plans | *(en attente)* | `PlansReddit/` | ⏳ |
| Fichiers | *(en attente)* | `FichiersReddit/` | ⏳ |
| Rappels | *(en attente)* | `RappelsReddit/` | ⏳ |
| Spotify | *(en attente)* | `SpotifyReddit/` | ⏳ |
| Netflix | debuging-life/netflix-clone | `NetflixReddit/` | ✅ Intégré |

## Règles d'intégration

1. **Renommer les types en conflit** — préfixe `<App>Reddit` (ex. `UberRedditHomeView`, pas `HomeView` qui existe déjà dans `MusicApp`).
2. **Ne pas toucher au Showroom** (`showroom-clone14`).
3. **LPSP** — garder les écrans narratifs (historique courses, opérations banque, etc.) dans un onglet ou une vue dédiée branchée sur `LpspAdapters`.
4. **Read-only** — respecter `@Environment(\.lpspReadOnly)` sur les actions (réserver, payer, envoyer).
5. **Assets** — copier dans `Assets.xcassets` ou sous-dossier resources du clone.
6. **README** dans chaque dossier clone : URL source + licence + adaptations Lost Phone.

## Test final

Tout l'histoire **J-3** (PIN 1503) sur Appetize une fois les 8 apps intégrées.

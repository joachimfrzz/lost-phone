# Intégration clones tiers (Reddit / GitHub)

**Règle : copier le repo à l'identique** (comme Showroom zerocode117). Seuls renommages autorisés : conflits de types (`HomeView`, `ContentView`, …). LPSP branché plus tard.

## Clones vendored (strict)

| App | Source | Dossier | Entrée |
|-----|--------|---------|--------|
| Uber | 264Gaurav/UBER-ios | `UberReddit/` | `UberRedditHomeView()` |
| Instagram | NDCSwift/InstagramRecreation2 | `InstagramReddit/` | `InstagramRedditContentView()` |
| Netflix | debuging-life/netflix-clone | `NetflixReddit/` | `NetflixRedditContentView()` |
| Apple Music | aisultanios/MyPlaylists | `MyPlaylistsReddit/` | `TabBar()` |
| Rappels | azamsharp/RemindersClone | `RappelsReddit/` | `MyListsScreen()` |
| Banque | GeraudLuku/YT-BankingApp | `BanqueReddit/` | `BanqueRedditContentView()` |

## Règles

1. **Copier les fichiers Swift + assets** du repo GitHub tel quel.
2. **Renommer uniquement les conflits** avec le reste de Lost Phone.
3. **Ne pas toucher au Showroom** (`showroom-clone14`).
4. **Ne pas réécrire l'UI** — pas de version « inspirée » ou simplifiée.
5. **LPSP** : branchement narratif dans un second temps (onglet dédié ou injection).
6. Exclure `README.md` / `INTEGRATION.md` du bundle (`project.yml`).
7. **SwiftUINavigation** (Netflix) : vendored localement dans `Packages/SwiftUINavigation/` (commit `34e67994b4ea`) — le Package.swift upstream exige Swift 6.2, incompatible CI Xcode 16.4.

## File d'attente

| App | Statut |
|-----|--------|
| Plans | ⏳ |
| Fichiers | ⏳ |
| Spotify | ⏳ |

# MyPlaylistsReddit

Clone [aisultanios/MyPlaylists](https://github.com/aisultanios/MyPlaylists) intégré dans Lost Phone.

## Source

- Repo : https://github.com/aisultanios/MyPlaylists
- UI originale : UIKit + MusicKit + tab bar + mini player (Library par défaut)

## Adaptations Lost Phone

- Réécriture **SwiftUI pure** (pas de MusicKit, Apple Music API, Core Data, storyboards)
- Tab bar 5 onglets : Listen Now, Browse, Radio, Library, Search
- Accent **rose** (`systemPink`) comme le repo source
- Mini player collapsé + plein écran (style MyPlaylists, read-only)
- Données LPSP via `LpspAdapters.appleMusic`
- **Distinct** du clone Showroom `Musique` (`MusicView` dans `MusicApp.swift`)

## Fichiers

- `MyPlaylistsRedditApp.swift` — point d'entrée + `LpspAppleMusicView`
- `MyPlaylistsRedditTabBar.swift` — tab bar interactive
- `MyPlaylistsRedditMiniPlayer.swift` — mini / full player
- `MyPlaylistsRedditViews.swift` — Library, Listen Now, détail playlist
- `MyPlaylistsRedditPlayer.swift` — état lecture (stub, sans API)
- `MyPlaylistsRedditTheme.swift` — couleurs

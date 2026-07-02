import SwiftUI

// Point d'entrée Lost Phone — clone aisultanios/MyPlaylists + LPSP.
// Source vendored : https://github.com/aisultanios/MyPlaylists
// UI SwiftUI sans MusicKit / Core Data / storyboards (read-only Lost Phone).

struct MyPlaylistsRedditAppView: View {
    let data: LpspAppleMusicData?
    @StateObject private var player = MyPlaylistsRedditPlayer()
    @State private var selectedTab = "library"
    @State private var selectedPlaylist: LpspAppleMusicPlaylist?
    @Namespace private var animation

    var body: some View {
        Group {
            if let data {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        tabContent(data)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        if player.currentTrack != nil, !player.showFullPlayer {
                            MyPlaylistsRedditMiniPlayer(
                                player: player,
                                queue: MyPlaylistsRedditLPSP.allTracks(from: data),
                                namespace: animation
                            )
                        }

                        MyPlaylistsRedditTabBar(selected: $selectedTab)
                    }

                    if player.showFullPlayer {
                        MyPlaylistsRedditMiniPlayer(
                            player: player,
                            queue: MyPlaylistsRedditLPSP.allTracks(from: data),
                            namespace: animation
                        )
                    }
                }
                .onAppear {
                    if player.currentTrack == nil, let first = data.recentTracks.first ?? data.playlists.first?.tracks.first {
                        player.currentTrack = first
                        player.isPlaying = false
                    }
                }
            } else {
                ContentUnavailableView("Apple Music", systemImage: "music.note.list")
            }
        }
        .preferredColorScheme(.light)
    }

    @ViewBuilder
    private func tabContent(_ data: LpspAppleMusicData) -> some View {
        switch selectedTab {
        case "listen":
            MyPlaylistsRedditListenNowView(data: data, player: player)
        case "library":
            MyPlaylistsRedditLibraryView(
                data: data,
                player: player,
                selectedPlaylist: $selectedPlaylist
            )
        case "browse":
            MyPlaylistsRedditPlaceholderView(title: "Browse", symbol: "square.grid.2x2.fill")
        case "radio":
            MyPlaylistsRedditPlaceholderView(title: "Radio", symbol: "dot.radiowaves.left.and.right")
        case "search":
            MyPlaylistsRedditPlaceholderView(title: "Search", symbol: "magnifyingglass")
        default:
            MyPlaylistsRedditLibraryView(
                data: data,
                player: player,
                selectedPlaylist: $selectedPlaylist
            )
        }
    }
}

/// Route LPSP — distinct du clone Showroom `Musique` / `MusicView`.
struct LpspAppleMusicView: View {
    let data: LpspAppleMusicData?

    var body: some View {
        MyPlaylistsRedditAppView(data: data)
    }
}

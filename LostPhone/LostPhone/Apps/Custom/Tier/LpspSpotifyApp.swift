import SwiftUI

// Clone Spotify iOS — accueil sombre + mini player + playlists.

struct LpspSpotifyView: View {
    let data: LpspSpotifyData?
    @State private var selected: LpspSpotifyPlaylist?
    @State private var tab = "home"

    private let tabs: [TierIOSTabBar.Item] = [
        .init(id: "home", icon: "house.fill", label: "Accueil"),
        .init(id: "search", icon: "magnifyingglass", label: "Rechercher"),
        .init(id: "library", icon: "books.vertical.fill", label: "Bibliothèque"),
        .init(id: "premium", icon: "star.circle.fill", label: "Premium"),
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            TierCloneShell {
                TierIOSTabBar(items: tabs, selected: tab, accent: LpspThirdPartyBrand.spotifyGreen, dark: true)
            } content: {
                NavigationStack {
                    Group {
                        if let data {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 28) {
                                    header(data)
                                    if !data.recentTracks.isEmpty {
                                        recentSection(data.recentTracks)
                                    }
                                    playlistsSection(data.playlists)
                                }
                                .padding(.bottom, 100)
                            }
                        } else {
                            ContentUnavailableView("Spotify", systemImage: "music.note")
                        }
                    }
                    .background(LpspThirdPartyBrand.spotifyBlack)
                    .navigationTitle("Accueil")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(LpspThirdPartyBrand.spotifyBlack, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack(spacing: 16) {
                                Button {} label: { Image(systemName: "bell") }
                                Button {} label: { Image(systemName: "clock") }
                                Button {} label: { Image(systemName: "gearshape") }
                            }
                            .foregroundStyle(.white)
                            .disabled(true)
                        }
                    }
                    .navigationDestination(item: $selected) { pl in
                        SpotifyPlaylistDetail(playlist: pl)
                    }
                }
            }

            if data != nil {
                SpotifyMiniPlayer()
            }
        }
        .preferredColorScheme(.dark)
    }

    @ViewBuilder
    private func header(_ data: LpspSpotifyData) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Bonjour")
                .font(.title.weight(.bold))
                .foregroundStyle(.white)
            Text(data.username)
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)
            Text(data.plan)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.55))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.white.opacity(0.12))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private func recentSection(_ tracks: [LpspSpotifyTrack]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Écoutes récentes")
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(tracks.prefix(10)) { track in
                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(LinearGradient(colors: [LpspThirdPartyBrand.spotifyGreen.opacity(0.5), LpspThirdPartyBrand.spotifyCard], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 148, height: 148)
                                .overlay { Image(systemName: "music.note").font(.largeTitle).foregroundStyle(.white.opacity(0.7)) }
                            Text(track.title)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .frame(width: 148, alignment: .leading)
                            Text(track.artist)
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.55))
                                .lineLimit(1)
                                .frame(width: 148, alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func playlistsSection(_ playlists: [LpspSpotifyPlaylist]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Vos playlists")
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ForEach(playlists) { pl in
                Button { selected = pl } label: {
                    HStack(spacing: 14) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LpspThirdPartyBrand.spotifyGreen.opacity(0.35))
                            .frame(width: 56, height: 56)
                            .overlay { Image(systemName: "music.note.list").foregroundStyle(.white) }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(pl.title)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                            Text("\(pl.trackCount) titres")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.55))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct SpotifyMiniPlayer: View {
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(LpspThirdPartyBrand.spotifyGreen.opacity(0.4))
                .frame(width: 42, height: 42)
                .overlay { Image(systemName: "music.note").foregroundStyle(.white) }
            VStack(alignment: .leading, spacing: 2) {
                Text("Lecture en cours")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                Text("Spotify Free")
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.55))
            }
            Spacer()
            Image(systemName: "airplayaudio")
                .foregroundStyle(.white.opacity(0.7))
            Image(systemName: "play.fill")
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(LpspThirdPartyBrand.spotifyCard)
        .padding(.bottom, 56)
    }
}

private struct SpotifyPlaylistDetail: View {
    let playlist: LpspSpotifyPlaylist

    var body: some View {
        List {
            Section {
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(LpspThirdPartyBrand.spotifyGreen.opacity(0.5))
                        .frame(width: 120, height: 120)
                        .overlay { Image(systemName: "music.note.list").font(.largeTitle).foregroundStyle(.white) }
                    VStack(alignment: .leading, spacing: 6) {
                        Text(playlist.title)
                            .font(.title2.weight(.bold))
                        Text("\(playlist.trackCount) titres")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .listRowBackground(Color.clear)
            }
            Section {
                ForEach(Array(playlist.tracks.enumerated()), id: \.element.id) { index, track in
                    HStack(spacing: 14) {
                        Text("\(index + 1)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(width: 24, alignment: .trailing)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(track.title).font(.subheadline)
                            Text(track.artist).font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspThirdPartyBrand.spotifyBlack)
        .navigationTitle(playlist.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

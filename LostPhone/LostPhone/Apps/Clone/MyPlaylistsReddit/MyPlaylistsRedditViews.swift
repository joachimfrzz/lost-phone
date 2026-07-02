import SwiftUI

struct MyPlaylistsRedditLibraryView: View {
    let data: LpspAppleMusicData
    @ObservedObject var player: MyPlaylistsRedditPlayer
    @Binding var selectedPlaylist: LpspAppleMusicPlaylist?
    @Environment(\.lpspReadOnly) private var readOnly

    private let libraryRows: [(icon: String, title: String)] = [
        ("arrow.down.circle.fill", "Downloaded"),
        ("person.crop.circle.fill", "Artists"),
        ("music.note", "Songs"),
        ("square.stack.fill", "Albums"),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    libraryCategories

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Playlists")
                            .font(.system(size: 25, weight: .bold))
                            .padding(.horizontal, 20)

                        LazyVGrid(
                            columns: [GridItem(.flexible()), GridItem(.flexible())],
                            spacing: 18
                        ) {
                            ForEach(data.playlists) { playlist in
                                Button {
                                    selectedPlaylist = playlist
                                } label: {
                                    playlistTile(playlist)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 120)
            }
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Image(systemName: "plus")
                    }
                    .disabled(readOnly)
                }
            }
            .navigationDestination(item: $selectedPlaylist) { playlist in
                MyPlaylistsRedditPlaylistDetail(
                    playlist: playlist,
                    player: player,
                    queue: MyPlaylistsRedditLPSP.allTracks(from: data)
                )
            }
        }
    }

    private var libraryCategories: some View {
        VStack(spacing: 0) {
            ForEach(libraryRows, id: \.title) { row in
                HStack(spacing: 14) {
                    Image(systemName: row.icon)
                        .font(.system(size: 24))
                        .foregroundStyle(MyPlaylistsRedditTheme.accent)
                        .frame(width: 34)
                    Text(row.title)
                        .font(.system(size: 24))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color(uiColor: .lightGray))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)

                Divider().padding(.leading, 68)
            }
        }
    }

    private func playlistTile(_ playlist: LpspAppleMusicPlaylist) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(MyPlaylistsRedditTheme.artworkGradient)
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    Image(systemName: "music.note.list")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }

            Text(playlist.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Text("\(playlist.trackCount) titres")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

struct MyPlaylistsRedditListenNowView: View {
    let data: LpspAppleMusicData
    @ObservedObject var player: MyPlaylistsRedditPlayer

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if !data.recentTracks.isEmpty {
                        sectionTitle("Recently Played")
                        trackCarousel(data.recentTracks)
                    }

                    if !data.playlists.isEmpty {
                        sectionTitle("Made For You")
                        playlistCarousel(data.playlists)
                    }

                    sectionTitle("Stations For You")
                    stationRow("Apple Music 1", subtitle: "Live worldwide")
                    stationRow("Apple Music Hits", subtitle: "Today's hits")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 120)
            }
            .navigationTitle("Listen Now")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2.bold())
    }

    private func trackCarousel(_ tracks: [LpspAppleMusicTrack]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(tracks) { track in
                    Button {
                        player.play(track)
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(MyPlaylistsRedditTheme.artworkGradient)
                                .frame(width: 160, height: 160)
                                .overlay {
                                    Image(systemName: "music.note")
                                        .font(.title)
                                        .foregroundStyle(.white.opacity(0.85))
                                }
                            Text(track.title)
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                            Text(track.artist)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                        .frame(width: 160, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func playlistCarousel(_ playlists: [LpspAppleMusicPlaylist]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(playlists.prefix(6)) { playlist in
                    VStack(alignment: .leading, spacing: 8) {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(MyPlaylistsRedditTheme.artworkGradient)
                            .frame(width: 180, height: 180)
                            .overlay {
                                Image(systemName: "music.note.list")
                                    .font(.title)
                                    .foregroundStyle(.white.opacity(0.85))
                            }
                        Text(playlist.title)
                            .font(.headline)
                            .lineLimit(2)
                        Text("\(playlist.trackCount) titres")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: 180, alignment: .leading)
                }
            }
        }
    }

    private func stationRow(_ title: String, subtitle: String) -> some View {
        HStack(spacing: 14) {
            Circle()
                .fill(MyPlaylistsRedditTheme.accent.gradient)
                .frame(width: 52, height: 52)
                .overlay {
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .foregroundStyle(.white)
                }
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

struct MyPlaylistsRedditPlaylistDetail: View {
    let playlist: LpspAppleMusicPlaylist
    @ObservedObject var player: MyPlaylistsRedditPlayer
    let queue: [LpspAppleMusicTrack]

    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(MyPlaylistsRedditTheme.artworkGradient)
                        .frame(width: 180, height: 180)
                        .overlay {
                            Image(systemName: "music.note.list")
                                .font(.largeTitle)
                                .foregroundStyle(.white.opacity(0.9))
                        }
                    Text(playlist.title)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                    Text("\(playlist.trackCount) titres")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }

            Section("Titres") {
                ForEach(playlist.tracks) { track in
                    Button {
                        player.play(track)
                    } label: {
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(MyPlaylistsRedditTheme.artworkGradient)
                                .frame(width: 44, height: 44)
                                .overlay {
                                    Image(systemName: "music.note")
                                        .foregroundStyle(.white.opacity(0.85))
                                }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(track.title)
                                    .foregroundStyle(.primary)
                                    .lineLimit(1)
                                Text(track.artist)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            Spacer()
                            if player.currentTrack?.id == track.id, player.isPlaying {
                                Image(systemName: "waveform")
                                    .foregroundStyle(MyPlaylistsRedditTheme.accent)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(playlist.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyPlaylistsRedditPlaceholderView: View {
    let title: String
    let symbol: String

    var body: some View {
        NavigationStack {
            ContentUnavailableView(title, systemImage: symbol)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

enum MyPlaylistsRedditLPSP {
    static func allTracks(from data: LpspAppleMusicData) -> [LpspAppleMusicTrack] {
        var seen = Set<String>()
        var tracks: [LpspAppleMusicTrack] = []
        for track in data.recentTracks + data.playlists.flatMap(\.tracks) {
            if seen.insert(track.id).inserted {
                tracks.append(track)
            }
        }
        return tracks
    }
}

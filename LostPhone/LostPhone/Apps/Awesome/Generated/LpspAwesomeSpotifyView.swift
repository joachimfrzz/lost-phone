import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/spotify
// Showroom interactif — build déclenché après passage du repo en public
// Meliwat/awesome-ios-design-md/music/spotify/DESIGN-swiftui.md
struct LpspAwesomeSpotifyView: View {
    var data: LpspSpotifyData?

    var body: some View {
        let storyData = data
        LpspSpotifyShowroomRoot(
            store: LpspSpotifyStore(
                username: storyData?.username ?? LpspSpotifyShowroomData.username,
                plan: storyData?.plan ?? LpspSpotifyShowroomData.plan,
                playlists: storyData.map { LpspSpotifyStore.playlists(from: $0) } ?? LpspSpotifyShowroomData.playlists,
                recentTracks: storyData.map { LpspSpotifyStore.tracks(from: $0.recentTracks) } ?? LpspSpotifyShowroomData.recentTracks,
                quickPicks: LpspSpotifyShowroomData.quickPicks,
                madeForYou: LpspSpotifyShowroomData.madeForYou,
                categories: LpspSpotifyShowroomData.categories,
                podcasts: LpspSpotifyShowroomData.podcasts
            ),
            isStoryMode: storyData != nil
        )
    }
}

// MARK: - Tokens & composants

private enum LpspSpotifyFonts {
    static let spotifyTitleLarge  = Font.system(size: 28, weight: .bold)
    static let spotifyTitle       = Font.system(size: 22, weight: .bold)
    static let spotifyPlaylistHero = Font.system(size: 24, weight: .bold)
    static let spotifyTrackTitle  = Font.system(size: 16, weight: .medium)
    static let spotifyCardTitle   = Font.system(size: 15, weight: .semibold)
    static let spotifySubtitle    = Font.system(size: 14, weight: .regular)
    static let spotifyBody        = Font.system(size: 15, weight: .regular)
    static let spotifyMeta        = Font.system(size: 12, weight: .regular)
    static let spotifyLabelUpper  = Font.system(size: 11, weight: .semibold)
    static let spotifyButton      = Font.system(size: 16, weight: .bold)
    static let spotifyTab         = Font.system(size: 11, weight: .regular)
}

private enum LpspSpotifyTokens {
    static let spotifyCanvas       = Color(red: 0.07, green: 0.07, blue: 0.07)
    static let spotifySurface1     = Color(red: 0.094, green: 0.094, blue: 0.094)
    static let spotifySurface2     = Color(red: 0.157, green: 0.157, blue: 0.157)
    static let spotifySurface3     = Color(red: 0.243, green: 0.243, blue: 0.243)
    static let spotifyDivider      = Color(red: 0.165, green: 0.165, blue: 0.165)
    static let spotifyTextPrimary   = Color.white
    static let spotifyTextSecondary = Color(red: 0.702, green: 0.702, blue: 0.702)
    static let spotifyTextTertiary  = Color(red: 0.416, green: 0.416, blue: 0.416)
    static let spotifyGreen        = Color(red: 0.114, green: 0.725, blue: 0.329)
    static let spotifyGreenPressed = Color(red: 0.086, green: 0.612, blue: 0.275)
    static let spotifyLogoGreen    = Color(red: 0.118, green: 0.843, blue: 0.376)
}

fileprivate struct LpspSpotifyPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspSpotifyArtwork: View {
    let accent: Color
    var icon: String = "music.note"
    var size: CGFloat = 44
    var cornerRadius: CGFloat = 4

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(
                LinearGradient(
                    colors: [accent, accent.opacity(0.45)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: size, height: size)
            .overlay(
                Image(systemName: icon)
                    .font(.system(size: size * 0.34, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.92))
            )
    }
}

fileprivate struct LpspSpotifyPlayButton: View {
    let isPlaying: Bool
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: size * 0.42, weight: .bold))
                .foregroundStyle(.black)
                .frame(width: size, height: size)
                .background(Circle().fill(LpspSpotifyTokens.spotifyGreen))
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isPlaying)
        .buttonStyle(LpspSpotifyPressableStyle(pressedScale: 0.92))
    }
}

fileprivate struct LpspSpotifyEqualizerBars: View {
    let color: Color
    @State private var animate = false

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<3, id: \.self) { i in
                RoundedRectangle(cornerRadius: 1)
                    .fill(color)
                    .frame(width: 3, height: animate ? CGFloat([10, 14, 8][i]) : CGFloat([6, 10, 5][i]))
                    .animation(
                        .easeInOut(duration: 0.45).repeatForever(autoreverses: true).delay(Double(i) * 0.12),
                        value: animate
                    )
            }
        }
        .onAppear { animate = true }
    }
}

fileprivate struct LpspSpotifyTrackRow: View {
    let track: LpspSpotifyShowroomTrack
    let isPlaying: Bool
    let action: () -> Void
    var menuAction: (() -> Void)?

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    LpspSpotifyArtwork(accent: track.accent, size: 44)
                    if isPlaying {
                        LpspSpotifyEqualizerBars(color: LpspSpotifyTokens.spotifyGreen)
                            .padding(6)
                            .background(Color.black.opacity(0.55))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(track.title)
                        .font(LpspSpotifyFonts.spotifyTrackTitle)
                        .foregroundStyle(isPlaying ? LpspSpotifyTokens.spotifyGreen : .white)
                        .lineLimit(1)
                    Text(track.artist)
                        .font(LpspSpotifyFonts.spotifySubtitle)
                        .foregroundStyle(isPlaying ? LpspSpotifyTokens.spotifyGreen : LpspSpotifyTokens.spotifyTextSecondary)
                        .lineLimit(1)
                }

                Spacer()

                Button {
                    menuAction?()
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .contentShape(Rectangle())
        }
        .buttonStyle(LpspSpotifyPressableStyle())
    }
}

fileprivate struct LpspSpotifyScrubber: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.white.opacity(0.25)).frame(height: 4)
                Capsule()
                    .fill(.white)
                    .frame(width: max(0, geo.size.width * progress), height: 4)
                Circle()
                    .fill(.white)
                    .frame(width: 12, height: 12)
                    .offset(x: max(0, geo.size.width * progress - 6))
            }
        }
        .frame(height: 12)
    }
}

// MARK: - Données & état

fileprivate struct LpspSpotifyShowroomTrack: Identifiable, Hashable {
    let id: String
    let title: String
    let artist: String
    let album: String
    let duration: String
    let accent: Color
}

fileprivate struct LpspSpotifyShowroomPlaylist: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let trackCount: Int
    let accent: Color
    let tracks: [LpspSpotifyShowroomTrack]
}

fileprivate struct LpspSpotifyShowroomCategory: Identifiable, Hashable {
    let id: String
    let title: String
    let accent: Color
}

@MainActor
fileprivate final class LpspSpotifyStore: ObservableObject {
    @Published var selectedTab: LpspSpotifyTab = .home
    @Published var currentTrack: LpspSpotifyShowroomTrack?
    @Published var queue: [LpspSpotifyShowroomTrack] = []
    @Published var isPlaying = false
    @Published var playbackProgress: Double = 0
    @Published var playbackElapsedSeconds: Double = 0
    @Published var shuffleEnabled = false
    @Published var repeatEnabled = false
    @Published var showNowPlaying = false
    @Published var presentedPlaylist: LpspSpotifyShowroomPlaylist?
    @Published var activePlaylist: LpspSpotifyShowroomPlaylist?
    @Published var searchQuery = ""
    @Published var libraryFilter: LpspSpotifyLibraryFilter = .playlists
    @Published var homeFilter: LpspSpotifyHomeFilter = .all

    let username: String
    let plan: String
    let playlists: [LpspSpotifyShowroomPlaylist]
    let recentTracks: [LpspSpotifyShowroomTrack]
    let quickPicks: [LpspSpotifyShowroomPlaylist]
    let madeForYou: [LpspSpotifyShowroomPlaylist]
    let categories: [LpspSpotifyShowroomCategory]
    let podcasts: [LpspSpotifyShowroomPlaylist]

    private var playbackTask: Task<Void, Never>?

    init(
        username: String,
        plan: String,
        playlists: [LpspSpotifyShowroomPlaylist],
        recentTracks: [LpspSpotifyShowroomTrack],
        quickPicks: [LpspSpotifyShowroomPlaylist],
        madeForYou: [LpspSpotifyShowroomPlaylist],
        categories: [LpspSpotifyShowroomCategory],
        podcasts: [LpspSpotifyShowroomPlaylist]
    ) {
        self.username = username
        self.plan = plan
        self.playlists = playlists
        self.recentTracks = recentTracks
        self.quickPicks = quickPicks
        self.madeForYou = madeForYou
        self.categories = categories
        self.podcasts = podcasts
        self.currentTrack = recentTracks.first
        self.queue = recentTracks
        self.isPlaying = true
        self.playbackProgress = 0
        self.playbackElapsedSeconds = 0
        startPlaybackClock()
    }

    deinit {
        playbackTask?.cancel()
    }

    var currentTrackDurationSeconds: Double {
        guard let track = currentTrack else { return 0 }
        return Self.durationSeconds(for: track.duration)
    }

    static func durationSeconds(for duration: String) -> Double {
        let parts = duration.split(separator: ":")
        guard parts.count == 2,
              let minutes = Int(parts[0]),
              let seconds = Int(parts[1]) else { return 180 }
        return Double(minutes * 60 + seconds)
    }

    func formattedTime(_ seconds: Double) -> String {
        let total = max(0, Int(seconds))
        return "\(total / 60):\(String(format: "%02d", total % 60))"
    }

    private func syncProgress() {
        let duration = currentTrackDurationSeconds
        guard duration > 0 else {
            playbackProgress = 0
            return
        }
        playbackProgress = min(1, playbackElapsedSeconds / duration)
    }

    private func resetPlaybackPosition() {
        playbackElapsedSeconds = 0
        playbackProgress = 0
    }

    func startPlaybackClock() {
        playbackTask?.cancel()
        guard isPlaying else { return }
        playbackTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .milliseconds(500))
                await MainActor.run {
                    guard let self, self.isPlaying else { return }
                    let duration = self.currentTrackDurationSeconds
                    guard duration > 0 else { return }
                    self.playbackElapsedSeconds += 0.5
                    if self.playbackElapsedSeconds >= duration {
                        self.playNext()
                    } else {
                        self.syncProgress()
                    }
                }
            }
        }
    }

    func stopPlaybackClock() {
        playbackTask?.cancel()
        playbackTask = nil
    }

    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good morning" }
        if hour < 18 { return "Good afternoon" }
        return "Good evening"
    }

    var filteredSearchResults: [LpspSpotifyShowroomTrack] {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return [] }
        let allTracks = (playlists.flatMap(\.tracks) + recentTracks)
        var seen = Set<String>()
        return allTracks.filter { track in
            guard seen.insert(track.id).inserted else { return false }
            return track.title.lowercased().contains(query) || track.artist.lowercased().contains(query)
        }
    }

    func play(_ track: LpspSpotifyShowroomTrack, from playlist: LpspSpotifyShowroomPlaylist? = nil) {
        currentTrack = track
        isPlaying = true
        resetPlaybackPosition()
        activePlaylist = playlist
        if let playlist, let index = playlist.tracks.firstIndex(of: track) {
            queue = Array(playlist.tracks[index...]) + playlist.tracks.prefix(index)
        } else if !recentTracks.contains(track) {
            queue = [track] + recentTracks.filter { $0.id != track.id }
        } else if let index = recentTracks.firstIndex(of: track) {
            queue = Array(recentTracks[index...]) + recentTracks.prefix(index)
        }
        startPlaybackClock()
    }

    func playPlaylist(_ playlist: LpspSpotifyShowroomPlaylist) {
        guard let first = playlist.tracks.first else { return }
        play(first, from: playlist)
    }

    func togglePlayPause() {
        guard currentTrack != nil else {
            if let first = recentTracks.first {
                play(first)
            }
            return
        }
        isPlaying.toggle()
        if isPlaying {
            startPlaybackClock()
        } else {
            stopPlaybackClock()
        }
    }

    func playNext() {
        guard !queue.isEmpty, let current = currentTrack,
              let index = queue.firstIndex(of: current) else { return }
        let nextIndex = (index + 1) % queue.count
        currentTrack = queue[nextIndex]
        isPlaying = true
        resetPlaybackPosition()
        startPlaybackClock()
    }

    func playPrevious() {
        guard !queue.isEmpty, let current = currentTrack,
              let index = queue.firstIndex(of: current) else { return }
        if playbackElapsedSeconds > 3 {
            resetPlaybackPosition()
            startPlaybackClock()
            return
        }
        let prevIndex = index == 0 ? queue.count - 1 : index - 1
        currentTrack = queue[prevIndex]
        isPlaying = true
        resetPlaybackPosition()
        startPlaybackClock()
    }

    static func playlists(from data: LpspSpotifyData) -> [LpspSpotifyShowroomPlaylist] {
        data.playlists.enumerated().map { index, playlist in
            LpspSpotifyShowroomPlaylist(
                id: playlist.id,
                title: playlist.title,
                subtitle: "Playlist",
                trackCount: playlist.trackCount,
                accent: LpspSpotifyShowroomData.palette[index % LpspSpotifyShowroomData.palette.count],
                tracks: tracks(from: playlist.tracks, paletteIndex: index)
            )
        }
    }

    static func tracks(from tracks: [LpspSpotifyTrack], paletteIndex: Int = 0) -> [LpspSpotifyShowroomTrack] {
        tracks.enumerated().map { index, track in
            LpspSpotifyShowroomTrack(
                id: track.id,
                title: track.title,
                artist: track.artist,
                album: "Single",
                duration: "3:\(String(format: "%02d", (index * 17 + 23) % 60))",
                accent: LpspSpotifyShowroomData.palette[(paletteIndex + index) % LpspSpotifyShowroomData.palette.count]
            )
        }
    }
}

private enum LpspSpotifyShowroomData {
    static let username = "Maya Rivera"
    static let plan = "Premium"

    static let palette: [Color] = [
        Color(red: 0.20, green: 0.45, blue: 0.95),
        Color(red: 0.85, green: 0.25, blue: 0.45),
        Color(red: 0.15, green: 0.70, blue: 0.55),
        Color(red: 0.95, green: 0.55, blue: 0.20),
        Color(red: 0.55, green: 0.35, blue: 0.90),
        Color(red: 0.90, green: 0.30, blue: 0.30),
    ]

    static let recentTracks: [LpspSpotifyShowroomTrack] = [
        .init(id: "t1", title: "Blinding Lights", artist: "The Weeknd", album: "After Hours", duration: "3:20", accent: palette[0]),
        .init(id: "t2", title: "As It Was", artist: "Harry Styles", album: "Harry's House", duration: "2:47", accent: palette[1]),
        .init(id: "t3", title: "Flowers", artist: "Miley Cyrus", album: "Endless Summer Vacation", duration: "3:20", accent: palette[2]),
        .init(id: "t4", title: "Espresso", artist: "Sabrina Carpenter", album: "Espresso", duration: "2:55", accent: palette[3]),
        .init(id: "t5", title: "Birds of a Feather", artist: "Billie Eilish", album: "HIT ME HARD AND SOFT", duration: "3:30", accent: palette[4]),
    ]

    static let playlists: [LpspSpotifyShowroomPlaylist] = [
        .init(
            id: "pl1", title: "Mellow Mornings", subtitle: "Soft starts for slow days",
            trackCount: 24, accent: palette[0],
            tracks: [
                .init(id: "pl1-t1", title: "Sunset Lover", artist: "Petit Biscuit", album: "Presence", duration: "3:29", accent: palette[0]),
                .init(id: "pl1-t2", title: "Holocene", artist: "Bon Iver", album: "Bon Iver", duration: "5:36", accent: palette[1]),
                .init(id: "pl1-t3", title: "Riptide", artist: "Vance Joy", album: "Dream Your Life Away", duration: "3:24", accent: palette[2]),
            ]
        ),
        .init(
            id: "pl2", title: "Louvre After Hours", subtitle: "Maya's Paris nights",
            trackCount: 18, accent: palette[5],
            tracks: [
                .init(id: "pl2-t1", title: "Midnight City", artist: "M83", album: "Hurry Up, We're Dreaming", duration: "4:03", accent: palette[5]),
                .init(id: "pl2-t2", title: "Nightcall", artist: "Kavinsky", album: "OutRun", duration: "4:18", accent: palette[4]),
                .init(id: "pl2-t3", title: "La Vie en rose", artist: "Édith Piaf", album: "Chansons Parisiennes", duration: "3:08", accent: palette[3]),
            ]
        ),
        .init(
            id: "pl3", title: "Focus Flow", subtitle: "Deep work instrumentals",
            trackCount: 32, accent: palette[2],
            tracks: [
                .init(id: "pl3-t1", title: "Experience", artist: "Ludovico Einaudi", album: "In a Time Lapse", duration: "5:15", accent: palette[2]),
                .init(id: "pl3-t2", title: "Cornfield Chase", artist: "Hans Zimmer", album: "Interstellar OST", duration: "2:06", accent: palette[0]),
                .init(id: "pl3-t3", title: "Arrival of the Birds", artist: "The Cinematic Orchestra", album: "The Crimson Wing", duration: "5:37", accent: palette[4]),
            ]
        ),
        .init(
            id: "pl4", title: "Indie France", subtitle: "French indie & pop",
            trackCount: 21, accent: palette[1],
            tracks: [
                .init(id: "pl4-t1", title: "Dommage", artist: "Bigflo & Oli", album: "La vie de rêve", duration: "3:12", accent: palette[1]),
                .init(id: "pl4-t2", title: "Jeune (j.c)", artist: "Louane", album: "Louane", duration: "3:42", accent: palette[3]),
                .init(id: "pl4-t3", title: "Soudain", artist: "Vianney", album: "Idées blanches", duration: "3:18", accent: palette[5]),
            ]
        ),
    ]

    static let quickPicks: [LpspSpotifyShowroomPlaylist] = Array(playlists.prefix(4))

    static let madeForYou: [LpspSpotifyShowroomPlaylist] = [
        playlists[1], playlists[2], playlists[3],
        .init(
            id: "mf1", title: "Discover Weekly", subtitle: "Your mixtape of fresh music",
            trackCount: 30, accent: palette[4],
            tracks: recentTracks
        ),
    ]

    static let categories: [LpspSpotifyShowroomCategory] = [
        .init(id: "c1", title: "Pop", accent: Color(red: 0.85, green: 0.25, blue: 0.45)),
        .init(id: "c2", title: "Hip-Hop", accent: Color(red: 0.95, green: 0.55, blue: 0.20)),
        .init(id: "c3", title: "Rock", accent: Color(red: 0.90, green: 0.30, blue: 0.30)),
        .init(id: "c4", title: "Jazz", accent: Color(red: 0.20, green: 0.45, blue: 0.95)),
        .init(id: "c5", title: "Podcasts", accent: Color(red: 0.15, green: 0.70, blue: 0.55)),
        .init(id: "c6", title: "Charts", accent: Color(red: 0.55, green: 0.35, blue: 0.90)),
        .init(id: "c7", title: "Mood", accent: Color(red: 0.30, green: 0.55, blue: 0.85)),
        .init(id: "c8", title: "Indie", accent: Color(red: 0.75, green: 0.40, blue: 0.55)),
    ]

    static let podcasts: [LpspSpotifyShowroomPlaylist] = [
        .init(
            id: "pod1", title: "Lost Phone Daily", subtitle: "Investigation briefings",
            trackCount: 42, accent: palette[4],
            tracks: [
                .init(id: "pod1-t1", title: "Episode 12 — The Louvre lead", artist: "Lost Phone Daily", album: "Season 1", duration: "28:14", accent: palette[4]),
                .init(id: "pod1-t2", title: "Episode 11 — Metro line 1", artist: "Lost Phone Daily", album: "Season 1", duration: "31:02", accent: palette[0]),
            ]
        ),
        .init(
            id: "pod2", title: "Design Guild Radio", subtitle: "UI craft & product stories",
            trackCount: 18, accent: palette[3],
            tracks: [
                .init(id: "pod2-t1", title: "Spectr fidelity in SwiftUI", artist: "Jordan P.", album: "Design Guild", duration: "44:08", accent: palette[3]),
            ]
        ),
    ]
}

// MARK: - Écrans showroom

private enum LpspSpotifyTab: CaseIterable {
    case home, search, library, premium

    var label: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        case .library: "Your Library"
        case .premium: "Premium"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .search: "magnifyingglass"
        case .library: "books.vertical.fill"
        case .premium: "circle.fill"
        }
    }
}

private enum LpspSpotifyLibraryFilter: String, CaseIterable {
    case playlists = "Playlists"
    case podcasts = "Podcasts"
    case albums = "Albums"
    case artists = "Artists"
}

private enum LpspSpotifyHomeFilter: String, CaseIterable {
    case all = "All"
    case music = "Music"
    case podcasts = "Podcasts"
}

private struct LpspSpotifyShowroomRoot: View {
    @ObservedObject var store: LpspSpotifyStore
    var isStoryMode = false

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspSpotifyHomeTabScreen(store: store, isStoryMode: isStoryMode)
                case .search:
                    LpspSpotifySearchTabScreen(store: store)
                case .library:
                    LpspSpotifyLibraryTabScreen(store: store)
                case .premium:
                    LpspSpotifyPremiumTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            if let track = store.currentTrack {
                LpspSpotifyMiniPlayerBar(store: store, track: track)
            }

            LpspSpotifySpectrTabBar(selectedTab: $store.selectedTab)
        }
        .background(LpspSpotifyTokens.spotifyCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .sheet(isPresented: $store.showNowPlaying) {
            if let track = store.currentTrack {
                LpspSpotifyNowPlayingScreen(store: store, track: track)
            }
        }
        .sheet(item: $store.presentedPlaylist) { playlist in
            LpspSpotifyPlaylistDetailScreen(store: store, playlist: playlist)
        }
    }
}

private struct LpspSpotifySpectrTabBar: View {
    @Binding var selectedTab: LpspSpotifyTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspSpotifyTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        if tab == .premium {
                            Image(systemName: tab.icon)
                                .font(.system(size: 20))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [LpspSpotifyTokens.spotifyLogoGreen, .white],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        } else {
                            Image(systemName: tab.icon)
                                .font(.system(size: 20))
                        }
                        Text(tab.label)
                            .font(LpspSpotifyFonts.spotifyTab)
                    }
                    .foregroundStyle(selectedTab == tab ? .white : LpspSpotifyTokens.spotifyTextSecondary)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(LpspSpotifyPressableStyle())
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 2)
        .background(LpspSpotifyTokens.spotifySurface1)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspSpotifyTokens.spotifyDivider).frame(height: 0.5)
        }
    }
}

private struct LpspSpotifyMiniPlayerBar: View {
    @ObservedObject var store: LpspSpotifyStore
    let track: LpspSpotifyShowroomTrack

    var body: some View {
        HStack(spacing: 12) {
            Button { store.showNowPlaying = true } label: {
                HStack(spacing: 12) {
                    LpspSpotifyArtwork(accent: track.accent, size: 40)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(track.title)
                            .font(LpspSpotifyFonts.spotifyTrackTitle)
                            .foregroundStyle(.white)
                            .lineLimit(1)
                        Text(track.artist)
                            .font(LpspSpotifyFonts.spotifyMeta)
                            .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                            .lineLimit(1)
                    }
                }
            }
            .buttonStyle(.plain)

            Spacer()

            Button { store.togglePlayPause() } label: {
                Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
            }
            .buttonStyle(LpspSpotifyPressableStyle())

            Button { store.playNext() } label: {
                Image(systemName: "forward.end.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
            }
            .buttonStyle(LpspSpotifyPressableStyle())
            .padding(.trailing, 12)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(LpspSpotifyTokens.spotifySurface2)
    }
}

private struct LpspSpotifyHomeTabScreen: View {
    @ObservedObject var store: LpspSpotifyStore
    var isStoryMode = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    HStack {
                        Text(store.greeting)
                            .font(LpspSpotifyFonts.spotifyTitleLarge)
                            .foregroundStyle(.white)
                        Spacer()
                        Circle()
                            .fill(LpspSpotifyTokens.spotifySurface3)
                            .frame(width: 32, height: 32)
                            .overlay(
                                Text(String(store.username.prefix(1)))
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.white)
                            )
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(LpspSpotifyHomeFilter.allCases, id: \.self) { filter in
                                Button {
                                    store.homeFilter = filter
                                } label: {
                                    Text(filter.rawValue)
                                        .font(LpspSpotifyFonts.spotifyMeta)
                                        .foregroundStyle(store.homeFilter == filter ? .black : .white)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule().fill(
                                                store.homeFilter == filter
                                                    ? .white
                                                    : LpspSpotifyTokens.spotifySurface2
                                            )
                                        )
                                }
                                .buttonStyle(LpspSpotifyPressableStyle())
                            }
                        }
                        .padding(.horizontal)
                    }

                    if store.homeFilter != .podcasts {
                        quickAccessGrid
                        madeForYouSection
                    }

                    if store.homeFilter != .music {
                        podcastSection
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recently played")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.horizontal)

                        ForEach(store.recentTracks) { track in
                            LpspSpotifyTrackRow(
                                track: track,
                                isPlaying: store.currentTrack?.id == track.id && store.isPlaying
                            ) {
                                store.play(track)
                            }
                        }
                    }

                    if isStoryMode {
                        Text("\(store.username) · \(store.plan)")
                            .font(LpspSpotifyFonts.spotifyMeta)
                            .foregroundStyle(LpspSpotifyTokens.spotifyTextTertiary)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical, 8)
            }
            .background(LpspSpotifyTokens.spotifyCanvas.ignoresSafeArea())
            .navigationTitle("")
        }
    }

    private var quickAccessGrid: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Jump back in")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                ForEach(store.quickPicks) { playlist in
                    Button {
                        store.presentedPlaylist = playlist
                    } label: {
                        HStack(spacing: 10) {
                            LpspSpotifyArtwork(accent: playlist.accent, size: 48, cornerRadius: 4)
                            Text(playlist.title)
                                .font(LpspSpotifyFonts.spotifyCardTitle)
                                .foregroundStyle(.white)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                            Spacer(minLength: 0)
                        }
                        .padding(.trailing, 10)
                        .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 4).fill(LpspSpotifyTokens.spotifySurface2))
                    }
                    .buttonStyle(LpspSpotifyPressableStyle())
                }
            }
            .padding(.horizontal)
        }
    }

    private var madeForYouSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Made for you")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(store.madeForYou) { playlist in
                        Button {
                            store.presentedPlaylist = playlist
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                LpspSpotifyArtwork(accent: playlist.accent, size: 140, cornerRadius: 8)
                                Text(playlist.title)
                                    .font(LpspSpotifyFonts.spotifyCardTitle)
                                    .foregroundStyle(.white)
                                    .lineLimit(2)
                                    .frame(width: 140, alignment: .leading)
                                Text(playlist.subtitle)
                                    .font(LpspSpotifyFonts.spotifyMeta)
                                    .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                                    .lineLimit(1)
                                    .frame(width: 140, alignment: .leading)
                            }
                        }
                        .buttonStyle(LpspSpotifyPressableStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var podcastSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your podcasts")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal)

            ForEach(store.podcasts) { podcast in
                Button {
                    store.presentedPlaylist = podcast
                } label: {
                    HStack(spacing: 12) {
                        LpspSpotifyArtwork(accent: podcast.accent, icon: "mic.fill", size: 56, cornerRadius: 4)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(podcast.title)
                                .font(LpspSpotifyFonts.spotifyCardTitle)
                                .foregroundStyle(.white)
                            Text(podcast.subtitle)
                                .font(LpspSpotifyFonts.spotifyMeta)
                                .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                .buttonStyle(LpspSpotifyPressableStyle())
            }
        }
    }
}

private struct LpspSpotifySearchTabScreen: View {
    @ObservedObject var store: LpspSpotifyStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                        TextField("What do you want to listen to?", text: $store.searchQuery)
                            .font(LpspSpotifyFonts.spotifyBody)
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(LpspSpotifyTokens.spotifySurface2))
                    .padding(.horizontal)

                    if store.searchQuery.isEmpty {
                        Text("Browse all")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.horizontal)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(store.categories) { category in
                                Button {
                                    store.searchQuery = category.title
                                } label: {
                                    ZStack(alignment: .bottomLeading) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(
                                                LinearGradient(
                                                    colors: [category.accent, category.accent.opacity(0.55)],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(height: 96)
                                        Text(category.title)
                                            .font(LpspSpotifyFonts.spotifyCardTitle)
                                            .foregroundStyle(.white)
                                            .padding(10)
                                    }
                                }
                                .buttonStyle(LpspSpotifyPressableStyle())
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        Text("Top results")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.horizontal)

                        if store.filteredSearchResults.isEmpty {
                            Text("No results for \"\(store.searchQuery)\"")
                                .font(LpspSpotifyFonts.spotifySubtitle)
                                .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                                .padding(.horizontal)
                        } else {
                            ForEach(store.filteredSearchResults) { track in
                                LpspSpotifyTrackRow(
                                    track: track,
                                    isPlaying: store.currentTrack?.id == track.id && store.isPlaying
                                ) {
                                    store.play(track)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .background(LpspSpotifyTokens.spotifyCanvas.ignoresSafeArea())
            .navigationTitle("Search")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

private struct LpspSpotifyLibraryTabScreen: View {
    @ObservedObject var store: LpspSpotifyStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(LpspSpotifyLibraryFilter.allCases, id: \.self) { filter in
                            Button {
                                store.libraryFilter = filter
                            } label: {
                                Text(filter.rawValue)
                                    .font(LpspSpotifyFonts.spotifyMeta)
                                    .foregroundStyle(store.libraryFilter == filter ? .black : .white)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(
                                        Capsule().fill(
                                            store.libraryFilter == filter
                                                ? .white
                                                : LpspSpotifyTokens.spotifySurface2
                                        )
                                    )
                            }
                            .buttonStyle(LpspSpotifyPressableStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }

                List {
                    switch store.libraryFilter {
                    case .playlists:
                        ForEach(store.playlists) { playlist in
                            libraryRow(
                                title: playlist.title,
                                subtitle: "Playlist · \(playlist.trackCount) songs",
                                accent: playlist.accent,
                                icon: "music.note.list"
                            ) {
                                store.presentedPlaylist = playlist
                            }
                        }
                    case .podcasts:
                        ForEach(store.podcasts) { podcast in
                            libraryRow(
                                title: podcast.title,
                                subtitle: "Podcast · \(podcast.trackCount) episodes",
                                accent: podcast.accent,
                                icon: "mic.fill"
                            ) {
                                store.presentedPlaylist = podcast
                            }
                        }
                    case .albums:
                        ForEach(store.recentTracks) { track in
                            libraryRow(
                                title: track.album,
                                subtitle: "Album · \(track.artist)",
                                accent: track.accent,
                                icon: "opticaldisc.fill"
                            ) {
                                store.play(track)
                            }
                        }
                    case .artists:
                        ForEach(Array(Set(store.recentTracks.map(\.artist))).sorted(), id: \.self) { artist in
                            let track = store.recentTracks.first { $0.artist == artist }!
                            libraryRow(
                                title: artist,
                                subtitle: "Artist",
                                accent: track.accent,
                                icon: "person.fill"
                            ) {
                                store.play(track)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Your Library")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        Image(systemName: "magnifyingglass")
                        Image(systemName: "plus")
                    }
                    .foregroundStyle(.white)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspSpotifyTokens.spotifyCanvas.ignoresSafeArea())
    }

    private func libraryRow(
        title: String,
        subtitle: String,
        accent: Color,
        icon: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                LpspSpotifyArtwork(accent: accent, icon: icon, size: 48)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(LpspSpotifyFonts.spotifyCardTitle)
                        .foregroundStyle(.white)
                    Text(subtitle)
                        .font(LpspSpotifyFonts.spotifyMeta)
                        .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                }
            }
        }
        .listRowBackground(LpspSpotifyTokens.spotifySurface1)
    }
}

private struct LpspSpotifyPremiumTabScreen: View {
    @ObservedObject var store: LpspSpotifyStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Premium")
                    .font(LpspSpotifyFonts.spotifyTitleLarge)
                    .foregroundStyle(.white)

                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [LpspSpotifyTokens.spotifyGreen, LpspSpotifyTokens.spotifyLogoGreen],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                    .overlay(alignment: .bottomLeading) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("You're on Premium")
                                .font(LpspSpotifyFonts.spotifyPlaylistHero)
                                .foregroundStyle(.black)
                            Text("\(store.username) · ad-free music, offline listening")
                                .font(LpspSpotifyFonts.spotifySubtitle)
                                .foregroundStyle(.black.opacity(0.75))
                        }
                        .padding(20)
                    }

                premiumFeature("checkmark.circle.fill", "Ad-free music listening")
                premiumFeature("arrow.down.circle.fill", "Download to listen offline")
                premiumFeature("forward.end.fill", "Play songs in any order")
                premiumFeature("music.note.list", "High-quality audio")

                Button { } label: {
                    Text("Manage your plan")
                        .font(LpspSpotifyFonts.spotifyButton)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 24).fill(.white))
                }
                .buttonStyle(LpspSpotifyPressableStyle())
            }
            .padding(16)
        }
        .background(LpspSpotifyTokens.spotifyCanvas.ignoresSafeArea())
    }

    private func premiumFeature(_ icon: String, _ text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(LpspSpotifyTokens.spotifyGreen)
                .frame(width: 28)
            Text(text)
                .font(LpspSpotifyFonts.spotifyBody)
                .foregroundStyle(.white)
        }
    }
}

private struct LpspSpotifyPlaylistDetailScreen: View {
    @ObservedObject var store: LpspSpotifyStore
    let playlist: LpspSpotifyShowroomPlaylist
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .bottom, spacing: 16) {
                        LpspSpotifyArtwork(accent: playlist.accent, size: 140, cornerRadius: 8)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Playlist")
                                .font(LpspSpotifyFonts.spotifyLabelUpper)
                                .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                            Text(playlist.title)
                                .font(LpspSpotifyFonts.spotifyPlaylistHero)
                                .foregroundStyle(.white)
                                .lineLimit(3)
                            Text("\(store.username) · \(playlist.trackCount) songs")
                                .font(LpspSpotifyFonts.spotifyMeta)
                                .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                        }
                    }
                    .padding(.horizontal)

                    HStack(spacing: 24) {
                        LpspSpotifyPlayButton(isPlaying: store.isPlaying && store.activePlaylist?.id == playlist.id, size: 56) {
                            store.playPlaylist(playlist)
                        }
                        Button { store.shuffleEnabled.toggle() } label: {
                            Image(systemName: "shuffle")
                                .font(.system(size: 22))
                                .foregroundStyle(store.shuffleEnabled ? LpspSpotifyTokens.spotifyGreen : .white)
                        }
                        .buttonStyle(LpspSpotifyPressableStyle())
                        Spacer()
                    }
                    .padding(.horizontal)

                    ForEach(playlist.tracks) { track in
                        LpspSpotifyTrackRow(
                            track: track,
                            isPlaying: store.currentTrack?.id == track.id && store.isPlaying
                        ) {
                            store.play(track, from: playlist)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .background(LpspSpotifyTokens.spotifyCanvas.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(.white)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

private struct LpspSpotifyNowPlayingScreen: View {
    @ObservedObject var store: LpspSpotifyStore
    let track: LpspSpotifyShowroomTrack
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [track.accent.opacity(0.85), LpspSpotifyTokens.spotifyCanvas],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    VStack(spacing: 2) {
                        Text(store.activePlaylist?.title ?? "Now Playing")
                            .font(LpspSpotifyFonts.spotifyMeta)
                            .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                        Text(track.artist)
                            .font(LpspSpotifyFonts.spotifyCardTitle)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    Button { } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)

                Spacer()

                LpspSpotifyArtwork(accent: track.accent, size: 320, cornerRadius: 8)
                    .shadow(color: .black.opacity(0.45), radius: 28, y: 14)

                VStack(spacing: 6) {
                    Text(track.title)
                        .font(LpspSpotifyFonts.spotifyTitle)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    Text(track.artist)
                        .font(LpspSpotifyFonts.spotifySubtitle)
                        .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                        .lineLimit(1)
                }
                .padding(.horizontal, 24)

                VStack(spacing: 8) {
                    LpspSpotifyScrubber(progress: $store.playbackProgress)
                    HStack {
                        Text(store.formattedTime(store.playbackElapsedSeconds))
                        Spacer()
                        Text(track.duration)
                    }
                    .font(LpspSpotifyFonts.spotifyMeta)
                    .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                }
                .padding(.horizontal, 24)

                HStack(spacing: 28) {
                    Button { store.shuffleEnabled.toggle() } label: {
                        Image(systemName: "shuffle")
                            .foregroundStyle(store.shuffleEnabled ? LpspSpotifyTokens.spotifyGreen : LpspSpotifyTokens.spotifyTextSecondary)
                    }
                    Button { store.playPrevious() } label: {
                        Image(systemName: "backward.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.white)
                    }
                    LpspSpotifyPlayButton(isPlaying: store.isPlaying, size: 72) {
                        store.togglePlayPause()
                    }
                    Button { store.playNext() } label: {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.white)
                    }
                    Button { store.repeatEnabled.toggle() } label: {
                        Image(systemName: "repeat")
                            .foregroundStyle(store.repeatEnabled ? LpspSpotifyTokens.spotifyGreen : LpspSpotifyTokens.spotifyTextSecondary)
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .preferredColorScheme(.dark)
    }
}

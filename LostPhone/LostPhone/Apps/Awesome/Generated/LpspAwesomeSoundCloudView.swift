import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/soundcloud
// Meliwat/awesome-ios-design-md/music/soundcloud/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeSoundCloudView: View {
    var body: some View {
        LpspSoundCloudShowroomRoot(store: LpspSoundCloudStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspSoundCloudFonts {
    static let scTitleLarge  = Font.system(size: 28, weight: .regular)
    static let scNowPlaying  = Font.system(size: 22, weight: .regular)
    static let scSection     = Font.system(size: 22, weight: .regular)
    static let scProfileName = Font.system(size: 20, weight: .regular)
    static let scTrackTitle  = Font.system(size: 16, weight: .regular)
    static let scCardTitle   = Font.system(size: 15, weight: .regular)
    static let scSubtitle    = Font.system(size: 14, weight: .regular)
    static let scBody        = Font.system(size: 15, weight: .regular)
    static let scComment     = Font.system(size: 14, weight: .regular)
    static let scMeta        = Font.system(size: 12, weight: .regular)
    static let scLabelUpper  = Font.system(size: 11, weight: .regular)
    static let scButton      = Font.system(size: 15, weight: .regular)
    static let scTab         = Font.system(size: 10, weight: .regular)
    static let scTimestamp   = Font.system(size: 11, weight: .regular)
    static func sc(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspSoundCloudTokens {
    static let scCanvas      = Color(red: 1.00, green: 1.00, blue: 1.00) // #FFFFFF
    static let scSurface     = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
    static let scDivider     = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
    static let scCanvasDark  = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let scSurfaceDark = Color(red: 0.149, green: 0.149, blue: 0.149) // #262626
    static let scDividerDark = Color(red: 0.20, green: 0.20, blue: 0.20)    // #333333
    static let scTextPrimary   = Color(red: 0.20, green: 0.20, blue: 0.20) // #333333
    static let scTextSecondary = Color(red: 0.60, green: 0.60, blue: 0.60) // #999999
    static let scTextTertiary  = Color(red: 0.749, green: 0.749, blue: 0.749) // #BFBFBF
    static let scOrange        = Color(red: 1.00, green: 0.333, blue: 0.00) // #FF5500
    static let scOrangeLight   = Color(red: 1.00, green: 0.467, blue: 0.00) // #FF7700
    static let scOrangePressed = Color(red: 0.902, green: 0.290, blue: 0.00) // #E64A00
    static let scErrorRed      = Color(red: 0.898, green: 0.282, blue: 0.302) // #E5484D
    static func scCanvasAdaptive(_ scheme: ColorScheme) -> Color { scheme == .dark ? scCanvasDark : scCanvas }
    static func scSurfaceAdaptive(_ scheme: ColorScheme) -> Color { scheme == .dark ? scSurfaceDark : scSurface }
    static func scTextAdaptive(_ scheme: ColorScheme) -> Color { scheme == .dark ? .white : scTextPrimary }
}







// System fallback if Interstate / Inter are unavailable


fileprivate struct LpspSoundCloudWaveformComment: Identifiable {
    let id = UUID()
    let position: Double      // 0...1 along the track
    let avatar: Image
    let text: String
}

fileprivate struct LpspSoundCloudWaveformScrubber: View {
    let samples: [CGFloat]        // 0...1 normalized amplitudes
    let progress: Double          // 0...1 current playback position
    let comments: [LpspSoundCloudWaveformComment]
    let onSeek: (Double) -> Void

    @State private var revealed: LpspSoundCloudWaveformComment?

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let barW: CGFloat = 1.5
            let gap: CGFloat = 1.0
            let count = max(1, Int(w / (barW + gap)))

            ZStack(alignment: .topLeading) {
                // Revealed inline comment
                if let c = revealed {
                    Text(c.text)
                        .font(LpspSoundCloudFonts.scComment)
                        .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                        .padding(.horizontal, 10).padding(.vertical, 6)
                        .background(Capsule().fill(LpspSoundCloudTokens.scSurface))
                        .offset(x: min(max(0, CGFloat(c.position) * w - 60), w - 120), y: -34)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                // Bars
                HStack(alignment: .center, spacing: gap) {
                    ForEach(0..<count, id: \.self) { i in
                        let amp = samples.isEmpty ? 0.3 : samples[i * samples.count / count]
                        let played = Double(i) / Double(count) <= progress
                        Capsule()
                            .fill(played ? LpspSoundCloudTokens.scOrange : LpspSoundCloudTokens.scOrangeLight.opacity(0.45))
                            .frame(width: barW, height: max(3, amp * 56))
                    }
                }
                .frame(height: 64, alignment: .center)

                // Playhead
                Rectangle()
                    .fill(LpspSoundCloudTokens.scTextPrimary)
                    .frame(width: 1, height: 64)
                    .offset(x: CGFloat(progress) * w)

                // Inline comment avatars on the baseline
                ForEach(comments) { c in
                    c.avatar
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(LpspSoundCloudTokens.scCanvas, lineWidth: 1.5))
                        .offset(x: CGFloat(c.position) * w - 10, y: 52)
                        .onAppear {
                            // reveal as the playhead sweeps past
                        }
                }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { v in
                        let p = min(1, max(0, v.location.x / w))
                        onSeek(p)
                        UISelectionFeedbackGenerator().selectionChanged()
                        if let hit = comments.min(by: { abs($0.position - p) < abs($1.position - p) }),
                           abs(hit.position - p) < 0.03 {
                            withAnimation(.easeOut(duration: 0.2)) { revealed = hit }
                        }
                    }
            )
        }
        .frame(height: 64)
    }
}

fileprivate struct LpspSoundCloudSCPlayButton: View {
    let isPlaying: Bool
    var size: CGFloat = 64
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: size * 0.4, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: size, height: size)
                .background(Circle().fill(LpspSoundCloudTokens.scOrange))
                .shadow(color: LpspSoundCloudTokens.scOrange.opacity(0.32), radius: 20, y: 6)
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: isPlaying)
        .buttonStyle(LpspSoundCloudSCPressable(pressedScale: 0.93))
    }
}

fileprivate struct LpspSoundCloudSCPressable: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspSoundCloudSCPill: View {
    let title: String
    var style: LpspSoundCloudStyle = .filled
    let action: () -> Void
    enum LpspSoundCloudStyle { case filled, outline }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(style == .filled ? LpspSoundCloudFonts.scButton : LpspSoundCloudFonts.scSubtitle)
                .foregroundStyle(style == .filled ? .white : LpspSoundCloudTokens.scTextPrimary)
                .padding(.vertical, 9)
                .padding(.horizontal, style == .filled ? 24 : 20)
                .background(RoundedRectangle(cornerRadius: 4).fill(style == .filled ? LpspSoundCloudTokens.scOrange : .clear))
                .overlay(RoundedRectangle(cornerRadius: 4).strokeBorder(style == .outline ? LpspSoundCloudTokens.scTextSecondary : .clear, lineWidth: 1))
        }
        .buttonStyle(LpspSoundCloudSCPressable())
    }
}

fileprivate struct LpspSoundCloudSCTrackRow<Artwork: View>: View {
    let title: String
    let uploader: String
    let artwork: Artwork
    let samples: [CGFloat]
    let progress: Double
    let isPlaying: Bool

    var body: some View {
        HStack(spacing: 12) {
            artwork
                .frame(width: 56, height: 56)
                .clipShape(RoundedRectangle(cornerRadius: 4))

            VStack(alignment: .leading, spacing: 2) {
                Text(uploader).font(LpspSoundCloudFonts.scSubtitle).foregroundStyle(LpspSoundCloudTokens.scTextSecondary).lineLimit(1)
                Text(title)
                    .font(LpspSoundCloudFonts.scTrackTitle)
                    .foregroundStyle(isPlaying ? LpspSoundCloudTokens.scOrange : LpspSoundCloudTokens.scTextPrimary)
                    .lineLimit(1)
            }

            Spacer(minLength: 8)

            LpspSoundCloudWaveformScrubber(samples: samples, progress: progress, comments: [], onSeek: { _ in })
                .frame(width: 110, height: 28)
                .allowsHitTesting(false)

            Image(systemName: "ellipsis")
                .font(.system(size: 20))
                .foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspSoundCloudSCNowPlaying: View {
    let title: String
    let uploader: String
    let artwork: Image
    let samples: [CGFloat]
    @Binding var progress: Double
    let comments: [LpspSoundCloudWaveformComment]
    @State private var isPlaying = true

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            artwork
                .resizable().aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 300)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .shadow(color: .black.opacity(0.18), radius: 32, y: 12)

            VStack(spacing: 4) {
                Text(title).font(LpspSoundCloudFonts.scNowPlaying).foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                Text(uploader).font(LpspSoundCloudFonts.scSubtitle).foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
            }

            LpspSoundCloudWaveformScrubber(samples: samples, progress: progress, comments: comments) { progress = $0 }
                .padding(.horizontal, 16)

            HStack(spacing: 28) {
                Image(systemName: "shuffle").foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
                Image(systemName: "backward.end.fill").foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                LpspSoundCloudSCPlayButton(isPlaying: isPlaying) { isPlaying.toggle() }
                Image(systemName: "forward.end.fill").foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                Image(systemName: "repeat").foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
            }
            .font(.system(size: 22))
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(LpspSoundCloudTokens.scCanvas.ignoresSafeArea())
    }
}



// MARK: - Showroom data & store

private enum LpspSoundCloudShowroomTab: String, CaseIterable, Identifiable {
    case home, search, library, upload, you

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        case .library: "Library"
        case .upload: "Upload"
        case .you: "You"
        }
    }

    var systemImage: String {
        switch self {
        case .home: "house.fill"
        case .search: "magnifyingglass"
        case .library: "play.square.stack"
        case .upload: "plus.circle.fill"
        case .you: "person.crop.circle"
        }
    }
}

private struct LpspSoundCloudTrack: Identifiable, Equatable {
    let id: String
    let title: String
    let artist: String
    let playlist: String
}

private enum LpspSoundCloudShowroomData {
    static let waveformSamples: [CGFloat] = [
        0.32, 0.48, 0.72, 0.55, 0.88, 0.64, 0.41, 0.76, 0.92, 0.58,
        0.35, 0.67, 0.84, 0.52, 0.73, 0.46, 0.91, 0.62, 0.38, 0.79,
        0.56, 0.83, 0.44, 0.70, 0.95, 0.51, 0.68, 0.37, 0.86, 0.59,
        0.74, 0.42, 0.81, 0.53, 0.69, 0.90, 0.47, 0.77, 0.61, 0.34,
    ]

    static let tracks: [LpspSoundCloudTrack] = [
        .init(id: "smoke", title: "Smoke & Static", artist: "novaa", playlist: "Late Night Uploads"),
        .init(id: "midnight", title: "Midnight Echo", artist: "kellan", playlist: "Late Night Uploads"),
        .init(id: "neon", title: "Neon Drift", artist: "pixelwave", playlist: "Indie Discoveries"),
    ]

    static let librarySections = ["Liked tracks", "Playlists", "Albums", "Artists"]

    static func waveformComments() -> [LpspSoundCloudWaveformComment] {
        [
            .init(position: 0.34, avatar: Image(systemName: "person.circle.fill"), text: "fire at this part"),
            .init(position: 0.71, avatar: Image(systemName: "person.circle.fill"), text: "vibes"),
        ]
    }
}

@MainActor
fileprivate final class LpspSoundCloudStore: ObservableObject {
    @Published var selectedTab: LpspSoundCloudShowroomTab = .home
    @Published var currentTrackId: String
    @Published var isPlaying = true
    @Published var progress = 0.58
    @Published var liked = true
    @Published var likeCount = 1200
    @Published var repostCount = 340
    @Published var commentCount = 88
    @Published var searchQuery = ""
    @Published var selectedLibrarySection = "Liked tracks"
    @Published var tracks = LpspSoundCloudShowroomData.tracks

    init(currentTrackId: String = "smoke") {
        self.currentTrackId = currentTrackId
    }

    var currentTrack: LpspSoundCloudTrack {
        tracks.first { $0.id == currentTrackId } ?? LpspSoundCloudShowroomData.tracks[0]
    }

    var elapsedLabel: String { "2:08" }

    var remainingLabel: String { "-1:24" }

    var likeCountLabel: String {
        likeCount >= 1000 ? String(format: "%.1fK", Double(likeCount) / 1000.0) : "\(likeCount)"
    }

    var filteredTracks: [LpspSoundCloudTrack] {
        guard !searchQuery.isEmpty else { return tracks }
        return tracks.filter {
            $0.title.localizedCaseInsensitiveContains(searchQuery)
                || $0.artist.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    func togglePlay() {
        isPlaying.toggle()
    }

    func toggleLike() {
        liked.toggle()
        likeCount += liked ? 1 : -1
    }

    func seek(to value: Double) {
        progress = min(1, max(0, value))
    }

    func playTrack(_ id: String) {
        currentTrackId = id
        progress = 0.12
        isPlaying = true
        selectedTab = .home
    }

    func skipNext() {
        guard let index = tracks.firstIndex(where: { $0.id == currentTrackId }) else { return }
        let next = tracks[(index + 1) % tracks.count]
        playTrack(next.id)
    }

    func skipPrevious() {
        guard let index = tracks.firstIndex(where: { $0.id == currentTrackId }) else { return }
        let previous = tracks[(index - 1 + tracks.count) % tracks.count]
        playTrack(previous.id)
    }

    func selectLibrarySection(_ section: String) {
        selectedLibrarySection = section
    }
}

// MARK: - Écrans showroom

private struct LpspSoundCloudShowroomRoot: View {
    @ObservedObject var store: LpspSoundCloudStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspSoundCloudShowroomTab.allCases) { tab in
                LpspSoundCloudShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .tint(LpspSoundCloudTokens.scOrange)
        .preferredColorScheme(.light)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            LpspSoundCloudMiniPlayerBar(store: store)
        }
    }
}

private struct LpspSoundCloudShowroomTabScreen: View {
    @ObservedObject var store: LpspSoundCloudStore
    let tab: LpspSoundCloudShowroomTab

    var body: some View {
        Group {
            switch tab {
            case .home:
                LpspSoundCloudHomeTabScreen(store: store)
            case .search:
                LpspSoundCloudSearchTabScreen(store: store)
            case .library:
                LpspSoundCloudLibraryTabScreen(store: store)
            case .upload:
                LpspSoundCloudUploadTabScreen()
            case .you:
                LpspSoundCloudYouTabScreen(store: store)
            }
        }
    }
}

private struct LpspSoundCloudHomeTabScreen: View {
    @ObservedObject var store: LpspSoundCloudStore

    var body: some View {
        VStack(spacing: 0) {
            LpspSoundCloudPlayerNavHeader(
                playlistLabel: "Playing from Playlist",
                playlistName: store.currentTrack.playlist
            )

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    LpspSoundCloudAlbumArtwork()
                        .padding(.horizontal, 24)

                    Text(store.currentTrack.title)
                        .font(LpspSoundCloudFonts.scNowPlaying.weight(.semibold))
                        .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)

                    Text(store.currentTrack.artist)
                        .font(LpspSoundCloudFonts.scSubtitle)
                        .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)

                    LpspSoundCloudWaveformScrubber(
                        samples: LpspSoundCloudShowroomData.waveformSamples,
                        progress: store.progress,
                        comments: LpspSoundCloudShowroomData.waveformComments(),
                        onSeek: { store.seek(to: $0) }
                    )
                    .padding(.horizontal, 16)

                    HStack {
                        Text(store.elapsedLabel)
                        Spacer()
                        Text(store.remainingLabel)
                    }
                    .font(LpspSoundCloudFonts.scSubtitle)
                    .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                    .padding(.horizontal, 16)

                    LpspSoundCloudTransportRow(store: store)
                        .padding(.horizontal, 14)

                    LpspSoundCloudActionBar(store: store)
                        .padding(.horizontal, 14)
                }
                .padding(.vertical, 8)
                .padding(.bottom, 8)
            }
        }
        .background(LpspSoundCloudTokens.scCanvas.ignoresSafeArea())
    }
}

private struct LpspSoundCloudPlayerNavHeader: View {
    let playlistLabel: String
    let playlistName: String

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text(playlistLabel)
                    .font(LpspSoundCloudFonts.scLabelUpper.weight(.bold))
                    .foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
                Text(playlistName)
                    .font(LpspSoundCloudFonts.scMeta.weight(.bold))
                    .foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
            }
            Spacer()
            Text("⌄")
                .font(.system(size: 20))
                .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
        }
        .padding(.horizontal, 14)
        .padding(.top, 8)
        .padding(.bottom, 6)
    }
}

private struct LpspSoundCloudAlbumArtwork: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.3, green: 0.2, blue: 0.5),
                        Color(red: 0.1, green: 0.1, blue: 0.2),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .aspectRatio(1, contentMode: .fit)
            .shadow(color: .black.opacity(0.18), radius: 32, y: 12)
    }
}

private struct LpspSoundCloudTransportRow: View {
    @ObservedObject var store: LpspSoundCloudStore

    var body: some View {
        HStack(spacing: 28) {
            Image(systemName: "shuffle")
                .foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
            Button { store.skipPrevious() } label: {
                Image(systemName: "backward.end.fill")
                    .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
            }
            LpspSoundCloudSCPlayButton(isPlaying: store.isPlaying, size: 64) {
                store.togglePlay()
            }
            Button { store.skipNext() } label: {
                Image(systemName: "forward.end.fill")
                    .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
            }
            Image(systemName: "repeat")
                .foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
        }
        .font(.system(size: 22))
        .buttonStyle(.plain)
    }
}

private struct LpspSoundCloudActionBar: View {
    @ObservedObject var store: LpspSoundCloudStore

    var body: some View {
        HStack(spacing: 0) {
            Button { store.toggleLike() } label: {
                LpspSoundCloudActionItem(
                    systemImage: store.liked ? "heart.fill" : "heart",
                    label: store.likeCountLabel,
                    highlighted: store.liked
                )
            }

            LpspSoundCloudActionItem(systemImage: "arrow.2.squarepath", label: "\(store.repostCount)")
            LpspSoundCloudActionItem(systemImage: "bubble.left", label: "\(store.commentCount)")
            LpspSoundCloudActionItem(systemImage: "square.and.arrow.up", label: nil)
            LpspSoundCloudActionItem(systemImage: "ellipsis", label: nil)
        }
        .frame(height: 44)
        .buttonStyle(.plain)
    }
}

private struct LpspSoundCloudActionItem: View {
    let systemImage: String
    let label: String?
    var highlighted = false

    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: systemImage)
                .font(.system(size: 18, weight: .semibold))
            if let label {
                Text(label)
                    .font(LpspSoundCloudFonts.scMeta)
            }
        }
        .foregroundStyle(highlighted ? LpspSoundCloudTokens.scOrange : LpspSoundCloudTokens.scTextPrimary)
        .frame(maxWidth: .infinity)
    }
}

private struct LpspSoundCloudMiniPlayerBar: View {
    @ObservedObject var store: LpspSoundCloudStore

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(LpspSoundCloudTokens.scDivider)
                    Rectangle()
                        .fill(LpspSoundCloudTokens.scOrange)
                        .frame(width: geo.size.width * store.progress)
                }
            }
            .frame(height: 2)

            HStack(spacing: 12) {
                LpspSoundCloudAlbumArtwork()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                VStack(alignment: .leading, spacing: 2) {
                    Text(store.currentTrack.title)
                        .font(LpspSoundCloudFonts.scCardTitle.weight(.semibold))
                        .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                        .lineLimit(1)
                    Text(store.currentTrack.artist)
                        .font(LpspSoundCloudFonts.scTimestamp)
                        .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                        .lineLimit(1)
                }

                Spacer()

                Button { store.togglePlay() } label: {
                    Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(LpspSoundCloudTokens.scCanvas)
        }
    }
}

private struct LpspSoundCloudSearchTabScreen: View {
    @ObservedObject var store: LpspSoundCloudStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
                    TextField("Artists, tracks, or podcasts", text: $store.searchQuery)
                        .font(LpspSoundCloudFonts.scBody)
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspSoundCloudTokens.scSurface)
                )
                .padding(16)

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(store.filteredTracks) { track in
                            Button {
                                store.playTrack(track.id)
                            } label: {
                                LpspSoundCloudSCTrackRow(
                                    title: track.title,
                                    uploader: track.artist,
                                    artwork: LpspSoundCloudTrackArtwork(),
                                    samples: LpspSoundCloudShowroomData.waveformSamples,
                                    progress: store.currentTrackId == track.id ? store.progress : 0,
                                    isPlaying: store.currentTrackId == track.id && store.isPlaying
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .background(LpspSoundCloudTokens.scCanvas.ignoresSafeArea())
            .navigationTitle("Search")
        }
    }
}

private struct LpspSoundCloudLibraryTabScreen: View {
    @ObservedObject var store: LpspSoundCloudStore

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(LpspSoundCloudShowroomData.librarySections, id: \.self) { section in
                        Button {
                            store.selectLibrarySection(section)
                        } label: {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LpspSoundCloudTokens.scOrange.opacity(0.2))
                                    .frame(width: 48, height: 48)
                                    .overlay {
                                        Image(systemName: "music.note")
                                            .foregroundStyle(LpspSoundCloudTokens.scOrange)
                                    }
                                Text(section)
                                    .font(LpspSoundCloudFonts.scBody)
                                    .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                                Spacer()
                                if store.selectedLibrarySection == section {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(LpspSoundCloudTokens.scOrange)
                                }
                            }
                        }
                    }
                }

                Section(store.selectedLibrarySection) {
                    ForEach(store.tracks) { track in
                        Button {
                            store.playTrack(track.id)
                        } label: {
                            LpspSoundCloudSCTrackRow(
                                title: track.title,
                                uploader: track.artist,
                                artwork: LpspSoundCloudTrackArtwork(),
                                samples: LpspSoundCloudShowroomData.waveformSamples,
                                progress: store.currentTrackId == track.id ? store.progress : 0,
                                isPlaying: store.currentTrackId == track.id && store.isPlaying
                            )
                        }
                        .buttonStyle(.plain)
                        .listRowInsets(EdgeInsets())
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Library")
        }
    }
}

private struct LpspSoundCloudUploadTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(LpspSoundCloudTokens.scOrange)
                Text("Share your sound")
                    .font(LpspSoundCloudFonts.scSection.weight(.semibold))
                    .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)
                Text("Upload tracks, set visibility, and reach listeners worldwide.")
                    .font(LpspSoundCloudFonts.scBody)
                    .foregroundStyle(LpspSoundCloudTokens.scTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                LpspSoundCloudSCPill(title: "Choose file", style: .filled) {}
                    .padding(.horizontal, 24)
                Spacer()
            }
            .background(LpspSoundCloudTokens.scCanvas.ignoresSafeArea())
            .navigationTitle("Upload")
        }
    }
}

private struct LpspSoundCloudYouTabScreen: View {
    @ObservedObject var store: LpspSoundCloudStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [LpspSoundCloudTokens.scOrange, LpspSoundCloudTokens.scOrangeLight],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 84, height: 84)
                        .overlay {
                            Text("A")
                                .font(.title.weight(.bold))
                                .foregroundStyle(.white)
                        }

                    Text("Alex Mercer")
                        .font(LpspSoundCloudFonts.scProfileName.weight(.semibold))
                        .foregroundStyle(LpspSoundCloudTokens.scTextPrimary)

                    Text("128 followers · 42 tracks")
                        .font(LpspSoundCloudFonts.scMeta)
                        .foregroundStyle(LpspSoundCloudTokens.scTextSecondary)

                    LpspSoundCloudSCPill(title: "Edit profile", style: .outline) {}
                        .padding(.horizontal, 24)

                    VStack(spacing: 0) {
                        ForEach(store.tracks) { track in
                            Button {
                                store.playTrack(track.id)
                            } label: {
                                LpspSoundCloudSCTrackRow(
                                    title: track.title,
                                    uploader: track.artist,
                                    artwork: LpspSoundCloudTrackArtwork(),
                                    samples: LpspSoundCloudShowroomData.waveformSamples,
                                    progress: store.currentTrackId == track.id ? store.progress : 0,
                                    isPlaying: store.currentTrackId == track.id && store.isPlaying
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.vertical, 24)
            }
            .background(LpspSoundCloudTokens.scCanvas.ignoresSafeArea())
            .navigationTitle("You")
        }
    }
}

private struct LpspSoundCloudTrackArtwork: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.3, green: 0.2, blue: 0.5),
                        Color(red: 0.1, green: 0.1, blue: 0.2),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}


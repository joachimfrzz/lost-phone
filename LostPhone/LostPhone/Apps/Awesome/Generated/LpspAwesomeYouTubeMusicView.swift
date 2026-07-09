import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/youtube-music
// Meliwat/awesome-ios-design-md/music/youtube-music/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeYouTubeMusicView: View {
    var body: some View {
        LpspYouTubeMusicShowroomRoot(store: LpspYouTubeMusicStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspYouTubeMusicTokens {
    // MARK: - Canvas & Surfaces (dark — the only mode)
    static let ytmCanvas      = Color(red: 0.012, green: 0.012, blue: 0.012) // #030303
    static let ytmSurface1    = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
    static let ytmSurface2    = Color(red: 0.153, green: 0.153, blue: 0.153) // #272727
    static let ytmMiniSurface = Color(red: 0.157, green: 0.157, blue: 0.157) // #282828
    static let ytmChipBg      = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
    static let ytmDivider     = Color(red: 0.188, green: 0.188, blue: 0.188) // #303030

    // MARK: - Brand
    static let ytmRed         = Color(red: 1.0,   green: 0.0,   blue: 0.0)   // #FF0000
    static let ytmRedPressed  = Color(red: 0.8,   green: 0.0,   blue: 0.0)   // #CC0000
    static let ytmActionWhite = Color.white                                    // #FFFFFF

    // MARK: - Text
    static let ytmTextPrimary   = Color.white                                  // #FFFFFF
    static let ytmTextSecondary = Color(red: 0.667, green: 0.667, blue: 0.667) // #AAAAAA
    static let ytmTextTertiary  = Color(red: 0.443, green: 0.443, blue: 0.443) // #717171

    // MARK: - Semantic
    static let ytmSuccess     = Color(red: 0.169, green: 0.651, blue: 0.251) // #2BA640
    static let ytmError       = Color(red: 1.0,   green: 0.306, blue: 0.271) // #FF4E45
    static let ytmTabBar      = Color(red: 0.039, green: 0.039, blue: 0.039) // #0A0A0A
}

private enum LpspYouTubeMusicFonts {
    static func ytm(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let face: String = {
            switch weight {
            case .black:    return "Roboto-Black"
            case .bold:     return "Roboto-Bold"
            case .medium:   return "Roboto-Medium"
            default:        return "Roboto-Regular"
            }
        }()
        return Font.custom(face, size: size)
    }

    static let ytmScreenTitle = Font.system(size: 32, weight: .regular)
    static let ytmNowPlaying  = Font.system(size: 26, weight: .regular)
    static let ytmSection     = Font.system(size: 22, weight: .regular)
    static let ytmCardHeader  = Font.system(size: 18, weight: .regular)
    static let ytmBody        = Font.system(size: 16, weight: .regular)
    static let ytmRowTitle    = Font.system(size: 15, weight: .regular)
    static let ytmSubtitle    = Font.system(size: 14, weight: .regular)
    static let ytmToggle      = Font.system(size: 12, weight: .regular)
    static let ytmChip        = Font.system(size: 13, weight: .regular)
    static let ytmTimestamp   = Font.system(size: 11, weight: .regular)
    static let ytmEyebrow     = Font.system(size: 10, weight: .regular)
    static let ytmTab         = Font.system(size: 10, weight: .regular)
    static let ytmButton      = Font.system(size: 15, weight: .regular)
}

fileprivate enum LpspYouTubeMusicPlayMode { case song, video }

fileprivate struct LpspYouTubeMusicNowPlayingView: View {
    let artworkURL: String
    let track: String
    let artist: String
    @State private var progress: Double = 0.42
    @State private var scrubbing = false
    @State private var mode: LpspYouTubeMusicPlayMode = .song

    var body: some View {
        ZStack {
            // Art-derived blurred backdrop glow
            AsyncImage(url: URL(string: artworkURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: { LpspYouTubeMusicTokens.ytmCanvas }
            .scaleEffect(1.4)
            .blur(radius: 40)
            .opacity(0.85)
            .overlay(
                LinearGradient(colors: [.clear, LpspYouTubeMusicTokens.ytmCanvas],
                               startPoint: .center, endPoint: .bottom)
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                AsyncImage(url: URL(string: artworkURL)) { img in
                    img.resizable().scaledToFill()
                } placeholder: { LpspYouTubeMusicTokens.ytmSurface1 }
                .frame(width: 232, height: 232)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .black.opacity(0.7), radius: 30, y: 24)
                .padding(.top, 26)

                LpspYouTubeMusicSongVideoToggle(mode: $mode).padding(.top, 22)

                VStack(alignment: .leading, spacing: 4) {
                    Text(track).font(LpspYouTubeMusicFonts.ytmNowPlaying).foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                    Text(artist).font(LpspYouTubeMusicFonts.ytmSubtitle).foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24).padding(.top, 22)

                LpspYouTubeMusicScrubber(progress: $progress, scrubbing: $scrubbing)
                    .padding(.horizontal, 24).padding(.top, 20)

                LpspYouTubeMusicTransportControls().padding(.top, 14)
                Spacer()
            }
        }
    }

    private var topBar: some View {
        HStack {
            Image(systemName: "chevron.down").font(.system(size: 22))
            Spacer()
            Text("FROM YOUR LIBRARY")
                .font(.system(size: 11, weight: .medium))
                .tracking(0.6)
                .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
            Spacer()
            Image(systemName: "ellipsis").font(.system(size: 22))
        }
        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
        .padding(.horizontal, 20).padding(.top, 6)
    }
}

fileprivate struct LpspYouTubeMusicSongVideoToggle: View {
    @Binding var mode: LpspYouTubeMusicPlayMode

    var body: some View {
        HStack(spacing: 6) {
            segment("Song", active: mode == .song) { mode = .song }
            segment("Video", active: mode == .video) { mode = .video }
        }
        .padding(4)
        .background(Color.white.opacity(0.08))
        .clipShape(Capsule())
    }

    private func segment(_ label: String, active: Bool, _ tap: @escaping () -> Void) -> some View {
        Text(label)
            .font(LpspYouTubeMusicFonts.ytmToggle)
            .tracking(0.2)
            .foregroundStyle(active ? LpspYouTubeMusicTokens.ytmCanvas : LpspYouTubeMusicTokens.ytmTextSecondary)
            .padding(.vertical, 7).padding(.horizontal, 18)
            .background(active ? LpspYouTubeMusicTokens.ytmActionWhite : Color.clear)
            .clipShape(Capsule())
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.2)) { tap() }
            }
            .sensoryFeedback(.impact(weight: .light), trigger: active)
    }
}

fileprivate struct LpspYouTubeMusicScrubber: View {
    @Binding var progress: Double
    @Binding var scrubbing: Bool

    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geo in
                let w = geo.size.width
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.white.opacity(0.22)).frame(height: 3)
                    Capsule()
                        .fill(scrubbing ? LpspYouTubeMusicTokens.ytmRed : LpspYouTubeMusicTokens.ytmActionWhite)
                        .frame(width: max(0, w * progress), height: 3)
                    Circle()
                        .fill(scrubbing ? LpspYouTubeMusicTokens.ytmRed : LpspYouTubeMusicTokens.ytmActionWhite)
                        .frame(width: scrubbing ? 16 : 12, height: scrubbing ? 16 : 12)
                        .background(
                            Circle()
                                .fill(LpspYouTubeMusicTokens.ytmRed.opacity(scrubbing ? 0.18 : 0))
                                .frame(width: 28, height: 28)
                        )
                        .offset(x: w * progress - (scrubbing ? 8 : 6))
                }
                .frame(height: 16)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { v in
                            scrubbing = true
                            progress = min(1, max(0, v.location.x / w))
                        }
                        .onEnded { _ in
                            withAnimation(.easeOut(duration: 0.15)) { scrubbing = false }
                        }
                )
                .sensoryFeedback(.impact(weight: .light), trigger: scrubbing)
            }
            .frame(height: 16)

            HStack {
                Text("1:48").font(LpspYouTubeMusicFonts.ytmTimestamp).monospacedDigit()
                Spacer()
                Text("-2:34").font(LpspYouTubeMusicFonts.ytmTimestamp).monospacedDigit()
            }
            .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
        }
    }
}

fileprivate struct LpspYouTubeMusicTransportControls: View {
    @State private var playing = true

    var body: some View {
        HStack {
            Image(systemName: "backward.end.fill").font(.system(size: 22))
            Spacer()
            Image(systemName: "backward.fill").font(.system(size: 26))
            Spacer()
            Button {
                playing.toggle()
            } label: {
                ZStack {
                    Circle().fill(LpspYouTubeMusicTokens.ytmActionWhite).frame(width: 64, height: 64)
                    Image(systemName: playing ? "pause.fill" : "play.fill")
                        .font(.system(size: 26))
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmCanvas) // black glyph on white
                }
            }
            .buttonStyle(.plain)
            Spacer()
            Image(systemName: "forward.fill").font(.system(size: 26))
            Spacer()
            Image(systemName: "forward.end.fill").font(.system(size: 22))
        }
        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
        .padding(.horizontal, 32)
    }
}

fileprivate struct LpspYouTubeMusicUpNextShelf: View {
    struct LpspYouTubeMusicQueueItem: Identifiable { let id = UUID(); let title: String; let artist: String }
    let items: [LpspYouTubeMusicQueueItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("UP NEXT")
                    .font(LpspYouTubeMusicFonts.ytmEyebrow).tracking(0.6)
                    .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                Spacer()
                Image(systemName: "list.bullet")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
            }
            .padding(16)

            ForEach(items) { item in
                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.title).font(LpspYouTubeMusicFonts.ytmRowTitle).foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                        Text(item.artist).font(LpspYouTubeMusicFonts.ytmSubtitle).foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                    }
                    Spacer()
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 18))
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextTertiary)
                }
                .padding(.horizontal, 16).padding(.vertical, 8)
            }
        }
        .background(LpspYouTubeMusicTokens.ytmCanvas)
        .overlay(Rectangle().fill(Color.white.opacity(0.12)).frame(height: 0.5), alignment: .top)
    }
}

fileprivate struct LpspYouTubeMusicMiniPlayer: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Midnight City").font(.system(size: 13, weight: .medium)).foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                    Text("M83").font(.system(size: 11)).foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                }
                Spacer()
                Image(systemName: "pause.fill").font(.system(size: 22)).foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                Image(systemName: "forward.fill").font(.system(size: 22)).foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
            }
            .padding(.horizontal, 12).padding(.vertical, 8)
            Rectangle().fill(LpspYouTubeMusicTokens.ytmActionWhite).frame(height: 2)
        }
        .background(LpspYouTubeMusicTokens.ytmMiniSurface)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


fileprivate struct LpspYouTubeMusicYTMTheme: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LpspYouTubeMusicTokens.ytmCanvas)
            .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
            .preferredColorScheme(.dark) // YT Music is dark-only on iOS
    }
}

fileprivate extension View {
    func ytmTheme() -> some View { modifier(LpspYouTubeMusicYTMTheme()) }
}

// MARK: - Showroom data & store

private enum LpspYouTubeMusicShowroomTab: String, CaseIterable, Identifiable {
    case home, samples, explore, library

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .samples: "Samples"
        case .explore: "Explore"
        case .library: "Library"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .samples: "record.circle"
        case .explore: "magnifyingglass"
        case .library: "books.vertical.fill"
        }
    }
}

private struct LpspYouTubeMusicTrack: Identifiable, Equatable {
    let id: String
    let title: String
    let artist: String
    let album: String
    let artworkColors: [Color]
}

private enum LpspYouTubeMusicShowroomData {
    static let midnightCity = LpspYouTubeMusicTrack(
        id: "midnight-city",
        title: "Midnight City",
        artist: "M83",
        album: "Hurry Up, We're Dreaming",
        artworkColors: [
            Color(red: 0.35, green: 0.18, blue: 0.72),
            Color(red: 0.12, green: 0.42, blue: 0.88),
        ]
    )

    static let reckoner = LpspYouTubeMusicTrack(
        id: "reckoner",
        title: "Reckoner",
        artist: "Radiohead",
        album: "In Rainbows",
        artworkColors: [
            Color(red: 0.82, green: 0.42, blue: 0.18),
            Color(red: 0.55, green: 0.18, blue: 0.22),
        ]
    )

    static let queue: [LpspYouTubeMusicTrack] = [
        midnightCity,
        reckoner,
        LpspYouTubeMusicTrack(
            id: "wait",
            title: "Wait",
            artist: "M83",
            album: "Hurry Up, We're Dreaming",
            artworkColors: [Color(red: 0.22, green: 0.28, blue: 0.62), Color(red: 0.48, green: 0.22, blue: 0.58)]
        ),
        LpspYouTubeMusicTrack(
            id: "starlight",
            title: "Starlight",
            artist: "M83",
            album: "Saturday Night, Sunday Morning",
            artworkColors: [Color(red: 0.18, green: 0.52, blue: 0.72), Color(red: 0.08, green: 0.28, blue: 0.48)]
        ),
    ]

    static let sampleMixes = ["Your Mix 1", "Your Mix 2", "Discover Mix", "New Release Mix"]

    static let exploreCategories = ["New releases", "Charts", "Moods & genres", "Podcasts"]

    static let librarySections = ["Liked songs", "Playlists", "Albums", "Artists", "Downloads"]
}

@MainActor
fileprivate final class LpspYouTubeMusicStore: ObservableObject {
    @Published var selectedTab: LpspYouTubeMusicShowroomTab = .home
    @Published var currentTrack: LpspYouTubeMusicTrack = LpspYouTubeMusicShowroomData.midnightCity
    @Published var tracks: [LpspYouTubeMusicTrack] = LpspYouTubeMusicShowroomData.queue
    @Published var isPlaying = true
    @Published var progress = 0.417
    @Published var isScrubbing = false
    @Published var playMode: LpspYouTubeMusicPlayMode = .song
    @Published var searchQuery = ""
    @Published var selectedLibrarySection = LpspYouTubeMusicShowroomData.librarySections[0]

    var elapsedLabel: String { "1:48" }

    var remainingLabel: String { "-2:34" }

    var upNextTrack: LpspYouTubeMusicTrack? {
        guard let index = tracks.firstIndex(of: currentTrack) else { return nil }
        return tracks[(index + 1) % tracks.count]
    }

    func togglePlay() {
        isPlaying.toggle()
    }

    func setPlayMode(_ mode: LpspYouTubeMusicPlayMode) {
        playMode = mode
    }

    func seek(to value: Double) {
        progress = min(1, max(0, value))
    }

    func setScrubbing(_ value: Bool) {
        isScrubbing = value
    }

    func playTrack(_ track: LpspYouTubeMusicTrack) {
        currentTrack = track
        progress = 0.12
        isPlaying = true
        selectedTab = .home
    }

    func skipNext() {
        guard let index = tracks.firstIndex(of: currentTrack) else { return }
        currentTrack = tracks[(index + 1) % tracks.count]
        progress = 0.12
        isPlaying = true
    }

    func skipPrevious() {
        guard let index = tracks.firstIndex(of: currentTrack) else { return }
        currentTrack = tracks[(index - 1 + tracks.count) % tracks.count]
        progress = 0.12
        isPlaying = true
    }

    func selectLibrarySection(_ section: String) {
        selectedLibrarySection = section
    }
}

// MARK: - Écrans showroom

private struct LpspYouTubeMusicShowroomRoot: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspYouTubeMusicSpectrHomeTabScreen(store: store)
                case .samples:
                    LpspYouTubeMusicSamplesTabScreen(store: store)
                case .explore:
                    LpspYouTubeMusicExploreTabScreen(store: store)
                case .library:
                    LpspYouTubeMusicLibraryTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspYouTubeMusicLabeledTabBar(store: store)
        }
        .background(LpspYouTubeMusicTokens.ytmCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspYouTubeMusicLabeledTabBar: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        HStack {
            ForEach(LpspYouTubeMusicShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspYouTubeMusicFonts.ytmTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspYouTubeMusicTokens.ytmActionWhite
                            : LpspYouTubeMusicTokens.ytmTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspYouTubeMusicTokens.ytmTabBar
                .overlay(
                    Rectangle()
                        .fill(LpspYouTubeMusicTokens.ytmDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspYouTubeMusicSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        ZStack {
            LinearGradient(
                colors: store.currentTrack.artworkColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .scaleEffect(1.4)
            .blur(radius: 40)
            .opacity(0.85)
            .overlay(
                LinearGradient(
                    colors: [.clear, LpspYouTubeMusicTokens.ytmCanvas],
                    startPoint: .center,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                LpspYouTubeMusicSpectrTopBar()

                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: store.currentTrack.artworkColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 232, height: 232)
                    .shadow(color: .black.opacity(0.7), radius: 30, y: 24)
                    .padding(.top, 26)

                LpspYouTubeMusicShowroomSongVideoToggle(store: store)
                    .padding(.top, 22)

                VStack(alignment: .leading, spacing: 4) {
                    Text(store.currentTrack.title)
                        .font(LpspYouTubeMusicFonts.ytmNowPlaying.weight(.semibold))
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                    Text("\(store.currentTrack.artist) · \(store.currentTrack.album)")
                        .font(LpspYouTubeMusicFonts.ytmSubtitle)
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 22)

                LpspYouTubeMusicShowroomScrubber(store: store)
                    .padding(.horizontal, 24)
                    .padding(.top, 20)

                LpspYouTubeMusicShowroomTransportControls(store: store)
                    .padding(.top, 14)

                if let upNext = store.upNextTrack {
                    LpspYouTubeMusicShowroomUpNextRow(track: upNext) {
                        store.skipNext()
                    }
                    .padding(.top, 18)
                }

                Spacer(minLength: 0)
            }
        }
    }
}

private struct LpspYouTubeMusicSpectrTopBar: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.down")
                .font(.system(size: 22))
            Spacer()
            Text("FROM YOUR LIBRARY")
                .font(.system(size: 11, weight: .medium))
                .tracking(0.6)
                .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
            Spacer()
            Image(systemName: "ellipsis")
                .font(.system(size: 22))
        }
        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
        .padding(.horizontal, 20)
        .padding(.top, 6)
    }
}

private struct LpspYouTubeMusicShowroomSongVideoToggle: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        LpspYouTubeMusicSongVideoToggle(
            mode: Binding(
                get: { store.playMode },
                set: { store.setPlayMode($0) }
            )
        )
    }
}

private struct LpspYouTubeMusicShowroomScrubber: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        LpspYouTubeMusicScrubber(
            progress: Binding(
                get: { store.progress },
                set: { store.seek(to: $0) }
            ),
            scrubbing: Binding(
                get: { store.isScrubbing },
                set: { store.setScrubbing($0) }
            )
        )
    }
}

private struct LpspYouTubeMusicShowroomTransportControls: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        HStack {
            Image(systemName: "backward.end.fill")
                .font(.system(size: 22))
            Spacer()
            Button(action: { store.skipPrevious() }) {
                Image(systemName: "backward.fill")
                    .font(.system(size: 26))
            }
            .buttonStyle(.plain)
            Spacer()
            Button(action: { store.togglePlay() }) {
                ZStack {
                    Circle()
                        .fill(LpspYouTubeMusicTokens.ytmActionWhite)
                        .frame(width: 64, height: 64)
                    Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 26))
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmCanvas)
                }
            }
            .buttonStyle(.plain)
            Spacer()
            Button(action: { store.skipNext() }) {
                Image(systemName: "forward.fill")
                    .font(.system(size: 26))
            }
            .buttonStyle(.plain)
            Spacer()
            Image(systemName: "forward.end.fill")
                .font(.system(size: 22))
        }
        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
        .padding(.horizontal, 32)
    }
}

private struct LpspYouTubeMusicShowroomUpNextRow: View {
    let track: LpspYouTubeMusicTrack
    let onPlayNext: () -> Void

    var body: some View {
        Button(action: onPlayNext) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            colors: track.artworkColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 48, height: 48)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Up Next")
                        .font(LpspYouTubeMusicFonts.ytmEyebrow.weight(.bold))
                        .tracking(0.6)
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                    Text("\(track.title) — \(track.artist)")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 18))
                    .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(LpspYouTubeMusicTokens.ytmSurface1.opacity(0.55))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspYouTubeMusicSamplesTabScreen: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Quick picks")
                    .font(LpspYouTubeMusicFonts.ytmScreenTitle.weight(.bold))
                    .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 12
                ) {
                    ForEach(Array(LpspYouTubeMusicShowroomData.sampleMixes.enumerated()), id: \.offset) { index, mix in
                        Button {
                            store.playTrack(LpspYouTubeMusicShowroomData.queue[index % LpspYouTubeMusicShowroomData.queue.count])
                        } label: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    LinearGradient(
                                        colors: LpspYouTubeMusicShowroomData.queue[index % LpspYouTubeMusicShowroomData.queue.count].artworkColors,
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(height: 120)
                                .overlay(alignment: .bottomLeading) {
                                    Text(mix)
                                        .font(LpspYouTubeMusicFonts.ytmCardHeader.weight(.semibold))
                                        .foregroundStyle(.white)
                                        .padding(10)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)

                Text("Queue")
                    .font(LpspYouTubeMusicFonts.ytmSection.weight(.semibold))
                    .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                    .padding(.horizontal, 16)

                LpspYouTubeMusicShowroomTrackList(store: store)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspYouTubeMusicExploreTabScreen: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                    TextField("Artists, songs, or podcasts", text: $store.searchQuery)
                        .font(LpspYouTubeMusicFonts.ytmBody)
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                        .tint(LpspYouTubeMusicTokens.ytmRed)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspYouTubeMusicTokens.ytmSurface1)
                )
                .padding(.horizontal, 16)
                .padding(.top, 8)

                ForEach(LpspYouTubeMusicShowroomData.exploreCategories, id: \.self) { category in
                    Button {
                        store.searchQuery = category
                    } label: {
                        HStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(LpspYouTubeMusicTokens.ytmChipBg)
                                .frame(width: 48, height: 48)
                                .overlay {
                                    Image(systemName: "music.note")
                                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                                }
                            Text(category)
                                .font(LpspYouTubeMusicFonts.ytmRowTitle)
                                .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(LpspYouTubeMusicTokens.ytmTextTertiary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }

                if !store.searchQuery.isEmpty {
                    Text("Results")
                        .font(LpspYouTubeMusicFonts.ytmSection.weight(.semibold))
                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                    LpspYouTubeMusicShowroomTrackList(store: store)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspYouTubeMusicLibraryTabScreen: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Library")
                    .font(LpspYouTubeMusicFonts.ytmScreenTitle.weight(.bold))
                    .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                ForEach(LpspYouTubeMusicShowroomData.librarySections, id: \.self) { section in
                    Button {
                        store.selectLibrarySection(section)
                    } label: {
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    store.selectedLibrarySection == section
                                        ? LpspYouTubeMusicTokens.ytmActionWhite.opacity(0.18)
                                        : LpspYouTubeMusicTokens.ytmChipBg
                                )
                                .frame(width: 48, height: 48)
                                .overlay {
                                    Image(systemName: libraryIcon(for: section))
                                        .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                                }
                            Text(section)
                                .font(LpspYouTubeMusicFonts.ytmBody)
                                .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                            Spacer()
                            if store.selectedLibrarySection == section {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(LpspYouTubeMusicTokens.ytmActionWhite)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(.plain)
                }

                if store.selectedLibrarySection == "Liked songs" {
                    LpspYouTubeMusicShowroomTrackList(store: store)
                        .padding(.top, 8)
                }
            }
            .padding(.bottom, 16)
        }
    }

    private func libraryIcon(for section: String) -> String {
        switch section {
        case "Liked songs": "heart.fill"
        case "Playlists": "music.note.list"
        case "Albums": "square.stack.fill"
        case "Artists": "person.fill"
        case "Downloads": "arrow.down.circle.fill"
        default: "music.note"
        }
    }
}

private struct LpspYouTubeMusicShowroomTrackList: View {
    @ObservedObject var store: LpspYouTubeMusicStore

    var body: some View {
        VStack(spacing: 0) {
            ForEach(filteredTracks) { track in
                Button {
                    store.playTrack(track)
                } label: {
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    colors: track.artworkColors,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 48, height: 48)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(track.title)
                                .font(LpspYouTubeMusicFonts.ytmRowTitle.weight(.medium))
                                .foregroundStyle(LpspYouTubeMusicTokens.ytmTextPrimary)
                            Text(track.artist)
                                .font(LpspYouTubeMusicFonts.ytmSubtitle)
                                .foregroundStyle(LpspYouTubeMusicTokens.ytmTextSecondary)
                        }

                        Spacer()

                        if store.currentTrack.id == track.id && store.isPlaying {
                            Image(systemName: "waveform")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(LpspYouTubeMusicTokens.ytmActionWhite)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var filteredTracks: [LpspYouTubeMusicTrack] {
        guard !store.searchQuery.isEmpty else { return store.tracks }
        return store.tracks.filter {
            $0.title.localizedCaseInsensitiveContains(store.searchQuery)
                || $0.artist.localizedCaseInsensitiveContains(store.searchQuery)
                || $0.album.localizedCaseInsensitiveContains(store.searchQuery)
        }
    }
}


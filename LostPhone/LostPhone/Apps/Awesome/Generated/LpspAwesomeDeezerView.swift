import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/deezer
// Meliwat/awesome-ios-design-md/music/deezer/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDeezerView: View {
    var body: some View {
        LpspDeezerShowroomRoot(store: LpspDeezerStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspDeezerTokens {
    // MARK: - Canvas & Surfaces (Dark — the only real theme)
    static let dzCanvas      = Color(red: 0.059, green: 0.051, blue: 0.075) // #0F0D13
    static let dzSurface1    = Color(red: 0.098, green: 0.086, blue: 0.122) // #19161F
    static let dzSurface2    = Color(red: 0.133, green: 0.118, blue: 0.169) // #221E2B
    static let dzDivider     = Color(red: 0.165, green: 0.149, blue: 0.200) // #2A2633

    // MARK: - Text
    static let dzTextPrimary   = Color.white                                  // #FFFFFF
    static let dzTextSecondary = Color(red: 0.635, green: 0.612, blue: 0.690) // #A29CB0
    static let dzTextTertiary  = Color(red: 0.431, green: 0.408, blue: 0.502) // #6E6880

    // MARK: - Brand (the gradient + its endpoints)
    static let dzPurple     = Color(red: 0.635, green: 0.220, blue: 1.000) // #A238FF
    static let dzPink       = Color(red: 1.000, green: 0.000, blue: 0.573) // #FF0092
    static let dzPurpleDeep = Color(red: 0.486, green: 0.157, blue: 0.769) // #7C28C4
    static let dzPinkPress  = Color(red: 0.839, green: 0.000, blue: 0.475) // #D60079
    static let dzArtMagenta = Color(red: 0.780, green: 0.122, blue: 0.557) // #C71F8E

    // MARK: - Semantic
    static let dzSuccess = Color(red: 0.118, green: 0.843, blue: 0.376) // #1ED760
    static let dzError   = Color(red: 1.000, green: 0.302, blue: 0.369) // #FF4D5E
    static let dzWarning = Color(red: 1.000, green: 0.690, blue: 0.180) // #FFB02E
}

// The Deezer signature gradient — used ONLY on alive elements
private enum LpspDeezerGradients {
    static let dzFlow = LinearGradient(
        colors: [LpspDeezerTokens.dzPurple, LpspDeezerTokens.dzPink],
        startPoint: .leading, endPoint: .trailing
    )
    static let dzPlayButton = LinearGradient(
        colors: [LpspDeezerTokens.dzPurple, LpspDeezerTokens.dzPink],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let dzArtwork = LinearGradient(
        stops: [
            .init(color: LpspDeezerTokens.dzPurple,     location: 0.0),
            .init(color: LpspDeezerTokens.dzArtMagenta, location: 0.45),
            .init(color: LpspDeezerTokens.dzPink,       location: 1.0),
        ],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}

fileprivate enum LpspDeezerDZFont {
    // Swap "DeezerSans" → "Inter" if the brand face isn't bundled.
    static let brand = "DeezerSans"
    static let read  = "Inter"
}

private enum LpspDeezerFonts {
    static func dzBrand(_ size: CGFloat, _ weight: Font.Weight = .bold) -> Font {
        Font.custom(LpspDeezerDZFont.brand, size: size).weight(weight)
    }
    static func dzRead(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        Font.custom(LpspDeezerDZFont.read, size: size).weight(weight)
    }

    static let dzScreenTitle    = Font.system(size: 32, weight: .regular)
    static let dzNowPlaying     = Font.system(size: 26, weight: .regular)
    static let dzSection        = Font.system(size: 22, weight: .regular)
    static let dzSubhead        = Font.system(size: 18, weight: .regular)
    static let dzBody           = Font.system(size: 16, weight: .regular)
    static let dzRowTitle       = Font.system(size: 15, weight: .regular)
    static let dzNowArtist      = Font.system(size: 15, weight: .regular)
    static let dzMeta           = Font.system(size: 14, weight: .regular)
    static let dzOverline       = Font.system(size: 12, weight: .regular)
    static let dzScrubTime      = Font.system(size: 11, weight: .regular)
    static let dzTabLabel       = Font.system(size: 10, weight: .regular)
    static let dzButton         = Font.system(size: 16, weight: .regular)
    static let dzChip           = Font.system(size: 13, weight: .regular)
}

// Tabular numerals for all timestamps
fileprivate extension View {
    func dzTabularNumbers() -> some View { self.monospacedDigit() }
}

fileprivate struct LpspDeezerFlowArtwork: View {
    var isPlaying: Bool = true
    @State private var drift = false

    // static design heights; replace with live FFT data when playing
    private let bars: [CGFloat] = [0.38,0.62,0.88,0.54,0.76,0.42,0.68,0.92,0.50,0.72,0.34,0.60]

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                LpspDeezerGradients.dzArtwork
                    .overlay(
                        RadialGradient(colors: [.white.opacity(0.22), .clear],
                                       center: .init(x: 0.78, y: 0.22),
                                       startRadius: 0, endRadius: geo.size.width * 0.6)
                    )
                    .overlay(
                        RadialGradient(colors: [LpspDeezerTokens.dzPurpleDeep.opacity(0.55), .clear],
                                       center: .init(x: 0.20, y: 0.82),
                                       startRadius: 0, endRadius: geo.size.width * 0.6)
                    )
                    .hueRotation(.degrees(drift ? 8 : 0))

                // FLOW badge
                HStack(spacing: 7) {
                    Image(systemName: "bolt.fill").font(.system(size: 12)).foregroundStyle(.white)
                    Text("FLOW").font(LpspDeezerFonts.dzOverline).tracking(0.4).foregroundStyle(.white)
                }
                .padding(.vertical, 7).padding(.leading, 11).padding(.trailing, 13)
                .background(LpspDeezerTokens.dzCanvas.opacity(0.55))
                .clipShape(Capsule())
                .background(.ultraThinMaterial, in: Capsule())
                .padding(16)

                // Embedded equalizer
                HStack(alignment: .bottom, spacing: 4) {
                    ForEach(bars.indices, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.white.opacity(0.62))
                            .frame(height: geo.size.height * 0.46 * bars[i])
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.horizontal, 18).padding(.bottom, 22)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: LpspDeezerTokens.dzPurple.opacity(0.55), radius: 24, x: 0, y: 24)
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            guard isPlaying else { return }
            withAnimation(.easeInOut(duration: 12).repeatForever(autoreverses: true)) { drift = true }
        }
    }
}

fileprivate struct LpspDeezerPlayButton: View {
    @Binding var isPlaying: Bool

    var body: some View {
        Button {
            isPlaying.toggle()
        } label: {
            ZStack {
                Circle().fill(LpspDeezerGradients.dzPlayButton)
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.white)
                    .offset(x: isPlaying ? 0 : 2)   // optical centering for ▶
            }
            .frame(width: 68, height: 68)
            .shadow(color: LpspDeezerTokens.dzPink.opacity(0.6), radius: 14, x: 0, y: 12)
        }
        .buttonStyle(LpspDeezerPressScale())
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isPlaying)
    }
}

fileprivate struct LpspDeezerPressScale: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

fileprivate struct LpspDeezerGradientScrubber: View {
    @Binding var progress: Double      // 0...1
    let elapsed: String                // "1:48"
    let remaining: String              // "-2:31"
    @State private var dragging = false

    var body: some View {
        VStack(spacing: 9) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(LpspDeezerTokens.dzSurface2).frame(height: 4)
                    Capsule().fill(LpspDeezerGradients.dzFlow)
                        .frame(width: geo.size.width * progress, height: 4)
                    Circle().fill(.white)
                        .frame(width: dragging ? 17 : 13, height: dragging ? 17 : 13)
                        .shadow(color: .black.opacity(0.5), radius: 3, y: 2)
                        .offset(x: geo.size.width * progress - (dragging ? 8.5 : 6.5))
                }
                .frame(height: 17)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { v in
                            dragging = true
                            progress = min(max(0, v.location.x / geo.size.width), 1)
                        }
                        .onEnded { _ in dragging = false }
                )
            }
            .frame(height: 17)

            HStack {
                Text(elapsed).font(LpspDeezerFonts.dzScrubTime).dzTabularNumbers()
                Spacer()
                Text(remaining).font(LpspDeezerFonts.dzScrubTime).dzTabularNumbers()
            }
            .foregroundStyle(LpspDeezerTokens.dzTextSecondary)
        }
    }
}

fileprivate struct LpspDeezerSongRow: View {
    let title: String
    let artist: String
    let isPlaying: Bool
    var artworkGradient: LinearGradient = LpspDeezerGradients.dzArtwork

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 6).fill(artworkGradient)
                .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(LpspDeezerFonts.dzRowTitle)
                    .foregroundStyle(isPlaying ? LpspDeezerTokens.dzPink : LpspDeezerTokens.dzTextPrimary)
                    .animation(.easeOut(duration: 0.18), value: isPlaying)
                Text(artist).font(LpspDeezerFonts.dzMeta).foregroundStyle(LpspDeezerTokens.dzTextSecondary)
            }
            Spacer()

            if isPlaying {
                LpspDeezerEqualizerMark()
            } else {
                Image(systemName: "ellipsis").font(.system(size: 18))
                    .foregroundStyle(LpspDeezerTokens.dzTextSecondary)
            }
        }
        .frame(height: 64)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspDeezerEqualizerMark: View {
    @State private var animate = false
    private let base: [CGFloat] = [7, 14, 5, 11]
    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            ForEach(base.indices, id: \.self) { i in
                RoundedRectangle(cornerRadius: 1)
                    .fill(LpspDeezerTokens.dzPink)
                    .frame(width: 3, height: animate ? base[i] : base[(i + 1) % base.count])
            }
        }
        .frame(height: 16)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) { animate = true }
        }
    }
}

fileprivate struct LpspDeezerNowPlayingTopBar: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.down").font(.system(size: 22, weight: .bold))
                .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
            Spacer()
            VStack(spacing: 2) {
                Text("FLOW · YOUR MIX").font(LpspDeezerFonts.dzOverline).tracking(0.4)
                    .foregroundStyle(LpspDeezerTokens.dzTextSecondary)
                Text("Made for you").font(LpspDeezerFonts.dzRead(13, .bold))
                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
            }
            Spacer()
            Image(systemName: "ellipsis").font(.system(size: 22, weight: .bold))
                .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
        }
    }
}

fileprivate struct LpspDeezerPrimaryButton: View {
    let title: String
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill").font(.system(size: 14, weight: .bold))
                Text(title).font(LpspDeezerFonts.dzButton)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 14).padding(.horizontal, 30)
            .background(LpspDeezerGradients.dzFlow, in: Capsule())
        }
        .buttonStyle(LpspDeezerPressScale())
    }
}


fileprivate struct LpspDeezerDZTheme: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LpspDeezerTokens.dzCanvas)
            .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
            .preferredColorScheme(.dark)   // force dark — Deezer's identity
    }
}
fileprivate extension View { func dzTheme() -> some View { modifier(LpspDeezerDZTheme()) } }

// MARK: - Showroom data & store

private enum LpspDeezerShowroomTab: String, CaseIterable, Identifiable {
    case home, search, music, profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        case .music: "Music"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .search: "magnifyingglass"
        case .music: "music.note"
        case .profile: "person.fill"
        }
    }
}

private struct LpspDeezerTrack: Identifiable, Equatable {
    let id: String
    let title: String
    let artist: String
    let album: String
}

private enum LpspDeezerShowroomData {
    static let flowTrack = LpspDeezerTrack(
        id: "midnight-city",
        title: "Midnight City",
        artist: "M83",
        album: "Hurry Up, We're Dreaming"
    )

    static let queue: [LpspDeezerTrack] = [
        flowTrack,
        LpspDeezerTrack(id: "wait", title: "Wait", artist: "M83", album: "Hurry Up, We're Dreaming"),
        LpspDeezerTrack(id: "starlight", title: "Starlight", artist: "M83", album: "Saturday Night, Sunday Morning"),
        LpspDeezerTrack(id: "outrun", title: "Outrun", artist: "Kavinsky", album: "OutRun"),
    ]

    static let searchSuggestions = ["Flow mixes", "Synthwave", "M83", "Chill electronic"]

    static let playlists = ["Flow · Your Mix", "Chill Vibes", "Night Drive", "Discover Weekly"]
}

@MainActor
fileprivate final class LpspDeezerStore: ObservableObject {
    @Published var selectedTab: LpspDeezerShowroomTab = .home
    @Published var currentTrack: LpspDeezerTrack = LpspDeezerShowroomData.flowTrack
    @Published var tracks: [LpspDeezerTrack] = LpspDeezerShowroomData.queue
    @Published var isPlaying = true
    @Published var progress = 0.417
    @Published var isLiked = false
    @Published var searchQuery = ""
    @Published var shuffleEnabled = false
    @Published var repeatEnabled = false

    var elapsedLabel: String { "1:48" }

    var remainingLabel: String { "-2:31" }

    func togglePlay() {
        isPlaying.toggle()
    }

    func toggleLike() {
        isLiked.toggle()
    }

    func seek(to value: Double) {
        progress = min(1, max(0, value))
    }

    func toggleShuffle() {
        shuffleEnabled.toggle()
    }

    func toggleRepeat() {
        repeatEnabled.toggle()
    }

    func playTrack(_ track: LpspDeezerTrack) {
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
}

// MARK: - Écrans showroom

private struct LpspDeezerShowroomRoot: View {
    @ObservedObject var store: LpspDeezerStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspDeezerFlowNowPlayingScreen(store: store)
                case .search:
                    LpspDeezerSearchTabScreen(store: store)
                case .music:
                    LpspDeezerMusicTabScreen(store: store)
                case .profile:
                    LpspDeezerProfileTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspDeezerLabeledTabBar(store: store)
        }
        .background(LpspDeezerTokens.dzCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspDeezerLabeledTabBar: View {
    @ObservedObject var store: LpspDeezerStore

    var body: some View {
        HStack {
            ForEach(LpspDeezerShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspDeezerFonts.dzTabLabel.weight(store.selectedTab == tab ? .semibold : .regular))
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspDeezerTokens.dzTextPrimary
                            : LpspDeezerTokens.dzTextTertiary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspDeezerTokens.dzCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspDeezerTokens.dzDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspDeezerFlowNowPlayingScreen: View {
    @ObservedObject var store: LpspDeezerStore

    var body: some View {
        VStack(spacing: 0) {
            LpspDeezerSpectrTopBar()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    LpspDeezerFlowArtwork(isPlaying: store.isPlaying)
                        .padding(.horizontal, 16)

                    VStack(spacing: 16) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(store.currentTrack.title)
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)

                                Text("\(store.currentTrack.artist) · \(store.currentTrack.album)")
                                    .font(LpspDeezerFonts.dzNowArtist)
                                    .foregroundStyle(LpspDeezerTokens.dzTextSecondary)
                                    .lineLimit(2)
                            }

                            Spacer(minLength: 12)

                            Button {
                                store.toggleLike()
                            } label: {
                                Image(systemName: store.isLiked ? "heart.fill" : "heart")
                                    .font(.system(size: 24))
                                    .foregroundStyle(
                                        store.isLiked
                                            ? LpspDeezerTokens.dzPink
                                            : LpspDeezerTokens.dzTextSecondary
                                    )
                            }
                            .buttonStyle(.plain)
                        }

                        LpspDeezerGradientScrubber(
                            progress: $store.progress,
                            elapsed: store.elapsedLabel,
                            remaining: store.remainingLabel
                        )

                        LpspDeezerShowroomTransportRow(store: store)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 16)
            }
        }
    }
}

private struct LpspDeezerSpectrTopBar: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.down")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(LpspDeezerTokens.dzTextPrimary)

            Spacer()

            VStack(spacing: 2) {
                Text("Flow · Your Mix")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(LpspDeezerTokens.dzTextSecondary)
                Text("Made for you")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
            }

            Spacer()

            Image(systemName: "ellipsis")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

private struct LpspDeezerShowroomTransportRow: View {
    @ObservedObject var store: LpspDeezerStore

    var body: some View {
        HStack {
            Button(action: { store.toggleShuffle() }) {
                Image(systemName: "shuffle")
                    .font(.system(size: 20))
                    .foregroundStyle(
                        store.shuffleEnabled
                            ? LpspDeezerTokens.dzPink
                            : LpspDeezerTokens.dzTextTertiary
                    )
            }
            .frame(maxWidth: .infinity)

            Button(action: { store.skipPrevious() }) {
                Image(systemName: "backward.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
            }
            .frame(maxWidth: .infinity)

            LpspDeezerPlayButton(isPlaying: $store.isPlaying)
                .frame(maxWidth: .infinity)

            Button(action: { store.skipNext() }) {
                Image(systemName: "forward.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
            }
            .frame(maxWidth: .infinity)

            Button(action: { store.toggleRepeat() }) {
                Image(systemName: "repeat")
                    .font(.system(size: 20))
                    .foregroundStyle(
                        store.repeatEnabled
                            ? LpspDeezerTokens.dzPink
                            : LpspDeezerTokens.dzTextTertiary
                    )
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private struct LpspDeezerSearchTabScreen: View {
    @ObservedObject var store: LpspDeezerStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(LpspDeezerTokens.dzTextSecondary)
                TextField("Artists, tracks, podcasts", text: $store.searchQuery)
                    .font(LpspDeezerFonts.dzBody)
                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
                    .tint(LpspDeezerTokens.dzPink)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(LpspDeezerTokens.dzSurface1)
            )
            .padding(.horizontal, 16)
            .padding(.top, 8)

            List {
                Section("Browse") {
                    ForEach(LpspDeezerShowroomData.searchSuggestions, id: \.self) { term in
                        Button {
                            store.searchQuery = term
                        } label: {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(LpspDeezerTokens.dzTextTertiary)
                                Text(term)
                                    .font(LpspDeezerFonts.dzRowTitle)
                                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
                            }
                        }
                        .listRowBackground(LpspDeezerTokens.dzSurface1)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

private struct LpspDeezerMusicTabScreen: View {
    @ObservedObject var store: LpspDeezerStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Your music")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(LpspDeezerShowroomData.playlists, id: \.self) { playlist in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LpspDeezerGradients.dzArtwork)
                                .frame(width: 140, height: 140)
                                .overlay(alignment: .bottomLeading) {
                                    Text(playlist)
                                        .font(LpspDeezerFonts.dzChip.weight(.semibold))
                                        .foregroundStyle(.white)
                                        .padding(10)
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Text("Queue")
                    .font(LpspDeezerFonts.dzSection.weight(.semibold))
                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)
                    .padding(.horizontal, 16)

                VStack(spacing: 0) {
                    ForEach(store.tracks) { track in
                        Button {
                            store.playTrack(track)
                        } label: {
                            LpspDeezerSongRow(
                                title: track.title,
                                artist: track.artist,
                                isPlaying: store.currentTrack.id == track.id && store.isPlaying
                            )
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.vertical, 16)
        }
    }
}

private struct LpspDeezerProfileTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Circle()
                    .fill(LpspDeezerGradients.dzFlow)
                    .frame(width: 96, height: 96)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                    }

                Text("Your Deezer")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(LpspDeezerTokens.dzTextPrimary)

                Text("Free · Upgrade to Deezer Premium")
                    .font(LpspDeezerFonts.dzMeta)
                    .foregroundStyle(LpspDeezerTokens.dzTextSecondary)

                LpspDeezerPrimaryButton(title: "Go Premium") {}
                    .padding(.horizontal, 32)
            }
            .padding(.vertical, 32)
        }
    }
}



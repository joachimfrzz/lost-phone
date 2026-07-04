import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/music/youtube-music/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/youtube-music
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeYouTubeMusicView: View {
    var body: some View {
        LpspYouTubeMusicShowroomRoot()
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

fileprivate struct LpspYouTubeMusicNowPlayingView: View {
    let artworkURL: String
    let track: String
    let artist: String
    @State private var progress: Double = 0.42
    @State private var scrubbing = false
    @State private var mode: LpspYouTubeMusicPlayMode = .song

    enum LpspYouTubeMusicPlayMode { case song, video }

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
    @Binding var mode: LpspYouTubeMusicNowPlayingView.LpspYouTubeMusicPlayMode

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

// MARK: - Écrans showroom

private struct LpspYouTubeMusicShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspYouTubeMusicMusicHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspYouTubeMusicMusicHomeTabScreen()
                .tabItem { Label("Samples", systemImage: "rectangle.stack.fill") }
                .tag(1)
            LpspYouTubeMusicMusicHomeTabScreen()
                .tabItem { Label("Explore", systemImage: "magnifyingglass") }
                .tag(2)
            LpspYouTubeMusicMusicLibraryTabScreen()
                .tabItem { Label("Library", systemImage: "books.vertical.fill") }
                .tag(3)
        }
        .tint(LpspYouTubeMusicTokens.ytmActionWhite)
        .preferredColorScheme(.dark)
    }
}


private struct LpspYouTubeMusicGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspYouTubeMusicTokens.ytmActionWhite.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspYouTubeMusicTokens.ytmActionWhite))
                    VStack(alignment: .leading) {
                        Text("\(title) \(i + 1)").font(.system(size: 17, weight: .semibold))
                        Text("Contenu démo").font(.system(size: 14)).foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}


private enum LpspYouTubeMusicDemoTracks {
    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let artist: String
        let isPlaying: Bool
    }
    static let items: [Item] = [
        .init(title: "Blinding Lights", artist: "The Weeknd", isPlaying: true),
        .init(title: "As It Was", artist: "Harry Styles", isPlaying: false),
        .init(title: "Flowers", artist: "Miley Cyrus", isPlaying: false),
    ]
}
private struct LpspYouTubeMusicMusicHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Bonsoir").font(.system(size: 28, weight: .bold)).padding(.horizontal)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(0..<4, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 8).fill(LpspYouTubeMusicTokens.ytmActionWhite.opacity(0.15 + Double(i) * 0.05))
                                .frame(height: 100)
                                .overlay(alignment: .bottomLeading) {
                                    Text("Playlist \(i + 1)").font(.subheadline.bold()).padding(8)
                                }
                        }
                    }
                    .padding(.horizontal)
                    Text("Récemment joué").font(.headline).padding(.horizontal)

                    ForEach(0..<4, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.08))
                            .frame(height: 56)
                            .padding(.horizontal)
                    }

                }
            }
            .background(LpspYouTubeMusicTokens.ytmCanvas.ignoresSafeArea())
            .navigationTitle("")
        }
    }
}

private struct LpspYouTubeMusicMusicSearchTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                    Text("Artistes, titres ou podcasts").foregroundStyle(.secondary)
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
                .padding()
                Spacer()
            }
            .navigationTitle("Rechercher")
        }
    }
}

private struct LpspYouTubeMusicMusicLibraryTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Titres likés", "Playlists", "Albums", "Artistes"], id: \.self) { item in
                HStack {
                    RoundedRectangle(cornerRadius: 4).fill(LpspYouTubeMusicTokens.ytmActionWhite.opacity(0.2)).frame(width: 48, height: 48)
                    Text(item).font(.body)
                }
            }
            .navigationTitle("Bibliothèque")
        }
    }
}




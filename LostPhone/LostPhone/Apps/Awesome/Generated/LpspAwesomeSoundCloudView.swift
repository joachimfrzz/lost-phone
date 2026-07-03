import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/music/soundcloud/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/soundcloud
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeSoundCloudView: View {
    var body: some View {
        LpspSoundCloudShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspSoundCloudTokens {
    // MARK: - Canvas & Surfaces (Light)
    static let scCanvas      = Color(red: 1.00, green: 1.00, blue: 1.00) // #FFFFFF
    static let scSurface     = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
    static let scDivider     = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5

    // MARK: - Canvas & Surfaces (Dark)
    static let scCanvasDark  = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let scSurfaceDark = Color(red: 0.149, green: 0.149, blue: 0.149) // #262626
    static let scDividerDark = Color(red: 0.20, green: 0.20, blue: 0.20)    // #333333

    // MARK: - Text
    static let scTextPrimary   = Color(red: 0.20, green: 0.20, blue: 0.20) // #333333
    static let scTextSecondary = Color(red: 0.60, green: 0.60, blue: 0.60) // #999999
    static let scTextTertiary  = Color(red: 0.749, green: 0.749, blue: 0.749) // #BFBFBF

    // MARK: - Brand
    static let scOrange        = Color(red: 1.00, green: 0.333, blue: 0.00) // #FF5500
    static let scOrangeLight   = Color(red: 1.00, green: 0.467, blue: 0.00) // #FF7700
    static let scOrangePressed = Color(red: 0.902, green: 0.290, blue: 0.00) // #E64A00
    static let scErrorRed      = Color(red: 0.898, green: 0.282, blue: 0.302) // #E5484D
}

private enum LpspSoundCloudTokens {
    static func scCanvasAdaptive(_ scheme: ColorScheme) -> Color { scheme == .dark ? scCanvasDark : scCanvas }
    static func scSurfaceAdaptive(_ scheme: ColorScheme) -> Color { scheme == .dark ? scSurfaceDark : scSurface }
    static func scTextAdaptive(_ scheme: ColorScheme) -> Color { scheme == .dark ? .white : scTextPrimary }
}

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
}

// System fallback if Interstate / Inter are unavailable
private enum LpspSoundCloudFonts {
    static func sc(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private struct LpspSoundCloudWaveformComment: Identifiable {
    let id = UUID()
    let position: Double      // 0...1 along the track
    let avatar: Image
    let text: String
}

private struct LpspSoundCloudWaveformScrubber: View {
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
                        .overlay(Circle().strokeBorder(LpspSoundCloudTokens.scCanvas, lineWidth: 1.5))
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

private struct LpspSoundCloudSCPlayButton: View {
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

private struct LpspSoundCloudSCPressable: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

private struct LpspSoundCloudSCPill: View {
    let title: String
    var style: LpspSoundCloudStyle = .filled
    let action: () -> Void
    enum LpspSoundCloudStyle { case filled, outline }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(style == .filled ? LpspSoundCloudTokens.scButton : LpspSoundCloudTokens.scSubtitle)
                .foregroundStyle(style == .filled ? .white : LpspSoundCloudTokens.scTextPrimary)
                .padding(.vertical, 9)
                .padding(.horizontal, style == .filled ? 24 : 20)
                .background(RoundedRectangle(cornerRadius: 4).fill(style == .filled ? LpspSoundCloudTokens.scOrange : .clear))
                .overlay(RoundedRectangle(cornerRadius: 4).strokeBorder(style == .outline ? LpspSoundCloudTokens.scTextSecondary : .clear, lineWidth: 1))
        }
        .buttonStyle(LpspSoundCloudSCPressable())
    }
}

private struct LpspSoundCloudSCTrackRow: View {
    let title: String
    let uploader: String
    let artwork: Image
    let samples: [CGFloat]
    let progress: Double
    let isPlaying: Bool

    var body: some View {
        HStack(spacing: 12) {
            artwork
                .resizable().aspectRatio(1, contentMode: .fill)
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

private struct LpspSoundCloudSCNowPlaying: View {
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

private struct LpspSoundCloudRootTabView: View {
    @Environment(\.colorScheme) private var scheme
    init() {
        let a = UITabBarAppearance()
        a.configureWithTransparentBackground()
        a.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        UITabBar.appearance().standardAppearance = a
        UITabBar.appearance().scrollEdgeAppearance = a
    }
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            SearchView().tabItem { Label("Search", systemImage: "magnifyingglass") }
            LibraryView().tabItem { Label("Library", systemImage: "play.square.stack") }
            UploadView().tabItem { Label("Upload", systemImage: "arrow.up.circle.fill") }
            ProfileView().tabItem { Label("You", systemImage: "person.crop.circle") }
        }
        .tint(LpspSoundCloudTokens.scOrange) // active = orange
    }
}

// MARK: - Écrans showroom

private struct LpspSoundCloudShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspSoundCloudMusicHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspSoundCloudMusicSearchTabScreen()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
            LpspSoundCloudMusicLibraryTabScreen()
                .tabItem { Label("Library", systemImage: "play.square.stack") }
                .tag(2)
            LpspSoundCloudMusicHomeTabScreen()
                .tabItem { Label("Upload", systemImage: "arrow.up.circle.fill") }
                .tag(3)
            LpspSoundCloudMusicHomeTabScreen()
                .tabItem { Label("You", systemImage: "person.crop.circle") }
                .tag(4)
        }
        .tint(LpspSoundCloudTokens.scErrorRed)
        .preferredColorScheme(.dark)
    }
}


private struct LpspSoundCloudGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspSoundCloudTokens.scErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspSoundCloudTokens.scErrorRed))
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


private struct LpspSoundCloudMusicHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Bonsoir").font(.system(size: 28, weight: .bold)).padding(.horizontal)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(0..<4, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 8).fill(LpspSoundCloudTokens.scErrorRed.opacity(0.15 + Double(i) * 0.05))
                                .frame(height: 100)
                                .overlay(alignment: .bottomLeading) {
                                    Text("Playlist \(i + 1)").font(.subheadline.bold()).padding(8)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(LpspSoundCloudTokens.scCanvas.ignoresSafeArea())
            .navigationTitle("")
        }
    }
}

private struct LpspSoundCloudMusicSearchTabScreen: View {
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

private struct LpspSoundCloudMusicLibraryTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Titres likés", "Playlists", "Albums", "Artistes"], id: \.self) { item in
                HStack {
                    RoundedRectangle(cornerRadius: 4).fill(LpspSoundCloudTokens.scErrorRed.opacity(0.2)).frame(width: 48, height: 48)
                    Text(item).font(.body)
                }
            }
            .navigationTitle("Bibliothèque")
        }
    }
}



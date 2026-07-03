import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/music/audible/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/audible
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAudibleView: View {
    var body: some View {
        LpspAudibleShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspAudibleFonts {
    static let audTitleLarge = Font.system(size: 30, weight: .regular)
    static let audBookTitle  = Font.system(size: 26, weight: .regular)
    static let audSection    = Font.system(size: 22, weight: .regular)
    static let audCardTitle  = Font.system(size: 17, weight: .regular)
    static let audMiniTitle  = Font.system(size: 14, weight: .regular)
    static let audAuthor     = Font.system(size: 14, weight: .regular)
    static let audNarrator   = Font.system(size: 13, weight: .regular)
    static let audChapter    = Font.system(size: 16, weight: .regular)
    static let audBody       = Font.system(size: 15, weight: .regular)
    static let audCaptions   = Font.system(size: 18, weight: .regular)
    static let audMeta       = Font.system(size: 13, weight: .regular)
    static let audLabelUpper = Font.system(size: 11, weight: .regular)
    static let audButton     = Font.system(size: 16, weight: .regular)
    static let audButtonSec  = Font.system(size: 14, weight: .regular)
    static let audSpeed      = Font.system(size: 15, weight: .regular)
    static let audTab        = Font.system(size: 10, weight: .regular)
    static func audSerif(_ size: CGFloat) -> Font { .system(size: size, weight: .bold, design: .serif) }
    static func audSans(_ size: CGFloat, weight: Font.Weight = .regular) -> Font { .system(size: size, weight: weight, design: .default) }
}

private enum LpspAudibleTokens {
    // MARK: - Canvas & Surfaces
    static let audCanvas   = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let audSurface1 = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
    static let audSurface2 = Color(red: 0.204, green: 0.204, blue: 0.204) // #343434
    static let audDivider  = Color(red: 0.227, green: 0.227, blue: 0.227) // #3A3A3A

    // MARK: - Text
    static let audTextPrimary   = Color.white                                // #FFFFFF
    static let audTextSecondary = Color(red: 0.690, green: 0.690, blue: 0.690) // #B0B0B0
    static let audTextTertiary  = Color(red: 0.431, green: 0.431, blue: 0.431) // #6E6E6E

    // MARK: - Brand
    static let audOrange        = Color(red: 1.0,   green: 0.600, blue: 0.0)  // #FF9900
    static let audOrangePressed = Color(red: 0.902, green: 0.541, blue: 0.0)  // #E68A00
    static let audErrorRed      = Color(red: 0.898, green: 0.282, blue: 0.302) // #E5484D
}

extension ShapeStyle where Self == Color {
    static var audOrangeGlow: Color { Color(red: 1.0, green: 0.6, blue: 0.0).opacity(0.28) }
}





private struct LpspAudibleCoverProgressRing: View {
    let artwork: Image
    let progress: Double          // 0...1
    var size: CGFloat = 280
    var ring: CGFloat = 4

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.audDivider, lineWidth: ring)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.audOrange, style: StrokeStyle(lineWidth: ring, lineCap: .round))
                .rotationEffect(.degrees(-90))
            artwork
                .resizable().aspectRatio(1, contentMode: .fill)
                .frame(width: size - ring * 6, height: size - ring * 6)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.5), radius: 36, y: 14)
        }
        .frame(width: size, height: size)
    }
}

private struct LpspAudibleAudiblePlayButton: View {
    let isPlaying: Bool
    var size: CGFloat = 72
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: size * 0.44, weight: .bold))
                .foregroundStyle(Color.audCanvas) // dark glyph on orange
                .frame(width: size, height: size)
                .background(Circle().fill(Color.audOrange))
                .shadow(color: .audOrangeGlow, radius: 22, y: 6)
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: isPlaying)
        .buttonStyle(LpspAudibleAudPressable(pressedScale: 0.93))
    }
}

private struct LpspAudibleSkipButton: View {
    enum LpspAudibleDir { case back, forward }
    let dir: LpspAudibleDir
    let action: () -> Void
    @State private var flash = false

    var body: some View {
        Button {
            withAnimation(.easeOut(duration: 0.18)) { flash = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { flash = false }
            action()
        } label: {
            Image(systemName: dir == .back ? "gobackward.30" : "goforward.30")
                .font(.system(size: 30, weight: .regular))
                .foregroundStyle(flash ? Color.audOrange : .white)
                .frame(width: 44, height: 44)
        }
        .sensoryFeedback(.impact(weight: .light), trigger: flash)
        .buttonStyle(LpspAudibleAudPressable(pressedScale: 0.9))
    }
}

private struct LpspAudibleAudPressable: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

private struct LpspAudibleSpeedDialSheet: View {
    @Binding var speed: Double      // 0.5 ... 3.5
    private let presets: [Double] = [1.0, 1.25, 1.5, 2.0]

    var body: some View {
        VStack(spacing: 24) {
            Capsule().fill(Color.audTextTertiary).frame(width: 36, height: 4).padding(.top, 10)

            Text(String(format: "%.2f×", speed).replacingOccurrences(of: ".00", with: ".0"))
                .font(.custom("Inter-Bold", size: 22)).monospacedDigit()
                .foregroundStyle(Color.audOrange)
                .contentTransition(.numericText())

            Slider(value: $speed, in: 0.5...3.5, step: 0.05) { _ in }
                .tint(.audOrange)
                .onChange(of: speed) { _, new in
                    if (new * 4).rounded() == new * 4 { // .25 detent
                        UISelectionFeedbackGenerator().selectionChanged()
                    }
                }

            HStack(spacing: 10) {
                ForEach(presets, id: \.self) { p in
                    Button {
                        withAnimation(.snappy) { speed = p }
                    } label: {
                        Text(String(format: "%.2g×", p))
                            .font(LpspAudibleFonts.audSpeed)
                            .foregroundStyle(speed == p ? Color.audCanvas : .white)
                            .padding(.vertical, 8).padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(speed == p ? Color.audOrange : Color.audSurface2))
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .background(Color.audSurface1)
        .presentationDetents([.height(280)])
        .presentationCornerRadius(16)
    }
}

private struct LpspAudibleAudiblePlayer: View {
    let title: String
    let author: String
    let narrator: String
    let artwork: Image
    @State private var progress = 0.34
    @State private var isPlaying = true
    @State private var speed = 1.5
    @State private var showSpeed = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            LpspAudibleCoverProgressRing(artwork: artwork, progress: progress)

            VStack(spacing: 6) {
                Text(title).font(LpspAudibleFonts.audTitleLarge).foregroundStyle(.white).multilineTextAlignment(.center)
                Text(author).font(LpspAudibleFonts.audAuthor).foregroundStyle(.audTextSecondary)
                Text(narrator).font(LpspAudibleFonts.audNarrator).foregroundStyle(.audTextSecondary)
            }

            HStack(spacing: 36) {
                LpspAudibleSkipButton(dir: .back) { progress = max(0, progress - 0.01) }
                LpspAudibleAudiblePlayButton(isPlaying: isPlaying) { isPlaying.toggle() }
                LpspAudibleSkipButton(dir: .forward) { progress = min(1, progress + 0.01) }
            }

            Text("8 hrs 14 min left").font(LpspAudibleFonts.audMeta).foregroundStyle(.audTextSecondary).monospacedDigit()

            HStack(spacing: 24) {
                Button { showSpeed = true } label: {
                    Text(String(format: "%.2g×", speed)).font(LpspAudibleFonts.audSpeed).foregroundStyle(Color.audOrange)
                        .padding(.vertical, 8).padding(.horizontal, 14)
                        .background(Capsule().fill(Color.audSurface2))
                }
                Image(systemName: "moon.zzz").foregroundStyle(.audTextSecondary)
                Image(systemName: "bookmark").foregroundStyle(.audTextSecondary)
                Image(systemName: "list.bullet").foregroundStyle(.audTextSecondary)
                Image(systemName: "car").foregroundStyle(.audTextSecondary)
            }
            .font(.system(size: 22))
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(Color.audCanvas.ignoresSafeArea())
        .sheet(isPresented: $showSpeed) { LpspAudibleSpeedDialSheet(speed: $speed) }
    }
}

private struct LpspAudibleContinueRow: View {
    let title: String
    let author: String
    let remaining: String
    let artwork: Image
    let progress: Double

    var body: some View {
        HStack(spacing: 14) {
            LpspAudibleCoverProgressRing(artwork: artwork, progress: progress, size: 72, ring: 3)
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(LpspAudibleFonts.audCardTitle).foregroundStyle(.white).lineLimit(1)
                Text(author).font(.custom("Inter-Regular", size: 13)).foregroundStyle(.audTextSecondary).lineLimit(1)
                Text(remaining).font(.custom("Inter-Regular", size: 12)).foregroundStyle(.audTextSecondary)
            }
            Spacer()
            Image(systemName: "play.fill")
                .font(.system(size: 18, weight: .bold)).foregroundStyle(Color.audCanvas)
                .frame(width: 56, height: 56).background(Circle().fill(Color.audOrange))
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.audSurface1))
    }
}

private struct LpspAudibleChapterListSheet: View {
    let chapters: [(n: Int, title: String, dur: String, state: LpspAudibleChapterState)]
    enum LpspAudibleChapterState { case playing, finished, upcoming }

    var body: some View {
        VStack(spacing: 0) {
            Capsule().fill(Color.audTextTertiary).frame(width: 36, height: 4).padding(.vertical, 10)
            Text("Chapters").font(LpspAudibleFonts.audSection).foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 16).padding(.bottom, 8)
            ScrollView {
                ForEach(chapters, id: \.n) { c in
                    HStack(spacing: 12) {
                        if c.state == .playing {
                            Rectangle().fill(Color.audOrange).frame(width: 3, height: 28)
                        } else {
                            Color.clear.frame(width: 3, height: 28)
                        }
                        Text("\(c.n).").font(LpspAudibleFonts.audChapter).foregroundStyle(.audTextSecondary)
                        Text(c.title)
                            .font(LpspAudibleFonts.audChapter)
                            .foregroundStyle(c.state == .playing ? Color.audOrange : .white)
                        Spacer()
                        if c.state == .finished {
                            Image(systemName: "checkmark").font(.system(size: 12, weight: .bold)).foregroundStyle(Color.audOrange)
                        }
                        Text(c.dur).font(LpspAudibleFonts.audMeta).foregroundStyle(.audTextSecondary).monospacedDigit()
                    }
                    .padding(.horizontal, 16).frame(height: 56)
                    Divider().overlay(Color.audDivider)
                }
            }
        }
        .background(Color.audSurface1)
        .presentationDetents([.medium, .large])
        .presentationCornerRadius(16)
    }
}

private struct LpspAudibleCaptionsPanel: View {
    let line: String
    let activeWordIndex: Int
    var body: some View {
        let words = line.split(separator: " ").map(String.init)
        FlowLayout(spacing: 4) {
            ForEach(words.indices, id: \.self) { i in
                Text(words[i])
                    .font(LpspAudibleFonts.audCaptions)
                    .foregroundStyle(i == activeWordIndex ? .white : Color.audTextSecondary)
                    .animation(.easeOut(duration: 0.18), value: activeWordIndex)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.audSurface1))
    }
}
// FlowLayout: a simple wrapping Layout (omitted for brevity).

private struct LpspAudibleRootTabView: View {
    init() {
        let a = UITabBarAppearance()
        a.configureWithTransparentBackground()
        a.backgroundEffect = UIBlurEffect(style: .systemMaterialDark)
        a.backgroundColor = UIColor(Color.audCanvas).withAlphaComponent(0.96)
        UITabBar.appearance().standardAppearance = a
        UITabBar.appearance().scrollEdgeAppearance = a
    }
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            LibraryView().tabItem { Label("Library", systemImage: "books.vertical.fill") }
            DiscoverView().tabItem { Label("Discover", systemImage: "magnifyingglass") }
            ProfileView().tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
        .tint(.audOrange)
    }
}

// MARK: - Écrans showroom

private struct LpspAudibleShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspAudibleMusicHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspAudibleMusicLibraryTabScreen()
                .tabItem { Label("Library", systemImage: "books.vertical.fill") }
                .tag(1)
            LpspAudibleMusicHomeTabScreen()
                .tabItem { Label("Discover", systemImage: "magnifyingglass") }
                .tag(2)
            LpspAudibleMusicHomeTabScreen()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(3)
        }
        .tint(LpspAudibleTokens.audErrorRed)
        .preferredColorScheme(.dark)
    }
}


private struct LpspAudibleGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspAudibleTokens.audErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspAudibleTokens.audErrorRed))
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


private struct LpspAudibleMusicHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Bonsoir").font(.system(size: 28, weight: .bold)).padding(.horizontal)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(0..<4, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 8).fill(LpspAudibleTokens.audErrorRed.opacity(0.15 + Double(i) * 0.05))
                                .frame(height: 100)
                                .overlay(alignment: .bottomLeading) {
                                    Text("Playlist \(i + 1)").font(.subheadline.bold()).padding(8)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(LpspAudibleTokens.audCanvas.ignoresSafeArea())
            .navigationTitle("")
        }
    }
}

private struct LpspAudibleMusicSearchTabScreen: View {
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

private struct LpspAudibleMusicLibraryTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Titres likés", "Playlists", "Albums", "Artistes"], id: \.self) { item in
                HStack {
                    RoundedRectangle(cornerRadius: 4).fill(LpspAudibleTokens.audErrorRed.opacity(0.2)).frame(width: 48, height: 48)
                    Text(item).font(.body)
                }
            }
            .navigationTitle("Bibliothèque")
        }
    }
}



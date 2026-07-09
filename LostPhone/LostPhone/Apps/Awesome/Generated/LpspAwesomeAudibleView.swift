import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/audible
// Meliwat/awesome-ios-design-md/music/audible/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAudibleView: View {
    var body: some View {
        LpspAudibleShowroomRoot(store: LpspAudibleStore())
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
    static var audOrangeGlow: Color { Color(red: 1.0, green: 0.6, blue: 0.0).opacity(0.28) }
}







fileprivate struct LpspAudibleCoverProgressRing: View {
    let artwork: Image
    let progress: Double          // 0...1
    var size: CGFloat = 280
    var ring: CGFloat = 4

    var body: some View {
        ZStack {
            Circle()
                .stroke(LpspAudibleTokens.audDivider, lineWidth: ring)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(LpspAudibleTokens.audOrange, style: StrokeStyle(lineWidth: ring, lineCap: .round))
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

fileprivate struct LpspAudibleAudiblePlayButton: View {
    let isPlaying: Bool
    var size: CGFloat = 72
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: size * 0.44, weight: .bold))
                .foregroundStyle(LpspAudibleTokens.audCanvas) // dark glyph on orange
                .frame(width: size, height: size)
                .background(Circle().fill(LpspAudibleTokens.audOrange))
                .shadow(color: LpspAudibleTokens.audOrangeGlow, radius: 22, y: 6)
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: isPlaying)
        .buttonStyle(LpspAudibleAudPressable(pressedScale: 0.93))
    }
}

fileprivate struct LpspAudibleSkipButton: View {
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
                .foregroundStyle(flash ? LpspAudibleTokens.audOrange : .white)
                .frame(width: 44, height: 44)
        }
        .sensoryFeedback(.impact(weight: .light), trigger: flash)
        .buttonStyle(LpspAudibleAudPressable(pressedScale: 0.9))
    }
}

fileprivate struct LpspAudibleAudPressable: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

fileprivate struct LpspAudibleSpeedDialSheet: View {
    @Binding var speed: Double      // 0.5 ... 3.5
    private let presets: [Double] = [1.0, 1.25, 1.5, 2.0]

    var body: some View {
        VStack(spacing: 24) {
            Capsule().fill(LpspAudibleTokens.audTextTertiary).frame(width: 36, height: 4).padding(.top, 10)

            Text(String(format: "%.2f×", speed).replacingOccurrences(of: ".00", with: ".0"))
                .font(.custom("Inter-Bold", size: 22)).monospacedDigit()
                .foregroundStyle(LpspAudibleTokens.audOrange)
                .contentTransition(.numericText())

            Slider(value: $speed, in: 0.5...3.5, step: 0.05) { _ in }
                .tint(LpspAudibleTokens.audOrange)
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
                            .foregroundStyle(speed == p ? LpspAudibleTokens.audCanvas : .white)
                            .padding(.vertical, 8).padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(speed == p ? LpspAudibleTokens.audOrange : LpspAudibleTokens.audSurface2))
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .background(LpspAudibleTokens.audSurface1)
        .presentationDetents([.height(280)])
        .presentationCornerRadius(16)
    }
}

fileprivate struct LpspAudibleAudiblePlayer: View {
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
                Text(author).font(LpspAudibleFonts.audAuthor).foregroundStyle(LpspAudibleTokens.audTextSecondary)
                Text(narrator).font(LpspAudibleFonts.audNarrator).foregroundStyle(LpspAudibleTokens.audTextSecondary)
            }

            HStack(spacing: 36) {
                LpspAudibleSkipButton(dir: .back) { progress = max(0, progress - 0.01) }
                LpspAudibleAudiblePlayButton(isPlaying: isPlaying) { isPlaying.toggle() }
                LpspAudibleSkipButton(dir: .forward) { progress = min(1, progress + 0.01) }
            }

            Text("8 hrs 14 min left").font(LpspAudibleFonts.audMeta).foregroundStyle(LpspAudibleTokens.audTextSecondary).monospacedDigit()

            HStack(spacing: 24) {
                Button { showSpeed = true } label: {
                    Text(String(format: "%.2g×", speed)).font(LpspAudibleFonts.audSpeed).foregroundStyle(LpspAudibleTokens.audOrange)
                        .padding(.vertical, 8).padding(.horizontal, 14)
                        .background(Capsule().fill(LpspAudibleTokens.audSurface2))
                }
                Image(systemName: "moon.zzz").foregroundStyle(LpspAudibleTokens.audTextSecondary)
                Image(systemName: "bookmark").foregroundStyle(LpspAudibleTokens.audTextSecondary)
                Image(systemName: "list.bullet").foregroundStyle(LpspAudibleTokens.audTextSecondary)
                Image(systemName: "car").foregroundStyle(LpspAudibleTokens.audTextSecondary)
            }
            .font(.system(size: 22))
            Spacer()
        }
        .padding(.horizontal, 24)
        .background(LpspAudibleTokens.audCanvas.ignoresSafeArea())
        .sheet(isPresented: $showSpeed) { LpspAudibleSpeedDialSheet(speed: $speed) }
    }
}

fileprivate struct LpspAudibleContinueRow: View {
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
                Text(author).font(.custom("Inter-Regular", size: 13)).foregroundStyle(LpspAudibleTokens.audTextSecondary).lineLimit(1)
                Text(remaining).font(.custom("Inter-Regular", size: 12)).foregroundStyle(LpspAudibleTokens.audTextSecondary)
            }
            Spacer()
            Image(systemName: "play.fill")
                .font(.system(size: 18, weight: .bold)).foregroundStyle(LpspAudibleTokens.audCanvas)
                .frame(width: 56, height: 56).background(Circle().fill(LpspAudibleTokens.audOrange))
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 12).fill(LpspAudibleTokens.audSurface1))
    }
}

fileprivate struct LpspAudibleChapterListSheet: View {
    let chapters: [(n: Int, title: String, dur: String, state: LpspAudibleChapterState)]
    enum LpspAudibleChapterState { case playing, finished, upcoming }

    var body: some View {
        VStack(spacing: 0) {
            Capsule().fill(LpspAudibleTokens.audTextTertiary).frame(width: 36, height: 4).padding(.vertical, 10)
            Text("Chapters").font(LpspAudibleFonts.audSection).foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 16).padding(.bottom, 8)
            ScrollView {
                ForEach(chapters, id: \.n) { c in
                    HStack(spacing: 12) {
                        if c.state == .playing {
                            Rectangle().fill(LpspAudibleTokens.audOrange).frame(width: 3, height: 28)
                        } else {
                            Color.clear.frame(width: 3, height: 28)
                        }
                        Text("\(c.n).").font(LpspAudibleFonts.audChapter).foregroundStyle(LpspAudibleTokens.audTextSecondary)
                        Text(c.title)
                            .font(LpspAudibleFonts.audChapter)
                            .foregroundStyle(c.state == .playing ? LpspAudibleTokens.audOrange : .white)
                        Spacer()
                        if c.state == .finished {
                            Image(systemName: "checkmark").font(.system(size: 12, weight: .bold)).foregroundStyle(LpspAudibleTokens.audOrange)
                        }
                        Text(c.dur).font(LpspAudibleFonts.audMeta).foregroundStyle(LpspAudibleTokens.audTextSecondary).monospacedDigit()
                    }
                    .padding(.horizontal, 16).frame(height: 56)
                    Divider().overlay(LpspAudibleTokens.audDivider)
                }
            }
        }
        .background(LpspAudibleTokens.audSurface1)
        .presentationDetents([.medium, .large])
        .presentationCornerRadius(16)
    }
}

fileprivate struct LpspAudibleCaptionsPanel: View {
    let line: String
    let activeWordIndex: Int
    var body: some View {
        let words = line.split(separator: " ").map(String.init)
        LpspAudibleFlowLayout(spacing: 4) {
            ForEach(words.indices, id: \.self) { i in
                Text(words[i])
                    .font(LpspAudibleFonts.audCaptions)
                    .foregroundStyle(i == activeWordIndex ? .white : LpspAudibleTokens.audTextSecondary)
                    .animation(.easeOut(duration: 0.18), value: activeWordIndex)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 12).fill(LpspAudibleTokens.audSurface1))
    }
}
// LpspAudibleFlowLayout: a simple wrapping Layout (omitted for brevity).

fileprivate struct LpspAudibleFlowLayout: Layout {
    var spacing: CGFloat = 8
    init(spacing: CGFloat = 8) { self.spacing = spacing }
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions(by: CGSize(width: 300, height: 40))
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            subview.place(at: CGPoint(x: x, y: bounds.minY), proposal: .unspecified)
            x += size.width + spacing
        }
    }
}


// MARK: - Showroom data & store

private enum LpspAudibleShowroomTab: String, CaseIterable, Identifiable {
    case home, library, discover, profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .library: "Library"
        case .discover: "Discover"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .library: "books.vertical.fill"
        case .discover: "magnifyingglass"
        case .profile: "person.crop.circle.fill"
        }
    }
}

private struct LpspAudibleBook: Identifiable, Equatable {
    let id: String
    let title: String
    let author: String
    let narrator: String
    let remaining: String
    let progress: Double
    let artworkColors: [Color]
}

private struct LpspAudibleChapter: Identifiable, Equatable {
    let id: Int
    let title: String
    let duration: String
    var state: LpspAudibleChapterListSheet.LpspAudibleChapterState
}

private enum LpspAudibleShowroomData {
    static let songOfAchilles = LpspAudibleBook(
        id: "achilles",
        title: "The Song of Achilles",
        author: "Madeline Miller",
        narrator: "Frazer Douglas",
        remaining: "8 hrs 14 min left",
        progress: 0.34,
        artworkColors: [
            Color(red: 0.72, green: 0.28, blue: 0.18),
            Color(red: 0.42, green: 0.12, blue: 0.10),
        ]
    )

    static let library: [LpspAudibleBook] = [
        songOfAchilles,
        LpspAudibleBook(
            id: "circe",
            title: "Circe",
            author: "Madeline Miller",
            narrator: "Perdita Weeks",
            remaining: "5 hrs 42 min left",
            progress: 0.18,
            artworkColors: [
                Color(red: 0.18, green: 0.42, blue: 0.62),
                Color(red: 0.08, green: 0.22, blue: 0.38),
            ]
        ),
        LpspAudibleBook(
            id: "project-hail-mary",
            title: "Project Hail Mary",
            author: "Andy Weir",
            narrator: "Ray Porter",
            remaining: "12 hrs 8 min left",
            progress: 0.52,
            artworkColors: [
                Color(red: 0.22, green: 0.58, blue: 0.48),
                Color(red: 0.10, green: 0.28, blue: 0.32),
            ]
        ),
    ]

    static let discoverCategories = ["Bestsellers", "New releases", "Editors' picks", "Sci-Fi & Fantasy"]

    static func chapters(for bookID: String) -> [LpspAudibleChapter] {
        switch bookID {
        case "achilles":
            return [
                LpspAudibleChapter(id: 1, title: "My Father and Achilles", duration: "42:18", state: .finished),
                LpspAudibleChapter(id: 2, title: "The Golden Prince", duration: "38:04", state: .playing),
                LpspAudibleChapter(id: 3, title: "The Kings of Sparta", duration: "44:12", state: .upcoming),
                LpspAudibleChapter(id: 4, title: "The Sea", duration: "36:55", state: .upcoming),
            ]
        default:
            return [
                LpspAudibleChapter(id: 1, title: "Chapter 1", duration: "32:10", state: .playing),
                LpspAudibleChapter(id: 2, title: "Chapter 2", duration: "28:44", state: .upcoming),
            ]
        }
    }
}

@MainActor
fileprivate final class LpspAudibleStore: ObservableObject {
    @Published var selectedTab: LpspAudibleShowroomTab = .home
    @Published var currentBook: LpspAudibleBook = LpspAudibleShowroomData.songOfAchilles
    @Published var books: [LpspAudibleBook] = LpspAudibleShowroomData.library
    @Published var progress: Double = 0.34
    @Published var isPlaying = true
    @Published var speed = 1.5
    @Published var showSpeedSheet = false
    @Published var showChaptersSheet = false
    @Published var isBookmarked = false
    @Published var searchQuery = ""

    var chapters: [LpspAudibleChapter] {
        LpspAudibleShowroomData.chapters(for: currentBook.id)
    }

    var chapterRows: [(n: Int, title: String, dur: String, state: LpspAudibleChapterListSheet.LpspAudibleChapterState)] {
        chapters.map { ($0.id, $0.title, $0.duration, $0.state) }
    }

    func togglePlay() {
        isPlaying.toggle()
    }

    func skipBack() {
        progress = max(0, progress - 0.01)
    }

    func skipForward() {
        progress = min(1, progress + 0.01)
    }

    func setSpeed(_ value: Double) {
        speed = value
    }

    func toggleBookmark() {
        isBookmarked.toggle()
    }

    func playBook(_ book: LpspAudibleBook) {
        currentBook = book
        progress = book.progress
        isPlaying = true
        selectedTab = .home
    }

    func openChapters() {
        showChaptersSheet = true
    }
}

// MARK: - Écrans showroom

private struct LpspAudibleShowroomRoot: View {
    @ObservedObject var store: LpspAudibleStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspAudibleSpectrHomeTabScreen(store: store)
                case .library:
                    LpspAudibleLibraryTabScreen(store: store)
                case .discover:
                    LpspAudibleDiscoverTabScreen(store: store)
                case .profile:
                    LpspAudibleProfileTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspAudibleMiniPlayerBar(store: store)
            LpspAudibleLabeledTabBar(store: store)
        }
        .background(LpspAudibleTokens.audCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .sheet(isPresented: $store.showSpeedSheet) {
            LpspAudibleSpeedDialSheet(speed: Binding(
                get: { store.speed },
                set: { store.setSpeed($0) }
            ))
        }
        .sheet(isPresented: $store.showChaptersSheet) {
            LpspAudibleChapterListSheet(chapters: store.chapterRows)
        }
    }
}

private struct LpspAudibleLabeledTabBar: View {
    @ObservedObject var store: LpspAudibleStore

    var body: some View {
        HStack {
            ForEach(LpspAudibleShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspAudibleFonts.audTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspAudibleTokens.audOrange
                            : LpspAudibleTokens.audTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspAudibleTokens.audCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspAudibleTokens.audDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspAudibleSpectrTopBar: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.down")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(LpspAudibleTokens.audTextPrimary)

            Spacer()

            Text("Now Playing")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(LpspAudibleTokens.audTextPrimary)

            Spacer()

            Image(systemName: "ellipsis")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(LpspAudibleTokens.audTextPrimary)
        }
        .padding(.horizontal, 14)
        .padding(.top, 8)
        .padding(.bottom, 6)
    }
}

private struct LpspAudibleShowroomCoverRing: View {
    let colors: [Color]
    let progress: Double
    var size: CGFloat = 226
    var ring: CGFloat = 4

    var body: some View {
        ZStack {
            Circle()
                .stroke(LpspAudibleTokens.audDivider, lineWidth: ring)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LpspAudibleTokens.audOrange,
                    style: StrokeStyle(lineWidth: ring, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: colors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size - ring * 6, height: size - ring * 6)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(Color.black.opacity(0.18))
                        .frame(width: 10)
                }
                .shadow(color: .black.opacity(0.5), radius: 36, y: 14)
        }
        .frame(width: size, height: size)
    }
}

private struct LpspAudibleSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspAudibleStore

    var body: some View {
        VStack(spacing: 0) {
            LpspAudibleSpectrTopBar()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    LpspAudibleShowroomCoverRing(
                        colors: store.currentBook.artworkColors,
                        progress: store.progress
                    )
                    .padding(.top, 8)

                    VStack(spacing: 6) {
                        Text(store.currentBook.title)
                            .font(LpspAudibleFonts.audBookTitle.weight(.bold))
                            .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                            .multilineTextAlignment(.center)
                        Text("By \(store.currentBook.author)")
                            .font(LpspAudibleFonts.audAuthor)
                            .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                        Text("Narrated by \(store.currentBook.narrator)")
                            .font(LpspAudibleFonts.audNarrator.weight(.semibold))
                            .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                    }
                    .padding(.horizontal, 24)

                    HStack(spacing: 36) {
                        LpspAudibleSkipButton(dir: .back) { store.skipBack() }
                        LpspAudibleAudiblePlayButton(isPlaying: store.isPlaying) { store.togglePlay() }
                        LpspAudibleSkipButton(dir: .forward) { store.skipForward() }
                    }

                    Text(store.currentBook.remaining)
                        .font(LpspAudibleFonts.audMeta)
                        .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                        .monospacedDigit()

                    HStack(spacing: 24) {
                        Button { store.showSpeedSheet = true } label: {
                            Text(String(format: "%.1g×", store.speed))
                                .font(LpspAudibleFonts.audSpeed.weight(.bold))
                                .foregroundStyle(LpspAudibleTokens.audOrange)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 14)
                                .background(Capsule().fill(LpspAudibleTokens.audSurface2))
                        }
                        .buttonStyle(.plain)

                        Image(systemName: "moon.zzz")
                            .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                        Button(action: { store.toggleBookmark() }) {
                            Image(systemName: store.isBookmarked ? "bookmark.fill" : "bookmark")
                                .foregroundStyle(
                                    store.isBookmarked
                                        ? LpspAudibleTokens.audOrange
                                        : LpspAudibleTokens.audTextSecondary
                                )
                        }
                        .buttonStyle(.plain)
                        Button(action: { store.openChapters() }) {
                            Image(systemName: "list.bullet")
                                .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                        }
                        .buttonStyle(.plain)
                        Image(systemName: "car.fill")
                            .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                    }
                    .font(.system(size: 22))
                }
                .padding(.bottom, 16)
            }
        }
    }
}

private struct LpspAudibleMiniPlayerBar: View {
    @ObservedObject var store: LpspAudibleStore

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(LpspAudibleTokens.audDivider)
                        .frame(height: 2)
                    Rectangle()
                        .fill(LpspAudibleTokens.audOrange)
                        .frame(width: geo.size.width * store.progress, height: 2)
                }
            }
            .frame(height: 2)

            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            colors: store.currentBook.artworkColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)

                VStack(alignment: .leading, spacing: 2) {
                    Text(store.currentBook.title)
                        .font(LpspAudibleFonts.audMiniTitle.weight(.bold))
                        .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                        .lineLimit(1)
                    Text(store.currentBook.author)
                        .font(LpspAudibleFonts.audTab)
                        .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                        .lineLimit(1)
                }

                Spacer()

                Button(action: { store.skipBack() }) {
                    Image(systemName: "gobackward.30")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                }
                .buttonStyle(.plain)

                Button(action: { store.togglePlay() }) {
                    Image(systemName: store.isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(LpspAudibleTokens.audSurface1)
        }
    }
}

private struct LpspAudibleLibraryTabScreen: View {
    @ObservedObject var store: LpspAudibleStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Library")
                    .font(LpspAudibleFonts.audSection.weight(.bold))
                    .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                Text("Continue listening")
                    .font(LpspAudibleFonts.audCardTitle.weight(.semibold))
                    .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                    .padding(.horizontal, 16)

                ForEach(store.books) { book in
                    Button {
                        store.playBook(book)
                    } label: {
                        LpspAudibleShowroomContinueRow(
                            book: book,
                            isCurrent: store.currentBook.id == book.id && store.isPlaying
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspAudibleShowroomContinueRow: View {
    let book: LpspAudibleBook
    let isCurrent: Bool

    var body: some View {
        HStack(spacing: 14) {
            LpspAudibleShowroomCoverRing(
                colors: book.artworkColors,
                progress: book.progress,
                size: 72,
                ring: 3
            )

            VStack(alignment: .leading, spacing: 3) {
                Text(book.title)
                    .font(LpspAudibleFonts.audCardTitle)
                    .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                    .lineLimit(1)
                Text(book.author)
                    .font(LpspAudibleFonts.audNarrator)
                    .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                    .lineLimit(1)
                Text(book.remaining)
                    .font(LpspAudibleFonts.audMeta)
                    .foregroundStyle(LpspAudibleTokens.audTextSecondary)
            }

            Spacer()

            Image(systemName: isCurrent ? "pause.fill" : "play.fill")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(LpspAudibleTokens.audCanvas)
                .frame(width: 56, height: 56)
                .background(Circle().fill(LpspAudibleTokens.audOrange))
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LpspAudibleTokens.audSurface1)
        )
    }
}

private struct LpspAudibleDiscoverTabScreen: View {
    @ObservedObject var store: LpspAudibleStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                    TextField("Titles, authors, or genres", text: $store.searchQuery)
                        .font(LpspAudibleFonts.audBody)
                        .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                        .tint(LpspAudibleTokens.audOrange)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspAudibleTokens.audSurface1)
                )
                .padding(.horizontal, 16)
                .padding(.top, 8)

                Text("Discover")
                    .font(LpspAudibleFonts.audSection.weight(.bold))
                    .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                    .padding(.horizontal, 16)

                ForEach(LpspAudibleShowroomData.discoverCategories, id: \.self) { category in
                    Button {
                        store.searchQuery = category
                    } label: {
                        HStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LpspAudibleTokens.audSurface2)
                                .frame(width: 56, height: 56)
                                .overlay {
                                    Image(systemName: "headphones")
                                        .foregroundStyle(LpspAudibleTokens.audOrange)
                                }
                            Text(category)
                                .font(LpspAudibleFonts.audCardTitle)
                                .foregroundStyle(LpspAudibleTokens.audTextPrimary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(LpspAudibleTokens.audTextTertiary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }

                if !store.searchQuery.isEmpty {
                    Text("Results")
                        .font(LpspAudibleFonts.audCardTitle.weight(.semibold))
                        .foregroundStyle(LpspAudibleTokens.audTextSecondary)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                    ForEach(filteredBooks) { book in
                        Button {
                            store.playBook(book)
                        } label: {
                            LpspAudibleShowroomContinueRow(
                                book: book,
                                isCurrent: store.currentBook.id == book.id && store.isPlaying
                            )
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }

    private var filteredBooks: [LpspAudibleBook] {
        store.books.filter {
            $0.title.localizedCaseInsensitiveContains(store.searchQuery)
                || $0.author.localizedCaseInsensitiveContains(store.searchQuery)
        }
    }
}

private struct LpspAudibleProfileTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                Circle()
                    .fill(LpspAudibleTokens.audSurface2)
                    .frame(width: 88, height: 88)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(LpspAudibleTokens.audOrange)
                    }

                Text("Your Audible")
                    .font(LpspAudibleFonts.audSection.weight(.bold))
                    .foregroundStyle(LpspAudibleTokens.audTextPrimary)

                Text("Premium · 1 credit available")
                    .font(LpspAudibleFonts.audMeta)
                    .foregroundStyle(LpspAudibleTokens.audTextSecondary)

                Text("Member since 2022")
                    .font(LpspAudibleFonts.audMeta)
                    .foregroundStyle(LpspAudibleTokens.audTextTertiary)
            }
            .padding(.vertical, 32)
        }
    }
}


import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/kindle
// Meliwat/awesome-ios-design-md/misc/kindle/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeKindleView: View {
    var body: some View {
        LpspKindleShowroomRoot(store: LpspKindleStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspKindleTokens {
    // MARK: - Brand & Interactive
    static let kdlOrange        = Color(red: 1.000, green: 0.600, blue: 0.000) // #FF9900
    static let kdlOrangePressed = Color(red: 0.910, green: 0.545, blue: 0.000) // #E88B00
    static let kdlBlack         = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let kdlLink          = Color(red: 0.102, green: 0.596, blue: 1.000) // #1A98FF
    static let kdlBlue          = Color(red: 0.310, green: 0.702, blue: 0.851) // #4FB3D9

    // MARK: - Reading Themes (page / ink)
    static let kdlWhitePage  = Color.white                                     // #FFFFFF
    static let kdlWhiteInk   = Color(red: 0.102, green: 0.102, blue: 0.102)    // #1A1A1A
    static let kdlSepiaPage  = Color(red: 0.984, green: 0.941, blue: 0.851)    // #FBF0D9
    static let kdlSepiaInk   = Color(red: 0.373, green: 0.294, blue: 0.196)    // #5F4B32
    static let kdlGreenPage  = Color(red: 0.773, green: 0.882, blue: 0.773)    // #C5E1C5
    static let kdlGreenInk   = Color(red: 0.200, green: 0.286, blue: 0.184)    // #33492F
    static let kdlDarkPage   = Color(red: 0.165, green: 0.165, blue: 0.165)    // #2A2A2A
    static let kdlDarkInk    = Color(red: 0.847, green: 0.847, blue: 0.847)    // #D8D8D8
    static let kdlBlackPage  = Color.black                                     // #000000
    static let kdlBlackInk   = Color(red: 0.784, green: 0.784, blue: 0.784)    // #C8C8C8

    // MARK: - App Chrome (Light)
    static let kdlChromeCanvas  = Color.white                                  // #FFFFFF
    static let kdlSurfaceSubtle = Color(red: 0.957, green: 0.949, blue: 0.933) // #F4F2EE
    static let kdlDivider       = Color(red: 0.894, green: 0.886, blue: 0.867) // #E4E2DD

    // MARK: - App Chrome (Dark)
    static let kdlDarkCanvas   = Color(red: 0.055, green: 0.055, blue: 0.055)  // #0E0E0E
    static let kdlDarkSurface1 = Color(red: 0.102, green: 0.102, blue: 0.102)  // #1A1A1A
    static let kdlDarkSurface2 = Color(red: 0.141, green: 0.141, blue: 0.141)  // #242424
    static let kdlDarkDivider  = Color(red: 0.180, green: 0.180, blue: 0.180)  // #2E2E2E

    // MARK: - Text (Chrome)
    static let kdlTextPrimary    = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let kdlTextSecondary  = Color(red: 0.420, green: 0.420, blue: 0.420) // #6B6B6B
    static let kdlDarkTextPrimary = Color(red: 0.910, green: 0.910, blue: 0.910) // #E8E8E8
    static let kdlDarkTextSecondary = Color(red: 0.604, green: 0.604, blue: 0.604) // #9A9A9A

    // MARK: - Semantic
    static let kdlError   = Color(red: 0.878, green: 0.325, blue: 0.239) // #E0533D
    static let kdlSuccess = Color(red: 0.184, green: 0.682, blue: 0.373) // #2FAE5F
}

// Reading theme model — the user's choice, OS-independent
fileprivate enum LpspKindleKindleReadingTheme: String, CaseIterable, Identifiable {
    case white, sepia, green, dark, black
    var id: String { rawValue }
    var page: Color {
        switch self { case .white: LpspKindleTokens.kdlWhitePage; case .sepia: LpspKindleTokens.kdlSepiaPage
        case .green: LpspKindleTokens.kdlGreenPage; case .dark: LpspKindleTokens.kdlDarkPage; case .black: LpspKindleTokens.kdlBlackPage }
    }
    var ink: Color {
        switch self { case .white: LpspKindleTokens.kdlWhiteInk; case .sepia: LpspKindleTokens.kdlSepiaInk
        case .green: LpspKindleTokens.kdlGreenInk; case .dark: LpspKindleTokens.kdlDarkInk; case .black: LpspKindleTokens.kdlBlackInk }
    }
}

private enum LpspKindleFonts {
    // Reading — Bitter (Bookerly analog)
    static func kdlReading(_ size: CGFloat) -> Font { .custom("Bitter-Regular", size: size) }
    static let kdlChapterTitle = Font.system(size: 24, weight: .regular)
    static let kdlDropCap      = Font.system(size: 52, weight: .regular)

    // Chrome — Amazon Ember (fallback: SF Pro)
    static let kdlScreenTitle = Font.system(size: 30, weight: .regular)
    static let kdlBookTitle   = Font.system(size: 20, weight: .regular)
    static let kdlSubtitle    = Font.system(size: 17, weight: .regular)
    static let kdlListTitle   = Font.system(size: 15, weight: .regular)
    static let kdlMeta        = Font.system(size: 14, weight: .regular)
    static let kdlCaption     = Font.system(size: 12, weight: .regular)
    static let kdlEyebrow     = Font.system(size: 11, weight: .regular)
    static let kdlTab         = Font.system(size: 10, weight: .regular)
    static let kdlNote        = Font.system(size: 13, weight: .regular)
}

// User reading settings (bound to a Settings store)
fileprivate struct LpspKindleKindleReadingSettings {
    var fontName: String = "Bitter-Regular"
    var size: CGFloat = 15.5
    var lineSpacingMultiple: CGFloat = 1.72
    var margin: CGFloat = 26   // Narrow 16 / Standard 26 / Wide 40
    var theme: LpspKindleKindleReadingTheme = .sepia
}

fileprivate struct LpspKindleReadingPage: View {
    let chapter: String        // "CHAPTER SEVEN"
    let title: String          // "The Lighthouse at Dawn"
    let paragraphs: [String]
    let percent: Int
    let minsLeft: Int
    let settings: LpspKindleKindleReadingSettings
    @Binding var chromeShown: Bool

    var body: some View {
        let theme = settings.theme
        ZStack(alignment: .bottom) {
            theme.page.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(chapter)
                        .font(LpspKindleFonts.kdlEyebrow).kerning(1.5)
                        .foregroundStyle(theme.ink.opacity(0.55))
                        .padding(.bottom, 4)
                    Text(title)
                        .font(LpspKindleFonts.kdlChapterTitle)
                        .foregroundStyle(theme.ink)
                        .padding(.bottom, 6)
                    ForEach(Array(paragraphs.enumerated()), id: \.offset) { i, p in
                        Text(p)
                            .font(.custom(settings.fontName, size: settings.size))
                            .foregroundStyle(theme.ink)
                            .lineSpacing(settings.size * (settings.lineSpacingMultiple - 1))
                            .multilineTextAlignment(.leading) // justified: see note
                    }
                }
                .padding(.horizontal, settings.margin)
                .padding(.vertical, 20)
            }
            .scrollIndicators(.hidden)

            // Footer whisper + 2pt orange progress hairline
            VStack(spacing: 8) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle().fill(theme.ink.opacity(0.18)).frame(height: 2)
                        Rectangle().fill(LpspKindleTokens.kdlOrange)
                            .frame(width: geo.size.width * CGFloat(percent) / 100, height: 2)
                    }
                }.frame(height: 2)
                HStack {
                    Text("\(percent)%")
                    Spacer()
                    Text("\(minsLeft) min left in chapter")
                }
                .font(LpspKindleFonts.kdlEyebrow).foregroundStyle(theme.ink.opacity(0.55))
            }
            .padding(.horizontal, 24).padding(.bottom, 14)
        }
        .contentShape(Rectangle())
        .onTapGesture { withAnimation(.easeInOut(duration: 0.2)) { chromeShown.toggle() } }
    }
}
// NOTE: SwiftUI Text has no native justified alignment. For true Kindle
// justified+hyphenated body, render the page with TextKit 2 (UIViewRepresentable
// over NSTextView/UITextView) and set .justified + .byWordWrapping + hyphenationFactor 1.

fileprivate struct LpspKindleAaPanel: View {
    @Binding var settings: LpspKindleKindleReadingSettings

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            // Size row
            HStack {
                Text("Aa").font(.system(size: 14))
                Slider(value: $settings.size, in: 12...26, step: 0.5).tint(LpspKindleTokens.kdlOrange)
                Text("Aa").font(.system(size: 24))
            }
            // Theme swatches
            HStack(spacing: 12) {
                ForEach(LpspKindleKindleReadingTheme.allCases) { theme in
                    Circle()
                        .fill(theme.page)
                        .frame(width: 30, height: 30)
                        .overlay(Circle().strokeBorder(.black.opacity(0.18), lineWidth: 1))
                        .overlay(
                            Circle().strokeBorder(LpspKindleTokens.kdlOrange, lineWidth: 2)
                                .padding(-4)
                                .opacity(settings.theme == theme ? 1 : 0)
                        )
                        .scaleEffect(settings.theme == theme ? 1.0 : 1.0)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.15)) { settings.theme = theme }
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(settings.theme.page)
        )
    }
}

fileprivate struct LpspKindleLibraryCover: View {
    let title: String
    let progress: Double
    let author: String
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            colors: [accent.opacity(0.85), accent.opacity(0.45)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .aspectRatio(2.0/3.0, contentMode: .fit)
                    .overlay(
                        Text(title)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(8),
                        alignment: .bottom
                    )
                    .shadow(color: .black.opacity(0.35), radius: 8, y: 4)

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle().fill(.white.opacity(0.2))
                        Rectangle().fill(LpspKindleTokens.kdlOrange)
                            .frame(width: geo.size.width * progress)
                    }
                }
                .frame(height: 3)
            }
            Text(progress >= 1 ? "Finished · \(author)" : "\(Int(progress * 100))% · \(author)")
                .font(LpspKindleFonts.kdlCaption)
                .foregroundStyle(LpspKindleTokens.kdlTextSecondary)
                .lineLimit(1)
        }
    }
}

fileprivate struct LpspKindleKindleProgress: View {
    let fraction: Double
    let caption: String
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        HStack(spacing: 12) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(scheme == .dark ? LpspKindleTokens.kdlDarkSurface2 : LpspKindleTokens.kdlDivider)
                    Capsule().fill(LpspKindleTokens.kdlOrange)
                        .frame(width: geo.size.width * fraction)
                }
            }
            .frame(height: 4)
            Text(caption).font(LpspKindleFonts.kdlCaption)
                .foregroundStyle(scheme == .dark ? LpspKindleTokens.kdlDarkTextSecondary : LpspKindleTokens.kdlTextSecondary)
                .frame(width: 96, alignment: .leading)
        }
    }
}


fileprivate struct LpspKindleKindleChromeTheme: ViewModifier {
    @Environment(\.colorScheme) var scheme
    func body(content: Content) -> some View {
        content
            .background(scheme == .dark ? LpspKindleTokens.kdlDarkCanvas : LpspKindleTokens.kdlChromeCanvas)
            .foregroundStyle(scheme == .dark ? LpspKindleTokens.kdlDarkTextPrimary : LpspKindleTokens.kdlTextPrimary)
            .tint(LpspKindleTokens.kdlOrange)
    }
}
fileprivate extension View { func kindleChrome() -> some View { modifier(LpspKindleKindleChromeTheme()) } }

// MARK: - Données & état (showroom Spectr)

fileprivate struct LpspKindleBook: Identifiable, Hashable {
    let id: String
    let title: String
    let author: String
    let chapter: String
    let chapterTitle: String
    let paragraphs: [String]
    let progress: Double
    let percentInChapter: Int
    let minsLeftInChapter: Int
    let coverAccent: Color
}

private enum LpspKindleTab: CaseIterable {
    case home, library, discover, more

    var label: String {
        switch self {
        case .home: "Home"
        case .library: "Library"
        case .discover: "Discover"
        case .more: "More"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .library: "books.vertical.fill"
        case .discover: "magnifyingglass"
        case .more: "ellipsis"
        }
    }
}

@MainActor
fileprivate final class LpspKindleStore: ObservableObject {
    @Published var selectedTab: LpspKindleTab = .home
    @Published var activeBookID: String
    @Published var readingSettings = LpspKindleKindleReadingSettings(theme: .sepia)
    @Published var chromeShown = false
    @Published var showAaPanel = false

    let books: [LpspKindleBook] = LpspKindleShowroomData.books

    init() {
        self.activeBookID = LpspKindleShowroomData.defaultBookID
    }

    var activeBook: LpspKindleBook {
        books.first { $0.id == activeBookID } ?? books[0]
    }

    func openBook(_ id: String) {
        activeBookID = id
        selectedTab = .home
        chromeShown = false
        showAaPanel = false
    }
}

private enum LpspKindleShowroomData {
    static let defaultBookID = "lighthouse-dawn"

    static let books: [LpspKindleBook] = [
        .init(
            id: "lighthouse-dawn",
            title: "The Lighthouse at Dawn",
            author: "Elena Marsh",
            chapter: "CHAPTER SEVEN",
            chapterTitle: "The Lighthouse at Dawn",
            paragraphs: [
                "At the top the lamp still turned, patient and enormous, throwing its long arm of light across water the color of slate. She rested her palm on the brass and felt the faint warmth that never quite left it.",
                "Below, the village was a scatter of dark roofs. Somewhere down there a boat was already missing, though no one knew it yet but her.",
            ],
            progress: 0.38,
            percentInChapter: 38,
            minsLeftInChapter: 14,
            coverAccent: Color(red: 0.45, green: 0.32, blue: 0.22)
        ),
        .init(
            id: "project-hail-mary",
            title: "Project Hail Mary",
            author: "Andy Weir",
            chapter: "CHAPTER 12",
            chapterTitle: "Rocky",
            paragraphs: [
                "I am, objectively, the luckiest human being in history. Also possibly the unluckiest. The distinction feels academic.",
            ],
            progress: 0.62,
            percentInChapter: 54,
            minsLeftInChapter: 22,
            coverAccent: Color(red: 0.15, green: 0.35, blue: 0.55)
        ),
        .init(
            id: "atomic-habits",
            title: "Atomic Habits",
            author: "James Clear",
            chapter: "CHAPTER 3",
            chapterTitle: "How to Build Better Habits",
            paragraphs: [
                "Habits are the compound interest of self-improvement. The same way that money multiplies through compound interest, the effects of your habits multiply as you repeat them.",
            ],
            progress: 0.12,
            percentInChapter: 12,
            minsLeftInChapter: 31,
            coverAccent: Color(red: 0.55, green: 0.42, blue: 0.18)
        ),
        .init(
            id: "creative-act",
            title: "The Creative Act",
            author: "Rick Rubin",
            chapter: "INTRODUCTION",
            chapterTitle: "The Source of Creativity",
            paragraphs: [
                "Creativity is not a rare ability. It is not a gift bestowed upon a select few. It is a fundamental aspect of being human.",
            ],
            progress: 1.0,
            percentInChapter: 100,
            minsLeftInChapter: 0,
            coverAccent: Color(red: 0.35, green: 0.35, blue: 0.38)
        ),
    ]
}

// MARK: - Écrans showroom

private struct LpspKindleShowroomRoot: View {
    @ObservedObject var store: LpspKindleStore

    var body: some View {
        ZStack {
            if store.selectedTab == .home {
                LpspKindleReadingScreen(store: store)
            } else {
                VStack(spacing: 0) {
                    Group {
                        switch store.selectedTab {
                        case .library:
                            LpspKindleLibraryScreen(store: store)
                        case .discover:
                            LpspKindleDiscoverScreen(store: store)
                        case .more:
                            LpspKindleMoreScreen()
                        case .home:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    LpspKindleTabBar(store: store)
                }
                .kindleChrome()
            }
        }
    }
}

private struct LpspKindleTabBar: View {
    @ObservedObject var store: LpspKindleStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspKindleTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        store.selectedTab = tab
                        if tab != .home {
                            store.chromeShown = false
                            store.showAaPanel = false
                        }
                    }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.label)
                            .font(LpspKindleFonts.kdlTab)
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspKindleTokens.kdlOrange : LpspKindleTokens.kdlTextSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
                .sensoryFeedback(.selection, trigger: store.selectedTab)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspKindleTokens.kdlChromeCanvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspKindleTokens.kdlDivider).frame(height: 0.5)
        }
    }
}

private struct LpspKindleReadingScreen: View {
    @ObservedObject var store: LpspKindleStore

    var body: some View {
        ZStack {
            LpspKindleReadingPage(
                chapter: store.activeBook.chapter,
                title: store.activeBook.chapterTitle,
                paragraphs: store.activeBook.paragraphs,
                percent: store.activeBook.percentInChapter,
                minsLeft: store.activeBook.minsLeftInChapter,
                settings: store.readingSettings,
                chromeShown: $store.chromeShown
            )

            if store.chromeShown {
                VStack {
                    LpspKindleReadingChromeBar(store: store)
                    Spacer()
                    if store.showAaPanel {
                        LpspKindleAaPanel(settings: $store.readingSettings)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)
                    }
                    LpspKindleReadingBottomChrome(store: store)
                }
                .transition(.opacity)
            }
        }
    }
}

private struct LpspKindleReadingChromeBar: View {
    @ObservedObject var store: LpspKindleStore

    var body: some View {
        HStack {
            Button {
                store.selectedTab = .library
                store.chromeShown = false
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .semibold))
            }
            Spacer()
            Text(store.activeBook.title)
                .font(LpspKindleFonts.kdlListTitle)
                .lineLimit(1)
            Spacer()
            Button {
                withAnimation { store.showAaPanel.toggle() }
            } label: {
                Text("Aa")
                    .font(.system(size: 17, weight: .semibold))
            }
        }
        .foregroundStyle(LpspKindleTokens.kdlBlack)
        .padding(.horizontal, 16)
        .frame(height: 44)
        .background(LpspKindleTokens.kdlBlack.opacity(0.92))
    }
}

private struct LpspKindleReadingBottomChrome: View {
    @ObservedObject var store: LpspKindleStore

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                chromeItem("Aa") { store.showAaPanel.toggle() }
                chromeItem("Brightness", systemImage: "sun.max") {}
                chromeItem("Layout", systemImage: "text.alignleft") {}
                chromeItem("Go To", systemImage: "list.bullet") {}
            }
            .frame(height: 48)
            .background(LpspKindleTokens.kdlBlack.opacity(0.92))

            LpspKindleTabBar(store: store)
        }
    }

    private func chromeItem(_ label: String, systemImage: String? = nil, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 4) {
                if let systemImage {
                    Image(systemName: systemImage).font(.system(size: 16))
                } else {
                    Text(label).font(.system(size: 15, weight: .semibold))
                }
                Text(label).font(LpspKindleFonts.kdlTab)
            }
            .foregroundStyle(.white.opacity(0.85))
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspKindleLibraryScreen: View {
    @ObservedObject var store: LpspKindleStore

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(store.books) { book in
                        Button { store.openBook(book.id) } label: {
                            LpspKindleLibraryCover(
                                title: book.title,
                                progress: book.progress,
                                author: book.author,
                                accent: book.coverAccent
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
            .navigationTitle("Library")
        }
    }
}

private struct LpspKindleDiscoverScreen: View {
    @ObservedObject var store: LpspKindleStore

    var body: some View {
        NavigationStack {
            List {
                Section("Recommended for you") {
                    ForEach(store.books.prefix(2)) { book in
                        Button { store.openBook(book.id) } label: {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(book.coverAccent.opacity(0.7))
                                    .frame(width: 48, height: 72)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(book.title)
                                        .font(LpspKindleFonts.kdlListTitle.weight(.semibold))
                                        .foregroundStyle(LpspKindleTokens.kdlTextPrimary)
                                    Text(book.author)
                                        .font(LpspKindleFonts.kdlMeta)
                                        .foregroundStyle(LpspKindleTokens.kdlTextSecondary)
                                }
                            }
                        }
                    }
                }
                Section("Browse") {
                    Label("Kindle Unlimited", systemImage: "infinity")
                    Label("Best Sellers", systemImage: "chart.line.uptrend.xyaxis")
                    Label("New Releases", systemImage: "sparkles")
                }
            }
            .navigationTitle("Discover")
        }
    }
}

private struct LpspKindleMoreScreen: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Label("Settings", systemImage: "gearshape")
                    Label("Your Account", systemImage: "person.crop.circle")
                }
                Section {
                    Label("Help & Feedback", systemImage: "questionmark.circle")
                    Label("About Kindle", systemImage: "info.circle")
                }
            }
            .navigationTitle("More")
        }
    }
}

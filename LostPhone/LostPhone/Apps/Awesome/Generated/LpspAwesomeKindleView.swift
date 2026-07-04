import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/misc/kindle/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/kindle
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeKindleView: View {
    var body: some View {
        LpspKindleShowroomRoot()
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
    let imageUrl: String?
    let progress: Double      // 0...1
    let author: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: imageUrl ?? "")) { img in
                    img.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle().fill(LpspKindleTokens.kdlDarkSurface2)
                }
                .aspectRatio(2.0/3.0, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .shadow(color: .black.opacity(0.4), radius: 10, y: 4)

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle().fill(.white.opacity(0.2))
                        Rectangle().fill(LpspKindleTokens.kdlOrange)
                            .frame(width: geo.size.width * progress)
                    }
                }
                .frame(height: 3)
            }
            Text(progress >= 1 ? "Finished · \(author)" : "\(Int(progress*100))% · \(author)")
                .font(LpspKindleFonts.kdlCaption).foregroundStyle(LpspKindleTokens.kdlTextSecondary)
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

// MARK: - Écrans showroom

private struct LpspKindleShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspKindleReaderTabScreen(title: "Home", tabIndex: 0)
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspKindleReaderTabScreen(title: "Library", tabIndex: 1)
                .tabItem { Label("Library", systemImage: "books.vertical.fill") }
                .tag(1)
            LpspKindleReaderTabScreen(title: "Discover", tabIndex: 2)
                .tabItem { Label("Discover", systemImage: "magnifyingglass") }
                .tag(2)
            LpspKindleReaderTabScreen(title: "More", tabIndex: 3)
                .tabItem { Label("More", systemImage: "ellipsis") }
                .tag(3)
        }
        .tint(LpspKindleTokens.kdlGreenPage)
        
    }
}


private struct LpspKindleGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspKindleTokens.kdlGreenPage.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspKindleTokens.kdlGreenPage))
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


private struct LpspKindleDemoBook { let title: String; let author: String; let progress: Double }
private enum LpspKindleDemoBooks {
    static let items: [LpspKindleDemoBook] = [
        .init(title: "SwiftUI Patterns", author: "Meliwat", progress: 0.42),
        .init(title: "Design Systems", author: "Spectr", progress: 0.08),
    ]
}

private struct LpspKindleReaderLibraryTabScreen: View {
    var body: some View { NavigationStack { ScrollView { 
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(LpspKindleDemoBooks.items, id: \.title) { b in
                        LpspKindleLibraryCover(imageUrl: nil, progress: b.progress, author: b.author)
                        }
                    }
                    .padding()
 } .navigationTitle("Bibliothèque") } }
}

private struct LpspKindleReaderReadingTabScreen: View {
    var body: some View {
        ZStack {
            LpspKindleTokens.kdlChromeCanvas.ignoresSafeArea()
            LpspKindleReadingPage()
        }
    }
}

private struct LpspKindleReaderTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if low.contains("read") || low.contains("lecture") { LpspKindleReaderReadingTabScreen() }
        else { LpspKindleReaderLibraryTabScreen() }
    }
}



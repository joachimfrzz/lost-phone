import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/disney-plus
// Meliwat/awesome-ios-design-md/video/disney-plus/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDisneyView: View {
    var body: some View {
        LpspDisneyShowroomRoot(store: LpspDisneyStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspDisneyFonts {
    static let dpBillboard  = Font.system(size: 30, weight: .regular)
    static let dpDetailTitle = Font.system(size: 26, weight: .regular)
    static let dpSection    = Font.system(size: 20, weight: .regular)
    static let dpRowHeader  = Font.system(size: 18, weight: .regular)
    static let dpCardTitle  = Font.system(size: 14, weight: .regular)
    static let dpSynopsis   = Font.system(size: 15, weight: .regular)
    static let dpMetaStrip  = Font.system(size: 13, weight: .regular)
    static let dpSubtitle   = Font.system(size: 14, weight: .regular)
    static let dpMeta       = Font.system(size: 12, weight: .regular)
    static let dpBadge      = Font.system(size: 10, weight: .regular)
    static let dpButton     = Font.system(size: 16, weight: .regular)
    static let dpButtonSec  = Font.system(size: 14, weight: .regular)
    static let dpTab        = Font.system(size: 10, weight: .regular)
    static func dp(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspDisneyTokens {

    // MARK: - Canvas & Surfaces
    static let dpCanvas   = Color(red: 0.039, green: 0.055, blue: 0.165) // #0A0E2A
    static let dpSurface1 = Color(red: 0.071, green: 0.082, blue: 0.180) // #12152E
    static let dpSurface2 = Color(red: 0.102, green: 0.122, blue: 0.239) // #1A1F3D
    static let dpDivider  = Color(red: 0.165, green: 0.188, blue: 0.314) // #2A3050

    // MARK: - Text
    static let dpTextPrimary   = Color.white                                 // #FFFFFF
    static let dpTextSecondary = Color(red: 0.627, green: 0.651, blue: 0.753) // #A0A6C0
    static let dpTextTertiary  = Color(red: 0.353, green: 0.376, blue: 0.502) // #5A6080

    // MARK: - Brand
    static let dpBlue        = Color(red: 0.0,   green: 0.388, blue: 0.898) // #0063E5
    static let dpGlowBlue    = Color(red: 0.102, green: 0.459, blue: 1.0)   // #1A75FF
    static let dpBluePressed = Color(red: 0.0,   green: 0.322, blue: 0.741) // #0052BD
    static let dpLiveRed     = Color(red: 0.898, green: 0.282, blue: 0.302) // #E5484D
    static var dpFocusGlow: Color { Color(red: 0.102, green: 0.459, blue: 1.0).opacity(0.30) }
}







fileprivate struct LpspDisneyDPPlayButton: View {
    let label: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill")
                Text(label).font(LpspDisneyFonts.dpButton).tracking(0.3)
            }
            .foregroundStyle(LpspDisneyTokens.dpCanvas) // dark glyph on white
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: label)
        .buttonStyle(LpspDisneyDPPressable())
    }
}

fileprivate struct LpspDisneyDPSecondaryButton: View {
    let icon: String
    let label: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(label).font(LpspDisneyFonts.dpButtonSec)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.12)))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.white.opacity(0.24), lineWidth: 1))
        }
        .buttonStyle(LpspDisneyDPPressable())
    }
}

fileprivate struct LpspDisneyDPPressable: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspDisneyBrandPortalTile: View {
    let logo: Image
    let gradient: [Color]          // brand-tinted
    @State private var focused = false

    var body: some View {
        logo
            .resizable().scaledToFit()
            .padding(20)
            .frame(width: 160, height: 96)
            .background(
                LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(focused ? LpspDisneyTokens.dpGlowBlue : LpspDisneyTokens.dpDivider,
                                  lineWidth: focused ? 2 : 1)
            )
            .scaleEffect(focused ? 1.04 : 1)
            .shadow(color: focused ? LpspDisneyTokens.dpGlowBlue.opacity(0.35) : .clear, radius: 24)
            .animation(.easeOut(duration: 0.18), value: focused)
            .onTapGesture { /* open universe hub */ }
            .onLongPressGesture(minimumDuration: 0, pressing: { focused = $0 }, perform: {})
    }
}

// Reusable focus modifier — the unified Disney+ selection language
fileprivate struct LpspDisneyDPFocusable: ViewModifier {
    @State private var focused = false
    func body(content: Content) -> some View {
        content
            .scaleEffect(focused ? 1.04 : 1)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(focused ? LpspDisneyTokens.dpGlowBlue : .clear, lineWidth: 2)
            )
            .shadow(color: focused ? LpspDisneyTokens.dpFocusGlow : .clear, radius: 24)
            .animation(.easeOut(duration: 0.18), value: focused)
            .onLongPressGesture(minimumDuration: 0, pressing: { focused = $0 }, perform: {})
    }
}
fileprivate extension View { func dpFocusable() -> some View { modifier(LpspDisneyDPFocusable()) } }

fileprivate struct LpspDisneyContentCard16x9: View {
    let keyArt: Image
    var progress: Double? = nil    // continue-watching

    var body: some View {
        ZStack(alignment: .bottom) {
            keyArt
                .resizable().aspectRatio(16/9, contentMode: .fill)
                .frame(width: 220, height: 124)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            if let p = progress {
                VStack {
                    Spacer()
                    GeometryReader { g in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.white.opacity(0.25))
                            Rectangle().fill(LpspDisneyTokens.dpBlue).frame(width: g.size.width * p)
                        }
                    }
                    .frame(height: 3)
                }
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .frame(width: 220, height: 124)
        .dpFocusable()
    }
}

fileprivate struct LpspDisneyEpisodeRow: View {
    let thumb: Image
    let title: String              // "E4 · The Siege"
    let synopsis: String
    let runtime: String
    var progress: Double? = nil

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .bottom) {
                thumb.resizable().aspectRatio(16/9, contentMode: .fill)
                    .frame(width: 160, height: 90).clipShape(RoundedRectangle(cornerRadius: 6))
                Image(systemName: "play.circle.fill").font(.system(size: 28)).foregroundStyle(.white.opacity(0.9))
                if let p = progress {
                    VStack { Spacer()
                        GeometryReader { g in
                            ZStack(alignment: .leading) {
                                Rectangle().fill(Color.white.opacity(0.25))
                                Rectangle().fill(LpspDisneyTokens.dpBlue).frame(width: g.size.width * p)
                            }
                        }.frame(height: 3)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(LpspDisneyFonts.dpCardTitle).foregroundStyle(.white)
                Text(synopsis).font(.custom("AvenirNext-Regular", size: 13)).foregroundStyle(LpspDisneyTokens.dpTextSecondary).lineLimit(2)
                Text(runtime).font(LpspDisneyFonts.dpMeta).foregroundStyle(LpspDisneyTokens.dpTextSecondary).monospacedDigit()
            }
            Spacer(minLength: 4)
            Image(systemName: "arrow.down.circle").font(.system(size: 22)).foregroundStyle(LpspDisneyTokens.dpTextSecondary)
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 8).fill(LpspDisneyTokens.dpSurface1))
    }
}



// MARK: - Données & état (showroom Spectr)

private enum LpspDisneyShowroomTab: String, CaseIterable, Identifiable {
    case home
    case search
    case watchlist
    case downloads
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .watchlist: return "Watchlist"
        case .downloads: return "Downloads"
        case .profile: return "Profile"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .search: return "magnifyingglass"
        case .watchlist: return "plus.rectangle.on.rectangle"
        case .downloads: return "arrow.down.circle"
        case .profile: return "person.crop.circle"
        }
    }
}

fileprivate enum LpspDisneyBrandPortal: String, CaseIterable, Identifiable {
    case disney
    case pixar
    case marvel
    case starWars
    case natGeo

    var id: String { rawValue }

    var label: String {
        switch self {
        case .disney: return "DISNEY"
        case .pixar: return "PIXAR"
        case .marvel: return "MARVEL"
        case .starWars: return "STAR WARS"
        case .natGeo: return "NAT GEO"
        }
    }

    var gradient: [Color] {
        switch self {
        case .disney:
            return [Color(red: 0.07, green: 0.24, blue: 0.81), Color(red: 0.0, green: 0.39, blue: 0.90)]
        case .pixar:
            return [Color(red: 0.35, green: 0.72, blue: 0.92), Color(red: 0.10, green: 0.46, blue: 1.0)]
        case .marvel:
            return [Color(red: 0.77, green: 0.12, blue: 0.23), Color(red: 0.36, green: 0.04, blue: 0.08)]
        case .starWars:
            return [Color(red: 0.10, green: 0.10, blue: 0.10), Color(red: 1.0, green: 0.91, blue: 0.12)]
        case .natGeo:
            return [Color(red: 1.0, green: 0.80, blue: 0.0), Color(red: 0.0, green: 0.66, blue: 0.42)]
        }
    }
}

fileprivate struct LpspDisneyTitle: Identifiable, Equatable {
    let id: String
    let name: String
    let meta: String
    let brand: LpspDisneyBrandPortal
    let gradient: [Color]
    var progress: Double?
    var inWatchlist: Bool
}

private enum LpspDisneyShowroomData {
    static let featuredID = "andor"

    static let featured = LpspDisneyTitle(
        id: featuredID,
        name: "ANDOR",
        meta: "Action · Sci-Fi · TV-14 · 2024",
        brand: .starWars,
        gradient: [
            Color(red: 0.12, green: 0.10, blue: 0.22),
            Color(red: 0.55, green: 0.28, blue: 0.08),
            LpspDisneyTokens.dpCanvas,
        ],
        progress: nil,
        inWatchlist: false
    )

    static let continueWatching: [LpspDisneyTitle] = [
        .init(
            id: "mandalorian",
            name: "The Mandalorian",
            meta: "Sci-Fi · TV-14",
            brand: .starWars,
            gradient: [Color(red: 0.18, green: 0.32, blue: 0.48), Color(red: 0.05, green: 0.12, blue: 0.28)],
            progress: 0.42,
            inWatchlist: true
        ),
        .init(
            id: "loki",
            name: "Loki",
            meta: "Action · TV-14",
            brand: .marvel,
            gradient: [Color(red: 0.45, green: 0.18, blue: 0.55), Color(red: 0.12, green: 0.05, blue: 0.22)],
            progress: 0.68,
            inWatchlist: false
        ),
        .init(
            id: "elemental",
            name: "Elemental",
            meta: "Family · PG",
            brand: .pixar,
            gradient: [Color(red: 0.95, green: 0.45, blue: 0.20), Color(red: 0.20, green: 0.55, blue: 0.88)],
            progress: nil,
            inWatchlist: false
        ),
    ]

    static let catalog: [LpspDisneyTitle] = [
        featured,
        continueWatching[0],
        continueWatching[1],
        continueWatching[2],
        .init(
            id: "inside-out-2",
            name: "Inside Out 2",
            meta: "Family · PG",
            brand: .pixar,
            gradient: [Color(red: 0.55, green: 0.25, blue: 0.75), Color(red: 0.20, green: 0.55, blue: 0.95)],
            progress: nil,
            inWatchlist: false
        ),
        .init(
            id: "bluey",
            name: "Bluey",
            meta: "Kids · TV-Y",
            brand: .disney,
            gradient: [Color(red: 0.20, green: 0.55, blue: 0.95), Color(red: 0.10, green: 0.30, blue: 0.72)],
            progress: nil,
            inWatchlist: true
        ),
        .init(
            id: "cosmos",
            name: "Cosmos",
            meta: "Documentary · TV-PG",
            brand: .natGeo,
            gradient: [Color(red: 0.10, green: 0.18, blue: 0.42), Color(red: 0.0, green: 0.45, blue: 0.55)],
            progress: nil,
            inWatchlist: false
        ),
    ]

    static let searchSuggestions = [
        "Star Wars",
        "Marvel",
        "Pixar",
        "Documentaries",
        "Kids",
        "Action",
    ]

    static let downloads = [
        ("Andor S1E3 · Reckoning", "1.2 GB"),
        ("Elemental", "2.4 GB"),
    ]

    static let profiles: [(name: String, color: Color, isKids: Bool)] = [
        ("Primary", LpspDisneyTokens.dpBlue, false),
        ("Kids", Color(red: 0.20, green: 0.72, blue: 0.55), true),
    ]
}

@MainActor
fileprivate final class LpspDisneyStore: ObservableObject {
    @Published var selectedTab: LpspDisneyShowroomTab = .home
    @Published var selectedPortal: LpspDisneyBrandPortal = .pixar
    @Published var titles: [LpspDisneyTitle]
    @Published var searchQuery = ""
    @Published var isHeroMuted = true
    @Published var isPlaying = false
    @Published var playingTitleID: String?
    @Published var focusedContinueID: String?
    @Published var activeProfile = "Primary"

    init() {
        titles = LpspDisneyShowroomData.catalog
        focusedContinueID = LpspDisneyShowroomData.continueWatching.first?.id
    }

    var featured: LpspDisneyTitle {
        titles.first { $0.id == LpspDisneyShowroomData.featuredID } ?? LpspDisneyShowroomData.featured
    }

    var continueWatching: [LpspDisneyTitle] {
        LpspDisneyShowroomData.continueWatching.compactMap { item in
            titles.first { $0.id == item.id } ?? item
        }
    }

    var watchlist: [LpspDisneyTitle] {
        titles.filter(\.inWatchlist)
    }

    var filteredCatalog: [LpspDisneyTitle] {
        guard !searchQuery.isEmpty else { return titles }
        return titles.filter {
            $0.name.localizedCaseInsensitiveContains(searchQuery)
                || $0.brand.label.localizedCaseInsensitiveContains(searchQuery)
                || $0.meta.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    func selectPortal(_ portal: LpspDisneyBrandPortal) {
        selectedPortal = portal
    }

    func focusContinue(_ id: String) {
        focusedContinueID = id
    }

    func toggleWatchlist(titleID: String) {
        guard let index = titles.firstIndex(where: { $0.id == titleID }) else { return }
        titles[index].inWatchlist.toggle()
    }

    func playFeatured() {
        playingTitleID = LpspDisneyShowroomData.featuredID
        isPlaying = true
    }

    func resumeTitle(_ id: String) {
        playingTitleID = id
        isPlaying = true
        selectedTab = .home
    }

    func toggleHeroMute() {
        isHeroMuted.toggle()
    }
}

// MARK: - Écrans showroom

private struct LpspDisneyShowroomRoot: View {
    @ObservedObject var store: LpspDisneyStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspDisneyShowroomTab.allCases) { tab in
                LpspDisneyShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .tint(LpspDisneyTokens.dpBlue)
        .preferredColorScheme(.dark)
    }
}

private struct LpspDisneyShowroomTabScreen: View {
    @ObservedObject var store: LpspDisneyStore
    let tab: LpspDisneyShowroomTab

    var body: some View {
        NavigationStack {
            Group {
                switch tab {
                case .home:
                    LpspDisneyHomeTabScreen(store: store)
                case .search:
                    LpspDisneySearchTabScreen(store: store)
                case .watchlist:
                    LpspDisneyWatchlistTabScreen(store: store)
                case .downloads:
                    LpspDisneyDownloadsTabScreen()
                case .profile:
                    LpspDisneyProfileTabScreen(store: store)
                }
            }
            .navigationTitle(tab == .home ? "" : tab.title)
            .navigationBarTitleDisplayMode(tab == .home ? .inline : .large)
            .background(LpspDisneyTokens.dpCanvas.ignoresSafeArea())
        }
    }
}

private struct LpspDisneyStarfield: View {
    private let stars: [(x: CGFloat, y: CGFloat, size: CGFloat, opacity: Double)] = [
        (0.12, 0.08, 1.5, 0.55), (0.28, 0.14, 1.0, 0.35), (0.44, 0.06, 1.2, 0.45),
        (0.62, 0.11, 1.0, 0.30), (0.78, 0.18, 1.4, 0.50), (0.88, 0.09, 1.0, 0.40),
        (0.18, 0.24, 1.0, 0.25), (0.52, 0.22, 1.2, 0.38), (0.70, 0.28, 1.0, 0.32),
        (0.34, 0.32, 1.0, 0.28), (0.90, 0.34, 1.3, 0.42), (0.08, 0.36, 1.0, 0.22),
    ]

    var body: some View {
        GeometryReader { geo in
            ForEach(Array(stars.enumerated()), id: \.offset) { _, star in
                Circle()
                    .fill(Color.white.opacity(star.opacity))
                    .frame(width: star.size, height: star.size)
                    .position(x: geo.size.width * star.x, y: geo.size.height * star.y)
            }
        }
    }
}

private struct LpspDisneyHomeTabScreen: View {
    @ObservedObject var store: LpspDisneyStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LpspDisneyBillboardHero(store: store)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(LpspDisneyBrandPortal.allCases) { portal in
                            LpspDisneyPortalTile(
                                portal: portal,
                                isFocused: store.selectedPortal == portal,
                                onSelect: { store.selectPortal(portal) }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 18)

                Text("Continue Watching")
                    .font(LpspDisneyFonts.dpRowHeader.weight(.semibold))
                    .foregroundStyle(LpspDisneyTokens.dpTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 22)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(store.continueWatching) { title in
                            LpspDisneyContinueCard(
                                title: title,
                                isFocused: store.focusedContinueID == title.id,
                                onFocus: { store.focusContinue(title.id) },
                                onPlay: { store.resumeTitle(title.id) }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

private struct LpspDisneyBillboardHero: View {
    @ObservedObject var store: LpspDisneyStore

    private var featured: LpspDisneyTitle { store.featured }

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                LinearGradient(
                    colors: featured.gradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                LpspDisneyStarfield()

                LinearGradient(
                    colors: [.clear, .clear, LpspDisneyTokens.dpCanvas],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .frame(height: 380)

            Button {
                store.toggleHeroMute()
            } label: {
                Image(systemName: store.isHeroMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(Color.black.opacity(0.45)))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 16)
            .padding(.bottom, 96)

            VStack(spacing: 12) {
                Text(featured.name)
                    .font(LpspDisneyFonts.dpBillboard.weight(.bold))
                    .kerning(4)
                    .foregroundStyle(LpspDisneyTokens.dpTextPrimary)
                    .shadow(color: .black.opacity(0.5), radius: 12, y: 2)

                Text(featured.meta)
                    .font(LpspDisneyFonts.dpMetaStrip.weight(.semibold))
                    .foregroundStyle(LpspDisneyTokens.dpTextSecondary)

                HStack(spacing: 12) {
                    LpspDisneyDPPlayButton(label: store.isPlaying && store.playingTitleID == featured.id ? "Playing" : "Play") {
                        store.playFeatured()
                    }

                    LpspDisneyDPSecondaryButton(
                        icon: featured.inWatchlist ? "checkmark" : "plus",
                        label: featured.inWatchlist ? "Watchlisted" : "Watchlist"
                    ) {
                        store.toggleWatchlist(titleID: featured.id)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspDisneyPortalTile: View {
    let portal: LpspDisneyBrandPortal
    let isFocused: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            Text(portal.label)
                .font(LpspDisneyFonts.dpCardTitle.weight(.bold))
                .kerning(1)
                .foregroundStyle(LpspDisneyTokens.dpTextPrimary)
                .frame(width: 132, height: 80)
                .background(
                    LinearGradient(
                        colors: portal.gradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            isFocused ? LpspDisneyTokens.dpGlowBlue : LpspDisneyTokens.dpDivider,
                            lineWidth: isFocused ? 2 : 1
                        )
                )
                .scaleEffect(isFocused ? 1.04 : 1)
                .shadow(color: isFocused ? LpspDisneyTokens.dpGlowBlue.opacity(0.35) : .clear, radius: 24)
                .animation(.easeOut(duration: 0.18), value: isFocused)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspDisneyContinueCard: View {
    let title: LpspDisneyTitle
    let isFocused: Bool
    let onFocus: () -> Void
    let onPlay: () -> Void

    var body: some View {
        Button {
            onFocus()
            onPlay()
        } label: {
            ZStack(alignment: .bottom) {
                LinearGradient(
                    colors: title.gradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: 200, height: 113)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 34))
                        .foregroundStyle(.white.opacity(0.9))
                }

                if let progress = title.progress {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.white.opacity(0.25))
                            Rectangle()
                                .fill(LpspDisneyTokens.dpBlue)
                                .frame(width: geo.size.width * progress)
                        }
                    }
                    .frame(height: 3)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(isFocused ? LpspDisneyTokens.dpGlowBlue : .clear, lineWidth: 2)
            )
            .scaleEffect(isFocused ? 1.04 : 1)
            .shadow(color: isFocused ? LpspDisneyTokens.dpFocusGlow : .clear, radius: 24)
            .animation(.easeOut(duration: 0.18), value: isFocused)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspDisneySearchTabScreen: View {
    @ObservedObject var store: LpspDisneyStore

    var body: some View {
        List {
            Section {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspDisneyTokens.dpTextSecondary)
                    TextField("Movies, series, brands", text: $store.searchQuery)
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(LpspDisneyTokens.dpTextPrimary)
                }
            }

            Section("Popular") {
                ForEach(LpspDisneyShowroomData.searchSuggestions, id: \.self) { item in
                    Button {
                        store.searchQuery = item
                    } label: {
                        Text(item)
                            .foregroundStyle(LpspDisneyTokens.dpTextPrimary)
                    }
                }
            }

            if !store.searchQuery.isEmpty {
                Section("Results") {
                    ForEach(store.filteredCatalog) { title in
                        Button {
                            store.resumeTitle(title.id)
                        } label: {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(
                                        LinearGradient(
                                            colors: title.gradient,
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 88, height: 50)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(title.name)
                                        .font(LpspDisneyFonts.dpCardTitle.weight(.semibold))
                                        .foregroundStyle(LpspDisneyTokens.dpTextPrimary)
                                    Text(title.meta)
                                        .font(LpspDisneyFonts.dpMeta)
                                        .foregroundStyle(LpspDisneyTokens.dpTextSecondary)
                                }
                            }
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspDisneyTokens.dpCanvas.ignoresSafeArea())
    }
}

private struct LpspDisneyWatchlistTabScreen: View {
    @ObservedObject var store: LpspDisneyStore

    var body: some View {
        Group {
            if store.watchlist.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .font(.system(size: 40))
                        .foregroundStyle(LpspDisneyTokens.dpTextTertiary)
                    Text("Your watchlist is empty")
                        .font(LpspDisneyFonts.dpSubtitle)
                        .foregroundStyle(LpspDisneyTokens.dpTextSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(store.watchlist) { title in
                        Button {
                            store.resumeTitle(title.id)
                        } label: {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(
                                        LinearGradient(
                                            colors: title.gradient,
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 120, height: 68)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(title.name)
                                        .font(LpspDisneyFonts.dpCardTitle.weight(.semibold))
                                        .foregroundStyle(LpspDisneyTokens.dpTextPrimary)
                                    Text(title.brand.label)
                                        .font(LpspDisneyFonts.dpMeta)
                                        .foregroundStyle(LpspDisneyTokens.dpTextSecondary)
                                }

                                Spacer()

                                Button {
                                    store.toggleWatchlist(titleID: title.id)
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(LpspDisneyTokens.dpBlue)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .background(LpspDisneyTokens.dpCanvas.ignoresSafeArea())
    }
}

private struct LpspDisneyDownloadsTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspDisneyShowroomData.downloads, id: \.0) { title, size in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(LpspDisneyTokens.dpSurface2)
                        .frame(width: 88, height: 50)
                        .overlay {
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundStyle(LpspDisneyTokens.dpBlue)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(LpspDisneyFonts.dpCardTitle.weight(.semibold))
                            .foregroundStyle(LpspDisneyTokens.dpTextPrimary)
                        Text(size)
                            .font(LpspDisneyFonts.dpMeta)
                            .foregroundStyle(LpspDisneyTokens.dpTextSecondary)
                    }
                }
                .listRowBackground(LpspDisneyTokens.dpSurface1)
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspDisneyTokens.dpCanvas.ignoresSafeArea())
    }
}

private struct LpspDisneyProfileTabScreen: View {
    @ObservedObject var store: LpspDisneyStore

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                Text("Who's watching?")
                    .font(LpspDisneyFonts.dpBillboard.weight(.bold))
                    .foregroundStyle(LpspDisneyTokens.dpTextPrimary)

                ForEach(LpspDisneyShowroomData.profiles, id: \.name) { profile in
                    Button {
                        store.activeProfile = profile.name
                    } label: {
                        VStack(spacing: 10) {
                            Circle()
                                .fill(profile.color.opacity(0.85))
                                .frame(width: 72, height: 72)
                                .overlay {
                                    Text(String(profile.name.prefix(1)))
                                        .font(.title2.weight(.bold))
                                        .foregroundStyle(.white)
                                }
                                .overlay(
                                    Circle()
                                        .stroke(
                                            store.activeProfile == profile.name
                                                ? LpspDisneyTokens.dpGlowBlue
                                                : Color.clear,
                                            lineWidth: 3
                                        )
                                )
                                .scaleEffect(store.activeProfile == profile.name ? 1.04 : 1)
                                .shadow(
                                    color: store.activeProfile == profile.name
                                        ? LpspDisneyTokens.dpFocusGlow
                                        : .clear,
                                    radius: 24
                                )

                            Text(profile.name)
                                .font(LpspDisneyFonts.dpSubtitle)
                                .foregroundStyle(
                                    store.activeProfile == profile.name
                                        ? LpspDisneyTokens.dpTextPrimary
                                        : LpspDisneyTokens.dpTextSecondary
                                )
                        }
                    }
                    .buttonStyle(.plain)
                    .animation(.easeOut(duration: 0.18), value: store.activeProfile)
                }
            }
            .padding(.vertical, 32)
        }
    }
}



import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/apple-tv
// Meliwat/awesome-ios-design-md/video/apple-tv/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAppleTVView: View {
    var body: some View {
        LpspAppleTVShowroomRoot(store: LpspAppleTVStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspAppleTVTokens {
    static let atvCanvas    = Color.black                                     // #000000
    static let atvSurface1  = Color(red: 0.110, green: 0.110, blue: 0.118)   // #1C1C1E
    static let atvSurface2  = Color(red: 0.173, green: 0.173, blue: 0.180)   // #2C2C2E
    static let atvDivider   = Color(red: 0.220, green: 0.220, blue: 0.227)   // #38383A
    static let atvTextPrimary   = Color.white                                 // #FFFFFF
    static let atvTextSecondary = Color(red: 0.596, green: 0.596, blue: 0.624) // #98989F
    static let atvTextTertiary  = Color(red: 0.388, green: 0.388, blue: 0.400) // #636366
    static let atvCTA        = Color.white                                    // #FFFFFF
    static let atvCTAPressed = Color(red: 0.898, green: 0.898, blue: 0.918)   // #E5E5EA
    static let atvCTALabel   = Color.black                                    // #000000
    static let atvBlue        = Color(red: 0.039, green: 0.518, blue: 1.000)  // #0A84FF
    static let atvBluePressed = Color(red: 0.000, green: 0.376, blue: 0.875)  // #0060DF
    static let atvMLS     = Color(red: 0.929, green: 0.102, blue: 0.435)      // #ED1A6F (MLS only)
    static let atvLive    = Color(red: 1.000, green: 0.271, blue: 0.227)      // #FF453A
    static let atvSuccess = Color(red: 0.188, green: 0.820, blue: 0.345)      // #30D158
    static let atvGold    = Color(red: 1.000, green: 0.839, blue: 0.039)      // #FFD60A
    static let atvGlassFill = Color(red: 0.471, green: 0.471, blue: 0.502).opacity(0.36)
}





private enum LpspAppleTVGradients {
    /// Hero card bottom scrim.
    static let atvHeroScrim = LinearGradient(
        stops: [
            .init(color: .clear,                location: 0.40),
            .init(color: .black.opacity(0.65),  location: 0.72),
            .init(color: .black.opacity(0.92),  location: 1.0),
        ],
        startPoint: .top, endPoint: .bottom
    )
}

private enum LpspAppleTVFonts {
    // Prefer system styles on iOS — they ARE SF Pro with optical sizing + Dynamic Type
    static let atvLargeTitle = Font.system(size: 34, weight: .heavy)
    static let atvHeroTitle  = Font.system(size: 28, weight: .heavy)
    static let atvRowHeader  = Font.system(size: 22, weight: .bold)
    static let atvTitle3     = Font.system(size: 20, weight: .semibold)
    static let atvBody       = Font.system(size: 17, weight: .regular)
    static let atvHeadline   = Font.system(size: 15, weight: .semibold)
    static let atvSubhead    = Font.system(size: 13, weight: .regular)
    static let atvCaption    = Font.system(size: 12, weight: .medium)
    static let atvEyebrow    = Font.system(size: 11, weight: .bold)
    static let atvButton     = Font.system(size: 15, weight: .semibold)
    static let atvChannelTag = Font.system(size: 9, weight: .bold)

    // Non-Apple build (Inter substitute):
    // static let atvLargeTitle = Font.custom("Inter-ExtraBold", size: 34)
}

// Eyebrow modifier — 11pt uppercase tracked, secondary
fileprivate struct LpspAppleTVATVEyebrow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(LpspAppleTVFonts.atvEyebrow)
            .tracking(1.2)
            .textCase(.uppercase)
            .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
    }
}
fileprivate extension View { func atvEyebrow() -> some View { modifier(LpspAppleTVATVEyebrow()) } }

fileprivate struct LpspAppleTVHeroCard: View {
    let artURL: URL?
    let eyebrow: String        // "Apple TV+ · New Episode"
    let title: String
    let meta: String
    let onPlay: () -> Void
    let onAdd: () -> Void

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: artURL) { img in
                img.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle().fill(LpspAppleTVTokens.atvSurface1)
            }
            .frame(height: 380)
            .clipped()

            LpspAppleTVGradients.atvHeroScrim

            VStack(alignment: .leading, spacing: 7) {
                Text(eyebrow).atvEyebrow()
                Text(title).font(LpspAppleTVFonts.atvHeroTitle).foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                Text(meta).font(LpspAppleTVFonts.atvCaption).foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                HStack(spacing: 10) {
                    Button(action: onPlay) {
                        Label("Play", systemImage: "play.fill")
                            .font(LpspAppleTVFonts.atvButton)
                            .foregroundStyle(LpspAppleTVTokens.atvCTALabel)
                            .padding(.vertical, 13).padding(.horizontal, 30)
                            .background(LpspAppleTVTokens.atvCTA, in: RoundedRectangle(cornerRadius: 12))
                    }
                    Button(action: onAdd) {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                }
                .padding(.top, 7)
            }
            .padding(18)
        }
        .frame(height: 380)
        .clipShape(RoundedRectangle(cornerRadius: 16))   // inset + rounded = floating gallery
        .padding(.horizontal, 14)
    }
}

fileprivate struct LpspAppleTVUpNextThumb: View {
    let artURL: URL?
    let title: String
    let subhead: String       // "S3 E8 · 24 min left"
    var progress: Double = 0  // 0...1; 0 hides the bar
    var channelTag: String? = "Apple TV+"
    @State private var pressed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: artURL) { $0.resizable().aspectRatio(contentMode: .fill) }
                    placeholder: { Rectangle().fill(LpspAppleTVTokens.atvSurface1) }
                    .frame(width: 196, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                if let channelTag {
                    Text(channelTag)
                        .font(LpspAppleTVFonts.atvChannelTag).tracking(0.4)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6).padding(.vertical, 3)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                        .padding(8)
                }
                if progress > 0 {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.white.opacity(0.28))
                            Rectangle().fill(Color.white).frame(width: geo.size.width * progress)
                        }
                        .frame(height: 4)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                    .frame(width: 196, height: 110)
                }
            }
            Text(title).font(LpspAppleTVFonts.atvHeadline).foregroundStyle(LpspAppleTVTokens.atvTextPrimary).lineLimit(1)
            Text(subhead).font(LpspAppleTVFonts.atvSubhead).foregroundStyle(LpspAppleTVTokens.atvTextSecondary).lineLimit(1)
        }
        .frame(width: 196)
        .scaleEffect(pressed ? 0.97 : 1)
        .animation(.easeOut(duration: 0.12), value: pressed)
        ._onButtonGesture { pressed = $0 } perform: {}
    }
}

fileprivate struct LpspAppleTVLiveBadge: View {
    @State private var dim = false
    var body: some View {
        HStack(spacing: 6) {
            Circle().fill(.white).frame(width: 7, height: 7)
                .opacity(dim ? 0.4 : 1)
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: dim)
            Text("LIVE").font(LpspAppleTVFonts.atvEyebrow).tracking(0.6).foregroundStyle(.white)
        }
        .padding(.horizontal, 10).padding(.vertical, 5)
        .background(LpspAppleTVTokens.atvLive, in: RoundedRectangle(cornerRadius: 6))
        .onAppear { dim = true }
    }
}

fileprivate struct LpspAppleTVMLSChip: View {
    let title: String   // "MLS Season Pass"
    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(.white)
            .padding(.horizontal, 14).padding(.vertical, 7)
            .background(LpspAppleTVTokens.atvMLS, in: RoundedRectangle(cornerRadius: 10)) // the ONLY non-system color
    }
}

fileprivate struct LpspAppleTVShelfHeader: View {
    let title: String
    var accessory: AnyView? = nil
    var body: some View {
        HStack(spacing: 8) {
            Text(title).font(LpspAppleTVFonts.atvRowHeader).foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
            if let accessory { accessory }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(LpspAppleTVTokens.atvTextTertiary)
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 10)
    }
}


fileprivate struct LpspAppleTVAppleTVTheme: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LpspAppleTVTokens.atvCanvas)            // pure #000000
            .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
            .preferredColorScheme(.dark)            // browse is always true-black
    }
}
fileprivate extension View { func appleTVTheme() -> some View { modifier(LpspAppleTVAppleTVTheme()) } }

// MARK: - Showroom data & store

private enum LpspAppleTVShowroomTab: String, CaseIterable, Identifiable {
    case watchNow, tvPlus, store, search

    var id: String { rawValue }

    var title: String {
        switch self {
        case .watchNow: "Watch Now"
        case .tvPlus: "TV+"
        case .store: "Store"
        case .search: "Search"
        }
    }

    var icon: String {
        switch self {
        case .watchNow: "play.tv.fill"
        case .tvPlus: "appletv"
        case .store: "bag.fill"
        case .search: "magnifyingglass"
        }
    }
}

private struct LpspAppleTVShow: Identifiable, Equatable {
    let id: String
    let title: String
    let eyebrow: String
    let meta: String
    let subhead: String
    let artworkColors: [Color]
    var progress: Double = 0
    var channelTag: String? = "Apple TV+"
    var isLive: Bool = false
    var inWatchlist: Bool = false
}

private enum LpspAppleTVShowroomData {
    static let severance = LpspAppleTVShow(
        id: "severance",
        title: "Severance",
        eyebrow: "Apple TV+ · New Episode",
        meta: "Season 2 · Episode 6 · Thriller · TV-MA",
        subhead: "Continue watching",
        artworkColors: [
            Color(red: 0.12, green: 0.42, blue: 0.48),
            Color(red: 0.04, green: 0.12, blue: 0.18),
        ]
    )

    static let upNext: [LpspAppleTVShow] = [
        LpspAppleTVShow(
            id: "ted-lasso",
            title: "Ted Lasso",
            eyebrow: "Apple TV+",
            meta: "Comedy · TV-MA",
            subhead: "S3 E8 · 24 min left",
            artworkColors: [
                Color(red: 0.18, green: 0.52, blue: 0.28),
                Color(red: 0.08, green: 0.28, blue: 0.16),
            ],
            progress: 0.62
        ),
        LpspAppleTVShow(
            id: "slow-horses",
            title: "Slow Horses",
            eyebrow: "Apple TV+",
            meta: "Thriller · TV-MA",
            subhead: "S4 E2 · 41 min left",
            artworkColors: [
                Color(red: 0.42, green: 0.32, blue: 0.12),
                Color(red: 0.18, green: 0.14, blue: 0.08),
            ],
            progress: 0.38
        ),
        LpspAppleTVShow(
            id: "morning-show",
            title: "The Morning Show",
            eyebrow: "Apple TV+ · New Episode",
            meta: "Drama · TV-MA",
            subhead: "New Episode",
            artworkColors: [
                Color(red: 0.52, green: 0.22, blue: 0.32),
                Color(red: 0.22, green: 0.10, blue: 0.18),
            ]
        ),
    ]

    static let mls: [LpspAppleTVShow] = [
        LpspAppleTVShow(
            id: "inter-miami",
            title: "Inter Miami vs LA",
            eyebrow: "MLS Season Pass",
            meta: "Matchday 28 · 2nd Half",
            subhead: "Matchday 28 · 2nd Half",
            artworkColors: [
                Color(red: 0.82, green: 0.12, blue: 0.42),
                Color(red: 0.42, green: 0.08, blue: 0.28),
            ],
            isLive: true
        ),
        LpspAppleTVShow(
            id: "lafc-seattle",
            title: "LAFC vs Seattle",
            eyebrow: "MLS Season Pass",
            meta: "Today · 7:30 PM",
            subhead: "Today · 7:30 PM",
            artworkColors: [
                Color(red: 0.12, green: 0.38, blue: 0.72),
                Color(red: 0.06, green: 0.18, blue: 0.38),
            ]
        ),
    ]

    static let tvPlusOriginals = ["Severance", "Ted Lasso", "Slow Horses", "The Morning Show", "Foundation", "Shrinking"]

    static let storeTitles = ["Dune: Part Two", "Killers of the Flower Moon", "Napoleon", "Argylle"]

    static let searchSuggestions = ["Thriller", "Comedy", "Apple TV+ Originals", "MLS"]
}

@MainActor
fileprivate final class LpspAppleTVStore: ObservableObject {
    @Published var selectedTab: LpspAppleTVShowroomTab = .watchNow
    @Published var featured: LpspAppleTVShow = LpspAppleTVShowroomData.severance
    @Published var upNext: [LpspAppleTVShow] = LpspAppleTVShowroomData.upNext
    @Published var mls: [LpspAppleTVShow] = LpspAppleTVShowroomData.mls
    @Published var isPlaying = false
    @Published var playingShowID: String?
    @Published var searchQuery = ""

    func playFeatured() {
        isPlaying = true
        playingShowID = featured.id
    }

    func playShow(_ show: LpspAppleTVShow) {
        featured = show
        isPlaying = true
        playingShowID = show.id
        selectedTab = .watchNow
    }

    func toggleFeaturedWatchlist() {
        var updated = featured
        updated.inWatchlist.toggle()
        featured = updated
    }
}

// MARK: - Écrans showroom

private struct LpspAppleTVShowroomRoot: View {
    @ObservedObject var store: LpspAppleTVStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .watchNow:
                    LpspAppleTVSpectrHomeTabScreen(store: store)
                case .tvPlus:
                    LpspAppleTVPlusTabScreen(store: store)
                case .store:
                    LpspAppleTVStoreTabScreen()
                case .search:
                    LpspAppleTVSearchTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspAppleTVLabeledTabBar(store: store)
        }
        .background(LpspAppleTVTokens.atvCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspAppleTVLabeledTabBar: View {
    @ObservedObject var store: LpspAppleTVStore

    var body: some View {
        HStack {
            ForEach(LpspAppleTVShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(.system(size: 10, weight: store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspAppleTVTokens.atvTextPrimary
                            : LpspAppleTVTokens.atvTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspAppleTVTokens.atvCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspAppleTVTokens.atvDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspAppleTVSpectrTitleBar: View {
    var body: some View {
        HStack {
            Text("Watch Now")
                .font(LpspAppleTVFonts.atvLargeTitle)
                .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)

            Spacer()

            Circle()
                .fill(
                    LinearGradient(
                        colors: [.orange, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 36, height: 36)
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
        .padding(.bottom, 4)
    }
}

private struct LpspAppleTVShowroomHeroCard: View {
    let show: LpspAppleTVShow
    let onPlay: () -> Void
    let onAdd: () -> Void
    let isInWatchlist: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: show.artworkColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 380)
            .clipped()

            LpspAppleTVGradients.atvHeroScrim

            VStack(alignment: .leading, spacing: 7) {
                Text(show.eyebrow).atvEyebrow()
                Text(show.title)
                    .font(LpspAppleTVFonts.atvHeroTitle)
                    .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                Text(show.meta)
                    .font(LpspAppleTVFonts.atvCaption)
                    .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                HStack(spacing: 10) {
                    Button(action: onPlay) {
                        Label("Play", systemImage: "play.fill")
                            .font(LpspAppleTVFonts.atvButton)
                            .foregroundStyle(LpspAppleTVTokens.atvCTALabel)
                            .padding(.vertical, 13)
                            .padding(.horizontal, 30)
                            .background(LpspAppleTVTokens.atvCTA, in: RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)

                    Button(action: onAdd) {
                        Image(systemName: isInWatchlist ? "checkmark" : "plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 7)
            }
            .padding(18)
        }
        .frame(height: 380)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 14)
    }
}

private struct LpspAppleTVShowroomUpNextThumb: View {
    let show: LpspAppleTVShow
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topLeading) {
                    LinearGradient(
                        colors: show.artworkColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(width: 196, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    if show.isLive {
                        LpspAppleTVLiveBadge()
                            .padding(8)
                    } else if let channelTag = show.channelTag {
                        Text(channelTag)
                            .font(LpspAppleTVFonts.atvChannelTag)
                            .tracking(0.4)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                            .padding(8)
                    }

                    if show.progress > 0 {
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Rectangle().fill(Color.white.opacity(0.28))
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: geo.size.width * show.progress)
                            }
                            .frame(height: 4)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                        .frame(width: 196, height: 110)
                    }
                }

                Text(show.title)
                    .font(LpspAppleTVFonts.atvHeadline)
                    .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                    .lineLimit(1)
                Text(show.subhead)
                    .font(LpspAppleTVFonts.atvSubhead)
                    .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                    .lineLimit(1)
            }
            .frame(width: 196)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspAppleTVSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspAppleTVStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                LpspAppleTVSpectrTitleBar()

                LpspAppleTVShowroomHeroCard(
                    show: store.featured,
                    onPlay: { store.playFeatured() },
                    onAdd: { store.toggleFeaturedWatchlist() },
                    isInWatchlist: store.featured.inWatchlist
                )

                VStack(alignment: .leading, spacing: 10) {
                    LpspAppleTVShelfHeader(title: "Up Next")

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(store.upNext) { show in
                                LpspAppleTVShowroomUpNextThumb(show: show) {
                                    store.playShow(show)
                                }
                            }
                        }
                        .padding(.horizontal, 18)
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    LpspAppleTVShelfHeader(
                        title: "MLS Season Pass",
                        accessory: AnyView(LpspAppleTVMLSChip(title: "MLS"))
                    )

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(store.mls) { show in
                                LpspAppleTVShowroomUpNextThumb(show: show) {
                                    store.playShow(show)
                                }
                            }
                        }
                        .padding(.horizontal, 18)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspAppleTVPlusTabScreen: View {
    @ObservedObject var store: LpspAppleTVStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Apple TV+")
                    .font(LpspAppleTVFonts.atvLargeTitle)
                    .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                    .padding(.horizontal, 18)
                    .padding(.top, 8)

                Text("Original series and films")
                    .font(LpspAppleTVFonts.atvSubhead)
                    .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                    .padding(.horizontal, 18)

                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 12
                ) {
                    ForEach(Array(LpspAppleTVShowroomData.tvPlusOriginals.enumerated()), id: \.offset) { index, title in
                        Button {
                            if title == "Severance" {
                                store.playShow(store.featured)
                            } else if let show = store.upNext.first(where: { $0.title == title }) {
                                store.playShow(show)
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(
                                        colors: store.upNext[index % store.upNext.count].artworkColors,
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(height: 140)
                                .overlay(alignment: .bottomLeading) {
                                    Text(title)
                                        .font(LpspAppleTVFonts.atvHeadline)
                                        .foregroundStyle(.white)
                                        .padding(10)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 18)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspAppleTVStoreTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Store")
                    .font(LpspAppleTVFonts.atvLargeTitle)
                    .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                    .padding(.horizontal, 18)
                    .padding(.top, 8)

                Text("Movies to rent or buy")
                    .font(LpspAppleTVFonts.atvSubhead)
                    .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                    .padding(.horizontal, 18)

                ForEach(LpspAppleTVShowroomData.storeTitles, id: \.self) { title in
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LpspAppleTVTokens.atvSurface1)
                            .frame(width: 72, height: 108)
                            .overlay {
                                Image(systemName: "film")
                                    .foregroundStyle(LpspAppleTVTokens.atvTextTertiary)
                            }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(LpspAppleTVFonts.atvHeadline)
                                .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                            Text("Rent $5.99 · Buy $14.99")
                                .font(LpspAppleTVFonts.atvSubhead)
                                .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 6)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspAppleTVSearchTabScreen: View {
    @ObservedObject var store: LpspAppleTVStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                    TextField("Shows, movies, sports", text: $store.searchQuery)
                        .font(LpspAppleTVFonts.atvBody)
                        .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                        .tint(LpspAppleTVTokens.atvBlue)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LpspAppleTVTokens.atvSurface1)
                )
                .padding(.horizontal, 18)
                .padding(.top, 8)

                ForEach(LpspAppleTVShowroomData.searchSuggestions, id: \.self) { term in
                    Button {
                        store.searchQuery = term
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(LpspAppleTVTokens.atvTextTertiary)
                            Text(term)
                                .font(LpspAppleTVFonts.atvBody)
                                .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                            Spacer()
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }

                if !store.searchQuery.isEmpty {
                    Text("Results")
                        .font(LpspAppleTVFonts.atvRowHeader)
                        .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                        .padding(.horizontal, 18)
                        .padding(.top, 8)

                    ForEach(filteredShows) { show in
                        Button {
                            store.playShow(show)
                        } label: {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        LinearGradient(
                                            colors: show.artworkColors,
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 64, height: 40)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(show.title)
                                        .font(LpspAppleTVFonts.atvHeadline)
                                        .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                                    Text(show.subhead)
                                        .font(LpspAppleTVFonts.atvSubhead)
                                        .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 6)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }

    private var filteredShows: [LpspAppleTVShow] {
        let all = [store.featured] + store.upNext + store.mls
        guard !store.searchQuery.isEmpty else { return all }
        return all.filter {
            $0.title.localizedCaseInsensitiveContains(store.searchQuery)
                || $0.meta.localizedCaseInsensitiveContains(store.searchQuery)
        }
    }
}


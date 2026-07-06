import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/prime-video
// Meliwat/awesome-ios-design-md/video/prime-video/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePrimeVideoView: View {
    var body: some View {
        LpspPrimeVideoShowroomRoot(store: LpspPrimeVideoStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspPrimeVideoFonts {
    static let primeDetailsTitle = Font.system(size: 30, weight: .regular)
    static let primeTitleLarge   = Font.system(size: 28, weight: .regular)
    static let primeRowHeader    = Font.system(size: 22, weight: .regular)
    static let primeSectionHeader = Font.system(size: 20, weight: .regular)
    static let primeEpisodeTitle = Font.system(size: 16, weight: .regular)
    static let primeTileTitle    = Font.system(size: 15, weight: .regular)
    static let primeBody         = Font.system(size: 15, weight: .regular)
    static let primeMeta         = Font.system(size: 13, weight: .regular)
    static let primeTileSubtitle = Font.system(size: 12, weight: .regular)
    static let primeLabelUpper   = Font.system(size: 11, weight: .regular)
    static let primeButton       = Font.system(size: 16, weight: .regular)
    static let primeButtonSecondary = Font.system(size: 15, weight: .regular)
    static let primeTab          = Font.system(size: 10, weight: .regular)
    static let primeBadge        = Font.system(size: 11, weight: .regular)
    static func prime(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspPrimeVideoTokens {
    // MARK: - Canvas & Surfaces
    static let primeCanvas    = Color(red: 0.059, green: 0.090, blue: 0.118) // #0F171E
    static let primeDeepBlack = Color.black                                  // #000000
    static let primeSurface1  = Color(red: 0.102, green: 0.141, blue: 0.184) // #1A242F
    static let primeSurface2  = Color(red: 0.137, green: 0.184, blue: 0.243) // #232F3E
    static let primeSurface3  = Color(red: 0.180, green: 0.231, blue: 0.278) // #2E3B47
    static let primeDivider   = Color(red: 0.180, green: 0.231, blue: 0.278) // #2E3B47

    // MARK: - Text
    static let primeTextPrimary   = Color.white                                // #FFFFFF
    static let primeTextSecondary = Color(red: 0.667, green: 0.718, blue: 0.769) // #AAB7C4
    static let primeTextTertiary  = Color(red: 0.431, green: 0.482, blue: 0.537) // #6E7B89

    // MARK: - Brand
    static let primeBlue        = Color(red: 0.000, green: 0.659, blue: 0.882) // #00A8E1
    static let primeBluePressed = Color(red: 0.000, green: 0.549, blue: 0.741) // #008CBD
    static let primeImdbYellow  = Color(red: 0.961, green: 0.773, blue: 0.094) // #F5C518
    static let primeLiveRed     = Color(red: 0.898, green: 0.035, blue: 0.078) // #E50914
}





fileprivate struct LpspPrimeVideoPrimePlayButton: View {
    var title: String = "Play"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill").font(.system(size: 18, weight: .bold))
                Text(title).font(LpspPrimeVideoFonts.primeButton).tracking(0.2)
            }
            .foregroundStyle(LpspPrimeVideoTokens.primeCanvas) // intentional: dark-navy on bright blue
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(RoundedRectangle(cornerRadius: 8).fill(LpspPrimeVideoTokens.primeBlue))
            .shadow(color: LpspPrimeVideoTokens.primeBlue.opacity(0.32), radius: 24, y: 8)
        }
        .sensoryFeedback(.impact(weight: .light), trigger: title)
        .buttonStyle(LpspPrimeVideoPrimePressableStyle(pressedScale: 0.97))
    }
}

fileprivate struct LpspPrimeVideoPrimePressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspPrimeVideoPrimeWatchlistButton: View {
    @Binding var added: Bool
    @State private var bump = false

    var body: some View {
        Button {
            added.toggle()
            bump = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: added ? "checkmark" : "plus")
                    .font(.system(size: 16, weight: .bold))
                Text(added ? "Watchlisted" : "Watchlist").font(LpspPrimeVideoFonts.primeButtonSecondary)
            }
            .foregroundStyle(added ? LpspPrimeVideoTokens.primeBlue : .white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.14)))
            .scaleEffect(bump ? 1.15 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: bump)
        }
        .sensoryFeedback(.success, trigger: added)
        .onChange(of: bump) { _, v in if v { DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { bump = false } } }
        .buttonStyle(LpspPrimeVideoPrimePressableStyle())
    }
}

fileprivate struct LpspPrimeVideoPrimeContentTile: View {
    let title: String
    let artwork: Image
    var includedWithPrime: Bool = false
    var progress: Double? = nil
    let width: CGFloat
    var aspect: CGFloat = 2/3

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottom) {
                artwork
                    .resizable()
                    .aspectRatio(aspect, contentMode: .fill)
                    .frame(width: width, height: width / aspect)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                if let progress {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.white.opacity(0.25))
                            Rectangle().fill(LpspPrimeVideoTokens.primeBlue).frame(width: geo.size.width * progress)
                        }
                    }
                    .frame(height: 3)
                }
            }
            Text(title).font(LpspPrimeVideoFonts.primeTileTitle).foregroundStyle(.white).lineLimit(1)
            if includedWithPrime {
                Text("Included with Prime")
                    .font(LpspPrimeVideoFonts.primeTileSubtitle)
                    .foregroundStyle(LpspPrimeVideoTokens.primeBlue)
            }
        }
        .frame(width: width)
    }
}

fileprivate struct LpspPrimeVideoPrimeBillboard: View {
    let title: String
    let metaLeading: String   // "2024 · 16+ · 1 Season · "
    let imdb: String          // "★ 8.4 IMDb"
    let still: Image
    let onPlay: () -> Void
    @Binding var watchlisted: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            still
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 440)
                .clipped()
            LinearGradient(colors: [.clear, LpspPrimeVideoTokens.primeCanvas], startPoint: .center, endPoint: .bottom)

            VStack(alignment: .leading, spacing: 12) {
                Text(title).font(LpspPrimeVideoFonts.primeDetailsTitle).foregroundStyle(.white)
                (Text(metaLeading).foregroundColor(LpspPrimeVideoTokens.primeTextSecondary)
                 + Text(imdb).foregroundColor(LpspPrimeVideoTokens.primeImdbYellow))
                .font(LpspPrimeVideoFonts.primeMeta)
                HStack(spacing: 12) {
                    LpspPrimeVideoPrimePlayButton(action: onPlay).frame(width: 130)
                    LpspPrimeVideoPrimeWatchlistButton(added: $watchlisted).frame(width: 150)
                }
            }
            .padding(16)
        }
        .frame(height: 440)
        .background(LpspPrimeVideoTokens.primeCanvas)
    }
}

fileprivate struct LpspPrimeVideoPrimeXRayOverlay: View {
    let cast: [LpspPrimeVideoCastMember]   // headshot + name + role
    let nowPlaying: String?
    @Binding var shown: Bool

    var body: some View {
        VStack {
            Spacer()
            if shown {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("IN THIS SCENE").font(LpspPrimeVideoFonts.primeLabelUpper)
                            .foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary).tracking(0.6)
                        Spacer()
                        Button { withAnimation(.easeOut(duration: 0.28)) { shown = false } } label: {
                            Image(systemName: "chevron.down").foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary)
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(cast) { m in
                                VStack(spacing: 6) {
                                    m.headshot.resizable().frame(width: 56, height: 56).clipShape(Circle())
                                    Text(m.name).font(LpspPrimeVideoFonts.primeTileSubtitle).foregroundStyle(.white)
                                    Text(m.role).font(LpspPrimeVideoFonts.primeTileSubtitle).foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary)
                                }
                                .frame(width: 80)
                            }
                        }
                    }
                    if let nowPlaying {
                        HStack(spacing: 8) {
                            Image(systemName: "music.note").foregroundStyle(LpspPrimeVideoTokens.primeBlue)
                            Text("Now playing: \(nowPlaying)").font(LpspPrimeVideoFonts.primeMeta).foregroundStyle(.white)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                .background(LpspPrimeVideoTokens.primeSurface2.opacity(0.96))
                .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
                .transition(.move(edge: .bottom))
            }
        }
    }
}

fileprivate struct LpspPrimeVideoCastMember: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    var headshot: Image { Image(systemName: "person.circle.fill") }
}


// MARK: - Données & état (showroom Spectr)

private enum LpspPrimeVideoShowroomTab: String, CaseIterable, Identifiable {
    case home
    case store
    case live
    case find
    case downloads

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .store: return "Store"
        case .live: return "Live"
        case .find: return "Find"
        case .downloads: return "Downloads"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house.fill"
        case .store: return "bag.fill"
        case .live: return "dot.radiowaves.left.and.right"
        case .find: return "magnifyingglass"
        case .downloads: return "arrow.down.circle.fill"
        }
    }
}

fileprivate struct LpspPrimeVideoTitle: Identifiable, Equatable {
    let id: String
    let name: String
    let gradient: [Color]
    var includedWithPrime: Bool
    var inWatchlist: Bool
    var progress: Double?
}

private enum LpspPrimeVideoShowroomData {
    static let featuredID = "citadel-files"

    static let featuredGradient: [Color] = [
        Color(red: 0.05, green: 0.08, blue: 0.20),
        Color(red: 0.02, green: 0.02, blue: 0.06),
        LpspPrimeVideoTokens.primeCanvas,
    ]

    static let cast: [LpspPrimeVideoCastMember] = [
        .init(name: "N. Palmer", role: "Agent Cole"),
        .init(name: "K. Voss", role: "Director"),
        .init(name: "H. Ruiz", role: "Mara"),
    ]

    static let catalog: [LpspPrimeVideoTitle] = [
        .init(
            id: featuredID,
            name: "The Citadel Files",
            gradient: featuredGradient,
            includedWithPrime: true,
            inWatchlist: false,
            progress: nil
        ),
        .init(
            id: "night-harbor",
            name: "Night Harbor",
            gradient: [Color(red: 0.10, green: 0.18, blue: 0.32), Color(red: 0.04, green: 0.08, blue: 0.16)],
            includedWithPrime: true,
            inWatchlist: false,
            progress: 0.35
        ),
        .init(
            id: "glass-transit",
            name: "Glass Transit",
            gradient: [Color(red: 0.18, green: 0.28, blue: 0.42), Color(red: 0.08, green: 0.12, blue: 0.22)],
            includedWithPrime: true,
            inWatchlist: true,
            progress: nil
        ),
        .init(
            id: "amber-signal",
            name: "Amber Signal",
            gradient: [Color(red: 0.32, green: 0.20, blue: 0.10), Color(red: 0.12, green: 0.08, blue: 0.06)],
            includedWithPrime: true,
            inWatchlist: false,
            progress: nil
        ),
        .init(
            id: "north-arcade",
            name: "North Arcade",
            gradient: [Color(red: 0.14, green: 0.22, blue: 0.18), Color(red: 0.06, green: 0.10, blue: 0.08)],
            includedWithPrime: true,
            inWatchlist: false,
            progress: 0.62
        ),
    ]

    static let liveEvents = [
        ("Premier League", "LIVE · Matchday 28", true),
        ("Thursday Night Football", "Starts 8:00 PM", false),
    ]

    static let searchSuggestions = ["Thriller", "Sci-Fi", "Documentary", "Included with Prime"]

    static let downloads = [
        ("The Citadel Files S1E2", "1.8 GB"),
        ("Night Harbor S1E1", "1.1 GB"),
    ]
}

@MainActor
fileprivate final class LpspPrimeVideoStore: ObservableObject {
    @Published var selectedTab: LpspPrimeVideoShowroomTab = .home
    @Published var titles: [LpspPrimeVideoTitle]
    @Published var isPlaying = false
    @Published var xRayShown = true
    @Published var searchQuery = ""

    init() {
        titles = LpspPrimeVideoShowroomData.catalog
    }

    var featured: LpspPrimeVideoTitle {
        titles.first { $0.id == LpspPrimeVideoShowroomData.featuredID } ?? LpspPrimeVideoShowroomData.catalog[0]
    }

    var includedRow: [LpspPrimeVideoTitle] {
        titles.filter(\.includedWithPrime)
    }

    func toggleFeaturedWatchlist() {
        toggleWatchlist(titleID: LpspPrimeVideoShowroomData.featuredID)
    }

    func toggleWatchlist(titleID: String) {
        guard let index = titles.firstIndex(where: { $0.id == titleID }) else { return }
        titles[index].inWatchlist.toggle()
    }

    func playFeatured() {
        isPlaying = true
    }

    func toggleXRay() {
        xRayShown.toggle()
    }
}

// MARK: - Écrans showroom

private struct LpspPrimeVideoShowroomRoot: View {
    @ObservedObject var store: LpspPrimeVideoStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspPrimeVideoShowroomTab.allCases) { tab in
                LpspPrimeVideoShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .tint(LpspPrimeVideoTokens.primeBlue)
        .preferredColorScheme(.dark)
    }
}

private struct LpspPrimeVideoShowroomTabScreen: View {
    @ObservedObject var store: LpspPrimeVideoStore
    let tab: LpspPrimeVideoShowroomTab

    var body: some View {
        NavigationStack {
            Group {
                switch tab {
                case .home:
                    LpspPrimeVideoHomeTabScreen(store: store)
                case .store:
                    LpspPrimeVideoStoreTabScreen(store: store)
                case .live:
                    LpspPrimeVideoLiveTabScreen()
                case .find:
                    LpspPrimeVideoFindTabScreen(store: store)
                case .downloads:
                    LpspPrimeVideoDownloadsTabScreen()
                }
            }
            .navigationTitle(tab == .home ? "" : tab.title)
            .navigationBarTitleDisplayMode(tab == .home ? .inline : .large)
            .background(LpspPrimeVideoTokens.primeCanvas.ignoresSafeArea())
        }
    }
}

private struct LpspPrimeVideoHomeTabScreen: View {
    @ObservedObject var store: LpspPrimeVideoStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LpspPrimeVideoSpectrBillboard(store: store)

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Included with Prime")
                            .font(LpspPrimeVideoFonts.primeSectionHeader.weight(.semibold))
                            .foregroundStyle(LpspPrimeVideoTokens.primeTextPrimary)
                        Spacer()
                        Text("See more")
                            .font(LpspPrimeVideoFonts.primeMeta.weight(.semibold))
                            .foregroundStyle(LpspPrimeVideoTokens.primeBlue)
                    }
                    .padding(.horizontal, 16)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(store.includedRow.filter { $0.id != LpspPrimeVideoShowroomData.featuredID }) { title in
                                LpspPrimeVideoPosterTile(
                                    title: title,
                                    onSelect: { store.toggleWatchlist(titleID: title.id) }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.top, 22)
                .padding(.bottom, 24)
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

private struct LpspPrimeVideoSpectrBillboard: View {
    @ObservedObject var store: LpspPrimeVideoStore

    private var featured: LpspPrimeVideoTitle { store.featured }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: featured.gradient,
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 440)

            LinearGradient(
                colors: [.clear, LpspPrimeVideoTokens.primeCanvas],
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(height: 440)

            VStack(alignment: .leading, spacing: 12) {
                Text("The Citadel Files")
                    .font(LpspPrimeVideoFonts.primeDetailsTitle.weight(.bold))
                    .foregroundStyle(LpspPrimeVideoTokens.primeTextPrimary)

                (Text("2024 · 16+ · 1 Season · ")
                    .foregroundColor(LpspPrimeVideoTokens.primeTextSecondary)
                 + Text("★ 8.4 IMDb")
                    .foregroundColor(LpspPrimeVideoTokens.primeImdbYellow))
                .font(LpspPrimeVideoFonts.primeMeta)

                HStack(spacing: 12) {
                    LpspPrimeVideoPrimePlayButton(
                        title: store.isPlaying ? "Playing" : "Play"
                    ) {
                        store.playFeatured()
                    }
                    .frame(width: 130)

                    LpspPrimeVideoPrimeWatchlistButton(
                        added: Binding(
                            get: { store.featured.inWatchlist },
                            set: { newValue in
                                guard let index = store.titles.firstIndex(where: { $0.id == LpspPrimeVideoShowroomData.featuredID }) else { return }
                                store.titles[index].inWatchlist = newValue
                            }
                        )
                    )
                    .frame(width: 150)
                }
            }
            .padding(16)
            .padding(.bottom, store.xRayShown ? 120 : 0)

            LpspPrimeVideoPrimeXRayOverlay(
                cast: LpspPrimeVideoShowroomData.cast,
                nowPlaying: store.isPlaying ? "The Citadel Files — Main Theme" : nil,
                shown: $store.xRayShown
            )
        }
        .frame(height: 440)
        .background(LpspPrimeVideoTokens.primeCanvas)
    }
}

private struct LpspPrimeVideoPosterTile: View {
    let title: LpspPrimeVideoTitle
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: title.gradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 120, height: 180)

                    if let progress = title.progress {
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Rectangle().fill(Color.white.opacity(0.25))
                                Rectangle()
                                    .fill(LpspPrimeVideoTokens.primeBlue)
                                    .frame(width: geo.size.width * progress)
                            }
                        }
                        .frame(height: 3)
                    }
                }

                Text(title.name)
                    .font(LpspPrimeVideoFonts.primeTileTitle)
                    .foregroundStyle(LpspPrimeVideoTokens.primeTextPrimary)
                    .lineLimit(1)

                if title.includedWithPrime {
                    Text("Included with Prime")
                        .font(LpspPrimeVideoFonts.primeTileSubtitle)
                        .foregroundStyle(LpspPrimeVideoTokens.primeBlue)
                }
            }
            .frame(width: 120)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspPrimeVideoStoreTabScreen: View {
    @ObservedObject var store: LpspPrimeVideoStore

    private let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: cols, spacing: 12) {
                ForEach(store.titles) { title in
                    LpspPrimeVideoPosterTile(title: title) {
                        store.toggleWatchlist(titleID: title.id)
                    }
                }
            }
            .padding(16)
        }
    }
}

private struct LpspPrimeVideoLiveTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspPrimeVideoShowroomData.liveEvents, id: \.0) { name, detail, isLive in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(LpspPrimeVideoTokens.primeSurface2)
                        .frame(width: 88, height: 50)
                        .overlay(alignment: .topLeading) {
                            if isLive {
                                Text("LIVE")
                                    .font(LpspPrimeVideoFonts.primeBadge.weight(.bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(LpspPrimeVideoTokens.primeLiveRed)
                                    .clipShape(RoundedRectangle(cornerRadius: 3))
                                    .padding(6)
                            }
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .font(LpspPrimeVideoFonts.primeTileTitle.weight(.semibold))
                            .foregroundStyle(LpspPrimeVideoTokens.primeTextPrimary)
                        Text(detail)
                            .font(LpspPrimeVideoFonts.primeTileSubtitle)
                            .foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary)
                    }
                }
                .listRowBackground(LpspPrimeVideoTokens.primeSurface1)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

private struct LpspPrimeVideoFindTabScreen: View {
    @ObservedObject var store: LpspPrimeVideoStore

    var body: some View {
        List {
            Section {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary)
                    TextField("Movies, TV, genres", text: $store.searchQuery)
                        .foregroundStyle(LpspPrimeVideoTokens.primeTextPrimary)
                }
            }

            Section("Popular") {
                ForEach(LpspPrimeVideoShowroomData.searchSuggestions, id: \.self) { item in
                    Button {
                        store.searchQuery = item
                    } label: {
                        Text(item)
                            .foregroundStyle(LpspPrimeVideoTokens.primeTextPrimary)
                    }
                }
            }

            if !store.searchQuery.isEmpty {
                Section("Results") {
                    ForEach(store.titles.filter {
                        $0.name.localizedCaseInsensitiveContains(store.searchQuery)
                            || store.searchQuery.localizedCaseInsensitiveContains("prime") && $0.includedWithPrime
                    }) { title in
                        Text(title.name)
                            .foregroundStyle(LpspPrimeVideoTokens.primeBlue)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

private struct LpspPrimeVideoDownloadsTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspPrimeVideoShowroomData.downloads, id: \.0) { title, size in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(LpspPrimeVideoTokens.primeSurface2)
                        .frame(width: 72, height: 108)
                        .overlay {
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundStyle(LpspPrimeVideoTokens.primeBlue)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(LpspPrimeVideoFonts.primeTileTitle.weight(.semibold))
                            .foregroundStyle(LpspPrimeVideoTokens.primeTextPrimary)
                        Text(size)
                            .font(LpspPrimeVideoFonts.primeTileSubtitle)
                            .foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary)
                    }
                }
                .listRowBackground(LpspPrimeVideoTokens.primeSurface1)
            }
        }
        .scrollContentBackground(.hidden)
    }
}



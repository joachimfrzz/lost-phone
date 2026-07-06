import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/netflix
// Meliwat/awesome-ios-design-md/video/netflix/DESIGN-swiftui.md
struct LpspAwesomeNetflixView: View {
    var body: some View {
        LpspNetflixShowroomRoot(
            store: LpspNetflixStore(
                profiles: LpspNetflixShowroomData.profiles,
                titles: LpspNetflixShowroomData.titles
            )
        )
    }
}

// MARK: - Tokens & composants

private enum LpspNetflixTokens {
    static let netflixRed        = Color(red: 0.898, green: 0.035, blue: 0.078)
    static let netflixCanvas     = Color(red: 0.078, green: 0.078, blue: 0.078)
    static let netflixBlack      = Color.black
    static let netflixSurface1   = Color(red: 0.122, green: 0.122, blue: 0.122)
    static let netflixSurface2   = Color(red: 0.165, green: 0.165, blue: 0.165)
    static let netflixTextSecondary = Color(red: 0.667, green: 0.667, blue: 0.667)
    static let netflixTextTertiary  = Color(red: 0.467, green: 0.467, blue: 0.467)
    static let netflixProfileYellow = Color(red: 0.961, green: 0.847, blue: 0.361)
}

private enum LpspNetflixFonts {
    static let profileGateTitle = Font.system(size: 32, weight: .medium)
    static let heroTitle        = Font.system(size: 42, weight: .black)
    static let rowHeader        = Font.system(size: 17, weight: .semibold)
    static let body             = Font.system(size: 14, weight: .regular)
    static let meta             = Font.system(size: 12, weight: .regular)
    static let tab              = Font.system(size: 10, weight: .regular)
    static let buttonLabel      = Font.system(size: 16, weight: .semibold)
}

fileprivate struct LpspNetflixPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .brightness(configuration.isPressed ? -0.08 : 0)
            .animation(.spring(response: 0.2, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspNetflixProfileAvatar: View {
    let profile: LpspNetflixShowroomProfile
    var size: CGFloat = 84
    var showLabel = true

    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(profile.accent)
                .frame(width: size, height: size)
                .overlay(
                    Image(systemName: profile.icon)
                        .font(.system(size: size * 0.42, weight: .regular))
                        .foregroundStyle(.white)
                )

            if showLabel {
                Text(profile.name)
                    .font(LpspNetflixFonts.body)
                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
            }
        }
    }
}

fileprivate struct LpspNetflixPoster: View {
    let title: LpspNetflixShowroomTitle
    var width: CGFloat = 110

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(
                LinearGradient(
                    colors: [title.accent, title.accent.opacity(0.5)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: width, height: width * 1.5)
            .overlay(
                VStack {
                    Spacer()
                    Text(title.shortTitle)
                        .font(.system(size: width * 0.1, weight: .black))
                        .foregroundStyle(.white.opacity(0.92))
                        .multilineTextAlignment(.center)
                        .padding(6)
                }
            )
            .shadow(color: .black.opacity(0.45), radius: 6, y: 3)
    }
}

fileprivate struct LpspNetflixContinueTile: View {
    let item: LpspNetflixContinueItem
    var width: CGFloat = 240

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    LinearGradient(
                        colors: [item.title.accent, item.title.accent.opacity(0.35)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: width, height: width * 0.56)
                .overlay(
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title.name)
                                .font(LpspNetflixFonts.rowHeader)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            Text(item.episodeLabel)
                                .font(LpspNetflixFonts.meta)
                                .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                .lineLimit(1)
                        }
                        Spacer()
                        Image(systemName: "play.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Circle().stroke(Color.white.opacity(0.8), lineWidth: 2))
                    }
                    .padding(12)
                )

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color.white.opacity(0.25)).frame(height: 3)
                    Rectangle()
                        .fill(LpspNetflixTokens.netflixRed)
                        .frame(width: geo.size.width * item.progress, height: 3)
                }
            }
            .frame(height: 3)
        }
        .frame(width: width)
    }
}

fileprivate struct LpspNetflixHeroButton: View {
    let icon: String
    let title: String
    var isPrimary = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: isPrimary ? 18 : 15, weight: .bold))
                Text(title)
                    .font(LpspNetflixFonts.buttonLabel)
            }
            .foregroundStyle(isPrimary ? .black : .white)
            .padding(.horizontal, isPrimary ? 22 : 18)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(isPrimary ? Color.white : Color.white.opacity(0.22))
            )
        }
        .buttonStyle(LpspNetflixPressableStyle())
    }
}

fileprivate struct LpspNetflixDisabledPlayButton: View {
    let title: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "play.fill")
                .font(.system(size: 18, weight: .bold))
            Text(title)
                .font(LpspNetflixFonts.buttonLabel)
        }
        .foregroundStyle(.black.opacity(0.35))
        .padding(.horizontal, 22)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 4).fill(Color.white.opacity(0.55)))
    }
}

fileprivate struct LpspNetflixDetailAction: View {
    let icon: String
    let label: String
    var action: (() -> Void)?

    var body: some View {
        Button {
            action?()
        } label: {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(LpspNetflixTokens.netflixSurface2)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
                Text(label)
                    .font(.system(size: 11))
                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
            }
        }
        .buttonStyle(LpspNetflixPressableStyle())
        .disabled(action == nil)
    }
}

// MARK: - Données & état

fileprivate struct LpspNetflixShowroomProfile: Identifiable, Hashable {
    let id: String
    let name: String
    let accent: Color
    let icon: String
    let isKids: Bool
}

fileprivate struct LpspNetflixShowroomEpisode: Identifiable, Hashable {
    let id: String
    let season: Int
    let episode: Int
    let title: String
    let duration: String
    let synopsis: String
}

fileprivate struct LpspNetflixShowroomTitle: Identifiable, Hashable {
    let id: String
    let name: String
    let shortTitle: String
    let tagline: String
    let genres: String
    let match: Int
    let year: String
    let rating: String
    let accent: Color
    let synopsis: String
    let isSeries: Bool
    let episodes: [LpspNetflixShowroomEpisode]
}

fileprivate struct LpspNetflixContinueItem: Identifiable {
    let id: String
    let title: LpspNetflixShowroomTitle
    let progress: Double
    let episodeLabel: String
}

@MainActor
fileprivate final class LpspNetflixStore: ObservableObject {
    @Published var selectedTab: LpspNetflixTab = .home
    @Published var selectedProfile: LpspNetflixShowroomProfile?
    @Published var presentedTitle: LpspNetflixShowroomTitle?
    @Published var myListIDs: Set<String>
    @Published var continueWatching: [LpspNetflixContinueItem]
    @Published var downloads: [LpspNetflixContinueItem]
    @Published var homeFilter: LpspNetflixHomeFilter = .series

    let profiles: [LpspNetflixShowroomProfile]
    let titles: [LpspNetflixShowroomTitle]

    init(profiles: [LpspNetflixShowroomProfile], titles: [LpspNetflixShowroomTitle]) {
        self.profiles = profiles
        self.titles = titles
        self.selectedProfile = nil
        self.myListIDs = ["t2", "t4"]
        self.continueWatching = LpspNetflixShowroomData.initialContinueWatching(titles: titles)
        self.downloads = LpspNetflixShowroomData.initialDownloads(titles: titles)
    }

    var heroTitle: LpspNetflixShowroomTitle {
        titles.first { $0.id == "t1" } ?? titles[0]
    }

    var filteredHomeRows: [(String, [LpspNetflixShowroomTitle])] {
        let pool: [LpspNetflixShowroomTitle] = switch homeFilter {
        case .series: titles.filter(\.isSeries)
        case .films: titles.filter { !$0.isSeries }
        case .categories: titles
        }
        return [
            ("Trending Now", Array(pool.prefix(6))),
            ("Because you watched The Louvre Files", Array(pool.dropFirst().prefix(5))),
            ("Paris Thrillers", pool.filter { $0.genres.contains("Thriller") }),
        ].filter { !$0.1.isEmpty }
    }

    func selectProfile(_ profile: LpspNetflixShowroomProfile) {
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedProfile = profile
            selectedTab = .home
        }
    }

    func switchProfile() {
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedProfile = nil
            presentedTitle = nil
        }
    }

    func openTitle(_ title: LpspNetflixShowroomTitle) {
        presentedTitle = title
    }

    func toggleMyList(_ title: LpspNetflixShowroomTitle) {
        if myListIDs.contains(title.id) {
            myListIDs.remove(title.id)
        } else {
            myListIDs.insert(title.id)
        }
    }

    func isInMyList(_ title: LpspNetflixShowroomTitle) -> Bool {
        myListIDs.contains(title.id)
    }
}

private enum LpspNetflixHomeFilter: String, CaseIterable {
    case series = "Series"
    case films = "Films"
    case categories = "Categories"
}

private enum LpspNetflixShowroomData {
    static let profiles: [LpspNetflixShowroomProfile] = [
        .init(id: "p1", name: "Maya", accent: LpspNetflixTokens.netflixRed, icon: "face.smiling", isKids: false),
        .init(id: "p2", name: "Jordan", accent: Color(red: 0.243, green: 0.243, blue: 0.569), icon: "face.smiling.inverse", isKids: false),
        .init(id: "p3", name: "Kids", accent: Color(red: 0.973, green: 0.596, blue: 0.114), icon: "teddybear.fill", isKids: true),
        .init(id: "p4", name: "Add", accent: LpspNetflixTokens.netflixSurface2, icon: "plus", isKids: false),
    ]

    static let titles: [LpspNetflixShowroomTitle] = [
        .init(
            id: "t1", name: "Night Wave", shortTitle: "NIGHT\nWAVE", tagline: "Series · #1 in France Today",
            genres: "Gripping · Drama · Thriller", match: 97, year: "2026", rating: "TV-MA",
            accent: Color(red: 0.15, green: 0.05, blue: 0.22),
            synopsis: "A radio host receives encrypted messages from a phone found in the Paris metro.",
            isSeries: true,
            episodes: [
                .init(id: "t1e1", season: 1, episode: 1, title: "Static", duration: "52m", synopsis: "The first ping arrives at 3:14 a.m."),
                .init(id: "t1e2", season: 1, episode: 2, title: "Dead Line", duration: "49m", synopsis: "A second SIM card surfaces near Bastille."),
            ]
        ),
        .init(
            id: "t2", name: "The Louvre Files", shortTitle: "LOUVRE\nFILES", tagline: "Limited Series",
            genres: "Mystery · Crime · Paris", match: 95, year: "2025", rating: "TV-14",
            accent: Color(red: 0.45, green: 0.28, blue: 0.12),
            synopsis: "Curators, guards, and hackers chase clues hidden in plain sight at the museum.",
            isSeries: true,
            episodes: [
                .init(id: "t2e1", season: 1, episode: 1, title: "Pyramid", duration: "47m", synopsis: "Security footage shows an impossible exit."),
                .init(id: "t2e2", season: 1, episode: 2, title: "Wing B", duration: "51m", synopsis: "A gallery closes early without explanation."),
            ]
        ),
        .init(
            id: "t3", name: "Metro Line 1", shortTitle: "METRO\nLINE 1", tagline: "New Episodes",
            genres: "Thriller · Transit · Noir", match: 92, year: "2026", rating: "TV-MA",
            accent: Color(red: 0.08, green: 0.18, blue: 0.35),
            synopsis: "Each stop on Line 1 reveals another fragment of the missing phone trail.",
            isSeries: true,
            episodes: [
                .init(id: "t3e1", season: 1, episode: 1, title: "Châtelet", duration: "44m", synopsis: "A dropped pin leads underground."),
            ]
        ),
        .init(
            id: "t4", name: "Lost Signal", shortTitle: "LOST\nSIGNAL", tagline: "Documentary",
            genres: "True Crime · Tech", match: 89, year: "2024", rating: "TV-14",
            accent: Color(red: 0.12, green: 0.35, blue: 0.28),
            synopsis: "How a single device can reconstruct a life in 48 hours of data.",
            isSeries: false,
            episodes: [
                .init(id: "t4e1", season: 1, episode: 1, title: "Lost Signal", duration: "94m", synopsis: "Feature documentary."),
            ]
        ),
        .init(
            id: "t5", name: "Station F", shortTitle: "STATION\nF", tagline: "Drama",
            genres: "Startup · Drama", match: 88, year: "2025", rating: "TV-MA",
            accent: Color(red: 0.55, green: 0.20, blue: 0.18),
            synopsis: "Founders compete while a prototype phone vanishes from the incubator.",
            isSeries: true,
            episodes: [
                .init(id: "t5e1", season: 1, episode: 1, title: "Demo Day", duration: "46m", synopsis: "The pitch deck hides a second narrative."),
            ]
        ),
        .init(
            id: "t6", name: "Bastille Nights", shortTitle: "BASTILLE", tagline: "Film",
            genres: "Thriller · Paris", match: 91, year: "2023", rating: "TV-MA",
            accent: Color(red: 0.22, green: 0.08, blue: 0.10),
            synopsis: "One night, three witnesses, zero matching statements.",
            isSeries: false,
            episodes: [
                .init(id: "t6e1", season: 1, episode: 1, title: "Bastille Nights", duration: "112m", synopsis: "Feature film."),
            ]
        ),
    ]

    static func initialContinueWatching(titles: [LpspNetflixShowroomTitle]) -> [LpspNetflixContinueItem] {
        guard titles.count >= 3 else { return [] }
        return [
            .init(id: "cw1", title: titles[1], progress: 0.42, episodeLabel: "S1:E1 · Pyramid"),
            .init(id: "cw2", title: titles[2], progress: 0.18, episodeLabel: "S1:E1 · Châtelet"),
            .init(id: "cw3", title: titles[0], progress: 0.67, episodeLabel: "S1:E2 · Dead Line"),
        ]
    }

    static func initialDownloads(titles: [LpspNetflixShowroomTitle]) -> [LpspNetflixContinueItem] {
        guard titles.count >= 2 else { return [] }
        return [
            .init(id: "dl1", title: titles[1], progress: 1, episodeLabel: "S1:E1 · Pyramid"),
            .init(id: "dl2", title: titles[3], progress: 1, episodeLabel: "Lost Signal"),
        ]
    }
}

// MARK: - Écrans showroom

private enum LpspNetflixTab: CaseIterable {
    case home, newHot, myNetflix, downloads

    var label: String {
        switch self {
        case .home: "Home"
        case .newHot: "New & Hot"
        case .myNetflix: "My Netflix"
        case .downloads: "Downloads"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .newHot: "play.rectangle.on.rectangle.fill"
        case .myNetflix: "person.crop.circle.fill"
        case .downloads: "arrow.down.circle.fill"
        }
    }
}

private struct LpspNetflixShowroomRoot: View {
    @ObservedObject var store: LpspNetflixStore

    var body: some View {
        Group {
            if store.selectedProfile == nil {
                LpspNetflixProfileGateScreen(store: store)
            } else {
                mainShell
            }
        }
        .background(LpspNetflixTokens.netflixBlack.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .sheet(item: $store.presentedTitle) { title in
            LpspNetflixTitleDetailScreen(store: store, title: title)
        }
    }

    private var mainShell: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspNetflixHomeTabScreen(store: store)
                case .newHot:
                    LpspNetflixNewHotTabScreen(store: store)
                case .myNetflix:
                    LpspNetflixMyNetflixTabScreen(store: store)
                case .downloads:
                    LpspNetflixDownloadsTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspNetflixSpectrTabBar(selectedTab: $store.selectedTab)
        }
        .background(LpspNetflixTokens.netflixCanvas.ignoresSafeArea())
    }
}

private struct LpspNetflixProfileGateScreen: View {
    @ObservedObject var store: LpspNetflixStore

    var body: some View {
        ZStack {
            LpspNetflixTokens.netflixBlack.ignoresSafeArea()

            VStack(spacing: 36) {
                Spacer()

                Text("Who's watching?")
                    .font(LpspNetflixFonts.profileGateTitle)
                    .foregroundStyle(.white)

                HStack(spacing: 20) {
                    ForEach(store.profiles.filter { $0.name != "Add" }) { profile in
                        Button {
                            store.selectProfile(profile)
                        } label: {
                            LpspNetflixProfileAvatar(profile: profile)
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                    }

                    Button { } label: {
                        LpspNetflixProfileAvatar(
                            profile: .init(id: "add", name: "Add Profile", accent: LpspNetflixTokens.netflixSurface2, icon: "plus", isKids: false),
                            showLabel: true
                        )
                    }
                    .buttonStyle(LpspNetflixPressableStyle())
                }
                .padding(.horizontal, 24)

                Spacer()

                HStack(spacing: 28) {
                    Button("Manage Profiles") { }
                    Button("Edit") { }
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(LpspNetflixTokens.netflixTextTertiary)
                .padding(.bottom, 36)
            }
        }
    }
}

private struct LpspNetflixSpectrTabBar: View {
    @Binding var selectedTab: LpspNetflixTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspNetflixTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selectedTab = tab }
                } label: {
                    VStack(spacing: 3) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: selectedTab == tab ? .semibold : .regular))
                        Text(tab.label)
                            .font(LpspNetflixFonts.tab)
                    }
                    .foregroundStyle(selectedTab == tab ? .white : LpspNetflixTokens.netflixTextSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(LpspNetflixPressableStyle())
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspNetflixTokens.netflixSurface1)
    }
}

private struct LpspNetflixHomeTabScreen: View {
    @ObservedObject var store: LpspNetflixStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                heroBanner
                VStack(alignment: .leading, spacing: 24) {
                    if !store.continueWatching.isEmpty {
                        continueWatchingRow
                    }
                    ForEach(store.filteredHomeRows, id: \.0) { row in
                        posterRow(title: row.0, titles: row.1)
                    }
                    top10Row
                }
                .padding(.top, 18)
                .padding(.bottom, 28)
            }
        }
        .background(LpspNetflixTokens.netflixCanvas.ignoresSafeArea())
    }

    private var heroBanner: some View {
        let hero = store.heroTitle
        return ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [hero.accent.opacity(0.95), hero.accent.opacity(0.35), LpspNetflixTokens.netflixCanvas],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 500)

            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Text("N")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(LpspNetflixTokens.netflixRed)
                        .overlay(
                            Text("N")
                                .font(.system(size: 28, weight: .black))
                                .foregroundStyle(LpspNetflixTokens.netflixRed)
                                .offset(x: -3)
                        )
                    Text("ETFLIX")
                        .font(.system(size: 22, weight: .black))
                        .foregroundStyle(LpspNetflixTokens.netflixRed)
                        .offset(x: -8)
                    Spacer()
                    HStack(spacing: 18) {
                        Image(systemName: "bell")
                        if let profile = store.selectedProfile {
                            Button { store.switchProfile() } label: {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(profile.accent)
                                    .frame(width: 28, height: 28)
                                    .overlay(
                                        Image(systemName: profile.icon)
                                            .font(.system(size: 14))
                                            .foregroundStyle(.white)
                                    )
                            }
                            .buttonStyle(LpspNetflixPressableStyle())
                        }
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)

                HStack(spacing: 8) {
                    ForEach(LpspNetflixHomeFilter.allCases, id: \.self) { filter in
                        Button {
                            store.homeFilter = filter
                        } label: {
                            Text(filter.rawValue)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(store.homeFilter == filter ? .black : .white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 7)
                                .background(
                                    Capsule().fill(
                                        store.homeFilter == filter ? .white : Color.white.opacity(0.14)
                                    )
                                )
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 14)

                Spacer()

                VStack(spacing: 10) {
                    HStack(spacing: 6) {
                        Text("TOP 10")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(RoundedRectangle(cornerRadius: 2).fill(LpspNetflixTokens.netflixRed))
                        Text("in France Today")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    Text(hero.name.uppercased())
                        .font(LpspNetflixFonts.heroTitle)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.5), radius: 8, y: 2)

                    Text(hero.genres)
                        .font(LpspNetflixFonts.meta)
                        .foregroundStyle(.white.opacity(0.92))

                    HStack(spacing: 10) {
                        LpspNetflixDisabledPlayButton(title: "Play")
                        LpspNetflixHeroButton(
                            icon: store.isInMyList(hero) ? "checkmark" : "plus",
                            title: "My List"
                        ) {
                            store.toggleMyList(hero)
                        }
                        LpspNetflixHeroButton(icon: "info.circle", title: "Info") {
                            store.openTitle(hero)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
    }

    private var continueWatchingRow: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Continue Watching for \(store.selectedProfile?.name ?? "")")
                .font(LpspNetflixFonts.rowHeader)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(store.continueWatching) { item in
                        Button {
                            store.openTitle(item.title)
                        } label: {
                            LpspNetflixContinueTile(item: item)
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func posterRow(title: String, titles: [LpspNetflixShowroomTitle]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(LpspNetflixFonts.rowHeader)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(titles) { item in
                        Button {
                            store.openTitle(item)
                        } label: {
                            LpspNetflixPoster(title: item)
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private var top10Row: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Top 10 TV Shows in France Today")
                .font(LpspNetflixFonts.rowHeader)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(Array(store.titles.filter(\.isSeries).prefix(5).enumerated()), id: \.element.id) { index, title in
                        Button {
                            store.openTitle(title)
                        } label: {
                            HStack(alignment: .bottom, spacing: -20) {
                                Text("\(index + 1)")
                                    .font(.system(size: 120, weight: .black))
                                    .foregroundStyle(LpspNetflixTokens.netflixCanvas)
                                    .overlay(
                                        Text("\(index + 1)")
                                            .font(.system(size: 120, weight: .black))
                                            .foregroundStyle(Color.white.opacity(0.14))
                                    )
                                LpspNetflixPoster(title: title, width: 96)
                            }
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                        .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

private struct LpspNetflixNewHotTabScreen: View {
    @ObservedObject var store: LpspNetflixStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Coming Soon")
                        .font(LpspNetflixFonts.rowHeader)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)

                    ForEach(store.titles.prefix(4)) { title in
                        Button {
                            store.openTitle(title)
                        } label: {
                            HStack(spacing: 12) {
                                LpspNetflixPoster(title: title, width: 72)
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(title.name)
                                        .font(LpspNetflixFonts.rowHeader)
                                        .foregroundStyle(.white)
                                    Text(title.tagline)
                                        .font(LpspNetflixFonts.meta)
                                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                    Text("Remind Me")
                                        .font(LpspNetflixFonts.meta)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 5)
                                        .overlay(Capsule().stroke(Color.white.opacity(0.45), lineWidth: 1))
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                    }
                }
                .padding(.vertical, 16)
            }
            .background(LpspNetflixTokens.netflixCanvas.ignoresSafeArea())
            .navigationTitle("New & Hot")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

private struct LpspNetflixMyNetflixTabScreen: View {
    @ObservedObject var store: LpspNetflixStore

    private let menuItems: [(String, String)] = [
        ("bell", "Notifications"),
        ("checkmark", "My List"),
        ("arrow.down.circle", "Downloads"),
        ("gearshape", "App Settings"),
        ("person.crop.circle", "Account"),
        ("questionmark.circle", "Help"),
    ]

    var body: some View {
        NavigationStack {
            List {
                if let profile = store.selectedProfile {
                    Section {
                        HStack(spacing: 14) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(profile.accent)
                                .frame(width: 52, height: 52)
                                .overlay(
                                    Image(systemName: profile.icon)
                                        .font(.system(size: 24))
                                        .foregroundStyle(.white)
                                )
                            VStack(alignment: .leading, spacing: 4) {
                                Text(profile.name)
                                    .font(LpspNetflixFonts.rowHeader)
                                    .foregroundStyle(.white)
                                Text("Netflix Premium")
                                    .font(LpspNetflixFonts.meta)
                                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                            }
                        }
                        .listRowBackground(LpspNetflixTokens.netflixSurface1)
                    }
                }

                Section {
                    ForEach(menuItems, id: \.0) { icon, label in
                        Label(label, systemImage: icon)
                            .font(LpspNetflixFonts.body)
                            .foregroundStyle(.white)
                            .listRowBackground(LpspNetflixTokens.netflixSurface1)
                    }
                }

                Section {
                    Button {
                        store.switchProfile()
                    } label: {
                        Label("Switch Profile", systemImage: "arrow.left.arrow.right")
                            .font(LpspNetflixFonts.body)
                            .foregroundStyle(.white)
                    }
                    .listRowBackground(LpspNetflixTokens.netflixSurface1)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("My Netflix")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspNetflixTokens.netflixCanvas.ignoresSafeArea())
    }
}

private struct LpspNetflixDownloadsTabScreen: View {
    @ObservedObject var store: LpspNetflixStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.downloads) { item in
                    Button {
                        store.openTitle(item.title)
                    } label: {
                        HStack(spacing: 12) {
                            LpspNetflixPoster(title: item.title, width: 64)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title.name)
                                    .font(LpspNetflixFonts.rowHeader)
                                    .foregroundStyle(.white)
                                Text(item.episodeLabel)
                                    .font(LpspNetflixFonts.meta)
                                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                HStack(spacing: 4) {
                                    Image(systemName: "checkmark.circle.fill")
                                    Text("Downloaded")
                                }
                                .font(LpspNetflixFonts.meta)
                                .foregroundStyle(LpspNetflixTokens.netflixProfileYellow)
                            }
                        }
                    }
                    .listRowBackground(LpspNetflixTokens.netflixSurface1)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Downloads")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspNetflixTokens.netflixCanvas.ignoresSafeArea())
    }
}

private struct LpspNetflixTitleDetailScreen: View {
    @ObservedObject var store: LpspNetflixStore
    let title: LpspNetflixShowroomTitle
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Capsule()
                        .fill(LpspNetflixTokens.netflixSurface2)
                        .frame(width: 36, height: 4)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)

                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(
                            colors: [title.accent, LpspNetflixTokens.netflixCanvas],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 260)
                        .overlay(
                            LinearGradient(colors: [.clear, LpspNetflixTokens.netflixCanvas], startPoint: .top, endPoint: .bottom)
                        )

                        VStack(alignment: .leading, spacing: 6) {
                            Text(title.name)
                                .font(.system(size: 30, weight: .black))
                                .foregroundStyle(.white)
                            Text(title.tagline)
                                .font(LpspNetflixFonts.meta)
                                .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                        }
                        .padding(16)
                    }

                    HStack(spacing: 22) {
                        LpspNetflixDetailAction(icon: "play.fill", label: "Play", action: nil)
                        LpspNetflixDetailAction(icon: "arrow.down.to.line", label: "Download", action: {})
                        LpspNetflixDetailAction(icon: store.isInMyList(title) ? "checkmark" : "plus", label: "My List") {
                            store.toggleMyList(title)
                        }
                        LpspNetflixDetailAction(icon: "hand.thumbsup", label: "Rate", action: {})
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text("\(title.match)% Match")
                                .foregroundStyle(LpspNetflixTokens.netflixProfileYellow)
                            Text(title.year)
                            Text(title.rating)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white.opacity(0.55), lineWidth: 1))
                            Text(title.isSeries ? "Series" : "Film")
                        }
                        .font(LpspNetflixFonts.meta)
                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)

                        Text(title.synopsis)
                            .font(LpspNetflixFonts.body)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 16)

                    if title.isSeries {
                        Text("Episodes")
                            .font(LpspNetflixFonts.rowHeader)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.top, 18)

                        Picker("Season", selection: .constant(1)) {
                            Text("Season 1").tag(1)
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 16)

                        ForEach(title.episodes) { episode in
                            HStack(alignment: .top, spacing: 12) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(title.accent.opacity(0.65))
                                    .frame(width: 120, height: 68)
                                    .overlay(
                                        Image(systemName: "play.fill")
                                            .foregroundStyle(.white.opacity(0.5))
                                    )

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(episode.episode). \(episode.title)")
                                        .font(LpspNetflixFonts.rowHeader)
                                        .foregroundStyle(.white)
                                    Text(episode.duration)
                                        .font(LpspNetflixFonts.meta)
                                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                    Text(episode.synopsis)
                                        .font(LpspNetflixFonts.body)
                                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                        .lineLimit(2)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding(.bottom, 24)
            }
            .background(LpspNetflixTokens.netflixCanvas.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Circle().fill(LpspNetflixTokens.netflixSurface2))
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
        .preferredColorScheme(.dark)
    }
}

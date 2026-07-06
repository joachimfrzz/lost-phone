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
    static let netflixSurface1   = Color(red: 0.122, green: 0.122, blue: 0.122)
    static let netflixSurface2   = Color(red: 0.165, green: 0.165, blue: 0.165)
    static let netflixTextSecondary = Color(red: 0.667, green: 0.667, blue: 0.667)
    static let netflixProfileYellow = Color(red: 0.961, green: 0.847, blue: 0.361)
}

private enum LpspNetflixFonts {
    static let heroTitle    = Font.system(size: 36, weight: .black)
    static let rowHeader    = Font.system(size: 17, weight: .bold)
    static let body         = Font.system(size: 14, weight: .regular)
    static let meta         = Font.system(size: 12, weight: .regular)
    static let tab          = Font.system(size: 10, weight: .regular)
    static let buttonPlay   = Font.system(size: 17, weight: .bold)
}

fileprivate struct LpspNetflixPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .brightness(configuration.isPressed ? -0.08 : 0)
            .animation(.spring(response: 0.2, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspNetflixPoster: View {
    let title: LpspNetflixShowroomTitle
    var width: CGFloat = 120
    var progress: Double?

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    LinearGradient(
                        colors: [title.accent, title.accent.opacity(0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: width, height: width * 1.5)
                .overlay(
                    VStack {
                        Spacer()
                        Text(title.shortTitle)
                            .font(.system(size: width * 0.11, weight: .black))
                            .foregroundStyle(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(8)
                    }
                )

            if let progress {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle().fill(Color.white.opacity(0.25)).frame(height: 3)
                        Rectangle()
                            .fill(LpspNetflixTokens.netflixRed)
                            .frame(width: geo.size.width * progress, height: 3)
                    }
                }
                .frame(height: 3)
                .padding(.horizontal, 4)
                .padding(.bottom, 4)
            }
        }
    }
}

fileprivate struct LpspNetflixPlayButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill")
                    .font(.system(size: 18, weight: .bold))
                Text(title)
                    .font(LpspNetflixFonts.buttonPlay)
            }
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(RoundedRectangle(cornerRadius: 4).fill(.white))
        }
        .buttonStyle(LpspNetflixPressableStyle())
    }
}

fileprivate struct LpspNetflixSecondaryButton: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                Text(title)
                    .font(LpspNetflixFonts.buttonPlay)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(RoundedRectangle(cornerRadius: 4).fill(Color.white.opacity(0.18)))
        }
        .buttonStyle(LpspNetflixPressableStyle())
    }
}

// MARK: - Données & état

fileprivate struct LpspNetflixShowroomProfile: Identifiable, Hashable {
    let id: String
    let name: String
    let accent: Color
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
    var progress: Double
    let episodeLabel: String
}

@MainActor
fileprivate final class LpspNetflixStore: ObservableObject {
    @Published var selectedTab: LpspNetflixTab = .home
    @Published var selectedProfile: LpspNetflixShowroomProfile?
    @Published var presentedTitle: LpspNetflixShowroomTitle?
    @Published var showPlayer = false
    @Published var playingTitle: LpspNetflixShowroomTitle?
    @Published var playingEpisode: LpspNetflixShowroomEpisode?
    @Published var myListIDs: Set<String>
    @Published var continueWatching: [LpspNetflixContinueItem]
    @Published var downloads: [LpspNetflixContinueItem]
    @Published var homeChip: String?

    let profiles: [LpspNetflixShowroomProfile]
    let titles: [LpspNetflixShowroomTitle]

    init(profiles: [LpspNetflixShowroomProfile], titles: [LpspNetflixShowroomTitle]) {
        self.profiles = profiles
        self.titles = titles
        self.selectedProfile = profiles.first
        self.myListIDs = ["t2", "t4"]
        self.continueWatching = LpspNetflixShowroomData.initialContinueWatching(titles: titles)
        self.downloads = LpspNetflixShowroomData.initialDownloads(titles: titles)
    }

    var heroTitle: LpspNetflixShowroomTitle {
        titles.first { $0.id == "t1" } ?? titles[0]
    }

    var filteredHomeRows: [(String, [LpspNetflixShowroomTitle])] {
        let chip = homeChip
        let filtered = titles.filter { title in
            guard let chip else { return true }
            return title.genres.localizedCaseInsensitiveContains(chip)
        }
        return [
            ("Trending Now", Array(filtered.prefix(6))),
            ("Because you watched The Louvre Files", Array(filtered.dropFirst().prefix(5))),
            ("Paris Thrillers", filtered.filter { $0.genres.contains("Thriller") }),
        ].filter { !$0.1.isEmpty }
    }

    func selectProfile(_ profile: LpspNetflixShowroomProfile) {
        selectedProfile = profile
        selectedTab = .home
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

    func play(_ title: LpspNetflixShowroomTitle, episode: LpspNetflixShowroomEpisode? = nil) {
        playingTitle = title
        playingEpisode = episode ?? title.episodes.first
        showPlayer = true
        upsertContinueWatching(title: title, episode: playingEpisode, progress: 0.04)
    }

    func resume(_ item: LpspNetflixContinueItem) {
        playingTitle = item.title
        playingEpisode = item.title.episodes.first
        showPlayer = true
    }

    private func upsertContinueWatching(
        title: LpspNetflixShowroomTitle,
        episode: LpspNetflixShowroomEpisode?,
        progress: Double
    ) {
        let label = episode.map { "S\( $0.season ):E\( $0.episode ) · \($0.title)" } ?? title.name
        if let index = continueWatching.firstIndex(where: { $0.title.id == title.id }) {
            continueWatching[index].progress = progress
        } else {
            continueWatching.insert(
                LpspNetflixContinueItem(id: "cw-\(title.id)", title: title, progress: progress, episodeLabel: label),
                at: 0
            )
        }
    }

    func advancePlayback() {
        guard let title = playingTitle else { return }
        if let index = continueWatching.firstIndex(where: { $0.title.id == title.id }) {
            continueWatching[index].progress = min(0.98, continueWatching[index].progress + 0.18)
        }
    }
}

private enum LpspNetflixShowroomData {
    static let profiles: [LpspNetflixShowroomProfile] = [
        .init(id: "p1", name: "Maya", accent: LpspNetflixTokens.netflixRed, isKids: false),
        .init(id: "p2", name: "Jordan", accent: Color(red: 0.243, green: 0.243, blue: 0.569), isKids: false),
        .init(id: "p3", name: "Kids", accent: Color(red: 0.973, green: 0.596, blue: 0.114), isKids: true),
    ]

    static let titles: [LpspNetflixShowroomTitle] = [
        .init(
            id: "t1", name: "Night Wave", shortTitle: "NIGHT\nWAVE", tagline: "This week's #1 series",
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
            id: "t2", name: "The Louvre Files", shortTitle: "LOUVRE\nFILES", tagline: "Limited series",
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
            id: "t3", name: "Metro Line 1", shortTitle: "METRO\nLINE 1", tagline: "New episodes",
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
        .preferredColorScheme(.dark)
        .sheet(item: $store.presentedTitle) { title in
            LpspNetflixTitleDetailScreen(store: store, title: title)
        }
        .fullScreenCover(isPresented: $store.showPlayer) {
            if let title = store.playingTitle {
                LpspNetflixPlayerScreen(store: store, title: title)
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
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon).font(.system(size: 20))
                        Text(tab.label).font(LpspNetflixFonts.tab)
                    }
                    .foregroundStyle(selectedTab == tab ? .white : LpspNetflixTokens.netflixTextSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(LpspNetflixPressableStyle())
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 2)
        .background(LpspNetflixTokens.netflixSurface1)
    }
}

private struct LpspNetflixHomeTabScreen: View {
    @ObservedObject var store: LpspNetflixStore

    private let chips = ["TV Shows", "Movies", "My List", "Thriller"]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                heroBanner
                VStack(alignment: .leading, spacing: 22) {
                    if !store.continueWatching.isEmpty {
                        continueWatchingRow
                    }
                    ForEach(store.filteredHomeRows, id: \.0) { row in
                        posterRow(title: row.0, titles: row.1)
                    }
                    top10Row
                }
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
        }
        .background(LpspNetflixTokens.netflixCanvas.ignoresSafeArea())
    }

    private var heroBanner: some View {
        let hero = store.heroTitle
        return ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [hero.accent, LpspNetflixTokens.netflixCanvas],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 420)

            LinearGradient(colors: [.clear, LpspNetflixTokens.netflixCanvas], startPoint: .top, endPoint: .bottom)
                .frame(height: 140)

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("NETFLIX")
                        .font(.system(size: 22, weight: .black))
                        .foregroundStyle(LpspNetflixTokens.netflixRed)
                    Spacer()
                    Image(systemName: "bell")
                    Image(systemName: "magnifyingglass")
                }
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.top, 8)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(chips, id: \.self) { chip in
                            Button {
                                store.homeChip = store.homeChip == chip ? nil : chip
                            } label: {
                                Text(chip)
                                    .font(LpspNetflixFonts.meta)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 6)
                                    .overlay(Capsule().stroke(Color.white.opacity(0.45), lineWidth: 1))
                            }
                            .buttonStyle(LpspNetflixPressableStyle())
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    Text(hero.name.uppercased())
                        .font(LpspNetflixFonts.heroTitle)
                        .foregroundStyle(.white)
                    Text(hero.genres)
                        .font(LpspNetflixFonts.meta)
                        .foregroundStyle(.white)
                    Text(hero.tagline)
                        .font(LpspNetflixFonts.body)
                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                    HStack(spacing: 10) {
                        LpspNetflixPlayButton(title: "Play") {
                            store.play(hero)
                        }
                        .frame(maxWidth: 140)
                        LpspNetflixSecondaryButton(
                            icon: store.isInMyList(hero) ? "checkmark" : "plus",
                            title: "My List"
                        ) {
                            store.toggleMyList(hero)
                        }
                        .frame(maxWidth: 140)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
        }
    }

    private var continueWatchingRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Continue Watching")
                .font(LpspNetflixFonts.rowHeader)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(store.continueWatching) { item in
                        Button {
                            store.resume(item)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                LpspNetflixPoster(title: item.title, width: 160, progress: item.progress)
                                Text(item.episodeLabel)
                                    .font(LpspNetflixFonts.meta)
                                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                    .lineLimit(1)
                                    .frame(width: 160, alignment: .leading)
                            }
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func posterRow(title: String, titles: [LpspNetflixShowroomTitle]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(LpspNetflixFonts.rowHeader)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(titles) { item in
                        Button {
                            store.presentedTitle = item
                        } label: {
                            LpspNetflixPoster(title: item, width: 120)
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private var top10Row: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Top 10 in France Today")
                .font(LpspNetflixFonts.rowHeader)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(Array(store.titles.prefix(5).enumerated()), id: \.element.id) { index, title in
                        Button {
                            store.presentedTitle = title
                        } label: {
                            HStack(alignment: .bottom, spacing: -18) {
                                Text("\(index + 1)")
                                    .font(.system(size: 110, weight: .black))
                                    .foregroundStyle(LpspNetflixTokens.netflixSurface1)
                                    .overlay(
                                        Text("\(index + 1)")
                                            .font(.system(size: 110, weight: .black))
                                            .foregroundStyle(Color.white.opacity(0.12))
                                    )
                                LpspNetflixPoster(title: title, width: 100)
                            }
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                        .padding(.trailing, 8)
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
                VStack(alignment: .leading, spacing: 20) {
                    Text("Coming Soon")
                        .font(LpspNetflixFonts.rowHeader)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)

                    ForEach(store.titles.prefix(3)) { title in
                        Button {
                            store.presentedTitle = title
                        } label: {
                            HStack(spacing: 12) {
                                LpspNetflixPoster(title: title, width: 80)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(title.name)
                                        .font(LpspNetflixFonts.rowHeader)
                                        .foregroundStyle(.white)
                                    Text(title.tagline)
                                        .font(LpspNetflixFonts.meta)
                                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                    Text("Remind Me")
                                        .font(LpspNetflixFonts.meta)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Capsule().stroke(Color.white.opacity(0.5), lineWidth: 1))
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

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                Text("Who's watching?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top, 24)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(store.profiles) { profile in
                        Button {
                            store.selectProfile(profile)
                        } label: {
                            VStack(spacing: 10) {
                                Circle()
                                    .fill(profile.accent)
                                    .frame(width: 84, height: 84)
                                    .overlay(
                                        Image(systemName: profile.isKids ? "face.smiling" : "person.fill")
                                            .font(.system(size: 36))
                                            .foregroundStyle(.white)
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(
                                                store.selectedProfile == profile ? .white : .clear,
                                                lineWidth: 3
                                            )
                                    )
                                Text(profile.name)
                                    .font(LpspNetflixFonts.body)
                                    .foregroundStyle(
                                        store.selectedProfile == profile ? .white : LpspNetflixTokens.netflixTextSecondary
                                    )
                            }
                        }
                        .buttonStyle(LpspNetflixPressableStyle())
                    }
                }
                .padding(.horizontal, 24)

                if let profile = store.selectedProfile {
                    Text("Watching as \(profile.name)")
                        .font(LpspNetflixFonts.body)
                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                }

                Button("Manage Profiles") { }
                    .font(LpspNetflixFonts.body)
                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
            }
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
                        store.resume(item)
                    } label: {
                        HStack(spacing: 12) {
                            LpspNetflixPoster(title: item.title, width: 72)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title.name)
                                    .font(LpspNetflixFonts.rowHeader)
                                    .foregroundStyle(.white)
                                Text(item.episodeLabel)
                                    .font(LpspNetflixFonts.meta)
                                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                Text("Downloaded")
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
                VStack(alignment: .leading, spacing: 18) {
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(
                            colors: [title.accent, LpspNetflixTokens.netflixCanvas],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 220)
                        Text(title.name)
                            .font(LpspNetflixFonts.heroTitle)
                            .foregroundStyle(.white)
                            .padding()
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text("\(title.match)% Match")
                                .foregroundStyle(LpspNetflixTokens.netflixProfileYellow)
                            Text(title.year)
                            Text(title.rating)
                                .padding(.horizontal, 4)
                                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white.opacity(0.6), lineWidth: 1))
                        }
                        .font(LpspNetflixFonts.meta)
                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)

                        Text(title.synopsis)
                            .font(LpspNetflixFonts.body)
                            .foregroundStyle(.white)

                        HStack(spacing: 10) {
                            LpspNetflixPlayButton(title: "Play") {
                                dismiss()
                                store.play(title)
                            }
                            LpspNetflixSecondaryButton(
                                icon: store.isInMyList(title) ? "checkmark" : "plus",
                                title: "My List"
                            ) {
                                store.toggleMyList(title)
                            }
                        }
                    }
                    .padding(.horizontal, 16)

                    if title.isSeries {
                        Text("Episodes")
                            .font(LpspNetflixFonts.rowHeader)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)

                        ForEach(title.episodes) { episode in
                            Button {
                                dismiss()
                                store.play(title, episode: episode)
                            } label: {
                                HStack(alignment: .top, spacing: 12) {
                                    Text("\(episode.episode)")
                                        .font(.title2.bold())
                                        .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                                        .frame(width: 28)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(episode.title)
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
                            .buttonStyle(LpspNetflixPressableStyle())
                        }
                    }
                }
            }
            .background(LpspNetflixTokens.netflixCanvas.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(.white)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

private struct LpspNetflixPlayerScreen: View {
    @ObservedObject var store: LpspNetflixStore
    let title: LpspNetflixShowroomTitle
    @Environment(\.dismiss) private var dismiss
    @State private var showControls = true

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LinearGradient(
                colors: [title.accent.opacity(0.35), .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.white.opacity(0.85))
                Text(store.playingEpisode?.title ?? title.name)
                    .font(LpspNetflixFonts.heroTitle)
                    .foregroundStyle(.white)
                Text(store.playingEpisode.map { "S\($0.season):E\($0.episode)" } ?? title.genres)
                    .font(LpspNetflixFonts.body)
                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
                Spacer()
            }

            if showControls {
                VStack {
                    HStack {
                        Button {
                            store.advancePlayback()
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(Circle().fill(Color.black.opacity(0.45)))
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    HStack(spacing: 36) {
                        Image(systemName: "backward.fill").font(.title2)
                        Image(systemName: "pause.fill").font(.largeTitle)
                        Image(systemName: "forward.fill").font(.title2)
                    }
                    .foregroundStyle(.white)
                    .padding(.bottom, 40)
                }
            }
        }
        .onTapGesture {
            withAnimation { showControls.toggle() }
        }
        .preferredColorScheme(.dark)
    }
}

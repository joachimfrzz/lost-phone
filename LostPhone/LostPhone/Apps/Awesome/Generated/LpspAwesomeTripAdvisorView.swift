import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/tripadvisor
// Meliwat/awesome-ios-design-md/travel/tripadvisor/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTripAdvisorView: View {
    var body: some View {
        LpspTripAdvisorShowroomRoot(store: LpspTripAdvisorStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTripAdvisorFonts {
    static let taTitleLarge  = Font.system(size: 28, weight: .regular)
    static let taPlaceHero   = Font.system(size: 24, weight: .regular)
    static let taSection     = Font.system(size: 22, weight: .regular)
    static let taPlaceName   = Font.system(size: 17, weight: .regular)
    static let taCardTitle   = Font.system(size: 16, weight: .regular)
    static let taReviewBody  = Font.system(size: 15, weight: .regular)
    static let taButton      = Font.system(size: 16, weight: .regular)
    static let taButtonSec   = Font.system(size: 15, weight: .regular)
    static let taMeta        = Font.system(size: 13, weight: .regular)
    static let taTab         = Font.system(size: 11, weight: .regular)
    static let taBadge       = Font.system(size: 11, weight: .regular)
    static let taCaption     = Font.system(size: 12, weight: .regular)
    static func ta(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspTripAdvisorTokens {
    // MARK: - Canvas & Surfaces
    static let taCanvas        = Color.white                                    // #FFFFFF
    static let taSurface       = Color(red: 0.949, green: 0.949, blue: 0.949)   // #F2F2F2
    static let taDivider       = Color(red: 0.878, green: 0.878, blue: 0.878)   // #E0E0E0
    static let taSurfacePressed = Color(red: 0.910, green: 0.910, blue: 0.910)  // #E8E8E8

    // MARK: - Text
    static let taTextPrimary   = Color.black                                    // #000000
    static let taTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)   // #6B6B6B
    static let taTextTertiary  = Color(red: 0.608, green: 0.608, blue: 0.608)   // #9B9B9B

    // MARK: - Brand
    static let taGreen         = Color(red: 0.204, green: 0.878, blue: 0.631)   // #34E0A1
    static let taGreenPressed  = Color(red: 0.129, green: 0.773, blue: 0.537)   // #21C589
    static let taOwlBlack      = Color.black                                    // #000000

    // MARK: - Semantic
    static let taEmptyBubble   = Color(red: 0.851, green: 0.851, blue: 0.851)   // #D9D9D9
    static let taErrorRed      = Color(red: 0.839, green: 0.071, blue: 0.180)   // #D6122E
}





fileprivate struct LpspTripAdvisorBubbleRating: View {
    let value: Double          // 0.0 ... 5.0
    var size: CGFloat = 16
    var reviewCount: Int? = nil

    var body: some View {
        HStack(spacing: 6) {
            HStack(spacing: 2) {
                ForEach(0..<5) { i in
                    bubble(at: i)
                }
            }
            if let count = reviewCount {
                Text("\(String(format: "%.1f", value)) (\(count.formatted()))")
                    .font(LpspTripAdvisorFonts.taMeta)
                    .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
            }
        }
    }

    @ViewBuilder
    private func bubble(at index: Int) -> some View {
        let fill = min(max(value - Double(index), 0), 1)  // 0, 0.5, or 1
        ZStack {
            Circle().fill(LpspTripAdvisorTokens.taEmptyBubble)
            Circle()
                .fill(LpspTripAdvisorTokens.taGreen)
                .mask(
                    Rectangle()
                        .frame(width: size * fill)
                        .frame(width: size, alignment: .leading)
                )
        }
        .frame(width: size, height: size)
    }
}

fileprivate struct LpspTripAdvisorBubbleRatingPicker: View {
    @Binding var rating: Int   // 1 ... 5
    var size: CGFloat = 32

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...5, id: \.self) { i in
                Circle()
                    .fill(i <= rating ? LpspTripAdvisorTokens.taGreen : LpspTripAdvisorTokens.taEmptyBubble)
                    .frame(width: size, height: size)
                    .scaleEffect(i == rating ? 1.0 : 1.0)
                    .onTapGesture { rating = i }
                    .sensoryFeedback(.impact(weight: .light), trigger: rating)
                    .animation(.spring(response: 0.2, dampingFraction: 0.6), value: rating)
            }
        }
    }
}

fileprivate struct LpspTripAdvisorTAPillButton: View {
    let title: String
    var style: LpspTripAdvisorStyle = .filled
    let action: () -> Void

    enum LpspTripAdvisorStyle { case filled, outline }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(style == .filled ? LpspTripAdvisorFonts.taButton : LpspTripAdvisorFonts.taButtonSec)
                .foregroundStyle(.black)
                .padding(.vertical, style == .filled ? 14 : 12)
                .padding(.horizontal, style == .filled ? 28 : 24)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule().fill(style == .filled ? LpspTripAdvisorTokens.taGreen : .clear)
                )
                .overlay(
                    Capsule().strokeBorder(style == .outline ? Color.black : .clear, lineWidth: 1)
                )
        }
        .buttonStyle(LpspTripAdvisorTAPressableStyle())
    }
}

fileprivate struct LpspTripAdvisorTAPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspTripAdvisorPlaceCard: View {
    let name: String
    let photo: Image
    let rating: Double
    let reviews: Int
    let category: String
    let priceTier: String
    let distance: String
    let isAwarded: Bool
    @State private var saved = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                photo
                    .resizable()
                    .aspectRatio(3/2, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Button {
                    saved.toggle()
                } label: {
                    Image(systemName: saved ? "heart.fill" : "heart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(saved ? LpspTripAdvisorTokens.taGreen : .white)
                        .padding(8)
                        .background(Circle().fill(.black.opacity(0.30)))
                }
                .sensoryFeedback(.success, trigger: saved)
                .padding(12)
            }

            if isAwarded {
                Text("TRAVELERS' CHOICE")
                    .font(LpspTripAdvisorFonts.taBadge)
                    .foregroundStyle(.black)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(LpspTripAdvisorTokens.taGreen))
            }

            Text(name).font(LpspTripAdvisorFonts.taPlaceName).foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
            LpspTripAdvisorBubbleRating(value: rating, size: 16, reviewCount: reviews)
            Text("\(category) · \(priceTier) · \(distance)")
                .font(LpspTripAdvisorFonts.taMeta)
                .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
        }
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspTripAdvisorPlaceHero: View {
    let name: String
    let photo: Image
    let rating: Double
    let reviews: Int

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            photo
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 280)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.55)],
                startPoint: .center, endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 8) {
                Text(name).font(LpspTripAdvisorFonts.taPlaceHero).foregroundStyle(.white)
                HStack(spacing: 6) {
                    LpspTripAdvisorBubbleRating(value: rating, size: 18)
                    Text("\(reviews.formatted()) reviews")
                        .font(LpspTripAdvisorFonts.taMeta).foregroundStyle(.white)
                }
            }
            .padding(20)
        }
        .frame(height: 280)
        .clipped()
    }
}



// MARK: - Showroom data & store

private enum LpspTripAdvisorShowroomTab: String, CaseIterable, Identifiable {
    case explore, search, trips, review, more

    var id: String { rawValue }

    var title: String {
        switch self {
        case .explore: "Explore"
        case .search: "Search"
        case .trips: "Trips"
        case .review: "Review"
        case .more: "More"
        }
    }

    var icon: String {
        switch self {
        case .explore: "safari.fill"
        case .search: "magnifyingglass"
        case .trips: "suitcase.fill"
        case .review: "square.and.pencil"
        case .more: "ellipsis"
        }
    }
}

private struct LpspTripAdvisorPlace: Identifiable, Equatable {
    let id: String
    let name: String
    let category: String
    let filterCategory: String
    let rating: Double
    let reviews: Int
    let meta: String
    let travelersChoice: Bool
    let photoCount: Int
    let photoColors: [Color]
    var isSaved: Bool
}

private enum LpspTripAdvisorShowroomData {
    static let location = "New York City ▾"
    static let searchPlaceholder = "Hotels, things to do, restaurants…"

    static let categories: [(icon: String, label: String)] = [
        ("house.fill", "Hotels"),
        ("figure.walk", "Things to do"),
        ("fork.knife", "Restaurants"),
        ("airplane", "Flights"),
    ]

    static let places: [LpspTripAdvisorPlace] = [
        LpspTripAdvisorPlace(
            id: "harborview",
            name: "The Harborview Grand Hotel",
            category: "Hotel",
            filterCategory: "Hotels",
            rating: 4.5,
            reviews: 1284,
            meta: "Hotel · $$ - $$$ · 0.4 mi · #2 of 240 hotels",
            travelersChoice: true,
            photoCount: 5,
            photoColors: [
                Color(red: 0.22, green: 0.42, blue: 0.72),
                Color(red: 0.12, green: 0.28, blue: 0.52),
            ],
            isSaved: true
        ),
        LpspTripAdvisorPlace(
            id: "olive-thyme",
            name: "Olive & Thyme Bistro",
            category: "Mediterranean",
            filterCategory: "Restaurants",
            rating: 4.0,
            reviews: 642,
            meta: "Mediterranean · $$ - $$$ · 0.7 mi",
            travelersChoice: false,
            photoCount: 3,
            photoColors: [
                Color(red: 0.82, green: 0.58, blue: 0.32),
                Color(red: 0.52, green: 0.32, blue: 0.18),
            ],
            isSaved: false
        ),
    ]

    static let moreItems = [
        "Account settings",
        "Help Center",
        "About Tripadvisor",
    ]
}

@MainActor
fileprivate final class LpspTripAdvisorStore: ObservableObject {
    @Published var selectedTab: LpspTripAdvisorShowroomTab = .explore
    @Published var selectedCategoryIndex: Int?
    @Published var places: [LpspTripAdvisorPlace] = LpspTripAdvisorShowroomData.places
    @Published var searchQuery = ""
    @Published var selectedPlaceID: String?
    @Published var showPlaceSheet = false
    @Published var tripPlaceIDs: [String] = []
    @Published var reviewRating = 4
    @Published var lastActionMessage = ""

    var savedPlaces: [LpspTripAdvisorPlace] {
        places.filter(\.isSaved)
    }

    func openSearch() {
        selectedTab = .search
        lastActionMessage = "Search opened"
    }

    func selectCategory(_ index: Int) {
        selectedCategoryIndex = selectedCategoryIndex == index ? nil : index
        lastActionMessage = "Filtered by \(LpspTripAdvisorShowroomData.categories[index].label)"
    }

    func performSearch() {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            lastActionMessage = "Enter a search term"
        } else {
            lastActionMessage = "Results for \"\(query)\" in New York City"
        }
    }

    func toggleSave(_ placeID: String) {
        guard let index = places.firstIndex(where: { $0.id == placeID }) else { return }
        var updated = places[index]
        updated.isSaved.toggle()
        places[index] = updated
        lastActionMessage = updated.isSaved ? "Saved \(updated.name)" : "Removed save"
    }

    func selectPlace(_ place: LpspTripAdvisorPlace) {
        selectedPlaceID = place.id
        showPlaceSheet = true
    }

    func savePlaceToTrip() {
        guard let id = selectedPlaceID,
              let place = places.first(where: { $0.id == id }) else { return }
        if !tripPlaceIDs.contains(id) {
            tripPlaceIDs.append(id)
        }
        showPlaceSheet = false
        lastActionMessage = "Added \(place.name) to trip"
        selectedTab = .trips
    }

    func submitReview() {
        lastActionMessage = "Review submitted · \(reviewRating) bubbles"
    }

    func filteredPlaces() -> [LpspTripAdvisorPlace] {
        guard let index = selectedCategoryIndex else { return places }
        let label = LpspTripAdvisorShowroomData.categories[index].label
        if label == "Flights" || label == "Things to do" { return [] }
        return places.filter { $0.filterCategory == label }
    }
}

// MARK: - Écrans showroom

private struct LpspTripAdvisorShowroomRoot: View {
    @ObservedObject var store: LpspTripAdvisorStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .explore:
                    LpspTripAdvisorSpectrHomeTabScreen(store: store)
                case .search:
                    LpspTripAdvisorSearchTabScreen(store: store)
                case .trips:
                    LpspTripAdvisorTripsTabScreen(store: store)
                case .review:
                    LpspTripAdvisorReviewTabScreen(store: store)
                case .more:
                    LpspTripAdvisorMoreTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspTripAdvisorLabeledTabBar(store: store)
        }
        .background(LpspTripAdvisorTokens.taCanvas.ignoresSafeArea())
        .sheet(isPresented: $store.showPlaceSheet) {
            if let id = store.selectedPlaceID,
               let place = store.places.first(where: { $0.id == id }) {
                LpspTripAdvisorPlaceSheet(store: store, place: place)
            }
        }
    }
}

private struct LpspTripAdvisorLabeledTabBar: View {
    @ObservedObject var store: LpspTripAdvisorStore

    var body: some View {
        HStack {
            ForEach(LpspTripAdvisorShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspTripAdvisorFonts.taTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspTripAdvisorTokens.taGreen
                            : LpspTripAdvisorTokens.taTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspTripAdvisorTokens.taCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspTripAdvisorTokens.taDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspTripAdvisorShowroomTopNav: View {
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LpspTripAdvisorTokens.taOwlBlack)
                    .frame(width: 32, height: 32)
                HStack(spacing: 6) {
                    Circle()
                        .fill(LpspTripAdvisorTokens.taGreen)
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(LpspTripAdvisorTokens.taGreen)
                        .frame(width: 8, height: 8)
                }
            }

            Text(LpspTripAdvisorShowroomData.location)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)

            Spacer()

            Circle()
                .fill(
                    LinearGradient(
                        colors: [.orange, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 32, height: 32)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
    }
}

private struct LpspTripAdvisorShowroomSearchPill: View {
    @ObservedObject var store: LpspTripAdvisorStore

    var body: some View {
        Button {
            store.openSearch()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
                Text(LpspTripAdvisorShowroomData.searchPlaceholder)
                    .font(.system(size: 15))
                    .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(LpspTripAdvisorTokens.taSurface)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
    }
}

private struct LpspTripAdvisorShowroomCategoryGrid: View {
    @ObservedObject var store: LpspTripAdvisorStore

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Array(LpspTripAdvisorShowroomData.categories.enumerated()), id: \.offset) { index, cat in
                let selected = store.selectedCategoryIndex == index
                Button {
                    store.selectCategory(index)
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: cat.icon)
                            .font(.system(size: 22))
                            .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                        Text(cat.label)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(selected ? LpspTripAdvisorTokens.taGreen.opacity(0.2) : LpspTripAdvisorTokens.taSurface)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(
                                selected ? LpspTripAdvisorTokens.taGreen : Color.clear,
                                lineWidth: 2
                            )
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct LpspTripAdvisorShowroomPlaceCard: View {
    let place: LpspTripAdvisorPlace
    let onTap: () -> Void
    let onSave: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topLeading) {
                    LinearGradient(
                        colors: place.photoColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .aspectRatio(3/2, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(alignment: .bottom) {
                        HStack(spacing: 5) {
                            ForEach(0..<place.photoCount, id: \.self) { idx in
                                Circle()
                                    .fill(idx == 0 ? LpspTripAdvisorTokens.taGreen : LpspTripAdvisorTokens.taEmptyBubble)
                                    .frame(width: 6, height: 6)
                            }
                        }
                        .padding(.bottom, 10)
                    }

                    if place.travelersChoice {
                        Text("Travelers' Choice")
                            .font(LpspTripAdvisorFonts.taBadge.weight(.bold))
                            .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(
                                Capsule()
                                    .fill(LpspTripAdvisorTokens.taGreen)
                            )
                            .padding(12)
                    }

                    Button(action: onSave) {
                        Image(systemName: place.isSaved ? "heart.fill" : "heart")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(place.isSaved ? LpspTripAdvisorTokens.taGreen : .white)
                            .padding(8)
                            .background(Circle().fill(.black.opacity(0.30)))
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(12)
                }

                LpspTripAdvisorBubbleRating(value: place.rating, size: 16, reviewCount: place.reviews)

                Text(place.name)
                    .font(LpspTripAdvisorFonts.taPlaceName.weight(.bold))
                    .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)

                Text(place.meta)
                    .font(LpspTripAdvisorFonts.taMeta)
                    .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct LpspTripAdvisorSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspTripAdvisorStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                LpspTripAdvisorShowroomTopNav()

                LpspTripAdvisorShowroomSearchPill(store: store)

                LpspTripAdvisorShowroomCategoryGrid(store: store)

                if store.filteredPlaces().isEmpty {
                    Text("No results in this category yet.")
                        .font(LpspTripAdvisorFonts.taBody)
                        .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
                        .padding(.horizontal, 16)
                } else {
                    ForEach(store.filteredPlaces()) { place in
                        LpspTripAdvisorShowroomPlaceCard(
                            place: place,
                            onTap: { store.selectPlace(place) },
                            onSave: { store.toggleSave(place.id) }
                        )
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspTripAdvisorSearchTabScreen: View {
    @ObservedObject var store: LpspTripAdvisorStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Search")
                    .font(LpspTripAdvisorFonts.taSection.weight(.bold))
                    .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                    .padding(.top, 8)

                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
                    TextField(LpspTripAdvisorShowroomData.searchPlaceholder, text: $store.searchQuery)
                        .font(LpspTripAdvisorFonts.taBody)
                }
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LpspTripAdvisorTokens.taSurface)
                )

                LpspTripAdvisorTAPillButton(title: "Search") {
                    store.performSearch()
                }

                if !store.lastActionMessage.isEmpty && store.selectedTab == .search {
                    Text(store.lastActionMessage)
                        .font(LpspTripAdvisorFonts.taMeta)
                        .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
                }

                ForEach(store.places) { place in
                    LpspTripAdvisorShowroomPlaceCard(
                        place: place,
                        onTap: { store.selectPlace(place) },
                        onSave: { store.toggleSave(place.id) }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

private struct LpspTripAdvisorTripsTabScreen: View {
    @ObservedObject var store: LpspTripAdvisorStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Trips")
                    .font(LpspTripAdvisorFonts.taSection.weight(.bold))
                    .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                if store.tripPlaceIDs.isEmpty {
                    Text("Save places to your trip from a listing.")
                        .font(LpspTripAdvisorFonts.taBody)
                        .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
                        .padding(.horizontal, 16)
                } else {
                    ForEach(store.tripPlaceIDs, id: \.self) { id in
                        if let place = store.places.first(where: { $0.id == id }) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(place.name)
                                    .font(LpspTripAdvisorFonts.taPlaceName.weight(.bold))
                                    .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                                Text(place.meta)
                                    .font(LpspTripAdvisorFonts.taMeta)
                                    .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
                                LpspTripAdvisorBubbleRating(value: place.rating, size: 14, reviewCount: place.reviews)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LpspTripAdvisorTokens.taSurface)
                            )
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspTripAdvisorReviewTabScreen: View {
    @ObservedObject var store: LpspTripAdvisorStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Review")
                    .font(LpspTripAdvisorFonts.taSection.weight(.bold))
                    .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                    .padding(.top, 8)

                Text("How was your visit?")
                    .font(LpspTripAdvisorFonts.taCardTitle)
                    .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)

                LpspTripAdvisorBubbleRatingPicker(rating: $store.reviewRating, size: 36)

                LpspTripAdvisorTAPillButton(title: "Submit review") {
                    store.submitReview()
                }

                if !store.lastActionMessage.isEmpty && store.selectedTab == .review {
                    Text(store.lastActionMessage)
                        .font(LpspTripAdvisorFonts.taMeta)
                        .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

private struct LpspTripAdvisorMoreTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("More")
                    .font(LpspTripAdvisorFonts.taSection.weight(.bold))
                    .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                ForEach(LpspTripAdvisorShowroomData.moreItems, id: \.self) { item in
                    HStack {
                        Text(item)
                            .font(LpspTripAdvisorFonts.taBody)
                            .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(LpspTripAdvisorTokens.taTextTertiary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspTripAdvisorPlaceSheet: View {
    @ObservedObject var store: LpspTripAdvisorStore
    let place: LpspTripAdvisorPlace
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: place.photoColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .aspectRatio(3/2, contentMode: .fit)

                    Text(place.name)
                        .font(LpspTripAdvisorFonts.taPlaceHero.weight(.bold))
                        .foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)

                    LpspTripAdvisorBubbleRating(value: place.rating, size: 18, reviewCount: place.reviews)

                    Text(place.meta)
                        .font(LpspTripAdvisorFonts.taMeta)
                        .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)

                    LpspTripAdvisorTAPillButton(title: "Save to trip") {
                        store.savePlaceToTrip()
                        dismiss()
                    }
                }
                .padding(16)
            }
            .background(LpspTripAdvisorTokens.taCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
        .presentationDetents([.large])
    }
}



import SwiftUI
import MapKit

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/google-maps
// Meliwat/awesome-ios-design-md/travel/google-maps/DESIGN-swiftui.md
struct LpspAwesomePlansView: View {
    var mapsData: LpspMapsData?

    var body: some View {
        let storyData = mapsData
        LpspPlansShowroomRoot(
            store: LpspPlansStore(
                places: storyData.map { LpspPlansStore.places(from: $0) } ?? LpspPlansShowroomData.places,
                trips: storyData.map { LpspPlansStore.trips(from: $0) } ?? LpspPlansShowroomData.trips,
                routes: storyData.map { LpspPlansStore.routes(from: $0) } ?? LpspPlansShowroomData.routes
            ),
            isStoryMode: storyData != nil
        )
    }
}

// MARK: - Tokens & composants

private enum LpspPlansTokens {
    static let canvas       = Color.white
    static let surfaceMuted = Color(red: 0.945, green: 0.953, blue: 0.957)
    static let divider      = Color(red: 0.855, green: 0.863, blue: 0.878)
    static let textPrimary  = Color(red: 0.125, green: 0.133, blue: 0.141)
    static let textSecondary = Color(red: 0.373, green: 0.388, blue: 0.408)
    static let blue         = Color(red: 0.259, green: 0.522, blue: 0.957)
    static let bluePressed  = Color(red: 0.102, green: 0.451, blue: 0.910)
    static let red          = Color(red: 0.918, green: 0.263, blue: 0.208)
    static let yellow       = Color(red: 0.984, green: 0.737, blue: 0.016)
    static let green        = Color(red: 0.204, green: 0.659, blue: 0.325)
    static let orange       = Color(red: 0.984, green: 0.549, blue: 0.000)
    static let blueHalo     = Color(red: 0.259, green: 0.522, blue: 0.957, opacity: 0.18)
    static let blueHaloEdge = Color(red: 0.259, green: 0.522, blue: 0.957, opacity: 0.4)
}

private enum LpspPlansFonts {
    static let screenTitle = Font.system(size: 22, weight: .semibold)
    static let placeTitle  = Font.system(size: 20, weight: .semibold)
    static let rowTitle    = Font.system(size: 16, weight: .medium)
    static let body        = Font.system(size: 14, weight: .regular)
    static let meta        = Font.system(size: 13, weight: .regular)
    static let tab         = Font.system(size: 10, weight: .regular)
    static let buttonSmall = Font.system(size: 14, weight: .medium)
}

fileprivate struct LpspPlansPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspPlansSearchBar: View {
    let placeholder: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Circle()
                    .fill(LpspPlansTokens.blue)
                    .frame(width: 28, height: 28)
                    .overlay(Text("M").font(.system(size: 12, weight: .bold)).foregroundStyle(.white))
                Text(placeholder)
                    .font(LpspPlansFonts.rowTitle)
                    .foregroundStyle(LpspPlansTokens.textSecondary)
                Spacer()
                Image(systemName: "mic.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(LpspPlansTokens.textSecondary)
            }
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(
                Capsule()
                    .fill(LpspPlansTokens.canvas)
                    .shadow(color: .black.opacity(0.12), radius: 8, y: 2)
            )
        }
        .buttonStyle(LpspPlansPressableStyle())
    }
}

fileprivate struct LpspPlansDirectionsFAB: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(LpspPlansTokens.blue))
                .shadow(color: .black.opacity(0.18), radius: 10, y: 4)
        }
        .buttonStyle(LpspPlansPressableStyle())
    }
}

fileprivate struct LpspPlansCategoryChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon).font(.system(size: 14))
                Text(title).font(LpspPlansFonts.buttonSmall)
            }
            .foregroundStyle(isSelected ? LpspPlansTokens.textPrimary : LpspPlansTokens.textSecondary)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule().fill(isSelected ? LpspPlansTokens.surfaceMuted : LpspPlansTokens.canvas)
                    .overlay(Capsule().stroke(LpspPlansTokens.divider, lineWidth: isSelected ? 0 : 1))
            )
        }
        .buttonStyle(LpspPlansPressableStyle())
    }
}

fileprivate struct LpspPlansPlaceCard: View {
    let place: LpspPlansShowroomPlace
    let isSaved: Bool
    let onDirections: () -> Void
    let onSave: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [place.accent.opacity(0.35), LpspPlansTokens.surfaceMuted],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 72, height: 72)
                    .overlay(Image(systemName: place.icon).font(.title2).foregroundStyle(LpspPlansTokens.blue))

                VStack(alignment: .leading, spacing: 4) {
                    Text(place.name)
                        .font(LpspPlansFonts.placeTitle)
                        .foregroundStyle(LpspPlansTokens.textPrimary)
                        .lineLimit(2)
                    HStack(spacing: 4) {
                        Text(String(format: "%.1f", place.rating))
                            .font(LpspPlansFonts.body)
                            .foregroundStyle(LpspPlansTokens.textPrimary)
                        ForEach(0..<5, id: \.self) { i in
                            Image(systemName: Double(i) < place.rating ? "star.fill" : "star")
                                .font(.system(size: 11))
                                .foregroundStyle(LpspPlansTokens.yellow)
                        }
                        Text("(\(place.reviewCount))")
                            .font(LpspPlansFonts.meta)
                            .foregroundStyle(LpspPlansTokens.textSecondary)
                    }
                    Text("\(place.category) · \(place.distance)")
                        .font(LpspPlansFonts.meta)
                        .foregroundStyle(LpspPlansTokens.textSecondary)
                    if place.isOpen {
                        Text("Ouvert")
                            .font(LpspPlansFonts.meta.weight(.medium))
                            .foregroundStyle(LpspPlansTokens.green)
                    }
                    Text(place.address)
                        .font(LpspPlansFonts.meta)
                        .foregroundStyle(LpspPlansTokens.textSecondary)
                        .lineLimit(1)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    actionPill("arrow.triangle.turn.up.right.diamond.fill", "Itinéraire", filled: true, action: onDirections)
                    actionPill(isSaved ? "bookmark.fill" : "bookmark", "Enregistrer", filled: false, action: onSave)
                    actionPill("square.and.arrow.up", "Partager", filled: false) { }
                    actionPill("phone.fill", "Appeler", filled: false) { }
                }
            }
        }
        .padding(16)
        .background(LpspPlansTokens.canvas)
    }

    private func actionPill(_ icon: String, _ title: String, filled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon).font(.system(size: 14, weight: .medium))
                Text(title).font(LpspPlansFonts.buttonSmall)
            }
            .foregroundStyle(filled ? .white : LpspPlansTokens.blue)
            .padding(.horizontal, 14)
            .frame(height: 36)
            .background(
                Capsule().fill(filled ? LpspPlansTokens.blue : Color.clear)
                    .overlay(Capsule().stroke(filled ? Color.clear : LpspPlansTokens.divider, lineWidth: 1))
            )
        }
        .buttonStyle(LpspPlansPressableStyle())
    }
}

fileprivate struct LpspPlansTurnCard: View {
    let instruction: String
    let distance: String
    let eta: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 14) {
                Image(systemName: "arrow.turn.up.right")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 4) {
                    Text(instruction)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    Text("dans \(distance) · \(eta)")
                        .font(LpspPlansFonts.meta)
                        .foregroundStyle(.white.opacity(0.75))
                }
                Spacer()
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).fill(LpspPlansTokens.blue))
        .shadow(color: .black.opacity(0.15), radius: 12, y: 4)
    }
}

fileprivate struct LpspPlansMapView: View {
    let places: [LpspPlansShowroomPlace]
    let selectedPlaceID: String?
    let showsRoute: Bool
    let routeEnd: LpspPlansShowroomPlace?

    private let userLocation = CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)

    var body: some View {
        Map(initialPosition: .region(MKCoordinateRegion(
            center: userLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.045, longitudeDelta: 0.045)
        ))) {
            Annotation("Vous", coordinate: userLocation) {
                ZStack {
                    Circle()
                        .fill(LpspPlansTokens.blueHalo)
                        .frame(width: 80, height: 80)
                    Circle()
                        .fill(LpspPlansTokens.blue)
                        .frame(width: 12, height: 12)
                        .overlay(Circle().stroke(.white, lineWidth: 3).frame(width: 18, height: 18))
                }
            }

            ForEach(places) { place in
                Annotation(place.name, coordinate: place.coordinate) {
                    Image(systemName: selectedPlaceID == place.id ? "mappin.circle.fill" : "mappin.circle")
                        .font(.system(size: 28))
                        .foregroundStyle(selectedPlaceID == place.id ? LpspPlansTokens.red : LpspPlansTokens.red.opacity(0.85))
                }
            }

            if showsRoute, let end = routeEnd {
                MapPolyline(coordinates: [userLocation, end.coordinate])
                    .stroke(LpspPlansTokens.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            }
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
        .mapControlVisibility(.hidden)
    }
}

// MARK: - Données & état

fileprivate struct LpspPlansShowroomPlace: Identifiable, Hashable {
    let id: String
    let name: String
    let address: String
    let category: String
    let rating: Double
    let reviewCount: Int
    let distance: String
    let isOpen: Bool
    let icon: String
    let accent: Color
    let coordinate: CLLocationCoordinate2D

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

fileprivate struct LpspPlansShowroomTrip: Identifiable, Hashable {
    let id: String
    let origin: String
    let destination: String
    let mode: String
    let duration: String
    let dateLabel: String
}

fileprivate struct LpspPlansShowroomRoute: Identifiable, Hashable {
    let id: String
    let name: String
    let origin: String
    let destination: String
    let duration: String
}

@MainActor
fileprivate final class LpspPlansStore: ObservableObject {
    @Published var selectedTab: LpspPlansTab = .explore
    @Published var selectedPlace: LpspPlansShowroomPlace?
    @Published var selectedCategory: String?
    @Published var showSearch = false
    @Published var showNavigation = false
    @Published var navigationDestination: LpspPlansShowroomPlace?
    @Published var searchQuery = ""
    @Published var savedPlaceIDs: Set<String>

    let places: [LpspPlansShowroomPlace]
    let trips: [LpspPlansShowroomTrip]
    let routes: [LpspPlansShowroomRoute]

    init(places: [LpspPlansShowroomPlace], trips: [LpspPlansShowroomTrip], routes: [LpspPlansShowroomRoute]) {
        self.places = places
        self.trips = trips
        self.routes = routes
        self.savedPlaceIDs = ["home", "work", "louvre"]
        self.selectedPlace = places.first { $0.id == "louvre" }
    }

    var filteredPlaces: [LpspPlansShowroomPlace] {
        let categoryFiltered = places.filter { place in
            guard let selectedCategory else { return true }
            return place.category.localizedCaseInsensitiveContains(selectedCategory)
        }
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return categoryFiltered }
        return categoryFiltered.filter {
            $0.name.lowercased().contains(query) || $0.address.lowercased().contains(query)
        }
    }

    var savedPlaces: [LpspPlansShowroomPlace] {
        places.filter { savedPlaceIDs.contains($0.id) }
    }

    func selectPlace(_ place: LpspPlansShowroomPlace) {
        selectedPlace = place
    }

    func toggleSaved(_ place: LpspPlansShowroomPlace) {
        if savedPlaceIDs.contains(place.id) {
            savedPlaceIDs.remove(place.id)
        } else {
            savedPlaceIDs.insert(place.id)
        }
    }

    func isSaved(_ place: LpspPlansShowroomPlace) -> Bool {
        savedPlaceIDs.contains(place.id)
    }

    func startDirections(to place: LpspPlansShowroomPlace) {
        navigationDestination = place
        selectedPlace = place
        showNavigation = true
        selectedTab = .go
    }

    static func places(from data: LpspMapsData) -> [LpspPlansShowroomPlace] {
        let coords: [CLLocationCoordinate2D] = [
            .init(latitude: 48.8606, longitude: 2.3376),
            .init(latitude: 48.8372, longitude: 2.3708),
            .init(latitude: 48.8606, longitude: 2.3376),
        ]
        return data.places.enumerated().map { index, place in
            LpspPlansShowroomPlace(
                id: place.id,
                name: place.label,
                address: place.address,
                category: "Adresse",
                rating: 4.5,
                reviewCount: 100,
                distance: "—",
                isOpen: true,
                icon: "mappin.circle.fill",
                accent: LpspPlansTokens.blue,
                coordinate: coords[index % coords.count]
            )
        }
    }

    static func trips(from data: LpspMapsData) -> [LpspPlansShowroomTrip] {
        data.trips.map { trip in
            LpspPlansShowroomTrip(
                id: trip.id,
                origin: trip.origin,
                destination: trip.destination,
                mode: trip.mode,
                duration: trip.duration,
                dateLabel: LpspAdapters.formatShortDate(trip.date, fallback: trip.dateRaw)
            )
        }
    }

    static func routes(from data: LpspMapsData) -> [LpspPlansShowroomRoute] {
        data.routes.map { route in
            LpspPlansShowroomRoute(
                id: route.id,
                name: route.name,
                origin: route.origin,
                destination: route.destination,
                duration: route.duration
            )
        }
    }
}

private enum LpspPlansShowroomData {
    static let places: [LpspPlansShowroomPlace] = [
        .init(id: "home", name: "Domicile", address: "14 Rue de Rivoli, 75001 Paris", category: "Domicile", rating: 0, reviewCount: 0, distance: "—", isOpen: true, icon: "house.fill", accent: LpspPlansTokens.blue, coordinate: .init(latitude: 48.8566, longitude: 2.3522)),
        .init(id: "work", name: "Travail", address: "Station F, 55 Bd Vincent Auriol", category: "Travail", rating: 0, reviewCount: 0, distance: "—", isOpen: true, icon: "briefcase.fill", accent: LpspPlansTokens.green, coordinate: .init(latitude: 48.8372, longitude: 2.3708)),
        .init(id: "louvre", name: "Musée du Louvre", address: "Rue de Rivoli, 75001 Paris", category: "Musée", rating: 4.7, reviewCount: 98241, distance: "350 m", isOpen: true, icon: "building.columns.fill", accent: LpspPlansTokens.orange, coordinate: .init(latitude: 48.8606, longitude: 2.3376)),
        .init(id: "boot", name: "Boot Café", address: "19 Rue du Pont aux Choux", category: "Café", rating: 4.6, reviewCount: 842, distance: "900 m", isOpen: true, icon: "cup.and.saucer.fill", accent: LpspPlansTokens.yellow, coordinate: .init(latitude: 48.8627, longitude: 2.3625)),
        .init(id: "nord", name: "Gare du Nord", address: "18 Rue de Dunkerque", category: "Gare", rating: 3.9, reviewCount: 12400, distance: "2,1 km", isOpen: true, icon: "tram.fill", accent: LpspPlansTokens.red, coordinate: .init(latitude: 48.8809, longitude: 2.3553)),
        .init(id: "bastille", name: "Place de la Bastille", address: "75011 Paris", category: "Monument", rating: 4.4, reviewCount: 5100, distance: "1,8 km", isOpen: true, icon: "mappin.and.ellipse", accent: LpspPlansTokens.red, coordinate: .init(latitude: 48.8530, longitude: 2.3690)),
    ]

    static let trips: [LpspPlansShowroomTrip] = [
        .init(id: "t1", origin: "Bastille", destination: "Musée du Louvre", mode: "Voiture", duration: "16 min", dateLabel: "12 juin"),
        .init(id: "t2", origin: "Domicile", destination: "Gare du Nord", mode: "Transports", duration: "22 min", dateLabel: "2 juin"),
        .init(id: "t3", origin: "Travail", destination: "Boot Café", mode: "À pied", duration: "14 min", dateLabel: "28 mai"),
    ]

    static let routes: [LpspPlansShowroomRoute] = [
        .init(id: "r1", name: "Maison → Travail", origin: "14 Rue de Rivoli", destination: "Station F", duration: "18 min"),
        .init(id: "r2", name: "Louvre → Gare du Nord", origin: "Musée du Louvre", destination: "Gare du Nord", duration: "24 min"),
    ]
}

// MARK: - Écrans showroom

private enum LpspPlansTab: CaseIterable {
    case explore, go, saved, contribute, updates

    var label: String {
        switch self {
        case .explore: "Explorer"
        case .go: "Go"
        case .saved: "Enregistrés"
        case .contribute: "Contribuer"
        case .updates: "Actus"
        }
    }

    var icon: String {
        switch self {
        case .explore: "safari.fill"
        case .go: "location.north.circle.fill"
        case .saved: "bookmark.fill"
        case .contribute: "plus.circle.fill"
        case .updates: "newspaper.fill"
        }
    }
}

private struct LpspPlansShowroomRoot: View {
    @ObservedObject var store: LpspPlansStore
    var isStoryMode = false

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .explore:
                    LpspPlansExploreTabScreen(store: store)
                case .go:
                    LpspPlansGoTabScreen(store: store)
                case .saved:
                    LpspPlansSavedTabScreen(store: store)
                case .contribute:
                    LpspPlansContributeTabScreen()
                case .updates:
                    LpspPlansUpdatesTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspPlansTabBar(selectedTab: $store.selectedTab)
        }
        .background(LpspPlansTokens.canvas.ignoresSafeArea())
        .sheet(isPresented: $store.showSearch) {
            LpspPlansSearchSheet(store: store)
        }
    }
}

private struct LpspPlansTabBar: View {
    @Binding var selectedTab: LpspPlansTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspPlansTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: selectedTab == tab ? .semibold : .regular))
                        Text(tab.label)
                            .font(LpspPlansFonts.tab)
                    }
                    .foregroundStyle(selectedTab == tab ? LpspPlansTokens.textPrimary : LpspPlansTokens.textSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(LpspPlansPressableStyle())
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspPlansTokens.canvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspPlansTokens.divider).frame(height: 0.5)
        }
    }
}

private struct LpspPlansExploreTabScreen: View {
    @ObservedObject var store: LpspPlansStore

    private let categories = [
        ("Restaurants", "fork.knife"),
        ("Cafés", "cup.and.saucer.fill"),
        ("Musées", "building.columns.fill"),
        ("Transports", "tram.fill"),
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            LpspPlansMapView(
                places: store.places,
                selectedPlaceID: store.selectedPlace?.id,
                showsRoute: false,
                routeEnd: nil
            )
            .ignoresSafeArea()

            VStack(spacing: 12) {
                LpspPlansSearchBar(placeholder: "Rechercher ici") {
                    store.showSearch = true
                }
                .padding(.horizontal, 4)
                .padding(.top, 8)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.0) { category, icon in
                            LpspPlansCategoryChip(
                                title: category,
                                icon: icon,
                                isSelected: store.selectedCategory == category
                            ) {
                                store.selectedCategory = store.selectedCategory == category ? nil : category
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }

                Spacer()

                HStack {
                    Spacer()
                    LpspPlansDirectionsFAB {
                        if let place = store.selectedPlace {
                            store.startDirections(to: place)
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, store.selectedPlace == nil ? 16 : 180)
                }
            }

            if let place = store.selectedPlace {
                VStack(spacing: 0) {
                    Capsule()
                        .fill(LpspPlansTokens.divider)
                        .frame(width: 36, height: 4)
                        .padding(.top, 8)
                    LpspPlansPlaceCard(
                        place: place,
                        isSaved: store.isSaved(place),
                        onDirections: { store.startDirections(to: place) },
                        onSave: { store.toggleSaved(place) }
                    )
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LpspPlansTokens.canvas)
                        .shadow(color: .black.opacity(0.12), radius: 12, y: -2)
                )
            }
        }
    }
}

private struct LpspPlansGoTabScreen: View {
    @ObservedObject var store: LpspPlansStore

    var body: some View {
        ZStack {
            if store.showNavigation, let destination = store.navigationDestination {
                LpspPlansMapView(
                    places: store.places,
                    selectedPlaceID: destination.id,
                    showsRoute: true,
                    routeEnd: destination
                )
                .ignoresSafeArea()

                VStack {
                    LpspPlansTurnCard(
                        instruction: "Tournez à droite sur \(destination.name)",
                        distance: "120 m",
                        eta: destination.distance == "—" ? "18 min" : destination.distance
                    )
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                    Spacer()
                    HStack {
                        Button {
                            store.showNavigation = false
                        } label: {
                            Text("Quitter")
                                .font(LpspPlansFonts.rowTitle)
                                .foregroundStyle(LpspPlansTokens.blue)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 10)
                                .background(Capsule().fill(LpspPlansTokens.canvas))
                        }
                        .buttonStyle(LpspPlansPressableStyle())
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 80)
                }
            } else {
                NavigationStack {
                    List {
                        Section("Itinéraires enregistrés") {
                            ForEach(store.routes) { route in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(route.name)
                                        .font(LpspPlansFonts.rowTitle)
                                        .foregroundStyle(LpspPlansTokens.textPrimary)
                                    Text("\(route.origin) → \(route.destination)")
                                        .font(LpspPlansFonts.meta)
                                        .foregroundStyle(LpspPlansTokens.textSecondary)
                                    Text(route.duration)
                                        .font(LpspPlansFonts.meta)
                                        .foregroundStyle(LpspPlansTokens.blue)
                                }
                                .padding(.vertical, 4)
                            }
                        }

                        Section("Trajets récents") {
                            ForEach(store.trips) { trip in
                                HStack(spacing: 12) {
                                    Image(systemName: icon(for: trip.mode))
                                        .foregroundStyle(LpspPlansTokens.blue)
                                        .frame(width: 28)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("\(trip.origin) → \(trip.destination)")
                                            .font(LpspPlansFonts.rowTitle)
                                            .foregroundStyle(LpspPlansTokens.textPrimary)
                                            .lineLimit(1)
                                        Text("\(trip.dateLabel) · \(trip.mode) · \(trip.duration)")
                                            .font(LpspPlansFonts.meta)
                                            .foregroundStyle(LpspPlansTokens.textSecondary)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .navigationTitle("Go")
                }
            }
        }
    }

    private func icon(for mode: String) -> String {
        let low = mode.lowercased()
        if low.contains("pied") { return "figure.walk" }
        if low.contains("transport") { return "tram.fill" }
        return "car.fill"
    }
}

private struct LpspPlansSavedTabScreen: View {
    @ObservedObject var store: LpspPlansStore

    var body: some View {
        NavigationStack {
            List {
                Section("Listes") {
                    Label("Favoris Paris", systemImage: "heart.fill")
                    Label("Lost Phone leads", systemImage: "magnifyingglass")
                }

                Section("Lieux enregistrés") {
                    ForEach(store.savedPlaces) { place in
                        Button {
                            store.selectPlace(place)
                            store.selectedTab = .explore
                        } label: {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(place.accent.opacity(0.25))
                                    .frame(width: 44, height: 44)
                                    .overlay(Image(systemName: place.icon).foregroundStyle(LpspPlansTokens.blue))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(place.name)
                                        .font(LpspPlansFonts.rowTitle)
                                        .foregroundStyle(LpspPlansTokens.textPrimary)
                                    Text(place.address)
                                        .font(LpspPlansFonts.meta)
                                        .foregroundStyle(LpspPlansTokens.textSecondary)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Enregistrés")
        }
    }
}

private struct LpspPlansContributeTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                Label("Ajouter un lieu", systemImage: "mappin.and.ellipse")
                Label("Évaluer un endroit", systemImage: "star")
                Label("Signaler un problème", systemImage: "exclamationmark.bubble")
                Label("Ajouter une photo", systemImage: "camera")
            }
            .navigationTitle("Contribuer")
        }
    }
}

private struct LpspPlansUpdatesTabScreen: View {
    @ObservedObject var store: LpspPlansStore

    var body: some View {
        NavigationStack {
            List {
                Section("Pour vous") {
                    ForEach(store.places.prefix(3)) { place in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Nouveau avis sur \(place.name)")
                                .font(LpspPlansFonts.rowTitle)
                            Text("Un utilisateur a partagé une photo récente.")
                                .font(LpspPlansFonts.meta)
                                .foregroundStyle(LpspPlansTokens.textSecondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Actus")
        }
    }
}

private struct LpspPlansSearchSheet: View {
    @ObservedObject var store: LpspPlansStore
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focused: Bool

    var body: some View {
        NavigationStack {
            List {
                if store.searchQuery.isEmpty {
                    Section("Suggestions") {
                        ForEach(store.places.prefix(4)) { place in
                            Button {
                                store.selectPlace(place)
                                dismiss()
                                store.selectedTab = .explore
                            } label: {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(place.name)
                                        .font(LpspPlansFonts.rowTitle)
                                        .foregroundStyle(LpspPlansTokens.textPrimary)
                                    Text(place.address)
                                        .font(LpspPlansFonts.meta)
                                        .foregroundStyle(LpspPlansTokens.textSecondary)
                                }
                            }
                        }
                    }
                } else {
                    Section("Résultats") {
                        ForEach(store.filteredPlaces) { place in
                            Button {
                                store.selectPlace(place)
                                dismiss()
                                store.selectedTab = .explore
                            } label: {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(place.name)
                                        .font(LpspPlansFonts.rowTitle)
                                        .foregroundStyle(LpspPlansTokens.textPrimary)
                                    Text(place.address)
                                        .font(LpspPlansFonts.meta)
                                        .foregroundStyle(LpspPlansTokens.textSecondary)
                                }
                            }
                        }
                    }
                }
            }
            .searchable(text: $store.searchQuery, prompt: "Rechercher un lieu")
            .navigationTitle("Recherche")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
        }
    }
}

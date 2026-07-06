import SwiftUI
import MapKit

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/uber
// Meliwat/awesome-ios-design-md/travel/uber/DESIGN-swiftui.md
struct LpspAwesomeUberView: View {
    var rides: [LpspRide]?
    var account: LpspUberAccount?

    var body: some View {
        let storyRides = rides?.isEmpty == false ? rides : nil
        let storyAccount = account
        LpspUberShowroomRoot(
            store: LpspUberStore(
                trips: storyRides.map { LpspUberStore.trips(from: $0) } ?? LpspUberShowroomData.trips,
                account: storyAccount.map { LpspUberStore.account(from: $0) } ?? LpspUberShowroomData.account
            ),
            isStoryMode: storyRides != nil
        )
    }
}

// MARK: - Tokens & composants

private enum LpspUberFonts {
    static let uberSheetTitle = Font.system(size: 18, weight: .bold)
    static let uberWhereTo    = Font.system(size: 18, weight: .regular)
    static let uberRowTitle   = Font.system(size: 16, weight: .semibold)
    static let uberMeta       = Font.system(size: 14, weight: .regular)
    static let uberCaption    = Font.system(size: 12, weight: .regular)
    static let uberPrice      = Font.system(size: 16, weight: .semibold)
    static let uberButton     = Font.system(size: 17, weight: .semibold)
    static let uberTab        = Font.system(size: 11, weight: .regular)
}

private enum LpspUberTokens {
    static let uberBlack      = Color.black
    static let uberWhite      = Color.white
    static let uberCanvasDark = Color(red: 0.047, green: 0.047, blue: 0.047)
    static let uberGray50     = Color(red: 0.965, green: 0.965, blue: 0.965)
    static let uberGray200    = Color(red: 0.898, green: 0.898, blue: 0.898)
    static let uberGray400    = Color(red: 0.686, green: 0.686, blue: 0.686)
    static let uberGray600    = Color(red: 0.459, green: 0.459, blue: 0.459)
    static let uberGray700    = Color(red: 0.329, green: 0.329, blue: 0.329)
    static let uberGray900    = Color(red: 0.184, green: 0.184, blue: 0.184)
    static let uberGray950    = Color(red: 0.102, green: 0.102, blue: 0.102)
    static let uberGreen      = Color(red: 0.020, green: 0.639, blue: 0.341)
}

fileprivate struct LpspUberPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.85), value: configuration.isPressed)
    }
}

fileprivate struct LpspUberWhereToInput: View {
    let destination: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                VStack(spacing: 4) {
                    Circle().fill(.white).frame(width: 8, height: 8)
                    ForEach(0..<3, id: \.self) { _ in
                        Rectangle().fill(LpspUberTokens.uberGray600).frame(width: 1, height: 3)
                    }
                    RoundedRectangle(cornerRadius: 1).fill(.white).frame(width: 8, height: 8)
                }
                .padding(.leading, 16)

                if let destination {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Current location")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(LpspUberTokens.uberGray600)
                        Text(destination)
                            .font(LpspUberFonts.uberWhereTo)
                            .foregroundStyle(.white)
                            .lineLimit(1)
                    }
                } else {
                    Text("Where to?")
                        .font(LpspUberFonts.uberWhereTo)
                        .foregroundStyle(.white)
                }

                Spacer()

                HStack(spacing: 6) {
                    Image(systemName: "clock").font(.system(size: 14, weight: .medium))
                    Text("Later").font(.system(size: 15, weight: .regular))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Capsule().fill(LpspUberTokens.uberGray900))
                .overlay(Capsule().stroke(LpspUberTokens.uberGray700, lineWidth: 1))
                .padding(.trailing, 8)
            }
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 8).fill(LpspUberTokens.uberGray950))
            .contentShape(Rectangle())
        }
        .buttonStyle(LpspUberPressableStyle())
    }
}

fileprivate struct LpspUberRideOptionCard: View {
    let name: String
    let eta: String
    let capacity: Int
    let price: String
    let isSelected: Bool
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "car.side.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.white.opacity(isEnabled ? 0.85 : 0.35))
                    .frame(width: 56, height: 56)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(name).font(LpspUberFonts.uberRowTitle).foregroundStyle(.white)
                        HStack(spacing: 2) {
                            Image(systemName: "person.fill").font(.system(size: 10))
                            Text("\(capacity)").font(LpspUberFonts.uberCaption)
                        }
                        .foregroundStyle(LpspUberTokens.uberGray600)
                    }
                    Text("\(eta) away")
                        .font(LpspUberFonts.uberCaption)
                        .foregroundStyle(LpspUberTokens.uberGray600)
                }

                Spacer()

                Text(isEnabled ? price : "—")
                    .font(LpspUberFonts.uberPrice)
                    .foregroundStyle(isEnabled ? .white : LpspUberTokens.uberGray600)
            }
            .padding(.horizontal, 16)
            .frame(height: 72)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? LpspUberTokens.uberGray900 : LpspUberTokens.uberGray950)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(isSelected ? .white : LpspUberTokens.uberGray700, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(LpspUberPressableStyle())
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.45)
        .sensoryFeedback(.selection, trigger: isSelected)
    }
}

fileprivate struct LpspUberMapView: View {
    var showsRoute: Bool
    private let pickup = CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)
    private let destination = CLLocationCoordinate2D(latitude: 48.8738, longitude: 2.2950)
    @State private var camera: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $camera) {
            Marker("Pickup", systemImage: "circle.fill", coordinate: pickup)
                .tint(.black)
            if showsRoute {
                Annotation("Destination", coordinate: destination) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black)
                        .frame(width: 28, height: 28)
                }
                MapPolyline(coordinates: [pickup, destination])
                    .stroke(.black, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            }
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
        .mapControlVisibility(.hidden)
    }
}

// MARK: - Données & état

fileprivate struct LpspUberShowroomTrip: Identifiable, Hashable {
    let id: String
    let pickup: String
    let dropoff: String
    let dateLabel: String
    let duration: String
    let price: String
    let driver: String
    let vehicle: String
    let rating: Double
    let plate: String
}

fileprivate struct LpspUberShowroomService: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
}

@MainActor
fileprivate final class LpspUberStore: ObservableObject {
    @Published var selectedRideOption = 0
    @Published var isBooking = false
    @Published var destination: String?
    @Published var showDestinationPicker = false
    @Published var showMapMenu = false
    @Published private(set) var trips: [LpspUberShowroomTrip]
    @Published var account: LpspUberShowroomAccount

    init(trips: [LpspUberShowroomTrip], account: LpspUberShowroomAccount) {
        self.trips = trips
        self.account = account
    }

    var hasDestination: Bool {
        guard let destination else { return false }
        return !destination.isEmpty
    }

    var selectedOption: LpspUberShowroomRideOption {
        LpspUberShowroomData.rideOptions[selectedRideOption]
    }

    func selectDestination(_ place: String) {
        destination = place
        selectedRideOption = 0
        showDestinationPicker = false
        showMapMenu = false
    }

    func clearDestination() {
        destination = nil
        selectedRideOption = 0
        isBooking = false
    }

    func confirmRide() {
        guard hasDestination else { return }
        isBooking = true
    }

    func completeBooking() {
        isBooking = false
        let dropoff = destination ?? "Destination"
        let newTrip = LpspUberShowroomTrip(
            id: "trip-\(UUID().uuidString.prefix(6))",
            pickup: "Current location",
            dropoff: dropoff,
            dateLabel: "Just now",
            duration: selectedOption.eta.replacingOccurrences(of: " min", with: "") + " min",
            price: selectedOption.price,
            driver: "Amadou K.",
            vehicle: "Peugeot 308 grise",
            rating: 4.92,
            plate: "AB-123-CD"
        )
        trips.insert(newTrip, at: 0)
        destination = nil
        selectedRideOption = 0
    }

    static func trips(from lpspRides: [LpspRide]) -> [LpspUberShowroomTrip] {
        lpspRides.map { ride in
            LpspUberShowroomTrip(
                id: ride.id,
                pickup: ride.pickup,
                dropoff: ride.dropoff,
                dateLabel: LpspAdapters.formatUberRideDate(ride),
                duration: ride.duration,
                price: ride.price,
                driver: ride.driver,
                vehicle: ride.vehicle,
                rating: 4.9,
                plate: "—"
            )
        }
    }

    static func account(from lpsp: LpspUberAccount) -> LpspUberShowroomAccount {
        LpspUberShowroomAccount(
            name: lpsp.name,
            email: lpsp.email,
            phone: lpsp.phone,
            passengerRating: lpsp.passengerRating,
            paymentMethod: lpsp.paymentMethod,
            savedPlaces: lpsp.savedPlaces.map { (label: $0.label, address: $0.address) }
        )
    }
}

fileprivate struct LpspUberShowroomAccount {
    let name: String
    let email: String
    let phone: String
    let passengerRating: Double
    let paymentMethod: String
    let savedPlaces: [(label: String, address: String)]
}

fileprivate struct LpspUberShowroomRideOption: Identifiable {
    let id: String
    let name: String
    let eta: String
    let capacity: Int
    let price: String
}

private enum LpspUberShowroomData {
    static let rideOptions: [LpspUberShowroomRideOption] = [
        .init(id: "uberx", name: "UberX", eta: "3 min", capacity: 4, price: "$14.82"),
        .init(id: "comfort", name: "Comfort", eta: "5 min", capacity: 4, price: "$19.14"),
        .init(id: "green", name: "Green", eta: "4 min", capacity: 4, price: "$15.60"),
    ]

    static let trips: [LpspUberShowroomTrip] = [
        .init(id: "t1", pickup: "14 Rue de Rivoli", dropoff: "Gare du Nord", dateLabel: "15 Jun · 18:42", duration: "18 min", price: "€12.40", driver: "Amadou K.", vehicle: "Peugeot 308 grise", rating: 4.92, plate: "AB-123-CD"),
        .init(id: "t2", pickup: "Bastille", dropoff: "Musée du Louvre — Pyramide", dateLabel: "12 Jun · 09:17", duration: "16 min", price: "€11.80", driver: "Youssef M.", vehicle: "Toyota Corolla noire", rating: 4.88, plate: "CD-456-EF"),
        .init(id: "t3", pickup: "Station F", dropoff: "Charles de Gaulle T2E", dateLabel: "2 Jun · 06:15", duration: "42 min", price: "€48.20", driver: "Fatima B.", vehicle: "Renault Clio blanche", rating: 4.95, plate: "FG-789-HI"),
        .init(id: "t4", pickup: "République", dropoff: "Parc de la Villette", dateLabel: "28 May · 14:05", duration: "12 min", price: "€9.70", driver: "Marc D.", vehicle: "VW Golf gris foncé", rating: 4.87, plate: "JK-012-LM"),
    ]

    static let account = LpspUberShowroomAccount(
        name: "Maya Rivera",
        email: "maya.rivera@lost.phone",
        phone: "+33 6 12 34 56 78",
        passengerRating: 4.91,
        paymentMethod: "Personal · Visa ·· 4242",
        savedPlaces: [
            (label: "Home", address: "14 Rue de Rivoli, 75001 Paris"),
            (label: "Work", address: "Station F, 55 Boulevard Vincent Auriol"),
            (label: "Coffee spot", address: "Boot Café, 19 Rue du Pont aux Choux"),
        ]
    )

    static let services: [LpspUberShowroomService] = [
        .init(id: "s1", title: "Ride", subtitle: "Get a ride", icon: "car.fill"),
        .init(id: "s2", title: "Uber Eats", subtitle: "Food delivery", icon: "fork.knife"),
        .init(id: "s3", title: "Reserve", subtitle: "Plan ahead", icon: "calendar"),
        .init(id: "s4", title: "Rent", subtitle: "Hourly rentals", icon: "key.fill"),
        .init(id: "s5", title: "Transit", subtitle: "Public transport", icon: "tram.fill"),
        .init(id: "s6", title: "Seniors", subtitle: "Assisted rides", icon: "figure.roll"),
    ]
}

// MARK: - Écrans showroom

private enum LpspUberTab: CaseIterable {
    case home, services, activity, account

    var label: String {
        switch self {
        case .home: "Home"
        case .services: "Services"
        case .activity: "Activity"
        case .account: "Account"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .services: "square.grid.2x2.fill"
        case .activity: "clock.fill"
        case .account: "person.fill"
        }
    }
}

private enum LpspUberRoute: Hashable {
    case tripDetail(String)
}

private struct LpspUberShowroomRoot: View {
    @ObservedObject var store: LpspUberStore
    var isStoryMode = false
    @State private var selectedTab: LpspUberTab = .home

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home:
                    LpspUberHomeTabScreen(store: store)
                case .services:
                    LpspUberServicesTabScreen()
                case .activity:
                    LpspUberActivityTabScreen(store: store)
                case .account:
                    LpspUberAccountTabScreen(account: store.account)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspUberSpectrTabBar(selectedTab: $selectedTab)
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspUberSpectrTabBar: View {
    @Binding var selectedTab: LpspUberTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspUberTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon).font(.system(size: 20))
                        Text(tab.label).font(LpspUberFonts.uberTab)
                    }
                    .foregroundStyle(selectedTab == tab ? .white : LpspUberTokens.uberGray600)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(LpspUberPressableStyle())
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 2)
        .background(LpspUberTokens.uberGray950)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspUberTokens.uberGray900).frame(height: 0.5)
        }
    }
}

private struct LpspUberHomeTabScreen: View {
    @ObservedObject var store: LpspUberStore

    var body: some View {
        ZStack(alignment: .top) {
            LpspUberMapView(showsRoute: store.hasDestination).ignoresSafeArea()

            VStack {
                HStack {
                    Spacer()
                    Button { store.showMapMenu = true } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(width: 44, height: 44)
                            .background(Circle().fill(.white))
                            .shadow(color: .black.opacity(0.12), radius: 8, y: 2)
                    }
                    .buttonStyle(LpspUberPressableStyle())
                    .padding(.trailing, 16)
                    .padding(.top, 8)
                }
                Spacer()
            }

            VStack {
                Spacer()
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(LpspUberTokens.uberGray600)
                        .frame(width: 36, height: 4)
                        .padding(.top, 8)

                    if store.isBooking {
                        LpspUberActiveBookingCard(store: store)
                            .padding(.horizontal, 12)
                            .padding(.top, 12)
                    } else {
                        Text(store.hasDestination ? "Choose a ride" : "Plan your ride")
                            .font(LpspUberFonts.uberSheetTitle)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.top, 14)

                        LpspUberWhereToInput(
                            destination: store.destination,
                            action: { store.showDestinationPicker = true }
                        )
                        .padding(.horizontal, 12)
                        .padding(.top, 10)

                        if store.hasDestination {
                            ForEach(Array(LpspUberShowroomData.rideOptions.enumerated()), id: \.element.id) { idx, option in
                                LpspUberRideOptionCard(
                                    name: option.name,
                                    eta: option.eta,
                                    capacity: option.capacity,
                                    price: option.price,
                                    isSelected: store.selectedRideOption == idx,
                                    isEnabled: true,
                                    action: { store.selectedRideOption = idx }
                                )
                                .padding(.horizontal, 12)
                            }
                            .padding(.vertical, 8)

                            HStack {
                                Text("VISA")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(RoundedRectangle(cornerRadius: 3).fill(Color.blue))
                                Text(store.account.paymentMethod)
                                    .font(LpspUberFonts.uberMeta)
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(LpspUberTokens.uberGray600)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)

                            Button {
                                store.confirmRide()
                                Task {
                                    try? await Task.sleep(for: .milliseconds(1800))
                                    await MainActor.run { store.completeBooking() }
                                }
                            } label: {
                                Text("Confirm \(store.selectedOption.name)")
                                    .font(LpspUberFonts.uberButton)
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                            }
                            .buttonStyle(LpspUberPressableStyle())
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        } else {
                            Text("Enter a destination to see prices and ride options.")
                                .font(LpspUberFonts.uberCaption)
                                .foregroundStyle(LpspUberTokens.uberGray600)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
                                .padding(.top, 12)
                                .padding(.bottom, 20)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LpspUberTokens.uberCanvasDark)
                        .ignoresSafeArea(edges: .bottom)
                )
            }
        }
        .sheet(isPresented: $store.showDestinationPicker) {
            LpspUberDestinationPickerSheet(store: store)
        }
        .sheet(isPresented: $store.showMapMenu) {
            LpspUberMapMenuSheet(store: store)
        }
    }
}

private struct LpspUberDestinationPickerSheet: View {
    @ObservedObject var store: LpspUberStore
    @Environment(\.dismiss) private var dismiss

    private let suggestions = [
        "Gare du Nord",
        "Musée du Louvre — Pyramide",
        "Charles de Gaulle T2E",
        "Parc de la Villette",
    ]

    var body: some View {
        NavigationStack {
            List {
                Section("Saved places") {
                    ForEach(store.account.savedPlaces, id: \.label) { place in
                        Button {
                            store.selectDestination(place.address)
                            dismiss()
                        } label: {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(place.label)
                                    .font(LpspUberFonts.uberRowTitle)
                                    .foregroundStyle(.white)
                                Text(place.address)
                                    .font(LpspUberFonts.uberCaption)
                                    .foregroundStyle(LpspUberTokens.uberGray600)
                            }
                        }
                        .listRowBackground(LpspUberTokens.uberGray950)
                    }
                }

                Section("Suggestions") {
                    ForEach(suggestions, id: \.self) { place in
                        Button {
                            store.selectDestination(place)
                            dismiss()
                        } label: {
                            Text(place)
                                .font(LpspUberFonts.uberMeta)
                                .foregroundStyle(.white)
                        }
                        .listRowBackground(LpspUberTokens.uberGray950)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Where to?")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
        .presentationDetents([.medium, .large])
        .preferredColorScheme(.dark)
    }
}

private struct LpspUberMapMenuSheet: View {
    @ObservedObject var store: LpspUberStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Button {
                    dismiss()
                    store.showDestinationPicker = true
                } label: {
                    Label("Set destination", systemImage: "mappin.and.ellipse")
                        .foregroundStyle(.white)
                }
                .listRowBackground(LpspUberTokens.uberGray950)

                if store.hasDestination {
                    Button {
                        store.clearDestination()
                        dismiss()
                    } label: {
                        Label("Clear destination", systemImage: "xmark.circle")
                            .foregroundStyle(.white)
                    }
                    .listRowBackground(LpspUberTokens.uberGray950)
                }

                Label("Safety", systemImage: "shield")
                    .foregroundStyle(.white)
                    .listRowBackground(LpspUberTokens.uberGray950)
                Label("Help", systemImage: "questionmark.circle")
                    .foregroundStyle(.white)
                    .listRowBackground(LpspUberTokens.uberGray950)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }
}

private struct LpspUberActiveBookingCard: View {
    @ObservedObject var store: LpspUberStore

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                LpspUberDriverBeacon()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Finding your driver…")
                        .font(LpspUberFonts.uberRowTitle)
                        .foregroundStyle(.white)
                    Text("\(store.selectedOption.name) · \(store.selectedOption.price)")
                        .font(LpspUberFonts.uberCaption)
                        .foregroundStyle(LpspUberTokens.uberGray600)
                }
                Spacer()
                Button { store.isBooking = false } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(LpspUberTokens.uberGray600)
                }
            }

            HStack(spacing: 8) {
                Image(systemName: "mappin.circle.fill")
                Text(store.destination ?? "Destination")
                    .font(LpspUberFonts.uberMeta)
                    .foregroundStyle(.white)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 12).fill(LpspUberTokens.uberGray950))
    }
}

fileprivate struct LpspUberDriverBeacon: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(LpspUberTokens.uberGreen.opacity(0.3 - Double(i) * 0.1))
                    .frame(width: 40, height: 40)
                    .scaleEffect(animate ? 2.0 : 1)
                    .opacity(animate ? 0 : 1)
                    .animation(
                        .easeInOut(duration: 1.8).repeatForever(autoreverses: false).delay(Double(i) * 0.5),
                        value: animate
                    )
            }
            Image(systemName: "car.fill")
                .font(.system(size: 12))
                .foregroundStyle(.black)
                .frame(width: 22, height: 22)
                .background(Circle().fill(.white))
        }
        .frame(width: 40, height: 40)
        .onAppear { animate = true }
    }
}

private struct LpspUberServicesTabScreen: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(LpspUberShowroomData.services) { service in
                        VStack(alignment: .leading, spacing: 8) {
                            Image(systemName: service.icon)
                                .font(.system(size: 24))
                                .foregroundStyle(.white)
                            Text(service.title)
                                .font(LpspUberFonts.uberRowTitle)
                                .foregroundStyle(.white)
                            Text(service.subtitle)
                                .font(LpspUberFonts.uberCaption)
                                .foregroundStyle(LpspUberTokens.uberGray600)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(14)
                        .background(RoundedRectangle(cornerRadius: 12).fill(LpspUberTokens.uberGray950))
                    }
                }
                .padding(16)
            }
            .navigationTitle("Services")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
    }
}

private struct LpspUberActivityTabScreen: View {
    @ObservedObject var store: LpspUberStore
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(store.trips) { trip in
                    Button {
                        path.append(LpspUberRoute.tripDetail(trip.id))
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(trip.dropoff)
                                    .font(LpspUberFonts.uberRowTitle)
                                    .foregroundStyle(.white)
                                    .lineLimit(2)
                                Spacer()
                                Text(trip.price)
                                    .font(LpspUberFonts.uberPrice)
                                    .foregroundStyle(.white)
                            }
                            Text(trip.pickup)
                                .font(LpspUberFonts.uberCaption)
                                .foregroundStyle(LpspUberTokens.uberGray600)
                                .lineLimit(1)
                            Text("\(trip.dateLabel) · \(trip.duration) · \(trip.driver)")
                                .font(LpspUberFonts.uberCaption)
                                .foregroundStyle(LpspUberTokens.uberGray600)
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowBackground(LpspUberTokens.uberGray950)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Activity")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: LpspUberRoute.self) { route in
                if case .tripDetail(let id) = route,
                   let trip = store.trips.first(where: { $0.id == id }) {
                    LpspUberTripDetailScreen(trip: trip)
                }
            }
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
    }
}

private struct LpspUberTripDetailScreen: View {
    let trip: LpspUberShowroomTrip
    @State private var showMessage = false
    @State private var showCall = false
    @State private var showShare = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                LpspUberRouteSummaryCard(pickup: trip.pickup, dropoff: trip.dropoff)
                    .frame(maxWidth: .infinity)

                HStack(spacing: 12) {
                    Circle()
                        .fill(LpspUberTokens.uberGray700)
                        .frame(width: 48, height: 48)
                        .overlay(Text(String(trip.driver.prefix(1))).font(.headline).foregroundStyle(.white))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(trip.driver).font(LpspUberFonts.uberRowTitle).foregroundStyle(.white)
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill").font(.system(size: 11))
                            Text(String(format: "%.2f", trip.rating))
                        }
                        .foregroundStyle(LpspUberTokens.uberGray600)
                        Text("\(trip.vehicle) · \(trip.plate)")
                            .font(LpspUberFonts.uberCaption)
                            .foregroundStyle(LpspUberTokens.uberGray600)
                    }
                    Spacer()
                    Text(trip.price).font(LpspUberFonts.uberPrice).foregroundStyle(.white)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(LpspUberTokens.uberGray950))
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 24) {
                    actionButton("message", "Message") { showMessage = true }
                    actionButton("phone", "Call") { showCall = true }
                    actionButton("square.and.arrow.up", "Share") { showShare = true }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 4)
            }
            .padding(16)
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
        .navigationTitle(trip.dateLabel)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .sheet(isPresented: $showMessage) {
            LpspUberDriverMessageSheet(driver: trip.driver)
        }
        .sheet(isPresented: $showCall) {
            LpspUberDriverCallSheet(driver: trip.driver)
        }
        .sheet(isPresented: $showShare) {
            LpspUberTripShareSheet(trip: trip)
        }
    }

    private func actionButton(_ icon: String, _ label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack {
                    Circle().fill(LpspUberTokens.uberGray950).frame(width: 44, height: 44)
                    Image(systemName: icon).font(.system(size: 18)).foregroundStyle(.white)
                }
                Text(label).font(LpspUberFonts.uberCaption).foregroundStyle(LpspUberTokens.uberGray600)
            }
        }
        .buttonStyle(LpspUberPressableStyle())
    }
}

private struct LpspUberRouteSummaryCard: View {
    let pickup: String
    let dropoff: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(spacing: 0) {
                Circle()
                    .fill(.white)
                    .frame(width: 10, height: 10)
                Rectangle()
                    .fill(LpspUberTokens.uberGray700)
                    .frame(width: 2, height: 36)
                RoundedRectangle(cornerRadius: 2)
                    .fill(.white)
                    .frame(width: 10, height: 10)
            }
            .padding(.top, 4)

            VStack(alignment: .leading, spacing: 20) {
                routeRow(title: pickup, subtitle: "Pickup")
                routeRow(title: dropoff, subtitle: "Dropoff")
            }
            Spacer(minLength: 0)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 12).fill(LpspUberTokens.uberGray950))
    }

    private func routeRow(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(subtitle.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(LpspUberTokens.uberGray600)
            Text(title)
                .font(LpspUberFonts.uberMeta)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct LpspUberDriverMessageSheet: View {
    let driver: String
    @Environment(\.dismiss) private var dismiss
    @State private var draft = ""
    @FocusState private var inputFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Hi, I'm on my way.")
                            .font(LpspUberFonts.uberMeta)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 16).fill(LpspUberTokens.uberGray900))
                        Text("Thanks! See you at the pickup point.")
                            .font(LpspUberFonts.uberMeta)
                            .foregroundStyle(.black)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(16)
                }
                HStack(spacing: 10) {
                    TextField("Message \(driver)", text: $draft)
                        .focused($inputFocused)
                        .font(LpspUberFonts.uberMeta)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(RoundedRectangle(cornerRadius: 20).fill(LpspUberTokens.uberGray950))
                    Button {
                        draft = ""
                        inputFocused = false
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                            .frame(width: 40, height: 40)
                            .background(Circle().fill(.white))
                    }
                    .buttonStyle(LpspUberPressableStyle())
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.45 : 1)
                }
                .padding(12)
                .background(LpspUberTokens.uberGray950)
            }
            .navigationTitle(driver)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspUberDriverCallSheet: View {
    let driver: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Circle()
                .fill(LpspUberTokens.uberGray700)
                .frame(width: 96, height: 96)
                .overlay(Text(String(driver.prefix(1))).font(.largeTitle.bold()).foregroundStyle(.white))
            Text(driver).font(.system(size: 24, weight: .semibold)).foregroundStyle(.white)
            Text("Calling driver…")
                .font(LpspUberFonts.uberMeta)
                .foregroundStyle(LpspUberTokens.uberGray600)
            Spacer()
            Button { dismiss() } label: {
                Image(systemName: "phone.down.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
                    .frame(width: 64, height: 64)
                    .background(Circle().fill(Color.red))
            }
            .buttonStyle(LpspUberPressableStyle())
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspUberTripShareSheet: View {
    let trip: LpspUberShowroomTrip
    @Environment(\.dismiss) private var dismiss

    private var summary: String {
        "Uber ride · \(trip.dateLabel)\n\(trip.pickup) → \(trip.dropoff)\n\(trip.price) · \(trip.driver)"
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(summary)
                    .font(LpspUberFonts.uberMeta)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 12).fill(LpspUberTokens.uberGray950))
                Button {
                    UIPasteboard.general.string = summary
                    dismiss()
                } label: {
                    Text("Copy trip details")
                        .font(LpspUberFonts.uberButton)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                }
                .buttonStyle(LpspUberPressableStyle())
                Spacer()
            }
            .padding(16)
            .navigationTitle("Share trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }
}

private struct LpspUberAccountTabScreen: View {
    let account: LpspUberShowroomAccount

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspUberTokens.uberGray700)
                            .frame(width: 56, height: 56)
                            .overlay(Text(String(account.name.prefix(1))).font(.title2.bold()).foregroundStyle(.white))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(account.name).font(LpspUberFonts.uberRowTitle).foregroundStyle(.white)
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill").font(.system(size: 11))
                                Text(String(format: "%.2f", account.passengerRating))
                            }
                            .font(LpspUberFonts.uberCaption)
                            .foregroundStyle(LpspUberTokens.uberGray600)
                        }
                    }
                    .listRowBackground(LpspUberTokens.uberGray950)
                }

                Section("Wallet") {
                    Label(account.paymentMethod, systemImage: "creditcard")
                        .foregroundStyle(.white)
                        .listRowBackground(LpspUberTokens.uberGray950)
                }

                Section("Saved places") {
                    ForEach(account.savedPlaces, id: \.label) { place in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(place.label).font(LpspUberFonts.uberRowTitle).foregroundStyle(.white)
                            Text(place.address).font(LpspUberFonts.uberCaption).foregroundStyle(LpspUberTokens.uberGray600)
                        }
                        .listRowBackground(LpspUberTokens.uberGray950)
                    }
                }

                Section("Settings") {
                    Label("Help", systemImage: "questionmark.circle")
                    Label("Safety", systemImage: "shield")
                    Label("Privacy", systemImage: "hand.raised")
                }
                .foregroundStyle(.white)
                .listRowBackground(LpspUberTokens.uberGray950)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Account")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
    }
}

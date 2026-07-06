import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/uber
// Meliwat/awesome-ios-design-md/travel/uber/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeUberView: View {
    var rides: [LpspRide]?
    var account: LpspUberAccount?

    var body: some View {
        let storyRides = rides?.isEmpty == false ? rides : nil
        LpspUberShowroomRoot(
            rides: storyRides ?? LpspUberShowroomData.rides,
            account: account ?? LpspUberShowroomData.account,
            isStoryMode: storyRides != nil
        )
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspUberFonts {
    static let uberHero         = Font.system(size: 36, weight: .regular)
    static let uberSheetTitle   = Font.system(size: 24, weight: .regular)
    static let uberNavTitle     = Font.system(size: 18, weight: .regular)
    static let uberWhereTo      = Font.system(size: 18, weight: .regular)
    static let uberRowTitle     = Font.system(size: 16, weight: .regular)
    static let uberBody         = Font.system(size: 15, weight: .regular)
    static let uberMeta         = Font.system(size: 14, weight: .regular)
    static let uberLabelUpper   = Font.system(size: 11, weight: .regular)
    static let uberButton       = Font.system(size: 17, weight: .regular)
    static let uberButtonSmall  = Font.system(size: 15, weight: .regular)
    static let uberTab          = Font.system(size: 11, weight: .regular)
    static let uberCaption      = Font.system(size: 12, weight: .regular)
    static let uberPrice        = Font.system(size: 16, weight: .regular)
    static let uberETA          = Font.system(size: 14, weight: .regular)
    static let uberETABadge     = Font.system(size: 18, weight: .regular)
    static let uberAddress      = Font.system(size: 13, weight: .regular)
    static func uber(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
    static func uberMono(_ size: CGFloat, weight: Font.Weight = .medium) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }
}

private enum LpspUberTokens {
    // MARK: - Canvas & Brand
    static let uberBlack          = Color.black                                 // #000000
    static let uberWhite          = Color.white                                 // #FFFFFF
    static let uberCanvasDark     = Color(red: 0.047, green: 0.047, blue: 0.047) // #0C0C0C

    // MARK: - Gray Ramp
    static let uberGray50   = Color(red: 0.965, green: 0.965, blue: 0.965) // #F6F6F6
    static let uberGray100  = Color(red: 0.933, green: 0.933, blue: 0.933) // #EEEEEE
    static let uberGray200  = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
    static let uberGray400  = Color(red: 0.686, green: 0.686, blue: 0.686) // #AFAFAF
    static let uberGray600  = Color(red: 0.459, green: 0.459, blue: 0.459) // #757575
    static let uberGray700  = Color(red: 0.329, green: 0.329, blue: 0.329) // #545454
    static let uberGray900  = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F
    static let uberGray950  = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A

    // MARK: - Functional
    static let uberGreen    = Color(red: 0.020, green: 0.639, blue: 0.341) // #05A357
    static let uberRed      = Color(red: 0.843, green: 0.129, blue: 0.075) // #D72113
    static let uberBlue     = Color(red: 0.039, green: 0.278, blue: 1.000) // #0A47FF
    static let uberAmber    = Color(red: 1.000, green: 0.796, blue: 0.000) // #FFCB00

    // MARK: - Semantic tokens (auto light/dark)
    static let uberSurface      = Color("UberSurface")      // #FFFFFF / #1A1A1A
    static let uberSurfaceAlt   = Color("UberSurfaceAlt")   // #F6F6F6 / #2F2F2F
    static let uberTextPrimary  = Color("UberTextPrimary")  // #000000 / #FFFFFF
    static let uberTextSecondary = Color("UberTextSecondary") // #757575 / #AFAFAF
    static let uberDivider      = Color("UberDivider")      // #E5E5E5 / #3A3A3A
}



// System fallback when Uber Move isn't bundled:



fileprivate struct LpspUberUberPressableStyle: ButtonStyle {
    var pressedFill: Color? = nil
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.85), value: configuration.isPressed)
    }
}

fileprivate struct LpspUberWhereToInput: View {
    var body: some View {
        HStack(spacing: 14) {
            VStack(spacing: 4) {
                Rectangle().fill(LpspUberTokens.uberBlack).frame(width: 8, height: 8)
                ForEach(0..<3) { _ in
                    Rectangle().fill(LpspUberTokens.uberGray400).frame(width: 1, height: 3)
                }
                Rectangle().fill(LpspUberTokens.uberBlack).frame(width: 8, height: 8)
            }
            .padding(.leading, 16)

            Text("Where to?")
                .font(LpspUberFonts.uberWhereTo)
                .foregroundStyle(LpspUberTokens.uberTextPrimary)

            Spacer()

            HStack(spacing: 6) {
                Image(systemName: "clock")
                    .font(.system(size: 14, weight: .medium))
                Text("Later")
                    .font(LpspUberFonts.uberButtonSmall)
            }
            .foregroundStyle(LpspUberTokens.uberTextPrimary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Capsule().fill(LpspUberTokens.uberWhite))
            .overlay(Capsule().stroke(LpspUberTokens.uberGray200, lineWidth: 1))
            .padding(.trailing, 8)
        }
        .frame(height: 56)
        .background(RoundedRectangle(cornerRadius: 8).fill(LpspUberTokens.uberGray50))
    }
}

fileprivate struct LpspUberRideOptionCard: View {
    let name: String
    let eta: String
    let capacity: Int
    let price: String
    let isSelected: Bool
    let carImage: Image
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                carImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 56, height: 56)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(name).font(LpspUberFonts.uberRowTitle).foregroundStyle(LpspUberTokens.uberTextPrimary)
                        HStack(spacing: 2) {
                            Image(systemName: "person.fill").font(.system(size: 10))
                            Text("\(capacity)").font(LpspUberFonts.uberCaption)
                        }
                        .foregroundStyle(LpspUberTokens.uberTextSecondary)
                    }
                    Text("\(eta) away")
                        .font(LpspUberFonts.uberAddress)
                        .foregroundStyle(LpspUberTokens.uberTextSecondary)
                }

                Spacer()

                Text(price)
                    .font(LpspUberFonts.uberPrice)
                    .foregroundStyle(LpspUberTokens.uberTextPrimary)
            }
            .padding(.horizontal, 16)
            .frame(height: 72)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? LpspUberTokens.uberGray50 : LpspUberTokens.uberWhite)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(
                        isSelected ? LpspUberTokens.uberBlack : LpspUberTokens.uberGray200,
                        lineWidth: isSelected ? 2 : 1
                    )
            )
        }
        .buttonStyle(LpspUberUberPressableStyle())
        .sensoryFeedback(.selection, trigger: isSelected)
    }
}

fileprivate struct LpspUberActiveTripCard: View {
    let driverName: String
    let rating: Double
    let carModel: String
    let plate: String
    let driverPhoto: Image

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                driverPhoto
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(driverName)
                        .font(LpspUberFonts.uberRowTitle)
                        .foregroundStyle(LpspUberTokens.uberTextPrimary)
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill").font(.system(size: 11))
                        Text(String(format: "%.2f", rating)).font(LpspUberFonts.uberETA)
                    }
                    .foregroundStyle(LpspUberTokens.uberTextSecondary)
                }

                Spacer()

                Text(plate)
                    .font(LpspUberFonts.uberETA)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(LpspUberTokens.uberGray50))
            }

            Text(carModel)
                .font(LpspUberFonts.uberMeta)
                .foregroundStyle(LpspUberTokens.uberGray700)

            Divider().background(LpspUberTokens.uberDivider)

            HStack(spacing: 24) {
                ForEach([("message", "Message"), ("phone", "Call"), ("square.and.arrow.up", "Share")], id: \.1) { icon, label in
                    VStack(spacing: 6) {
                        ZStack {
                            Circle().fill(LpspUberTokens.uberGray50).frame(width: 44, height: 44)
                            Image(systemName: icon).font(.system(size: 20, weight: .medium))
                                .foregroundStyle(LpspUberTokens.uberTextPrimary)
                        }
                        Text(label).font(LpspUberFonts.uberCaption).foregroundStyle(LpspUberTokens.uberTextSecondary)
                    }
                }
                Spacer()
            }
        }
        .padding(16)
    }
}

fileprivate struct LpspUberUberBottomSheet<Content: View>: View {
    @State private var selectedDetent: PresentationDetent = .medium
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(spacing: 0) { /* map content */ }
            .sheet(isPresented: .constant(true)) {
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(LpspUberTokens.uberGray200)
                        .frame(width: 36, height: 4)
                        .padding(.top, 6)
                        .padding(.bottom, 14)
                    content()
                }
                .presentationDetents(
                    [.height(140), .medium, .large],
                    selection: $selectedDetent
                )
                .presentationDragIndicator(.hidden)
                .presentationBackground(LpspUberTokens.uberSurface)
                .presentationCornerRadius(16)
                .interactiveDismissDisabled()
            }
    }
}

import MapKit

fileprivate struct LpspUberUberMapView: View {
    private let pickup = CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)
    private let destination = CLLocationCoordinate2D(latitude: 48.8738, longitude: 2.2950)
    private var route: [CLLocationCoordinate2D] { [pickup, destination] }

    @State private var camera: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $camera) {
            Marker("Pickup", systemImage: "circle.fill", coordinate: pickup)
                .tint(LpspUberTokens.uberBlack)
            Annotation("Destination", coordinate: destination) {
                LpspUberDestinationPin()
            }
            MapPolyline(coordinates: route)
                .stroke(LpspUberTokens.uberBlack, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
        .mapControlVisibility(.hidden)
    }
}

fileprivate struct LpspUberDestinationPin: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.25))
                .frame(width: 28, height: 8)
                .offset(y: 4)
                .blur(radius: 3)
            RoundedRectangle(cornerRadius: 4)
                .fill(LpspUberTokens.uberBlack)
                .frame(width: 32, height: 32)
        }
    }
}

fileprivate struct LpspUberFloatingMapButton: View {
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(LpspUberTokens.uberTextPrimary)
                .frame(width: 44, height: 44)
                .background(Circle().fill(LpspUberTokens.uberSurface))
                .shadow(color: .black.opacity(0.12), radius: 8, y: 2)
        }
    }
}

fileprivate struct LpspUberDriverBeacon: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                Circle()
                    .fill(LpspUberTokens.uberGreen.opacity(0.3 - Double(i) * 0.1))
                    .frame(width: 48, height: 48)
                    .scaleEffect(animate ? 2.4 : 1)
                    .opacity(animate ? 0 : 1)
                    .animation(
                        .easeInOut(duration: 1.8)
                            .repeatForever(autoreverses: false)
                            .delay(Double(i) * 0.6),
                        value: animate
                    )
            }
            Image(systemName: "car.fill")
                .font(.system(size: 14))
                .foregroundStyle(.black)
                .frame(width: 24, height: 24)
                .background(Circle().fill(LpspUberTokens.uberWhite))
        }
        .onAppear { animate = true }
    }
}



// MARK: - Données showroom

private enum LpspUberShowroomData {
    static let rides: [LpspRide] = [
        LpspRide(
            id: "demo-1",
            date: nil,
            dateRaw: "",
            pickup: "Home",
            dropoff: "Gare du Nord",
            duration: "18 min",
            price: "€12.40",
            driver: "Amadou K.",
            vehicle: "Peugeot 308",
            status: "completed"
        )
    ]

    static let account = LpspUberAccount(
        name: "Lost Phone",
        email: "demo@lost.phone",
        phone: "",
        passengerRating: 4.9,
        paymentMethod: "Visa •••• 4242",
        savedPlaces: []
    )
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

private struct LpspUberShowroomRoot: View {
    let rides: [LpspRide]
    let account: LpspUberAccount
    var isStoryMode = false
    @State private var selectedTab: LpspUberTab = .home

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home:
                    LpspUberRideHomeTabScreen(isStoryMode: isStoryMode)
                case .services:
                    LpspUberRideServicesTabScreen(isStoryMode: isStoryMode)
                case .activity:
                    LpspUberRideActivityTabScreen(rides: rides, isStoryMode: isStoryMode)
                case .account:
                    LpspUberRideAccountTabScreen(account: account, isStoryMode: isStoryMode)
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
                        Image(systemName: tab.icon)
                            .font(.system(size: 20))
                        Text(tab.label)
                            .font(LpspUberFonts.uberTab)
                    }
                    .foregroundStyle(selectedTab == tab ? .white : LpspUberTokens.uberGray600)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(LpspUberUberPressableStyle())
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 2)
        .background(LpspUberTokens.uberGray950)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspUberTokens.uberGray900)
                .frame(height: 0.5)
        }
    }
}


private struct LpspUberGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspUberTokens.uberRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspUberTokens.uberRed))
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


private struct LpspUberRideHomeTabScreen: View {
    var isStoryMode = false
    @State private var selectedRide = 0
    var body: some View {
        ZStack(alignment: .top) {
            LpspUberUberMapView().ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 36, height: 4)
                        .padding(.top, 8)
                    LpspUberWhereToInput()
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                    ForEach(Array(LpspUberDemoRides.items.enumerated()), id: \.offset) { idx, option in
                        LpspUberRideOptionCard(
                            name: option.name,
                            eta: option.eta,
                            capacity: option.capacity,
                            price: option.price,
                            isSelected: selectedRide == idx,
                            carImage: Image(systemName: "car.fill"),
                            action: { if !isStoryMode { selectedRide = idx } }
                        )
                        .padding(.horizontal, 12)
                    }
                    .padding(.vertical, 8)
                }
                .background(RoundedRectangle(cornerRadius: 16).fill(LpspUberTokens.uberCanvasDark).ignoresSafeArea(edges: .bottom))
            }
        }
    }
}

private struct LpspUberDemoRideOption {
    let name: String
    let eta: String
    let capacity: Int
    let price: String
}

private enum LpspUberDemoRides {
    static let items: [LpspUberDemoRideOption] = [
        .init(name: "UberX", eta: "3 min", capacity: 4, price: "€12.40"),
        .init(name: "Comfort", eta: "5 min", capacity: 4, price: "€16.80"),
        .init(name: "Green", eta: "4 min", capacity: 4, price: "€13.20"),
    ]
}

private struct LpspUberRideServicesTabScreen: View {
    var isStoryMode = false
    var body: some View {
        NavigationStack {
            Group {
                if isStoryMode {
                    ContentUnavailableView(
                        "Services",
                        systemImage: "square.grid.2x2",
                        description: Text("Ride and delivery services appear here.")
                    )
                } else {
                    List(["UberX", "Uber Black", "Uber Green", "Uber Eats"], id: \.self) { Label($0, systemImage: "square.grid.2x2") }
                }
            }
            .navigationTitle("Services")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
    }
}

private struct LpspUberRideActivityTabScreen: View {
    let rides: [LpspRide]
    var isStoryMode = false

    var body: some View {
        NavigationStack {
            List {
                if rides.isEmpty {
                    ContentUnavailableView(
                        "No trips yet",
                        systemImage: "clock",
                        description: Text("Your ride history will appear here.")
                    )
                    .listRowBackground(Color.clear)
                } else {
                    ForEach(rides) { ride in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(ride.dropoff)
                                    .font(LpspUberFonts.uberRowTitle)
                                    .foregroundStyle(.white)
                                    .lineLimit(2)
                                Spacer()
                                Text(ride.price)
                                    .font(LpspUberFonts.uberPrice)
                                    .foregroundStyle(.white)
                            }
                            Text(ride.pickup)
                                .font(LpspUberFonts.uberAddress)
                                .foregroundStyle(LpspUberTokens.uberGray600)
                                .lineLimit(1)
                            HStack(spacing: 8) {
                                Text(LpspAdapters.formatUberRideDate(ride))
                                if !ride.duration.isEmpty {
                                    Text("·")
                                    Text(ride.duration)
                                }
                                if !ride.driver.isEmpty {
                                    Text("·")
                                    Text(ride.driver)
                                }
                            }
                            .font(LpspUberFonts.uberCaption)
                            .foregroundStyle(LpspUberTokens.uberGray600)
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(LpspUberTokens.uberGray950)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Activity")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
    }
}

private struct LpspUberRideAccountTabScreen: View {
    let account: LpspUberAccount
    var isStoryMode = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Circle()
                            .fill(LpspUberTokens.uberGray700)
                            .frame(width: 56, height: 56)
                            .overlay(
                                Text(String(account.name.prefix(1)).uppercased())
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                            )
                        VStack(alignment: .leading, spacing: 4) {
                            Text(account.name)
                                .font(LpspUberFonts.uberRowTitle)
                                .foregroundStyle(.white)
                            if account.passengerRating > 0 {
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill").font(.system(size: 11))
                                    Text(String(format: "%.2f", account.passengerRating))
                                }
                                .font(LpspUberFonts.uberCaption)
                                .foregroundStyle(LpspUberTokens.uberGray600)
                            }
                        }
                    }
                    .listRowBackground(LpspUberTokens.uberGray950)
                }

                if !account.paymentMethod.isEmpty {
                    Section("Wallet") {
                        Label(account.paymentMethod, systemImage: "creditcard")
                            .foregroundStyle(.white)
                            .listRowBackground(LpspUberTokens.uberGray950)
                    }
                }

                if !account.savedPlaces.isEmpty {
                    Section("Saved places") {
                        ForEach(account.savedPlaces) { place in
                            VStack(alignment: .leading, spacing: 2) {
                                Text(place.label)
                                    .font(LpspUberFonts.uberRowTitle)
                                    .foregroundStyle(.white)
                                Text(place.address)
                                    .font(LpspUberFonts.uberAddress)
                                    .foregroundStyle(LpspUberTokens.uberGray600)
                                    .lineLimit(2)
                            }
                            .listRowBackground(LpspUberTokens.uberGray950)
                        }
                    }
                }

                if isStoryMode, !account.email.isEmpty {
                    Section("Contact") {
                        Label(account.email, systemImage: "envelope")
                        if !account.phone.isEmpty {
                            Label(account.phone, systemImage: "phone")
                        }
                    }
                    .foregroundStyle(.white)
                    .listRowBackground(LpspUberTokens.uberGray950)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Account")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspUberTokens.uberCanvasDark.ignoresSafeArea())
    }
}

private struct LpspUberRideTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if tabIndex == 0 || low.contains("home") { LpspUberRideHomeTabScreen() }
        else if low.contains("service") { LpspUberRideServicesTabScreen() }
        else if low.contains("activ") {
            LpspUberRideActivityTabScreen(rides: LpspUberShowroomData.rides, isStoryMode: false)
        }
        else {
            LpspUberRideAccountTabScreen(account: LpspUberShowroomData.account, isStoryMode: false)
        }
    }
}


private struct LpspUberSpectrHomeTabScreen: View {
    var body: some View {
        ZStack(alignment: .bottom) {
        Color(red:0.89,green:0.91,blue:0.85).ignoresSafeArea()
        VStack(spacing: 0) {
            Text("Choose a ride").font(.system(size: 18.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Where to?").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Later").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                            Text("UberX").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                            Text("· 4").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("3 min away · 8:42 PM").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("$14.82").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                            Text("Comfort").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                            Text("· 4").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("5 min away · 8:44 PM").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("$19.14").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("VISA").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Personal · Visa ·· 4242").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("›").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Confirm UberX").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        } .background(Color(red: 0.047, green: 0.047, blue: 0.047)).clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .background(Color(red: 0.047, green: 0.047, blue: 0.047).ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}



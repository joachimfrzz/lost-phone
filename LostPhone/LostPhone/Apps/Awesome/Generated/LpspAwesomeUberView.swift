import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/travel/uber/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/uber
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeUberView: View {
    var body: some View {
        LpspUberShowroomRoot()
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



// MARK: - Écrans showroom

private struct LpspUberShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspUberGenericTabScreen(title: "Home", tabIndex: 0)
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspUberGenericTabScreen(title: "Services", tabIndex: 1)
                .tabItem { Label("Services", systemImage: "square.grid.2x2.fill") }
                .tag(1)
            LpspUberGenericTabScreen(title: "Activity", tabIndex: 2)
                .tabItem { Label("Activity", systemImage: "clock.fill") }
                .tag(2)
            LpspUberGenericTabScreen(title: "Account", tabIndex: 3)
                .tabItem { Label("Account", systemImage: "person.fill") }
                .tag(3)
        }
        .tint(LpspUberTokens.uberRed)
        
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


private struct LpspUberMessagingTabScreen: View {
    let title: String
    var body: some View { LpspUberGenericTabScreen(title: title, tabIndex: 0) }
}



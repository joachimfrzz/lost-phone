import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/flighty
// Meliwat/awesome-ios-design-md/travel/flighty/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeFlightyView: View {
    var body: some View {
        LpspFlightyShowroomRoot(store: LpspFlightyStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspFlightyTokens {
    static let fltCanvas   = Color(red: 0.043, green: 0.043, blue: 0.059)  // #0B0B0F
    static let fltSurface1 = Color(red: 0.102, green: 0.102, blue: 0.122)  // #1A1A1F
    static let fltSurface2 = Color(red: 0.133, green: 0.133, blue: 0.157)  // #222228
    static let fltSurface3 = Color(red: 0.173, green: 0.173, blue: 0.204)  // #2C2C34
    static let fltDivider  = Color(red: 0.180, green: 0.180, blue: 0.212)  // #2E2E36
    static let fltTextPrimary   = Color.white                              // #FFFFFF
    static let fltTextSecondary = Color(red: 0.557, green: 0.557, blue: 0.588) // #8E8E96
    static let fltTextTertiary  = Color(red: 0.353, green: 0.353, blue: 0.384) // #5A5A62
    static let fltBlue        = Color(red: 0.039, green: 0.518, blue: 1.000) // #0A84FF
    static let fltBluePressed = Color(red: 0.000, green: 0.400, blue: 0.800) // #0066CC
    static let fltOnTime    = Color(red: 0.188, green: 0.820, blue: 0.345)  // #30D158
    static let fltDelay     = Color(red: 1.000, green: 0.839, blue: 0.039)  // #FFD60A
    static let fltCancelled = Color(red: 1.000, green: 0.271, blue: 0.227)  // #FF453A
    static let fltMapLand      = Color(red: 0.086, green: 0.086, blue: 0.106) // #16161B
    static let fltMapGraticule = Color(red: 0.122, green: 0.122, blue: 0.149) // #1F1F26
    static let fltBlueGlow = LpspFlightyTokens.fltBlue.opacity(0.45)
}





private enum LpspFlightyFonts {
    static let fltTimeHero  = Font.system(size: 32, weight: .bold)
    static let fltTitleLarge = Font.system(size: 28, weight: .bold)
    static let fltRouteCode = Font.system(size: 24, weight: .bold)
    static let fltSection   = Font.system(size: 22, weight: .bold)
    static let fltCardTitle = Font.system(size: 17, weight: .semibold)
    static let fltBody      = Font.system(size: 15, weight: .regular)
    static let fltButton    = Font.system(size: 16, weight: .semibold)
    static let fltStatus    = Font.system(size: 13, weight: .bold)
    static let fltGate      = Font.system(size: 15, weight: .semibold)
    static let fltMeta      = Font.system(size: 13, weight: .regular)
    static let fltOnTimePct = Font.system(size: 20, weight: .bold)
    static let fltTab       = Font.system(size: 11, weight: .semibold)
    static let fltTimestamp = Font.system(size: 11, weight: .semibold)
}

fileprivate struct LpspFlightyStatusChip: View {
    enum LpspFlightyStatus { case onTime, delayed(Int), cancelled }
    let status: LpspFlightyStatus

    private var color: Color {
        switch status {
        case .onTime: LpspFlightyTokens.fltOnTime
        case .delayed: LpspFlightyTokens.fltDelay
        case .cancelled: LpspFlightyTokens.fltCancelled
        }
    }
    private var label: String {
        switch status {
        case .onTime: "ON TIME"
        case .delayed(let m): "DELAYED \(m)m"
        case .cancelled: "CANCELLED"
        }
    }

    var body: some View {
        Text(label)
            .font(LpspFlightyFonts.fltStatus)
            .foregroundStyle(color)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Capsule().fill(color.opacity(0.15)))
            .accessibilityLabel(label.replacingOccurrences(of: "m", with: " minutes"))
    }
}

import MapKit

fileprivate struct LpspFlightyFlightArc: Shape {
    let origin: CGPoint        // normalized 0...1 in the view
    let destination: CGPoint
    let progress: CGFloat      // 0...1 flown fraction

    func path(in rect: CGRect) -> Path {
        let o = CGPoint(x: origin.x * rect.width, y: origin.y * rect.height)
        let d = CGPoint(x: destination.x * rect.width, y: destination.y * rect.height)
        let mid = CGPoint(x: (o.x + d.x) / 2, y: min(o.y, d.y) - rect.height * 0.18) // arched control
        var p = Path()
        p.move(to: o)
        p.addQuadCurve(to: d, control: mid)
        return p.trimmedPath(from: 0, to: progress)
    }
}

fileprivate struct LpspFlightyLiveFlightMap: View {
    let origin: CGPoint
    let destination: CGPoint
    @State private var drawn: CGFloat = 0
    let livePosition: CGFloat   // 0...1

    var body: some View {
        ZStack {
            LpspFlightyTokens.fltCanvas // map host; swap for a styled MKMapView / dark tile layer

            // Remaining (dashed, dim)
            LpspFlightyFlightArc(origin: origin, destination: destination, progress: 1)
                .stroke(LpspFlightyTokens.fltBlue.opacity(0.35),
                        style: StrokeStyle(lineWidth: 2, dash: [4, 5]))

            // Flown (solid, glowing)
            LpspFlightyFlightArc(origin: origin, destination: destination, progress: drawn)
                .stroke(LpspFlightyTokens.fltBlue, style: StrokeStyle(lineWidth: 2.5, lineCap: .round))
                .shadow(color: LpspFlightyTokens.fltBlueGlow, radius: 18)

            // Plane marker with glow halo
            GeometryReader { geo in
                let pt = pointOnArc(in: geo.size, at: livePosition)
                Image(systemName: "airplane")
                    .font(.system(size: 18, weight: .black))
                    .foregroundStyle(.white)
                    .shadow(color: LpspFlightyTokens.fltBlueGlow, radius: 10)
                    .position(pt)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.9)) { drawn = livePosition }
        }
    }

    private func pointOnArc(in size: CGSize, at t: CGFloat) -> CGPoint {
        let o = CGPoint(x: origin.x * size.width, y: origin.y * size.height)
        let d = CGPoint(x: destination.x * size.width, y: destination.y * size.height)
        let c = CGPoint(x: (o.x + d.x) / 2, y: min(o.y, d.y) - size.height * 0.18)
        let mt = 1 - t
        return CGPoint(
            x: mt * mt * o.x + 2 * mt * t * c.x + t * t * d.x,
            y: mt * mt * o.y + 2 * mt * t * c.y + t * t * d.y
        )
    }
}

fileprivate struct LpspFlightyFlightCard: View {
    let airline: String
    let flightNo: String
    let originCode: String
    let destCode: String
    let depTime: String
    let arrTime: String
    let depGate: String
    let arrGate: String
    let meta: String
    let status: LpspFlightyStatusChip.LpspFlightyStatus

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("\(airline) · \(flightNo)").font(LpspFlightyFonts.fltCardTitle).foregroundStyle(.white)
                Spacer()
                LpspFlightyStatusChip(status: status)
            }
            HStack(alignment: .center, spacing: 16) {
                Text(originCode).font(LpspFlightyFonts.fltRouteCode).foregroundStyle(.white)
                Image(systemName: "airplane")
                    .font(.system(size: 14))
                    .foregroundStyle(LpspFlightyTokens.fltBlue)
                    .frame(maxWidth: .infinity)
                Text(destCode).font(LpspFlightyFonts.fltRouteCode).foregroundStyle(.white)
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(depTime).font(LpspFlightyFonts.fltTimeHero).foregroundStyle(.white)
                    Text(depGate).font(LpspFlightyFonts.fltGate).foregroundStyle(LpspFlightyTokens.fltTextSecondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(arrTime).font(LpspFlightyFonts.fltTimeHero).foregroundStyle(.white)
                    Text(arrGate).font(LpspFlightyFonts.fltGate).foregroundStyle(LpspFlightyTokens.fltTextSecondary)
                }
            }
            Text(meta).font(LpspFlightyFonts.fltMeta).foregroundStyle(LpspFlightyTokens.fltTextSecondary)
        }
        .padding(18)
        .background(RoundedRectangle(cornerRadius: 16).fill(LpspFlightyTokens.fltSurface1))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(LpspFlightyTokens.fltDivider, lineWidth: 1))
        .shadow(color: .black.opacity(0.4), radius: 16, y: 4)
    }
}

fileprivate struct LpspFlightyOnTimeRing: View {
    let percent: Int   // 0...100
    var body: some View {
        ZStack {
            Circle().stroke(LpspFlightyTokens.fltDivider, lineWidth: 3)
            Circle()
                .trim(from: 0, to: CGFloat(percent) / 100)
                .stroke(LpspFlightyTokens.fltOnTime, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 0) {
                Text("\(percent)%").font(LpspFlightyFonts.fltOnTimePct).foregroundStyle(.white)
                Text("on time").font(LpspFlightyFonts.fltTimestamp).foregroundStyle(LpspFlightyTokens.fltTextSecondary)
            }
        }
        .frame(width: 72, height: 72)
    }
}

fileprivate struct LpspFlightyFltPrimaryButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspFlightyFonts.fltButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(RoundedRectangle(cornerRadius: 14).fill(LpspFlightyTokens.fltBlue))
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: title)
        .buttonStyle(LpspFlightyFltPressableStyle())
    }
}

fileprivate struct LpspFlightyFltPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}



// MARK: - Showroom data & store

private enum LpspFlightyShowroomTab: String, CaseIterable, Identifiable {
    case flights, search, airport, profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .flights: "Flights"
        case .search: "Search"
        case .airport: "Airport"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .flights: "airplane"
        case .search: "magnifyingglass"
        case .airport: "building.columns.fill"
        case .profile: "person.fill"
        }
    }
}

private struct LpspFlightyFlight: Identifiable, Equatable {
    let id: String
    let airline: String
    let flightNo: String
    let originCode: String
    let destCode: String
    let depTime: String
    let arrTime: String
    let depGate: String
    let arrGate: String
    let meta: String
    let delayMinutes: Int
    let progress: CGFloat
    let originPoint: CGPoint
    let destPoint: CGPoint
}

private enum LpspFlightyShowroomData {
    static let activeFlight = LpspFlightyFlight(
        id: "ua-482",
        airline: "United",
        flightNo: "UA 482",
        originCode: "SFO",
        destCode: "JFK",
        depTime: "7:45 AM",
        arrTime: "4:34 PM",
        depGate: "Gate B24 · Term 2",
        arrGate: "Gate 7 · Term 4",
        meta: "5h 42m · 2,586 mi · Nonstop · 62% complete",
        delayMinutes: 22,
        progress: 0.62,
        originPoint: CGPoint(x: 0.16, y: 0.64),
        destPoint: CGPoint(x: 0.82, y: 0.38)
    )

    static let airportName = "San Francisco International"
    static let airportCode = "SFO"
    static let onTimePercent = 94
}

@MainActor
fileprivate final class LpspFlightyStore: ObservableObject {
    @Published var selectedTab: LpspFlightyShowroomTab = .flights
    @Published var flight: LpspFlightyFlight = LpspFlightyShowroomData.activeFlight
    @Published var searchQuery = ""
    @Published var searchResultMessage = ""
    @Published var lastActionMessage = ""

    func searchFlight() {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            searchResultMessage = "Enter a flight number"
            return
        }
        if query.uppercased().contains("482") || query.uppercased().contains("UA") {
            searchResultMessage = "Found \(flight.airline) · \(flight.flightNo)"
            selectedTab = .flights
        } else {
            searchResultMessage = "No flight found for \"\(query)\""
        }
        lastActionMessage = searchResultMessage
    }

    func refreshFlight() {
        lastActionMessage = "Updated \(flight.flightNo)"
    }
}

// MARK: - Écrans showroom

private struct LpspFlightyShowroomRoot: View {
    @ObservedObject var store: LpspFlightyStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .flights:
                    LpspFlightySpectrHomeTabScreen(store: store)
                case .search:
                    LpspFlightySearchTabScreen(store: store)
                case .airport:
                    LpspFlightyAirportTabScreen(store: store)
                case .profile:
                    LpspFlightyProfileTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspFlightyLabeledTabBar(store: store)
        }
        .background(LpspFlightyTokens.fltCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspFlightyLabeledTabBar: View {
    @ObservedObject var store: LpspFlightyStore

    var body: some View {
        HStack {
            ForEach(LpspFlightyShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspFlightyFonts.fltTab.weight(store.selectedTab == tab ? .bold : .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspFlightyTokens.fltBlue
                            : LpspFlightyTokens.fltTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspFlightyTokens.fltCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspFlightyTokens.fltDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspFlightyShowroomMapView: View {
    let flight: LpspFlightyFlight

    var body: some View {
        GeometryReader { geo in
            ZStack {
                LpspFlightyTokens.fltMapLand

                RoundedRectangle(cornerRadius: 40)
                    .fill(LpspFlightyTokens.fltMapGraticule)
                    .frame(width: geo.size.width * 0.56, height: geo.size.height * 0.28)
                    .offset(x: -geo.size.width * 0.12, y: geo.size.height * 0.08)

                RoundedRectangle(cornerRadius: 30)
                    .fill(LpspFlightyTokens.fltSurface2)
                    .frame(width: geo.size.width * 0.44, height: geo.size.height * 0.22)
                    .offset(x: geo.size.width * 0.18, y: -geo.size.height * 0.06)

                LinearGradient(
                    colors: [Color.clear, LpspFlightyTokens.fltCanvas.opacity(0.35)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                LpspFlightyLiveFlightMap(
                    origin: flight.originPoint,
                    destination: flight.destPoint,
                    livePosition: flight.progress
                )

                LpspFlightyMapPinLabel(code: flight.originCode)
                    .position(
                        x: flight.originPoint.x * geo.size.width,
                        y: flight.originPoint.y * geo.size.height
                    )
                LpspFlightyMapPinLabel(code: flight.destCode, isDestination: true)
                    .position(
                        x: flight.destPoint.x * geo.size.width,
                        y: flight.destPoint.y * geo.size.height
                    )
            }
        }
    }
}

private struct LpspFlightyMapPinLabel: View {
    let code: String
    var isDestination: Bool = false

    var body: some View {
        VStack(spacing: 4) {
            Circle()
                .fill(isDestination ? LpspFlightyTokens.fltBlue : LpspFlightyTokens.fltOnTime)
                .frame(width: 10, height: 10)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.8), lineWidth: 2)
                )
            Text(code)
                .font(LpspFlightyFonts.fltStatus)
                .foregroundStyle(LpspFlightyTokens.fltTextPrimary)
        }
    }
}

private struct LpspFlightyShowroomFlightSheet: View {
    let flight: LpspFlightyFlight
    let onRefresh: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(LpspFlightyTokens.fltTextTertiary)
                .frame(width: 36, height: 4)
                .padding(.top, 8)
                .padding(.bottom, 12)

            LpspFlightyFlightCard(
                airline: flight.airline,
                flightNo: flight.flightNo,
                originCode: flight.originCode,
                destCode: flight.destCode,
                depTime: flight.depTime,
                arrTime: flight.arrTime,
                depGate: flight.depGate,
                arrGate: flight.arrGate,
                meta: flight.meta,
                status: .delayed(flight.delayMinutes)
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 8)

            Button(action: onRefresh) {
                Text("Refresh")
                    .font(LpspFlightyFonts.fltMeta.weight(.semibold))
                    .foregroundStyle(LpspFlightyTokens.fltBlue)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(LpspFlightyTokens.fltSurface1)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

private struct LpspFlightySpectrHomeTabScreen: View {
    @ObservedObject var store: LpspFlightyStore

    var body: some View {
        ZStack(alignment: .bottom) {
            LpspFlightyShowroomMapView(flight: store.flight)
                .ignoresSafeArea()

            LpspFlightyShowroomFlightSheet(flight: store.flight) {
                store.refreshFlight()
            }
        }
    }
}

private struct LpspFlightySearchTabScreen: View {
    @ObservedObject var store: LpspFlightyStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Search")
                    .font(LpspFlightyFonts.fltSection)
                    .foregroundStyle(LpspFlightyTokens.fltTextPrimary)
                    .padding(.top, 8)

                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspFlightyTokens.fltTextSecondary)
                    TextField("Flight number", text: $store.searchQuery)
                        .font(LpspFlightyFonts.fltBody)
                        .foregroundStyle(LpspFlightyTokens.fltTextPrimary)
                        .textInputAutocapitalization(.characters)
                }
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LpspFlightyTokens.fltSurface2)
                )

                LpspFlightyFltPrimaryButton(title: "Search flights") {
                    store.searchFlight()
                }

                if !store.searchResultMessage.isEmpty {
                    Text(store.searchResultMessage)
                        .font(LpspFlightyFonts.fltMeta)
                        .foregroundStyle(LpspFlightyTokens.fltTextSecondary)
                }

                Text("Try UA 482")
                    .font(LpspFlightyFonts.fltMeta)
                    .foregroundStyle(LpspFlightyTokens.fltTextTertiary)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

private struct LpspFlightyAirportTabScreen: View {
    @ObservedObject var store: LpspFlightyStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Airport")
                    .font(LpspFlightyFonts.fltSection)
                    .foregroundStyle(LpspFlightyTokens.fltTextPrimary)
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text(LpspFlightyShowroomData.airportCode)
                        .font(LpspFlightyFonts.fltRouteCode)
                        .foregroundStyle(LpspFlightyTokens.fltTextPrimary)
                    Text(LpspFlightyShowroomData.airportName)
                        .font(LpspFlightyFonts.fltBody)
                        .foregroundStyle(LpspFlightyTokens.fltTextSecondary)

                    Divider().overlay(LpspFlightyTokens.fltDivider)

                    Text("Your departure")
                        .font(LpspFlightyFonts.fltMeta.weight(.semibold))
                        .foregroundStyle(LpspFlightyTokens.fltTextSecondary)
                    Text(store.flight.depGate)
                        .font(LpspFlightyFonts.fltGate)
                        .foregroundStyle(LpspFlightyTokens.fltTextPrimary)
                    Text(store.flight.depTime)
                        .font(LpspFlightyFonts.fltTimeHero)
                        .foregroundStyle(LpspFlightyTokens.fltTextPrimary)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LpspFlightyTokens.fltSurface1)
                )
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

private struct LpspFlightyProfileTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                Text("Profile")
                    .font(LpspFlightyFonts.fltSection)
                    .foregroundStyle(LpspFlightyTokens.fltTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)

                LpspFlightyOnTimeRing(percent: LpspFlightyShowroomData.onTimePercent)

                Text("Your flights arrive on time \(LpspFlightyShowroomData.onTimePercent)% of the time")
                    .font(LpspFlightyFonts.fltBody)
                    .foregroundStyle(LpspFlightyTokens.fltTextSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}



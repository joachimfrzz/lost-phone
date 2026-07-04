import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/flighty
// Meliwat/awesome-ios-design-md/travel/flighty/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeFlightyView: View {
    var body: some View {
        LpspFlightyShowroomRoot()
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



// MARK: - Écrans showroom

private struct LpspFlightyShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspFlightySpectrHomeTabScreen()
                .tabItem { Label("Flights", systemImage: "airplane") }
                .tag(0)
            LpspFlightyTravelTabScreen(title: "Search", tabIndex: 1)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
            LpspFlightyTravelTabScreen(title: "Airport", tabIndex: 2)
                .tabItem { Label("Airport", systemImage: "building.2.fill") }
                .tag(2)
            LpspFlightyTravelTabScreen(title: "Profile", tabIndex: 3)
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .tag(3)
        }
        .tint(LpspFlightyTokens.fltTextPrimary)
        
    }
}


private struct LpspFlightyGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspFlightyTokens.fltTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspFlightyTokens.fltTextPrimary))
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


private struct LpspFlightyTravelExploreTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(0..<6, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LpspFlightyTokens.fltTextPrimary.opacity(0.1 + Double(i) * 0.05))
                            .frame(height: 180)
                            .overlay(alignment: .bottomLeading) {
                                Text("Logement \(i + 1)").font(.headline).padding(8)
                            }
                    }
                }
                .padding()
            }
            .background(LpspFlightyTokens.fltCanvas.ignoresSafeArea())
            .navigationTitle("Explore")
        }
    }
}

private struct LpspFlightyTravelTripsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Paris · 12–15 juil.", "Lisbonne · 3–7 août"], id: \.self) { trip in
                Label(trip, systemImage: "airplane")
            }
            .navigationTitle("Trips")
        }
    }
}

private struct LpspFlightyTravelInboxTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Message hôte · Paris", "Rappel check-in"], id: \.self) { msg in
                Label(msg, systemImage: "message")
            }
            .navigationTitle("Inbox")
        }
    }
}

private struct LpspFlightyTravelProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Circle().fill(LpspFlightyTokens.fltTextPrimary.gradient).frame(width: 72, height: 72)
                Text("lost.phone").font(.title2.bold())
            }
            .navigationTitle("Profile")
        }
    }
}

private struct LpspFlightyTravelWishlistsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Paris loft", "Bretagne bord de mer"], id: \.self) { Label($0, systemImage: "heart") }
            .navigationTitle("Wishlists")
        }
    }
}

private struct LpspFlightyTravelTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if low.contains("wishlist") || low.contains("favori") { LpspFlightyTravelWishlistsTabScreen() }
        else if low.contains("explor") || low.contains("search") || low.contains("recherch") { LpspFlightyTravelExploreTabScreen() }
        else if low.contains("trip") || low.contains("voyage") { LpspFlightyTravelTripsTabScreen() }
        else if low.contains("inbox") || low.contains("message") { LpspFlightyTravelInboxTabScreen() }
        else if low.contains("profil") || low.contains("profile") { LpspFlightyTravelProfileTabScreen() }
        else if tabIndex == 0 { LpspFlightyTravelExploreTabScreen() }
        else { LpspFlightyTravelTripsTabScreen() }
    }
}


private struct LpspFlightySpectrHomeTabScreen: View {
    var body: some View {
        ZStack(alignment: .bottom) {
        Color(red:0.89,green:0.91,blue:0.85).ignoresSafeArea()
        VStack(spacing: 0) {
                Text("United · UA 482").font(.system(size: 17.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("DELAYED 22m").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("SFO").font(.system(size: 24.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("JFK").font(.system(size: 24.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("7:45 AM").font(.system(size: 32.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Gate B24 · Term 2").font(.system(size: 15.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("4:34 PM").font(.system(size: 32.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Gate 7 · Term 4").font(.system(size: 15.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("5h 42m · 2,586 mi · Nonstop · 62% complete").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        } .background(Color(red: 0.043, green: 0.043, blue: 0.059)).clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .background(Color(red: 0.043, green: 0.043, blue: 0.059).ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}



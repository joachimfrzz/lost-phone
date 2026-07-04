import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/google-maps
// Meliwat/awesome-ios-design-md/travel/google-maps/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePlansView: View {
    var body: some View {
        LpspPlansShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspPlansTokens {
    // MARK: - Canvas & Surfaces (Light)
    static let gmCanvas        = Color.white                                   // #FFFFFF
    static let gmSurfaceMuted  = Color(red: 0.945, green: 0.953, blue: 0.957) // #F1F3F4
    static let gmDivider       = Color(red: 0.855, green: 0.863, blue: 0.878) // #DADCE0

    // MARK: - Text
    static let gmTextPrimary   = Color(red: 0.125, green: 0.133, blue: 0.141) // #202124
    static let gmTextSecondary = Color(red: 0.373, green: 0.388, blue: 0.408) // #5F6368
    static let gmTextTertiary  = Color(red: 0.502, green: 0.525, blue: 0.545) // #80868B

    // MARK: - Google Logo Colors (Pin System)
    static let gmBlue          = Color(red: 0.259, green: 0.522, blue: 0.957) // #4285F4
    static let gmBluePressed   = Color(red: 0.102, green: 0.451, blue: 0.910) // #1A73E8
    static let gmBlueDark      = Color(red: 0.090, green: 0.306, blue: 0.651) // #174EA6
    static let gmRed           = Color(red: 0.918, green: 0.263, blue: 0.208) // #EA4335
    static let gmYellow        = Color(red: 0.984, green: 0.737, blue: 0.016) // #FBBC04
    static let gmGreen         = Color(red: 0.204, green: 0.659, blue: 0.325) // #34A853
    static let gmOrange        = Color(red: 0.984, green: 0.549, blue: 0.000) // #FB8C00

    // MARK: - Map Tiles (Light)
    static let gmRoadWhite     = Color.white                                   // #FFFFFF
    static let gmHighwayYellow = Color(red: 0.992, green: 0.965, blue: 0.890) // #FDF6E3
    static let gmWaterBlue     = Color(red: 0.667, green: 0.855, blue: 1.000) // #AADAFF
    static let gmParkGreen     = Color(red: 0.784, green: 0.902, blue: 0.788) // #C8E6C9
    static let gmBuildingFill  = Color(red: 0.941, green: 0.941, blue: 0.941) // #F0F0F0

    // MARK: - Dark Mode
    static let gmDarkCanvas    = Color(red: 0.125, green: 0.133, blue: 0.141) // #202124
    static let gmDarkSurface1  = Color(red: 0.176, green: 0.180, blue: 0.192) // #2D2E31
    static let gmDarkSurface2  = Color(red: 0.235, green: 0.251, blue: 0.263) // #3C4043
    static let gmDarkTextPrim  = Color(red: 0.910, green: 0.918, blue: 0.929) // #E8EAED

    // MARK: - Blue Halo (Accuracy Circle)
    static let gmBlueHalo      = Color(red: 0.259, green: 0.522, blue: 0.957, opacity: 0.18)
    static let gmBlueHaloEdge  = Color(red: 0.259, green: 0.522, blue: 0.957, opacity: 0.4)
}

private enum LpspPlansFonts {
    // Google Sans (headings, CTAs)
    static let gmNavTurn      = Font.system(size: 36, weight: .regular)
    static let gmScreenTitle  = Font.system(size: 28, weight: .regular)
    static let gmPlaceTitle   = Font.system(size: 20, weight: .regular)
    static let gmSection      = Font.system(size: 16, weight: .regular)
    static let gmButton       = Font.system(size: 16, weight: .regular)
    static let gmButtonSmall  = Font.system(size: 14, weight: .regular)
    static let gmTab          = Font.system(size: 11, weight: .regular)
    static let gmChip         = Font.system(size: 14, weight: .regular)

    // Roboto (body, UI, data)
    static let gmRowTitle     = Font.system(size: 16, weight: .regular)
    static let gmBody         = Font.system(size: 14, weight: .regular)
    static let gmAddress      = Font.system(size: 14, weight: .regular)
    static let gmMeta         = Font.system(size: 13, weight: .regular)
    static let gmRating       = Font.system(size: 14, weight: .regular)
    static let gmETA          = Font.system(size: 16, weight: .regular)
    static let gmDistancePill = Font.system(size: 13, weight: .regular)
}

// Tabular numerals modifier for distances, ETAs, speeds
fileprivate extension View {
    func gmTabularFigures() -> some View {
        self.monospacedDigit()
    }
}

fileprivate struct LpspPlansGMSearchBar: View {
    let onTap: () -> Void
    let onMic: () -> Void
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 28, height: 28)
                .overlay(Image(systemName: "person.fill").foregroundStyle(.white).font(.system(size: 14)))
            Text("Search here")
                .font(LpspPlansFonts.gmButton)
                .foregroundStyle(LpspPlansTokens.gmTextSecondary)
            Spacer()
            Button(action: onMic) {
                Image(systemName: "mic.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspPlansTokens.gmTextSecondary)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(
            Capsule().fill(LpspPlansTokens.gmCanvas)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        )
        .padding(.horizontal, 16)
        .onTapGesture(perform: onTap)
    }
}

fileprivate struct LpspPlansGMDirectionsFAB: View {
    let action: () -> Void
    @State private var pressed = false
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(pressed ? LpspPlansTokens.gmBluePressed : LpspPlansTokens.gmBlue))
                .shadow(color: .black.opacity(0.2), radius: 12, y: 4)
        }
        .scaleEffect(pressed ? 0.95 : 1)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: pressed)
        .sensoryFeedback(.impact(weight: .medium), trigger: pressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressed = true }
                .onEnded   { _ in pressed = false }
        )
    }
}

fileprivate struct LpspPlansGMLocationDot: View {
    @State private var pulse = false
    var headingDegrees: Double?  // if non-nil, draw a cone in that direction

    var body: some View {
        ZStack {
            // Accuracy circle
            Circle()
                .fill(LpspPlansTokens.gmBlueHalo)
                .overlay(Circle().stroke(LpspPlansTokens.gmBlueHaloEdge, lineWidth: 1))
                .frame(width: 140, height: 140)

            // Heading cone (optional)
            if let heading = headingDegrees {
                LpspPlansTriangle()
                    .fill(LinearGradient(
                        colors: [LpspPlansTokens.gmBlue.opacity(0.55), LpspPlansTokens.gmBlue.opacity(0)],
                        startPoint: .top, endPoint: .bottom))
                    .frame(width: 40, height: 48)
                    .offset(y: -48)
                    .rotationEffect(.degrees(heading))
            }

            // Inner blue dot with white stroke ring
            Circle()
                .fill(LpspPlansTokens.gmBlue)
                .frame(width: 12, height: 12)
                .overlay(Circle().stroke(.white, lineWidth: 3).frame(width: 18, height: 18))
                .scaleEffect(pulse ? 1.15 : 1.0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }
}

fileprivate struct LpspPlansTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

fileprivate struct LpspPlansGMMapPin: View {
    enum LpspPlansKind { case `default`, saved, homeWork, category(String) }
    let kind: LpspPlansKind
    var fillColor: Color {
        switch kind {
        case .default:       return LpspPlansTokens.gmRed
        case .saved:         return LpspPlansTokens.gmGreen
        case .homeWork:      return LpspPlansTokens.gmBlue
        case .category:      return LpspPlansTokens.gmOrange
        }
    }
    var body: some View {
        ZStack(alignment: .top) {
            LpspPlansTeardropShape()
                .fill(fillColor)
                .frame(width: 32, height: 40)
                .shadow(color: .black.opacity(0.25), radius: 3, y: 4)

            if case .default = kind {
                Circle()
                    .fill(.white)
                    .frame(width: 10, height: 10)
                    .offset(y: 10)
            } else if case .category(let symbol) = kind {
                Image(systemName: symbol)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .offset(y: 10)
            }
        }
    }
}

fileprivate struct LpspPlansTeardropShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let circleD = rect.width
        p.addArc(center: CGPoint(x: rect.midX, y: rect.width / 2),
                 radius: circleD / 2,
                 startAngle: .degrees(0),
                 endAngle: .degrees(360), clockwise: false)
        p.move(to: CGPoint(x: rect.minX + 2, y: rect.width / 2))
        p.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                       control: CGPoint(x: rect.minX, y: rect.width))
        p.addQuadCurve(to: CGPoint(x: rect.maxX - 2, y: rect.width / 2),
                       control: CGPoint(x: rect.maxX, y: rect.width))
        return p
    }
}

fileprivate struct LpspPlansGMPlaceCard: View {
    let title: String
    let rating: Double
    let reviewCount: Int
    let category: String
    let distance: String
    let isOpen: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LpspPlansTokens.gmSurfaceMuted)
                    .frame(width: 72, height: 72)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(LpspPlansFonts.gmPlaceTitle).foregroundStyle(LpspPlansTokens.gmTextPrimary).lineLimit(2)
                    HStack(spacing: 4) {
                        Text(String(format: "%.1f", rating))
                            .font(LpspPlansFonts.gmRating)
                            .foregroundStyle(LpspPlansTokens.gmTextPrimary)
                            .gmTabularFigures()
                        ForEach(0..<5, id: \.self) { i in
                            Image(systemName: Double(i) < rating ? "star.fill" : "star")
                                .font(.system(size: 12))
                                .foregroundStyle(LpspPlansTokens.gmYellow)
                        }
                        Text("(\(reviewCount))")
                            .font(LpspPlansFonts.gmBody)
                            .foregroundStyle(LpspPlansTokens.gmTextSecondary)
                    }
                    Text("\(category) · \(distance)")
                        .font(LpspPlansFonts.gmMeta)
                        .foregroundStyle(LpspPlansTokens.gmTextSecondary)
                    if isOpen {
                        Text("Open now")
                            .font(LpspPlansFonts.gmMeta.weight(.medium))
                            .foregroundStyle(LpspPlansTokens.gmGreen)
                    }
                }
            }
            LpspPlansGMActionRow()
        }
        .padding(16)
        .background(LpspPlansTokens.gmCanvas)
    }
}

fileprivate struct LpspPlansGMActionRow: View {
    var body: some View {
        HStack(spacing: 12) {
            LpspPlansGMPillButton(icon: "arrow.triangle.turn.up.right.diamond.fill", title: "Directions", filled: true)
            LpspPlansGMPillButton(icon: "bookmark", title: "Save", filled: false)
            LpspPlansGMPillButton(icon: "square.and.arrow.up", title: "Share", filled: false)
            LpspPlansGMPillButton(icon: "phone.fill", title: "Call", filled: false)
        }
    }
}

fileprivate struct LpspPlansGMPillButton: View {
    let icon: String
    let title: String
    let filled: Bool
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon).font(.system(size: 16, weight: .medium))
            Text(title).font(LpspPlansFonts.gmButtonSmall)
        }
        .foregroundStyle(filled ? .white : LpspPlansTokens.gmBlue)
        .padding(.horizontal, 16)
        .frame(height: 36)
        .background(
            Capsule().fill(filled ? LpspPlansTokens.gmBlue : Color.clear)
                .overlay(Capsule().stroke(filled ? Color.clear : LpspPlansTokens.gmDivider, lineWidth: 1))
        )
    }
}

fileprivate struct LpspPlansGMTurnCard: View {
    let instruction: String
    let distance: String
    let nextInstruction: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: "arrow.turn.up.right")
                    .font(.system(size: 44, weight: .bold))
                    .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 4) {
                    Text(instruction)
                        .font(.custom("GoogleSans-Bold", size: 22))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    Text("in \(distance)")
                        .font(LpspPlansFonts.gmBody)
                        .foregroundStyle(.white.opacity(0.7))
                        .gmTabularFigures()
                }
                Spacer()
            }
            if let next = nextInstruction {
                HStack(spacing: 10) {
                    Image(systemName: "arrow.turn.up.left")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(.white.opacity(0.8))
                    Text("Then \(next)")
                        .font(LpspPlansFonts.gmBody)
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(.top, 6)
                .overlay(Rectangle().frame(height: 1).foregroundStyle(.white.opacity(0.2)), alignment: .top)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).fill(LpspPlansTokens.gmBlue))
        .shadow(color: .black.opacity(0.2), radius: 16, y: 4)
        .padding(.horizontal, 16)
    }
}

import MapKit

final class LpspPlansGMRouteRenderer: MKOverlayRenderer {
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        guard let polyline = overlay as? MKPolyline else { return }
        let path = CGMutablePath()
        for i in 0..<polyline.pointCount {
            let pt = self.point(for: polyline.points()[i])
            if i == 0 { path.move(to: pt) } else { path.addLine(to: pt) }
        }
        // Casing
        context.setStrokeColor(UIColor(red: 0.09, green: 0.306, blue: 0.651, alpha: 1).cgColor) // #174EA6
        context.setLineWidth(6.5 / zoomScale)
        context.setLineCap(.round)
        context.addPath(path); context.strokePath()

        // Fill
        context.setStrokeColor(UIColor(red: 0.259, green: 0.522, blue: 0.957, alpha: 1).cgColor) // #4285F4
        context.setLineWidth(5 / zoomScale)
        context.setLineCap(.round)
        context.addPath(path); context.strokePath()
    }
}



// MARK: - Écrans showroom

private struct LpspPlansShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspPlansSpectrHomeTabScreen()
                .tabItem { Label("Explore", systemImage: "safari.fill") }
                .tag(0)
            LpspPlansMapsTabScreen(title: "Go", tabIndex: 1)
                .tabItem { Label("Go", systemImage: "location.north.circle.fill") }
                .tag(1)
            LpspPlansMapsTabScreen(title: "Saved", tabIndex: 2)
                .tabItem { Label("Saved", systemImage: "bookmark.fill") }
                .tag(2)
            LpspPlansMapsTabScreen(title: "Contribute", tabIndex: 3)
                .tabItem { Label("Contribute", systemImage: "plus.circle.fill") }
                .tag(3)
            LpspPlansMapsTabScreen(title: "Updates", tabIndex: 4)
                .tabItem { Label("Updates", systemImage: "newspaper.fill") }
                .tag(4)
        }
        .tint(LpspPlansTokens.gmYellow)
        
    }
}


private struct LpspPlansGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspPlansTokens.gmYellow.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspPlansTokens.gmYellow))
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


private struct LpspPlansMapsHomeTabScreen: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.15).ignoresSafeArea()
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                        .frame(height: 48)
                        .overlay(HStack { Image(systemName: "magnifyingglass"); Text("Rechercher") }.foregroundStyle(.secondary))
                        .padding()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

private struct LpspPlansMapsRoutesTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Maison → Bureau", "Bureau → Gare"], id: \.self) { Label($0, systemImage: "arrow.triangle.turn.up.right.diamond") }
            .navigationTitle("Itinéraire")
        }
    }
}

private struct LpspPlansMapsProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            List { Label("Adresses enregistrées", systemImage: "mappin"); Label("Historique", systemImage: "clock") }
            .navigationTitle("Profil")
        }
    }
}

private struct LpspPlansMapsTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if tabIndex == 0 || low.contains("carte") || low.contains("map") || low.contains("home") { LpspPlansMapsHomeTabScreen() }
        else if low.contains("itin") || low.contains("route") { LpspPlansMapsRoutesTabScreen() }
        else { LpspPlansMapsProfileTabScreen() }
    }
}


private struct LpspPlansSpectrHomeTabScreen: View {
    var body: some View {
        LpspPlansMapsHomeTabScreen()
    }
}



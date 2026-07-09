import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/google-maps
// Meliwat/awesome-ios-design-md/travel/google-maps/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeGoogleMapsView: View {
    var body: some View {
        LpspGoogleMapsShowroomRoot(store: LpspGoogleMapsStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspGoogleMapsTokens {
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

private enum LpspGoogleMapsFonts {
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

fileprivate struct LpspGoogleMapsGMSearchBar: View {
    let onTap: () -> Void
    let onMic: () -> Void
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 28, height: 28)
                .overlay(Image(systemName: "person.fill").foregroundStyle(.white).font(.system(size: 14)))
            Text("Search here")
                .font(LpspGoogleMapsFonts.gmButton)
                .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
            Spacer()
            Button(action: onMic) {
                Image(systemName: "mic.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(
            Capsule().fill(LpspGoogleMapsTokens.gmCanvas)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        )
        .padding(.horizontal, 16)
        .onTapGesture(perform: onTap)
    }
}

fileprivate struct LpspGoogleMapsGMDirectionsFAB: View {
    let action: () -> Void
    @State private var pressed = false
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(pressed ? LpspGoogleMapsTokens.gmBluePressed : LpspGoogleMapsTokens.gmBlue))
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

fileprivate struct LpspGoogleMapsGMLocationDot: View {
    @State private var pulse = false
    var headingDegrees: Double?  // if non-nil, draw a cone in that direction

    var body: some View {
        ZStack {
            // Accuracy circle
            Circle()
                .fill(LpspGoogleMapsTokens.gmBlueHalo)
                .overlay(Circle().stroke(LpspGoogleMapsTokens.gmBlueHaloEdge, lineWidth: 1))
                .frame(width: 140, height: 140)

            // Heading cone (optional)
            if let heading = headingDegrees {
                LpspGoogleMapsTriangle()
                    .fill(LinearGradient(
                        colors: [LpspGoogleMapsTokens.gmBlue.opacity(0.55), LpspGoogleMapsTokens.gmBlue.opacity(0)],
                        startPoint: .top, endPoint: .bottom))
                    .frame(width: 40, height: 48)
                    .offset(y: -48)
                    .rotationEffect(.degrees(heading))
            }

            // Inner blue dot with white stroke ring
            Circle()
                .fill(LpspGoogleMapsTokens.gmBlue)
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

fileprivate struct LpspGoogleMapsTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

fileprivate struct LpspGoogleMapsGMMapPin: View {
    enum LpspGoogleMapsKind { case `default`, saved, homeWork, category(String) }
    let kind: LpspGoogleMapsKind
    var fillColor: Color {
        switch kind {
        case .default:       return LpspGoogleMapsTokens.gmRed
        case .saved:         return LpspGoogleMapsTokens.gmGreen
        case .homeWork:      return LpspGoogleMapsTokens.gmBlue
        case .category:      return LpspGoogleMapsTokens.gmOrange
        }
    }
    var body: some View {
        ZStack(alignment: .top) {
            LpspGoogleMapsTeardropShape()
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

fileprivate struct LpspGoogleMapsTeardropShape: Shape {
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

fileprivate struct LpspGoogleMapsGMPlaceCard: View {
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
                    .fill(LpspGoogleMapsTokens.gmSurfaceMuted)
                    .frame(width: 72, height: 72)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(LpspGoogleMapsFonts.gmPlaceTitle).foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary).lineLimit(2)
                    HStack(spacing: 4) {
                        Text(String(format: "%.1f", rating))
                            .font(LpspGoogleMapsFonts.gmRating)
                            .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                            .gmTabularFigures()
                        ForEach(0..<5, id: \.self) { i in
                            Image(systemName: Double(i) < rating ? "star.fill" : "star")
                                .font(.system(size: 12))
                                .foregroundStyle(LpspGoogleMapsTokens.gmYellow)
                        }
                        Text("(\(reviewCount))")
                            .font(LpspGoogleMapsFonts.gmBody)
                            .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
                    }
                    Text("\(category) · \(distance)")
                        .font(LpspGoogleMapsFonts.gmMeta)
                        .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
                    if isOpen {
                        Text("Open now")
                            .font(LpspGoogleMapsFonts.gmMeta.weight(.medium))
                            .foregroundStyle(LpspGoogleMapsTokens.gmGreen)
                    }
                }
            }
            LpspGoogleMapsGMActionRow()
        }
        .padding(16)
        .background(LpspGoogleMapsTokens.gmCanvas)
    }
}

fileprivate struct LpspGoogleMapsGMActionRow: View {
    var body: some View {
        HStack(spacing: 12) {
            LpspGoogleMapsGMPillButton(icon: "arrow.triangle.turn.up.right.diamond.fill", title: "Directions", filled: true)
            LpspGoogleMapsGMPillButton(icon: "bookmark", title: "Save", filled: false)
            LpspGoogleMapsGMPillButton(icon: "square.and.arrow.up", title: "Share", filled: false)
            LpspGoogleMapsGMPillButton(icon: "phone.fill", title: "Call", filled: false)
        }
    }
}

fileprivate struct LpspGoogleMapsGMPillButton: View {
    let icon: String
    let title: String
    let filled: Bool
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon).font(.system(size: 16, weight: .medium))
            Text(title).font(LpspGoogleMapsFonts.gmButtonSmall)
        }
        .foregroundStyle(filled ? .white : LpspGoogleMapsTokens.gmBlue)
        .padding(.horizontal, 16)
        .frame(height: 36)
        .background(
            Capsule().fill(filled ? LpspGoogleMapsTokens.gmBlue : Color.clear)
                .overlay(Capsule().stroke(filled ? Color.clear : LpspGoogleMapsTokens.gmDivider, lineWidth: 1))
        )
    }
}

fileprivate struct LpspGoogleMapsGMTurnCard: View {
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
                        .font(LpspGoogleMapsFonts.gmBody)
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
                        .font(LpspGoogleMapsFonts.gmBody)
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(.top, 6)
                .overlay(Rectangle().frame(height: 1).foregroundStyle(.white.opacity(0.2)), alignment: .top)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).fill(LpspGoogleMapsTokens.gmBlue))
        .shadow(color: .black.opacity(0.2), radius: 16, y: 4)
        .padding(.horizontal, 16)
    }
}

import MapKit

final class LpspGoogleMapsGMRouteRenderer: MKOverlayRenderer {
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



// MARK: - Showroom data & store

private enum LpspGoogleMapsShowroomTab: String, CaseIterable, Identifiable {
    case explore, go, saved, contribute, updates

    var id: String { rawValue }

    var title: String {
        switch self {
        case .explore: "Explore"
        case .go: "Go"
        case .saved: "Saved"
        case .contribute: "Contribute"
        case .updates: "Updates"
        }
    }

    var icon: String {
        switch self {
        case .explore: "safari.fill"
        case .go: "location.north.fill"
        case .saved: "bookmark.fill"
        case .contribute: "plus.circle.fill"
        case .updates: "bell.fill"
        }
    }
}

private struct LpspGoogleMapsPlace: Identifiable, Equatable {
    let id: String
    let title: String
    let rating: Double
    let reviewCount: Int
    let category: String
    let distance: String
    let isOpen: Bool
    var isSaved: Bool
}

private enum LpspGoogleMapsShowroomData {
    static let featured = LpspGoogleMapsPlace(
        id: "sanborns",
        title: "Sanborn's Café",
        rating: 4.6,
        reviewCount: 142,
        category: "Coffee shop",
        distance: "0.3 mi",
        isOpen: true,
        isSaved: false
    )

    static let savedPlaces = [
        LpspGoogleMapsPlace(
            id: "home",
            title: "Home",
            rating: 0,
            reviewCount: 0,
            category: "Saved place",
            distance: "2.1 mi",
            isOpen: true,
            isSaved: true
        ),
        LpspGoogleMapsPlace(
            id: "work",
            title: "Work",
            rating: 0,
            reviewCount: 0,
            category: "Saved place",
            distance: "4.8 mi",
            isOpen: true,
            isSaved: true
        ),
    ]

    static let updates = [
        ("Traffic on Market St", "Slower than usual · 12 min ago"),
        ("New photos at Sanborn's Café", "Added by local guide · 1 hr ago"),
    ]
}

@MainActor
fileprivate final class LpspGoogleMapsStore: ObservableObject {
    @Published var selectedTab: LpspGoogleMapsShowroomTab = .explore
    @Published var featuredPlace: LpspGoogleMapsPlace = LpspGoogleMapsShowroomData.featured
    @Published var savedPlaces: [LpspGoogleMapsPlace] = LpspGoogleMapsShowroomData.savedPlaces
    @Published var isNavigating = false
    @Published var searchQuery = ""
    @Published var lastActionMessage = ""

    func startDirections() {
        isNavigating = true
        selectedTab = .go
        lastActionMessage = "Directions to \(featuredPlace.title)"
    }

    func toggleSaveFeatured() {
        var updated = featuredPlace
        updated.isSaved.toggle()
        featuredPlace = updated
        if featuredPlace.isSaved {
            if !savedPlaces.contains(where: { $0.id == featuredPlace.id }) {
                savedPlaces.append(featuredPlace)
            }
        } else {
            savedPlaces.removeAll { $0.id == featuredPlace.id }
        }
        lastActionMessage = featuredPlace.isSaved ? "Saved \(featuredPlace.title)" : "Removed save"
    }

    func callPlace() {
        lastActionMessage = "Calling \(featuredPlace.title)…"
    }

    func openSearch() {
        searchQuery = featuredPlace.title
        lastActionMessage = "Search opened"
    }

    func endNavigation() {
        isNavigating = false
        selectedTab = .explore
    }
}

// MARK: - Écrans showroom

private struct LpspGoogleMapsShowroomRoot: View {
    @ObservedObject var store: LpspGoogleMapsStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .explore:
                    LpspGoogleMapsSpectrHomeTabScreen(store: store)
                case .go:
                    LpspGoogleMapsGoTabScreen(store: store)
                case .saved:
                    LpspGoogleMapsSavedTabScreen(store: store)
                case .contribute:
                    LpspGoogleMapsContributeTabScreen()
                case .updates:
                    LpspGoogleMapsUpdatesTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspGoogleMapsLabeledTabBar(store: store)
        }
        .background(LpspGoogleMapsTokens.gmCanvas.ignoresSafeArea())
    }
}

private struct LpspGoogleMapsLabeledTabBar: View {
    @ObservedObject var store: LpspGoogleMapsStore

    var body: some View {
        HStack {
            ForEach(LpspGoogleMapsShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspGoogleMapsFonts.gmTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspGoogleMapsTokens.gmBlue
                            : LpspGoogleMapsTokens.gmTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspGoogleMapsTokens.gmCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspGoogleMapsTokens.gmDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspGoogleMapsShowroomMapCanvas: View {
    var body: some View {
        ZStack {
            Color(red: 0.961, green: 0.945, blue: 0.910)

            RoundedRectangle(cornerRadius: 4)
                .fill(LpspGoogleMapsTokens.gmParkGreen)
                .frame(width: 120, height: 80)
                .offset(x: -80, y: -120)

            RoundedRectangle(cornerRadius: 4)
                .fill(LpspGoogleMapsTokens.gmParkGreen)
                .frame(width: 90, height: 60)
                .offset(x: 100, y: -60)

            RoundedRectangle(cornerRadius: 4)
                .fill(LpspGoogleMapsTokens.gmWaterBlue)
                .frame(width: 140, height: 70)
                .offset(x: -40, y: 80)

            RoundedRectangle(cornerRadius: 2)
                .fill(LpspGoogleMapsTokens.gmHighwayYellow)
                .frame(width: 260, height: 10)
                .rotationEffect(.degrees(-12))

            RoundedRectangle(cornerRadius: 1)
                .fill(LpspGoogleMapsTokens.gmRoadWhite)
                .frame(width: 180, height: 6)
                .rotationEffect(.degrees(24))
                .shadow(color: .black.opacity(0.06), radius: 1, y: 1)

            RoundedRectangle(cornerRadius: 1)
                .fill(LpspGoogleMapsTokens.gmBuildingFill)
                .frame(width: 48, height: 36)
                .offset(x: 60, y: -20)

            RoundedRectangle(cornerRadius: 1)
                .fill(LpspGoogleMapsTokens.gmBuildingFill)
                .frame(width: 36, height: 28)
                .offset(x: -50, y: 30)

            LpspGoogleMapsGMLocationDot()
                .offset(y: 20)

            LpspGoogleMapsGMMapPin(kind: .default)
                .offset(y: -24)
        }
    }
}

private struct LpspGoogleMapsShowroomSearchBar: View {
    @ObservedObject var store: LpspGoogleMapsStore

    var body: some View {
        LpspGoogleMapsGMSearchBar(
            onTap: { store.openSearch() },
            onMic: { store.lastActionMessage = "Voice search" }
        )
    }
}

private struct LpspGoogleMapsShowroomPlaceSheet: View {
    @ObservedObject var store: LpspGoogleMapsStore

    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .fill(LpspGoogleMapsTokens.gmDivider)
                .frame(width: 36, height: 4)
                .padding(.top, 8)

            HStack(alignment: .top, spacing: 12) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LpspGoogleMapsTokens.gmSurfaceMuted)
                    .frame(width: 72, height: 72)

                VStack(alignment: .leading, spacing: 4) {
                    Text(store.featuredPlace.title)
                        .font(LpspGoogleMapsFonts.gmPlaceTitle.weight(.semibold))
                        .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)

                    HStack(spacing: 4) {
                        Text(String(format: "%.1f", store.featuredPlace.rating))
                            .font(LpspGoogleMapsFonts.gmRating)
                            .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: Double(index) < store.featuredPlace.rating ? "star.fill" : "star")
                                .font(.system(size: 12))
                                .foregroundStyle(LpspGoogleMapsTokens.gmYellow)
                        }
                        Text("(\(store.featuredPlace.reviewCount))")
                            .font(LpspGoogleMapsFonts.gmBody)
                            .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
                    }

                    Text("\(store.featuredPlace.category) · Open · \(store.featuredPlace.distance)")
                        .font(LpspGoogleMapsFonts.gmMeta)
                        .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
                }
            }
            .padding(.horizontal, 16)

            LpspGoogleMapsShowroomActionRow(store: store)
                .padding(.bottom, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspGoogleMapsTokens.gmCanvas)
                .shadow(color: .black.opacity(0.12), radius: 16, y: -4)
        )
    }
}

private struct LpspGoogleMapsShowroomActionRow: View {
    @ObservedObject var store: LpspGoogleMapsStore

    var body: some View {
        HStack(spacing: 12) {
            Button(action: { store.startDirections() }) {
                LpspGoogleMapsGMPillButton(
                    icon: "arrow.triangle.turn.up.right.diamond.fill",
                    title: "Directions",
                    filled: true
                )
            }
            .buttonStyle(.plain)

            Button(action: { store.callPlace() }) {
                LpspGoogleMapsGMPillButton(icon: "phone.fill", title: "Call", filled: false)
            }
            .buttonStyle(.plain)

            Button(action: { store.toggleSaveFeatured() }) {
                LpspGoogleMapsGMPillButton(
                    icon: store.featuredPlace.isSaved ? "bookmark.fill" : "bookmark",
                    title: "Save",
                    filled: false
                )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
    }
}

private struct LpspGoogleMapsSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspGoogleMapsStore

    var body: some View {
        ZStack(alignment: .bottom) {
            LpspGoogleMapsShowroomMapCanvas()
                .ignoresSafeArea()

            VStack {
                LpspGoogleMapsShowroomSearchBar(store: store)
                    .padding(.top, 8)
                Spacer()
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    LpspGoogleMapsGMDirectionsFAB {
                        store.startDirections()
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 180)
                }
            }

            LpspGoogleMapsShowroomPlaceSheet(store: store)
        }
    }
}

private struct LpspGoogleMapsGoTabScreen: View {
    @ObservedObject var store: LpspGoogleMapsStore

    var body: some View {
        ZStack {
            LpspGoogleMapsShowroomMapCanvas()
                .ignoresSafeArea()

            VStack {
                if store.isNavigating {
                    LpspGoogleMapsGMTurnCard(
                        instruction: "Turn right on Oak Street",
                        distance: "800 ft",
                        nextInstruction: "Turn left on Market Street"
                    )
                    .padding(.top, 16)
                } else {
                    VStack(spacing: 16) {
                        Text("Where to?")
                            .font(LpspGoogleMapsFonts.gmScreenTitle.weight(.bold))
                            .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                            .padding(.top, 24)

                        LpspGoogleMapsShowroomSearchBar(store: store)

                        Button(action: { store.startDirections() }) {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                Text(store.featuredPlace.title)
                            }
                            .font(LpspGoogleMapsFonts.gmButton)
                            .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LpspGoogleMapsTokens.gmSurfaceMuted)
                            )
                            .padding(.horizontal, 16)
                        }
                        .buttonStyle(.plain)
                    }
                }

                Spacer()

                if store.isNavigating {
                    Button("End navigation") {
                        store.endNavigation()
                    }
                    .font(LpspGoogleMapsFonts.gmButton.weight(.semibold))
                    .foregroundStyle(LpspGoogleMapsTokens.gmBlue)
                    .padding(.bottom, 16)
                }
            }
        }
    }
}

private struct LpspGoogleMapsSavedTabScreen: View {
    @ObservedObject var store: LpspGoogleMapsStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Saved")
                    .font(LpspGoogleMapsFonts.gmScreenTitle.weight(.bold))
                    .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                ForEach(store.savedPlaces) { place in
                    Button {
                        store.featuredPlace = place
                        store.selectedTab = .explore
                    } label: {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(LpspGoogleMapsTokens.gmBlue)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: place.id == "home" ? "house.fill" : "briefcase.fill")
                                        .foregroundStyle(.white)
                                )
                            VStack(alignment: .leading, spacing: 2) {
                                Text(place.title)
                                    .font(LpspGoogleMapsFonts.gmRowTitle.weight(.semibold))
                                    .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                                Text(place.distance)
                                    .font(LpspGoogleMapsFonts.gmMeta)
                                    .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(LpspGoogleMapsTokens.gmTextTertiary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(.plain)
                }

                if store.featuredPlace.isSaved,
                   !store.savedPlaces.contains(where: { $0.id == store.featuredPlace.id }) {
                    Text(store.featuredPlace.title)
                        .font(LpspGoogleMapsFonts.gmRowTitle)
                        .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspGoogleMapsContributeTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Contribute")
                    .font(LpspGoogleMapsFonts.gmScreenTitle.weight(.bold))
                    .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                ForEach(["Add a place", "Write a review", "Upload photos", "Fix the map"], id: \.self) { item in
                    HStack {
                        Circle()
                            .fill(LpspGoogleMapsTokens.gmSurfaceMuted)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundStyle(LpspGoogleMapsTokens.gmBlue)
                            )
                        Text(item)
                            .font(LpspGoogleMapsFonts.gmRowTitle)
                            .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspGoogleMapsUpdatesTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Updates")
                    .font(LpspGoogleMapsFonts.gmScreenTitle.weight(.bold))
                    .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                ForEach(LpspGoogleMapsShowroomData.updates, id: \.0) { update in
                    HStack(alignment: .top, spacing: 12) {
                        Circle()
                            .fill(LpspGoogleMapsTokens.gmBlue.opacity(0.12))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: "bell.fill")
                                    .foregroundStyle(LpspGoogleMapsTokens.gmBlue)
                            )
                        VStack(alignment: .leading, spacing: 2) {
                            Text(update.0)
                                .font(LpspGoogleMapsFonts.gmRowTitle.weight(.semibold))
                                .foregroundStyle(LpspGoogleMapsTokens.gmTextPrimary)
                            Text(update.1)
                                .font(LpspGoogleMapsFonts.gmMeta)
                                .foregroundStyle(LpspGoogleMapsTokens.gmTextSecondary)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
            }
            .padding(.bottom, 16)
        }
    }
}


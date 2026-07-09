import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/airbnb
// Meliwat/awesome-ios-design-md/travel/airbnb/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAirbnbView: View {
    var body: some View {
        LpspAirbnbShowroomRoot(store: LpspAirbnbStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspAirbnbFonts {
    static let airbnbLargeNav   = Font.system(size: 32, weight: .regular)
    static let airbnbHero       = Font.system(size: 26, weight: .regular)
    static let airbnbSection    = Font.system(size: 22, weight: .regular)
    static let airbnbSubsection = Font.system(size: 18, weight: .regular)
    static let airbnbCardTitle  = Font.system(size: 15, weight: .regular)
    static let airbnbBody       = Font.system(size: 16, weight: .regular)
    static let airbnbBodySmall  = Font.system(size: 14, weight: .regular)
    static let airbnbMeta       = Font.system(size: 14, weight: .regular)
    static let airbnbRatingNum  = Font.system(size: 14, weight: .regular)
    static let airbnbPriceInline = Font.system(size: 15, weight: .regular)
    static let airbnbPriceHero   = Font.system(size: 22, weight: .regular)
    static let airbnbButton     = Font.system(size: 16, weight: .regular)
    static let airbnbButtonSm   = Font.system(size: 14, weight: .regular)
    static let airbnbTab        = Font.system(size: 10, weight: .regular)
    static let airbnbChip       = Font.system(size: 12, weight: .regular)
    static let airbnbCaption    = Font.system(size: 12, weight: .regular)
    static func airbnb(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default) // SF Pro
    }
}

private enum LpspAirbnbTokens {
    // MARK: - Canvas & Surfaces
    static let airbnbCanvas       = Color(red: 1.00, green: 1.00, blue: 1.00)   // #FFFFFF
    static let airbnbSurfaceGray  = Color(red: 0.969, green: 0.969, blue: 0.969) // #F7F7F7
    static let airbnbSurfaceGray2 = Color(red: 0.922, green: 0.922, blue: 0.922) // #EBEBEB
    static let airbnbDivider      = Color(red: 0.922, green: 0.922, blue: 0.922) // #EBEBEB

    // MARK: - Text
    static let airbnbHof          = Color(red: 0.282, green: 0.282, blue: 0.282) // #484848 primary text
    static let airbnbFoggy        = Color(red: 0.463, green: 0.463, blue: 0.463) // #767676 secondary text
    static let airbnbFoggyLight   = Color(red: 0.690, green: 0.690, blue: 0.690) // #B0B0B0 tertiary
    static let airbnbInk          = Color(red: 0.133, green: 0.133, blue: 0.133) // #222222 hero titles

    // MARK: - Brand
    static let airbnbCoral        = Color(red: 1.00, green: 0.220, blue: 0.361)  // #FF385C primary
    static let airbnbCoralPressed = Color(red: 0.890, green: 0.110, blue: 0.373) // #E31C5F
    static let airbnbRausch       = Color(red: 1.00, green: 0.353, blue: 0.373)  // #FF5A5F heritage
    static let airbnbBabu         = Color(red: 0.00, green: 0.651, blue: 0.600)  // #00A699 Plus / Experiences
    static let airbnbArches       = Color(red: 0.988, green: 0.392, blue: 0.176) // #FC642D Trips
    static let airbnbBeach        = Color(red: 1.00, green: 0.706, blue: 0.00)   // #FFB400 star yellow

    // MARK: - Semantic
    static let airbnbSuccess      = Color(red: 0.00, green: 0.541, blue: 0.020)  // #008A05
    static let airbnbError        = Color(red: 0.757, green: 0.208, blue: 0.082) // #C13515

    // MARK: - Dark mode
    static let airbnbDarkCanvas   = Color(red: 0.071, green: 0.071, blue: 0.071) // #121212
    static let airbnbDarkSurface  = Color(red: 0.110, green: 0.110, blue: 0.118) // #1C1C1E
    static let airbnbDarkText     = Color(red: 0.867, green: 0.867, blue: 0.867) // #DDDDDD
    static let airbnbDarkTextSec  = Color(red: 0.627, green: 0.627, blue: 0.627) // #A0A0A0
}



// If Cereal isn't bundled, this fallback keeps the warm system substitute:


fileprivate struct LpspAirbnbSaveHeart: View {
    @Binding var isSaved: Bool

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isSaved.toggle()
            }
        } label: {
            Image(systemName: isSaved ? "heart.fill" : "heart")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(isSaved ? LpspAirbnbTokens.airbnbCoral : .white)
                .overlay(
                    Image(systemName: "heart")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(isSaved ? .clear : LpspAirbnbTokens.airbnbInk)
                )
                .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
                .frame(width: 32, height: 32)
                .contentShape(Rectangle().inset(by: -12)) // 44pt hit area
                .scaleEffect(isSaved ? 1 : 1)
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isSaved)
    }
}

fileprivate struct LpspAirbnbRatingRow: View {
    let rating: Double
    let reviewCount: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundStyle(LpspAirbnbTokens.airbnbHof)
            Text(String(format: "%.2f", rating))
                .font(LpspAirbnbFonts.airbnbRatingNum)
                .foregroundStyle(LpspAirbnbTokens.airbnbHof)
            Text(" · \(reviewCount.formatted())")
                .font(LpspAirbnbFonts.airbnbMeta)
                .foregroundStyle(LpspAirbnbTokens.airbnbFoggy)
        }
    }
}

fileprivate struct LpspAirbnbStayCard: View {
    let photos: [Image]
    let title: String
    let host: String
    let dates: String
    let pricePerNight: Int
    let rating: Double
    let reviewCount: Int
    @State private var isSaved = false
    @State private var currentPhoto = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Photo carousel w/ save heart overlay
            TabView(selection: $currentPhoto) {
                ForEach(Array(photos.enumerated()), id: \.offset) { idx, photo in
                    photo
                        .resizable()
                        .aspectRatio(4/3, contentMode: .fill)
                        .tag(idx)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .aspectRatio(4/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(alignment: .topTrailing) {
                LpspAirbnbSaveHeart(isSaved: $isSaved)
                    .padding(12)
            }

            // Rating row
            LpspAirbnbRatingRow(rating: rating, reviewCount: reviewCount)
                .padding(.top, 8)

            // Title
            Text(title)
                .font(LpspAirbnbFonts.airbnbCardTitle)
                .foregroundStyle(LpspAirbnbTokens.airbnbHof)
                .lineLimit(1)
                .padding(.top, 2)

            // Host subtitle
            Text(host)
                .font(LpspAirbnbFonts.airbnbMeta)
                .foregroundStyle(LpspAirbnbTokens.airbnbFoggy)
                .lineLimit(1)
                .padding(.top, 2)

            // Dates
            Text(dates)
                .font(LpspAirbnbFonts.airbnbMeta)
                .foregroundStyle(LpspAirbnbTokens.airbnbFoggy)
                .padding(.top, 6)

            // Price
            HStack(spacing: 4) {
                Text("$\(pricePerNight)")
                    .font(LpspAirbnbFonts.airbnbPriceInline)
                    .foregroundStyle(LpspAirbnbTokens.airbnbHof)
                Text("night")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(LpspAirbnbTokens.airbnbHof)
            }
            .padding(.top, 4)
        }
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspAirbnbSearchPill: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(LpspAirbnbTokens.airbnbInk)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Where to?")
                        .font(.custom("AirbnbCereal-Bold", size: 14))
                        .foregroundStyle(LpspAirbnbTokens.airbnbInk)
                    Text("Anywhere · Any week · Add guests")
                        .font(.custom("AirbnbCereal-Book", size: 12))
                        .foregroundStyle(LpspAirbnbTokens.airbnbFoggy)
                }
                Spacer()
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(LpspAirbnbTokens.airbnbInk)
                    .padding(10)
                    .overlay(Circle().stroke(LpspAirbnbTokens.airbnbDivider, lineWidth: 1))
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .background(
                Capsule()
                    .fill(LpspAirbnbTokens.airbnbCanvas)
                    .overlay(Capsule().stroke(LpspAirbnbTokens.airbnbDivider, lineWidth: 0.5))
                    .shadow(color: .black.opacity(0.08), radius: 12, y: 4)
                    .shadow(color: .black.opacity(0.04), radius: 2, y: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspAirbnbCategoryBar: View {
    let categories: [(icon: String, label: String)]
    @Binding var selected: Int
    @Namespace private var underlineNS

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(Array(categories.enumerated()), id: \.offset) { idx, cat in
                    VStack(spacing: 8) {
                        Image(systemName: cat.icon)
                            .font(.system(size: 24))
                            .foregroundStyle(selected == idx ? LpspAirbnbTokens.airbnbInk : Color(red: 0.443, green: 0.443, blue: 0.443))
                        Text(cat.label)
                            .font(LpspAirbnbFonts.airbnbChip)
                            .foregroundStyle(selected == idx ? LpspAirbnbTokens.airbnbInk : Color(red: 0.443, green: 0.443, blue: 0.443))
                        if selected == idx {
                            Rectangle()
                                .fill(LpspAirbnbTokens.airbnbInk)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "underline", in: underlineNS)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                            selected = idx
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 72)
        .background(LpspAirbnbTokens.airbnbCanvas)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspAirbnbTokens.airbnbDivider).frame(height: 0.5)
        }
    }
}

fileprivate struct LpspAirbnbBookingFooter: View {
    let totalPrice: Int
    let dateRange: String
    var onReserve: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("$\(totalPrice)")
                        .font(.custom("AirbnbCereal-Bold", size: 16))
                        .foregroundStyle(LpspAirbnbTokens.airbnbInk)
                    Text("total")
                        .font(LpspAirbnbFonts.airbnbBodySmall)
                        .foregroundStyle(LpspAirbnbTokens.airbnbInk)
                }
                Text(dateRange)
                    .font(LpspAirbnbFonts.airbnbBodySmall)
                    .foregroundStyle(LpspAirbnbTokens.airbnbInk)
                    .underline()
            }
            Spacer()
            Button(action: onReserve) {
                Text("Reserve")
                    .font(LpspAirbnbFonts.airbnbButton)
                    .foregroundStyle(.white)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 28)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LpspAirbnbTokens.airbnbCoral)
                    )
            }
            .sensoryFeedback(.impact(weight: .medium), trigger: UUID())
        }
        .padding(.horizontal, 24)
        .frame(height: 80)
        .background(.regularMaterial)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspAirbnbTokens.airbnbDivider).frame(height: 0.5)
        }
    }
}

fileprivate struct LpspAirbnbMapPriceBubble: View {
    let price: Int
    var state: LpspAirbnbBubbleState = .default

    enum LpspAirbnbBubbleState { case `default`, visited, selected }

    var bg: Color {
        switch state {
        case .default:  return .white
        case .visited:  return LpspAirbnbTokens.airbnbInk
        case .selected: return LpspAirbnbTokens.airbnbCoral
        }
    }
    var fg: Color {
        state == .default ? LpspAirbnbTokens.airbnbInk : .white
    }

    var body: some View {
        Text("$\(price)")
            .font(.custom("AirbnbCereal-Bold", size: 14))
            .foregroundStyle(fg)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 12).fill(bg)
            )
            .shadow(color: .black.opacity(0.2), radius: 6, y: 2)
    }
}



// MARK: - Showroom data & store

private enum LpspAirbnbShowroomTab: String, CaseIterable, Identifiable {
    case explore, wishlists, trips, inbox, profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .explore: "Explore"
        case .wishlists: "Wishlists"
        case .trips: "Trips"
        case .inbox: "Inbox"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .explore: "magnifyingglass"
        case .wishlists: "heart.fill"
        case .trips: "paperplane.fill"
        case .inbox: "message.fill"
        case .profile: "person.crop.circle.fill"
        }
    }
}

private struct LpspAirbnbStay: Identifiable, Equatable {
    let id: String
    let title: String
    let host: String
    let dates: String
    let pricePerNight: Int
    let totalPrice: Int
    let rating: Double
    let reviewCount: Int
    let photoCount: Int
    let categories: [String]
    let photoColors: [Color]
    var isSaved: Bool
}

private enum LpspAirbnbShowroomData {
    static let searchTop = "Where to?"
    static let searchSub = "Anywhere · Any week · Add guests"

    static let categories: [(icon: String, label: String)] = [
        ("house.fill", "Cabins"),
        ("mountain.2.fill", "Amazing views"),
        ("leaf.fill", "Tropical"),
        ("water.waves", "Beachfront"),
        ("paintpalette.fill", "Design"),
        ("building.columns.fill", "Mansions"),
    ]

    static let stays: [LpspAirbnbStay] = [
        LpspAirbnbStay(
            id: "reykjavik",
            title: "Private room in Reykjavík",
            host: "Hosted by Sigrún · Superhost",
            dates: "Oct 12 – 17",
            pricePerNight: 214,
            totalPrice: 1070,
            rating: 4.92,
            reviewCount: 324,
            photoCount: 5,
            categories: ["Cabins"],
            photoColors: [
                Color(red: 0.42, green: 0.62, blue: 0.82),
                Color(red: 0.28, green: 0.48, blue: 0.72),
            ],
            isSaved: true
        ),
        LpspAirbnbStay(
            id: "joshua-tree",
            title: "Dome in Joshua Tree",
            host: "Hosted by Marion · 3 yrs hosting",
            dates: "Nov 3 – 8",
            pricePerNight: 326,
            totalPrice: 1630,
            rating: 4.87,
            reviewCount: 1284,
            photoCount: 4,
            categories: ["Amazing views", "Design"],
            photoColors: [
                Color(red: 0.82, green: 0.58, blue: 0.32),
                Color(red: 0.52, green: 0.32, blue: 0.18),
            ],
            isSaved: false
        ),
    ]

    static let inboxMessages = [
        ("Sigrún", "Your check-in details for Reykjavík"),
        ("Airbnb", "Reminder: review your stay"),
    ]
}

@MainActor
fileprivate final class LpspAirbnbStore: ObservableObject {
    @Published var selectedTab: LpspAirbnbShowroomTab = .explore
    @Published var selectedCategoryIndex = 0
    @Published var stays: [LpspAirbnbStay] = LpspAirbnbShowroomData.stays
    @Published var selectedStayID: String?
    @Published var showReserveSheet = false
    @Published var bookedStayIDs: [String] = []
    @Published var lastActionMessage = ""

    var savedStays: [LpspAirbnbStay] {
        stays.filter(\.isSaved)
    }

    func openSearch() {
        lastActionMessage = "Search opened"
        selectedTab = .explore
    }

    func openFilters() {
        lastActionMessage = "Filters opened"
    }

    func selectCategory(_ index: Int) {
        selectedCategoryIndex = index
    }

    func toggleSave(_ stayID: String) {
        guard let index = stays.firstIndex(where: { $0.id == stayID }) else { return }
        var updated = stays[index]
        updated.isSaved.toggle()
        stays[index] = updated
        lastActionMessage = updated.isSaved ? "Saved \(updated.title)" : "Removed save"
    }

    func selectStay(_ stay: LpspAirbnbStay) {
        selectedStayID = stay.id
        showReserveSheet = true
    }

    func reserveSelectedStay() {
        guard let id = selectedStayID,
              let stay = stays.first(where: { $0.id == id }) else { return }
        if !bookedStayIDs.contains(id) {
            bookedStayIDs.append(id)
        }
        showReserveSheet = false
        lastActionMessage = "Reserved \(stay.title)"
        selectedTab = .trips
    }

    func filteredStays() -> [LpspAirbnbStay] {
        let label = LpspAirbnbShowroomData.categories[selectedCategoryIndex].label
        if label == "Cabins" { return stays }
        return stays.filter { $0.categories.contains(label) }
    }
}

// MARK: - Écrans showroom

private struct LpspAirbnbShowroomRoot: View {
    @ObservedObject var store: LpspAirbnbStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .explore:
                    LpspAirbnbSpectrHomeTabScreen(store: store)
                case .wishlists:
                    LpspAirbnbWishlistsTabScreen(store: store)
                case .trips:
                    LpspAirbnbTripsTabScreen(store: store)
                case .inbox:
                    LpspAirbnbInboxTabScreen()
                case .profile:
                    LpspAirbnbProfileTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspAirbnbLabeledTabBar(store: store)
        }
        .background(LpspAirbnbTokens.airbnbDarkCanvas.ignoresSafeArea())
        .sheet(isPresented: $store.showReserveSheet) {
            if let id = store.selectedStayID,
               let stay = store.stays.first(where: { $0.id == id }) {
                LpspAirbnbReserveSheet(store: store, stay: stay)
            }
        }
    }
}

private struct LpspAirbnbLabeledTabBar: View {
    @ObservedObject var store: LpspAirbnbStore

    var body: some View {
        HStack {
            ForEach(LpspAirbnbShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspAirbnbFonts.airbnbTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspAirbnbTokens.airbnbCoral
                            : LpspAirbnbTokens.airbnbDarkTextSec
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspAirbnbTokens.airbnbDarkCanvas
                .overlay(
                    Rectangle()
                        .fill(Color(red: 0.173, green: 0.173, blue: 0.180))
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspAirbnbShowroomSearchPill: View {
    @ObservedObject var store: LpspAirbnbStore

    var body: some View {
        Button {
            store.openSearch()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                VStack(alignment: .leading, spacing: 2) {
                    Text(LpspAirbnbShowroomData.searchTop)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                    Text(LpspAirbnbShowroomData.searchSub)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
                }
                Spacer()
                Button {
                    store.openFilters()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                        .padding(10)
                        .overlay(
                            Circle()
                                .stroke(Color(red: 0.173, green: 0.173, blue: 0.180), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .background(
                Capsule()
                    .fill(Color(red: 0.165, green: 0.165, blue: 0.165))
                    .shadow(color: .black.opacity(0.25), radius: 12, y: 4)
            )
        }
        .buttonStyle(.plain)
    }
}

private struct LpspAirbnbShowroomCategoryBar: View {
    @ObservedObject var store: LpspAirbnbStore
    @Namespace private var underlineNS

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(Array(LpspAirbnbShowroomData.categories.enumerated()), id: \.offset) { idx, cat in
                    let isSelected = store.selectedCategoryIndex == idx
                    VStack(spacing: 8) {
                        Image(systemName: cat.icon)
                            .font(.system(size: 24))
                            .foregroundStyle(isSelected ? LpspAirbnbTokens.airbnbDarkText : LpspAirbnbTokens.airbnbDarkTextSec)
                        Text(cat.label)
                            .font(LpspAirbnbFonts.airbnbChip)
                            .foregroundStyle(isSelected ? LpspAirbnbTokens.airbnbDarkText : LpspAirbnbTokens.airbnbDarkTextSec)
                        if isSelected {
                            Rectangle()
                                .fill(LpspAirbnbTokens.airbnbDarkText)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "underline", in: underlineNS)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                            store.selectCategory(idx)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 72)
    }
}

private struct LpspAirbnbShowroomRatingRow: View {
    let rating: Double
    let reviewCount: Int

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
            Text(String(format: "%.2f", rating))
                .font(LpspAirbnbFonts.airbnbRatingNum)
                .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
            Text(" · \(reviewCount.formatted())")
                .font(LpspAirbnbFonts.airbnbMeta)
                .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
        }
    }
}

private struct LpspAirbnbShowroomStayCard: View {
    let stay: LpspAirbnbStay
    let isSaved: Bool
    let onTap: () -> Void
    let onSave: () -> Void
    @State private var currentPhoto = 0

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    LinearGradient(
                        colors: stay.photoColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .aspectRatio(4/3, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(alignment: .bottom) {
                        HStack(spacing: 5) {
                            ForEach(0..<stay.photoCount, id: \.self) { idx in
                                Circle()
                                    .fill(idx == currentPhoto ? Color.white : Color.white.opacity(0.45))
                                    .frame(width: 6, height: 6)
                            }
                        }
                        .padding(.bottom, 10)
                    }

                    Button(action: onSave) {
                        Image(systemName: isSaved ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(isSaved ? LpspAirbnbTokens.airbnbCoral : .white)
                            .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
                            .frame(width: 32, height: 32)
                    }
                    .buttonStyle(.plain)
                    .padding(12)
                }

                LpspAirbnbShowroomRatingRow(rating: stay.rating, reviewCount: stay.reviewCount)
                    .padding(.top, 8)

                Text(stay.title)
                    .font(LpspAirbnbFonts.airbnbCardTitle)
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                    .lineLimit(1)
                    .padding(.top, 2)

                Text(stay.host)
                    .font(LpspAirbnbFonts.airbnbMeta)
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
                    .lineLimit(1)
                    .padding(.top, 2)

                Text(stay.dates)
                    .font(LpspAirbnbFonts.airbnbMeta)
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
                    .padding(.top, 6)

                HStack(spacing: 4) {
                    Text("$\(stay.pricePerNight)")
                        .font(LpspAirbnbFonts.airbnbPriceInline.weight(.semibold))
                        .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                    Text("night")
                        .font(LpspAirbnbFonts.airbnbPriceInline)
                        .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                }
                .padding(.top, 4)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct LpspAirbnbSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspAirbnbStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                LpspAirbnbShowroomSearchPill(store: store)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                LpspAirbnbShowroomCategoryBar(store: store)

                ForEach(store.filteredStays()) { stay in
                    LpspAirbnbShowroomStayCard(
                        stay: stay,
                        isSaved: stay.isSaved,
                        onTap: { store.selectStay(stay) },
                        onSave: { store.toggleSave(stay.id) }
                    )
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspAirbnbWishlistsTabScreen: View {
    @ObservedObject var store: LpspAirbnbStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Wishlists")
                    .font(LpspAirbnbFonts.airbnbSection.weight(.bold))
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                if store.savedStays.isEmpty {
                    Text("Save places you like by tapping the heart icon.")
                        .font(LpspAirbnbFonts.airbnbBody)
                        .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
                        .padding(.horizontal, 16)
                } else {
                    ForEach(store.savedStays) { stay in
                        LpspAirbnbShowroomStayCard(
                            stay: stay,
                            isSaved: stay.isSaved,
                            onTap: { store.selectStay(stay) },
                            onSave: { store.toggleSave(stay.id) }
                        )
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspAirbnbTripsTabScreen: View {
    @ObservedObject var store: LpspAirbnbStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Trips")
                    .font(LpspAirbnbFonts.airbnbSection.weight(.bold))
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                if store.bookedStayIDs.isEmpty {
                    Text("Your upcoming trips will appear here.")
                        .font(LpspAirbnbFonts.airbnbBody)
                        .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
                        .padding(.horizontal, 16)
                } else {
                    ForEach(store.bookedStayIDs, id: \.self) { id in
                        if let stay = store.stays.first(where: { $0.id == id }) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(stay.title)
                                    .font(LpspAirbnbFonts.airbnbCardTitle.weight(.semibold))
                                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                                Text(stay.dates)
                                    .font(LpspAirbnbFonts.airbnbMeta)
                                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
                                Text("$\(stay.totalPrice) total")
                                    .font(LpspAirbnbFonts.airbnbPriceInline.weight(.bold))
                                    .foregroundStyle(LpspAirbnbTokens.airbnbCoral)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LpspAirbnbTokens.airbnbDarkSurface)
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

private struct LpspAirbnbInboxTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Inbox")
                    .font(LpspAirbnbFonts.airbnbSection.weight(.bold))
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                ForEach(LpspAirbnbShowroomData.inboxMessages, id: \.0) { sender, preview in
                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspAirbnbTokens.airbnbCoral.opacity(0.25))
                            .frame(width: 44, height: 44)
                            .overlay(
                                Text(String(sender.prefix(1)))
                                    .font(LpspAirbnbFonts.airbnbBody.weight(.semibold))
                                    .foregroundStyle(LpspAirbnbTokens.airbnbCoral)
                            )
                        VStack(alignment: .leading, spacing: 2) {
                            Text(sender)
                                .font(LpspAirbnbFonts.airbnbBody.weight(.semibold))
                                .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)
                            Text(preview)
                                .font(LpspAirbnbFonts.airbnbMeta)
                                .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
                                .lineLimit(1)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspAirbnbProfileTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Circle()
                    .fill(LpspAirbnbTokens.airbnbCoral.gradient)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(.white)
                    )

                Text("Guest")
                    .font(LpspAirbnbFonts.airbnbSection.weight(.bold))
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkText)

                Text("Show profile")
                    .font(LpspAirbnbFonts.airbnbBody)
                    .foregroundStyle(LpspAirbnbTokens.airbnbDarkTextSec)
            }
            .padding(.vertical, 32)
        }
    }
}

private struct LpspAirbnbReserveSheet: View {
    @ObservedObject var store: LpspAirbnbStore
    let stay: LpspAirbnbStay
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: stay.photoColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .aspectRatio(4/3, contentMode: .fit)

                Text(stay.title)
                    .font(LpspAirbnbFonts.airbnbCardTitle.weight(.bold))
                    .foregroundStyle(LpspAirbnbTokens.airbnbInk)

                Text(stay.host)
                    .font(LpspAirbnbFonts.airbnbMeta)
                    .foregroundStyle(LpspAirbnbTokens.airbnbFoggy)

                LpspAirbnbRatingRow(rating: stay.rating, reviewCount: stay.reviewCount)

                Spacer()

                LpspAirbnbBookingFooter(
                    totalPrice: stay.totalPrice,
                    dateRange: stay.dates,
                    onReserve: {
                        store.reserveSelectedStay()
                        dismiss()
                    }
                )
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .background(LpspAirbnbTokens.airbnbCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
        .presentationDetents([.large])
    }
}



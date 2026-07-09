import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/booking
// Meliwat/awesome-ios-design-md/travel/booking/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeBookingView: View {
    var body: some View {
        LpspBookingShowroomRoot(store: LpspBookingStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspBookingFonts {
    static let bkScreenTitle = Font.system(size: 22, weight: .regular)
    static let bkSection     = Font.system(size: 18, weight: .regular)
    static let bkPropName    = Font.system(size: 17, weight: .regular)
    static let bkPrice       = Font.system(size: 17, weight: .regular)
    static let bkScoreNum    = Font.system(size: 15, weight: .regular)
    static let bkBody        = Font.system(size: 15, weight: .regular)
    static let bkButton      = Font.system(size: 16, weight: .regular)
    static let bkScoreWord   = Font.system(size: 14, weight: .regular)
    static let bkMeta        = Font.system(size: 13, weight: .regular)
    static let bkTag         = Font.system(size: 12, weight: .regular)
    static let bkTab         = Font.system(size: 11, weight: .regular)
    static let bkCaption     = Font.system(size: 11, weight: .regular)
    static func bk(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspBookingTokens {
    // MARK: - Canvas & Surfaces
    static let bkCanvas      = Color.white                                  // #FFFFFF
    static let bkSurface     = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
    static let bkSurfaceDeep = Color(red: 0.902, green: 0.902, blue: 0.902) // #E6E6E6
    static let bkDivider     = Color(red: 0.878, green: 0.878, blue: 0.878) // #E0E0E0

    // MARK: - Text
    static let bkTextPrimary   = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let bkTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420) // #6B6B6B
    static let bkTextTertiary  = Color(red: 0.580, green: 0.580, blue: 0.580) // #949494

    // MARK: - Brand
    static let bkBlue         = Color(red: 0.0,   green: 0.208, blue: 0.502) // #003580
    static let bkCTA          = Color(red: 0.0,   green: 0.443, blue: 0.761) // #0071C2
    static let bkCTAPressed   = Color(red: 0.0,   green: 0.353, blue: 0.612) // #005A9C
    static let bkBlueTint     = Color(red: 0.906, green: 0.941, blue: 0.969) // #E7F0F7
    static let bkYellow       = Color(red: 0.996, green: 0.733, blue: 0.008) // #FEBB02

    // MARK: - Semantic
    static let bkSuccess = Color(red: 0.0,   green: 0.502, blue: 0.035) // #008009
    static let bkDeal    = Color(red: 0.8,   green: 0.0,   blue: 0.0)   // #CC0000
    static let bkWarning = Color(red: 0.961, green: 0.651, blue: 0.137) // #F5A623
}





fileprivate struct LpspBookingReviewScoreBadge: View {
    let score: Double          // 8.9
    let reviews: Int           // 1284

    private var word: String {
        switch score {
        case 9...:   "Superb"
        case 8..<9:  "Fabulous"
        case 7..<8:  "Very good"
        case 6..<7:  "Good"
        default:     "Pleasant"
        }
    }

    var body: some View {
        HStack(spacing: 6) {
            Text(String(format: "%.1f", score))   // always one decimal
                .font(LpspBookingFonts.bkScoreNum).monospacedDigit()
                .foregroundStyle(.white)
                .padding(.horizontal, 7).padding(.vertical, 4)
                .background(RoundedRectangle(cornerRadius: 5).fill(LpspBookingTokens.bkBlue))
            Text(word)
                .font(LpspBookingFonts.bkScoreWord)
                .foregroundStyle(LpspBookingTokens.bkTextPrimary)
            Text("· \(reviews.formatted()) reviews")
                .font(LpspBookingFonts.bkTag).fontWeight(.regular)
                .foregroundStyle(LpspBookingTokens.bkTextSecondary)
        }
    }
}

fileprivate struct LpspBookingPropertyCard: View {
    let photo: Image
    let name: String
    let area: String
    let distance: String
    let score: Double
    let reviews: Int
    let originalPrice: String?
    let price: String
    let scarcity: String?

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            photo
                .resizable().scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(name).font(LpspBookingFonts.bkPropName).foregroundStyle(LpspBookingTokens.bkTextPrimary).lineLimit(2)
                HStack(spacing: 6) {
                    Text(area).font(LpspBookingFonts.bkMeta).foregroundStyle(LpspBookingTokens.bkCTA)
                    Text(distance).font(LpspBookingFonts.bkMeta).foregroundStyle(LpspBookingTokens.bkTextSecondary)
                }
                Text("Free cancellation")
                    .font(LpspBookingFonts.bkMeta).foregroundStyle(LpspBookingTokens.bkSuccess)
                LpspBookingReviewScoreBadge(score: score, reviews: reviews)

                Spacer(minLength: 4)

                VStack(alignment: .trailing, spacing: 1) {
                    if let originalPrice {
                        Text(originalPrice)
                            .font(LpspBookingFonts.bkMeta).strikethrough()
                            .foregroundStyle(LpspBookingTokens.bkTextTertiary)
                    }
                    Text(price).font(LpspBookingFonts.bkPrice).monospacedDigit()
                        .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                    Text("Includes taxes and fees")
                        .font(LpspBookingFonts.bkCaption).foregroundStyle(LpspBookingTokens.bkTextSecondary)
                    if let scarcity {
                        Text(scarcity)
                            .font(LpspBookingFonts.bkTag).foregroundStyle(LpspBookingTokens.bkDeal)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8).fill(LpspBookingTokens.bkCanvas)
                .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(LpspBookingTokens.bkDivider, lineWidth: 1))
        )
    }
}

fileprivate struct LpspBookingBookingCTA: View {
    let label: String     // "Search" / "Reserve"
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspBookingFonts.bkButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(RoundedRectangle(cornerRadius: 8).fill(LpspBookingTokens.bkCTA))
        }
        .buttonStyle(LpspBookingBKPressableStyle())
    }
}

fileprivate struct LpspBookingBKPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .brightness(configuration.isPressed ? -0.04 : 0)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspBookingSearchFormCard: View {
    var body: some View {
        VStack(spacing: 0) {
            LpspBookingFormRow(system: "mappin.and.ellipse", text: "Where are you going?")
            Divider().overlay(LpspBookingTokens.bkDivider)
            LpspBookingFormRow(system: "calendar", text: "Fri 12 Jul — Sun 14 Jul")
            Divider().overlay(LpspBookingTokens.bkDivider)
            LpspBookingFormRow(system: "person", text: "2 adults · 0 children · 1 room")
            LpspBookingBookingCTA(label: "Search") {}
                .padding(.top, 12)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8).fill(LpspBookingTokens.bkCanvas)
                .shadow(color: LpspBookingTokens.bkTextPrimary.opacity(0.08), radius: 6, y: 2)
        )
    }

    struct LpspBookingFormRow: View {
        let system: String
        let text: String
        var body: some View {
            HStack(spacing: 10) {
                Image(systemName: system)
                    .font(.system(size: 18)).foregroundStyle(LpspBookingTokens.bkTextSecondary).frame(width: 22)
                Text(text).font(LpspBookingFonts.bkBody).foregroundStyle(LpspBookingTokens.bkTextPrimary)
                Spacer()
            }
            .frame(height: 52)
        }
    }
}

fileprivate struct LpspBookingGeniusBanner: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Genius").font(LpspBookingFonts.bkPropName).foregroundStyle(.white)
                Text("You're a Genius level 1 member — enjoy 10% off")
                    .font(LpspBookingFonts.bkMeta).foregroundStyle(.white.opacity(0.9))
            }
            Spacer()
            Text("10% off")
                .font(LpspBookingFonts.bkTag).foregroundStyle(LpspBookingTokens.bkBlue)
                .padding(.horizontal, 8).padding(.vertical, 4)
                .background(Capsule().fill(LpspBookingTokens.bkYellow))
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 8).fill(LpspBookingTokens.bkBlue))
    }
}

fileprivate struct LpspBookingFilterChip: View {
    let label: String
    let isSelected: Bool
    let tap: () -> Void
    var body: some View {
        Button(action: tap) {
            Text(label)
                .font(LpspBookingFonts.bkTag)
                .fontWeight(isSelected ? .bold : .semibold)
                .foregroundStyle(isSelected ? LpspBookingTokens.bkCTA : LpspBookingTokens.bkTextPrimary)
                .padding(.horizontal, 16).padding(.vertical, 8)
                .background(Capsule().fill(isSelected ? LpspBookingTokens.bkBlueTint : LpspBookingTokens.bkCanvas))
                .overlay(
                    Capsule().strokeBorder(isSelected ? LpspBookingTokens.bkCTA : LpspBookingTokens.bkDivider,
                                           lineWidth: isSelected ? 1.5 : 1)
                )
        }
        .buttonStyle(.plain)
        .animation(.easeOut(duration: 0.15), value: isSelected)
    }
}

fileprivate struct LpspBookingPricePin: View {
    let price: String
    let isSelected: Bool
    var body: some View {
        Text(price)
            .font(LpspBookingFonts.bk(13, weight: .bold)).monospacedDigit()
            .foregroundStyle(isSelected ? .white : LpspBookingTokens.bkTextPrimary)
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(Capsule().fill(isSelected ? LpspBookingTokens.bkBlue : LpspBookingTokens.bkCanvas))
            .shadow(color: LpspBookingTokens.bkTextPrimary.opacity(0.16), radius: 6, y: 2)
            .scaleEffect(isSelected ? 1.12 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isSelected)
    }
}
// A "Map"/"List" pill toggle floats above the list; selecting a pin slides a single
// LpspBookingPropertyCard up from the bottom (a .sheet at a low detent or a bottom overlay).



// MARK: - Showroom data & store

private enum LpspBookingShowroomTab: String, CaseIterable, Identifiable {
    case search, saved, bookings, profile, help

    var id: String { rawValue }

    var title: String {
        switch self {
        case .search: "Search"
        case .saved: "Saved"
        case .bookings: "Bookings"
        case .profile: "Profile"
        case .help: "Help"
        }
    }

    var icon: String {
        switch self {
        case .search: "magnifyingglass"
        case .saved: "heart.fill"
        case .bookings: "suitcase.fill"
        case .profile: "person.fill"
        case .help: "questionmark.circle.fill"
        }
    }
}

private struct LpspBookingProperty: Identifiable, Equatable {
    let id: String
    let name: String
    let area: String
    let distance: String
    let policy: String
    let score: Double
    let reviews: Int
    let originalPrice: String?
    let price: String
    let scarcity: String?
    let photoColors: [Color]
    var isSaved: Bool
}

private enum LpspBookingShowroomData {
    static let destination = "Lisbon, Portugal"
    static let shortDestination = "Lisbon"
    static let dates = "Fri 12 Jul — Sun 14 Jul"
    static let guests = "2 adults · 0 children · 1 room"
    static let appBarSubtitle = "Fri 12 Jul — Sun 14 Jul · 2 adults"

    static let properties: [LpspBookingProperty] = [
        LpspBookingProperty(
            id: "grand-plaza",
            name: "Grand Plaza Hotel",
            area: "City centre",
            distance: "· 0.5 km from centre",
            policy: "Free cancellation",
            score: 8.9,
            reviews: 1284,
            originalPrice: "$240",
            price: "$198",
            scarcity: "Only 2 rooms left",
            photoColors: [
                Color(red: 0.22, green: 0.42, blue: 0.72),
                Color(red: 0.12, green: 0.28, blue: 0.52),
            ],
            isSaved: false
        ),
        LpspBookingProperty(
            id: "riverside",
            name: "Riverside Boutique Inn",
            area: "Alfama",
            distance: "· 1.2 km from centre",
            policy: "Breakfast included",
            score: 9.2,
            reviews: 642,
            originalPrice: nil,
            price: "$164",
            scarcity: nil,
            photoColors: [
                Color(red: 0.82, green: 0.48, blue: 0.28),
                Color(red: 0.52, green: 0.28, blue: 0.18),
            ],
            isSaved: false
        ),
    ]

    static let filters = ["Popular filters", "Free cancellation", "Breakfast included", "Hotels"]
}

@MainActor
fileprivate final class LpspBookingStore: ObservableObject {
    @Published var selectedTab: LpspBookingShowroomTab = .search
    @Published var properties: [LpspBookingProperty] = LpspBookingShowroomData.properties
    @Published var selectedFilter = LpspBookingShowroomData.filters[0]
    @Published var selectedPropertyID: String?
    @Published var showReserveSheet = false
    @Published var bookedPropertyIDs: [String] = []
    @Published var lastActionMessage = ""

    var savedProperties: [LpspBookingProperty] {
        properties.filter(\.isSaved)
    }

    func search() {
        lastActionMessage = "Showing stays in \(LpspBookingShowroomData.shortDestination)"
        selectedTab = .search
    }

    func setFilter(_ filter: String) {
        selectedFilter = filter
    }

    func toggleSave(_ propertyID: String) {
        guard let index = properties.firstIndex(where: { $0.id == propertyID }) else { return }
        properties[index].isSaved.toggle()
        lastActionMessage = properties[index].isSaved ? "Saved \(properties[index].name)" : "Removed save"
    }

    func selectProperty(_ property: LpspBookingProperty) {
        selectedPropertyID = property.id
        showReserveSheet = true
    }

    func reserveSelectedProperty() {
        guard let id = selectedPropertyID,
              let property = properties.first(where: { $0.id == id }) else { return }
        if !bookedPropertyIDs.contains(id) {
            bookedPropertyIDs.append(id)
        }
        showReserveSheet = false
        lastActionMessage = "Reserved \(property.name)"
        selectedTab = .bookings
    }
}

// MARK: - Écrans showroom

private struct LpspBookingShowroomRoot: View {
    @ObservedObject var store: LpspBookingStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .search:
                    LpspBookingSpectrHomeTabScreen(store: store)
                case .saved:
                    LpspBookingSavedTabScreen(store: store)
                case .bookings:
                    LpspBookingBookingsTabScreen(store: store)
                case .profile:
                    LpspBookingProfileTabScreen()
                case .help:
                    LpspBookingHelpTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspBookingLabeledTabBar(store: store)
        }
        .background(LpspBookingTokens.bkCanvas.ignoresSafeArea())
        .sheet(isPresented: $store.showReserveSheet) {
            if let id = store.selectedPropertyID,
               let property = store.properties.first(where: { $0.id == id }) {
                LpspBookingReserveSheet(store: store, property: property)
            }
        }
    }
}

private struct LpspBookingLabeledTabBar: View {
    @ObservedObject var store: LpspBookingStore

    var body: some View {
        HStack {
            ForEach(LpspBookingShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspBookingFonts.bkTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspBookingTokens.bkCTA
                            : LpspBookingTokens.bkTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspBookingTokens.bkCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspBookingTokens.bkDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspBookingSpectrAppBar: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(LpspBookingTokens.bkTextPrimary)

            VStack(alignment: .leading, spacing: 2) {
                Text(LpspBookingShowroomData.shortDestination)
                    .font(LpspBookingFonts.bkScreenTitle.weight(.bold))
                    .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                Text(LpspBookingShowroomData.appBarSubtitle)
                    .font(LpspBookingFonts.bkCaption)
                    .foregroundStyle(LpspBookingTokens.bkTextSecondary)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(LpspBookingTokens.bkCanvas)
    }
}

private struct LpspBookingShowroomSearchForm: View {
    @ObservedObject var store: LpspBookingStore

    var body: some View {
        VStack(spacing: 0) {
            LpspBookingSearchFormCard.LpspBookingFormRow(
                system: "mappin.and.ellipse",
                text: LpspBookingShowroomData.destination
            )
            Divider().overlay(LpspBookingTokens.bkDivider)
            LpspBookingSearchFormCard.LpspBookingFormRow(
                system: "calendar",
                text: LpspBookingShowroomData.dates
            )
            Divider().overlay(LpspBookingTokens.bkDivider)
            LpspBookingSearchFormCard.LpspBookingFormRow(
                system: "person",
                text: LpspBookingShowroomData.guests
            )
            LpspBookingBookingCTA(label: "Search") {
                store.search()
            }
            .padding(.top, 12)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(LpspBookingTokens.bkCanvas)
                .shadow(color: LpspBookingTokens.bkTextPrimary.opacity(0.08), radius: 6, y: 2)
        )
    }
}

private struct LpspBookingShowroomPropertyCard: View {
    let property: LpspBookingProperty
    let onTap: () -> Void
    let onSave: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 12) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: property.photoColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                    .overlay(alignment: .topTrailing) {
                        Button(action: onSave) {
                            Image(systemName: property.isSaved ? "heart.fill" : "heart")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(property.isSaved ? LpspBookingTokens.bkDeal : .white)
                                .padding(8)
                        }
                        .buttonStyle(.plain)
                    }

                VStack(alignment: .leading, spacing: 4) {
                    Text(property.name)
                        .font(LpspBookingFonts.bkPropName.weight(.semibold))
                        .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                        .lineLimit(2)
                    HStack(spacing: 6) {
                        Text(property.area)
                            .font(LpspBookingFonts.bkMeta)
                            .foregroundStyle(LpspBookingTokens.bkCTA)
                        Text(property.distance)
                            .font(LpspBookingFonts.bkMeta)
                            .foregroundStyle(LpspBookingTokens.bkTextSecondary)
                    }
                    Text(property.policy)
                        .font(LpspBookingFonts.bkMeta.weight(.semibold))
                        .foregroundStyle(LpspBookingTokens.bkSuccess)
                    LpspBookingReviewScoreBadge(score: property.score, reviews: property.reviews)

                    Spacer(minLength: 4)

                    VStack(alignment: .trailing, spacing: 1) {
                        if let originalPrice = property.originalPrice {
                            Text(originalPrice)
                                .font(LpspBookingFonts.bkMeta)
                                .strikethrough()
                                .foregroundStyle(LpspBookingTokens.bkTextTertiary)
                        }
                        Text(property.price)
                            .font(LpspBookingFonts.bkPrice.weight(.bold))
                            .monospacedDigit()
                            .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                        Text("Includes taxes and fees")
                            .font(LpspBookingFonts.bkCaption)
                            .foregroundStyle(LpspBookingTokens.bkTextSecondary)
                        if let scarcity = property.scarcity {
                            Text(scarcity)
                                .font(LpspBookingFonts.bkTag.weight(.semibold))
                                .foregroundStyle(LpspBookingTokens.bkDeal)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(LpspBookingTokens.bkCanvas)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(LpspBookingTokens.bkDivider, lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

private struct LpspBookingSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspBookingStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                LpspBookingSpectrAppBar()

                LpspBookingShowroomSearchForm(store: store)
                    .padding(.horizontal, 16)

                LpspBookingGeniusBanner()
                    .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(LpspBookingShowroomData.filters, id: \.self) { filter in
                            LpspBookingFilterChip(
                                label: filter,
                                isSelected: store.selectedFilter == filter
                            ) {
                                store.setFilter(filter)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }

                ForEach(filteredProperties) { property in
                    LpspBookingShowroomPropertyCard(
                        property: property,
                        onTap: { store.selectProperty(property) },
                        onSave: { store.toggleSave(property.id) }
                    )
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
        }
    }

    private var filteredProperties: [LpspBookingProperty] {
        switch store.selectedFilter {
        case "Free cancellation":
            return store.properties.filter { $0.policy == "Free cancellation" }
        case "Breakfast included":
            return store.properties.filter { $0.policy == "Breakfast included" }
        default:
            return store.properties
        }
    }
}

private struct LpspBookingSavedTabScreen: View {
    @ObservedObject var store: LpspBookingStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Saved")
                    .font(LpspBookingFonts.bkScreenTitle.weight(.bold))
                    .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                if store.savedProperties.isEmpty {
                    Text("Save places you like by tapping the heart icon.")
                        .font(LpspBookingFonts.bkBody)
                        .foregroundStyle(LpspBookingTokens.bkTextSecondary)
                        .padding(.horizontal, 16)
                } else {
                    ForEach(store.savedProperties) { property in
                        LpspBookingShowroomPropertyCard(
                            property: property,
                            onTap: { store.selectProperty(property) },
                            onSave: { store.toggleSave(property.id) }
                        )
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspBookingBookingsTabScreen: View {
    @ObservedObject var store: LpspBookingStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Bookings")
                    .font(LpspBookingFonts.bkScreenTitle.weight(.bold))
                    .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                if store.bookedPropertyIDs.isEmpty {
                    Text("Your upcoming trips will appear here.")
                        .font(LpspBookingFonts.bkBody)
                        .foregroundStyle(LpspBookingTokens.bkTextSecondary)
                        .padding(.horizontal, 16)
                } else {
                    ForEach(store.bookedPropertyIDs, id: \.self) { id in
                        if let property = store.properties.first(where: { $0.id == id }) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(property.name)
                                    .font(LpspBookingFonts.bkPropName.weight(.semibold))
                                    .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                                Text("\(LpspBookingShowroomData.shortDestination) · \(LpspBookingShowroomData.dates)")
                                    .font(LpspBookingFonts.bkMeta)
                                    .foregroundStyle(LpspBookingTokens.bkTextSecondary)
                                Text(property.price)
                                    .font(LpspBookingFonts.bkPrice.weight(.bold))
                                    .foregroundStyle(LpspBookingTokens.bkCTA)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LpspBookingTokens.bkSurface)
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

private struct LpspBookingProfileTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Circle()
                    .fill(LpspBookingTokens.bkBlue)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Text("G1")
                            .font(LpspBookingFonts.bkSection.weight(.bold))
                            .foregroundStyle(.white)
                    )

                Text("Genius Level 1")
                    .font(LpspBookingFonts.bkScreenTitle.weight(.bold))
                    .foregroundStyle(LpspBookingTokens.bkTextPrimary)

                Text("Enjoy 10% off select stays")
                    .font(LpspBookingFonts.bkBody)
                    .foregroundStyle(LpspBookingTokens.bkTextSecondary)
            }
            .padding(.vertical, 32)
        }
    }
}

private struct LpspBookingHelpTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Help")
                    .font(LpspBookingFonts.bkScreenTitle.weight(.bold))
                    .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                ForEach(["Manage booking", "Contact property", "Cancellation policy"], id: \.self) { item in
                    HStack {
                        Text(item)
                            .font(LpspBookingFonts.bkBody)
                            .foregroundStyle(LpspBookingTokens.bkTextPrimary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(LpspBookingTokens.bkTextTertiary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspBookingReserveSheet: View {
    @ObservedObject var store: LpspBookingStore
    let property: LpspBookingProperty
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(property.name)
                    .font(LpspBookingFonts.bkPropName.weight(.bold))
                    .foregroundStyle(LpspBookingTokens.bkTextPrimary)

                Text("\(LpspBookingShowroomData.dates) · \(LpspBookingShowroomData.guests)")
                    .font(LpspBookingFonts.bkMeta)
                    .foregroundStyle(LpspBookingTokens.bkTextSecondary)

                Text(property.price)
                    .font(LpspBookingFonts.bkPrice.weight(.bold))
                    .foregroundStyle(LpspBookingTokens.bkTextPrimary)

                LpspBookingBookingCTA(label: "Reserve") {
                    store.reserveSelectedProperty()
                    dismiss()
                }

                Spacer()
            }
            .padding(16)
            .background(LpspBookingTokens.bkCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}


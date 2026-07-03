import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/travel/booking/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/booking
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeBookingView: View {
    var body: some View {
        LpspBookingShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
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
}

private enum LpspBookingFonts {
    static func bk(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private struct LpspBookingReviewScoreBadge: View {
    let score: Double          // 8.9
    let reviews: Int           // 1284

    private var word: String {
        switch score {
        case 9...:   "Fabulous"
        case 8..<9:  "Very good"
        case 7..<8:  "Good"
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

private struct LpspBookingPropertyCard: View {
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

private struct LpspBookingBookingCTA: View {
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

private struct LpspBookingBKPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .brightness(configuration.isPressed ? -0.04 : 0)
    }
}

private struct LpspBookingSearchFormCard: View {
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

private struct LpspBookingGeniusBanner: View {
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

private struct LpspBookingFilterChip: View {
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
    }
}

private struct LpspBookingPricePin: View {
    let price: String
    let isSelected: Bool
    var body: some View {
        Text(price)
            .font(.bk(13, weight: .bold)).monospacedDigit()
            .foregroundStyle(isSelected ? .white : LpspBookingTokens.bkTextPrimary)
            .padding(.horizontal, 10).padding(.vertical, 6)
            .background(Capsule().fill(isSelected ? LpspBookingTokens.bkBlue : LpspBookingTokens.bkCanvas))
            .shadow(color: LpspBookingTokens.bkTextPrimary.opacity(0.16), radius: 6, y: 2)
    }
}
// A "Map"/"List" pill toggle floats above the list; selecting a pin slides a single
// LpspBookingPropertyCard up from the bottom (a .sheet at a low detent or a bottom overlay).

private struct LpspBookingRootTabView: View {
    init() {
        let nav = UINavigationBarAppearance()
        nav.configureWithOpaqueBackground()
        nav.backgroundColor = UIColor(LpspBookingTokens.bkBlue)
        nav.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = nav
        UINavigationBar.appearance().scrollEdgeAppearance = nav

        let tab = UITabBarAppearance()
        tab.configureWithOpaqueBackground()
        tab.backgroundColor = UIColor.white
        tab.shadowColor = UIColor(LpspBookingTokens.bkDivider)
        UITabBar.appearance().standardAppearance = tab
        UITabBar.appearance().scrollEdgeAppearance = tab
    }
    var body: some View {
        TabView {
            SearchView().tabItem   { Label("Search",   systemImage: "magnifyingglass") }
            SavedView().tabItem    { Label("Saved",    systemImage: "heart") }
            BookingsView().tabItem { Label("Bookings", systemImage: "suitcase") }
            ProfileView().tabItem  { Label("Profile",  systemImage: "person") }
            HelpView().tabItem     { Label("Help",     systemImage: "questionmark.circle") }
        }
        .tint(LpspBookingTokens.bkCTA) // active = CTA blue
    }
}

// MARK: - Écrans showroom

private struct LpspBookingShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspBookingGenericTabScreen(title: "Bookings", tabIndex: 0)
                .tabItem { Label("Bookings", systemImage: "suitcase") }
                .tag(0)
        }
        .tint(LpspBookingTokens.bkTextPrimary)
        
    }
}


private struct LpspBookingGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspBookingTokens.bkTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspBookingTokens.bkTextPrimary))
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


private struct LpspBookingMessagingTabScreen: View {
    let title: String
    var body: some View { LpspBookingGenericTabScreen(title: title, tabIndex: 0) }
}



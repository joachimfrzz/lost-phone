import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/expedia
// Meliwat/awesome-ios-design-md/travel/expedia/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeExpediaView: View {
    var body: some View {
        LpspExpediaShowroomRoot(store: LpspExpediaStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspExpediaTokens {
    // MARK: - Canvas & Surfaces (Light)
    static let expCanvas        = Color.white                                    // #FFFFFF
    static let expSurfaceGray   = Color(red: 0.961, green: 0.969, blue: 0.980)  // #F5F7FA
    static let expSurfacePressed = Color(red: 0.925, green: 0.937, blue: 0.957) // #ECEFF4
    static let expDivider       = Color(red: 0.890, green: 0.906, blue: 0.929)  // #E3E7ED

    // MARK: - Canvas & Surfaces (Dark)
    static let expDarkCanvas    = Color(red: 0.055, green: 0.067, blue: 0.086)  // #0E1116
    static let expDarkSurface1  = Color(red: 0.086, green: 0.106, blue: 0.133)  // #161B22
    static let expDarkSurface2  = Color(red: 0.122, green: 0.149, blue: 0.188)  // #1F2630
    static let expDarkDivider   = Color(red: 0.165, green: 0.196, blue: 0.243)  // #2A323E

    // MARK: - Text
    static let expTextPrimary   = Color(red: 0.102, green: 0.122, blue: 0.149)  // #1A1F26
    static let expTextSecondary = Color(red: 0.353, green: 0.396, blue: 0.451)  // #5A6573
    static let expTextTertiary  = Color(red: 0.541, green: 0.584, blue: 0.639)  // #8A95A3
    static let expDarkTextPrimary   = Color(red: 0.910, green: 0.922, blue: 0.937) // #E8EBEF
    static let expDarkTextSecondary = Color(red: 0.604, green: 0.643, blue: 0.698) // #9AA4B2

    // MARK: - Brand & Interactive
    static let expYellow        = Color(red: 1.000, green: 0.788, blue: 0.302)  // #FFC94D
    static let expYellowDeep    = Color(red: 1.000, green: 0.702, blue: 0.102)  // #FFB31A
    static let expActionBlue    = Color(red: 0.086, green: 0.408, blue: 0.890)  // #1668E3
    static let expActionPressed = Color(red: 0.059, green: 0.310, blue: 0.690)  // #0F4FB0
    static let expNavy          = Color(red: 0.000, green: 0.208, blue: 0.373)  // #00355F
    static let expNavySoft      = Color(red: 0.078, green: 0.255, blue: 0.420)  // #14416B
    static let expOneKeyGold    = Color(red: 0.961, green: 0.773, blue: 0.094)  // #F5C518

    // MARK: - Semantic
    static let expSuccess       = Color(red: 0.102, green: 0.545, blue: 0.294)  // #1A8B4B
    static let expError         = Color(red: 0.851, green: 0.227, blue: 0.227)  // #D93A3A
    static let expWarning       = Color(red: 0.910, green: 0.514, blue: 0.047)  // #E8830C
}

// Review-score badge color for a 0–10 guest score
func expReviewBadgeColor(_ score: Double) -> Color {
    switch score {
    case 9.0...:   return LpspExpediaTokens.expSuccess     // Wonderful
    case 8.0..<9.0: return LpspExpediaTokens.expActionBlue // Excellent
    case 7.0..<8.0: return LpspExpediaTokens.expNavySoft   // Good
    case 6.0..<7.0: return LpspExpediaTokens.expTextSecondary
    default:        return LpspExpediaTokens.expTextTertiary
    }
}

private enum LpspExpediaFonts {
    // Expedia Sans → SF Pro fallback (swap "ExpediaSans-*" if the licensed face is bundled)
    static func expedia(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        Font.system(size: size, weight: weight, design: .default)
    }

    static let expDisplay      = Font.system(size: 32, weight: .heavy)
    static let expScreenTitle  = Font.system(size: 26, weight: .heavy)
    static let expSection      = Font.system(size: 22, weight: .bold)
    static let expCardTitle    = Font.system(size: 18, weight: .bold)
    static let expBody         = Font.system(size: 16, weight: .regular)
    static let expCardSubtitle = Font.system(size: 15, weight: .semibold)
    static let expMeta         = Font.system(size: 14, weight: .regular)
    static let expStrike       = Font.system(size: 13, weight: .regular)
    static let expBadge        = Font.system(size: 12, weight: .semibold)
    static let expOneKeyLine   = Font.system(size: 11, weight: .bold)
    static let expButton       = Font.system(size: 16, weight: .bold)
    static let expTab          = Font.system(size: 10, weight: .semibold)

    // Price figures — always tabular
    static let expPriceNow   = Font.system(size: 18, weight: .heavy)
    static let expScoreNum   = Font.system(size: 15, weight: .heavy)
}

fileprivate struct LpspExpediaPropertyCard: View {
    let imageName: String
    let dealFlag: String?         // "−24% Bundle" / "Member price"
    let title: String
    let location: String
    let score: Double             // 9.2
    let scoreWord: String         // "Wonderful"
    let reviewCount: Int
    let strikePrice: Int?
    let nightlyPrice: Int
    let oneKeyEarn: Int
    @State private var saved = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image(imageName)
                    .resizable().aspectRatio(16.0/10.0, contentMode: .fill)
                    .clipped()

                if let dealFlag {
                    Text(dealFlag)
                        .font(LpspExpediaFonts.expBadge).foregroundStyle(LpspExpediaTokens.expNavy)
                        .padding(.vertical, 4).padding(.horizontal, 9)
                        .background(RoundedRectangle(cornerRadius: 6).fill(LpspExpediaTokens.expYellow))
                        .padding(12)
                }

                Button { withAnimation(.spring(response: 0.22, dampingFraction: 0.55)) { saved.toggle() } } label: {
                    Image(systemName: saved ? "heart.fill" : "heart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(saved ? LpspExpediaTokens.expActionBlue : .white)
                        .padding(7)
                        .background(Circle().fill(Color.black.opacity(0.4)))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(10)
                .scaleEffect(saved ? 1.0 : 1.0)
            }

            VStack(alignment: .leading, spacing: 0) {
                Text(title).font(LpspExpediaFonts.expCardTitle).foregroundStyle(LpspExpediaTokens.expTextPrimary)
                Text(location).font(LpspExpediaFonts.expCardSubtitle).foregroundStyle(LpspExpediaTokens.expTextSecondary)
                    .padding(.top, 3)

                HStack(spacing: 6) {
                    Text(String(format: "%.1f", score))
                        .font(LpspExpediaFonts.expScoreNum).foregroundStyle(.white)
                        .padding(.vertical, 3).padding(.horizontal, 7)
                        .background(RoundedRectangle(cornerRadius: 6).fill(expReviewBadgeColor(score)))
                    Text(scoreWord).font(LpspExpediaFonts.expBadge.weight(.bold)).foregroundStyle(LpspExpediaTokens.expTextPrimary)
                    Text("· \(reviewCount.formatted()) reviews")
                        .font(LpspExpediaFonts.expBadge).foregroundStyle(LpspExpediaTokens.expTextSecondary)
                }
                .padding(.top, 8)

                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    if let strikePrice {
                        Text("$\(strikePrice)")
                            .font(LpspExpediaFonts.expStrike).strikethrough()
                            .foregroundStyle(LpspExpediaTokens.expTextTertiary)
                    }
                    Text("$\(nightlyPrice)").font(LpspExpediaFonts.expPriceNow).foregroundStyle(LpspExpediaTokens.expTextPrimary)
                    Text("/ night").font(LpspExpediaFonts.expBadge).foregroundStyle(LpspExpediaTokens.expTextSecondary)
                }
                .padding(.top, 10)

                HStack(spacing: 5) {
                    Circle().fill(LpspExpediaTokens.expOneKeyGold).frame(width: 8, height: 8)
                    Text("Earn \(oneKeyEarn.formatted()) One Key cash")
                        .font(LpspExpediaFonts.expOneKeyLine).foregroundStyle(LpspExpediaTokens.expOneKeyGold)
                }
                .padding(.top, 7)
            }
            .padding(.horizontal, 14).padding(.top, 12).padding(.bottom, 14)
        }
        .background(RoundedRectangle(cornerRadius: 16).fill(LpspExpediaTokens.expCanvas))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(LpspExpediaTokens.expDivider, lineWidth: 0.5))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 12, y: 4)
        .sensoryFeedback(.impact(flexibility: .soft), trigger: saved)
    }
}

fileprivate struct LpspExpediaModeSwitch: View {
    @Binding var selection: Int
    let modes = ["Stays", "Flights", "Cars", "Bundle"]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(modes.indices, id: \.self) { i in
                let active = selection == i
                Text(modes[i])
                    .font(LpspExpediaFonts.expBadge.weight(.semibold))
                    .foregroundStyle(active ? LpspExpediaTokens.expNavy : LpspExpediaTokens.expTextSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(active ? LpspExpediaTokens.expYellow : LpspExpediaTokens.expSurfaceGray)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(active ? Color.clear : LpspExpediaTokens.expDivider, lineWidth: 0.5)
                    )
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) { selection = i }
                    }
            }
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspExpediaOneKeyStrip: View {
    let balance: String   // "$124.80"

    var body: some View {
        HStack(spacing: 12) {
            Text("1K")
                .font(.system(size: 13, weight: .heavy))
                .foregroundStyle(Color(red: 0.106, green: 0.106, blue: 0.106))
                .frame(width: 36, height: 36)
                .background(Circle().fill(LpspExpediaTokens.expOneKeyGold))

            VStack(alignment: .leading, spacing: 2) {
                Text("One Key cash available")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(LpspExpediaTokens.expTextPrimary)
                Text("Apply at checkout on any stay, flight, or car")
                    .font(.system(size: 11)).foregroundStyle(LpspExpediaTokens.expTextSecondary)
            }
            Spacer()
            Text(balance).font(.system(size: 16, weight: .heavy))
                .foregroundStyle(LpspExpediaTokens.expOneKeyGold)
        }
        .padding(.vertical, 14).padding(.horizontal, 16)
        .background(RoundedRectangle(cornerRadius: 12).fill(LpspExpediaTokens.expSurfaceGray))
        .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(LpspExpediaTokens.expDivider, lineWidth: 0.5))
    }
}

fileprivate struct LpspExpediaSearchPill: View {
    let destination: String
    let detail: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(LpspExpediaTokens.expTextSecondary)
            VStack(alignment: .leading, spacing: 2) {
                Text(destination).font(.system(size: 14, weight: .bold))
                    .foregroundStyle(LpspExpediaTokens.expTextPrimary)
                Text(detail).font(.system(size: 11)).foregroundStyle(LpspExpediaTokens.expTextSecondary)
            }
            Spacer()
        }
        .padding(.horizontal, 16).frame(height: 52)
        .background(RoundedRectangle(cornerRadius: 14).fill(LpspExpediaTokens.expCanvas))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(LpspExpediaTokens.expDivider, lineWidth: 0.5))
        .shadow(color: .black.opacity(0.08), radius: 12, y: 4)
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspExpediaReserveButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title).font(LpspExpediaFonts.expButton).foregroundStyle(.white)
                .frame(maxWidth: .infinity).padding(.vertical, 14)
        }
        .background(RoundedRectangle(cornerRadius: 8).fill(LpspExpediaTokens.expActionBlue))
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspExpediaBundleButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title).font(LpspExpediaFonts.expButton).foregroundStyle(LpspExpediaTokens.expNavy)
                .frame(maxWidth: .infinity).padding(.vertical, 14)
        }
        .background(RoundedRectangle(cornerRadius: 8).fill(LpspExpediaTokens.expYellow))
        .buttonStyle(.plain)
    }
}


fileprivate struct LpspExpediaExpediaTheme: ViewModifier {
    @Environment(\.colorScheme) var scheme
    func body(content: Content) -> some View {
        content
            .background(scheme == .dark ? LpspExpediaTokens.expDarkCanvas : LpspExpediaTokens.expSurfaceGray)
            .foregroundStyle(scheme == .dark ? LpspExpediaTokens.expDarkTextPrimary : LpspExpediaTokens.expTextPrimary)
    }
}
fileprivate extension View { func expediaTheme() -> some View { modifier(LpspExpediaExpediaTheme()) } }

// MARK: - Showroom data & store

private enum LpspExpediaShowroomTab: String, CaseIterable, Identifiable {
    case search, saved, trips, support, account

    var id: String { rawValue }

    var title: String {
        switch self {
        case .search: "Search"
        case .saved: "Saved"
        case .trips: "Trips"
        case .support: "Support"
        case .account: "Account"
        }
    }

    var icon: String {
        switch self {
        case .search: "magnifyingglass"
        case .saved: "heart.fill"
        case .trips: "line.3.horizontal"
        case .support: "questionmark.circle.fill"
        case .account: "person.fill"
        }
    }
}

private struct LpspExpediaProperty: Identifiable, Equatable {
    let id: String
    let dealFlag: String?
    let title: String
    let location: String
    let score: Double
    let scoreWord: String
    let reviewCount: Int
    let strikePrice: Int?
    let nightlyPrice: Int
    let oneKeyEarn: Int
    let photoColors: [Color]
    var isSaved: Bool
}

private enum LpspExpediaShowroomData {
    static let oneKeyBalance = "12,480 One Key"
    static let destination = "San Diego, CA"
    static let searchDetail = "Oct 12 – 17 · 2 travelers · 1 room"
    static let modes = ["Stays", "Flights", "Cars", "Bundle"]
    static let sectionTitle = "Bundle + Save deals"

    static let properties: [LpspExpediaProperty] = [
        LpspExpediaProperty(
            id: "hotel-republic",
            dealFlag: "−24% Bundle",
            title: "Hotel Republic San Diego",
            location: "Downtown · Gaslamp Quarter",
            score: 9.2,
            scoreWord: "Wonderful",
            reviewCount: 1847,
            strikePrice: 268,
            nightlyPrice: 204,
            oneKeyEarn: 2040,
            photoColors: [
                Color(red: 0.18, green: 0.38, blue: 0.62),
                Color(red: 0.10, green: 0.24, blue: 0.48),
            ],
            isSaved: true
        ),
        LpspExpediaProperty(
            id: "guild-hotel",
            dealFlag: "Member price",
            title: "The Guild Hotel, Autograph",
            location: "Marina District · 0.4 mi from center",
            score: 8.8,
            scoreWord: "Excellent",
            reviewCount: 932,
            strikePrice: nil,
            nightlyPrice: 251,
            oneKeyEarn: 2510,
            photoColors: [
                Color(red: 0.72, green: 0.52, blue: 0.34),
                Color(red: 0.42, green: 0.28, blue: 0.18),
            ],
            isSaved: false
        ),
    ]

    static let supportItems = [
        "Manage booking",
        "Cancellation policy",
        "Contact support",
    ]
}

@MainActor
fileprivate final class LpspExpediaStore: ObservableObject {
    @Published var selectedTab: LpspExpediaShowroomTab = .search
    @Published var selectedModeIndex = 0
    @Published var properties: [LpspExpediaProperty] = LpspExpediaShowroomData.properties
    @Published var selectedPropertyID: String?
    @Published var showReserveSheet = false
    @Published var bookedPropertyIDs: [String] = []
    @Published var lastActionMessage = ""

    var savedProperties: [LpspExpediaProperty] {
        properties.filter(\.isSaved)
    }

    func selectMode(_ index: Int) {
        selectedModeIndex = index
        lastActionMessage = "Switched to \(LpspExpediaShowroomData.modes[index])"
    }

    func openSearch() {
        lastActionMessage = "Search opened for \(LpspExpediaShowroomData.destination)"
        selectedTab = .search
    }

    func seeAllDeals() {
        lastActionMessage = "Showing all Bundle + Save deals"
    }

    func toggleSave(_ propertyID: String) {
        guard let index = properties.firstIndex(where: { $0.id == propertyID }) else { return }
        var updated = properties[index]
        updated.isSaved.toggle()
        properties[index] = updated
        lastActionMessage = updated.isSaved ? "Saved \(updated.title)" : "Removed save"
    }

    func selectProperty(_ property: LpspExpediaProperty) {
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
        lastActionMessage = "Reserved \(property.title)"
        selectedTab = .trips
    }
}

// MARK: - Écrans showroom

private struct LpspExpediaShowroomRoot: View {
    @ObservedObject var store: LpspExpediaStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .search:
                    LpspExpediaSpectrHomeTabScreen(store: store)
                case .saved:
                    LpspExpediaSavedTabScreen(store: store)
                case .trips:
                    LpspExpediaTripsTabScreen(store: store)
                case .support:
                    LpspExpediaSupportTabScreen()
                case .account:
                    LpspExpediaAccountTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspExpediaLabeledTabBar(store: store)
        }
        .background(LpspExpediaTokens.expDarkCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .sheet(isPresented: $store.showReserveSheet) {
            if let id = store.selectedPropertyID,
               let property = store.properties.first(where: { $0.id == id }) {
                LpspExpediaReserveSheet(store: store, property: property)
            }
        }
    }
}

private struct LpspExpediaLabeledTabBar: View {
    @ObservedObject var store: LpspExpediaStore

    var body: some View {
        HStack {
            ForEach(LpspExpediaShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspExpediaFonts.expTab.weight(store.selectedTab == tab ? .bold : .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspExpediaTokens.expActionBlue
                            : LpspExpediaTokens.expDarkTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspExpediaTokens.expDarkCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspExpediaTokens.expDarkDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspExpediaShowroomAppBar: View {
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(LpspExpediaTokens.expNavy)
                        .frame(width: 32, height: 32)
                    Circle()
                        .fill(LpspExpediaTokens.expYellow)
                        .frame(width: 8, height: 8)
                        .offset(x: 6, y: -4)
                }
                Text("Expedia")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
            }

            Spacer()

            HStack(spacing: 6) {
                Circle()
                    .fill(LpspExpediaTokens.expOneKeyGold)
                    .frame(width: 8, height: 8)
                Text(LpspExpediaShowroomData.oneKeyBalance)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(LpspExpediaTokens.expDarkSurface2)
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

private struct LpspExpediaShowroomModeSwitch: View {
    @ObservedObject var store: LpspExpediaStore

    var body: some View {
        HStack(spacing: 8) {
            ForEach(LpspExpediaShowroomData.modes.indices, id: \.self) { index in
                let active = store.selectedModeIndex == index
                Text(LpspExpediaShowroomData.modes[index])
                    .font(LpspExpediaFonts.expBadge.weight(.semibold))
                    .foregroundStyle(active ? LpspExpediaTokens.expNavy : LpspExpediaTokens.expDarkTextSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(active ? LpspExpediaTokens.expYellow : LpspExpediaTokens.expDarkSurface2)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(
                                active ? Color.clear : LpspExpediaTokens.expDarkDivider,
                                lineWidth: 0.5
                            )
                    )
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) {
                            store.selectMode(index)
                        }
                    }
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct LpspExpediaShowroomSearchPill: View {
    @ObservedObject var store: LpspExpediaStore

    var body: some View {
        Button {
            store.openSearch()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                VStack(alignment: .leading, spacing: 2) {
                    Text(LpspExpediaShowroomData.destination)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                    Text(LpspExpediaShowroomData.searchDetail)
                        .font(.system(size: 11))
                        .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(LpspExpediaTokens.expDarkSurface2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(LpspExpediaTokens.expDarkDivider, lineWidth: 0.5)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
    }
}

private struct LpspExpediaShowroomSectionHeader: View {
    let onSeeAll: () -> Void

    var body: some View {
        HStack {
            Text(LpspExpediaShowroomData.sectionTitle)
                .font(LpspExpediaFonts.expSection)
                .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
            Spacer()
            Button(action: onSeeAll) {
                Text("See all")
                    .font(LpspExpediaFonts.expMeta.weight(.semibold))
                    .foregroundStyle(LpspExpediaTokens.expActionBlue)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
    }
}

private struct LpspExpediaShowroomPropertyCard: View {
    let property: LpspExpediaProperty
    let onTap: () -> Void
    let onSave: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topLeading) {
                    LinearGradient(
                        colors: property.photoColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .aspectRatio(16.0 / 10.0, contentMode: .fit)

                    if let dealFlag = property.dealFlag {
                        Text(dealFlag)
                            .font(LpspExpediaFonts.expBadge)
                            .foregroundStyle(LpspExpediaTokens.expNavy)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 9)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(LpspExpediaTokens.expYellow)
                            )
                            .padding(12)
                    }

                    Button(action: onSave) {
                        Image(systemName: property.isSaved ? "heart.fill" : "heart")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(property.isSaved ? LpspExpediaTokens.expActionBlue : .white)
                            .padding(7)
                            .background(Circle().fill(Color.black.opacity(0.4)))
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(10)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text(property.title)
                        .font(LpspExpediaFonts.expCardTitle)
                        .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                    Text(property.location)
                        .font(LpspExpediaFonts.expCardSubtitle)
                        .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                        .padding(.top, 3)

                    HStack(spacing: 6) {
                        Text(String(format: "%.1f", property.score))
                            .font(LpspExpediaFonts.expScoreNum)
                            .foregroundStyle(.white)
                            .padding(.vertical, 3)
                            .padding(.horizontal, 7)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(expReviewBadgeColor(property.score))
                            )
                        Text(property.scoreWord)
                            .font(LpspExpediaFonts.expBadge.weight(.bold))
                            .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                        Text("· \(property.reviewCount.formatted()) reviews")
                            .font(LpspExpediaFonts.expBadge)
                            .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                    }
                    .padding(.top, 8)

                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        if let strikePrice = property.strikePrice {
                            Text("$\(strikePrice)")
                                .font(LpspExpediaFonts.expStrike)
                                .strikethrough()
                                .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                        }
                        Text("$\(property.nightlyPrice)")
                            .font(LpspExpediaFonts.expPriceNow)
                            .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                        Text("/ night")
                            .font(LpspExpediaFonts.expBadge)
                            .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                    }
                    .padding(.top, 10)

                    HStack(spacing: 5) {
                        Circle()
                            .fill(LpspExpediaTokens.expOneKeyGold)
                            .frame(width: 8, height: 8)
                        Text("Earn \(property.oneKeyEarn.formatted()) One Key cash")
                            .font(LpspExpediaFonts.expOneKeyLine)
                            .foregroundStyle(LpspExpediaTokens.expOneKeyGold)
                    }
                    .padding(.top, 7)
                }
                .padding(.horizontal, 14)
                .padding(.top, 12)
                .padding(.bottom, 14)
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(LpspExpediaTokens.expDarkSurface1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(LpspExpediaTokens.expDarkDivider, lineWidth: 0.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

private struct LpspExpediaSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspExpediaStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                LpspExpediaShowroomAppBar()

                LpspExpediaShowroomModeSwitch(store: store)

                if store.selectedModeIndex == 0 {
                    LpspExpediaShowroomSearchPill(store: store)

                    LpspExpediaShowroomSectionHeader {
                        store.seeAllDeals()
                    }

                    ForEach(store.properties) { property in
                        LpspExpediaShowroomPropertyCard(
                            property: property,
                            onTap: { store.selectProperty(property) },
                            onSave: { store.toggleSave(property.id) }
                        )
                        .padding(.horizontal, 16)
                    }
                } else {
                    Text("Search \(LpspExpediaShowroomData.modes[store.selectedModeIndex].lowercased()) in \(LpspExpediaShowroomData.destination)")
                        .font(LpspExpediaFonts.expBody)
                        .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspExpediaSavedTabScreen: View {
    @ObservedObject var store: LpspExpediaStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Saved")
                    .font(LpspExpediaFonts.expScreenTitle)
                    .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                if store.savedProperties.isEmpty {
                    Text("Save places you like by tapping the heart icon.")
                        .font(LpspExpediaFonts.expBody)
                        .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                        .padding(.horizontal, 16)
                } else {
                    ForEach(store.savedProperties) { property in
                        LpspExpediaShowroomPropertyCard(
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

private struct LpspExpediaTripsTabScreen: View {
    @ObservedObject var store: LpspExpediaStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Trips")
                    .font(LpspExpediaFonts.expScreenTitle)
                    .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                if store.bookedPropertyIDs.isEmpty {
                    Text("Your upcoming trips will appear here.")
                        .font(LpspExpediaFonts.expBody)
                        .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                        .padding(.horizontal, 16)
                } else {
                    ForEach(store.bookedPropertyIDs, id: \.self) { id in
                        if let property = store.properties.first(where: { $0.id == id }) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(property.title)
                                    .font(LpspExpediaFonts.expCardTitle)
                                    .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                                Text("\(LpspExpediaShowroomData.destination) · \(LpspExpediaShowroomData.searchDetail)")
                                    .font(LpspExpediaFonts.expMeta)
                                    .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                                Text("$\(property.nightlyPrice) / night")
                                    .font(LpspExpediaFonts.expPriceNow)
                                    .foregroundStyle(LpspExpediaTokens.expActionBlue)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LpspExpediaTokens.expDarkSurface1)
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

private struct LpspExpediaSupportTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Support")
                    .font(LpspExpediaFonts.expScreenTitle)
                    .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                ForEach(LpspExpediaShowroomData.supportItems, id: \.self) { item in
                    HStack {
                        Text(item)
                            .font(LpspExpediaFonts.expBody)
                            .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(LpspExpediaTokens.expDarkTextSecondary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspExpediaAccountTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Circle()
                    .fill(LpspExpediaTokens.expOneKeyGold.gradient)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Text("1K")
                            .font(.system(size: 24, weight: .heavy))
                            .foregroundStyle(Color(red: 0.106, green: 0.106, blue: 0.106))
                    )

                Text("One Key member")
                    .font(LpspExpediaFonts.expScreenTitle)
                    .foregroundStyle(LpspExpediaTokens.expDarkTextPrimary)

                Text(LpspExpediaShowroomData.oneKeyBalance)
                    .font(LpspExpediaFonts.expBody)
                    .foregroundStyle(LpspExpediaTokens.expOneKeyGold)
            }
            .padding(.vertical, 32)
        }
    }
}

private struct LpspExpediaReserveSheet: View {
    @ObservedObject var store: LpspExpediaStore
    let property: LpspExpediaProperty
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: property.photoColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .aspectRatio(16.0 / 10.0, contentMode: .fit)

                Text(property.title)
                    .font(LpspExpediaFonts.expCardTitle)
                    .foregroundStyle(LpspExpediaTokens.expTextPrimary)

                Text(property.location)
                    .font(LpspExpediaFonts.expCardSubtitle)
                    .foregroundStyle(LpspExpediaTokens.expTextSecondary)

                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    if let strikePrice = property.strikePrice {
                        Text("$\(strikePrice)")
                            .font(LpspExpediaFonts.expStrike)
                            .strikethrough()
                            .foregroundStyle(LpspExpediaTokens.expTextTertiary)
                    }
                    Text("$\(property.nightlyPrice)")
                        .font(LpspExpediaFonts.expPriceNow)
                        .foregroundStyle(LpspExpediaTokens.expTextPrimary)
                    Text("/ night")
                        .font(LpspExpediaFonts.expBadge)
                        .foregroundStyle(LpspExpediaTokens.expTextSecondary)
                }

                Text("Earn \(property.oneKeyEarn.formatted()) One Key cash")
                    .font(LpspExpediaFonts.expOneKeyLine)
                    .foregroundStyle(LpspExpediaTokens.expOneKeyGold)

                Spacer()

                LpspExpediaReserveButton(title: "Reserve") {
                    store.reserveSelectedProperty()
                    dismiss()
                }
            }
            .padding(16)
            .background(LpspExpediaTokens.expCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
        .presentationDetents([.large])
    }
}



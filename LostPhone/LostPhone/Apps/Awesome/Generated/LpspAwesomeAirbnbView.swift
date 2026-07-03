import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/travel/airbnb/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/airbnb
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAirbnbView: View {
    var body: some View {
        LpspAirbnbShowroomRoot()
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
                    .overlay(Circle().strokeBorder(LpspAirbnbTokens.airbnbDivider, lineWidth: 1))
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .background(
                Capsule()
                    .fill(LpspAirbnbTokens.airbnbCanvas)
                    .overlay(Capsule().strokeBorder(LpspAirbnbTokens.airbnbDivider, lineWidth: 0.5))
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

fileprivate struct LpspAirbnbRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.92)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            ExploreView()   .tabItem { Label("Explore",   systemImage: "magnifyingglass") }
            WishlistsView() .tabItem { Label("Wishlists", systemImage: "heart") }
            TripsView()     .tabItem { Label("Trips",     systemImage: "airplane") }
            InboxView()     .tabItem { Label("Inbox",     systemImage: "message") }
            ProfileView()   .tabItem { Label("Profile",   systemImage: "person.circle") }
        }
        .tint(LpspAirbnbTokens.airbnbCoral) // active = Primary Coral
    }
}

// MARK: - Écrans showroom

private struct LpspAirbnbShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspAirbnbGenericTabScreen(title: "Wishlists", tabIndex: 0)
                .tabItem { Label("Wishlists", systemImage: "heart") }
                .tag(0)
        }
        .tint(LpspAirbnbTokens.airbnbLargeNav)
        
    }
}


private struct LpspAirbnbGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspAirbnbTokens.airbnbLargeNav.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspAirbnbTokens.airbnbLargeNav))
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


private struct LpspAirbnbMessagingTabScreen: View {
    let title: String
    var body: some View { LpspAirbnbGenericTabScreen(title: title, tabIndex: 0) }
}



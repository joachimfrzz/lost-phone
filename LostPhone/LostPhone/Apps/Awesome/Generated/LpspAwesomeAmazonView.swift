import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/misc/amazon/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/amazon
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAmazonView: View {
    var body: some View {
        LpspAmazonShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspAmazonTokens {
    // MARK: - Canvas
    static let amzCanvas        = Color.white                                   // #FFFFFF
    static let amzSurfaceMuted  = Color(red: 0.953, green: 0.953, blue: 0.953) // #F3F3F3
    static let amzSurfaceTint   = Color(red: 0.969, green: 0.973, blue: 0.973) // #F7F8F8
    static let amzDivider       = Color(red: 0.867, green: 0.867, blue: 0.867) // #DDDDDD
    static let amzBorderDefault = Color(red: 0.835, green: 0.851, blue: 0.851) // #D5D9D9

    // MARK: - Text
    static let amzTextPrimary   = Color(red: 0.059, green: 0.067, blue: 0.067) // #0F1111
    static let amzTextSecondary = Color(red: 0.337, green: 0.349, blue: 0.349) // #565959
    static let amzTextTertiary  = Color(red: 0.518, green: 0.541, blue: 0.549) // #848A8C

    // MARK: - Brand
    static let amzYellow        = Color(red: 1.000, green: 0.600, blue: 0.000) // #FF9900
    static let amzYellowPressed = Color(red: 0.902, green: 0.541, blue: 0.000) // #E68A00
    static let amzYellowHighlight = Color(red: 0.988, green: 0.824, blue: 0.000) // #FCD200
    static let amzBuyNowOrange  = Color(red: 0.941, green: 0.533, blue: 0.016) // #F08804
    static let amzDeepNavy      = Color(red: 0.075, green: 0.098, blue: 0.129) // #131921
    static let amzSecondaryNavy = Color(red: 0.137, green: 0.184, blue: 0.243) // #232F3E

    // MARK: - Semantic
    static let amzPriceRed      = Color(red: 0.694, green: 0.153, blue: 0.016) // #B12704
    static let amzAlertRed      = Color(red: 0.800, green: 0.047, blue: 0.224) // #CC0C39
    static let amzSuccessGreen  = Color(red: 0.000, green: 0.463, blue: 0.000) // #007600
    static let amzPrimeTeal     = Color(red: 0.000, green: 0.443, blue: 0.522) // #007185
    static let amzPrimeSky      = Color(red: 0.000, green: 0.659, blue: 0.882) // #00A8E1
    static let amzRatingGold    = Color(red: 1.000, green: 0.643, blue: 0.110) // #FFA41C

    // MARK: - Dark
    static let amzDarkCanvas    = Color(red: 0.059, green: 0.067, blue: 0.067) // #0F1111
    static let amzDarkSurface1  = Color(red: 0.102, green: 0.122, blue: 0.145) // #1A1F25
    static let amzDarkSurface2  = Color(red: 0.137, green: 0.184, blue: 0.243) // #232F3E
}

private enum LpspAmazonFonts {
    // Amazon Ember hierarchy
    static let amzNavHero      = Font.system(size: 22, weight: .regular)
    static let amzSection      = Font.system(size: 20, weight: .regular)
    static let amzProductTitle = Font.system(size: 16, weight: .regular)
    static let amzPDPTitle     = Font.system(size: 20, weight: .regular)
    static let amzPriceHero    = Font.system(size: 28, weight: .regular)
    static let amzPriceSuperscript = Font.system(size: 14, weight: .regular)
    static let amzPriceCard    = Font.system(size: 18, weight: .regular)
    static let amzPriceStruck  = Font.system(size: 14, weight: .regular)
    static let amzBody         = Font.system(size: 15, weight: .regular)
    static let amzRatingCount  = Font.system(size: 13, weight: .regular)
    static let amzDelivery     = Font.system(size: 13, weight: .regular)
    static let amzMeta         = Font.system(size: 12, weight: .regular)
    static let amzButton       = Font.system(size: 15, weight: .regular)
    static let amzButtonSmall  = Font.system(size: 14, weight: .regular)
    static let amzPrimeBadge   = Font.system(size: 11, weight: .regular)
    static let amzTab          = Font.system(size: 10, weight: .regular)
    static let amzSearchPlaceholder = Font.system(size: 16, weight: .regular)
    static let amzPromoBadge   = Font.system(size: 11, weight: .regular)
}

private struct LpspAmazonAmazonTopNav: View {
    @State private var query = ""
    let onSearch: () -> Void
    let onMicOrScan: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "cart.fill")
                .resizable().scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundStyle(.white)
            HStack(spacing: 0) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18))
                        .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                    Text("Search Amazon")
                        .font(LpspAmazonFonts.amzSearchPlaceholder)
                        .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                    Spacer()
                }
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(LpspAmazonTokens.amzCanvas)
                .clipShape(LpspAmazonRoundedCorner(radius: 8, corners: [.topLeft, .bottomLeft]))

                Button(action: onMicOrScan) {
                    HStack(spacing: 10) {
                        Image(systemName: "mic.fill").font(.system(size: 18))
                        Image(systemName: "barcode.viewfinder").font(.system(size: 20))
                    }
                    .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                    .padding(.horizontal, 14)
                    .frame(height: 44)
                    .background(LpspAmazonTokens.amzYellow)
                    .clipShape(LpspAmazonRoundedCorner(radius: 8, corners: [.topRight, .bottomRight]))
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(LpspAmazonTokens.amzDeepNavy)
        .onTapGesture(perform: onSearch)
    }
}

private struct LpspAmazonRoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                          cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    }
}

private struct LpspAmazonAmazonAddToCartButton: View {
    let action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button(action: action) {
            Text("Add to Cart")
                .font(LpspAmazonFonts.amzButton)
                .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(pressed ? LpspAmazonTokens.amzYellowPressed : LpspAmazonTokens.amzYellow)
                        // 1pt top highlight (vestigial 3D cue)
                        VStack(spacing: 0) {
                            Rectangle().fill(LpspAmazonTokens.amzYellowHighlight).frame(height: 1)
                            Spacer()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                )
                .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
        }
        .buttonStyle(.plain)
        .scaleEffect(pressed ? 0.98 : 1)
        .animation(.spring(response: 0.2, dampingFraction: 0.8), value: pressed)
        .sensoryFeedback(.success, trigger: pressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressed = true }
                .onEnded   { _ in pressed = false }
        )
    }
}

private struct LpspAmazonAmazonBuyNowButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text("Buy Now")
                .font(LpspAmazonFonts.amzButton)
                .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(RoundedRectangle(cornerRadius: 8).fill(LpspAmazonTokens.amzBuyNowOrange))
        }
        .buttonStyle(.plain)
    }
}

private struct LpspAmazonAmazonProductCard: View {
    let title: String
    let rating: Double
    let reviewCount: Int
    let price: String
    let originalPrice: String?
    let isPrime: Bool
    let deliveryLine: String
    let imageUrl: URL?

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            AsyncImage(url: imageUrl) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                LpspAmazonTokens.amzSurfaceMuted
            }
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 4))

            Text(title)
                .font(LpspAmazonFonts.amzProductTitle)
                .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { i in
                    Image(systemName: Double(i) < rating ? "star.fill" : "star")
                        .font(.system(size: 12))
                        .foregroundStyle(LpspAmazonTokens.amzRatingGold)
                }
                Text(" (\(reviewCount.formatted()))")
                    .font(LpspAmazonFonts.amzRatingCount)
                    .foregroundStyle(LpspAmazonTokens.amzPrimeTeal)
            }

            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(price)
                    .font(LpspAmazonFonts.amzPriceCard)
                    .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                if let original = originalPrice {
                    Text(original)
                        .font(LpspAmazonFonts.amzPriceStruck)
                        .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                        .strikethrough()
                }
            }

            if isPrime {
                HStack(spacing: 4) {
                    Text("prime")
                        .font(LpspAmazonFonts.amzPrimeBadge)
                        .foregroundStyle(LpspAmazonTokens.amzPrimeSky)
                    Text(deliveryLine)
                        .font(LpspAmazonFonts.amzDelivery)
                        .foregroundStyle(LpspAmazonTokens.amzSuccessGreen)
                }
            }
        }
        .padding(8)
        .background(LpspAmazonTokens.amzCanvas)
    }
}

private struct LpspAmazonAmazonPDPPriceBlock: View {
    let dollars: Int
    let cents: Int
    let originalPrice: String?
    let savingsLine: String?
    let deliveryText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top, spacing: 2) {
                Text("$")
                    .font(LpspAmazonFonts.amzPriceSuperscript)
                    .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                    .baselineOffset(12)
                Text("\(dollars)")
                    .font(LpspAmazonFonts.amzPriceHero)
                    .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                Text(String(format: "%02d", cents))
                    .font(LpspAmazonFonts.amzPriceSuperscript)
                    .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                    .baselineOffset(12)
            }
            if let original = originalPrice {
                Text(original)
                    .font(LpspAmazonFonts.amzPriceStruck)
                    .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                    .strikethrough()
            }
            if let savings = savingsLine {
                Text(savings)
                    .font(LpspAmazonFonts.amzButton)
                    .foregroundStyle(LpspAmazonTokens.amzPriceRed)
            }
            HStack(spacing: 4) {
                Text("prime")
                    .font(LpspAmazonFonts.amzPrimeBadge)
                    .foregroundStyle(LpspAmazonTokens.amzPrimeSky)
                Text(deliveryText)
                    .font(LpspAmazonFonts.amzButton)
                    .foregroundStyle(LpspAmazonTokens.amzSuccessGreen)
            }
        }
    }
}

private struct LpspAmazonAmazonLightningDealBanner: View {
    let countdown: String  // "02h 45m 10s"
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "bolt.fill")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
            Text("Lightning Deal")
                .font(LpspAmazonFonts.amzDelivery)
                .foregroundStyle(.white)
                .fontWeight(.bold)
            Spacer()
            Text("Ends in \(countdown)")
                .font(LpspAmazonFonts.amzDelivery)
                .foregroundStyle(.white)
                .monospacedDigit()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            LinearGradient(colors: [LpspAmazonTokens.amzPriceRed, LpspAmazonTokens.amzAlertRed],
                           startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

private struct LpspAmazonAmazonQuantityStepper: View {
    @Binding var count: Int
    var body: some View {
        HStack(spacing: 0) {
            Button { if count > 1 { count -= 1 } } label: {
                Image(systemName: "minus")
                    .frame(width: 44, height: 32)
            }
            Text("\(count)")
                .font(LpspAmazonFonts.amzButton)
                .frame(width: 36, height: 32)
                .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
            Button { count += 1 } label: {
                Image(systemName: "plus")
                    .frame(width: 44, height: 32)
            }
        }
        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(LpspAmazonTokens.amzSurfaceMuted)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(LpspAmazonTokens.amzBorderDefault, lineWidth: 1))
        )
    }
}

private struct LpspAmazonAmazonRootTabView: View {
    @State private var cartCount = 2
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = UIColor(red: 0.867, green: 0.867, blue: 0.867, alpha: 1)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home",   systemImage: "house.fill") }
            MenuView().tabItem { Label("Menu",   systemImage: "line.3.horizontal") }
            CartView().tabItem { Label("Cart",   systemImage: "cart.fill") }
                .badge(cartCount)
            YouView().tabItem  { Label("You",    systemImage: "person.fill") }
            SearchView().tabItem { Label("Search", systemImage: "magnifyingglass") }
        }
        .tint(LpspAmazonTokens.amzYellow)
    }
}

private struct LpspAmazonAddToCartToast: View {
    @Binding var visible: Bool
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill").foregroundStyle(LpspAmazonTokens.amzSuccessGreen)
            Text("Added to your Cart").font(LpspAmazonFonts.amzButton)
            Spacer()
        }
        .padding(.horizontal, 16).frame(height: 48)
        .background(LpspAmazonTokens.amzCanvas)
        .shadow(color: .black.opacity(0.15), radius: 12, y: -4)
        .offset(y: visible ? 0 : 60)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: visible)
    }
}

// MARK: - Écrans showroom

private struct LpspAmazonShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspAmazonGenericTabScreen(title: "Search", tabIndex: 0)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(0)
        }
        .tint(LpspAmazonTokens.amzSuccessGreen)
        
    }
}


private struct LpspAmazonGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspAmazonTokens.amzSuccessGreen.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspAmazonTokens.amzSuccessGreen))
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


private struct LpspAmazonMessagingTabScreen: View {
    let title: String
    var body: some View { LpspAmazonGenericTabScreen(title: title, tabIndex: 0) }
}



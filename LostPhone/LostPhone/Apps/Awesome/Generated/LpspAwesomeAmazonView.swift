import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/amazon
// Meliwat/awesome-ios-design-md/misc/amazon/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAmazonView: View {
    var body: some View {
        LpspAmazonShowroomRoot(store: LpspAmazonStore())
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

fileprivate struct LpspAmazonAmazonTopNav: View {
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

fileprivate struct LpspAmazonRoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                          cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    }
}

fileprivate struct LpspAmazonAmazonAddToCartButton: View {
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

fileprivate struct LpspAmazonAmazonBuyNowButton: View {
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

fileprivate struct LpspAmazonAmazonProductCard: View {
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

fileprivate struct LpspAmazonAmazonPDPPriceBlock: View {
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
                    .font(LpspAmazonFonts.amzPriceHero.weight(.bold))
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

fileprivate struct LpspAmazonAmazonLightningDealBanner: View {
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

fileprivate struct LpspAmazonAmazonQuantityStepper: View {
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


fileprivate struct LpspAmazonAddToCartToast: View {
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

// MARK: - Données & état (showroom Lost Phone)

fileprivate struct LpspAmazonProduct: Identifiable, Hashable {
    let id: String
    let title: String
    let brand: String
    let rating: Double
    let reviewCount: Int
    let dollars: Int
    let cents: Int
    let listPriceDollars: Int?
    let listPriceCents: Int?
    let savingsLine: String?
    let isPrime: Bool
    let deliveryText: String
    let deliveryLocation: String
    let inStock: Bool
    let symbol: String
    let category: String
    let relatedIDs: [String]
    let limitedDeal: Bool
}

fileprivate struct LpspAmazonOrder: Identifiable {
    let id: String
    let title: String
    let dateLabel: String
    let total: String
    let status: String
}

private enum LpspAmazonTab: CaseIterable {
    case home, menu, cart, you, search

    var label: String {
        switch self {
        case .home: "Home"
        case .menu: "Menu"
        case .cart: "Cart"
        case .you: "You"
        case .search: "Search"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .menu: "line.3.horizontal"
        case .cart: "cart.fill"
        case .you: "person.fill"
        case .search: "magnifyingglass"
        }
    }
}

@MainActor
fileprivate final class LpspAmazonStore: ObservableObject {
    @Published var selectedTab: LpspAmazonTab = .home
    @Published var selectedProductID: String? = LpspAmazonShowroomData.defaultProductID
    @Published var cart: [String: Int] = [:]
    @Published var searchQuery = ""
    @Published var quantity = 1
    @Published var showAddToCartToast = false
    @Published var selectedCategory = "All"

    let products: [LpspAmazonProduct] = LpspAmazonShowroomData.products
    let orders: [LpspAmazonOrder] = LpspAmazonShowroomData.orders
    let menuCategories = ["All", "Electronics", "Tools", "Deals", "Home"]

    var selectedProduct: LpspAmazonProduct? {
        guard let selectedProductID else { return nil }
        return products.first { $0.id == selectedProductID }
    }

    var cartItemCount: Int {
        cart.values.reduce(0, +)
    }

    var cartSubtotalCents: Int {
        cart.reduce(0) { partial, entry in
            guard let product = products.first(where: { $0.id == entry.key }) else { return partial }
            return partial + (product.dollars * 100 + product.cents) * entry.value
        }
    }

    var cartSubtotalLabel: String {
        formatUSD(cents: cartSubtotalCents)
    }

    var filteredProducts: [LpspAmazonProduct] {
        let categoryFiltered = products.filter {
            selectedCategory == "All" || $0.category == selectedCategory
        }
        let q = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return categoryFiltered }
        return categoryFiltered.filter {
            $0.title.lowercased().contains(q) || $0.brand.lowercased().contains(q)
        }
    }

    func product(id: String) -> LpspAmazonProduct? {
        products.first { $0.id == id }
    }

    func openProduct(_ id: String) {
        selectedProductID = id
        quantity = 1
        selectedTab = .home
    }

    func closeProduct() {
        selectedProductID = nil
    }

    func addToCart(productID: String? = nil, qty: Int? = nil) {
        let id = productID ?? selectedProductID ?? LpspAmazonShowroomData.defaultProductID
        let amount = qty ?? quantity
        cart[id, default: 0] += amount
        withAnimation { showAddToCartToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            withAnimation { self.showAddToCartToast = false }
        }
    }

    func buyNow() {
        addToCart()
        selectedTab = .cart
    }

    func updateCartQuantity(productID: String, delta: Int) {
        let current = cart[productID, default: 0] + delta
        if current <= 0 {
            cart.removeValue(forKey: productID)
        } else {
            cart[productID] = current
        }
    }

    static func formatUSD(cents: Int) -> String {
        String(format: "$%.2f", Double(cents) / 100.0)
    }

    static func formatUSD(dollars: Int, cents: Int) -> String {
        formatUSD(cents: dollars * 100 + cents)
    }
}

private enum LpspAmazonShowroomData {
    static let defaultProductID = "airpods-pro"

    static let products: [LpspAmazonProduct] = [
        .init(
            id: "airpods-pro",
            title: "Apple AirPods Pro (2nd Generation) with MagSafe Charging Case (USB-C)",
            brand: "Apple",
            rating: 5.0,
            reviewCount: 4231,
            dollars: 249,
            cents: 0,
            listPriceDollars: 299,
            listPriceCents: 0,
            savingsLine: "Save $50 (17%)",
            isPrime: true,
            deliveryText: "FREE delivery Tomorrow",
            deliveryLocation: "Brooklyn, 11201",
            inStock: true,
            symbol: "airpodspro",
            category: "Electronics",
            relatedIDs: ["usb-c-cable", "airpods-case"],
            limitedDeal: true
        ),
        .init(
            id: "nitrile-gloves",
            title: "Gants nitrile noirs — boîte 100, taille M (maintenance)",
            brand: "MedSupply",
            rating: 4.6,
            reviewCount: 892,
            dollars: 18,
            cents: 99,
            listPriceDollars: 24,
            listPriceCents: 99,
            savingsLine: "Save 24%",
            isPrime: true,
            deliveryText: "FREE delivery ven. 20 juin",
            deliveryLocation: "Paris 11e",
            inStock: true,
            symbol: "hand.raised.fill",
            category: "Tools",
            relatedIDs: ["work-light", "sd-card"],
            limitedDeal: false
        ),
        .init(
            id: "sd-card",
            title: "Carte microSD 128 Go — sans logo, vitesse U3",
            brand: "SanDisk",
            rating: 4.8,
            reviewCount: 12400,
            dollars: 22,
            cents: 49,
            listPriceDollars: nil,
            listPriceCents: nil,
            savingsLine: nil,
            isPrime: true,
            deliveryText: "FREE delivery demain",
            deliveryLocation: "Paris 11e",
            inStock: true,
            symbol: "memorychip",
            category: "Electronics",
            relatedIDs: ["gopro-mount"],
            limitedDeal: false
        ),
        .init(
            id: "gopro-mount",
            title: "Support caméra magnétique discret — collerette HVAC",
            brand: "ProMount",
            rating: 4.2,
            reviewCount: 156,
            dollars: 34,
            cents: 95,
            listPriceDollars: 44,
            listPriceCents: 0,
            savingsLine: "Limited time deal",
            isPrime: true,
            deliveryText: "FREE delivery 18 juin",
            deliveryLocation: "Gennevilliers",
            inStock: true,
            symbol: "camera.fill",
            category: "Tools",
            relatedIDs: ["sd-card", "work-light"],
            limitedDeal: true
        ),
        .init(
            id: "work-light",
            title: "Lampe frontale LED 600 lm — mode rouge",
            brand: "NightOps",
            rating: 4.5,
            reviewCount: 2103,
            dollars: 29,
            cents: 99,
            listPriceDollars: nil,
            listPriceCents: nil,
            savingsLine: nil,
            isPrime: true,
            deliveryText: "FREE delivery demain",
            deliveryLocation: "Paris 11e",
            inStock: true,
            symbol: "flashlight.on.fill",
            category: "Tools",
            relatedIDs: ["nitrile-gloves"],
            limitedDeal: false
        ),
        .init(
            id: "usb-c-cable",
            title: "Câble USB-C 1 m — charge rapide",
            brand: "Anker",
            rating: 4.7,
            reviewCount: 9821,
            dollars: 11,
            cents: 99,
            listPriceDollars: nil,
            listPriceCents: nil,
            savingsLine: nil,
            isPrime: true,
            deliveryText: "FREE delivery Tomorrow",
            deliveryLocation: "Brooklyn, 11201",
            inStock: true,
            symbol: "cable.connector",
            category: "Electronics",
            relatedIDs: ["airpods-pro"],
            limitedDeal: false
        ),
        .init(
            id: "airpods-case",
            title: "Coque silicone AirPods Pro — noir",
            brand: "Elago",
            rating: 4.4,
            reviewCount: 3310,
            dollars: 12,
            cents: 99,
            listPriceDollars: 16,
            listPriceCents: 99,
            savingsLine: "Save 23%",
            isPrime: true,
            deliveryText: "FREE delivery Tomorrow",
            deliveryLocation: "Brooklyn, 11201",
            inStock: true,
            symbol: "airpodcase",
            category: "Electronics",
            relatedIDs: ["airpods-pro"],
            limitedDeal: false
        ),
    ]

    static let orders: [LpspAmazonOrder] = [
        .init(id: "o1", title: "Gants nitrile noirs ×2", dateLabel: "12 juin", total: "$37.98", status: "Delivered"),
        .init(id: "o2", title: "Carte microSD 128 Go", dateLabel: "3 juin", total: "$22.49", status: "Delivered"),
        .init(id: "o3", title: "Support caméra magnétique", dateLabel: "En cours", total: "$34.95", status: "Arriving Jun 18"),
    ]
}

// MARK: - Écrans showroom

private struct LpspAmazonShowroomRoot: View {
    @ObservedObject var store: LpspAmazonStore

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .home:
                        LpspAmazonHomeScreen(store: store)
                    case .menu:
                        LpspAmazonMenuScreen(store: store)
                    case .cart:
                        LpspAmazonCartScreen(store: store)
                    case .you:
                        LpspAmazonYouScreen(store: store)
                    case .search:
                        LpspAmazonSearchScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspAmazonTabBar(store: store)
            }

            if store.showAddToCartToast {
                LpspAmazonAddToCartToast(visible: $store.showAddToCartToast)
            }
        }
        .background(LpspAmazonTokens.amzCanvas.ignoresSafeArea())
    }
}

private struct LpspAmazonTabBar: View {
    @ObservedObject var store: LpspAmazonStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspAmazonTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                            if tab == .cart, store.cartItemCount > 0 {
                                Text("\(store.cartItemCount)")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(3)
                                    .background(Circle().fill(LpspAmazonTokens.amzAlertRed))
                                    .offset(x: 8, y: -6)
                            }
                        }
                        Text(tab.label)
                            .font(LpspAmazonFonts.amzTab)
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspAmazonTokens.amzYellow : LpspAmazonTokens.amzTextSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspAmazonTokens.amzCanvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspAmazonTokens.amzDivider).frame(height: 0.5)
        }
    }
}

private struct LpspAmazonGridProductCard: View {
    let product: LpspAmazonProduct

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            LpspAmazonProductImage(symbol: product.symbol)
                .aspectRatio(1, contentMode: .fit)

            Text(product.title)
                .font(LpspAmazonFonts.amzProductTitle)
                .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { i in
                    Image(systemName: Double(i) < product.rating ? "star.fill" : "star")
                        .font(.system(size: 12))
                        .foregroundStyle(LpspAmazonTokens.amzRatingGold)
                }
                Text(" (\(product.reviewCount.formatted()))")
                    .font(LpspAmazonFonts.amzRatingCount)
                    .foregroundStyle(LpspAmazonTokens.amzPrimeTeal)
            }

            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(LpspAmazonStore.formatUSD(dollars: product.dollars, cents: product.cents))
                    .font(LpspAmazonFonts.amzPriceCard.weight(.bold))
                    .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                if let listD = product.listPriceDollars {
                    Text(LpspAmazonStore.formatUSD(dollars: listD, cents: product.listPriceCents ?? 0))
                        .font(LpspAmazonFonts.amzPriceStruck)
                        .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                        .strikethrough()
                }
            }

            if product.isPrime {
                HStack(spacing: 4) {
                    Text("prime")
                        .font(LpspAmazonFonts.amzPrimeBadge)
                        .foregroundStyle(LpspAmazonTokens.amzPrimeSky)
                    Text(product.deliveryText.replacingOccurrences(of: "FREE delivery ", with: ""))
                        .font(LpspAmazonFonts.amzDelivery)
                        .foregroundStyle(LpspAmazonTokens.amzSuccessGreen)
                }
            }
        }
        .padding(8)
        .background(LpspAmazonTokens.amzCanvas)
    }
}

private struct LpspAmazonProductImage: View {
    let symbol: String

    private var systemName: String {
        switch symbol {
        case "airpodspro", "airpodcase": "airpodspro"
        case "sdcard.fill": "memorychip"
        default: symbol
        }
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(LpspAmazonTokens.amzSurfaceMuted)
            .overlay(
                Image(systemName: systemName)
                    .font(.system(size: 44))
                    .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
            )
    }
}

private struct LpspAmazonHomeScreen: View {
    @ObservedObject var store: LpspAmazonStore

    var body: some View {
        if let product = store.selectedProduct {
            LpspAmazonPDPScreen(store: store, product: product)
        } else {
            ScrollView {
                VStack(spacing: 0) {
                    LpspAmazonAmazonTopNav(onSearch: { store.selectedTab = .search }, onMicOrScan: {})
                    LpspAmazonDealStrip()
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                        ForEach(store.filteredProducts) { product in
                            Button { store.openProduct(product.id) } label: {
                                LpspAmazonGridProductCard(product: product)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 16)
                }
            }
        }
    }
}

private struct LpspAmazonDealStrip: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(["Deals", "Prime", "Electronics", "Tools"], id: \.self) { label in
                    Text(label)
                        .font(LpspAmazonFonts.amzButtonSmall)
                        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LpspAmazonTokens.amzSurfaceMuted)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(LpspAmazonTokens.amzBorderDefault, lineWidth: 1))
                        )
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
        .background(LpspAmazonTokens.amzSecondaryNavy)
    }
}

private struct LpspAmazonPDPScreen: View {
    @ObservedObject var store: LpspAmazonStore
    let product: LpspAmazonProduct

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Button { store.closeProduct() } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                    }
                    Text(product.title)
                        .font(LpspAmazonFonts.amzProductTitle)
                        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)

                LpspAmazonAmazonTopNav(onSearch: { store.selectedTab = .search }, onMicOrScan: {})

                VStack(alignment: .leading, spacing: 4) {
                    Text(product.deliveryLocation)
                        .font(LpspAmazonFonts.amzBody.weight(.semibold))
                        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                    Text("Visit the \(product.brand) Store")
                        .font(LpspAmazonFonts.amzMeta)
                        .foregroundStyle(LpspAmazonTokens.amzPrimeTeal)
                }
                .padding(.horizontal, 16)

                LpspAmazonProductImage(symbol: product.symbol)
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                    .padding(.horizontal, 24)

                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .font(LpspAmazonFonts.amzPDPTitle)
                        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)

                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { i in
                            Image(systemName: Double(i) < product.rating ? "star.fill" : "star")
                                .font(.system(size: 14))
                                .foregroundStyle(LpspAmazonTokens.amzRatingGold)
                        }
                        Text("\(product.reviewCount.formatted()) ratings")
                            .font(LpspAmazonFonts.amzRatingCount)
                            .foregroundStyle(LpspAmazonTokens.amzPrimeTeal)
                    }

                    if product.limitedDeal {
                        Text("Limited time deal")
                            .font(LpspAmazonFonts.amzDelivery.weight(.bold))
                            .foregroundStyle(LpspAmazonTokens.amzPriceRed)
                    }

                    LpspAmazonAmazonPDPPriceBlock(
                        dollars: product.dollars,
                        cents: product.cents,
                        originalPrice: product.listPriceDollars.map {
                            "List Price: \(LpspAmazonStore.formatUSD(dollars: $0, cents: product.listPriceCents ?? 0))"
                        },
                        savingsLine: product.savingsLine,
                        deliveryText: product.deliveryText
                    )

                    if product.inStock {
                        Text("In Stock")
                            .font(LpspAmazonFonts.amzBody.weight(.semibold))
                            .foregroundStyle(LpspAmazonTokens.amzSuccessGreen)
                    }

                    HStack(spacing: 12) {
                        Text("Qty:")
                            .font(LpspAmazonFonts.amzBody)
                        LpspAmazonAmazonQuantityStepper(count: $store.quantity)
                    }

                    LpspAmazonAmazonAddToCartButton { store.addToCart() }
                    LpspAmazonAmazonBuyNowButton { store.buyNow() }
                }
                .padding(.horizontal, 16)

                if !product.relatedIDs.isEmpty {
                    Text("Frequently bought together")
                        .font(LpspAmazonFonts.amzSection)
                        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(product.relatedIDs.compactMap { store.product(id: $0) }) { related in
                                Button { store.openProduct(related.id) } label: {
                                    LpspAmazonGridProductCard(product: related)
                                        .frame(width: 168)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.bottom, 24)
        }
    }
}

private struct LpspAmazonMenuScreen: View {
    @ObservedObject var store: LpspAmazonStore

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LpspAmazonAmazonTopNav(onSearch: { store.selectedTab = .search }, onMicOrScan: {})
                VStack(alignment: .leading, spacing: 0) {
                    Text("Shop by Category")
                        .font(LpspAmazonFonts.amzSection)
                        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                        .padding(16)
                    ForEach(store.menuCategories, id: \.self) { category in
                        Button {
                            store.selectedCategory = category
                            store.closeProduct()
                            store.selectedTab = .home
                        } label: {
                            HStack {
                                Text(category)
                                    .font(LpspAmazonFonts.amzBody)
                                    .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundStyle(LpspAmazonTokens.amzTextTertiary)
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 48)
                        }
                        .buttonStyle(.plain)
                        Divider().overlay(LpspAmazonTokens.amzDivider)
                    }
                }
            }
        }
    }
}

private struct LpspAmazonCartScreen: View {
    @ObservedObject var store: LpspAmazonStore

    var body: some View {
        NavigationStack {
            Group {
                if store.cart.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "cart")
                            .font(.system(size: 48))
                            .foregroundStyle(LpspAmazonTokens.amzTextTertiary)
                        Text("Your Amazon Cart is empty")
                            .font(LpspAmazonFonts.amzSection)
                            .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                        Button("Shop today's deals") {
                            store.closeProduct()
                            store.selectedTab = .home
                        }
                        .font(LpspAmazonFonts.amzButton)
                        .foregroundStyle(LpspAmazonTokens.amzPrimeTeal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(Array(store.cart.keys.sorted()), id: \.self) { productID in
                            if let product = store.product(id: productID) {
                                HStack(spacing: 12) {
                                    LpspAmazonProductImage(symbol: product.symbol)
                                        .frame(width: 64, height: 64)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(product.title)
                                            .font(LpspAmazonFonts.amzProductTitle)
                                            .lineLimit(2)
                                        Text(LpspAmazonStore.formatUSD(dollars: product.dollars, cents: product.cents))
                                            .font(LpspAmazonFonts.amzPriceCard.weight(.bold))
                                    }
                                    Spacer()
                                    Text("×\(store.cart[productID] ?? 0)")
                                        .font(LpspAmazonFonts.amzBody)
                                        .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        store.cart.removeValue(forKey: productID)
                                    } label: {
                                        Label("Remove", systemImage: "trash")
                                    }
                                }
                            }
                        }

                        Section {
                            HStack {
                                Text("Subtotal")
                                    .font(LpspAmazonFonts.amzBody.weight(.semibold))
                                Spacer()
                                Text(store.cartSubtotalLabel)
                                    .font(LpspAmazonFonts.amzPriceCard.weight(.bold))
                            }
                            LpspAmazonAmazonBuyNowButton {}
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspAmazonYouScreen: View {
    @ObservedObject var store: LpspAmazonStore

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspAmazonTokens.amzSurfaceMuted)
                            .frame(width: 48, height: 48)
                            .overlay(Text("MG").font(.system(size: 16, weight: .semibold)))
                        VStack(alignment: .leading) {
                            Text("Hello, Mathieu")
                                .font(LpspAmazonFonts.amzSection)
                            Text("Paris 11e · Prime member")
                                .font(LpspAmazonFonts.amzMeta)
                                .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                        }
                    }
                }

                Section("Your Orders") {
                    ForEach(store.orders) { order in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(order.title)
                                .font(LpspAmazonFonts.amzProductTitle)
                            HStack {
                                Text(order.dateLabel)
                                Text("·")
                                Text(order.status)
                                    .foregroundStyle(order.status.contains("Delivered") ? LpspAmazonTokens.amzSuccessGreen : LpspAmazonTokens.amzPrimeTeal)
                            }
                            .font(LpspAmazonFonts.amzMeta)
                            .foregroundStyle(LpspAmazonTokens.amzTextSecondary)
                            Text(order.total)
                                .font(LpspAmazonFonts.amzPriceCard.weight(.bold))
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("You")
        }
    }
}

private struct LpspAmazonSearchScreen: View {
    @ObservedObject var store: LpspAmazonStore

    var body: some View {
        VStack(spacing: 0) {
            LpspAmazonAmazonTopNav(onSearch: {}, onMicOrScan: {})
            TextField("Search Amazon", text: $store.searchQuery)
                .font(LpspAmazonFonts.amzSearchPlaceholder)
                .padding(12)
                .background(LpspAmazonTokens.amzSurfaceMuted)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)

            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(store.filteredProducts) { product in
                        Button { store.openProduct(product.id) } label: {
                            HStack(spacing: 12) {
                                LpspAmazonProductImage(symbol: product.symbol)
                                    .frame(width: 72, height: 72)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.title)
                                        .font(LpspAmazonFonts.amzProductTitle)
                                        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                                        .lineLimit(2)
                                    Text(LpspAmazonStore.formatUSD(dollars: product.dollars, cents: product.cents))
                                        .font(LpspAmazonFonts.amzPriceCard.weight(.bold))
                                        .foregroundStyle(LpspAmazonTokens.amzTextPrimary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                        }
                        .buttonStyle(.plain)
                        Divider().overlay(LpspAmazonTokens.amzDivider)
                    }
                }
            }
        }
    }
}

import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/deliveroo
// Meliwat/awesome-ios-design-md/food/deliveroo/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDeliverooView: View {
    var body: some View {
        LpspDeliverooShowroomRoot(store: LpspDeliverooStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspDeliverooTokens {
    // MARK: - Brand (the ONE color)
    static let rooTeal        = Color(red: 0.000, green: 0.800, blue: 0.737) // #00CCBC
    static let rooTealPressed = Color(red: 0.000, green: 0.663, blue: 0.612) // #00A99C
    static let rooTealInk     = Color(red: 0.000, green: 0.216, blue: 0.200) // #003733  (on-teal content)

    // MARK: - Membership & Promo
    static let rooPlusMint    = Color(red: 0.769, green: 0.957, blue: 0.937) // #C4F4EF
    static let rooPromoGold   = Color(red: 1.000, green: 0.757, blue: 0.000) // #FFC100

    // MARK: - Canvas & Surfaces (Light)
    static let rooCanvas        = Color.white                                   // #FFFFFF
    static let rooSurface1      = Color(red: 0.957, green: 0.957, blue: 0.949) // #F4F4F2
    static let rooSurface2      = Color(red: 0.918, green: 0.918, blue: 0.910) // #EAEAE8
    static let rooDivider       = Color(red: 0.910, green: 0.910, blue: 0.902) // #E8E8E6

    // MARK: - Canvas & Surfaces (Dark)
    static let rooDarkCanvas    = Color(red: 0.071, green: 0.071, blue: 0.071) // #121212
    static let rooDarkSurface1  = Color(red: 0.110, green: 0.110, blue: 0.118) // #1C1C1E
    static let rooDarkSurface2  = Color(red: 0.149, green: 0.149, blue: 0.161) // #262629
    static let rooDarkDivider   = Color(red: 0.173, green: 0.173, blue: 0.180) // #2C2C2E

    // MARK: - Text
    static let rooTextPrimary    = Color(red: 0.114, green: 0.114, blue: 0.106) // #1D1D1B
    static let rooTextSecondary  = Color(red: 0.420, green: 0.420, blue: 0.420) // #6B6B6B
    static let rooTextTertiary   = Color(red: 0.627, green: 0.627, blue: 0.627) // #A0A0A0
    static let rooDarkTextPrimary = Color(red: 0.957, green: 0.957, blue: 0.949) // #F4F4F2

    // MARK: - Semantic
    static let rooError       = Color(red: 0.886, green: 0.282, blue: 0.239) // #E2483D
}

private enum LpspDeliverooFonts {
    static let rooScreenTitle    = Font.system(size: 32, weight: .regular)
    static let rooRestaurantHero = Font.system(size: 26, weight: .regular)
    static let rooSection        = Font.system(size: 22, weight: .regular)
    static let rooSubsection     = Font.system(size: 20, weight: .regular)
    static let rooRestaurantName = Font.system(size: 16, weight: .regular)
    static let rooMenuName       = Font.system(size: 15, weight: .regular)
    static let rooBody           = Font.system(size: 15, weight: .regular)
    static let rooPrice          = Font.system(size: 14, weight: .regular)
    static let rooMeta           = Font.system(size: 14, weight: .regular)
    static let rooFeePill        = Font.system(size: 13, weight: .regular)
    static let rooBadge          = Font.system(size: 12, weight: .regular)
    static let rooButton         = Font.system(size: 16, weight: .regular)
    static let rooTab            = Font.system(size: 10, weight: .regular)
    static let rooCaption        = Font.system(size: 12, weight: .regular)
}

fileprivate extension View {
    func rooTabular() -> some View { self.monospacedDigit() }
}

fileprivate struct LpspDeliverooFoodImage: View {
    let accent: Color
    let symbol: String

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [accent.opacity(0.55), accent.opacity(0.25)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: symbol)
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(.white.opacity(0.85))
        }
        .aspectRatio(5/3, contentMode: .fill)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

fileprivate struct LpspDeliverooRestaurantCard: View {
    let name: String
    let meta: String
    let rating: Double
    let fee: String
    let badge: String?
    let badgeIsPromo: Bool
    let accent: Color
    let symbol: String
    var isSaved: Bool = false
    let onTap: () -> Void
    let onSave: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topLeading) {
                    LpspDeliverooFoodImage(accent: accent, symbol: symbol)

                    if let badge {
                        Text(badge)
                            .font(LpspDeliverooFonts.rooBadge)
                            .foregroundStyle(badgeIsPromo ? Color(red: 0.102, green: 0.071, blue: 0.024) : LpspDeliverooTokens.rooTealInk)
                            .padding(.horizontal, 9).padding(.vertical, 4)
                            .background(badgeIsPromo ? LpspDeliverooTokens.rooPromoGold : LpspDeliverooTokens.rooTeal,
                                        in: RoundedRectangle(cornerRadius: 6))
                            .padding(10)
                    }

                    Button(action: onSave) {
                        Image(systemName: isSaved ? "heart.fill" : "heart")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(isSaved ? LpspDeliverooTokens.rooTeal : .white)
                            .frame(width: 32, height: 32)
                            .background(Color.black.opacity(0.4), in: Circle())
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(10)
                }

                HStack {
                    Text(name).font(LpspDeliverooFonts.rooRestaurantName).foregroundStyle(LpspDeliverooTokens.rooDarkTextPrimary)
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill").font(.system(size: 13)).foregroundStyle(LpspDeliverooTokens.rooTeal)
                        Text(String(format: "%.1f", rating)).font(LpspDeliverooFonts.rooFeePill).foregroundStyle(LpspDeliverooTokens.rooDarkTextPrimary)
                    }
                }
                .padding(.top, 10)

                Text(meta).font(LpspDeliverooFonts.rooMeta).foregroundStyle(LpspDeliverooTokens.rooTextTertiary).padding(.top, 4)

                LpspDeliverooFeePill(text: fee).padding(.top, 8)
            }
            .padding(.bottom, 22)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspDeliverooFeePill: View {
    let text: String
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "bicycle").font(.system(size: 11, weight: .bold)).foregroundStyle(LpspDeliverooTokens.rooTeal)
            Text(text).font(LpspDeliverooFonts.rooFeePill).foregroundStyle(LpspDeliverooTokens.rooTextPrimary)
        }
        .padding(.horizontal, 10).padding(.vertical, 5)
        .background(LpspDeliverooTokens.rooSurface1, in: Capsule())
    }
}

fileprivate struct LpspDeliverooMenuItemRow: View {
    let name: String
    let desc: String
    let price: String
    let accent: Color
    let quantity: Int
    let onAdd: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(name).font(LpspDeliverooFonts.rooMenuName).foregroundStyle(LpspDeliverooTokens.rooTextPrimary)
                Text(desc)
                    .font(LpspDeliverooFonts.rooBody.weight(.regular))
                    .foregroundStyle(LpspDeliverooTokens.rooTextSecondary)
                    .lineLimit(2)
                HStack(spacing: 8) {
                    Text(price).font(LpspDeliverooFonts.rooPrice).foregroundStyle(LpspDeliverooTokens.rooTextPrimary)
                    if quantity > 0 {
                        Text("× \(quantity)")
                            .font(LpspDeliverooFonts.rooCaption.weight(.semibold))
                            .foregroundStyle(LpspDeliverooTokens.rooTeal)
                    }
                }
                .padding(.top, 4)
            }
            Spacer(minLength: 8)
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(accent.opacity(0.2))
                    .frame(width: 84, height: 84)
                    .overlay(Image(systemName: "fork.knife").foregroundStyle(accent))
                Button(action: onAdd) {
                    Image(systemName: quantity > 0 ? "plus" : "plus")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(LpspDeliverooTokens.rooTealInk)
                        .frame(width: 28, height: 28)
                        .background(LpspDeliverooTokens.rooTeal, in: Circle())
                        .shadow(color: .black.opacity(0.18), radius: 3, y: 2)
                }
                .offset(x: 8, y: 10)
            }
        }
        .padding(.vertical, 14)
        .overlay(alignment: .bottom) { Rectangle().fill(LpspDeliverooTokens.rooDivider).frame(height: 1) }
    }
}

fileprivate struct LpspDeliverooQuantityStepper: View {
    @Binding var quantity: Int

    var body: some View {
        HStack(spacing: 14) {
            control("minus") { if quantity > 1 { quantity -= 1 } }
                .opacity(quantity > 1 ? 1 : 0.35)
            Text("\(quantity)").font(LpspDeliverooFonts.rooButton).rooTabular()
                .foregroundStyle(LpspDeliverooTokens.rooTextPrimary)
                .frame(minWidth: 18)
                .contentTransition(.numericText())
            control("plus") { quantity += 1 }
        }
        .sensoryFeedback(.selection, trigger: quantity)
    }

    private func control(_ symbol: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(LpspDeliverooTokens.rooTealInk)
                .frame(width: 32, height: 32)
                .background(LpspDeliverooTokens.rooTeal, in: Circle())
        }
    }
}

fileprivate struct LpspDeliverooBasketBar: View {
    let itemCount: Int
    let total: String
    let onTap: () -> Void
    @State private var pulse = false

    var body: some View {
        Button(action: onTap) {
            Text("View basket · \(itemCount) items · \(total)")
                .font(LpspDeliverooFonts.rooButton)
                .foregroundStyle(LpspDeliverooTokens.rooTealInk)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(LpspDeliverooTokens.rooTeal, in: Capsule())
        }
        .buttonStyle(.plain)
        .scaleEffect(pulse ? 1.03 : 1.0)
        .padding(.horizontal, 16)
        .onChange(of: itemCount) { _, _ in
            withAnimation(.easeOut(duration: 0.1)) { pulse = true }
            withAnimation(.easeOut(duration: 0.1).delay(0.1)) { pulse = false }
        }
    }
}

fileprivate struct LpspDeliverooCategoryRow: View {
    struct LpspDeliverooCat: Identifiable { let id: String; let symbol: String; let label: String }
    let cats: [LpspDeliverooCat]
    @Binding var selectedID: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(cats) { cat in
                    let isSelected = cat.id == selectedID
                    VStack(spacing: 7) {
                        Image(systemName: cat.symbol)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(isSelected ? LpspDeliverooTokens.rooTealInk : LpspDeliverooTokens.rooTeal)
                            .frame(width: 54, height: 54)
                            .background(isSelected ? LpspDeliverooTokens.rooTeal : LpspDeliverooTokens.rooDarkSurface2,
                                        in: RoundedRectangle(cornerRadius: 16))
                        Text(cat.label)
                            .font(LpspDeliverooFonts.rooCaption.weight(.semibold))
                            .foregroundStyle(isSelected ? LpspDeliverooTokens.rooDarkTextPrimary : LpspDeliverooTokens.rooTextTertiary)
                    }
                    .onTapGesture { withAnimation(.easeOut(duration: 0.15)) { selectedID = cat.id } }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

fileprivate struct LpspDeliverooRooButton: View {
    let title: String
    let action: () -> Void
    var style: LpspDeliverooStyle = .teal
    enum LpspDeliverooStyle { case teal, dark }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(style == .teal ? LpspDeliverooFonts.rooButton : LpspDeliverooFonts.rooButton)
                .foregroundStyle(style == .teal ? LpspDeliverooTokens.rooTealInk : .white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(style == .teal ? LpspDeliverooTokens.rooTeal : LpspDeliverooTokens.rooTextPrimary, in: Capsule())
        }
        .buttonStyle(.plain)
    }
}
// Checkout: LpspDeliverooRooButton(title: "Checkout · £24.50", action: {}, style: .dark)


fileprivate struct LpspDeliverooDeliverooTheme: ViewModifier {
    @Environment(\.colorScheme) var scheme

    func body(content: Content) -> some View {
        content
            .background(scheme == .dark ? LpspDeliverooTokens.rooDarkCanvas : LpspDeliverooTokens.rooCanvas)
            .foregroundStyle(scheme == .dark ? LpspDeliverooTokens.rooDarkTextPrimary : LpspDeliverooTokens.rooTextPrimary)
    }
}

fileprivate extension View {
    func deliverooTheme() -> some View { modifier(LpspDeliverooDeliverooTheme()) }
}

// MARK: - Données & état

fileprivate struct LpspDeliverooShowroomMenuItem: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let priceCents: Int
}

fileprivate struct LpspDeliverooShowroomRestaurant: Identifiable, Hashable {
    let id: String
    let name: String
    let cuisine: String
    let eta: String
    let rating: Double
    let deliveryFee: String
    let minOrder: String
    let badge: String?
    let badgeIsPromo: Bool
    let categoryID: String
    let accent: Color
    let symbol: String
    let menu: [LpspDeliverooShowroomMenuItem]
}

fileprivate struct LpspDeliverooShowroomOrder: Identifiable, Hashable {
    let id: String
    let restaurantName: String
    let itemsSummary: String
    let totalLabel: String
    let dateLabel: String
    let status: LpspDeliverooOrderStatus
    let etaLabel: String?
}

fileprivate enum LpspDeliverooOrderStatus: String, Hashable {
    case preparing, onTheWay, delivered, cancelled
}

private enum LpspDeliverooTab: CaseIterable {
    case home, search, orders, favourites, account

    var label: String {
        switch self {
        case .home: "Accueil"
        case .search: "Rechercher"
        case .orders: "Commandes"
        case .favourites: "Favoris"
        case .account: "Compte"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .search: "magnifyingglass"
        case .orders: "bag.fill"
        case .favourites: "heart.fill"
        case .account: "person.crop.circle.fill"
        }
    }
}

@MainActor
fileprivate final class LpspDeliverooStore: ObservableObject {
    @Published var selectedTab: LpspDeliverooTab = .home
    @Published var selectedCategoryID = "all"
    @Published var searchQuery = ""
    @Published var basket: [String: Int] = [:]
    @Published var favouriteIDs: Set<String> = ["monop", "pizza-julien"]
    @Published var selectedRestaurantID: String?
    @Published var showBasket = false
    @Published var showCheckout = false
    @Published var activeOrder: LpspDeliverooShowroomOrder?
    @Published var pastOrders: [LpspDeliverooShowroomOrder]

    let address = "17 rue de la Roquette"
    let restaurants: [LpspDeliverooShowroomRestaurant]
    let categories: [LpspDeliverooCategoryRow.LpspDeliverooCat]

    init() {
        self.restaurants = LpspDeliverooShowroomData.restaurants
        self.categories = LpspDeliverooShowroomData.categories
        self.pastOrders = LpspDeliverooShowroomData.pastOrders
    }

    var filteredRestaurants: [LpspDeliverooShowroomRestaurant] {
        let categoryFiltered = restaurants.filter {
            selectedCategoryID == "all" || $0.categoryID == selectedCategoryID
        }
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return categoryFiltered }
        return categoryFiltered.filter {
            $0.name.lowercased().contains(query)
                || $0.cuisine.lowercased().contains(query)
                || $0.menu.contains { $0.name.lowercased().contains(query) }
        }
    }

    var favouriteRestaurants: [LpspDeliverooShowroomRestaurant] {
        restaurants.filter { favouriteIDs.contains($0.id) }
    }

    var basketItemCount: Int {
        basket.values.reduce(0, +)
    }

    var basketTotalCents: Int {
        basket.reduce(0) { partial, entry in
            guard let item = item(id: entry.key) else { return partial }
            return partial + item.priceCents * entry.value
        }
    }

    var basketTotalLabel: String {
        Self.formatEuro(basketTotalCents)
    }

    var selectedRestaurant: LpspDeliverooShowroomRestaurant? {
        guard let selectedRestaurantID else { return nil }
        return restaurants.first { $0.id == selectedRestaurantID }
    }

    func item(id: String) -> LpspDeliverooShowroomMenuItem? {
        restaurants.flatMap(\.menu).first { $0.id == id }
    }

    func quantity(for itemID: String) -> Int {
        basket[itemID, default: 0]
    }

    func addToBasket(itemID: String) {
        basket[itemID, default: 0] += 1
    }

    func toggleFavourite(_ restaurantID: String) {
        if favouriteIDs.contains(restaurantID) {
            favouriteIDs.remove(restaurantID)
        } else {
            favouriteIDs.insert(restaurantID)
        }
    }

    func openRestaurant(_ id: String) {
        selectedRestaurantID = id
    }

    func restaurant(containingItemID itemID: String) -> LpspDeliverooShowroomRestaurant? {
        restaurants.first { $0.menu.contains { $0.id == itemID } }
    }

    func placeOrder() {
        guard basketItemCount > 0 else { return }
        let restaurant = selectedRestaurant
            ?? basket.keys.compactMap { self.restaurant(containingItemID: $0) }.first
            ?? restaurants.first
        guard let restaurant else { return }
        let summary = basket.compactMap { id, qty -> String? in
            guard let item = item(id: id), qty > 0 else { return nil }
            return qty > 1 ? "\(item.name) ×\(qty)" : item.name
        }.joined(separator: ", ")
        activeOrder = LpspDeliverooShowroomOrder(
            id: "active-\(UUID().uuidString)",
            restaurantName: restaurant.name,
            itemsSummary: summary.isEmpty ? "Commande" : summary,
            totalLabel: basketTotalLabel,
            dateLabel: "Aujourd'hui",
            status: .preparing,
            etaLabel: restaurant.eta
        )
        basket.removeAll()
        showBasket = false
        showCheckout = false
        selectedTab = .orders
    }

    func advanceActiveOrder() {
        guard var order = activeOrder else { return }
        switch order.status {
        case .preparing:
            order = LpspDeliverooShowroomOrder(
                id: order.id, restaurantName: order.restaurantName, itemsSummary: order.itemsSummary,
                totalLabel: order.totalLabel, dateLabel: order.dateLabel, status: .onTheWay, etaLabel: "8 min"
            )
        case .onTheWay:
            order = LpspDeliverooShowroomOrder(
                id: order.id, restaurantName: order.restaurantName, itemsSummary: order.itemsSummary,
                totalLabel: order.totalLabel, dateLabel: order.dateLabel, status: .delivered, etaLabel: nil
            )
            pastOrders.insert(order, at: 0)
            activeOrder = nil
            return
        default:
            activeOrder = nil
            return
        }
        activeOrder = order
    }

    static func formatEuro(_ cents: Int) -> String {
        let euros = Double(cents) / 100.0
        return String(format: "%.2f €", euros).replacingOccurrences(of: ".", with: ",")
    }
}

private enum LpspDeliverooShowroomData {
    static let categories: [LpspDeliverooCategoryRow.LpspDeliverooCat] = [
        .init(id: "all", symbol: "sparkles", label: "Tout"),
        .init(id: "restaurants", symbol: "fork.knife", label: "Restos"),
        .init(id: "grocery", symbol: "cart.fill", label: "Courses"),
        .init(id: "fast", symbol: "bolt.fill", label: "Rapide"),
        .init(id: "treats", symbol: "birthday.cake.fill", label: "Gourmand"),
    ]

    static let restaurants: [LpspDeliverooShowroomRestaurant] = [
        .init(
            id: "monop",
            name: "Monop' Daily",
            cuisine: "Courses · Supermarché",
            eta: "15–25 min",
            rating: 4.5,
            deliveryFee: "1,99 € livraison · Min 15 €",
            minOrder: "15 €",
            badge: "Courses Hugo",
            badgeIsPromo: false,
            categoryID: "grocery",
            accent: .green,
            symbol: "cart.fill",
            menu: [
                .init(id: "m1", name: "Nuggets poulet Bonduelle", description: "450 g — les ronds, pas les strips", priceCents: 450),
                .init(id: "m2", name: "Compote pomme-fraise", description: "4 pots — sans pulpe", priceCents: 320),
                .init(id: "m3", name: "Céréales Chocapic", description: "Pas les autres — note Hugo", priceCents: 390),
                .init(id: "m4", name: "Jus d'orange Tropicana", description: "Sans pulpe impérativement", priceCents: 280),
            ]
        ),
        .init(
            id: "pizza-julien",
            name: "Pizza Julien",
            cuisine: "Italien · Pizza · Bastille",
            eta: "22–32 min",
            rating: 4.7,
            deliveryFee: "1,49 € livraison · Min 12 €",
            minOrder: "12 €",
            badge: "PLUS · Livraison offerte",
            badgeIsPromo: false,
            categoryID: "restaurants",
            accent: .red,
            symbol: "takeoutbag.and.cup.and.straw.fill",
            menu: [
                .init(id: "p1", name: "Margherita", description: "Tomate, mozzarella, basilic", priceCents: 1150),
                .init(id: "p2", name: "Regina", description: "Jambon, champignons, olives", priceCents: 1350),
                .init(id: "p3", name: "Tiramisu maison", description: "Portion individuelle", priceCents: 650),
            ]
        ),
        .init(
            id: "poke-bastille",
            name: "Poké House Bastille",
            cuisine: "Japonais · Poke · Healthy",
            eta: "25–35 min",
            rating: 4.6,
            deliveryFee: "2,49 € livraison · Min 14 €",
            minOrder: "14 €",
            badge: "−20 % jusqu'à 8 €",
            badgeIsPromo: true,
            categoryID: "restaurants",
            accent: .teal,
            symbol: "fish.fill",
            menu: [
                .init(id: "k1", name: "Poké saumon", description: "Riz, avocat, edamame", priceCents: 1350),
                .init(id: "k2", name: "Poké thon épicé", description: "Mangue, sésame", priceCents: 1420),
            ]
        ),
        .init(
            id: "boot-cafe",
            name: "Boot Café",
            cuisine: "Café · Brunch · Marais",
            eta: "28–38 min",
            rating: 4.8,
            deliveryFee: "2,99 € livraison · Min 18 €",
            minOrder: "18 €",
            badge: nil,
            badgeIsPromo: false,
            categoryID: "treats",
            accent: .brown,
            symbol: "cup.and.saucer.fill",
            menu: [
                .init(id: "b1", name: "Flat white", description: "Lait d'avoine", priceCents: 450),
                .init(id: "b2", name: "Banana bread", description: "Maison, beurre salé", priceCents: 550),
                .init(id: "b3", name: "Avocado toast", description: "Graines, citron", priceCents: 1250),
            ]
        ),
        .init(
            id: "tasty-chicken",
            name: "Tasty Chicken",
            cuisine: "Fast food · Poulet",
            eta: "18–28 min",
            rating: 4.2,
            deliveryFee: "0,99 € livraison · Min 10 €",
            minOrder: "10 €",
            badge: "Promo",
            badgeIsPromo: true,
            categoryID: "fast",
            accent: .orange,
            symbol: "flame.fill",
            menu: [
                .init(id: "t1", name: "Box nuggets 9 pcs", description: "Sauce barbecue", priceCents: 890),
                .init(id: "t2", name: "Menu enfant", description: "Nuggets + compote + jus", priceCents: 790),
            ]
        ),
    ]

    static let pastOrders: [LpspDeliverooShowroomOrder] = [
        .init(id: "o1", restaurantName: "Boot Café", itemsSummary: "Flat white, Banana bread", totalLabel: "12,40 €", dateLabel: "2 juin", status: .delivered, etaLabel: nil),
        .init(id: "o2", restaurantName: "Monop' Daily", itemsSummary: "Nuggets, compote, Chocapic", totalLabel: "18,60 €", dateLabel: "6 juin", status: .delivered, etaLabel: nil),
    ]
}

// MARK: - Écrans showroom

private struct LpspDeliverooShowroomRoot: View {
    @ObservedObject var store: LpspDeliverooStore

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .home:
                        LpspDeliverooHomeScreen(store: store)
                    case .search:
                        LpspDeliverooSearchScreen(store: store)
                    case .orders:
                        LpspDeliverooOrdersScreen(store: store)
                    case .favourites:
                        LpspDeliverooFavouritesScreen(store: store)
                    case .account:
                        LpspDeliverooAccountScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspDeliverooTabBar(store: store)
            }

            if store.basketItemCount > 0, store.selectedTab != .orders {
                LpspDeliverooBasketBar(
                    itemCount: store.basketItemCount,
                    total: store.basketTotalLabel
                ) {
                    store.showBasket = true
                }
                .padding(.bottom, 56)
            }
        }
        .preferredColorScheme(store.selectedTab == .home ? .dark : .light)
        .sheet(isPresented: $store.showBasket) {
            LpspDeliverooBasketSheet(store: store)
        }
        .sheet(item: Binding(
            get: { store.selectedRestaurant.map { LpspDeliverooRestaurantSheetID(id: $0.id) } },
            set: { store.selectedRestaurantID = $0?.id }
        )) { wrapper in
            if let restaurant = store.restaurants.first(where: { $0.id == wrapper.id }) {
                LpspDeliverooRestaurantSheet(store: store, restaurant: restaurant)
            }
        }
    }
}

private struct LpspDeliverooRestaurantSheetID: Identifiable {
    let id: String
}

private struct LpspDeliverooTabBar: View {
    @ObservedObject var store: LpspDeliverooStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspDeliverooTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                            if tab == .orders, store.activeOrder != nil {
                                Circle().fill(LpspDeliverooTokens.rooTeal).frame(width: 8, height: 8).offset(x: 6, y: -2)
                            }
                        }
                        Text(tab.label).font(LpspDeliverooFonts.rooTab)
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspDeliverooTokens.rooTeal : LpspDeliverooTokens.rooTextSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(store.selectedTab == .home ? LpspDeliverooTokens.rooDarkCanvas : LpspDeliverooTokens.rooCanvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspDeliverooTokens.rooDivider.opacity(0.5)).frame(height: 0.5)
        }
    }
}

private struct LpspDeliverooAddressHeader: View {
    @ObservedObject var store: LpspDeliverooStore

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Livrer à")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(LpspDeliverooTokens.rooTextTertiary)
                HStack(spacing: 4) {
                    Text(store.address)
                        .font(.system(size: 15))
                        .foregroundStyle(LpspDeliverooTokens.rooDarkTextPrimary)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(LpspDeliverooTokens.rooTextTertiary)
                }
            }
            Spacer()
            if store.basketItemCount > 0 {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bag")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspDeliverooTokens.rooDarkTextPrimary)
                    Text("\(store.basketItemCount)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(LpspDeliverooTokens.rooTealInk)
                        .padding(4)
                        .background(Circle().fill(LpspDeliverooTokens.rooTeal))
                        .offset(x: 8, y: -8)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}

private struct LpspDeliverooHomeScreen: View {
    @ObservedObject var store: LpspDeliverooStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                LpspDeliverooAddressHeader(store: store)

                Button { store.selectedTab = .search } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(LpspDeliverooTokens.rooTextTertiary)
                        Text("Restaurants, courses, plats…")
                            .font(LpspDeliverooFonts.rooBody)
                            .foregroundStyle(LpspDeliverooTokens.rooTextTertiary)
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(LpspDeliverooTokens.rooDarkSurface2, in: Capsule())
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("deliveroo plus")
                            .font(.system(size: 13))
                            .foregroundStyle(LpspDeliverooTokens.rooTeal)
                        Text("Livraison offerte sur cette commande")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(LpspDeliverooTokens.rooDarkTextPrimary)
                    }
                    Spacer()
                    Text("Rejoindre")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(LpspDeliverooTokens.rooTealInk)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(LpspDeliverooTokens.rooTeal, in: Capsule())
                }
                .padding(14)
                .background(LpspDeliverooTokens.rooDarkSurface1, in: RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)

                LpspDeliverooCategoryRow(cats: store.categories, selectedID: $store.selectedCategoryID)

                Text("Populaires près de vous")
                    .font(LpspDeliverooFonts.rooSection)
                    .foregroundStyle(LpspDeliverooTokens.rooDarkTextPrimary)
                    .padding(.horizontal, 16)

                ForEach(store.filteredRestaurants) { restaurant in
                    LpspDeliverooRestaurantCard(
                        name: restaurant.name,
                        meta: "\(restaurant.cuisine) · \(restaurant.eta)",
                        rating: restaurant.rating,
                        fee: restaurant.deliveryFee,
                        badge: restaurant.badge,
                        badgeIsPromo: restaurant.badgeIsPromo,
                        accent: restaurant.accent,
                        symbol: restaurant.symbol,
                        isSaved: store.favouriteIDs.contains(restaurant.id),
                        onTap: { store.openRestaurant(restaurant.id) },
                        onSave: { store.toggleFavourite(restaurant.id) }
                    )
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, store.basketItemCount > 0 ? 100 : 24)
        }
        .background(LpspDeliverooTokens.rooDarkCanvas.ignoresSafeArea())
    }
}

private struct LpspDeliverooSearchScreen: View {
    @ObservedObject var store: LpspDeliverooStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if store.searchQuery.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Suggestions")
                            .font(LpspDeliverooFonts.rooSection)
                            .padding(.horizontal, 16)
                        ForEach(["nuggets", "compote", "pizza", "Boot Café"], id: \.self) { term in
                            Button {
                                store.searchQuery = term
                            } label: {
                                Label(term.capitalized, systemImage: "magnifyingglass")
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                } else {
                    ScrollView {
                        ForEach(store.filteredRestaurants) { restaurant in
                            Button { store.openRestaurant(restaurant.id) } label: {
                                HStack(spacing: 12) {
                                    LpspDeliverooFoodImage(accent: restaurant.accent, symbol: restaurant.symbol)
                                        .frame(width: 72, height: 48)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(restaurant.name).font(LpspDeliverooFonts.rooRestaurantName)
                                        Text(restaurant.cuisine).font(LpspDeliverooFonts.rooMeta).foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .navigationTitle("Rechercher")
            .searchable(text: $store.searchQuery, prompt: "Plats, restaurants…")
            .background(LpspDeliverooTokens.rooCanvas.ignoresSafeArea())
        }
    }
}

private struct LpspDeliverooOrdersScreen: View {
    @ObservedObject var store: LpspDeliverooStore

    var body: some View {
        NavigationStack {
            List {
                if let active = store.activeOrder {
                    Section("En cours") {
                        LpspDeliverooOrderRow(order: active, isActive: true) {
                            store.advanceActiveOrder()
                        }
                    }
                }
                Section("Historique") {
                    ForEach(store.pastOrders) { order in
                        LpspDeliverooOrderRow(order: order, isActive: false) { }
                    }
                }
            }
            .navigationTitle("Commandes")
        }
    }
}

private struct LpspDeliverooOrderRow: View {
    let order: LpspDeliverooShowroomOrder
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(order.restaurantName).font(LpspDeliverooFonts.rooRestaurantName)
                Spacer()
                Text(order.totalLabel).font(LpspDeliverooFonts.rooPrice)
            }
            Text(order.itemsSummary)
                .font(LpspDeliverooFonts.rooMeta)
                .foregroundStyle(LpspDeliverooTokens.rooTextSecondary)
                .lineLimit(2)
            HStack {
                Text(statusLabel)
                    .font(LpspDeliverooFonts.rooCaption.weight(.semibold))
                    .foregroundStyle(isActive ? LpspDeliverooTokens.rooTeal : LpspDeliverooTokens.rooTextSecondary)
                if let eta = order.etaLabel {
                    Text("· \(eta)")
                        .font(LpspDeliverooFonts.rooCaption)
                        .foregroundStyle(LpspDeliverooTokens.rooTextSecondary)
                }
                Spacer()
                Text(order.dateLabel)
                    .font(LpspDeliverooFonts.rooCaption)
                    .foregroundStyle(LpspDeliverooTokens.rooTextTertiary)
            }
            if isActive {
                Button(action: action) {
                    Text(order.status == .preparing ? "Suivre la préparation" : "Suivre le livreur")
                        .font(LpspDeliverooFonts.rooButton)
                        .foregroundStyle(LpspDeliverooTokens.rooTealInk)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(LpspDeliverooTokens.rooTeal, in: Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 4)
    }

    private var statusLabel: String {
        switch order.status {
        case .preparing: return "En préparation"
        case .onTheWay: return "En route"
        case .delivered: return "Livrée"
        case .cancelled: return "Annulée"
        }
    }
}

private struct LpspDeliverooFavouritesScreen: View {
    @ObservedObject var store: LpspDeliverooStore

    var body: some View {
        NavigationStack {
            Group {
                if store.favouriteRestaurants.isEmpty {
                    ContentUnavailableView("Aucun favori", systemImage: "heart")
                } else {
                    ScrollView {
                        ForEach(store.favouriteRestaurants) { restaurant in
                            LpspDeliverooRestaurantCard(
                                name: restaurant.name,
                                meta: "\(restaurant.cuisine) · \(restaurant.eta)",
                                rating: restaurant.rating,
                                fee: restaurant.deliveryFee,
                                badge: restaurant.badge,
                                badgeIsPromo: restaurant.badgeIsPromo,
                                accent: restaurant.accent,
                                symbol: restaurant.symbol,
                                isSaved: true,
                                onTap: { store.openRestaurant(restaurant.id) },
                                onSave: { store.toggleFavourite(restaurant.id) }
                            )
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .navigationTitle("Favoris")
            .background(LpspDeliverooTokens.rooCanvas.ignoresSafeArea())
        }
    }
}

private struct LpspDeliverooAccountScreen: View {
    @ObservedObject var store: LpspDeliverooStore

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 14) {
                        Circle()
                            .fill(LpspDeliverooTokens.rooTeal.opacity(0.2))
                            .frame(width: 56, height: 56)
                            .overlay(Text("MG").font(.headline).foregroundStyle(LpspDeliverooTokens.rooTeal))
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Mathieu Garnier")
                            Text("mathieu.g@icloud.com")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                Section("Adresses") {
                    Label(store.address + ", 75011 Paris", systemImage: "mappin.circle.fill")
                    Label("Travail — Station F", systemImage: "briefcase.fill")
                }
                Section("Paiements") {
                    Label("Visa •••• 4821", systemImage: "creditcard.fill")
                    Label("Apple Pay", systemImage: "apple.logo")
                }
                Section("Deliveroo Plus") {
                    Label("Essai gratuit — 14 jours", systemImage: "star.circle.fill")
                }
            }
            .navigationTitle("Compte")
        }
    }
}

private struct LpspDeliverooRestaurantSheet: View {
    @ObservedObject var store: LpspDeliverooStore
    let restaurant: LpspDeliverooShowroomRestaurant
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    LpspDeliverooFoodImage(accent: restaurant.accent, symbol: restaurant.symbol)
                        .padding(.horizontal, 16)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(restaurant.name).font(LpspDeliverooFonts.rooRestaurantHero)
                        Text("\(restaurant.cuisine) · ★ \(String(format: "%.1f", restaurant.rating)) · \(restaurant.eta)")
                            .font(LpspDeliverooFonts.rooMeta)
                            .foregroundStyle(LpspDeliverooTokens.rooTextSecondary)
                        LpspDeliverooFeePill(text: restaurant.deliveryFee)
                    }
                    .padding(16)

                    ForEach(restaurant.menu) { item in
                        LpspDeliverooMenuItemRow(
                            name: item.name,
                            desc: item.description,
                            price: LpspDeliverooStore.formatEuro(item.priceCents),
                            accent: restaurant.accent,
                            quantity: store.quantity(for: item.id)
                        ) {
                            store.addToBasket(itemID: item.id)
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .navigationTitle(restaurant.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if store.basketItemCount > 0 {
                    LpspDeliverooBasketBar(
                        itemCount: store.basketItemCount,
                        total: store.basketTotalLabel
                    ) {
                        store.showBasket = true
                    }
                    .padding(.bottom, 8)
                }
            }
        }
    }
}

private struct LpspDeliverooBasketSheet: View {
    @ObservedObject var store: LpspDeliverooStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(store.basket.keys.sorted()), id: \.self) { itemID in
                    if let item = store.item(id: itemID), store.basket[itemID, default: 0] > 0 {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.name).font(LpspDeliverooFonts.rooMenuName)
                                Text(LpspDeliverooStore.formatEuro(item.priceCents))
                                    .font(LpspDeliverooFonts.rooMeta)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("× \(store.basket[itemID, default: 0])")
                                .font(LpspDeliverooFonts.rooButton)
                        }
                    }
                }
            }
            .navigationTitle("Panier")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                LpspDeliverooRooButton(title: "Commander · \(store.basketTotalLabel)", action: {
                    store.placeOrder()
                    dismiss()
                }, style: .dark)
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
        }
        .presentationDetents([.medium, .large])
    }
}


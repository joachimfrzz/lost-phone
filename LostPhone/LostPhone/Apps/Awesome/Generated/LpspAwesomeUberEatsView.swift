import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/uber-eats
// Meliwat/awesome-ios-design-md/food/uber-eats/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeUberEatsView: View {
    var body: some View {
        LpspUberEatsShowroomRoot(store: LpspUberEatsStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspUberEatsFonts {
    static let ueRestaurantHeader = Font.system(size: 30, weight: .regular)
    static let ueTitleLarge       = Font.system(size: 28, weight: .regular)
    static let ueSectionHeader    = Font.system(size: 22, weight: .regular)
    static let ueSubsection       = Font.system(size: 20, weight: .regular)
    static let ueRestaurantName   = Font.system(size: 17, weight: .bold)
    static let ueMenuItemTitle    = Font.system(size: 16, weight: .medium)
    static let ueBody             = Font.system(size: 15, weight: .regular)
    static let uePrice            = Font.system(size: 16, weight: .regular)
    static let ueMeta             = Font.system(size: 14, weight: .regular)
    static let uePill             = Font.system(size: 14, weight: .regular)
    static let ueCaption          = Font.system(size: 13, weight: .regular)
    static let ueLabelUpper       = Font.system(size: 11, weight: .regular)
    static let ueButton           = Font.system(size: 16, weight: .bold)
    static let ueTab              = Font.system(size: 10, weight: .regular)
    static let ueCartBadge        = Font.system(size: 12, weight: .regular)
    static func ue(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspUberEatsTokens {
    static let ueCanvas    = Color.white                                       // #FFFFFF
    static let ueSurface   = Color(red: 0.953, green: 0.953, blue: 0.953)      // #F3F3F3
    static let ueSurface2  = Color(red: 0.933, green: 0.933, blue: 0.933)      // #EEEEEE
    static let ueDivider   = Color(red: 0.910, green: 0.910, blue: 0.910)      // #E8E8E8
    static let ueTextPrimary   = Color.black                                   // #000000
    static let ueTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)  // #6B6B6B
    static let ueTextTertiary  = Color(red: 0.651, green: 0.651, blue: 0.651)  // #A6A6A6
    static let ueDarkCanvas    = Color.black                                   // #000000
    static let ueDarkSurface   = Color(red: 0.110, green: 0.110, blue: 0.118)  // #1C1C1E
    static let ueDarkSurface2  = Color(red: 0.173, green: 0.173, blue: 0.180)  // #2C2C2E
    static let ueGreen        = Color(red: 0.024, green: 0.757, blue: 0.404)   // #06C167
    static let ueGreenPressed = Color(red: 0.020, green: 0.651, blue: 0.345)   // #05A658
    static let ueGreenTint    = Color(red: 0.906, green: 0.973, blue: 0.937)   // #E7F8EF
    static let ueErrorRed     = Color(red: 0.882, green: 0.098, blue: 0.000)   // #E11900
    static let ueBusyAmber    = Color(red: 1.000, green: 0.541, blue: 0.000)   // #FF8A00
    static func ueBackground(_ s: ColorScheme) -> Color { s == .dark ? LpspUberEatsTokens.ueDarkCanvas  : LpspUberEatsTokens.ueCanvas }
    static func ueCard(_ s: ColorScheme)       -> Color { s == .dark ? LpspUberEatsTokens.ueDarkSurface : LpspUberEatsTokens.ueSurface }
    static func ueText(_ s: ColorScheme)       -> Color { s == .dark ? .white         : .black }
}



// Dynamic (light/dark) helpers — use these in views






fileprivate struct LpspUberEatsUEPrimaryButton: View {
    let title: String
    var trailing: String? = nil   // e.g. price "$12.49"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title).font(LpspUberEatsFonts.ueButton).tracking(0.2)
                if let trailing { Spacer(); Text(trailing).font(LpspUberEatsFonts.ueButton) }
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .padding(.horizontal, trailing == nil ? 0 : 20)
            .background(RoundedRectangle(cornerRadius: 12).fill(LpspUberEatsTokens.ueGreen))
        }
        .sensoryFeedback(.impact(weight: .light), trigger: title)
        .buttonStyle(LpspUberEatsUEPressableStyle(pressedScale: 0.98))
    }
}

fileprivate struct LpspUberEatsUEPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspUberEatsUERestaurantCard: View {
    let name: String
    let rating: String   // "4.8"
    let eta: String      // "25 min"
    let fee: String      // "$0.99 Delivery Fee"
    var freeDelivery: Bool = false
    let photo: Image
    @Environment(\.colorScheme) private var scheme
    @State private var pressed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                photo
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .scaleEffect(pressed ? 0.98 : 1)
                if freeDelivery {
                    Text("$0 Delivery Fee")
                        .font(LpspUberEatsFonts.ueCaption.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(Capsule().fill(LpspUberEatsTokens.ueGreen))
                        .padding(10)
                }
                HStack { Spacer()
                    Image(systemName: "heart")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.black)
                        .frame(width: 36, height: 36)
                        .background(Circle().fill(.white.opacity(0.9)))
                }.padding(10)
            }
            Text(name).font(LpspUberEatsFonts.ueRestaurantName).foregroundStyle(LpspUberEatsTokens.ueText(scheme))
            HStack(spacing: 6) {
                Image(systemName: "star.fill").font(.system(size: 12))
                    .foregroundStyle(LpspUberEatsTokens.ueText(scheme))   // monochrome, not yellow
                Text(rating).font(LpspUberEatsFonts.ueMeta).foregroundStyle(LpspUberEatsTokens.ueText(scheme))
                Text("· \(eta) ·").font(LpspUberEatsFonts.ueMeta).foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                Text(fee).font(LpspUberEatsFonts.ueMeta).foregroundStyle(freeDelivery ? LpspUberEatsTokens.ueGreen : LpspUberEatsTokens.ueTextSecondary)
            }
        }
        .onLongPressGesture(minimumDuration: 0, pressing: { p in
            withAnimation(.easeOut(duration: 0.15)) { pressed = p }
        }, perform: {})
    }
}

fileprivate struct LpspUberEatsUEStickyCartBar: View {
    let count: Int
    let total: String
    let onView: () -> Void

    var body: some View {
        Button(action: onView) {
            HStack {
                Text("\(count)")
                    .font(LpspUberEatsFonts.ueCartBadge).foregroundStyle(LpspUberEatsTokens.ueGreen)
                    .frame(width: 28, height: 28)
                    .background(Circle().fill(.white))
                Spacer()
                Text("View cart").font(LpspUberEatsFonts.ueButton).foregroundStyle(.white)
                Spacer()
                Text(total).font(LpspUberEatsFonts.ueButton).foregroundStyle(.white)
                    .contentTransition(.numericText())
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 12).fill(LpspUberEatsTokens.ueGreen))
            .padding(.horizontal, 16)
            .shadow(color: .black.opacity(0.12), radius: 12, y: -2)
        }
        .buttonStyle(LpspUberEatsUEPressableStyle())
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

fileprivate struct LpspUberEatsUEMenuItemRow: View {
    let name: String
    let desc: String
    let price: String
    let photo: Image
    let onAdd: () -> Void
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(name).font(LpspUberEatsFonts.ueMenuItemTitle).foregroundStyle(LpspUberEatsTokens.ueText(scheme))
                Text(desc).font(LpspUberEatsFonts.ueMeta).foregroundStyle(LpspUberEatsTokens.ueTextSecondary).lineLimit(2)
                Text(price).font(LpspUberEatsFonts.ueBody).foregroundStyle(LpspUberEatsTokens.ueText(scheme)).padding(.top, 2)
            }
            Spacer(minLength: 12)
            ZStack(alignment: .bottomTrailing) {
                photo.resizable().aspectRatio(1, contentMode: .fill)
                    .frame(width: 88, height: 88)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Button(action: onAdd) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(LpspUberEatsTokens.ueGreen))
                }
                .sensoryFeedback(.impact(weight: .light), trigger: price)
                .offset(x: 6, y: 6)
            }
        }
        .padding(.vertical, 12)
        .overlay(Divider().background(LpspUberEatsTokens.ueDivider), alignment: .bottom)
    }
}

// Reusable cart-count "bump"
fileprivate struct LpspUberEatsCartCountBadge: View {
    let count: Int
    @State private var bump = false
    var body: some View {
        Text("\(count)")
            .font(LpspUberEatsFonts.ueCartBadge).foregroundStyle(.white)
            .frame(width: 18, height: 18)
            .background(Circle().fill(LpspUberEatsTokens.ueGreen))
            .scaleEffect(bump ? 1.25 : 1)
            .onChange(of: count) { _, _ in
                withAnimation(.spring(response: 0.28, dampingFraction: 0.5)) { bump = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
                    withAnimation { bump = false }
                }
            }
    }
}

import MapKit

fileprivate struct LpspUberEatsUEOrderTrackingView: View {
    @State private var courier = CLLocationCoordinate2D(latitude: 37.78, longitude: -122.41)
    let route: [CLLocationCoordinate2D]
    let etaText: String

    var body: some View {
        ZStack(alignment: .bottom) {
            Map {
                MapPolyline(coordinates: route).stroke(.black, lineWidth: 4)   // near-black route
                Annotation("Courier", coordinate: courier) {
                    Circle().fill(LpspUberEatsTokens.ueGreen)
                        .frame(width: 22, height: 22)
                        .overlay(Circle().stroke(.white, lineWidth: 3))
                }
            }
            .mapStyle(.standard(elevation: .flat))
            .ignoresSafeArea()

            // Draggable tracking sheet
            VStack(alignment: .leading, spacing: 16) {
                Capsule().fill(LpspUberEatsTokens.ueDivider).frame(width: 40, height: 5)
                    .frame(maxWidth: .infinity)
                Text(etaText).font(LpspUberEatsFonts.ueSectionHeader)            // "Arriving in 12 min"
                LpspUberEatsUEProgressStepper(steps: ["Preparing", "Picked up", "On the way", "Delivered"],
                                  current: 2)
                // Courier card omitted for brevity
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LpspUberEatsTokens.ueCanvas)
            .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
            .shadow(color: .black.opacity(0.16), radius: 28, y: -8)
        }
        .task {
            // Ease the courier marker between location updates
            for point in route {
                withAnimation(.easeInOut(duration: 1.0)) { courier = point }
                try? await Task.sleep(for: .seconds(3))
            }
        }
    }
}

fileprivate struct LpspUberEatsUEProgressStepper: View {
    let steps: [String]
    let current: Int
    var body: some View {
        HStack(spacing: 6) {
            ForEach(steps.indices, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(i <= current ? LpspUberEatsTokens.ueGreen : LpspUberEatsTokens.ueSurface2)
                    .frame(height: 4)
            }
        }
    }
}



// MARK: - Données & état (showroom Lost Phone)

fileprivate struct LpspUberEatsShowroomMenuItem: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let priceCents: Int
}

fileprivate struct LpspUberEatsShowroomRestaurant: Identifiable, Hashable {
    let id: String
    let name: String
    let cuisine: String
    let eta: String
    let rating: Double
    let deliveryFee: String
    let freeDelivery: Bool
    let categoryID: String
    let accent: Color
    let symbol: String
    let menu: [LpspUberEatsShowroomMenuItem]
}

fileprivate struct LpspUberEatsShowroomOrder: Identifiable, Hashable {
    let id: String
    let restaurantName: String
    let itemsSummary: String
    let totalLabel: String
    let dateLabel: String
    let status: LpspUberEatsOrderStatus
    let etaLabel: String?
}

fileprivate enum LpspUberEatsOrderStatus: Hashable {
    case preparing, pickedUp, onTheWay, delivered
}

private enum LpspUberEatsTab: CaseIterable {
    case home, browse, search, cart, account

    var label: String {
        switch self {
        case .home: "Home"
        case .browse: "Browse"
        case .search: "Search"
        case .cart: "Cart"
        case .account: "Account"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .browse: "square.grid.2x2.fill"
        case .search: "magnifyingglass"
        case .cart: "cart.fill"
        case .account: "person.crop.circle.fill"
        }
    }
}

@MainActor
fileprivate final class LpspUberEatsStore: ObservableObject {
    @Published var selectedTab: LpspUberEatsTab = .home
    @Published var selectedCategoryID = "featured"
    @Published var searchQuery = ""
    @Published var basket: [String: Int]
    @Published var favouriteIDs: Set<String> = ["sunrise-diner"]
    @Published var selectedRestaurantID: String?
    @Published var showBasketSheet = false
    @Published var activeOrder: LpspUberEatsShowroomOrder?
    @Published var pastOrders: [LpspUberEatsShowroomOrder]

    let deliveryLabel = "Deliver to · Home"
    let addressStory = "17 rue de la Roquette"
    let restaurants: [LpspUberEatsShowroomRestaurant]
    let categories: [(id: String, label: String)]

    init() {
        self.restaurants = LpspUberEatsShowroomData.restaurants
        self.categories = LpspUberEatsShowroomData.categories
        self.pastOrders = LpspUberEatsShowroomData.pastOrders
        self.basket = LpspUberEatsShowroomData.spectrSeedBasket
    }

    var filteredRestaurants: [LpspUberEatsShowroomRestaurant] {
        let categoryFiltered = restaurants.filter {
            selectedCategoryID == "featured" || $0.categoryID == selectedCategoryID
        }
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return categoryFiltered }
        return categoryFiltered.filter {
            $0.name.lowercased().contains(query)
                || $0.cuisine.lowercased().contains(query)
                || $0.menu.contains { $0.name.lowercased().contains(query) }
        }
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
        Self.formatUSD(basketTotalCents)
    }

    var selectedRestaurant: LpspUberEatsShowroomRestaurant? {
        guard let selectedRestaurantID else { return nil }
        return restaurants.first { $0.id == selectedRestaurantID }
    }

    func item(id: String) -> LpspUberEatsShowroomMenuItem? {
        restaurants.flatMap(\.menu).first { $0.id == id }
    }

    func restaurant(containingItemID itemID: String) -> LpspUberEatsShowroomRestaurant? {
        restaurants.first { $0.menu.contains { $0.id == itemID } }
    }

    func quantity(for itemID: String) -> Int {
        basket[itemID, default: 0]
    }

    func addToBasket(itemID: String) {
        basket[itemID, default: 0] += 1
    }

    func removeFromBasket(itemID: String) {
        guard let current = basket[itemID], current > 0 else { return }
        if current == 1 { basket.removeValue(forKey: itemID) }
        else { basket[itemID] = current - 1 }
    }

    func toggleFavourite(_ restaurantID: String) {
        if favouriteIDs.contains(restaurantID) { favouriteIDs.remove(restaurantID) }
        else { favouriteIDs.insert(restaurantID) }
    }

    func openRestaurant(_ id: String) {
        selectedRestaurantID = id
    }

    func placeOrder() {
        guard basketItemCount > 0 else { return }
        let restaurant = selectedRestaurant
            ?? basket.keys.compactMap { restaurant(containingItemID: $0) }.first
            ?? restaurants.first
        guard let restaurant else { return }
        let summary = basket.compactMap { id, qty -> String? in
            guard let item = item(id: id), qty > 0 else { return nil }
            return qty > 1 ? "\(item.name) ×\(qty)" : item.name
        }.joined(separator: ", ")
        activeOrder = LpspUberEatsShowroomOrder(
            id: "active-\(UUID().uuidString)",
            restaurantName: restaurant.name,
            itemsSummary: summary.isEmpty ? "Order" : summary,
            totalLabel: basketTotalLabel,
            dateLabel: "Today",
            status: .preparing,
            etaLabel: restaurant.eta
        )
        basket.removeAll()
        showBasketSheet = false
        selectedTab = .cart
    }

    func advanceActiveOrder() {
        guard var order = activeOrder else { return }
        switch order.status {
        case .preparing:
            order = LpspUberEatsShowroomOrder(
                id: order.id, restaurantName: order.restaurantName, itemsSummary: order.itemsSummary,
                totalLabel: order.totalLabel, dateLabel: order.dateLabel, status: .pickedUp, etaLabel: "18 min"
            )
        case .pickedUp:
            order = LpspUberEatsShowroomOrder(
                id: order.id, restaurantName: order.restaurantName, itemsSummary: order.itemsSummary,
                totalLabel: order.totalLabel, dateLabel: order.dateLabel, status: .onTheWay, etaLabel: "12 min"
            )
        case .onTheWay:
            order = LpspUberEatsShowroomOrder(
                id: order.id, restaurantName: order.restaurantName, itemsSummary: order.itemsSummary,
                totalLabel: order.totalLabel, dateLabel: order.dateLabel, status: .delivered, etaLabel: nil
            )
            pastOrders.insert(order, at: 0)
            activeOrder = nil
            return
        case .delivered:
            activeOrder = nil
            return
        }
        activeOrder = order
    }

    static func formatUSD(_ cents: Int) -> String {
        String(format: "$%.2f", Double(cents) / 100.0)
    }

    static func formatEuro(_ cents: Int) -> String {
        String(format: "%.2f €", Double(cents) / 100.0).replacingOccurrences(of: ".", with: ",")
    }
}

private enum LpspUberEatsShowroomData {
    static let categories: [(id: String, label: String)] = [
        ("featured", "Featured"),
        ("pizza", "Pizza"),
        ("sushi", "Sushi"),
        ("burgers", "Burgers"),
        ("healthy", "Healthy"),
    ]

    static let spectrSeedBasket: [String: Int] = [
        "sd-breakfast": 1,
        "sd-toast": 1,
        "sd-juice": 1,
    ]

    static let restaurants: [LpspUberEatsShowroomRestaurant] = [
        .init(
            id: "sunrise-diner",
            name: "Sunrise Diner",
            cuisine: "American",
            eta: "25 min",
            rating: 4.8,
            deliveryFee: "$0 Delivery Fee",
            freeDelivery: true,
            categoryID: "featured",
            accent: .orange,
            symbol: "sun.max.fill",
            menu: [
                .init(id: "sd-breakfast", name: "Classic Breakfast", description: "Eggs, bacon, hash browns", priceCents: 950),
                .init(id: "sd-toast", name: "Avocado Toast", description: "Sourdough, chili flakes", priceCents: 1250),
                .init(id: "sd-juice", name: "Fresh Orange Juice", description: "16 oz, no pulp", priceCents: 640),
            ]
        ),
        .init(
            id: "green-bowl",
            name: "Green Bowl Kitchen",
            cuisine: "Healthy",
            eta: "30 min",
            rating: 4.7,
            deliveryFee: "$1.49 Delivery Fee",
            freeDelivery: false,
            categoryID: "healthy",
            accent: .green,
            symbol: "leaf.fill",
            menu: [
                .init(id: "gb-bowl", name: "Buddha Bowl", description: "Quinoa, kale, tahini", priceCents: 1490),
                .init(id: "gb-smoothie", name: "Green Smoothie", description: "Spinach, mango, ginger", priceCents: 890),
            ]
        ),
        .init(
            id: "monop",
            name: "Monop' Daily",
            cuisine: "Grocery · Bastille",
            eta: "20 min",
            rating: 4.5,
            deliveryFee: "€1,99 delivery",
            freeDelivery: false,
            categoryID: "featured",
            accent: .blue,
            symbol: "cart.fill",
            menu: [
                .init(id: "m1", name: "Nuggets poulet Bonduelle", description: "450 g — les ronds", priceCents: 450),
                .init(id: "m2", name: "Compote pomme-fraise", description: "4 pots — sans pulpe", priceCents: 320),
                .init(id: "m3", name: "Céréales Chocapic", description: "Note Hugo", priceCents: 390),
            ]
        ),
        .init(
            id: "pizza-julien",
            name: "Pizza Julien",
            cuisine: "Pizza · Italien",
            eta: "22 min",
            rating: 4.7,
            deliveryFee: "€1,49 delivery",
            freeDelivery: false,
            categoryID: "pizza",
            accent: .red,
            symbol: "takeoutbag.and.cup.and.straw.fill",
            menu: [
                .init(id: "p1", name: "Margherita", description: "Tomate, mozzarella, basilic", priceCents: 1150),
                .init(id: "p2", name: "Regina", description: "Jambon, champignons", priceCents: 1350),
            ]
        ),
    ]

    static let pastOrders: [LpspUberEatsShowroomOrder] = [
        .init(id: "o1", restaurantName: "Pizza Julien", itemsSummary: "Margherita", totalLabel: "€13,50", dateLabel: "2 juin", status: .delivered, etaLabel: nil),
    ]
}

// MARK: - Écrans showroom

private struct LpspUberEatsShowroomRoot: View {
    @ObservedObject var store: LpspUberEatsStore

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .home: LpspUberEatsHomeScreen(store: store)
                    case .browse: LpspUberEatsBrowseScreen(store: store)
                    case .search: LpspUberEatsSearchScreen(store: store)
                    case .cart: LpspUberEatsCartScreen(store: store)
                    case .account: LpspUberEatsAccountScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspUberEatsTabBar(store: store)
            }

            if store.basketItemCount > 0, store.selectedTab != .cart {
                LpspUberEatsUEStickyCartBar(
                    count: store.basketItemCount,
                    total: store.basketTotalLabel,
                    onView: { store.showBasketSheet = true }
                )
                .padding(.bottom, 56)
            }
        }
        .background(LpspUberEatsTokens.ueCanvas.ignoresSafeArea())
        .sheet(isPresented: $store.showBasketSheet) {
            LpspUberEatsBasketSheet(store: store)
        }
        .sheet(item: Binding(
            get: { store.selectedRestaurant.map { LpspUberEatsRestaurantSheetID(id: $0.id) } },
            set: { store.selectedRestaurantID = $0?.id }
        )) { wrapper in
            if let restaurant = store.restaurants.first(where: { $0.id == wrapper.id }) {
                LpspUberEatsRestaurantSheet(store: store, restaurant: restaurant)
            }
        }
    }
}

private struct LpspUberEatsRestaurantSheetID: Identifiable {
    let id: String
}

fileprivate struct LpspUberEatsFoodImage: View {
    let accent: Color
    let symbol: String

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [accent.opacity(0.65), accent.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: symbol)
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.white.opacity(0.9))
        }
    }
}

private struct LpspUberEatsShowroomRestaurantCard: View {
    let restaurant: LpspUberEatsShowroomRestaurant
    let isSaved: Bool
    let onTap: () -> Void
    let onSave: () -> Void
    @Environment(\.colorScheme) private var scheme
    @State private var pressed = false

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topLeading) {
                    LpspUberEatsFoodImage(accent: restaurant.accent, symbol: restaurant.symbol)
                        .aspectRatio(16/9, contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .scaleEffect(pressed ? 0.98 : 1)

                    if restaurant.freeDelivery {
                        Text("$0 Delivery Fee")
                            .font(LpspUberEatsFonts.ueCaption.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(Capsule().fill(LpspUberEatsTokens.ueGreen))
                            .padding(10)
                    }

                    HStack {
                        Spacer()
                        Button(action: onSave) {
                            Image(systemName: isSaved ? "heart.fill" : "heart")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.black)
                                .frame(width: 36, height: 36)
                                .background(Circle().fill(.white.opacity(0.9)))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(10)
                }

                Text(restaurant.name)
                    .font(LpspUberEatsFonts.ueRestaurantName)
                    .foregroundStyle(LpspUberEatsTokens.ueText(scheme))

                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(LpspUberEatsTokens.ueText(scheme))
                    Text(String(format: "%.1f", restaurant.rating))
                        .font(LpspUberEatsFonts.ueMeta)
                        .foregroundStyle(LpspUberEatsTokens.ueText(scheme))
                    Text("· \(restaurant.eta) ·")
                        .font(LpspUberEatsFonts.ueMeta)
                        .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                    Text(restaurant.deliveryFee)
                        .font(LpspUberEatsFonts.ueMeta)
                        .foregroundStyle(restaurant.freeDelivery ? LpspUberEatsTokens.ueGreen : LpspUberEatsTokens.ueTextSecondary)
                }
            }
        }
        .buttonStyle(.plain)
        .onLongPressGesture(minimumDuration: 0, pressing: { p in
            withAnimation(.easeOut(duration: 0.15)) { pressed = p }
        }, perform: {})
    }
}

private struct LpspUberEatsTabBar: View {
    @ObservedObject var store: LpspUberEatsStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspUberEatsTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                            if tab == .cart, store.basketItemCount > 0 {
                                Text("\(store.basketItemCount)")
                                    .font(LpspUberEatsFonts.ueCartBadge)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background(Capsule().fill(LpspUberEatsTokens.ueGreen))
                                    .offset(x: 10, y: -6)
                            }
                        }
                        Text(tab.label)
                            .font(LpspUberEatsFonts.ueTab.weight(.medium))
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspUberEatsTokens.ueTextPrimary : LpspUberEatsTokens.ueTextTertiary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspUberEatsTokens.ueDivider).frame(height: 0.5)
        }
    }
}

private struct LpspUberEatsCategoryPills: View {
    let categories: [(id: String, label: String)]
    @Binding var selectedID: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categories, id: \.id) { cat in
                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) { selectedID = cat.id }
                    } label: {
                        Text(cat.label)
                            .font(.system(size: 14, weight: selectedID == cat.id ? .semibold : .regular))
                            .foregroundStyle(selectedID == cat.id ? LpspUberEatsTokens.ueTextPrimary : LpspUberEatsTokens.ueTextSecondary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                Capsule().fill(selectedID == cat.id ? LpspUberEatsTokens.ueSurface2 : LpspUberEatsTokens.ueSurface)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

private struct LpspUberEatsHomeScreen: View {
    @ObservedObject var store: LpspUberEatsStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    HStack(spacing: 4) {
                        Text(store.deliveryLabel)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(LpspUberEatsTokens.ueTextPrimary)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                    }
                    Spacer()
                    Circle()
                        .fill(LpspUberEatsTokens.ueSurface2)
                        .frame(width: 32, height: 32)
                        .overlay(Image(systemName: "person.fill").font(.system(size: 14)))
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)

                Button { store.selectedTab = .search } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                        Text("Search Uber Eats")
                            .font(LpspUberEatsFonts.ueBody)
                            .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(LpspUberEatsTokens.ueSurface, in: RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)

                LpspUberEatsCategoryPills(categories: store.categories, selectedID: $store.selectedCategoryID)

                ForEach(store.filteredRestaurants) { restaurant in
                    LpspUberEatsShowroomRestaurantCard(
                        restaurant: restaurant,
                        isSaved: store.favouriteIDs.contains(restaurant.id),
                        onTap: { store.openRestaurant(restaurant.id) },
                        onSave: { store.toggleFavourite(restaurant.id) }
                    )
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, store.basketItemCount > 0 ? 120 : 24)
        }
        .background(LpspUberEatsTokens.ueCanvas.ignoresSafeArea())
    }
}

private struct LpspUberEatsBrowseScreen: View {
    @ObservedObject var store: LpspUberEatsStore

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(store.categories.filter { $0.id != "featured" }, id: \.id) { cat in
                        Button {
                            store.selectedCategoryID = cat.id
                            store.selectedTab = .home
                        } label: {
                            VStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LpspUberEatsTokens.ueGreenTint)
                                    .frame(height: 88)
                                    .overlay(
                                        Text(cat.label)
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundStyle(LpspUberEatsTokens.ueTextPrimary)
                                    )
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
            .background(LpspUberEatsTokens.ueCanvas.ignoresSafeArea())
            .navigationTitle("Browse")
        }
    }
}

private struct LpspUberEatsSearchScreen: View {
    @ObservedObject var store: LpspUberEatsStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                    TextField("Search Uber Eats", text: $store.searchQuery)
                        .font(LpspUberEatsFonts.ueBody)
                }
                .padding(12)
                .background(LpspUberEatsTokens.ueSurface, in: RoundedRectangle(cornerRadius: 12))
                .padding(16)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(store.filteredRestaurants) { restaurant in
                            LpspUberEatsShowroomRestaurantCard(
                                restaurant: restaurant,
                                isSaved: store.favouriteIDs.contains(restaurant.id),
                                onTap: { store.openRestaurant(restaurant.id) },
                                onSave: { store.toggleFavourite(restaurant.id) }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .background(LpspUberEatsTokens.ueCanvas.ignoresSafeArea())
            .navigationTitle("Search")
        }
    }
}

private struct LpspUberEatsCartScreen: View {
    @ObservedObject var store: LpspUberEatsStore

    var body: some View {
        NavigationStack {
            Group {
                if let order = store.activeOrder {
                    LpspUberEatsUEOrderTrackingView(
                        route: [
                            CLLocationCoordinate2D(latitude: 48.855, longitude: 2.372),
                            CLLocationCoordinate2D(latitude: 48.858, longitude: 2.378),
                            CLLocationCoordinate2D(latitude: 48.861, longitude: 2.385),
                        ],
                        etaText: order.etaLabel.map { "Arriving in \($0)" } ?? "Delivered"
                    )
                    .overlay(alignment: .bottom) {
                        Button { store.advanceActiveOrder() } label: {
                            Text(order.status == .onTheWay ? "Mark delivered" : "Update status")
                                .font(LpspUberEatsFonts.ueButton)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(RoundedRectangle(cornerRadius: 12).fill(LpspUberEatsTokens.ueGreen))
                                .padding(16)
                        }
                    }
                } else if store.basketItemCount == 0 {
                    ContentUnavailableView("Cart empty", systemImage: "cart", description: Text("Add items from a restaurant"))
                } else {
                    List {
                        ForEach(store.basket.sorted(by: { $0.key < $1.key }), id: \.key) { itemID, qty in
                            if let item = store.item(id: itemID), qty > 0 {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name).font(LpspUberEatsFonts.ueMenuItemTitle)
                                        Text(store.restaurant(containingItemID: itemID)?.name ?? "")
                                            .font(LpspUberEatsFonts.ueMeta)
                                            .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                                    }
                                    Spacer()
                                    Text("×\(qty)")
                                    Button { store.removeFromBasket(itemID: itemID) } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                                    }
                                }
                            }
                        }
                    }
                    .safeAreaInset(edge: .bottom) {
                        LpspUberEatsUEPrimaryButton(title: "Checkout", trailing: store.basketTotalLabel) {
                            store.placeOrder()
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Cart")
        }
    }
}

private struct LpspUberEatsAccountScreen: View {
    @ObservedObject var store: LpspUberEatsStore

    var body: some View {
        NavigationStack {
            List {
                Section("Delivery") {
                    Label(store.deliveryLabel, systemImage: "house.fill")
                    Label(store.addressStory, systemImage: "mappin.and.ellipse")
                }
                Section("Orders") {
                    ForEach(store.pastOrders) { order in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(order.restaurantName).font(LpspUberEatsFonts.ueMenuItemTitle)
                            Text("\(order.dateLabel) · \(order.totalLabel)")
                                .font(LpspUberEatsFonts.ueMeta)
                                .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                        }
                    }
                }
                Section {
                    Label("Payments", systemImage: "creditcard")
                    Label("Help", systemImage: "questionmark.circle")
                }
            }
            .navigationTitle("Account")
        }
    }
}

private struct LpspUberEatsRestaurantSheet: View {
    @ObservedObject var store: LpspUberEatsStore
    let restaurant: LpspUberEatsShowroomRestaurant
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    LpspUberEatsFoodImage(accent: restaurant.accent, symbol: restaurant.symbol)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(16)

                    Text(restaurant.name)
                        .font(LpspUberEatsFonts.ueRestaurantHeader)
                        .padding(.horizontal, 16)

                    HStack(spacing: 6) {
                        Image(systemName: "star.fill").font(.system(size: 12))
                        Text(String(format: "%.1f", restaurant.rating))
                        Text("· \(restaurant.eta) · \(restaurant.deliveryFee)")
                    }
                    .font(LpspUberEatsFonts.ueMeta)
                    .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)

                    ForEach(restaurant.menu) { item in
                        LpspUberEatsShowroomMenuRow(
                            item: item,
                            restaurant: restaurant,
                            quantity: store.quantity(for: item.id),
                            onAdd: { store.addToBasket(itemID: item.id) }
                        )
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.bottom, store.basketItemCount > 0 ? 80 : 24)
            }
            .background(LpspUberEatsTokens.ueCanvas.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if store.basketItemCount > 0 {
                    LpspUberEatsUEStickyCartBar(
                        count: store.basketItemCount,
                        total: store.basketTotalLabel,
                        onView: { dismiss(); store.showBasketSheet = true }
                    )
                }
            }
        }
    }
}

private struct LpspUberEatsShowroomMenuRow: View {
    let item: LpspUberEatsShowroomMenuItem
    let restaurant: LpspUberEatsShowroomRestaurant
    let quantity: Int
    let onAdd: () -> Void

    var priceLabel: String {
        restaurant.id == "sunrise-diner" || restaurant.id == "green-bowl"
            ? LpspUberEatsStore.formatUSD(item.priceCents)
            : LpspUberEatsStore.formatEuro(item.priceCents)
    }

    var body: some View {
        LpspUberEatsUEMenuItemRow(
            name: item.name,
            desc: item.description,
            price: priceLabel,
            photo: Image(systemName: restaurant.symbol),
            onAdd: onAdd
        )
        .overlay(alignment: .topTrailing) {
            if quantity > 0 {
                LpspUberEatsCartCountBadge(count: quantity)
                    .padding(.trailing, 8)
                    .padding(.top, 8)
            }
        }
    }
}

private struct LpspUberEatsBasketSheet: View {
    @ObservedObject var store: LpspUberEatsStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.basket.sorted(by: { $0.key < $1.key }), id: \.key) { itemID, qty in
                    if let item = store.item(id: itemID), qty > 0 {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(LpspUberEatsFonts.ueMenuItemTitle)
                                Text(store.restaurant(containingItemID: itemID)?.name ?? "")
                                    .font(LpspUberEatsFonts.ueMeta)
                                    .foregroundStyle(LpspUberEatsTokens.ueTextSecondary)
                            }
                            Spacer()
                            Text("×\(qty)")
                        }
                    }
                }
            }
            .navigationTitle("View cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                LpspUberEatsUEPrimaryButton(title: "Checkout", trailing: store.basketTotalLabel) {
                    store.placeOrder()
                    dismiss()
                }
                .padding()
            }
        }
        .presentationDetents([.medium, .large])
    }
}


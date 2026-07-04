import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/deliveroo
// Meliwat/awesome-ios-design-md/food/deliveroo/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDeliverooView: View {
    var body: some View {
        LpspDeliverooShowroomRoot()
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

fileprivate struct LpspDeliverooRestaurantCard: View {
    let name: String
    let meta: String
    let rating: Double
    let fee: String          // "£1.49 delivery · Min £12"
    let badge: String?       // "PLUS · Free delivery" or promo
    let badgeIsPromo: Bool
    let imageName: String
    @State private var saved = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(5/3, contentMode: .fill)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                if let badge {
                    Text(badge)
                        .font(LpspDeliverooFonts.rooBadge)
                        .foregroundStyle(badgeIsPromo ? Color(red: 0.102, green: 0.071, blue: 0.024) : LpspDeliverooTokens.rooTealInk)
                        .padding(.horizontal, 9).padding(.vertical, 4)
                        .background(badgeIsPromo ? LpspDeliverooTokens.rooPromoGold : LpspDeliverooTokens.rooTeal,
                                    in: RoundedRectangle(cornerRadius: 6))
                        .padding(10)
                }

                Button { saved.toggle() } label: {
                    Image(systemName: saved ? "heart.fill" : "heart")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(saved ? LpspDeliverooTokens.rooTeal : .white)
                        .frame(width: 32, height: 32)
                        .background(Color.black.opacity(0.4), in: Circle())
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(10)
            }

            HStack {
                Text(name).font(LpspDeliverooFonts.rooRestaurantName).foregroundStyle(LpspDeliverooTokens.rooTextPrimary)
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "star.fill").font(.system(size: 13)).foregroundStyle(LpspDeliverooTokens.rooTeal)
                    Text(String(format: "%.1f", rating)).font(LpspDeliverooFonts.rooFeePill).foregroundStyle(LpspDeliverooTokens.rooTextPrimary)
                }
            }
            .padding(.top, 10)

            Text(meta).font(LpspDeliverooFonts.rooMeta).foregroundStyle(LpspDeliverooTokens.rooTextSecondary).padding(.top, 4)

            LpspDeliverooFeePill(text: fee).padding(.top, 8)
        }
        .padding(.bottom, 22)
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
    let imageName: String
    let onAdd: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(name).font(LpspDeliverooFonts.rooMenuName).foregroundStyle(LpspDeliverooTokens.rooTextPrimary)
                Text(desc)
                    .font(LpspDeliverooFonts.rooBody.weight(.regular))
                    .foregroundStyle(LpspDeliverooTokens.rooTextSecondary)
                    .lineLimit(2)
                Text(price).font(LpspDeliverooFonts.rooPrice).foregroundStyle(LpspDeliverooTokens.rooTextPrimary).padding(.top, 4)
            }
            Spacer(minLength: 8)
            ZStack(alignment: .bottomTrailing) {
                Image(imageName)
                    .resizable().scaledToFill()
                    .frame(width: 84, height: 84)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Button(action: onAdd) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(LpspDeliverooTokens.rooTealInk)
                        .frame(width: 28, height: 28)
                        .background(LpspDeliverooTokens.rooTeal, in: Circle())
                        .shadow(color: .black.opacity(0.18), radius: 3, y: 2)
                }
                .offset(x: 8, y: 10)   // hangs off the corner
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
    struct LpspDeliverooCat: Identifiable { let id = UUID(); let symbol: String; let label: String }
    let cats: [LpspDeliverooCat]
    @State private var selected = 0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(Array(cats.enumerated()), id: \.element.id) { i, c in
                    VStack(spacing: 7) {
                        Image(systemName: c.symbol)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(i == selected ? LpspDeliverooTokens.rooTealInk : LpspDeliverooTokens.rooTeal)
                            .frame(width: 54, height: 54)
                            .background(i == selected ? LpspDeliverooTokens.rooTeal : LpspDeliverooTokens.rooSurface1,
                                        in: RoundedRectangle(cornerRadius: 16))
                        Text(c.label)
                            .font(LpspDeliverooFonts.rooCaption.weight(.semibold))
                            .foregroundStyle(i == selected ? LpspDeliverooTokens.rooTextPrimary : LpspDeliverooTokens.rooTextSecondary)
                    }
                    .onTapGesture { withAnimation(.easeOut(duration: 0.15)) { selected = i } }
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

// MARK: - Écrans showroom

private struct LpspDeliverooShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspDeliverooSpectrHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspDeliverooFoodTabScreen(title: "Search", tabIndex: 1)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
            LpspDeliverooFoodTabScreen(title: "Orders", tabIndex: 2)
                .tabItem { Label("Orders", systemImage: "list.bullet.rectangle") }
                .tag(2)
            LpspDeliverooFoodTabScreen(title: "Favourites", tabIndex: 3)
                .tabItem { Label("Favourites", systemImage: "heart") }
                .tag(3)
            LpspDeliverooFoodTabScreen(title: "Account", tabIndex: 4)
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
                .tag(4)
        }
        .tint(LpspDeliverooTokens.rooTextPrimary)
        
    }
}


private struct LpspDeliverooGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspDeliverooTokens.rooTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspDeliverooTokens.rooTextPrimary))
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


private struct LpspDeliverooDemoRestaurant { let name: String; let meta: String; let rating: Double; let fee: String; let badge: String?; let promo: Bool }
private enum LpspDeliverooDemoRestaurants {
    static let items: [LpspDeliverooDemoRestaurant] = [
        .init(name: "Sushi Shop", meta: "Japonais · 25 min", rating: 4.8, fee: "€1,99", badge: "Promo", promo: true),
        .init(name: "Pizza Roma", meta: "Italien · 20 min", rating: 4.6, fee: "€0,99", badge: nil, promo: false),
    ]
}
private struct LpspDeliverooDemoMenuItem { let title: String; let sub: String; let price: String }
private enum LpspDeliverooDemoMenu {
    static let items: [LpspDeliverooDemoMenuItem] = [
        .init(title: "Poke saumon", sub: "Riz, avocat", price: "€13,50"),
    ]
}

private struct LpspDeliverooFoodHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView { VStack(spacing: 16) { 
                    ForEach(LpspDeliverooDemoRestaurants.items, id: \.name) { r in
                        LpspDeliverooRestaurantCard(name: r.name, meta: r.meta, rating: r.rating, fee: r.fee, badge: r.badge, badgeIsPromo: r.promo, imageName: "photo")
                            .padding(.horizontal)
                    }
 } .padding(.vertical) }
            .background(LpspDeliverooTokens.rooCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
            .safeAreaInset(edge: .bottom) { LpspDeliverooBasketBar(itemCount: 2, total: "€24,50", onTap: {}) }
        }
    }
}

private struct LpspDeliverooFoodSearchTabScreen: View {
    var body: some View { NavigationStack { ScrollView { VStack { 
                    ForEach(LpspDeliverooDemoMenu.items, id: \.title) { item in
                        LpspDeliverooMenuItemRow(name: item.title, desc: item.sub, price: item.price, imageName: "photo", onAdd: {}).padding(.horizontal)
                    }
 } } .navigationTitle("Rechercher") } }
}

private struct LpspDeliverooFoodOrdersTabScreen: View {
    var body: some View { NavigationStack { List(["Commande en cours"], id: \.self) { Label($0, systemImage: "bag") } .navigationTitle("Commandes") } }
}

private struct LpspDeliverooFoodAccountTabScreen: View {
    var body: some View { NavigationStack { List { Label("Adresses", systemImage: "mappin"); Label("Paiements", systemImage: "creditcard") } .navigationTitle("Compte") } }
}

private struct LpspDeliverooFoodTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if tabIndex == 0 || low.contains("home") || low.contains("accueil") { LpspDeliverooFoodHomeTabScreen() }
        else if low.contains("recherch") || low.contains("search") { LpspDeliverooFoodSearchTabScreen() }
        else if low.contains("command") || low.contains("order") || low.contains("activity") { LpspDeliverooFoodOrdersTabScreen() }
        else { LpspDeliverooFoodAccountTabScreen() }
    }
}


private struct LpspDeliverooSpectrHomeTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
                Text("Deliver to").font(.system(size: 11.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("12 Hatton Garden").font(.system(size: 15.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Text("Restaurants, groceries, dishes").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            } .padding(.horizontal, 14).padding(.vertical, 12).background(Color(red: 0.149, green: 0.149, blue: 0.161)).clipShape(RoundedRectangle(cornerRadius: 28))
        } .padding(.horizontal, 16).padding(.top, 8)
            Text("deliveroo plus").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Free delivery on this order").font(.system(size: 13.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Join").font(.system(size: 12.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Restaurants").font(.system(size: 11.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Grocery").font(.system(size: 11.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Fast").font(.system(size: 11.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Treats").font(.system(size: 11.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Offers").font(.system(size: 11.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        ScrollView {
            VStack(spacing: 12) {
            Text("Popular near you").font(.system(size: 20.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("PLUS · Free delivery").font(.system(size: 11.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Franco Manca").font(.system(size: 16.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("4.7").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Pizza · Sourdough · 25–35 min").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("£1.49 delivery · Min £12").font(.system(size: 12.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("20% off, up to £10").font(.system(size: 11.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Wagamama").font(.system(size: 16.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("4.6").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Asian · Ramen · 30–40 min").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("£2.49 delivery · Min £15").font(.system(size: 12.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            }
        }
        }
        .background(Color(red: 0.071, green: 0.071, blue: 0.071).ignoresSafeArea())
    }
}



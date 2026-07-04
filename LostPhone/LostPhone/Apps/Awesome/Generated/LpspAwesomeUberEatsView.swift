import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/uber-eats
// Meliwat/awesome-ios-design-md/food/uber-eats/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeUberEatsView: View {
    var body: some View {
        LpspUberEatsShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspUberEatsFonts {
    static let ueRestaurantHeader = Font.system(size: 30, weight: .regular)
    static let ueTitleLarge       = Font.system(size: 28, weight: .regular)
    static let ueSectionHeader    = Font.system(size: 22, weight: .regular)
    static let ueSubsection       = Font.system(size: 20, weight: .regular)
    static let ueRestaurantName   = Font.system(size: 17, weight: .regular)
    static let ueMenuItemTitle    = Font.system(size: 16, weight: .regular)
    static let ueBody             = Font.system(size: 15, weight: .regular)
    static let uePrice            = Font.system(size: 16, weight: .regular)
    static let ueMeta             = Font.system(size: 14, weight: .regular)
    static let uePill             = Font.system(size: 14, weight: .regular)
    static let ueCaption          = Font.system(size: 13, weight: .regular)
    static let ueLabelUpper       = Font.system(size: 11, weight: .regular)
    static let ueButton           = Font.system(size: 16, weight: .regular)
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



// MARK: - Écrans showroom

private struct LpspUberEatsShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspUberEatsSpectrHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspUberEatsFoodTabScreen(title: "Browse", tabIndex: 1)
                .tabItem { Label("Browse", systemImage: "square.grid.2x2.fill") }
                .tag(1)
            LpspUberEatsFoodTabScreen(title: "Search", tabIndex: 2)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(2)
            LpspUberEatsFoodTabScreen(title: "Cart", tabIndex: 3)
                .tabItem { Label("Cart", systemImage: "cart.fill") }
                .tag(3)
            LpspUberEatsFoodTabScreen(title: "Account", tabIndex: 4)
                .tabItem { Label("Account", systemImage: "person.crop.circle.fill") }
                .tag(4)
        }
        .tint(LpspUberEatsTokens.ueErrorRed)
        
    }
}


private struct LpspUberEatsGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspUberEatsTokens.ueErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspUberEatsTokens.ueErrorRed))
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


private struct LpspUberEatsDemoRestaurant { let name: String; let meta: String; let rating: Double; let fee: String; let badge: String?; let promo: Bool }
private enum LpspUberEatsDemoRestaurants {
    static let items: [LpspUberEatsDemoRestaurant] = [
        .init(name: "Sushi Shop", meta: "Japonais · 25 min", rating: 4.8, fee: "€1,99", badge: "Promo", promo: true),
        .init(name: "Pizza Roma", meta: "Italien · 20 min", rating: 4.6, fee: "€0,99", badge: nil, promo: false),
    ]
}
private struct LpspUberEatsDemoMenuItem { let title: String; let sub: String; let price: String }
private enum LpspUberEatsDemoMenu {
    static let items: [LpspUberEatsDemoMenuItem] = [
        .init(title: "Poke saumon", sub: "Riz, avocat", price: "€13,50"),
    ]
}

private struct LpspUberEatsFoodHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView { VStack(spacing: 16) { 
                    ForEach(LpspUberEatsDemoRestaurants.items, id: \.name) { r in
                        LpspUberEatsUERestaurantCard(name: r.name, meta: r.meta, rating: r.rating, fee: r.fee, badge: r.badge, badgeIsPromo: r.promo, imageName: "photo")
                            .padding(.horizontal)
                    }
 } .padding(.vertical) }
            .background(LpspUberEatsTokens.ueCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
            .safeAreaInset(edge: .bottom) { LpspUberEatsUEStickyCartBar(itemCount: 2, subtotal: "€24,50", onCheckout: {}) }
        }
    }
}

private struct LpspUberEatsFoodSearchTabScreen: View {
    var body: some View { NavigationStack { ScrollView { VStack { 
                    ForEach(LpspUberEatsDemoMenu.items, id: \.title) { item in
                        LpspUberEatsUEMenuItemRow(title: item.title, subtitle: item.sub, price: item.price, quantity: .constant(1)).padding(.horizontal)
                    }
 } } .navigationTitle("Rechercher") } }
}

private struct LpspUberEatsFoodOrdersTabScreen: View {
    var body: some View { NavigationStack { LpspUberEatsUEOrderTrackingView() .navigationTitle("Commandes") } }
}

private struct LpspUberEatsFoodAccountTabScreen: View {
    var body: some View { NavigationStack { List { Label("Adresses", systemImage: "mappin"); Label("Paiements", systemImage: "creditcard") } .navigationTitle("Compte") } }
}

private struct LpspUberEatsFoodTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if tabIndex == 0 || low.contains("home") || low.contains("accueil") { LpspUberEatsFoodHomeTabScreen() }
        else if low.contains("recherch") || low.contains("search") { LpspUberEatsFoodSearchTabScreen() }
        else if low.contains("command") || low.contains("order") || low.contains("activity") { LpspUberEatsFoodOrdersTabScreen() }
        else { LpspUberEatsFoodAccountTabScreen() }
    }
}


private struct LpspUberEatsSpectrHomeTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Deliver to · Home").font(.system(size: 16.0, weight: .bold)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
        Text("Search Uber Eats").font(.system(size: 15.0, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
            Text("Featured").font(.system(size: 14.0, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
            Text("Pizza").font(.system(size: 14.0, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
            Text("Sushi").font(.system(size: 14.0, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
            Text("Burgers").font(.system(size: 14.0, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
            Text("Healthy").font(.system(size: 14.0, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
        ScrollView {
            VStack(spacing: 12) {
                    Text("$0 Delivery Fee").font(.system(size: 11.0, weight: .bold)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
                Text("Sunrise Diner").font(.system(size: 17.0, weight: .bold)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
                    Text("4.8").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
                    Text("· 25 min ·").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
                    Text("$0 Delivery Fee").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
                Text("Green Bowl Kitchen").font(.system(size: 17.0, weight: .bold)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
                    Text("4.7").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
                    Text("· 30 min · $1.49 Delivery Fee").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
            }
        }
            Text("3").font(.system(size: 12.0, weight: .bold)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
            Text("View cart").font(.system(size: 16.0, weight: .bold)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
            Text("$28.40").font(.system(size: 16.0, weight: .bold)).foregroundStyle(Color(red: 0.000, green: 0.000, blue: 0.000))
        }
        .background(Color(red: 1.000, green: 1.000, blue: 1.000).ignoresSafeArea())
    }
}



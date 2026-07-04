import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/expedia
// Meliwat/awesome-ios-design-md/travel/expedia/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeExpediaView: View {
    var body: some View {
        LpspExpediaShowroomRoot()
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

// MARK: - Écrans showroom

private struct LpspExpediaShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspExpediaSpectrHomeTabScreen()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(0)
            LpspExpediaTravelTabScreen(title: "Saved", tabIndex: 1)
                .tabItem { Label("Saved", systemImage: "heart") }
                .tag(1)
            LpspExpediaTravelTabScreen(title: "Trips", tabIndex: 2)
                .tabItem { Label("Trips", systemImage: "suitcase") }
                .tag(2)
            LpspExpediaTravelTabScreen(title: "Support", tabIndex: 3)
                .tabItem { Label("Support", systemImage: "questionmark.circle") }
                .tag(3)
            LpspExpediaTravelTabScreen(title: "Account", tabIndex: 4)
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
                .tag(4)
        }
        .tint(LpspExpediaTokens.expActionBlue)
        
    }
}


private struct LpspExpediaGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspExpediaTokens.expActionBlue.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspExpediaTokens.expActionBlue))
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


private struct LpspExpediaTravelExploreTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(0..<6, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LpspExpediaTokens.expActionBlue.opacity(0.1 + Double(i) * 0.05))
                            .frame(height: 180)
                            .overlay(alignment: .bottomLeading) {
                                Text("Logement \(i + 1)").font(.headline).padding(8)
                            }
                    }
                }
                .padding()
            }
            .background(LpspExpediaTokens.expCanvas.ignoresSafeArea())
            .navigationTitle("Explore")
        }
    }
}

private struct LpspExpediaTravelTripsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Paris · 12–15 juil.", "Lisbonne · 3–7 août"], id: \.self) { trip in
                Label(trip, systemImage: "airplane")
            }
            .navigationTitle("Trips")
        }
    }
}

private struct LpspExpediaTravelInboxTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Message hôte · Paris", "Rappel check-in"], id: \.self) { msg in
                Label(msg, systemImage: "message")
            }
            .navigationTitle("Inbox")
        }
    }
}

private struct LpspExpediaTravelProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Circle().fill(LpspExpediaTokens.expActionBlue.gradient).frame(width: 72, height: 72)
                Text("lost.phone").font(.title2.bold())
            }
            .navigationTitle("Profile")
        }
    }
}

private struct LpspExpediaTravelWishlistsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Paris loft", "Bretagne bord de mer"], id: \.self) { Label($0, systemImage: "heart") }
            .navigationTitle("Wishlists")
        }
    }
}

private struct LpspExpediaTravelTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if low.contains("wishlist") || low.contains("favori") { LpspExpediaTravelWishlistsTabScreen() }
        else if low.contains("explor") || low.contains("search") || low.contains("recherch") { LpspExpediaTravelExploreTabScreen() }
        else if low.contains("trip") || low.contains("voyage") { LpspExpediaTravelTripsTabScreen() }
        else if low.contains("inbox") || low.contains("message") { LpspExpediaTravelInboxTabScreen() }
        else if low.contains("profil") || low.contains("profile") { LpspExpediaTravelProfileTabScreen() }
        else if tabIndex == 0 { LpspExpediaTravelExploreTabScreen() }
        else { LpspExpediaTravelTripsTabScreen() }
    }
}


private struct LpspExpediaSpectrHomeTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
                Text("Expedia").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("12,480 One Key").font(.system(size: 14))
            Text("Stays").font(.system(size: 12.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Flights").font(.system(size: 12.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Cars").font(.system(size: 12.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Bundle").font(.system(size: 12.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                    Text("San Diego, CA").font(.system(size: 14.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Oct 12 – 17 · 2 travelers · 1 room").font(.system(size: 11.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            } .padding(.horizontal, 14).padding(.vertical, 12).background(Color(red: 0.122, green: 0.149, blue: 0.188)).clipShape(RoundedRectangle(cornerRadius: 28))
        } .padding(.horizontal, 16).padding(.top, 8)
            Text("Bundle + Save deals").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("See all").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("−24% Bundle").font(.system(size: 11.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Hotel Republic San Diego").font(.system(size: 15.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Downtown · Gaslamp Quarter").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("9.2").font(.system(size: 12.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("Wonderful").font(.system(size: 14, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("· 1,847 reviews").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("$268").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("$204").font(.system(size: 18.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("/ night").font(.system(size: 12.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Earn 2,040 One Key cash").font(.system(size: 11.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Member price").font(.system(size: 11.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("The Guild Hotel, Autograph").font(.system(size: 15.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Marina District · 0.4 mi from center").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("8.8").font(.system(size: 12.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("Excellent").font(.system(size: 14, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("· 932 reviews").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("$251").font(.system(size: 18.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("/ night").font(.system(size: 12.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Earn 2,510 One Key cash").font(.system(size: 11.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        }
        .background(Color(red: 0.055, green: 0.067, blue: 0.086).ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}



import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/finance/revolut/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/revolut
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeBanqueView: View {
    var body: some View {
        LpspBanqueShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspBanqueTokens {
    // MARK: - Canvas & Surfaces
    static let revCanvas   = Color(red: 0.039, green: 0.039, blue: 0.059) // #0A0A0F
    static let revSurface1 = Color(red: 0.086, green: 0.086, blue: 0.122) // #16161F
    static let revSurface2 = Color(red: 0.118, green: 0.118, blue: 0.165) // #1E1E2A
    static let revSurface3 = Color(red: 0.157, green: 0.157, blue: 0.227) // #28283A
    static let revDivider  = Color(red: 0.165, green: 0.165, blue: 0.220) // #2A2A38
    static let revBorder   = Color(red: 0.200, green: 0.200, blue: 0.290) // #33334A

    // MARK: - Text
    static let revTextPrimary   = Color.white                                  // #FFFFFF
    static let revTextSecondary = Color(red: 0.604, green: 0.604, blue: 0.667) // #9A9AAA
    static let revTextTertiary  = Color(red: 0.416, green: 0.416, blue: 0.494) // #6A6A7E

    // MARK: - Brand
    static let revGradStart = Color(red: 0.357, green: 0.420, blue: 1.000) // #5B6BFF
    static let revGradEnd   = Color(red: 0.612, green: 0.420, blue: 1.000) // #9C6BFF
    static let revBrand     = Color(red: 0.420, green: 0.357, blue: 1.000) // #6B5BFF
    static let revBrandPressed = Color(red: 0.337, green: 0.282, blue: 0.839) // #5648D6
    static let revBrandTint = Color(red: 0.110, green: 0.106, blue: 0.200) // #1C1B33

    // MARK: - Semantic
    static let revIncome = Color(red: 0.122, green: 0.820, blue: 0.482) // #1FD17B
    static let revSpend  = Color(red: 1.000, green: 0.353, blue: 0.416) // #FF5A6A
    static let revWarn   = Color(red: 1.000, green: 0.698, blue: 0.247) // #FFB23F
    static let revCrypto = Color(red: 0.969, green: 0.788, blue: 0.282) // #F7C948
}

private enum LpspBanqueGradients {
    static let revBrand = LinearGradient(
        colors: [LpspBanqueTokens.revGradStart, LpspBanqueTokens.revGradEnd],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}

private enum LpspBanqueFonts {
    static let revBalance     = Font.system(size: 40, weight: .regular)
    static let revTitleLarge  = Font.system(size: 28, weight: .regular)
    static let revSection     = Font.system(size: 22, weight: .regular)
    static let revTileBalance = Font.system(size: 22, weight: .regular)
    static let revSubsection  = Font.system(size: 18, weight: .regular)
    static let revAmount      = Font.system(size: 16, weight: .regular)
    static let revMerchant    = Font.system(size: 16, weight: .regular)
    static let revBody        = Font.system(size: 15, weight: .regular)
    static let revButton      = Font.system(size: 16, weight: .regular)
    static let revMeta        = Font.system(size: 13, weight: .regular)
    static let revLabelUpper  = Font.system(size: 11, weight: .regular)
    static let revTab         = Font.system(size: 10, weight: .regular)
    static let revCaption     = Font.system(size: 11, weight: .regular)
}

private enum LpspBanqueFonts {
    static func rev(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private struct LpspBanqueRevPrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspBanqueFonts.revButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(LinearGradient.revBrand, in: RoundedRectangle(cornerRadius: 16))
                .shadow(color: LpspBanqueTokens.revBrand.opacity(0.30), radius: 14, y: 8)
        }
        .sensoryFeedback(.impact(weight: .light), trigger: UUID())
        .buttonStyle(LpspBanqueRevPressableStyle())
    }
}

private struct LpspBanqueRevPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.85 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

private struct LpspBanqueRevSecondaryButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspBanqueFonts.revButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(LpspBanqueTokens.revSurface2, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(LpspBanqueRevPressableStyle())
    }
}

private struct LpspBanqueCurrencyTile: View {
    let flag: String      // emoji or asset
    let code: String
    let name: String
    let balance: String

    var body: some View {
        HStack(spacing: 12) {
            Text(flag)
                .font(.system(size: 20))
                .frame(width: 28, height: 28)
                .background(Circle().fill(LpspBanqueTokens.revSurface2))
            VStack(alignment: .leading, spacing: 2) {
                Text(code).font(LpspBanqueFonts.revMerchant).foregroundStyle(.white)
                Text(name).font(LpspBanqueFonts.revMeta).foregroundStyle(LpspBanqueTokens.revTextSecondary)
            }
            Spacer()
            Text(balance)
                .font(LpspBanqueFonts.revTileBalance)
                .monospacedDigit()
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspBanqueTokens.revSurface1)
                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(LpspBanqueTokens.revDivider, lineWidth: 1))
        )
    }
}

private struct LpspBanqueTransactionRow: View {
    let merchant: String
    let meta: String
    let amount: String
    let incoming: Bool
    let logo: Image

    var body: some View {
        HStack(spacing: 12) {
            logo
                .resizable().aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text(merchant).font(LpspBanqueFonts.revMerchant).foregroundStyle(.white).lineLimit(1)
                Text(meta).font(LpspBanqueFonts.revMeta).foregroundStyle(LpspBanqueTokens.revTextSecondary).lineLimit(1)
            }
            Spacer()
            Text(amount)
                .font(LpspBanqueFonts.revAmount)
                .monospacedDigit()
                .foregroundStyle(incoming ? LpspBanqueTokens.revIncome : .white)
        }
        .padding(.horizontal, 16)
        .frame(height: 64)
        .contentShape(Rectangle())
    }
}

private struct LpspBanqueSpendDonut: View {
    let total: String
    let progress: Double // 0...1
    @State private var animated: Double = 0

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle().stroke(LpspBanqueTokens.revSurface3, lineWidth: 14)
                Circle()
                    .trim(from: 0, to: animated)
                    .stroke(
                        AngularGradient(colors: [LpspBanqueTokens.revGradStart, LpspBanqueTokens.revGradEnd], center: .center),
                        style: StrokeStyle(lineWidth: 14, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                VStack(spacing: 2) {
                    Text(total).font(LpspBanqueFonts.revSection).monospacedDigit().foregroundStyle(.white)
                    Text("this month").font(LpspBanqueFonts.revMeta).foregroundStyle(LpspBanqueTokens.revTextSecondary)
                }
            }
            .frame(width: 180, height: 180)
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 20).fill(LpspBanqueTokens.revSurface1))
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) { animated = progress }
        }
    }
}

private struct LpspBanqueMetalCardHero: View {
    @State private var flipped = false
    @State private var sheen: CGFloat = -1

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(colors: [Color(white: 0.18), Color(white: 0.07)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            // diagonal sheen band
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(colors: [.clear, Color.white.opacity(0.18), .clear],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .offset(x: sheen * 260)
                .mask(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading) {
                Text("Revolut").font(LpspBanqueFonts.revSubsection).foregroundStyle(.white.opacity(0.9))
                Spacer()
                Text(flipped ? "CVV 042" : "•••• 4821")
                    .font(LpspBanqueFonts.revAmount).monospacedDigit().foregroundStyle(.white)
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .aspectRatio(1.586, contentMode: .fit)
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .shadow(color: .black.opacity(0.5), radius: 24, y: 8)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.45)) { flipped.toggle() }
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: flipped)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).delay(0.2)) { sheen = 1 }
        }
    }
}

extension View {
    /// Apply the brand gradient as a foreground (e.g., active icon tint).
    func revGradientForeground() -> some View {
        self.overlay(LinearGradient.revBrand).mask(self)
    }
}

// Glow modifier for active / primary elements
private struct LpspBanqueRevGlow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: LpspBanqueTokens.revBrand.opacity(0.30), radius: 14, y: 8)
    }
}

private struct LpspBanqueRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterialDark)
        appearance.backgroundColor = UIColor(LpspBanqueTokens.revCanvas).withAlphaComponent(0.92)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            InvestView().tabItem { Label("Invest", systemImage: "chart.line.uptrend.xyaxis") }
            CryptoView().tabItem { Label("Crypto", systemImage: "bitcoinsign.circle.fill") }
            LifestyleView().tabItem { Label("Lifestyle", systemImage: "sparkles") }
            CardsView().tabItem { Label("Cards", systemImage: "creditcard.fill") }
        }
        .tint(LpspBanqueTokens.revBrand) // gradient applied per-icon where possible; brand solid as TabView tint
    }
}

// Card flip — see LpspBanqueMetalCardHero: rotation3DEffect + .impact(weight: .medium)

// Gradient CTA press — LpspBanqueRevPressableStyle: opacity 0.85 + scale 0.98, 150ms

// Donut draw — Circle().trim animated 0→progress over 0.7s ease-out on appear

// Balance hide/reveal
private struct LpspBanqueBalanceReveal: ViewModifier {
    let hidden: Bool
    func body(content: Content) -> some View {
        content.blur(radius: hidden ? 12 : 0)
            .animation(.easeInOut(duration: 0.25), value: hidden)
    }
}

// Segmented thumb — matchedGeometryEffect on a gradient capsule, 0.22s ease

// MARK: - Écrans showroom

private struct LpspBanqueShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspBanqueFinanceHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspBanqueFinanceHomeTabScreen()
                .tabItem { Label("Invest", systemImage: "chart.line.uptrend.xyaxis") }
                .tag(1)
            LpspBanqueFinanceHomeTabScreen()
                .tabItem { Label("Crypto", systemImage: "bitcoinsign.circle.fill") }
                .tag(2)
            LpspBanqueFinanceHomeTabScreen()
                .tabItem { Label("Lifestyle", systemImage: "sparkles") }
                .tag(3)
            LpspBanqueFinanceCardsTabScreen()
                .tabItem { Label("Cards", systemImage: "creditcard.fill") }
                .tag(4)
        }
        .tint(LpspBanqueTokens.revBrand)
        
    }
}


private struct LpspBanqueGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspBanqueTokens.revBrand.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspBanqueTokens.revBrand))
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


private struct LpspBanqueFinanceHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Solde total").font(.subheadline).foregroundStyle(.secondary)
                        Text("2 847,50 €").font(.system(size: 36, weight: .bold))
                    }
                    .padding(.horizontal)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(colors: [LpspBanqueTokens.revBrand, LpspBanqueTokens.revBrand.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 180)
                        .overlay(alignment: .bottomLeading) {
                            Text("•••• 4829").font(.title2.bold()).foregroundStyle(.white).padding(20)
                        }
                        .padding(.horizontal)
                    Text("Transactions").font(.headline).padding(.horizontal)
                    ForEach(LpspBanqueDemoTx.items) { tx in
                        HStack {
                            Circle().fill(LpspBanqueTokens.revBrand.opacity(0.15)).frame(width: 40, height: 40)
                            VStack(alignment: .leading) { Text(tx.title); Text(tx.date).font(.caption).foregroundStyle(.secondary) }
                            Spacer()
                            Text(tx.amount).font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(tx.amount.hasPrefix("-") ? Color.primary : Color.green)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(LpspBanqueTokens.revCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
        }
    }
}

private struct LpspBanqueFinanceCardsTabScreen: View {
    var body: some View {
        NavigationStack {
            Text("Gérez vos cartes").padding().navigationTitle("Cartes")
        }
    }
}

private struct LpspBanqueDemoTx: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let amount: String
    static let items: [LpspBanqueDemoTx] = [
        .init(title: "Carrefour", date: "Aujourd'hui", amount: "-42,30 €"),
        .init(title: "Virement reçu", date: "Hier", amount: "+150,00 €"),
    ]
}



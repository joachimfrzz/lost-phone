import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/finance/coinbase/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/coinbase
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeCoinbaseView: View {
    var body: some View {
        LpspCoinbaseShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspCoinbaseTokens {
    // MARK: - Brand
    static let cbBlue        = Color(red: 0.00, green: 0.322, blue: 1.00)  // #0052FF
    static let cbBluePressed = Color(red: 0.00, green: 0.251, blue: 0.800) // #0040CC
    static let cbBlueTint    = Color(red: 0.898, green: 0.929, blue: 1.00) // #E5EDFF
    static let cbBlueDark    = Color(red: 0.231, green: 0.424, blue: 1.00) // #3B6CFF (dark-mode)
    static let cbBlack       = Color(red: 0.039, green: 0.043, blue: 0.051) // #0A0B0D
    static let cbCharcoal    = Color(red: 0.102, green: 0.110, blue: 0.122) // #1A1C1F

    // MARK: - Crypto Asset Colors
    static let cbBitcoin     = Color(red: 0.969, green: 0.576, blue: 0.102) // #F7931A
    static let cbEthereum    = Color(red: 0.384, green: 0.494, blue: 0.918) // #627EEA
    static let cbUSDC        = Color(red: 0.153, green: 0.459, blue: 0.792) // #2775CA
    static let cbSolana      = Color(red: 0.600, green: 0.271, blue: 1.00)  // #9945FF
    static let cbCardano     = Color(red: 0.00, green: 0.200, blue: 0.678)  // #0033AD
    static let cbTether      = Color(red: 0.149, green: 0.631, blue: 0.482) // #26A17B

    // MARK: - Canvas & Surfaces (light)
    static let cbCanvas      = Color(red: 1.00, green: 1.00, blue: 1.00)    // #FFFFFF
    static let cbSurfaceGray = Color(red: 0.969, green: 0.973, blue: 0.980) // #F7F8FA
    static let cbSurfaceGray2 = Color(red: 0.933, green: 0.941, blue: 0.953) // #EEF0F3
    static let cbDivider     = Color(red: 0.882, green: 0.894, blue: 0.910) // #E1E4E8

    // MARK: - Text (light)
    static let cbTextPrimary   = LpspCoinbaseTokens.cbBlack
    static let cbTextSecondary = Color(red: 0.357, green: 0.380, blue: 0.431) // #5B616E
    static let cbTextTertiary  = Color(red: 0.502, green: 0.525, blue: 0.561) // #80868F
    static let cbTextMuted     = Color(red: 0.627, green: 0.643, blue: 0.667) // #A0A4AA

    // MARK: - Semantic
    static let cbSuccess       = Color(red: 0.020, green: 0.694, blue: 0.412) // #05B169
    static let cbSuccessTint   = Color(red: 0.902, green: 0.969, blue: 0.937) // #E6F7EF
    static let cbLoss          = Color(red: 0.812, green: 0.125, blue: 0.184) // #CF202F
    static let cbLossTint      = Color(red: 0.988, green: 0.906, blue: 0.914) // #FCE7E9
    static let cbWarning       = Color(red: 0.961, green: 0.651, blue: 0.137) // #F5A623

    // MARK: - Dark mode
    static let cbDarkCanvas    = LpspCoinbaseTokens.cbBlack
    static let cbDarkSurface1  = Color(red: 0.075, green: 0.082, blue: 0.102) // #13151A
    static let cbDarkSurface2  = Color(red: 0.118, green: 0.125, blue: 0.149) // #1E2026
    static let cbDarkDivider   = Color(red: 0.165, green: 0.180, blue: 0.212) // #2A2E36
    static let cbDarkTextPri   = Color.white
    static let cbDarkTextSec   = Color(red: 0.627, green: 0.643, blue: 0.667) // #A0A4AA
}

private enum LpspCoinbaseFonts {
    // Hero amounts (Display variant)
    static let cbPortfolioHero = Font.system(size: 40, weight: .regular)
    static let cbBuyAmount     = Font.system(size: 56, weight: .regular)
    static let cbScreenTitle   = Font.system(size: 28, weight: .regular)

    // Sections & titles (Sans)
    static let cbSectionHeader = Font.system(size: 20, weight: .regular)
    static let cbAssetTitle    = Font.system(size: 16, weight: .regular)

    // Prices & deltas
    static let cbAssetPrice    = Font.system(size: 16, weight: .regular)
    static let cbAssetChange   = Font.system(size: 13, weight: .regular)

    // Body
    static let cbBody          = Font.system(size: 15, weight: .regular)
    static let cbBodySmall     = Font.system(size: 13, weight: .regular)

    // Micro
    static let cbTicker        = Font.system(size: 13, weight: .regular)
    static let cbTab           = Font.system(size: 10, weight: .regular)
    static let cbAllCaps       = Font.system(size: 11, weight: .regular)
    static let cbRangeChip     = Font.system(size: 13, weight: .regular)

    // Buttons
    static let cbButton        = Font.system(size: 16, weight: .regular)
    static let cbButtonSmall   = Font.system(size: 13, weight: .regular)

    // Mono (technical readouts)
    static let cbWalletAddr    = Font.system(size: 13, weight: .regular)
    static let cbTxHash        = Font.system(size: 12, weight: .regular)
}

// Fallback if Coinbase fonts aren't bundled — SF Pro / SF Mono:
private enum LpspCoinbaseFonts {
    static func cb(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
    static func cbMono(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }
}

private struct LpspCoinbasePortfolioHero: View {
    let value: Double
    let dayChange: Double
    let dayChangePct: Double

    private var isUp: Bool { dayChange >= 0 }
    private var sign: String { isUp ? "+" : "−" }
    private var color: Color { isUp ? LpspCoinbaseTokens.cbSuccess : LpspCoinbaseTokens.cbLoss }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("PORTFOLIO BALANCE")
                .font(LpspCoinbaseFonts.cbAllCaps)
                .tracking(0.6)
                .foregroundStyle(LpspCoinbaseTokens.cbTextSecondary)

            Text(value, format: .currency(code: "USD"))
                .font(LpspCoinbaseFonts.cbPortfolioHero)
                .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                .monospacedDigit()
                .contentTransition(.numericText())

            HStack(spacing: 4) {
                Text("\(sign)\(abs(dayChange), format: .currency(code: "USD"))")
                Text("(\(sign)\(abs(dayChangePct * 100), specifier: "%.2f")%)")
            }
            .font(LpspCoinbaseFonts.cbAssetPrice)
            .foregroundStyle(color)
            .monospacedDigit()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

private struct LpspCoinbaseAssetRow: View {
    let assetName: String       // "Bitcoin"
    let ticker: String          // "BTC"
    let holdings: String        // "0.1842 BTC"
    let price: Double           // 67234.18
    let dayChange: Double
    let dayChangePct: Double
    let iconColor: Color        // LpspCoinbaseTokens.cbBitcoin, LpspCoinbaseTokens.cbEthereum, etc.
    let glyph: String           // "₿", "Ξ", "$" etc.
    let sparklinePoints: [(Double, Double)]

    private var isUp: Bool { dayChange >= 0 }
    private var color: Color { isUp ? LpspCoinbaseTokens.cbSuccess : LpspCoinbaseTokens.cbLoss }
    private var sign: String { isUp ? "+" : "−" }

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                Circle().fill(iconColor)
                Text(glyph)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 2) {
                Text(assetName)
                    .font(LpspCoinbaseFonts.cbAssetTitle)
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                HStack(spacing: 4) {
                    Text(ticker).font(LpspCoinbaseFonts.cbTicker).tracking(0.3)
                    Text("· \(holdings)").font(LpspCoinbaseFonts.cbBodySmall)
                }
                .foregroundStyle(LpspCoinbaseTokens.cbTextSecondary)
            }

            Spacer()

            // Mini sparkline
            LpspCoinbaseMiniSparkline(points: sparklinePoints, color: color)
                .frame(width: 56, height: 20)

            VStack(alignment: .trailing, spacing: 2) {
                Text(price, format: .currency(code: "USD"))
                    .font(LpspCoinbaseFonts.cbAssetPrice)
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                    .monospacedDigit()
                Text("\(sign)\(abs(dayChangePct * 100), specifier: "%.2f")%")
                    .font(LpspCoinbaseFonts.cbAssetChange)
                    .foregroundStyle(color)
                    .monospacedDigit()
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 64)
        .background(LpspCoinbaseTokens.cbCanvas)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspCoinbaseTokens.cbDivider).frame(height: 0.5)
        }
    }
}

private struct LpspCoinbaseMiniSparkline: View {
    let points: [(Double, Double)]  // (timestamp, price)
    let color: Color

    var body: some View {
        GeometryReader { geo in
            Path { path in
                guard !points.isEmpty else { return }
                let xs = points.map(\.0)
                let ys = points.map(\.1)
                guard let xMin = xs.min(), let xMax = xs.max(),
                      let yMin = ys.min(), let yMax = ys.max(),
                      xMax > xMin, yMax > yMin else { return }
                let xRange = xMax - xMin
                let yRange = yMax - yMin
                for (i, p) in points.enumerated() {
                    let x = CGFloat((p.0 - xMin) / xRange) * geo.size.width
                    let y = geo.size.height - CGFloat((p.1 - yMin) / yRange) * geo.size.height
                    if i == 0 { path.move(to: CGPoint(x: x, y: y)) }
                    else { path.addLine(to: CGPoint(x: x, y: y)) }
                }
            }
            .stroke(color, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
        }
    }
}

private struct LpspCoinbaseAssetActionRow: View {
    var onBuy: () -> Void
    var onSell: () -> Void
    var onSend: () -> Void
    var onReceive: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            LpspCoinbaseActionButton(icon: "arrow.up", label: "Buy",     action: onBuy)
            LpspCoinbaseActionButton(icon: "arrow.down", label: "Sell",   action: onSell)
            LpspCoinbaseActionButton(icon: "paperplane", label: "Send",  action: onSend)
            LpspCoinbaseActionButton(icon: "qrcode", label: "Receive",   action: onReceive)
        }
        .padding(.horizontal, 16)
    }
}

private struct LpspCoinbaseActionButton: View {
    let icon: String
    let label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(LpspCoinbaseTokens.cbBlue)
                Text(label)
                    .font(LpspCoinbaseFonts.cbButtonSmall)
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(RoundedRectangle(cornerRadius: 12).fill(LpspCoinbaseTokens.cbSurfaceGray))
        }
    }
}

private struct LpspCoinbaseCBPrimaryButton: View {
    let label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspCoinbaseFonts.cbButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(RoundedRectangle(cornerRadius: 12).fill(LpspCoinbaseTokens.cbBlue))
        }
    }
}

private struct LpspCoinbaseCBSecondaryButton: View {
    let label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspCoinbaseFonts.cbButton)
                .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(RoundedRectangle(cornerRadius: 12).fill(LpspCoinbaseTokens.cbSurfaceGray2))
        }
    }
}

private struct LpspCoinbaseCoinbaseCMark: View {
    var size: CGFloat = 28
    var color: Color = LpspCoinbaseTokens.cbBlue

    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.18)
            Rectangle()
                .fill(color)
                .frame(width: size * 0.42, height: size * 0.16)
        }
        .frame(width: size, height: size)
    }
}

// Animated loading variant
private struct LpspCoinbaseCoinbaseCMarkLoading: View {
    @State private var rotate = 0.0

    var body: some View {
        LpspCoinbaseCoinbaseCMark()
            .rotationEffect(.degrees(rotate))
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    rotate = 360
                }
            }
    }
}

private struct LpspCoinbaseWalletAddressView: View {
    let address: String  // full address
    @State private var copied = false

    private var truncated: String {
        guard address.count > 14 else { return address }
        let start = address.prefix(10)
        let end = address.suffix(8)
        return "\(start)...\(end)"
    }

    var body: some View {
        Button(action: {
            UIPasteboard.general.string = address
            withAnimation { copied = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { copied = false }
        }) {
            HStack {
                Text(truncated)
                    .font(LpspCoinbaseFonts.cbWalletAddr)
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                Spacer()
                Image(systemName: copied ? "checkmark" : "doc.on.doc")
                    .foregroundStyle(copied ? LpspCoinbaseTokens.cbSuccess : LpspCoinbaseTokens.cbTextSecondary)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 8).fill(LpspCoinbaseTokens.cbSurfaceGray))
        }
    }
}

private struct LpspCoinbaseCoinbaseRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = UIColor(red: 0.882, green: 0.894, blue: 0.910, alpha: 1)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            HomeView()    .tabItem { Label("Home",    systemImage: "house") }
            TradeView()   .tabItem { Label("Trade",   systemImage: "arrow.left.arrow.right") }
            CardsView()   .tabItem { Label("Cards",   systemImage: "creditcard") }
            EarnView()    .tabItem { Label("Earn",    systemImage: "percent") }
            WalletView()  .tabItem { Label("Wallet",  systemImage: "wallet.pass") }
        }
        .tint(LpspCoinbaseTokens.cbBlue)
    }
}

// MARK: - Écrans showroom

private struct LpspCoinbaseShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspCoinbaseFinanceHomeTabScreen()
                .tabItem { Label("Accueil", systemImage: "house.fill") }
                .tag(0)
            LpspCoinbaseFinanceCardsTabScreen()
                .tabItem { Label("Cartes", systemImage: "creditcard.fill") }
                .tag(1)
            LpspCoinbaseFinanceHomeTabScreen()
                .tabItem { Label("Plus", systemImage: "ellipsis") }
                .tag(2)
        }
        .tint(LpspCoinbaseTokens.cbTextPrimary)
        
    }
}


private struct LpspCoinbaseGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspCoinbaseTokens.cbTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspCoinbaseTokens.cbTextPrimary))
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


private struct LpspCoinbaseFinanceHomeTabScreen: View {
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
                        .fill(LinearGradient(colors: [LpspCoinbaseTokens.cbTextPrimary, LpspCoinbaseTokens.cbTextPrimary.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 180)
                        .overlay(alignment: .bottomLeading) {
                            Text("•••• 4829").font(.title2.bold()).foregroundStyle(.white).padding(20)
                        }
                        .padding(.horizontal)
                    Text("Transactions").font(.headline).padding(.horizontal)
                    ForEach(LpspCoinbaseDemoTx.items) { tx in
                        HStack {
                            Circle().fill(LpspCoinbaseTokens.cbTextPrimary.opacity(0.15)).frame(width: 40, height: 40)
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
            .background(LpspCoinbaseTokens.cbCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
        }
    }
}

private struct LpspCoinbaseFinanceCardsTabScreen: View {
    var body: some View {
        NavigationStack {
            Text("Gérez vos cartes").padding().navigationTitle("Cartes")
        }
    }
}

private struct LpspCoinbaseDemoTx: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let amount: String
    static let items: [LpspCoinbaseDemoTx] = [
        .init(title: "Carrefour", date: "Aujourd'hui", amount: "-42,30 €"),
        .init(title: "Virement reçu", date: "Hier", amount: "+150,00 €"),
    ]
}



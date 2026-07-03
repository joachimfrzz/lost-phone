import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/finance/binance/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/binance
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeBinanceView: View {
    var body: some View {
        LpspBinanceShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspBinanceTokens {
    // MARK: - Canvas & Surfaces (Dark — default)
    static let bnCanvas    = Color(red: 0.043, green: 0.055, blue: 0.067) // #0B0E11
    static let bnSurface1  = Color(red: 0.094, green: 0.102, blue: 0.125) // #181A20
    static let bnSurface2  = Color(red: 0.118, green: 0.125, blue: 0.149) // #1E2026
    static let bnSurface3  = Color(red: 0.169, green: 0.192, blue: 0.224) // #2B3139
    static let bnDivider   = Color(red: 0.169, green: 0.192, blue: 0.224) // #2B3139

    // MARK: - Canvas & Surfaces (Light — secondary)
    static let bnCanvasLight   = Color.white                                  // #FFFFFF
    static let bnSurface1Light = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let bnDividerLight  = Color(red: 0.918, green: 0.925, blue: 0.937) // #EAECEF

    // MARK: - Brand & Market Semantics
    static let bnYellow        = Color(red: 0.941, green: 0.725, blue: 0.043) // #F0B90B
    static let bnYellowPressed  = Color(red: 0.788, green: 0.580, blue: 0.0)  // #C99400
    static let bnUp            = Color(red: 0.055, green: 0.796, blue: 0.506) // #0ECB81
    static let bnDown          = Color(red: 0.965, green: 0.275, blue: 0.365) // #F6465D
    static let bnUpPressed     = Color(red: 0.043, green: 0.647, blue: 0.447) // #0BA572
    static let bnDownPressed   = Color(red: 0.851, green: 0.220, blue: 0.286) // #D93849

    // MARK: - Text
    static let bnTextPrimary    = Color(red: 0.918, green: 0.925, blue: 0.937) // #EAECEF
    static let bnTextSecondary  = Color(red: 0.518, green: 0.557, blue: 0.612) // #848E9C
    static let bnTextTertiary   = Color(red: 0.369, green: 0.400, blue: 0.451) // #5E6673
    static let bnTextPrimaryLt  = Color(red: 0.118, green: 0.137, blue: 0.161) // #1E2329

    // MARK: - Semantic / Info
    static let bnInfo  = Color(red: 0.200, green: 0.459, blue: 0.733) // #3375BB
}

// Tints
private enum LpspBinanceTokens {
    static let bnYellowTint = LpspBinanceTokens.bnYellow.opacity(0.12)
    static let bnAskFill    = LpspBinanceTokens.bnDown.opacity(0.14)
    static let bnBidFill     = LpspBinanceTokens.bnUp.opacity(0.14)
}

private enum LpspBinanceFonts {
    // UI Sans (IBM Plex Sans)
    static let bnScreenTitle = Font.system(size: 32, weight: .regular)
    static let bnSection     = Font.system(size: 22, weight: .regular)
    static let bnRowTitle    = Font.system(size: 18, weight: .regular)
    static let bnBody        = Font.system(size: 16, weight: .regular)
    static let bnListLabel   = Font.system(size: 14, weight: .regular)
    static let bnMeta        = Font.system(size: 14, weight: .regular)
    static let bnPill        = Font.system(size: 13, weight: .regular)
    static let bnCaption     = Font.system(size: 12, weight: .regular)
    static let bnTab         = Font.system(size: 10, weight: .regular)
    static let bnButton      = Font.system(size: 15, weight: .regular)

    // Numeric Mono (IBM Plex Mono) — always tabular
    static let bnBalance     = Font.system(size: 28, weight: .regular)
    static let bnPrice       = Font.system(size: 15, weight: .regular)
    static let bnNumber      = Font.system(size: 14, weight: .regular)
    static let bnMonoCaption = Font.system(size: 12, weight: .regular)
    static let bnMonoSmall   = Font.system(size: 10, weight: .regular)
}

// Apply tabular figures to every numeric Text
extension View {
    func bnTabular() -> some View { self.monospacedDigit() }
}

private struct LpspBinanceMarketRow: View {
    let symbol: String          // "BTC"
    let quote: String           // "USDT"
    let volume: String          // "1.42B"
    let price: String           // "67,284.10"
    let usd: String             // "$67,284.10"
    let changePct: Double       // 2.34

    private var up: Bool { changePct >= 0 }

    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(Color(red: 0.969, green: 0.576, blue: 0.102)) // BTC #F7931A
                .frame(width: 30, height: 30)
                .overlay(Text("B").font(.system(size: 13, weight: .bold)).foregroundStyle(.black))

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 2) {
                    Text(symbol).font(LpspBinanceFonts.bnListLabel).foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    Text("/\(quote)").font(.custom("IBMPlexSans-Medium", size: 11)).foregroundStyle(LpspBinanceTokens.bnTextTertiary)
                }
                Text("Vol \(volume)").font(.custom("IBMPlexSans-Regular", size: 11)).foregroundStyle(LpspBinanceTokens.bnTextSecondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(price).font(LpspBinanceFonts.bnNumber).bnTabular().foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                Text(usd).font(LpspBinanceFonts.bnMonoSmall).bnTabular().foregroundStyle(LpspBinanceTokens.bnTextSecondary)
            }

            Text("\(up ? "+" : "")\(changePct, specifier: "%.2f")%")
                .font(LpspBinanceFonts.bnPill).bnTabular()
                .foregroundStyle(.white)
                .frame(minWidth: 64)
                .padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 4).fill(up ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown))
                .padding(.leading, 8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .overlay(alignment: .bottom) { Rectangle().fill(LpspBinanceTokens.bnDivider).frame(height: 1) }
    }
}

private struct LpspBinanceOrderBookRow: View {
    let price: String
    let qty: String
    let depthRatio: CGFloat   // 0...1 cumulative size / max
    let isAsk: Bool

    var body: some View {
        ZStack(alignment: .trailing) {
            GeometryReader { geo in
                Rectangle()
                    .fill(isAsk ? LpspBinanceTokens.bnAskFill : LpspBinanceTokens.bnBidFill)
                    .frame(width: geo.size.width * depthRatio)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            HStack {
                Text(price).font(LpspBinanceFonts.bnMonoCaption).bnTabular()
                    .foregroundStyle(isAsk ? LpspBinanceTokens.bnDown : LpspBinanceTokens.bnUp)
                Spacer()
                Text(qty).font(LpspBinanceFonts.bnMonoCaption).bnTabular()
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
            }
            .padding(.horizontal, 8)
        }
        .frame(height: 22)
    }
}

private struct LpspBinanceSpreadRow: View {
    let last: String
    let up: Bool
    var body: some View {
        HStack(spacing: 6) {
            Text(last).font(.custom("IBMPlexMono-SemiBold", size: 16)).bnTabular()
                .foregroundStyle(up ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown)
            Image(systemName: up ? "arrow.up" : "arrow.down")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(up ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown)
            Spacer()
        }
        .padding(.horizontal, 8).padding(.vertical, 6)
    }
}

private struct LpspBinanceBalanceHero: View {
    let value: String      // "12,840.57"
    let currency: String   // "USDT"
    let pnl: String        // "+$214.86 (+1.70%)"
    let gain: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Text("Est. Total Value").font(LpspBinanceFonts.bnCaption).foregroundStyle(LpspBinanceTokens.bnTextSecondary)
                Image(systemName: "eye").font(.system(size: 12)).foregroundStyle(LpspBinanceTokens.bnTextSecondary)
            }
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value).font(LpspBinanceFonts.bnBalance).bnTabular().foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                Text(currency).font(.custom("IBMPlexSans-Medium", size: 14)).foregroundStyle(LpspBinanceTokens.bnTextSecondary)
            }
            Text("\(pnl) Today").font(LpspBinanceFonts.bnMonoCaption).bnTabular()
                .foregroundStyle(gain ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown)
        }
        .padding(.horizontal, 16)
    }
}

private struct LpspBinanceTradeTicket: View {
    @State private var isBuy = true
    @State private var pct: Int = 0

    var body: some View {
        VStack(spacing: 12) {
            // Buy/Sell toggle
            HStack(spacing: 0) {
                ForEach([true, false], id: \.self) { buy in
                    Text(buy ? "Buy" : "Sell")
                        .font(LpspBinanceFonts.bnButton)
                        .foregroundStyle(isBuy == buy ? .white : LpspBinanceTokens.bnTextSecondary)
                        .frame(maxWidth: .infinity).frame(height: 36)
                        .background(isBuy == buy ? (buy ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown) : LpspBinanceTokens.bnSurface3)
                        .onTapGesture { isBuy = buy }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))

            // Percentage slider chips
            HStack(spacing: 8) {
                ForEach([25, 50, 75, 100], id: \.self) { p in
                    Text("\(p)%")
                        .font(.custom("IBMPlexSans-SemiBold", size: 13))
                        .foregroundStyle(pct == p ? LpspBinanceTokens.bnYellow : LpspBinanceTokens.bnTextSecondary)
                        .padding(.vertical, 7).frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 500)
                            .fill(pct == p ? LpspBinanceTokens.bnYellowTint : LpspBinanceTokens.bnSurface3))
                        .onTapGesture { pct = p }
                }
            }

            Button { } label: {
                Text(isBuy ? "Buy BTC" : "Sell BTC")
                    .font(LpspBinanceFonts.bnButton).foregroundStyle(.white)
                    .frame(maxWidth: .infinity).frame(height: 48)
                    .background(RoundedRectangle(cornerRadius: 8).fill(isBuy ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown))
            }
        }
        .padding(16)
        .background(LpspBinanceTokens.bnSurface1)
    }
}

private struct LpspBinanceBinancePrimaryButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title).font(LpspBinanceFonts.bnButton)
                .foregroundStyle(LpspBinanceTokens.bnCanvas)        // black text on yellow
                .frame(maxWidth: .infinity).frame(height: 48)
                .background(RoundedRectangle(cornerRadius: 8).fill(LpspBinanceTokens.bnYellow))
        }
        .buttonStyle(.plain)
    }
}

private struct LpspBinanceConvertCard: View {
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                LpspBinanceConvertTile(role: "From", coin: "BTC", avail: "0.482")
                LpspBinanceConvertTile(role: "To",   coin: "USDT", avail: "12,840.57")
            }
            Circle().fill(LpspBinanceTokens.bnYellow).frame(width: 36, height: 36)
                .overlay(Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 14, weight: .bold)).foregroundStyle(LpspBinanceTokens.bnCanvas))
        }
    }
}

private struct LpspBinanceConvertTile: View {
    let role: String; let coin: String; let avail: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack(spacing: 6) {
                    Circle().fill(LpspBinanceTokens.bnYellow).frame(width: 24, height: 24)
                    Text(coin).font(LpspBinanceFonts.bnListLabel).foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    Image(systemName: "chevron.down").font(.system(size: 11)).foregroundStyle(LpspBinanceTokens.bnTextSecondary)
                }
                Spacer()
                Text("0.00").font(.custom("IBMPlexMono-SemiBold", size: 18)).bnTabular()
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
            }
            Text("\(role) · Available \(avail) \(coin)")
                .font(LpspBinanceFonts.bnMonoCaption).foregroundStyle(LpspBinanceTokens.bnTextSecondary)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 8).fill(LpspBinanceTokens.bnSurface2))
    }
}

private struct LpspBinanceBinanceTabView: View {
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            MarketsView().tabItem { Label("Markets", systemImage: "chart.bar.fill") }
            TradeView().tabItem { Label("Trade", systemImage: "arrow.left.arrow.right") }
            FuturesView().tabItem { Label("Futures", systemImage: "chart.xyaxis.line") }
            WalletsView().tabItem { Label("Wallets", systemImage: "creditcard.fill") }
        }
        .tint(LpspBinanceTokens.bnYellow)
        .onAppear {
            let a = UITabBarAppearance()
            a.configureWithOpaqueBackground()
            a.backgroundColor = UIColor(LpspBinanceTokens.bnCanvas)
            a.shadowColor = UIColor(LpspBinanceTokens.bnDivider)
            UITabBar.appearance().standardAppearance = a
            UITabBar.appearance().scrollEdgeAppearance = a
        }
    }
}

private struct LpspBinanceBinanceTheme: ViewModifier {
    @Environment(\.colorScheme) var scheme
    func body(content: Content) -> some View {
        content
            .background(scheme == .dark ? LpspBinanceTokens.bnCanvas : LpspBinanceTokens.bnCanvasLight)
            .foregroundStyle(scheme == .dark ? LpspBinanceTokens.bnTextPrimary : LpspBinanceTokens.bnTextPrimaryLt)
    }
}
extension View { func binanceTheme() -> some View { modifier(LpspBinanceBinanceTheme()) } }

// MARK: - Écrans showroom

private struct LpspBinanceShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspBinanceFinanceHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspBinanceFinanceHomeTabScreen()
                .tabItem { Label("Markets", systemImage: "chart.bar.fill") }
                .tag(1)
            LpspBinanceFinanceHomeTabScreen()
                .tabItem { Label("Trade", systemImage: "arrow.left.arrow.right") }
                .tag(2)
            LpspBinanceFinanceHomeTabScreen()
                .tabItem { Label("Futures", systemImage: "chart.xyaxis.line") }
                .tag(3)
            LpspBinanceFinanceHomeTabScreen()
                .tabItem { Label("Wallets", systemImage: "creditcard.fill") }
                .tag(4)
        }
        .tint(LpspBinanceTokens.bnTextPrimary)
        
    }
}


private struct LpspBinanceGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspBinanceTokens.bnTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspBinanceTokens.bnTextPrimary))
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


private struct LpspBinanceFinanceHomeTabScreen: View {
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
                        .fill(LinearGradient(colors: [LpspBinanceTokens.bnTextPrimary, LpspBinanceTokens.bnTextPrimary.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 180)
                        .overlay(alignment: .bottomLeading) {
                            Text("•••• 4829").font(.title2.bold()).foregroundStyle(.white).padding(20)
                        }
                        .padding(.horizontal)
                    Text("Transactions").font(.headline).padding(.horizontal)
                    ForEach(LpspBinanceDemoTx.items) { tx in
                        HStack {
                            Circle().fill(LpspBinanceTokens.bnTextPrimary.opacity(0.15)).frame(width: 40, height: 40)
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
            .background(LpspBinanceTokens.bnCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
        }
    }
}

private struct LpspBinanceFinanceCardsTabScreen: View {
    var body: some View {
        NavigationStack {
            Text("Gérez vos cartes").padding().navigationTitle("Cartes")
        }
    }
}

private struct LpspBinanceDemoTx: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let amount: String
    static let items: [LpspBinanceDemoTx] = [
        .init(title: "Carrefour", date: "Aujourd'hui", amount: "-42,30 €"),
        .init(title: "Virement reçu", date: "Hier", amount: "+150,00 €"),
    ]
}



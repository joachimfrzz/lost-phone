import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/binance
// Meliwat/awesome-ios-design-md/finance/binance/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeBinanceView: View {
    var body: some View {
        LpspBinanceShowroomRoot(store: LpspBinanceStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspBinanceTokens {
    static let bnCanvas    = Color(red: 0.043, green: 0.055, blue: 0.067) // #0B0E11
    static let bnSurface1  = Color(red: 0.094, green: 0.102, blue: 0.125) // #181A20
    static let bnSurface2  = Color(red: 0.118, green: 0.125, blue: 0.149) // #1E2026
    static let bnSurface3  = Color(red: 0.169, green: 0.192, blue: 0.224) // #2B3139
    static let bnDivider   = Color(red: 0.169, green: 0.192, blue: 0.224) // #2B3139
    static let bnCanvasLight   = Color.white                                  // #FFFFFF
    static let bnSurface1Light = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let bnDividerLight  = Color(red: 0.918, green: 0.925, blue: 0.937) // #EAECEF
    static let bnYellow        = Color(red: 0.941, green: 0.725, blue: 0.043) // #F0B90B
    static let bnYellowPressed  = Color(red: 0.788, green: 0.580, blue: 0.0)  // #C99400
    static let bnUp            = Color(red: 0.055, green: 0.796, blue: 0.506) // #0ECB81
    static let bnDown          = Color(red: 0.965, green: 0.275, blue: 0.365) // #F6465D
    static let bnUpPressed     = Color(red: 0.043, green: 0.647, blue: 0.447) // #0BA572
    static let bnDownPressed   = Color(red: 0.851, green: 0.220, blue: 0.286) // #D93849
    static let bnTextPrimary    = Color(red: 0.918, green: 0.925, blue: 0.937) // #EAECEF
    static let bnTextSecondary  = Color(red: 0.518, green: 0.557, blue: 0.612) // #848E9C
    static let bnTextTertiary   = Color(red: 0.369, green: 0.400, blue: 0.451) // #5E6673
    static let bnTextPrimaryLt  = Color(red: 0.118, green: 0.137, blue: 0.161) // #1E2329
    static let bnInfo  = Color(red: 0.200, green: 0.459, blue: 0.733) // #3375BB
    static let bnYellowTint = LpspBinanceTokens.bnYellow.opacity(0.12)
    static let bnAskFill    = LpspBinanceTokens.bnDown.opacity(0.14)
    static let bnBidFill     = LpspBinanceTokens.bnUp.opacity(0.14)
}



// Tints


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
fileprivate extension View {
    func bnTabular() -> some View { self.monospacedDigit() }
}

fileprivate struct LpspBinanceMarketRow: View {
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

fileprivate struct LpspBinanceOrderBookRow: View {
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

fileprivate struct LpspBinanceSpreadRow: View {
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

fileprivate struct LpspBinanceBalanceHero: View {
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

fileprivate struct LpspBinanceTradeTicket: View {
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

fileprivate struct LpspBinanceBinancePrimaryButton: View {
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

fileprivate struct LpspBinanceConvertCard: View {
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

fileprivate struct LpspBinanceConvertTile: View {
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


fileprivate struct LpspBinanceBinanceTheme: ViewModifier {
    @Environment(\.colorScheme) var scheme
    func body(content: Content) -> some View {
        content
            .background(scheme == .dark ? LpspBinanceTokens.bnCanvas : LpspBinanceTokens.bnCanvasLight)
            .foregroundStyle(scheme == .dark ? LpspBinanceTokens.bnTextPrimary : LpspBinanceTokens.bnTextPrimaryLt)
    }
}
fileprivate extension View { func binanceTheme() -> some View { modifier(LpspBinanceBinanceTheme()) } }

// MARK: - Showroom data & store

private enum LpspBinanceShowroomTab: String, CaseIterable, Identifiable {
    case home, markets, trade, futures, wallets

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .markets: "Markets"
        case .trade: "Trade"
        case .futures: "Futures"
        case .wallets: "Wallets"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .markets: "chart.bar.fill"
        case .trade: "chart.line.uptrend.xyaxis"
        case .futures: "shippingbox.fill"
        case .wallets: "creditcard.fill"
        }
    }
}

private enum LpspBinanceMarketFilter: String, CaseIterable, Identifiable {
    case favorites, spot, futures, hot

    var id: String { rawValue }

    var title: String {
        switch self {
        case .favorites: "Favorites"
        case .spot: "Spot"
        case .futures: "Futures"
        case .hot: "Hot"
        }
    }
}

private struct LpspBinanceMarket: Identifiable, Equatable {
    let id: String
    let symbol: String
    let quote: String
    let volume: String
    let price: String
    let usd: String
    let changePct: Double
    let iconLetter: String
    let iconColor: Color
    var isFavorite: Bool
    var isFutures: Bool
}

private enum LpspBinanceShowroomData {
    static let markets: [LpspBinanceMarket] = [
        LpspBinanceMarket(
            id: "btc",
            symbol: "BTC",
            quote: "USDT",
            volume: "1.42B",
            price: "67,284.10",
            usd: "$67,284.10",
            changePct: 2.34,
            iconLetter: "B",
            iconColor: Color(red: 0.969, green: 0.576, blue: 0.102),
            isFavorite: true,
            isFutures: true
        ),
        LpspBinanceMarket(
            id: "eth",
            symbol: "ETH",
            quote: "USDT",
            volume: "884M",
            price: "3,512.66",
            usd: "$3,512.66",
            changePct: -0.92,
            iconLetter: "E",
            iconColor: Color(red: 0.38, green: 0.44, blue: 0.92),
            isFavorite: true,
            isFutures: true
        ),
        LpspBinanceMarket(
            id: "bnb",
            symbol: "BNB",
            quote: "USDT",
            volume: "312M",
            price: "604.20",
            usd: "$604.20",
            changePct: 1.08,
            iconLetter: "B",
            iconColor: Color(red: 0.941, green: 0.725, blue: 0.043),
            isFavorite: true,
            isFutures: false
        ),
        LpspBinanceMarket(
            id: "sol",
            symbol: "SOL",
            quote: "USDT",
            volume: "198M",
            price: "172.43",
            usd: "$172.43",
            changePct: 4.61,
            iconLetter: "S",
            iconColor: Color(red: 0.58, green: 0.32, blue: 0.92),
            isFavorite: true,
            isFutures: false
        ),
    ]

    static let walletAssets = [
        ("BTC", "0.482", "$32,430.12"),
        ("USDT", "12,840.57", "$12,840.57"),
        ("ETH", "1.24", "$4,355.70"),
    ]
}

@MainActor
fileprivate final class LpspBinanceStore: ObservableObject {
    @Published var selectedTab: LpspBinanceShowroomTab = .home
    @Published var marketFilter: LpspBinanceMarketFilter = .favorites
    @Published var markets: [LpspBinanceMarket] = LpspBinanceShowroomData.markets
    @Published var balanceValue = "12,840.57"
    @Published var balanceHidden = false
    @Published var searchQuery = ""
    @Published var selectedPairID = "btc"
    @Published var isBuy = true
    @Published var tradePercent = 0
    @Published var showConvertSheet = false
    @Published var lastActionMessage = ""

    var pnlLabel: String { "+$214.86 (+1.70%)" }

    var selectedPair: LpspBinanceMarket {
        markets.first { $0.id == selectedPairID } ?? LpspBinanceShowroomData.markets[0]
    }

    var filteredMarkets: [LpspBinanceMarket] {
        var list = markets
        if !searchQuery.isEmpty {
            list = list.filter {
                $0.symbol.localizedCaseInsensitiveContains(searchQuery)
                    || $0.quote.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        switch marketFilter {
        case .favorites:
            list = list.filter(\.isFavorite)
        case .spot:
            break
        case .futures:
            list = list.filter(\.isFutures)
        case .hot:
            list = list.sorted { abs($0.changePct) > abs($1.changePct) }
        }
        return list
    }

    func setMarketFilter(_ filter: LpspBinanceMarketFilter) {
        marketFilter = filter
    }

    func toggleBalanceVisibility() {
        balanceHidden.toggle()
    }

    func selectPair(_ market: LpspBinanceMarket) {
        selectedPairID = market.id
        selectedTab = .trade
    }

    func toggleFavorite(_ marketID: String) {
        guard let index = markets.firstIndex(where: { $0.id == marketID }) else { return }
        markets[index].isFavorite.toggle()
    }

    func setTradeSide(buy: Bool) {
        isBuy = buy
    }

    func setTradePercent(_ percent: Int) {
        tradePercent = percent
    }

    func executeTrade() {
        lastActionMessage = "\(isBuy ? "Bought" : "Sold") \(selectedPair.symbol) · \(tradePercent)%"
    }

    func deposit() {
        lastActionMessage = "Deposit initiated"
        selectedTab = .wallets
    }

    func withdraw() {
        lastActionMessage = "Withdrawal opened"
        selectedTab = .wallets
    }

    func openConvert() {
        showConvertSheet = true
    }
}

// MARK: - Écrans showroom

private struct LpspBinanceShowroomRoot: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspBinanceSpectrHomeTabScreen(store: store)
                case .markets:
                    LpspBinanceMarketsTabScreen(store: store)
                case .trade:
                    LpspBinanceTradeTabScreen(store: store)
                case .futures:
                    LpspBinanceFuturesTabScreen(store: store)
                case .wallets:
                    LpspBinanceWalletsTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspBinanceLabeledTabBar(store: store)
        }
        .background(LpspBinanceTokens.bnCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .sheet(isPresented: $store.showConvertSheet) {
            LpspBinanceConvertSheet()
        }
    }
}

private struct LpspBinanceLabeledTabBar: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        HStack {
            ForEach(LpspBinanceShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspBinanceFonts.bnTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspBinanceTokens.bnYellow
                            : LpspBinanceTokens.bnTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspBinanceTokens.bnCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspBinanceTokens.bnDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspBinanceSpectrSearchRow: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(LpspBinanceTokens.bnTextSecondary)
                TextField("Search BTC, ETH, BNB…", text: $store.searchQuery)
                    .font(LpspBinanceFonts.bnBody)
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    .tint(LpspBinanceTokens.bnYellow)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(LpspBinanceTokens.bnSurface2)
            )

            Image(systemName: "bell")
                .font(.system(size: 20))
                .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(LpspBinanceTokens.bnSurface2)
                )
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}

private struct LpspBinanceShowroomBalanceHero: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Text("Est. Total Value")
                    .font(LpspBinanceFonts.bnCaption)
                    .foregroundStyle(LpspBinanceTokens.bnTextSecondary)
                Button(action: { store.toggleBalanceVisibility() }) {
                    Image(systemName: store.balanceHidden ? "eye.slash" : "eye")
                        .font(.system(size: 12))
                        .foregroundStyle(LpspBinanceTokens.bnTextSecondary)
                }
                .buttonStyle(.plain)
            }
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(store.balanceHidden ? "••••••" : store.balanceValue)
                    .font(LpspBinanceFonts.bnBalance)
                    .bnTabular()
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                Text("USDT")
                    .font(LpspBinanceFonts.bnMeta)
                    .foregroundStyle(LpspBinanceTokens.bnTextSecondary)
            }
            Text("\(store.pnlLabel) Today")
                .font(LpspBinanceFonts.bnMonoCaption)
                .bnTabular()
                .foregroundStyle(LpspBinanceTokens.bnUp)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
}

private struct LpspBinanceQuickActionsRow: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        HStack(spacing: 10) {
            Button(action: { store.deposit() }) {
                Text("Deposit")
                    .font(LpspBinanceFonts.bnButton.weight(.semibold))
                    .foregroundStyle(LpspBinanceTokens.bnCanvas)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LpspBinanceTokens.bnYellow)
                    )
            }
            .buttonStyle(.plain)

            Button(action: { store.withdraw() }) {
                Text("Withdraw")
                    .font(LpspBinanceFonts.bnButton.weight(.semibold))
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(LpspBinanceTokens.bnSurface3, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)

            Button(action: { store.openConvert() }) {
                Text("Convert")
                    .font(LpspBinanceFonts.bnButton.weight(.semibold))
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(LpspBinanceTokens.bnSurface3, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
}

private struct LpspBinanceMarketFilterRow: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(LpspBinanceMarketFilter.allCases) { filter in
                    Button {
                        store.setMarketFilter(filter)
                    } label: {
                        Text(filter.title)
                            .font(LpspBinanceFonts.bnListLabel.weight(store.marketFilter == filter ? .semibold : .regular))
                            .foregroundStyle(
                                store.marketFilter == filter
                                    ? LpspBinanceTokens.bnTextPrimary
                                    : LpspBinanceTokens.bnTextSecondary
                            )
                            .overlay(alignment: .bottom) {
                                if store.marketFilter == filter {
                                    Rectangle()
                                        .fill(LpspBinanceTokens.bnYellow)
                                        .frame(height: 2)
                                        .offset(y: 8)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}

private struct LpspBinanceShowroomMarketRow: View {
    let market: LpspBinanceMarket
    let onTap: () -> Void

    private var up: Bool { market.changePct >= 0 }

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 10) {
                Circle()
                    .fill(market.iconColor)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text(market.iconLetter)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.black)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 2) {
                        Text(market.symbol)
                            .font(LpspBinanceFonts.bnListLabel)
                            .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                        Text("/\(market.quote)")
                            .font(LpspBinanceFonts.bnMonoSmall)
                            .foregroundStyle(LpspBinanceTokens.bnTextTertiary)
                    }
                    Text("Vol \(market.volume)")
                        .font(LpspBinanceFonts.bnMonoSmall)
                        .foregroundStyle(LpspBinanceTokens.bnTextSecondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(market.price)
                        .font(LpspBinanceFonts.bnNumber)
                        .bnTabular()
                        .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    Text(market.usd)
                        .font(LpspBinanceFonts.bnMonoSmall)
                        .bnTabular()
                        .foregroundStyle(LpspBinanceTokens.bnTextSecondary)
                }

                Text("\(up ? "+" : "")\(market.changePct, specifier: "%.2f")%")
                    .font(LpspBinanceFonts.bnPill)
                    .bnTabular()
                    .foregroundStyle(.white)
                    .frame(minWidth: 64)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(up ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown)
                    )
                    .padding(.leading, 8)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(LpspBinanceTokens.bnDivider)
                    .frame(height: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct LpspBinanceSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LpspBinanceSpectrSearchRow(store: store)
                LpspBinanceShowroomBalanceHero(store: store)
                LpspBinanceQuickActionsRow(store: store)
                LpspBinanceMarketFilterRow(store: store)

                VStack(spacing: 0) {
                    ForEach(store.filteredMarkets) { market in
                        LpspBinanceShowroomMarketRow(market: market) {
                            store.selectPair(market)
                        }
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspBinanceMarketsTabScreen: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                Text("Markets")
                    .font(LpspBinanceFonts.bnScreenTitle.weight(.bold))
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                LpspBinanceSpectrSearchRow(store: store)
                LpspBinanceMarketFilterRow(store: store)

                ForEach(store.filteredMarkets) { market in
                    LpspBinanceShowroomMarketRow(market: market) {
                        store.selectPair(market)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspBinanceShowroomTradeTicket: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                ForEach([true, false], id: \.self) { buy in
                    Button {
                        store.setTradeSide(buy: buy)
                    } label: {
                        Text(buy ? "Buy" : "Sell")
                            .font(LpspBinanceFonts.bnButton)
                            .foregroundStyle(store.isBuy == buy ? .white : LpspBinanceTokens.bnTextSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 36)
                            .background(
                                store.isBuy == buy
                                    ? (buy ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown)
                                    : LpspBinanceTokens.bnSurface3
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))

            HStack(spacing: 8) {
                ForEach([25, 50, 75, 100], id: \.self) { percent in
                    Button {
                        store.setTradePercent(percent)
                    } label: {
                        Text("\(percent)%")
                            .font(LpspBinanceFonts.bnPill.weight(.semibold))
                            .foregroundStyle(
                                store.tradePercent == percent
                                    ? LpspBinanceTokens.bnYellow
                                    : LpspBinanceTokens.bnTextSecondary
                            )
                            .padding(.vertical, 7)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 500)
                                    .fill(
                                        store.tradePercent == percent
                                            ? LpspBinanceTokens.bnYellowTint
                                            : LpspBinanceTokens.bnSurface3
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }

            Button(action: { store.executeTrade() }) {
                Text(store.isBuy ? "Buy \(store.selectedPair.symbol)" : "Sell \(store.selectedPair.symbol)")
                    .font(LpspBinanceFonts.bnButton)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(store.isBuy ? LpspBinanceTokens.bnUp : LpspBinanceTokens.bnDown)
                    )
            }
            .buttonStyle(.plain)

            if !store.lastActionMessage.isEmpty {
                Text(store.lastActionMessage)
                    .font(LpspBinanceFonts.bnCaption)
                    .foregroundStyle(LpspBinanceTokens.bnTextSecondary)
            }
        }
        .padding(16)
        .background(LpspBinanceTokens.bnSurface1)
    }
}

private struct LpspBinanceTradeTabScreen: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("\(store.selectedPair.symbol)/\(store.selectedPair.quote)")
                        .font(LpspBinanceFonts.bnRowTitle.weight(.bold))
                        .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    Spacer()
                    Text(store.selectedPair.price)
                        .font(LpspBinanceFonts.bnPrice.weight(.semibold))
                        .bnTabular()
                        .foregroundStyle(LpspBinanceTokens.bnUp)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)

                VStack(spacing: 0) {
                    ForEach(["67,285.40", "67,284.80", "67,284.10"], id: \.self) { price in
                        LpspBinanceOrderBookRow(
                            price: price,
                            qty: "0.842",
                            depthRatio: 0.6,
                            isAsk: true
                        )
                    }
                    LpspBinanceSpreadRow(last: store.selectedPair.price, up: store.selectedPair.changePct >= 0)
                    ForEach(["67,283.60", "67,283.10", "67,282.50"], id: \.self) { price in
                        LpspBinanceOrderBookRow(
                            price: price,
                            qty: "1.204",
                            depthRatio: 0.45,
                            isAsk: false
                        )
                    }
                }
                .padding(.horizontal, 16)

                LpspBinanceShowroomTradeTicket(store: store)
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspBinanceFuturesTabScreen: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Futures")
                    .font(LpspBinanceFonts.bnScreenTitle.weight(.bold))
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                ForEach(store.markets.filter(\.isFutures)) { market in
                    LpspBinanceShowroomMarketRow(market: market) {
                        store.selectPair(market)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspBinanceWalletsTabScreen: View {
    @ObservedObject var store: LpspBinanceStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                LpspBinanceShowroomBalanceHero(store: store)
                    .padding(.top, 8)

                if !store.lastActionMessage.isEmpty {
                    Text(store.lastActionMessage)
                        .font(LpspBinanceFonts.bnCaption)
                        .foregroundStyle(LpspBinanceTokens.bnYellow)
                        .padding(.horizontal, 16)
                }

                Text("Assets")
                    .font(LpspBinanceFonts.bnSection.weight(.bold))
                    .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    .padding(.horizontal, 16)

                ForEach(LpspBinanceShowroomData.walletAssets, id: \.0) { asset in
                    HStack {
                        Circle()
                            .fill(LpspBinanceTokens.bnYellow)
                            .frame(width: 32, height: 32)
                            .overlay(
                                Text(String(asset.0.prefix(1)))
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(LpspBinanceTokens.bnCanvas)
                            )
                        VStack(alignment: .leading, spacing: 2) {
                            Text(asset.0)
                                .font(LpspBinanceFonts.bnListLabel)
                                .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                            Text(asset.1)
                                .font(LpspBinanceFonts.bnMonoCaption)
                                .bnTabular()
                                .foregroundStyle(LpspBinanceTokens.bnTextSecondary)
                        }
                        Spacer()
                        Text(asset.2)
                            .font(LpspBinanceFonts.bnNumber)
                            .bnTabular()
                            .foregroundStyle(LpspBinanceTokens.bnTextPrimary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }

                LpspBinanceBinancePrimaryButton(title: "Add Funds") {
                    store.deposit()
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspBinanceConvertSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                LpspBinanceConvertCard()
                LpspBinanceBinancePrimaryButton(title: "Preview Conversion") {
                    dismiss()
                }
                Spacer()
            }
            .padding(16)
            .background(LpspBinanceTokens.bnCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .navigationTitle("Convert")
        }
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }
}


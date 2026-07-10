import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/coinbase
// Meliwat/awesome-ios-design-md/finance/coinbase/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeCoinbaseView: View {
    var body: some View {
        LpspCoinbaseShowroomRoot(store: LpspCoinbaseStore())
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



// Fallback if Coinbase fonts aren't bundled — SF Pro / SF Mono:


fileprivate struct LpspCoinbasePortfolioHero: View {
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
                .animation(.snappy, value: value)

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

fileprivate struct LpspCoinbaseAssetRow: View {
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

fileprivate struct LpspCoinbaseMiniSparkline: View {
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

fileprivate struct LpspCoinbaseAssetActionRow: View {
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

private enum LpspCoinbaseFonts {
    static let cbPortfolioHero = Font.system(size: 40, weight: .regular)
    static let cbBuyAmount     = Font.system(size: 56, weight: .regular)
    static let cbScreenTitle   = Font.system(size: 28, weight: .regular)
    static let cbSectionHeader = Font.system(size: 20, weight: .regular)
    static let cbAssetTitle    = Font.system(size: 16, weight: .regular)
    static let cbAssetPrice    = Font.system(size: 16, weight: .regular)
    static let cbAssetChange   = Font.system(size: 13, weight: .regular)
    static let cbBody          = Font.system(size: 15, weight: .regular)
    static let cbBodySmall     = Font.system(size: 13, weight: .regular)
    static let cbTicker        = Font.system(size: 13, weight: .regular)
    static let cbTab           = Font.system(size: 10, weight: .regular)
    static let cbAllCaps       = Font.system(size: 11, weight: .regular)
    static let cbRangeChip     = Font.system(size: 13, weight: .regular)
    static let cbButton        = Font.system(size: 16, weight: .regular)
    static let cbButtonSmall   = Font.system(size: 13, weight: .regular)
    static let cbWalletAddr    = Font.system(size: 13, weight: .regular)
    static let cbTxHash        = Font.system(size: 12, weight: .regular)
    static func cb(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
    static func cbMono(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
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
        .sensoryFeedback(.impact(weight: .light), trigger: UUID())
    }
}

fileprivate struct LpspCoinbaseCBPrimaryButton: View {
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
        .sensoryFeedback(.impact(weight: .medium), trigger: UUID())
    }
}

fileprivate struct LpspCoinbaseCBSecondaryButton: View {
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

fileprivate struct LpspCoinbaseCoinbaseCMark: View {
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
fileprivate struct LpspCoinbaseCoinbaseCMarkLoading: View {
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

fileprivate struct LpspCoinbaseWalletAddressView: View {
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
        .sensoryFeedback(.success, trigger: copied)
    }
}



// MARK: - Showroom data & store

private enum LpspCoinbaseShowroomTab: String, CaseIterable, Identifiable {
    case home, trade, cards, earn, wallet

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .trade: "Trade"
        case .cards: "Cards"
        case .earn: "Earn"
        case .wallet: "Wallet"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .trade: "arrow.left.arrow.right"
        case .cards: "creditcard.fill"
        case .earn: "chart.line.uptrend.xyaxis"
        case .wallet: "wallet.pass.fill"
        }
    }
}

private struct LpspCoinbaseAsset: Identifiable {
    let id: String
    let name: String
    let ticker: String
    let holdings: String
    let value: Double
    let dayChangePct: Double
    let iconColor: Color
    let glyph: String
    let sparklinePoints: [(Double, Double)]
}

private enum LpspCoinbaseShowroomData {
    static let rangeChips = ["1H", "1D", "1W", "1M", "1Y", "ALL"]

    static let portfolioChart: [(Double, Double)] = [
        (0, 60), (18, 55), (36, 58), (54, 50), (72, 52), (90, 48), (108, 42),
        (126, 46), (144, 38), (162, 40), (180, 32), (198, 30), (216, 28),
        (234, 22), (252, 24), (270, 18), (288, 14), (306, 16), (320, 10),
    ]

    static let assets: [LpspCoinbaseAsset] = [
        LpspCoinbaseAsset(
            id: "btc",
            name: "Bitcoin",
            ticker: "BTC",
            holdings: "0.1842 BTC",
            value: 12389.42,
            dayChangePct: 0.0192,
            iconColor: LpspCoinbaseTokens.cbBitcoin,
            glyph: "₿",
            sparklinePoints: [(0, 9), (6, 7), (12, 8), (18, 5), (24, 6), (30, 3), (36, 4), (40, 2)]
        ),
        LpspCoinbaseAsset(
            id: "eth",
            name: "Ethereum",
            ticker: "ETH",
            holdings: "0.62 ETH",
            value: 1847.62,
            dayChangePct: -0.0084,
            iconColor: LpspCoinbaseTokens.cbEthereum,
            glyph: "Ξ",
            sparklinePoints: [(0, 4), (6, 5), (12, 3), (18, 7), (24, 6), (30, 9), (36, 8), (40, 11)]
        ),
        LpspCoinbaseAsset(
            id: "usdc",
            name: "USD Coin",
            ticker: "USDC",
            holdings: "420.00 USDC",
            value: 420.00,
            dayChangePct: 0.0001,
            iconColor: LpspCoinbaseTokens.cbUSDC,
            glyph: "$",
            sparklinePoints: [(0, 7), (8, 7), (16, 6), (24, 7), (32, 7), (40, 6)]
        ),
        LpspCoinbaseAsset(
            id: "sol",
            name: "Solana",
            ticker: "SOL",
            holdings: "2.84 SOL",
            value: 590.81,
            dayChangePct: 0.0342,
            iconColor: LpspCoinbaseTokens.cbSolana,
            glyph: "S",
            sparklinePoints: [(0, 11), (6, 8), (12, 9), (18, 5), (24, 7), (30, 3), (36, 5), (40, 2)]
        ),
    ]

    static let earnProducts = [
        ("USDC", "4.10% APY"),
        ("ETH", "3.25% APY"),
        ("SOL", "5.80% APY"),
    ]

    static let recentTransactions: [(String, String, String, Bool)] = [
        ("Bought BTC", "+0.002 BTC", "Today", true),
        ("Sent ETH", "−0.05 ETH", "Yesterday", false),
        ("Received USDC", "+$120.00", "Mon", true),
        ("Sold SOL", "−1.2 SOL", "Sun", false),
    ]
}

@MainActor
fileprivate final class LpspCoinbaseStore: ObservableObject {
    @Published var selectedTab: LpspCoinbaseShowroomTab = .home
    @Published var portfolioValue: Double = 12_847.93
    @Published var dayChange: Double = 847.93
    @Published var dayChangePct: Double = 0.0659
    @Published var selectedRange = "1D"
    @Published var assets: [LpspCoinbaseAsset] = LpspCoinbaseShowroomData.assets
    @Published var selectedAssetID = "btc"
    @Published var lastActionMessage = ""
    @Published var showReceiveSheet = false
    @Published var tradeSide: TradeSide = .buy

    enum TradeSide: Hashable { case buy, sell }

    var selectedAsset: LpspCoinbaseAsset {
        assets.first { $0.id == selectedAssetID } ?? LpspCoinbaseShowroomData.assets[0]
    }

    func setRange(_ range: String) {
        selectedRange = range
    }

    func selectAsset(_ asset: LpspCoinbaseAsset) {
        selectedAssetID = asset.id
        selectedTab = .trade
    }

    func buy() {
        tradeSide = .buy
        selectedTab = .trade
        lastActionMessage = "Buy \(selectedAsset.ticker)"
    }

    func sell() {
        tradeSide = .sell
        selectedTab = .trade
        lastActionMessage = "Sell \(selectedAsset.ticker)"
    }

    func send() {
        lastActionMessage = "Send \(selectedAsset.ticker) opened"
        selectedTab = .wallet
    }

    func receive() {
        showReceiveSheet = true
        lastActionMessage = "Receive address ready"
    }

    func executeTrade() {
        let delta = tradeSide == .buy ? 120.0 : -120.0
        portfolioValue += delta
        dayChange += delta * 0.15
        lastActionMessage = "\(tradeSide == .buy ? "Bought" : "Sold") \(selectedAsset.ticker)"
    }
}

// MARK: - Écrans showroom

private struct LpspCoinbaseShowroomRoot: View {
    @ObservedObject var store: LpspCoinbaseStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspCoinbaseSpectrHomeTabScreen(store: store)
                case .trade:
                    LpspCoinbaseTradeTabScreen(store: store)
                case .cards:
                    LpspCoinbaseCardsTabScreen()
                case .earn:
                    LpspCoinbaseEarnTabScreen()
                case .wallet:
                    LpspCoinbaseWalletTabScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspCoinbaseLabeledTabBar(store: store)
        }
        .background(LpspCoinbaseTokens.cbCanvas.ignoresSafeArea())
        .sheet(isPresented: $store.showReceiveSheet) {
            LpspCoinbaseReceiveSheet(asset: store.selectedAsset)
        }
    }
}

private struct LpspCoinbaseLabeledTabBar: View {
    @ObservedObject var store: LpspCoinbaseStore

    var body: some View {
        HStack {
            ForEach(LpspCoinbaseShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspCoinbaseFonts.cbTab.weight(store.selectedTab == tab ? .semibold : .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspCoinbaseTokens.cbBlue
                            : LpspCoinbaseTokens.cbTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspCoinbaseTokens.cbCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspCoinbaseTokens.cbDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspCoinbaseSpectrTopBar: View {
    var body: some View {
        HStack {
            LpspCoinbaseCoinbaseCMark(size: 28)

            Spacer()

            HStack(spacing: 20) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                Image(systemName: "bell")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 4)
    }
}

private struct LpspCoinbaseShowroomPortfolioHero: View {
    @ObservedObject var store: LpspCoinbaseStore

    var body: some View {
        LpspCoinbasePortfolioHero(
            value: store.portfolioValue,
            dayChange: store.dayChange,
            dayChangePct: store.dayChangePct
        )
    }
}

private struct LpspCoinbasePortfolioChart: View {
    let points: [(Double, Double)]

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
                for (index, point) in points.enumerated() {
                    let x = CGFloat((point.0 - xMin) / xRange) * geo.size.width
                    let y = CGFloat((point.1 - yMin) / yRange) * geo.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(
                LpspCoinbaseTokens.cbBlue,
                style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
            )
        }
        .frame(height: 90)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}

private struct LpspCoinbaseRangeChipRow: View {
    @ObservedObject var store: LpspCoinbaseStore

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(LpspCoinbaseShowroomData.rangeChips, id: \.self) { range in
                    Button {
                        store.setRange(range)
                    } label: {
                        Text(range)
                            .font(LpspCoinbaseFonts.cbRangeChip.weight(store.selectedRange == range ? .semibold : .regular))
                            .foregroundStyle(
                                store.selectedRange == range
                                    ? LpspCoinbaseTokens.cbTextPrimary
                                    : LpspCoinbaseTokens.cbTextSecondary
                            )
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(
                                        store.selectedRange == range
                                            ? LpspCoinbaseTokens.cbSurfaceGray2
                                            : LpspCoinbaseTokens.cbSurfaceGray
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}

private struct LpspCoinbaseShowroomActionRow: View {
    @ObservedObject var store: LpspCoinbaseStore

    var body: some View {
        LpspCoinbaseAssetActionRow(
            onBuy: { store.buy() },
            onSell: { store.sell() },
            onSend: { store.send() },
            onReceive: { store.receive() }
        )
        .padding(.bottom, 8)
    }
}

private struct LpspCoinbaseShowroomAssetRow: View {
    let asset: LpspCoinbaseAsset
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            LpspCoinbaseAssetRow(
                assetName: asset.name,
                ticker: asset.ticker,
                holdings: asset.holdings,
                price: asset.value,
                dayChange: asset.value * asset.dayChangePct,
                dayChangePct: asset.dayChangePct,
                iconColor: asset.iconColor,
                glyph: asset.glyph,
                sparklinePoints: asset.sparklinePoints
            )
        }
        .buttonStyle(.plain)
    }
}

private struct LpspCoinbaseSpectrHomeTabScreen: View {
    @ObservedObject var store: LpspCoinbaseStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LpspCoinbaseSpectrTopBar()
                LpspCoinbaseShowroomPortfolioHero(store: store)
                LpspCoinbasePortfolioChart(points: LpspCoinbaseShowroomData.portfolioChart)
                LpspCoinbaseRangeChipRow(store: store)
                LpspCoinbaseShowroomActionRow(store: store)

                Text("Your assets")
                    .font(LpspCoinbaseFonts.cbSectionHeader.weight(.bold))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 4)

                ForEach(store.assets) { asset in
                    LpspCoinbaseShowroomAssetRow(asset: asset) {
                        store.selectAsset(asset)
                    }
                }

                Text("Recent activity")
                    .font(LpspCoinbaseFonts.cbSectionHeader.weight(.bold))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 4)

                ForEach(LpspCoinbaseShowroomData.recentTransactions, id: \.0) { tx in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(tx.0)
                                .font(LpspCoinbaseFonts.cbAssetTitle)
                                .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                            Text(tx.2)
                                .font(LpspCoinbaseFonts.cbBodySmall)
                                .foregroundStyle(LpspCoinbaseTokens.cbTextSecondary)
                        }
                        Spacer()
                        Text(tx.1)
                            .font(LpspCoinbaseFonts.cbAssetPrice)
                            .foregroundStyle(tx.3 ? LpspCoinbaseTokens.cbSuccess : LpspCoinbaseTokens.cbTextPrimary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .overlay(alignment: .bottom) {
                        Rectangle().fill(LpspCoinbaseTokens.cbDivider).frame(height: 0.5)
                    }
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspCoinbaseTradeTabScreen: View {
    @ObservedObject var store: LpspCoinbaseStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Trade")
                    .font(LpspCoinbaseFonts.cbScreenTitle.weight(.bold))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                HStack(spacing: 0) {
                    ForEach([LpspCoinbaseStore.TradeSide.buy, .sell], id: \.self) { side in
                        Button {
                            store.tradeSide = side
                        } label: {
                            Text(side == .buy ? "Buy" : "Sell")
                                .font(LpspCoinbaseFonts.cbButton.weight(.semibold))
                                .foregroundStyle(
                                    store.tradeSide == side
                                        ? .white
                                        : LpspCoinbaseTokens.cbTextSecondary
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(
                                    store.tradeSide == side
                                        ? LpspCoinbaseTokens.cbBlue
                                        : LpspCoinbaseTokens.cbSurfaceGray
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 16)

                ForEach(store.assets) { asset in
                    Button {
                        store.selectedAssetID = asset.id
                    } label: {
                        HStack {
                            Circle()
                                .fill(asset.iconColor)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Text(asset.glyph)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.white)
                                )
                            Text(asset.ticker)
                                .font(LpspCoinbaseFonts.cbAssetTitle.weight(.semibold))
                                .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                            Spacer()
                            if store.selectedAssetID == asset.id {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(LpspCoinbaseTokens.cbBlue)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }

                Text(store.selectedAsset.value, format: .currency(code: "USD"))
                    .font(LpspCoinbaseFonts.cbBuyAmount.weight(.bold))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)

                LpspCoinbaseCBPrimaryButton(
                    label: store.tradeSide == .buy
                        ? "Buy \(store.selectedAsset.ticker)"
                        : "Sell \(store.selectedAsset.ticker)"
                ) {
                    store.executeTrade()
                }
                .padding(.horizontal, 16)

                if !store.lastActionMessage.isEmpty {
                    Text(store.lastActionMessage)
                        .font(LpspCoinbaseFonts.cbBodySmall)
                        .foregroundStyle(LpspCoinbaseTokens.cbTextSecondary)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspCoinbaseCardsTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [LpspCoinbaseTokens.cbBlue, LpspCoinbaseTokens.cbBluePressed],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                    .overlay(alignment: .bottomLeading) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Coinbase Card")
                                .font(LpspCoinbaseFonts.cbAssetTitle.weight(.semibold))
                                .foregroundStyle(.white)
                            Text("•••• 4829")
                                .font(LpspCoinbaseFonts.cbBody)
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .padding(20)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                Text("Spend crypto anywhere Visa is accepted")
                    .font(LpspCoinbaseFonts.cbBody)
                    .foregroundStyle(LpspCoinbaseTokens.cbTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspCoinbaseEarnTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Earn")
                    .font(LpspCoinbaseFonts.cbScreenTitle.weight(.bold))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                ForEach(LpspCoinbaseShowroomData.earnProducts, id: \.0) { product in
                    HStack {
                        Circle()
                            .fill(LpspCoinbaseTokens.cbBlueTint)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text(product.0)
                                    .font(LpspCoinbaseFonts.cbTicker.weight(.bold))
                                    .foregroundStyle(LpspCoinbaseTokens.cbBlue)
                            )
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Earn \(product.0)")
                                .font(LpspCoinbaseFonts.cbAssetTitle)
                                .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                            Text(product.1)
                                .font(LpspCoinbaseFonts.cbBodySmall)
                                .foregroundStyle(LpspCoinbaseTokens.cbSuccess)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(LpspCoinbaseTokens.cbTextTertiary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspCoinbaseWalletTabScreen: View {
    @ObservedObject var store: LpspCoinbaseStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                LpspCoinbaseShowroomPortfolioHero(store: store)
                    .padding(.top, 8)

                Text("Holdings")
                    .font(LpspCoinbaseFonts.cbSectionHeader.weight(.bold))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)
                    .padding(.horizontal, 16)

                ForEach(store.assets) { asset in
                    LpspCoinbaseShowroomAssetRow(asset: asset) {
                        store.selectAsset(asset)
                    }
                }

                if !store.lastActionMessage.isEmpty {
                    Text(store.lastActionMessage)
                        .font(LpspCoinbaseFonts.cbBodySmall)
                        .foregroundStyle(LpspCoinbaseTokens.cbBlue)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
        }
    }
}

private struct LpspCoinbaseReceiveSheet: View {
    let asset: LpspCoinbaseAsset
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Receive \(asset.ticker)")
                    .font(LpspCoinbaseFonts.cbSectionHeader.weight(.bold))
                    .foregroundStyle(LpspCoinbaseTokens.cbTextPrimary)

                LpspCoinbaseWalletAddressView(
                    address: "0x742d35Cc6634C0532925a3b844Bc9e7595f0bEb"
                )

                LpspCoinbaseCBSecondaryButton(label: "Share address") {
                    dismiss()
                }

                Spacer()
            }
            .padding(16)
            .background(LpspCoinbaseTokens.cbCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}


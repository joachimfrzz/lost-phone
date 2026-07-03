import SwiftUI

// Source: Meliwat/awesome-ios-design-md — coinbase/DESIGN-swiftui.md
struct LpspAwesomeCoinbaseView: View {
    var body: some View {
        TabView {
            AwesomeCoinbaseTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Coinbase")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomeCoinbaseTabScreen(title: "Trade", icon: "square.grid.2x2.fill", appName: "Coinbase")
                .tabItem { Label("Trade", systemImage: "square.grid.2x2.fill") }
            AwesomeCoinbaseTabScreen(title: "Cards", icon: "square.grid.2x2.fill", appName: "Coinbase")
                .tabItem { Label("Cards", systemImage: "square.grid.2x2.fill") }
            AwesomeCoinbaseTabScreen(title: "Earn", icon: "square.grid.2x2.fill", appName: "Coinbase")
                .tabItem { Label("Earn", systemImage: "square.grid.2x2.fill") }
            AwesomeCoinbaseTabScreen(title: "Wallet", icon: "square.grid.2x2.fill", appName: "Coinbase")
                .tabItem { Label("Wallet", systemImage: "square.grid.2x2.fill") }
        }
        .tint(CoinbaseTokens.cbBlue)
    }
}

private enum CoinbaseTokens {
        static let cbBlue = Color(red: 0.00, green: 0.322, blue: 1.00)  // #0052FF
        static let cbBluePressed = Color(red: 0.00, green: 0.251, blue: 0.800) // #0040CC
        static let cbBlueTint = Color(red: 0.898, green: 0.929, blue: 1.00) // #E5EDFF
        static let cbBlueDark = Color(red: 0.231, green: 0.424, blue: 1.00) // #3B6CFF (dark-mode)
        static let cbBlack = Color(red: 0.039, green: 0.043, blue: 0.051) // #0A0B0D
        static let cbCharcoal = Color(red: 0.102, green: 0.110, blue: 0.122) // #1A1C1F
        static let cbBitcoin = Color(red: 0.969, green: 0.576, blue: 0.102) // #F7931A
        static let cbEthereum = Color(red: 0.384, green: 0.494, blue: 0.918) // #627EEA
        static let cbUSDC = Color(red: 0.153, green: 0.459, blue: 0.792) // #2775CA
        static let cbSolana = Color(red: 0.600, green: 0.271, blue: 1.00)  // #9945FF
        static let cbCardano = Color(red: 0.00, green: 0.200, blue: 0.678)  // #0033AD
        static let cbTether = Color(red: 0.149, green: 0.631, blue: 0.482) // #26A17B
        static let cbCanvas = Color(red: 1.00, green: 1.00, blue: 1.00)    // #FFFFFF
        static let cbSurfaceGray = Color(red: 0.969, green: 0.973, blue: 0.980) // #F7F8FA
        static let cbSurfaceGray2 = Color(red: 0.933, green: 0.941, blue: 0.953) // #EEF0F3
        static let cbDivider = Color(red: 0.882, green: 0.894, blue: 0.910) // #E1E4E8
        static let cbTextPrimary = Color.cbBlack
        static let cbTextSecondary = Color(red: 0.357, green: 0.380, blue: 0.431) // #5B616E
        static let cbTextTertiary = Color(red: 0.502, green: 0.525, blue: 0.561) // #80868F
        static let cbTextMuted = Color(red: 0.627, green: 0.643, blue: 0.667) // #A0A4AA
        static let cbSuccess = Color(red: 0.020, green: 0.694, blue: 0.412) // #05B169
        static let cbSuccessTint = Color(red: 0.902, green: 0.969, blue: 0.937) // #E6F7EF
        static let cbLoss = Color(red: 0.812, green: 0.125, blue: 0.184) // #CF202F
        static let cbLossTint = Color(red: 0.988, green: 0.906, blue: 0.914) // #FCE7E9
}

private struct AwesomeCoinbaseTabScreen: View {
    let title: String
    let icon: String
    let appName: String

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    header
                    sampleContent
                }
                .padding()
            }
            .background(CoinbaseTokens.cbCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(CoinbaseTokens.cbCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(CoinbaseTokens.cbBlue)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(CoinbaseTokens.cbBlue.opacity(0.12))
                .frame(height: 72)
                .overlay(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(title) item \(i + 1)")
                            .font(.headline)
                        Text("Awesome iOS DESIGN spec")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
        }
    }
}

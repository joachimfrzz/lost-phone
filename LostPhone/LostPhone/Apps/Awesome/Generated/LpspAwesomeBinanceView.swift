import SwiftUI

// Source: Meliwat/awesome-ios-design-md — binance/DESIGN-swiftui.md
struct LpspAwesomeBinanceView: View {
    var body: some View {
        TabView {
            AwesomeBinanceTabScreen(title: "Home", icon: "house.fill", appName: "Binance")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeBinanceTabScreen(title: "Markets", icon: "chart.bar.fill", appName: "Binance")
                .tabItem { Label("Markets", systemImage: "chart.bar.fill") }
            AwesomeBinanceTabScreen(title: "Trade", icon: "arrow.left.arrow.right", appName: "Binance")
                .tabItem { Label("Trade", systemImage: "arrow.left.arrow.right") }
            AwesomeBinanceTabScreen(title: "Futures", icon: "chart.xyaxis.line", appName: "Binance")
                .tabItem { Label("Futures", systemImage: "chart.xyaxis.line") }
            AwesomeBinanceTabScreen(title: "Wallets", icon: "creditcard.fill", appName: "Binance")
                .tabItem { Label("Wallets", systemImage: "creditcard.fill") }
        }
        .tint(BinanceTokens.bnCanvas)
    }
}

private enum BinanceTokens {
        static let bnCanvas = Color(red: 0.043, green: 0.055, blue: 0.067) // #0B0E11
        static let bnSurface1 = Color(red: 0.094, green: 0.102, blue: 0.125) // #181A20
        static let bnSurface2 = Color(red: 0.118, green: 0.125, blue: 0.149) // #1E2026
        static let bnSurface3 = Color(red: 0.169, green: 0.192, blue: 0.224) // #2B3139
        static let bnDivider = Color(red: 0.169, green: 0.192, blue: 0.224) // #2B3139
        static let bnCanvasLight = Color.white                                  // #FFFFFF
        static let bnSurface1Light = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
        static let bnDividerLight = Color(red: 0.918, green: 0.925, blue: 0.937) // #EAECEF
        static let bnYellow = Color(red: 0.941, green: 0.725, blue: 0.043) // #F0B90B
        static let bnYellowPressed = Color(red: 0.788, green: 0.580, blue: 0.0)  // #C99400
        static let bnUp = Color(red: 0.055, green: 0.796, blue: 0.506) // #0ECB81
        static let bnDown = Color(red: 0.965, green: 0.275, blue: 0.365) // #F6465D
        static let bnUpPressed = Color(red: 0.043, green: 0.647, blue: 0.447) // #0BA572
        static let bnDownPressed = Color(red: 0.851, green: 0.220, blue: 0.286) // #D93849
        static let bnTextPrimary = Color(red: 0.918, green: 0.925, blue: 0.937) // #EAECEF
        static let bnTextSecondary = Color(red: 0.518, green: 0.557, blue: 0.612) // #848E9C
        static let bnTextTertiary = Color(red: 0.369, green: 0.400, blue: 0.451) // #5E6673
        static let bnTextPrimaryLt = Color(red: 0.118, green: 0.137, blue: 0.161) // #1E2329
        static let bnInfo = Color(red: 0.200, green: 0.459, blue: 0.733) // #3375BB
        static let bnYellowTint = Color.bnYellow.opacity(0.12)
        static let bnAskFill = Color.bnDown.opacity(0.14)
        static let bnBidFill = Color.bnUp.opacity(0.14)
}

private struct AwesomeBinanceTabScreen: View {
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
            .background(BinanceTokens.bnCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(BinanceTokens.bnCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(BinanceTokens.bnCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(BinanceTokens.bnCanvas.opacity(0.12))
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

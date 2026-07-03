import SwiftUI

// Source: Meliwat/awesome-ios-design-md — revolut/DESIGN-swiftui.md
struct LpspAwesomeRevolutView: View {
    var body: some View {
        TabView {
            AwesomeRevolutTabScreen(title: "Home", icon: "house.fill", appName: "Revolut")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeRevolutTabScreen(title: "Invest", icon: "chart.line.uptrend.xyaxis", appName: "Revolut")
                .tabItem { Label("Invest", systemImage: "chart.line.uptrend.xyaxis") }
            AwesomeRevolutTabScreen(title: "Crypto", icon: "bitcoinsign.circle.fill", appName: "Revolut")
                .tabItem { Label("Crypto", systemImage: "bitcoinsign.circle.fill") }
            AwesomeRevolutTabScreen(title: "Lifestyle", icon: "sparkles", appName: "Revolut")
                .tabItem { Label("Lifestyle", systemImage: "sparkles") }
            AwesomeRevolutTabScreen(title: "Cards", icon: "creditcard.fill", appName: "Revolut")
                .tabItem { Label("Cards", systemImage: "creditcard.fill") }
        }
        .tint(RevolutTokens.revCanvas)
    }
}

private enum RevolutTokens {
        static let revCanvas = Color(red: 0.039, green: 0.039, blue: 0.059) // #0A0A0F
        static let revSurface1 = Color(red: 0.086, green: 0.086, blue: 0.122) // #16161F
        static let revSurface2 = Color(red: 0.118, green: 0.118, blue: 0.165) // #1E1E2A
        static let revSurface3 = Color(red: 0.157, green: 0.157, blue: 0.227) // #28283A
        static let revDivider = Color(red: 0.165, green: 0.165, blue: 0.220) // #2A2A38
        static let revBorder = Color(red: 0.200, green: 0.200, blue: 0.290) // #33334A
        static let revTextPrimary = Color.white                                  // #FFFFFF
        static let revTextSecondary = Color(red: 0.604, green: 0.604, blue: 0.667) // #9A9AAA
        static let revTextTertiary = Color(red: 0.416, green: 0.416, blue: 0.494) // #6A6A7E
        static let revGradStart = Color(red: 0.357, green: 0.420, blue: 1.000) // #5B6BFF
        static let revGradEnd = Color(red: 0.612, green: 0.420, blue: 1.000) // #9C6BFF
        static let revBrand = Color(red: 0.420, green: 0.357, blue: 1.000) // #6B5BFF
        static let revBrandPressed = Color(red: 0.337, green: 0.282, blue: 0.839) // #5648D6
        static let revBrandTint = Color(red: 0.110, green: 0.106, blue: 0.200) // #1C1B33
        static let revIncome = Color(red: 0.122, green: 0.820, blue: 0.482) // #1FD17B
        static let revSpend = Color(red: 1.000, green: 0.353, blue: 0.416) // #FF5A6A
        static let revWarn = Color(red: 1.000, green: 0.698, blue: 0.247) // #FFB23F
        static let revCrypto = Color(red: 0.969, green: 0.788, blue: 0.282) // #F7C948
        static let revBrand = LinearGradient(
}

private struct AwesomeRevolutTabScreen: View {
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
            .background(RevolutTokens.revCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(RevolutTokens.revCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(RevolutTokens.revCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(RevolutTokens.revCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — paypal/DESIGN-swiftui.md
struct LpspAwesomePayPalView: View {
    var body: some View {
        TabView {
            AwesomePayPalTabScreen(title: "Activity", icon: "clock", appName: "PayPal")
                .tabItem { Label("Activity", systemImage: "clock") }
            AwesomePayPalTabScreen(title: "Finances", icon: "chart.line.uptrend.xyaxis", appName: "PayPal")
                .tabItem { Label("Finances", systemImage: "chart.line.uptrend.xyaxis") }
            AwesomePayPalTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "PayPal")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomePayPalTabScreen(title: "Send", icon: "square.grid.2x2.fill", appName: "PayPal")
                .tabItem { Label("Send", systemImage: "square.grid.2x2.fill") }
            AwesomePayPalTabScreen(title: "Wallet", icon: "square.grid.2x2.fill", appName: "PayPal")
                .tabItem { Label("Wallet", systemImage: "square.grid.2x2.fill") }
        }
        .tint(PayPalTokens.payPalBlue)
    }
}

private enum PayPalTokens {
        static let payPalBlue = Color(red: 0.00, green: 0.188, blue: 0.529)  // #003087
        static let payPalSky = Color(red: 0.00, green: 0.439, blue: 0.729)  // #0070BA
        static let payPalCobalt = Color(red: 0.00, green: 0.110, blue: 0.392)  // #001C64
        static let payPalBlueDark = Color(red: 0.231, green: 0.510, blue: 0.965) // #3B82F6 (dark-mode shifted)
        static let ppCanvas = Color(red: 1.00, green: 1.00, blue: 1.00)    // #FFFFFF
        static let ppSurfaceGray = Color(red: 0.961, green: 0.969, blue: 0.980) // #F5F7FA
        static let ppSurfaceGray2 = Color(red: 0.933, green: 0.945, blue: 0.957) // #EEF1F4
        static let ppDivider = Color(red: 0.898, green: 0.910, blue: 0.929) // #E5E8ED
        static let ppTextPrimary = Color(red: 0.00, green: 0.078, blue: 0.208)  // #001435
        static let ppTextSecondary = Color(red: 0.173, green: 0.180, blue: 0.184) // #2C2E2F
        static let ppTextMuted = Color(red: 0.408, green: 0.443, blue: 0.451) // #687173
        static let ppTextTertiary = Color(red: 0.616, green: 0.639, blue: 0.651) // #9DA3A6
        static let ppSuccess = Color(red: 0.110, green: 0.545, blue: 0.263) // #1C8B43
        static let ppSuccessBg = Color(red: 0.894, green: 0.961, blue: 0.918) // #E4F5EA
        static let ppError = Color(red: 0.824, green: 0.00, blue: 0.129)  // #D20021
        static let ppErrorBg = Color(red: 0.988, green: 0.898, blue: 0.910) // #FCE5E8
        static let ppWarning = Color(red: 1.00, green: 0.722, blue: 0.110)  // #FFB81C
        static let ppWarningBg = Color(red: 1.00, green: 0.965, blue: 0.878)  // #FFF6E0
        static let ppIconSent = Color.payPalBlue       // #003087
        static let ppIconReceived = Color.ppSuccess        // #1C8B43
        static let ppIconCard = Color.payPalSky        // #0070BA
        static let ppIconReward = Color.ppWarning        // #FFB81C
        static let ppDarkCanvas = Color(red: 0.039, green: 0.055, blue: 0.102) // #0A0E1A
        static let ppDarkSurface1 = Color(red: 0.078, green: 0.102, blue: 0.165) // #141A2A
}

private struct AwesomePayPalTabScreen: View {
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
            .background(PayPalTokens.ppCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(PayPalTokens.ppCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(PayPalTokens.payPalBlue)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(PayPalTokens.payPalBlue.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — deliveroo/DESIGN-swiftui.md
struct LpspAwesomeDeliverooView: View {
    var body: some View {
        TabView {
            AwesomeDeliverooTabScreen(title: "Favourites", icon: "heart", appName: "Deliveroo")
                .tabItem { Label("Favourites", systemImage: "heart") }
            AwesomeDeliverooTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Deliveroo")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomeDeliverooTabScreen(title: "Search", icon: "square.grid.2x2.fill", appName: "Deliveroo")
                .tabItem { Label("Search", systemImage: "square.grid.2x2.fill") }
            AwesomeDeliverooTabScreen(title: "Orders", icon: "square.grid.2x2.fill", appName: "Deliveroo")
                .tabItem { Label("Orders", systemImage: "square.grid.2x2.fill") }
            AwesomeDeliverooTabScreen(title: "Account", icon: "square.grid.2x2.fill", appName: "Deliveroo")
                .tabItem { Label("Account", systemImage: "square.grid.2x2.fill") }
        }
        .tint(DeliverooTokens.rooTeal)
    }
}

private enum DeliverooTokens {
        static let rooTeal = Color(red: 0.000, green: 0.800, blue: 0.737) // #00CCBC
        static let rooTealPressed = Color(red: 0.000, green: 0.663, blue: 0.612) // #00A99C
        static let rooTealInk = Color(red: 0.000, green: 0.216, blue: 0.200) // #003733  (on-teal content)
        static let rooPlusMint = Color(red: 0.769, green: 0.957, blue: 0.937) // #C4F4EF
        static let rooPromoGold = Color(red: 1.000, green: 0.757, blue: 0.000) // #FFC100
        static let rooCanvas = Color.white                                   // #FFFFFF
        static let rooSurface1 = Color(red: 0.957, green: 0.957, blue: 0.949) // #F4F4F2
        static let rooSurface2 = Color(red: 0.918, green: 0.918, blue: 0.910) // #EAEAE8
        static let rooDivider = Color(red: 0.910, green: 0.910, blue: 0.902) // #E8E8E6
        static let rooDarkCanvas = Color(red: 0.071, green: 0.071, blue: 0.071) // #121212
        static let rooDarkSurface1 = Color(red: 0.110, green: 0.110, blue: 0.118) // #1C1C1E
        static let rooDarkSurface2 = Color(red: 0.149, green: 0.149, blue: 0.161) // #262629
        static let rooDarkDivider = Color(red: 0.173, green: 0.173, blue: 0.180) // #2C2C2E
        static let rooTextPrimary = Color(red: 0.114, green: 0.114, blue: 0.106) // #1D1D1B
        static let rooTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420) // #6B6B6B
        static let rooTextTertiary = Color(red: 0.627, green: 0.627, blue: 0.627) // #A0A0A0
        static let rooDarkTextPrimary = Color(red: 0.957, green: 0.957, blue: 0.949) // #F4F4F2
        static let rooError = Color(red: 0.886, green: 0.282, blue: 0.239) // #E2483D
}

private struct AwesomeDeliverooTabScreen: View {
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
            .background(DeliverooTokens.rooCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(DeliverooTokens.rooCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(DeliverooTokens.rooTeal)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(DeliverooTokens.rooTeal.opacity(0.12))
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

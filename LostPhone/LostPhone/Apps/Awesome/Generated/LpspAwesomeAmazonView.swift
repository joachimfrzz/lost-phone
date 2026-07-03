import SwiftUI

// Source: Meliwat/awesome-ios-design-md — amazon/DESIGN-swiftui.md
struct LpspAwesomeAmazonView: View {
    var body: some View {
        TabView {
            AwesomeAmazonTabScreen(title: "Search", icon: "magnifyingglass", appName: "Amazon")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            AwesomeAmazonTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Amazon")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomeAmazonTabScreen(title: "Menu", icon: "square.grid.2x2.fill", appName: "Amazon")
                .tabItem { Label("Menu", systemImage: "square.grid.2x2.fill") }
            AwesomeAmazonTabScreen(title: "Cart", icon: "square.grid.2x2.fill", appName: "Amazon")
                .tabItem { Label("Cart", systemImage: "square.grid.2x2.fill") }
            AwesomeAmazonTabScreen(title: "You", icon: "square.grid.2x2.fill", appName: "Amazon")
                .tabItem { Label("You", systemImage: "square.grid.2x2.fill") }
        }
        .tint(AmazonTokens.amzCanvas)
    }
}

private enum AmazonTokens {
        static let amzCanvas = Color.white                                   // #FFFFFF
        static let amzSurfaceMuted = Color(red: 0.953, green: 0.953, blue: 0.953) // #F3F3F3
        static let amzSurfaceTint = Color(red: 0.969, green: 0.973, blue: 0.973) // #F7F8F8
        static let amzDivider = Color(red: 0.867, green: 0.867, blue: 0.867) // #DDDDDD
        static let amzBorderDefault = Color(red: 0.835, green: 0.851, blue: 0.851) // #D5D9D9
        static let amzTextPrimary = Color(red: 0.059, green: 0.067, blue: 0.067) // #0F1111
        static let amzTextSecondary = Color(red: 0.337, green: 0.349, blue: 0.349) // #565959
        static let amzTextTertiary = Color(red: 0.518, green: 0.541, blue: 0.549) // #848A8C
        static let amzYellow = Color(red: 1.000, green: 0.600, blue: 0.000) // #FF9900
        static let amzYellowPressed = Color(red: 0.902, green: 0.541, blue: 0.000) // #E68A00
        static let amzYellowHighlight = Color(red: 0.988, green: 0.824, blue: 0.000) // #FCD200
        static let amzBuyNowOrange = Color(red: 0.941, green: 0.533, blue: 0.016) // #F08804
        static let amzDeepNavy = Color(red: 0.075, green: 0.098, blue: 0.129) // #131921
        static let amzSecondaryNavy = Color(red: 0.137, green: 0.184, blue: 0.243) // #232F3E
        static let amzPriceRed = Color(red: 0.694, green: 0.153, blue: 0.016) // #B12704
        static let amzAlertRed = Color(red: 0.800, green: 0.047, blue: 0.224) // #CC0C39
        static let amzSuccessGreen = Color(red: 0.000, green: 0.463, blue: 0.000) // #007600
        static let amzPrimeTeal = Color(red: 0.000, green: 0.443, blue: 0.522) // #007185
        static let amzPrimeSky = Color(red: 0.000, green: 0.659, blue: 0.882) // #00A8E1
        static let amzRatingGold = Color(red: 1.000, green: 0.643, blue: 0.110) // #FFA41C
        static let amzDarkCanvas = Color(red: 0.059, green: 0.067, blue: 0.067) // #0F1111
        static let amzDarkSurface1 = Color(red: 0.102, green: 0.122, blue: 0.145) // #1A1F25
        static let amzDarkSurface2 = Color(red: 0.137, green: 0.184, blue: 0.243) // #232F3E
}

private struct AwesomeAmazonTabScreen: View {
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
            .background(AmazonTokens.amzCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(AmazonTokens.amzCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(AmazonTokens.amzCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AmazonTokens.amzCanvas.opacity(0.12))
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

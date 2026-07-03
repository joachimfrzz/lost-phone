import SwiftUI

// Source: Meliwat/awesome-ios-design-md — apple-tv/DESIGN-swiftui.md
struct LpspAwesomeAppleTVView: View {
    var body: some View {
        TabView {
            AwesomeAppleTVTabScreen(title: "Watch Now", icon: "play.tv", appName: "Apple TV")
                .tabItem { Label("Watch Now", systemImage: "play.tv") }
            AwesomeAppleTVTabScreen(title: "TV+", icon: "play.rectangle.on.rectangle", appName: "Apple TV")
                .tabItem { Label("TV+", systemImage: "play.rectangle.on.rectangle") }
            AwesomeAppleTVTabScreen(title: "Store", icon: "bag", appName: "Apple TV")
                .tabItem { Label("Store", systemImage: "bag") }
            AwesomeAppleTVTabScreen(title: "Search", icon: "magnifyingglass", appName: "Apple TV")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
        }
        .tint(AppleTVTokens.atvCanvas)
    }
}

private enum AppleTVTokens {
        static let atvCanvas = Color.black                                     // #000000
        static let atvSurface1 = Color(red: 0.110, green: 0.110, blue: 0.118)   // #1C1C1E
        static let atvSurface2 = Color(red: 0.173, green: 0.173, blue: 0.180)   // #2C2C2E
        static let atvDivider = Color(red: 0.220, green: 0.220, blue: 0.227)   // #38383A
        static let atvTextPrimary = Color.white                                 // #FFFFFF
        static let atvTextSecondary = Color(red: 0.596, green: 0.596, blue: 0.624) // #98989F
        static let atvTextTertiary = Color(red: 0.388, green: 0.388, blue: 0.400) // #636366
        static let atvCTA = Color.white                                    // #FFFFFF
        static let atvCTAPressed = Color(red: 0.898, green: 0.898, blue: 0.918)   // #E5E5EA
        static let atvCTALabel = Color.black                                    // #000000
        static let atvBlue = Color(red: 0.039, green: 0.518, blue: 1.000)  // #0A84FF
        static let atvBluePressed = Color(red: 0.000, green: 0.376, blue: 0.875)  // #0060DF
        static let atvMLS = Color(red: 0.929, green: 0.102, blue: 0.435)      // #ED1A6F (MLS only)
        static let atvLive = Color(red: 1.000, green: 0.271, blue: 0.227)      // #FF453A
        static let atvSuccess = Color(red: 0.188, green: 0.820, blue: 0.345)      // #30D158
        static let atvGold = Color(red: 1.000, green: 0.839, blue: 0.039)      // #FFD60A
        static let atvGlassFill = Color(red: 0.471, green: 0.471, blue: 0.502).opacity(0.36)
        static let atvHeroScrim = LinearGradient(
}

private struct AwesomeAppleTVTabScreen: View {
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
            .background(AppleTVTokens.atvCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(AppleTVTokens.atvCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(AppleTVTokens.atvCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AppleTVTokens.atvCanvas.opacity(0.12))
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

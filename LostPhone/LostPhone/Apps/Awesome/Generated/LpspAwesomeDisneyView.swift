import SwiftUI

// Source: Meliwat/awesome-ios-design-md — disney-plus/DESIGN-swiftui.md
struct LpspAwesomeDisneyView: View {
    var body: some View {
        TabView {
            AwesomeDisneyTabScreen(title: "Home", icon: "house.fill", appName: "Disney+")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeDisneyTabScreen(title: "Search", icon: "magnifyingglass", appName: "Disney+")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            AwesomeDisneyTabScreen(title: "Watchlist", icon: "plus.rectangle.on.rectangle", appName: "Disney+")
                .tabItem { Label("Watchlist", systemImage: "plus.rectangle.on.rectangle") }
            AwesomeDisneyTabScreen(title: "Downloads", icon: "arrow.down.circle", appName: "Disney+")
                .tabItem { Label("Downloads", systemImage: "arrow.down.circle") }
            AwesomeDisneyTabScreen(title: "Profile", icon: "person.crop.circle", appName: "Disney+")
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
        .tint(DisneyTokens.dpCanvas)
    }
}

private enum DisneyTokens {
        static let dpCanvas = Color(red: 0.039, green: 0.055, blue: 0.165) // #0A0E2A
        static let dpSurface1 = Color(red: 0.071, green: 0.082, blue: 0.180) // #12152E
        static let dpSurface2 = Color(red: 0.102, green: 0.122, blue: 0.239) // #1A1F3D
        static let dpDivider = Color(red: 0.165, green: 0.188, blue: 0.314) // #2A3050
        static let dpTextPrimary = Color.white                                 // #FFFFFF
        static let dpTextSecondary = Color(red: 0.627, green: 0.651, blue: 0.753) // #A0A6C0
        static let dpTextTertiary = Color(red: 0.353, green: 0.376, blue: 0.502) // #5A6080
        static let dpBlue = Color(red: 0.0,   green: 0.388, blue: 0.898) // #0063E5
        static let dpGlowBlue = Color(red: 0.102, green: 0.459, blue: 1.0)   // #1A75FF
        static let dpBluePressed = Color(red: 0.0,   green: 0.322, blue: 0.741) // #0052BD
        static let dpLiveRed = Color(red: 0.898, green: 0.282, blue: 0.302) // #E5484D
}

private struct AwesomeDisneyTabScreen: View {
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
            .background(DisneyTokens.dpCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(DisneyTokens.dpCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(DisneyTokens.dpCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(DisneyTokens.dpCanvas.opacity(0.12))
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

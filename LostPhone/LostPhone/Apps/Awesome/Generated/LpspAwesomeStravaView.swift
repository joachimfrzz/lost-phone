import SwiftUI

// Source: Meliwat/awesome-ios-design-md — strava/DESIGN-swiftui.md
struct LpspAwesomeStravaView: View {
    var body: some View {
        TabView {
            AwesomeStravaTabScreen(title: "Home", icon: "house", appName: "Strava")
                .tabItem { Label("Home", systemImage: "house") }
            AwesomeStravaTabScreen(title: "Maps", icon: "map", appName: "Strava")
                .tabItem { Label("Maps", systemImage: "map") }
            AwesomeStravaTabScreen(title: "Groups", icon: "person.3", appName: "Strava")
                .tabItem { Label("Groups", systemImage: "person.3") }
            AwesomeStravaTabScreen(title: "You", icon: "square.grid.2x2.fill", appName: "Strava")
                .tabItem { Label("You", systemImage: "square.grid.2x2.fill") }
        }
        .tint(StravaTokens.stravaOrange)
    }
}

private enum StravaTokens {
        static let stravaOrange = Color(red: 0.988, green: 0.298, blue: 0.008)  // #FC4C02
        static let stravaOrangePressed = Color(red: 0.831, green: 0.251, blue: 0.008)  // #D44002
        static let stravaOrangeHalo = Color(red: 0.988, green: 0.298, blue: 0.008).opacity(0.3)
        static let stravaCanvas = Color(red: 1.00, green: 1.00, blue: 1.00)     // #FFFFFF
        static let stravaSurfaceWarm = Color(red: 0.961, green: 0.957, blue: 0.949)  // #F5F4F2
        static let stravaSurfaceCool = Color(red: 0.941, green: 0.941, blue: 0.941)  // #F0F0F0
        static let stravaDivider = Color(red: 0.898, green: 0.898, blue: 0.898)  // #E5E5E5
        static let stravaMapTile = Color(red: 0.910, green: 0.898, blue: 0.867)  // #E8E5DD
        static let stravaInkPrimary = Color(red: 0.055, green: 0.055, blue: 0.055)  // #0E0E0E
        static let stravaInkSecondary = Color(red: 0.400, green: 0.400, blue: 0.400)  // #666666
        static let stravaInkTertiary = Color(red: 0.604, green: 0.604, blue: 0.604)  // #9A9A9A
        static let stravaDarkCanvas = Color(red: 0.059, green: 0.059, blue: 0.059)  // #0F0F0F coal
        static let stravaDarkSurface = Color(red: 0.102, green: 0.102, blue: 0.102)  // #1A1A1A
        static let stravaDarkSurface2 = Color(red: 0.149, green: 0.149, blue: 0.149)  // #262626
        static let stravaDarkDivider = Color(red: 0.165, green: 0.165, blue: 0.165)  // #2A2A2A
        static let stravaDarkText = Color(red: 0.949, green: 0.949, blue: 0.949)  // #F2F2F2
        static let stravaDarkTextSec = Color(red: 0.627, green: 0.627, blue: 0.627)  // #A0A0A0
        static let stravaDarkMapTile = Color(red: 0.106, green: 0.106, blue: 0.106)  // #1B1B1B
        static let stravaPRGold = Color(red: 0.961, green: 0.761, blue: 0.290)  // #F5C24A
        static let stravaSilver = Color(red: 0.776, green: 0.776, blue: 0.776)  // #C6C6C6
        static let stravaBronze = Color(red: 0.804, green: 0.498, blue: 0.196)  // #CD7F32
        static let stravaKOMCrown = Color(red: 1.00, green: 0.843, blue: 0.00)    // #FFD700
        static let stravaSuccess = Color(red: 0.133, green: 0.773, blue: 0.369)  // #22C55E
        static let stravaHeartRed = Color(red: 0.906, green: 0.298, blue: 0.235)  // #E74C3C
}

private struct AwesomeStravaTabScreen: View {
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
            .background(StravaTokens.stravaCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(StravaTokens.stravaCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(StravaTokens.stravaOrange)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(StravaTokens.stravaOrange.opacity(0.12))
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

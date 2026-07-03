import SwiftUI

// Source: Meliwat/awesome-ios-design-md — waze/DESIGN-swiftui.md
struct LpspAwesomeWazeView: View {
    var body: some View {
        TabView {
            AwesomeWazeTabScreen(title: "Accueil", icon: "house.fill", appName: "Waze")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeWazeTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Waze")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeWazeTabScreen(title: "Profil", icon: "person.fill", appName: "Waze")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(WazeTokens.wazePurple)
    }
}

private enum WazeTokens {
        static let wazePurple = Color(red: 0.494, green: 0.333, blue: 0.745)  // #7E55BE
        static let wazePurpleDeep = Color(red: 0.357, green: 0.235, blue: 0.604)  // #5B3C9A
        static let wazePurpleTint = Color(red: 0.910, green: 0.871, blue: 0.961)  // #E8DEF5
        static let wazeCyan = Color(red: 0.200, green: 0.800, blue: 1.000)  // #33CCFF
        static let wazeCyanDeep = Color(red: 0.000, green: 0.600, blue: 0.898)  // #0099E5
        static let wazePoliceRed = Color(red: 0.937, green: 0.416, blue: 0.396)  // #EF6A65
        static let wazeTrafficOrng = Color(red: 0.965, green: 0.596, blue: 0.200)  // #F69833
        static let wazeClosureYel = Color(red: 0.976, green: 0.769, blue: 0.180)  // #F9C42E
        static let wazeClearedGrn = Color(red: 0.459, green: 0.780, blue: 0.243)  // #75C73E
        static let wazeHazardBrown = Color(red: 0.545, green: 0.435, blue: 0.278)  // #8B6F47
        static let wazeCameraGray = Color(red: 0.420, green: 0.420, blue: 0.420)  // #6B6B6B
        static let wazeMapCream = Color(red: 1.000, green: 0.988, blue: 0.949)  // #FFFCF2
        static let wazeMapWater = Color(red: 0.608, green: 0.871, blue: 0.937)  // #9BDEEF
        static let wazeMapPark = Color(red: 0.773, green: 0.910, blue: 0.608)  // #C5E89B
        static let wazeMapRoadMajor = Color(red: 1.000, green: 1.000, blue: 1.000)  // #FFFFFF
        static let wazeMapRoadMinor = Color(red: 0.961, green: 0.941, blue: 0.898)  // #F5F0E5
        static let wazeMapHighway = Color(red: 1.000, green: 0.851, blue: 0.439)  // #FFD970
        static let wazeMapBuilding = Color(red: 0.910, green: 0.886, blue: 0.820)  // #E8E2D1
        static let wazeCardCanvas = Color(red: 1.000, green: 1.000, blue: 1.000)  // #FFFFFF
        static let wazeSurfaceGray = Color(red: 0.961, green: 0.961, blue: 0.969)  // #F5F5F7
        static let wazeSurfaceGray2 = Color(red: 0.918, green: 0.918, blue: 0.925)  // #EAEAEC
        static let wazeDivider = Color(red: 0.839, green: 0.839, blue: 0.851)  // #D6D6D9
        static let wazeInk = Color(red: 0.102, green: 0.102, blue: 0.102)  // #1A1A1A
        static let wazeSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)  // #6B6B6B
}

private struct AwesomeWazeTabScreen: View {
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
            .background(WazeTokens.wazeCardCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(WazeTokens.wazeCardCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(WazeTokens.wazePurple)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(WazeTokens.wazePurple.opacity(0.12))
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

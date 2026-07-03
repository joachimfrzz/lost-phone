import SwiftUI

// Source: Meliwat/awesome-ios-design-md — microsoft-teams/DESIGN-swiftui.md
struct LpspAwesomeTeamsView: View {
    var body: some View {
        TabView {
            AwesomeTeamsTabScreen(title: "Activity", icon: "bell.fill", appName: "Teams")
                .tabItem { Label("Activity", systemImage: "bell.fill") }
            AwesomeTeamsTabScreen(title: "Calendar", icon: "calendar", appName: "Teams")
                .tabItem { Label("Calendar", systemImage: "calendar") }
            AwesomeTeamsTabScreen(title: "Chat", icon: "square.grid.2x2.fill", appName: "Teams")
                .tabItem { Label("Chat", systemImage: "square.grid.2x2.fill") }
            AwesomeTeamsTabScreen(title: "Teams", icon: "square.grid.2x2.fill", appName: "Teams")
                .tabItem { Label("Teams", systemImage: "square.grid.2x2.fill") }
            AwesomeTeamsTabScreen(title: "Calls", icon: "square.grid.2x2.fill", appName: "Teams")
                .tabItem { Label("Calls", systemImage: "square.grid.2x2.fill") }
        }
        .tint(TeamsTokens.teamsLightCanvas)
    }
}

private enum TeamsTokens {
        static let teamsLightCanvas = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
        static let teamsLightSurface1 = Color.white                                  // #FFFFFF
        static let teamsLightSurface2 = Color(red: 0.941, green: 0.941, blue: 0.941) // #F0F0F0
        static let teamsLightDivider = Color(red: 0.882, green: 0.882, blue: 0.882) // #E1E1E1
        static let teamsLightText1 = Color(red: 0.145, green: 0.141, blue: 0.137) // #252423
        static let teamsLightText2 = Color(red: 0.380, green: 0.380, blue: 0.380) // #616161
        static let teamsDarkCanvas = Color(red: 0.122, green: 0.122, blue: 0.122)  // #1F1F1F
        static let teamsDarkSurface1 = Color(red: 0.176, green: 0.173, blue: 0.173)  // #2D2C2C
        static let teamsDarkSurface2 = Color(red: 0.239, green: 0.235, blue: 0.235)  // #3D3C3C
        static let teamsDarkDivider = Color(red: 0.239, green: 0.235, blue: 0.235)  // #3D3C3C
        static let teamsDarkText1 = Color.white                                   // #FFFFFF
        static let teamsDarkText2 = Color(red: 0.678, green: 0.678, blue: 0.678)  // #ADADAD
        static let teamsPurpleLight = Color(red: 0.384, green: 0.392, blue: 0.655)   // #6264A7
        static let teamsPurpleDark = Color(red: 0.357, green: 0.373, blue: 0.780)   // #5B5FC7
        static let teamsPurplePress = Color(red: 0.310, green: 0.322, blue: 0.698)   // #4F52B2
        static let teamsAvailable = Color(red: 0.420, green: 0.718, blue: 0.0)       // #6BB700
        static let teamsBusy = Color(red: 0.769, green: 0.192, blue: 0.294)     // #C4314B
        static let teamsAway = Color(red: 1.0,   green: 0.667, blue: 0.267)     // #FFAA44
        static let teamsOffline = Color(red: 0.541, green: 0.533, blue: 0.525)     // #8A8886
}

private struct AwesomeTeamsTabScreen: View {
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
            .background(TeamsTokens.teamsLightCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(TeamsTokens.teamsLightCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(TeamsTokens.teamsLightCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(TeamsTokens.teamsLightCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — google-maps/DESIGN-swiftui.md
struct LpspAwesomeGoogleMapsView: View {
    var body: some View {
        TabView {
            AwesomeGoogleMapsTabScreen(title: "Contribute", icon: "plus.circle.fill", appName: "Google Maps")
                .tabItem { Label("Contribute", systemImage: "plus.circle.fill") }
            AwesomeGoogleMapsTabScreen(title: "Explore", icon: "square.grid.2x2.fill", appName: "Google Maps")
                .tabItem { Label("Explore", systemImage: "square.grid.2x2.fill") }
            AwesomeGoogleMapsTabScreen(title: "Go", icon: "square.grid.2x2.fill", appName: "Google Maps")
                .tabItem { Label("Go", systemImage: "square.grid.2x2.fill") }
            AwesomeGoogleMapsTabScreen(title: "Saved", icon: "square.grid.2x2.fill", appName: "Google Maps")
                .tabItem { Label("Saved", systemImage: "square.grid.2x2.fill") }
            AwesomeGoogleMapsTabScreen(title: "Updates", icon: "square.grid.2x2.fill", appName: "Google Maps")
                .tabItem { Label("Updates", systemImage: "square.grid.2x2.fill") }
        }
        .tint(GoogleMapsTokens.gmCanvas)
    }
}

private enum GoogleMapsTokens {
        static let gmCanvas = Color.white                                   // #FFFFFF
        static let gmSurfaceMuted = Color(red: 0.945, green: 0.953, blue: 0.957) // #F1F3F4
        static let gmDivider = Color(red: 0.855, green: 0.863, blue: 0.878) // #DADCE0
        static let gmTextPrimary = Color(red: 0.125, green: 0.133, blue: 0.141) // #202124
        static let gmTextSecondary = Color(red: 0.373, green: 0.388, blue: 0.408) // #5F6368
        static let gmTextTertiary = Color(red: 0.502, green: 0.525, blue: 0.545) // #80868B
        static let gmBlue = Color(red: 0.259, green: 0.522, blue: 0.957) // #4285F4
        static let gmBluePressed = Color(red: 0.102, green: 0.451, blue: 0.910) // #1A73E8
        static let gmBlueDark = Color(red: 0.090, green: 0.306, blue: 0.651) // #174EA6
        static let gmRed = Color(red: 0.918, green: 0.263, blue: 0.208) // #EA4335
        static let gmYellow = Color(red: 0.984, green: 0.737, blue: 0.016) // #FBBC04
        static let gmGreen = Color(red: 0.204, green: 0.659, blue: 0.325) // #34A853
        static let gmOrange = Color(red: 0.984, green: 0.549, blue: 0.000) // #FB8C00
        static let gmRoadWhite = Color.white                                   // #FFFFFF
        static let gmHighwayYellow = Color(red: 0.992, green: 0.965, blue: 0.890) // #FDF6E3
        static let gmWaterBlue = Color(red: 0.667, green: 0.855, blue: 1.000) // #AADAFF
        static let gmParkGreen = Color(red: 0.784, green: 0.902, blue: 0.788) // #C8E6C9
        static let gmBuildingFill = Color(red: 0.941, green: 0.941, blue: 0.941) // #F0F0F0
        static let gmDarkCanvas = Color(red: 0.125, green: 0.133, blue: 0.141) // #202124
        static let gmDarkSurface1 = Color(red: 0.176, green: 0.180, blue: 0.192) // #2D2E31
        static let gmDarkSurface2 = Color(red: 0.235, green: 0.251, blue: 0.263) // #3C4043
        static let gmDarkTextPrim = Color(red: 0.910, green: 0.918, blue: 0.929) // #E8EAED
        static let gmBlueHalo = Color(red: 0.259, green: 0.522, blue: 0.957, opacity: 0.18)
        static let gmBlueHaloEdge = Color(red: 0.259, green: 0.522, blue: 0.957, opacity: 0.4)
}

private struct AwesomeGoogleMapsTabScreen: View {
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
            .background(GoogleMapsTokens.gmCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(GoogleMapsTokens.gmCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(GoogleMapsTokens.gmCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(GoogleMapsTokens.gmCanvas.opacity(0.12))
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

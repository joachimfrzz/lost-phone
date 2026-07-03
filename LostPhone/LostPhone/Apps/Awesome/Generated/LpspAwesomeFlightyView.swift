import SwiftUI

// Source: Meliwat/awesome-ios-design-md — flighty/DESIGN-swiftui.md
struct LpspAwesomeFlightyView: View {
    var body: some View {
        TabView {
            AwesomeFlightyTabScreen(title: "Flights", icon: "airplane", appName: "Flighty")
                .tabItem { Label("Flights", systemImage: "airplane") }
            AwesomeFlightyTabScreen(title: "Search", icon: "magnifyingglass", appName: "Flighty")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            AwesomeFlightyTabScreen(title: "Airport", icon: "building.2.fill", appName: "Flighty")
                .tabItem { Label("Airport", systemImage: "building.2.fill") }
            AwesomeFlightyTabScreen(title: "Profile", icon: "person.fill", appName: "Flighty")
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
        .tint(FlightyTokens.fltCanvas)
    }
}

private enum FlightyTokens {
        static let fltCanvas = Color(red: 0.043, green: 0.043, blue: 0.059)  // #0B0B0F
        static let fltSurface1 = Color(red: 0.102, green: 0.102, blue: 0.122)  // #1A1A1F
        static let fltSurface2 = Color(red: 0.133, green: 0.133, blue: 0.157)  // #222228
        static let fltSurface3 = Color(red: 0.173, green: 0.173, blue: 0.204)  // #2C2C34
        static let fltDivider = Color(red: 0.180, green: 0.180, blue: 0.212)  // #2E2E36
        static let fltTextPrimary = Color.white                              // #FFFFFF
        static let fltTextSecondary = Color(red: 0.557, green: 0.557, blue: 0.588) // #8E8E96
        static let fltTextTertiary = Color(red: 0.353, green: 0.353, blue: 0.384) // #5A5A62
        static let fltBlue = Color(red: 0.039, green: 0.518, blue: 1.000) // #0A84FF
        static let fltBluePressed = Color(red: 0.000, green: 0.400, blue: 0.800) // #0066CC
        static let fltOnTime = Color(red: 0.188, green: 0.820, blue: 0.345)  // #30D158
        static let fltDelay = Color(red: 1.000, green: 0.839, blue: 0.039)  // #FFD60A
        static let fltCancelled = Color(red: 1.000, green: 0.271, blue: 0.227)  // #FF453A
        static let fltMapLand = Color(red: 0.086, green: 0.086, blue: 0.106) // #16161B
        static let fltMapGraticule = Color(red: 0.122, green: 0.122, blue: 0.149) // #1F1F26
        static let fltBlueGlow = Color.fltBlue.opacity(0.45)
}

private struct AwesomeFlightyTabScreen: View {
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
            .background(FlightyTokens.fltCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(FlightyTokens.fltCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(FlightyTokens.fltCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(FlightyTokens.fltCanvas.opacity(0.12))
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

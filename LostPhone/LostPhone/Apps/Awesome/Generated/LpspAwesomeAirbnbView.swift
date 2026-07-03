import SwiftUI

// Source: Meliwat/awesome-ios-design-md — airbnb/DESIGN-swiftui.md
struct LpspAwesomeAirbnbView: View {
    var body: some View {
        TabView {
            AwesomeAirbnbTabScreen(title: "Wishlists", icon: "heart", appName: "Airbnb")
                .tabItem { Label("Wishlists", systemImage: "heart") }
            AwesomeAirbnbTabScreen(title: "Explore", icon: "square.grid.2x2.fill", appName: "Airbnb")
                .tabItem { Label("Explore", systemImage: "square.grid.2x2.fill") }
            AwesomeAirbnbTabScreen(title: "Trips", icon: "square.grid.2x2.fill", appName: "Airbnb")
                .tabItem { Label("Trips", systemImage: "square.grid.2x2.fill") }
            AwesomeAirbnbTabScreen(title: "Inbox", icon: "square.grid.2x2.fill", appName: "Airbnb")
                .tabItem { Label("Inbox", systemImage: "square.grid.2x2.fill") }
            AwesomeAirbnbTabScreen(title: "Profile", icon: "square.grid.2x2.fill", appName: "Airbnb")
                .tabItem { Label("Profile", systemImage: "square.grid.2x2.fill") }
        }
        .tint(AirbnbTokens.airbnbCanvas)
    }
}

private enum AirbnbTokens {
        static let airbnbCanvas = Color(red: 1.00, green: 1.00, blue: 1.00)   // #FFFFFF
        static let airbnbSurfaceGray = Color(red: 0.969, green: 0.969, blue: 0.969) // #F7F7F7
        static let airbnbSurfaceGray2 = Color(red: 0.922, green: 0.922, blue: 0.922) // #EBEBEB
        static let airbnbDivider = Color(red: 0.922, green: 0.922, blue: 0.922) // #EBEBEB
        static let airbnbHof = Color(red: 0.282, green: 0.282, blue: 0.282) // #484848 primary text
        static let airbnbFoggy = Color(red: 0.463, green: 0.463, blue: 0.463) // #767676 secondary text
        static let airbnbFoggyLight = Color(red: 0.690, green: 0.690, blue: 0.690) // #B0B0B0 tertiary
        static let airbnbInk = Color(red: 0.133, green: 0.133, blue: 0.133) // #222222 hero titles
        static let airbnbCoral = Color(red: 1.00, green: 0.220, blue: 0.361)  // #FF385C primary
        static let airbnbCoralPressed = Color(red: 0.890, green: 0.110, blue: 0.373) // #E31C5F
        static let airbnbRausch = Color(red: 1.00, green: 0.353, blue: 0.373)  // #FF5A5F heritage
        static let airbnbBabu = Color(red: 0.00, green: 0.651, blue: 0.600)  // #00A699 Plus / Experiences
        static let airbnbArches = Color(red: 0.988, green: 0.392, blue: 0.176) // #FC642D Trips
        static let airbnbBeach = Color(red: 1.00, green: 0.706, blue: 0.00)   // #FFB400 star yellow
        static let airbnbSuccess = Color(red: 0.00, green: 0.541, blue: 0.020)  // #008A05
        static let airbnbError = Color(red: 0.757, green: 0.208, blue: 0.082) // #C13515
        static let airbnbDarkCanvas = Color(red: 0.071, green: 0.071, blue: 0.071) // #121212
        static let airbnbDarkSurface = Color(red: 0.110, green: 0.110, blue: 0.118) // #1C1C1E
        static let airbnbDarkText = Color(red: 0.867, green: 0.867, blue: 0.867) // #DDDDDD
        static let airbnbDarkTextSec = Color(red: 0.627, green: 0.627, blue: 0.627) // #A0A0A0
}

private struct AwesomeAirbnbTabScreen: View {
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
            .background(AirbnbTokens.airbnbCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(AirbnbTokens.airbnbCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(AirbnbTokens.airbnbCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AirbnbTokens.airbnbCanvas.opacity(0.12))
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

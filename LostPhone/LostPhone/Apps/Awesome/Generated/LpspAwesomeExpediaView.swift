import SwiftUI

// Source: Meliwat/awesome-ios-design-md — expedia/DESIGN-swiftui.md
struct LpspAwesomeExpediaView: View {
    var body: some View {
        TabView {
            AwesomeExpediaTabScreen(title: "Search", icon: "magnifyingglass", appName: "Expedia")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            AwesomeExpediaTabScreen(title: "Saved", icon: "heart", appName: "Expedia")
                .tabItem { Label("Saved", systemImage: "heart") }
            AwesomeExpediaTabScreen(title: "Trips", icon: "suitcase", appName: "Expedia")
                .tabItem { Label("Trips", systemImage: "suitcase") }
            AwesomeExpediaTabScreen(title: "Support", icon: "questionmark.circle", appName: "Expedia")
                .tabItem { Label("Support", systemImage: "questionmark.circle") }
            AwesomeExpediaTabScreen(title: "Account", icon: "person.crop.circle", appName: "Expedia")
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
        }
        .tint(ExpediaTokens.expCanvas)
    }
}

private enum ExpediaTokens {
        static let expCanvas = Color.white                                    // #FFFFFF
        static let expSurfaceGray = Color(red: 0.961, green: 0.969, blue: 0.980)  // #F5F7FA
        static let expSurfacePressed = Color(red: 0.925, green: 0.937, blue: 0.957) // #ECEFF4
        static let expDivider = Color(red: 0.890, green: 0.906, blue: 0.929)  // #E3E7ED
        static let expDarkCanvas = Color(red: 0.055, green: 0.067, blue: 0.086)  // #0E1116
        static let expDarkSurface1 = Color(red: 0.086, green: 0.106, blue: 0.133)  // #161B22
        static let expDarkSurface2 = Color(red: 0.122, green: 0.149, blue: 0.188)  // #1F2630
        static let expDarkDivider = Color(red: 0.165, green: 0.196, blue: 0.243)  // #2A323E
        static let expTextPrimary = Color(red: 0.102, green: 0.122, blue: 0.149)  // #1A1F26
        static let expTextSecondary = Color(red: 0.353, green: 0.396, blue: 0.451)  // #5A6573
        static let expTextTertiary = Color(red: 0.541, green: 0.584, blue: 0.639)  // #8A95A3
        static let expDarkTextPrimary = Color(red: 0.910, green: 0.922, blue: 0.937) // #E8EBEF
        static let expDarkTextSecondary = Color(red: 0.604, green: 0.643, blue: 0.698) // #9AA4B2
        static let expYellow = Color(red: 1.000, green: 0.788, blue: 0.302)  // #FFC94D
        static let expYellowDeep = Color(red: 1.000, green: 0.702, blue: 0.102)  // #FFB31A
        static let expActionBlue = Color(red: 0.086, green: 0.408, blue: 0.890)  // #1668E3
        static let expActionPressed = Color(red: 0.059, green: 0.310, blue: 0.690)  // #0F4FB0
        static let expNavy = Color(red: 0.000, green: 0.208, blue: 0.373)  // #00355F
        static let expNavySoft = Color(red: 0.078, green: 0.255, blue: 0.420)  // #14416B
        static let expOneKeyGold = Color(red: 0.961, green: 0.773, blue: 0.094)  // #F5C518
        static let expSuccess = Color(red: 0.102, green: 0.545, blue: 0.294)  // #1A8B4B
        static let expError = Color(red: 0.851, green: 0.227, blue: 0.227)  // #D93A3A
        static let expWarning = Color(red: 0.910, green: 0.514, blue: 0.047)  // #E8830C
}

private struct AwesomeExpediaTabScreen: View {
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
            .background(ExpediaTokens.expCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(ExpediaTokens.expCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(ExpediaTokens.expCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(ExpediaTokens.expCanvas.opacity(0.12))
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

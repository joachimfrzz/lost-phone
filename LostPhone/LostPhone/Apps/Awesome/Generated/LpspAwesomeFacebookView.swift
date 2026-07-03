import SwiftUI

// Source: Meliwat/awesome-ios-design-md — facebook/DESIGN-swiftui.md
struct LpspAwesomeFacebookView: View {
    var body: some View {
        TabView {
            AwesomeFacebookTabScreen(title: "Notifications", icon: "bell.fill", appName: "Facebook")
                .tabItem { Label("Notifications", systemImage: "bell.fill") }
            AwesomeFacebookTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Facebook")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomeFacebookTabScreen(title: "Video", icon: "square.grid.2x2.fill", appName: "Facebook")
                .tabItem { Label("Video", systemImage: "square.grid.2x2.fill") }
            AwesomeFacebookTabScreen(title: "Marketplace", icon: "square.grid.2x2.fill", appName: "Facebook")
                .tabItem { Label("Marketplace", systemImage: "square.grid.2x2.fill") }
            AwesomeFacebookTabScreen(title: "Menu", icon: "square.grid.2x2.fill", appName: "Facebook")
                .tabItem { Label("Menu", systemImage: "square.grid.2x2.fill") }
        }
        .tint(FacebookTokens.fbCanvas)
    }
}

private enum FacebookTokens {
        static let fbCanvas = Color(red: 0.941, green: 0.949, blue: 0.961) // #F0F2F5
        static let fbCard = Color.white                                   // #FFFFFF
        static let fbSurfaceTint = Color(red: 0.969, green: 0.973, blue: 0.980) // #F7F8FA
        static let fbDivider = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
        static let fbSeparator = Color(red: 0.808, green: 0.816, blue: 0.831) // #CED0D4
        static let fbDarkCanvas = Color(red: 0.094, green: 0.098, blue: 0.102) // #18191A
        static let fbDarkCard = Color(red: 0.141, green: 0.145, blue: 0.149) // #242526
        static let fbDarkSurfaceTint = Color(red: 0.227, green: 0.231, blue: 0.235) // #3A3B3C
        static let fbDarkDivider = Color(red: 0.243, green: 0.251, blue: 0.259) // #3E4042
        static let fbTextPrimaryLight = Color(red: 0.020, green: 0.020, blue: 0.020) // #050505
        static let fbTextPrimaryDark = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
        static let fbTextSecondaryLight = Color(red: 0.396, green: 0.404, blue: 0.420) // #65676B
        static let fbTextSecondaryDark = Color(red: 0.690, green: 0.702, blue: 0.722) // #B0B3B8
        static let fbTextTertiary = Color(red: 0.541, green: 0.553, blue: 0.569) // #8A8D91
        static let fbBlue = Color(red: 0.094, green: 0.467, blue: 0.949) // #1877F2
        static let fbBluePressed = Color(red: 0.039, green: 0.373, blue: 0.784) // #0A5FC8
        static let fbBlueLight = Color(red: 0.906, green: 0.953, blue: 1.000) // #E7F3FF
        static let fbLikeBlue = Color(red: 0.094, green: 0.467, blue: 0.949) // #1877F2 (same as Blue)
        static let fbLovePink = Color(red: 0.953, green: 0.259, blue: 0.373) // #F3425F
        static let fbCareYellow = Color(red: 0.969, green: 0.725, blue: 0.157) // #F7B928
        static let fbHahaYellow = Color(red: 0.969, green: 0.725, blue: 0.157) // #F7B928
        static let fbWowYellow = Color(red: 0.969, green: 0.725, blue: 0.157) // #F7B928
        static let fbSadYellow = Color(red: 0.969, green: 0.725, blue: 0.157) // #F7B928
        static let fbAngryOrange = Color(red: 0.914, green: 0.443, blue: 0.059) // #E9710F
}

private struct AwesomeFacebookTabScreen: View {
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
            .background(FacebookTokens.fbCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(FacebookTokens.fbCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(FacebookTokens.fbCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(FacebookTokens.fbCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — twitch/DESIGN-swiftui.md
struct LpspAwesomeTwitchView: View {
    var body: some View {
        TabView {
            AwesomeTwitchTabScreen(title: "Notifications", icon: "bell.fill", appName: "Twitch")
                .tabItem { Label("Notifications", systemImage: "bell.fill") }
            AwesomeTwitchTabScreen(title: "Following", icon: "square.grid.2x2.fill", appName: "Twitch")
                .tabItem { Label("Following", systemImage: "square.grid.2x2.fill") }
            AwesomeTwitchTabScreen(title: "Browse", icon: "square.grid.2x2.fill", appName: "Twitch")
                .tabItem { Label("Browse", systemImage: "square.grid.2x2.fill") }
            AwesomeTwitchTabScreen(title: "Search", icon: "square.grid.2x2.fill", appName: "Twitch")
                .tabItem { Label("Search", systemImage: "square.grid.2x2.fill") }
            AwesomeTwitchTabScreen(title: "Profile", icon: "square.grid.2x2.fill", appName: "Twitch")
                .tabItem { Label("Profile", systemImage: "square.grid.2x2.fill") }
        }
        .tint(TwitchTokens.twitchCanvas)
    }
}

private enum TwitchTokens {
        static let twitchCanvas = Color(red: 0.055, green: 0.055, blue: 0.063) // #0E0E10
        static let twitchDeepBlack = Color.black                                  // #000000
        static let twitchSurface1 = Color(red: 0.094, green: 0.094, blue: 0.106) // #18181B
        static let twitchSurface2 = Color(red: 0.122, green: 0.122, blue: 0.137) // #1F1F23
        static let twitchSurface3 = Color(red: 0.165, green: 0.165, blue: 0.176) // #2A2A2D
        static let twitchDivider = Color(red: 0.165, green: 0.165, blue: 0.176) // #2A2A2D
        static let twitchTextPrimary = Color(red: 0.937, green: 0.937, blue: 0.945) // #EFEFF1
        static let twitchTextSecondary = Color(red: 0.678, green: 0.678, blue: 0.722) // #ADADB8
        static let twitchTextTertiary = Color(red: 0.435, green: 0.435, blue: 0.482) // #6F6F7B
        static let twitchPurple = Color(red: 0.569, green: 0.275, blue: 1.000) // #9146FF
        static let twitchPurplePressed = Color(red: 0.467, green: 0.173, blue: 0.910) // #772CE8
        static let twitchLiveRed = Color(red: 0.922, green: 0.016, blue: 0.000) // #EB0400
        static let twitchLiveRedPressed = Color(red: 0.761, green: 0.012, blue: 0.000) // #C20300
        static let twitchOnlineGreen = Color(red: 0.000, green: 0.757, blue: 0.431) // #00C16E
}

private struct AwesomeTwitchTabScreen: View {
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
            .background(TwitchTokens.twitchCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(TwitchTokens.twitchCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(TwitchTokens.twitchCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(TwitchTokens.twitchCanvas.opacity(0.12))
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

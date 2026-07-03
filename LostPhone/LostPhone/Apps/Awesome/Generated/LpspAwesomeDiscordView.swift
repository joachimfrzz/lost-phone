import SwiftUI

// Source: Meliwat/awesome-ios-design-md — discord/DESIGN-swiftui.md
struct LpspAwesomeDiscordView: View {
    var body: some View {
        TabView {
            AwesomeDiscordTabScreen(title: "Servers", icon: "square.grid.2x2.fill", appName: "Discord")
                .tabItem { Label("Servers", systemImage: "square.grid.2x2.fill") }
            AwesomeDiscordTabScreen(title: "Messages", icon: "bubble.left.and.bubble.right.fill", appName: "Discord")
                .tabItem { Label("Messages", systemImage: "bubble.left.and.bubble.right.fill") }
            AwesomeDiscordTabScreen(title: "Notifications", icon: "bell.fill", appName: "Discord")
                .tabItem { Label("Notifications", systemImage: "bell.fill") }
            AwesomeDiscordTabScreen(title: "You", icon: "person.crop.circle.fill", appName: "Discord")
                .tabItem { Label("You", systemImage: "person.crop.circle.fill") }
        }
        .tint(DiscordTokens.dcBlurple)
    }
}

private enum DiscordTokens {
        static let dcBlurple = Color(red: 0.345, green: 0.396, blue: 0.949) // #5865F2
        static let dcBlurplePressed = Color(red: 0.278, green: 0.322, blue: 0.769) // #4752C4
        static let dcBlurpleLegacy = Color(red: 0.447, green: 0.537, blue: 0.855) // #7289DA
        static let dcServerRail = Color(red: 0.118, green: 0.122, blue: 0.133) // #1E1F22
        static let dcChannelList = Color(red: 0.169, green: 0.176, blue: 0.192) // #2B2D31
        static let dcChatCanvas = Color(red: 0.192, green: 0.200, blue: 0.220) // #313338
        static let dcSurface2 = Color(red: 0.220, green: 0.227, blue: 0.251) // #383A40
        static let dcDivider = Color(red: 0.247, green: 0.255, blue: 0.278) // #3F4147
        static let dcRowHover = Color(red: 0.180, green: 0.188, blue: 0.208) // #2E3035
        static let dcActiveChannelBg = Color(red: 0.251, green: 0.259, blue: 0.286) // #404249
        static let dcTextPrimary = Color(red: 0.949, green: 0.953, blue: 0.961) // #F2F3F5
        static let dcTextSecondary = Color(red: 0.710, green: 0.729, blue: 0.757) // #B5BAC1
        static let dcTextMuted = Color(red: 0.580, green: 0.608, blue: 0.643) // #949BA4
        static let dcTextLink = Color(red: 0.000, green: 0.659, blue: 0.988) // #00A8FC
        static let dcTextDisabled = Color(red: 0.365, green: 0.376, blue: 0.412) // #5D6069
        static let dcOnlineGreen = Color(red: 0.137, green: 0.647, blue: 0.353) // #23A55A
        static let dcIdleYellow = Color(red: 0.941, green: 0.698, blue: 0.196) // #F0B232
        static let dcDNDRed = Color(red: 0.949, green: 0.247, blue: 0.263) // #F23F43
        static let dcOfflineGray = Color(red: 0.502, green: 0.518, blue: 0.557) // #80848E
        static let dcStreamingPurple = Color(red: 0.349, green: 0.212, blue: 0.584) // #593695
        static let dcDestructiveRed = Color(red: 0.855, green: 0.216, blue: 0.235) // #DA373C
        static let dcBoostPink = Color(red: 0.922, green: 0.271, blue: 0.620) // #EB459E
        static let dcNitroGradient = LinearGradient(
}

private struct AwesomeDiscordTabScreen: View {
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
            .background(DiscordTokens.dcChatCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(DiscordTokens.dcChatCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(DiscordTokens.dcBlurple)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(DiscordTokens.dcBlurple.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — telegram/DESIGN-swiftui.md
struct LpspAwesomeTelegramView: View {
    var body: some View {
        TabView {
            AwesomeTelegramTabScreen(title: "Contacts", icon: "person.2.fill", appName: "Telegram")
                .tabItem { Label("Contacts", systemImage: "person.2.fill") }
            AwesomeTelegramTabScreen(title: "Calls", icon: "phone.fill", appName: "Telegram")
                .tabItem { Label("Calls", systemImage: "phone.fill") }
            AwesomeTelegramTabScreen(title: "Chats", icon: "bubble.left.and.bubble.right.fill", appName: "Telegram")
                .tabItem { Label("Chats", systemImage: "bubble.left.and.bubble.right.fill") }
            AwesomeTelegramTabScreen(title: "Settings", icon: "gearshape.fill", appName: "Telegram")
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(TelegramTokens.tgAccent)
    }
}

private enum TelegramTokens {
        static let tgAccent = Color(red: 0.000, green: 0.533, blue: 0.800) // #0088CC
        static let tgAccentLight = Color(red: 0.251, green: 0.655, blue: 0.890) // #40A7E3
        static let tgAccentPressed = Color(red: 0.000, green: 0.443, blue: 0.690) // #0071B0
        static let tgBubbleOutgoing = Color(red: 0.169, green: 0.525, blue: 0.992) // #2B86FD
        static let tgBubbleOutgoingTop = Color(red: 0.169, green: 0.525, blue: 0.992) // #2B86FD (gradient top)
        static let tgBubbleOutgoingBot = Color(red: 0.380, green: 0.702, blue: 1.000) // #61B3FF (gradient bottom)
        static let tgBubbleIncomingLight = Color.white
        static let tgBubbleIncomingDark = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let tgCanvasLight = Color.white                                    // #FFFFFF
        static let tgCanvasDark = Color(red: 0.129, green: 0.129, blue: 0.129)   // #212121
        static let tgCanvasOLED = Color.black                                     // #000000
        static let tgChatBGBlue = Color(red: 0.859, green: 0.906, blue: 0.957)   // #DBE7F4 (default blue wallpaper)
        static let tgSurface1Light = Color(red: 0.969, green: 0.969, blue: 0.969)   // #F7F7F7
        static let tgSurface1Dark = Color(red: 0.110, green: 0.110, blue: 0.110)   // #1C1C1C
        static let tgSurface2Dark = Color(red: 0.173, green: 0.173, blue: 0.180)   // #2C2C2E
        static let tgDividerLight = Color(red: 0.780, green: 0.780, blue: 0.800)   // #C7C7CC
        static let tgDividerDark = Color(red: 0.220, green: 0.220, blue: 0.220)   // #383838
        static let tgTextPrimary = Color.black
        static let tgTextSecondary = Color(red: 0.439, green: 0.459, blue: 0.475) // #707579
        static let tgTextTertiary = Color(red: 0.627, green: 0.651, blue: 0.678) // #A0A6AD
        static let tgTextPrimaryDark = Color.white
        static let tgTextSecondaryDark = Color(red: 0.553, green: 0.557, blue: 0.576) // #8D8E93
        static let tgOnlineGreen = Color(red: 0.302, green: 0.827, blue: 0.392) // #4DD364
        static let tgErrorRed = Color(red: 0.898, green: 0.224, blue: 0.208) // #E53935
}

private struct AwesomeTelegramTabScreen: View {
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
            .background(TelegramTokens.tgCanvasLight.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(TelegramTokens.tgCanvasLight, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(TelegramTokens.tgAccent)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(TelegramTokens.tgAccent.opacity(0.12))
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

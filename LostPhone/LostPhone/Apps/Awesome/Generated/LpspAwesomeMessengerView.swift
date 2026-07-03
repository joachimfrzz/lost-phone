import SwiftUI

// Source: Meliwat/awesome-ios-design-md — messenger/DESIGN-swiftui.md
struct LpspAwesomeMessengerView: View {
    var body: some View {
        TabView {
            AwesomeMessengerTabScreen(title: "Chats", icon: "message.fill", appName: "Messenger")
                .tabItem { Label("Chats", systemImage: "message.fill") }
            AwesomeMessengerTabScreen(title: "Marketplace", icon: "storefront.fill", appName: "Messenger")
                .tabItem { Label("Marketplace", systemImage: "storefront.fill") }
            AwesomeMessengerTabScreen(title: "Stories", icon: "play.circle.fill", appName: "Messenger")
                .tabItem { Label("Stories", systemImage: "play.circle.fill") }
        }
        .tint(MessengerTokens.msgGradBlue)
    }
}

private enum MessengerTokens {
        static let msgGradBlue = Color(red: 0.039, green: 0.486, blue: 1.000) // #0A7CFF
        static let msgGradViolet = Color(red: 0.616, green: 0.306, blue: 0.867) // #9D4EDD
        static let msgGradPink = Color(red: 1.000, green: 0.361, blue: 0.627) // #FF5CA0
        static let msgBlue = Color(red: 0.039, green: 0.486, blue: 1.000) // #0A7CFF
        static let msgBluePressed = Color(red: 0.031, green: 0.400, blue: 0.839) // #0866D6
        static let msgCanvas = Color(red: 1, green: 1, blue: 1)             // #FFFFFF
        static let msgCanvasDark = Color.black                                  // #000000 (true black)
        static let msgSurface = Color(red: 0.945, green: 0.945, blue: 0.949) // #F1F1F2
        static let msgSurfaceDark = Color(red: 0.110, green: 0.110, blue: 0.114) // #1C1C1D
        static let msgIncoming = Color(red: 0.945, green: 0.945, blue: 0.949) // #F1F1F2
        static let msgIncomingDark = Color(red: 0.188, green: 0.188, blue: 0.188) // #303030
        static let msgDivider = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
        static let msgDividerDark = Color(red: 0.227, green: 0.231, blue: 0.235) // #3A3B3C
        static let msgTextPrimary = Color(red: 0.020, green: 0.020, blue: 0.020) // #050505
        static let msgTextPrimaryD = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
        static let msgTextSecondary = Color(red: 0.396, green: 0.404, blue: 0.420) // #65676B
        static let msgTextTertiary = Color(red: 0.541, green: 0.553, blue: 0.569) // #8A8D91
        static let msgActiveGreen = Color(red: 0.192, green: 0.820, blue: 0.345)  // #31D158
        static let msgError = Color(red: 0.980, green: 0.220, blue: 0.243)  // #FA383E
        static let msgSuccess = Color(red: 0.192, green: 0.635, blue: 0.298)  // #31A24C
        static let msgBubble = LinearGradient(
}

private struct AwesomeMessengerTabScreen: View {
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
            .background(MessengerTokens.msgCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(MessengerTokens.msgCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(MessengerTokens.msgGradBlue)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(MessengerTokens.msgGradBlue.opacity(0.12))
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

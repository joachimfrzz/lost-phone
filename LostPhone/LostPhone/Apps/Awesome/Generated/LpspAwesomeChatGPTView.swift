import SwiftUI

// Source: Meliwat/awesome-ios-design-md — chatgpt/DESIGN-swiftui.md
struct LpspAwesomeChatGPTView: View {
    var body: some View {
        TabView {
            AwesomeChatGPTTabScreen(title: "Accueil", icon: "house.fill", appName: "ChatGPT")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeChatGPTTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "ChatGPT")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeChatGPTTabScreen(title: "Profil", icon: "person.fill", appName: "ChatGPT")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(ChatGPTTokens.gptCanvas)
    }
}

private enum ChatGPTTokens {
        static let gptCanvas = Color.white                                    // #FFFFFF
        static let gptDarkCanvas = Color(red: 0.129, green: 0.129, blue: 0.129)  // #212121
        static let gptSidebarLight = Color(red: 0.976, green: 0.976, blue: 0.976) // #F9F9F9
        static let gptSidebarDark = Color(red: 0.094, green: 0.094, blue: 0.094) // #181818
        static let gptSidebarActive = Color(red: 0.925, green: 0.925, blue: 0.925) // #ECECEC
        static let gptSidebarActiveDark = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F
        static let gptDivider = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
        static let gptDividerDark = Color(red: 0.259, green: 0.259, blue: 0.259) // #424242
        static let gptTextPrimary = Color(red: 0.051, green: 0.051, blue: 0.051) // #0D0D0D
        static let gptTextSecondary = Color(red: 0.404, green: 0.404, blue: 0.404) // #676767
        static let gptTextTertiary = Color(red: 0.557, green: 0.557, blue: 0.557) // #8E8E8E
        static let gptDarkTextPrimary = Color(red: 0.925, green: 0.925, blue: 0.925) // #ECECEC
        static let gptDarkTextSecondary = Color(red: 0.706, green: 0.706, blue: 0.706) // #B4B4B4
        static let gptUserBubbleLight = Color(red: 0.969, green: 0.969, blue: 0.973) // #F7F7F8
        static let gptUserBubbleDark = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F
        static let gptCodeBlockLight = Color(red: 0.969, green: 0.969, blue: 0.973) // #F7F7F8
        static let gptCodeBlockDark = Color(red: 0.118, green: 0.118, blue: 0.118) // #1E1E1E
        static let gptCodeInlineLight = Color(red: 0.941, green: 0.941, blue: 0.941) // #F0F0F0
        static let gptCodeInlineDark = Color(red: 0.259, green: 0.259, blue: 0.259) // #424242
        static let gptSendLight = Color(red: 0.051, green: 0.051, blue: 0.051) // #0D0D0D
        static let gptSendDark = Color.white                                    // #FFFFFF
        static let gptSendDisabled = Color(red: 0.800, green: 0.800, blue: 0.800) // #CCCCCC
        static let gptLinkBlue = Color(red: 0.165, green: 0.498, blue: 1.000) // #2A7FFF
        static let gptLegacyGreen = Color(red: 0.063, green: 0.639, blue: 0.498) // #10A37F (legacy, mostly retired)
}

private struct AwesomeChatGPTTabScreen: View {
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
            .background(ChatGPTTokens.gptCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(ChatGPTTokens.gptCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(ChatGPTTokens.gptCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(ChatGPTTokens.gptCanvas.opacity(0.12))
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

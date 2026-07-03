import SwiftUI

// Source: Meliwat/awesome-ios-design-md — happn/DESIGN-swiftui.md
struct LpspAwesomeHappnView: View {
    var body: some View {
        TabView {
            AwesomeHappnTabScreen(title: "Timeline", icon: "heart.text.square", appName: "Happn")
                .tabItem { Label("Timeline", systemImage: "heart.text.square") }
            AwesomeHappnTabScreen(title: "Map", icon: "map", appName: "Happn")
                .tabItem { Label("Map", systemImage: "map") }
            AwesomeHappnTabScreen(title: "Chats", icon: "bubble.left.and.bubble.right", appName: "Happn")
                .tabItem { Label("Chats", systemImage: "bubble.left.and.bubble.right") }
            AwesomeHappnTabScreen(title: "Profile", icon: "person", appName: "Happn")
                .tabItem { Label("Profile", systemImage: "person") }
        }
        .tint(HappnTokens.happnCanvas)
    }
}

private enum HappnTokens {
        static let happnCanvas = Color(red: 0.055, green: 0.055, blue: 0.071) // #0E0E12
        static let happnSurface1 = Color(red: 0.094, green: 0.094, blue: 0.122) // #18181F
        static let happnSurface2 = Color(red: 0.129, green: 0.129, blue: 0.169) // #21212B
        static let happnSurface3 = Color(red: 0.173, green: 0.173, blue: 0.220) // #2C2C38
        static let happnDivider = Color(red: 0.165, green: 0.165, blue: 0.200) // #2A2A33  (also timeline spine)
        static let happnCanvasLight = Color.white                                   // #FFFFFF
        static let happnSurface1Light = Color(red: 0.965, green: 0.965, blue: 0.973) // #F6F6F8
        static let happnPink = Color(red: 1.000, green: 0.282, blue: 0.396) // #FF4865
        static let happnPinkPress = Color(red: 0.898, green: 0.208, blue: 0.310) // #E5354F
        static let happnMagenta = Color(red: 0.914, green: 0.118, blue: 0.388) // #E91E63
        static let happnRose = Color(red: 1.000, green: 0.482, blue: 0.576) // #FF7B93
        static let happnGold = Color(red: 1.000, green: 0.761, blue: 0.294) // #FFC24B  (Crush/premium only)
        static let happnTextPrimary = Color(red: 0.957, green: 0.957, blue: 0.965) // #F4F4F6
        static let happnTextSecondary = Color(red: 0.627, green: 0.627, blue: 0.682) // #A0A0AE
        static let happnTextTertiary = Color(red: 0.424, green: 0.424, blue: 0.478) // #6C6C7A
        static let happnOnPink = Color.white                                  // #FFFFFF
        static let happnOnGold = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let happnSuccess = Color(red: 0.306, green: 0.851, blue: 0.643) // #4ED9A4
        static let happnError = Color(red: 1.000, green: 0.361, blue: 0.361) // #FF5C5C
        static let happnHero = LinearGradient(
}

private struct AwesomeHappnTabScreen: View {
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
            .background(HappnTokens.happnCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(HappnTokens.happnCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(HappnTokens.happnCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(HappnTokens.happnCanvas.opacity(0.12))
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

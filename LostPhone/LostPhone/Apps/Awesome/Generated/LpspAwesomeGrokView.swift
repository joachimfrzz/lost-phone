import SwiftUI

// Source: Meliwat/awesome-ios-design-md — grok/DESIGN-swiftui.md
struct LpspAwesomeGrokView: View {
    var body: some View {
        TabView {
            AwesomeGrokTabScreen(title: "Accueil", icon: "house.fill", appName: "Grok")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeGrokTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Grok")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeGrokTabScreen(title: "Profil", icon: "person.fill", appName: "Grok")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(GrokTokens.grokCanvas)
    }
}

private enum GrokTokens {
        static let grokCanvas = Color.black                                  // #000000
        static let grokSurface1 = Color(red: 0.086, green: 0.094, blue: 0.110) // #16181C
        static let grokSurface2 = Color(red: 0.118, green: 0.129, blue: 0.149) // #1E2126
        static let grokSurface3 = Color(red: 0.153, green: 0.165, blue: 0.180) // #272A2E
        static let grokDivider = Color(red: 0.184, green: 0.200, blue: 0.212) // #2F3336
        static let grokTextPrimary = Color(red: 0.906, green: 0.914, blue: 0.918) // #E7E9EA
        static let grokTextSecondary = Color(red: 0.443, green: 0.463, blue: 0.482) // #71767B
        static let grokTextTertiary = Color(red: 0.302, green: 0.318, blue: 0.337) // #4D5156
        static let grokAccentWhite = Color.white                                  // #FFFFFF
        static let grokPressedWhite = Color(red: 0.843, green: 0.859, blue: 0.863) // #D7DBDC
        static let grokLinkBlue = Color(red: 0.114, green: 0.608, blue: 0.941) // #1D9BF0
        static let grokLinkPressed = Color(red: 0.102, green: 0.549, blue: 0.847) // #1A8CD8
        static let grokSuccess = Color(red: 0.000, green: 0.729, blue: 0.486) // #00BA7C
        static let grokError = Color(red: 0.957, green: 0.129, blue: 0.180) // #F4212E
}

private struct AwesomeGrokTabScreen: View {
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
            .background(GrokTokens.grokCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(GrokTokens.grokCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(GrokTokens.grokCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(GrokTokens.grokCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — tiktok/DESIGN-swiftui.md
struct LpspAwesomeTikTokView: View {
    var body: some View {
        TabView {
            AwesomeTikTokTabScreen(title: "Accueil", icon: "house.fill", appName: "TikTok")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeTikTokTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "TikTok")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeTikTokTabScreen(title: "Profil", icon: "person.fill", appName: "TikTok")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(TikTokTokens.tiktokCanvas)
    }
}

private enum TikTokTokens {
        static let tiktokCanvas = Color(red: 0.004, green: 0.004, blue: 0.004) // #010101
        static let tiktokSurface = Color(red: 0.086, green: 0.094, blue: 0.137) // #161823 — DMs, sheets
        static let tiktokInputField = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F — comment compose
        static let tiktokRose = Color(red: 0.996, green: 0.173, blue: 0.333) // #FE2C55
        static let tiktokCyan = Color(red: 0.145, green: 0.957, blue: 0.933) // #25F4EE
        static let tiktokTextPrimary = Color.white                                  // #FFFFFF
        static let tiktokTextSecondary = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5 — hashtag counts
        static let tiktokTextTertiary = Color.white.opacity(0.6)                     // placeholder, meta
        static let tiktokTextDisabled = Color.white.opacity(0.3)
        static let tiktokFollowerGray = Color.white.opacity(0.15)                    // "Following" pill bg
        static let tiktokScrimLight = Color.black.opacity(0.25)                    // icon shadow
        static let tiktokScrimMedium = Color.black.opacity(0.4)                     // text shadow
        static let tiktokScrimHeavy = Color.black.opacity(0.6)                     // sheet dim
        static let tiktokScrubberTrack = Color.white.opacity(0.3)
}

private struct AwesomeTikTokTabScreen: View {
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
            .background(TikTokTokens.tiktokCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(TikTokTokens.tiktokCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(TikTokTokens.tiktokCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(TikTokTokens.tiktokCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — gemini/DESIGN-swiftui.md
struct LpspAwesomeGeminiView: View {
    var body: some View {
        TabView {
            AwesomeGeminiTabScreen(title: "Accueil", icon: "house.fill", appName: "Gemini")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeGeminiTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Gemini")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeGeminiTabScreen(title: "Profil", icon: "person.fill", appName: "Gemini")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(GeminiTokens.gemCanvas)
    }
}

private enum GeminiTokens {
        static let gemCanvas = Color.white                                     // #FFFFFF
        static let gemSurface = Color(red: 0.941, green: 0.957, blue: 0.976)    // #F0F4F9
        static let gemDivider = Color(red: 0.890, green: 0.890, blue: 0.890)    // #E3E3E3
        static let gemDarkCanvas = Color(red: 0.118, green: 0.118, blue: 0.118) // #1E1E1E
        static let gemDarkSurface = Color(red: 0.157, green: 0.165, blue: 0.173) // #282A2C
        static let gemDarkDivider = Color(red: 0.235, green: 0.235, blue: 0.235) // #3C3C3C
        static let gemTextPrimary = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
        static let gemTextSecondary = Color(red: 0.373, green: 0.388, blue: 0.408) // #5F6368
        static let gemTextTertiary = Color(red: 0.604, green: 0.627, blue: 0.651) // #9AA0A6
        static let gemDarkTextPrimary = Color(red: 0.890, green: 0.890, blue: 0.890) // #E3E3E3
        static let gemBlue = Color(red: 0.259, green: 0.522, blue: 0.957) // #4285F4
        static let gemBluePressed = Color(red: 0.200, green: 0.404, blue: 0.839) // #3367D6
        static let gemDarkBlue = Color(red: 0.541, green: 0.706, blue: 0.973) // #8AB4F8
        static let gemViolet = Color(red: 0.608, green: 0.447, blue: 0.796) // #9B72CB
        static let gemCoral = Color(red: 0.851, green: 0.396, blue: 0.439) // #D96570
        static let gemSuccess = Color(red: 0.118, green: 0.557, blue: 0.243)     // #1E8E3E
        static let gemWarning = Color(red: 0.976, green: 0.671, blue: 0.0)       // #F9AB00
        static let gemError = Color(red: 0.851, green: 0.188, blue: 0.145)     // #D93025
        static let gemini = LinearGradient(
}

private struct AwesomeGeminiTabScreen: View {
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
            .background(GeminiTokens.gemCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(GeminiTokens.gemCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(GeminiTokens.gemCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(GeminiTokens.gemCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — youtube-music/DESIGN-swiftui.md
struct LpspAwesomeYouTubeMusicView: View {
    var body: some View {
        TabView {
            AwesomeYouTubeMusicTabScreen(title: "Home", icon: "house.fill", appName: "YouTube Music")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeYouTubeMusicTabScreen(title: "Samples", icon: "rectangle.stack.fill", appName: "YouTube Music")
                .tabItem { Label("Samples", systemImage: "rectangle.stack.fill") }
            AwesomeYouTubeMusicTabScreen(title: "Explore", icon: "magnifyingglass", appName: "YouTube Music")
                .tabItem { Label("Explore", systemImage: "magnifyingglass") }
            AwesomeYouTubeMusicTabScreen(title: "Library", icon: "books.vertical.fill", appName: "YouTube Music")
                .tabItem { Label("Library", systemImage: "books.vertical.fill") }
        }
        .tint(YouTubeMusicTokens.ytmCanvas)
    }
}

private enum YouTubeMusicTokens {
        static let ytmCanvas = Color(red: 0.012, green: 0.012, blue: 0.012) // #030303
        static let ytmSurface1 = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
        static let ytmSurface2 = Color(red: 0.153, green: 0.153, blue: 0.153) // #272727
        static let ytmMiniSurface = Color(red: 0.157, green: 0.157, blue: 0.157) // #282828
        static let ytmChipBg = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let ytmDivider = Color(red: 0.188, green: 0.188, blue: 0.188) // #303030
        static let ytmRed = Color(red: 1.0,   green: 0.0,   blue: 0.0)   // #FF0000
        static let ytmRedPressed = Color(red: 0.8,   green: 0.0,   blue: 0.0)   // #CC0000
        static let ytmActionWhite = Color.white                                    // #FFFFFF
        static let ytmTextPrimary = Color.white                                  // #FFFFFF
        static let ytmTextSecondary = Color(red: 0.667, green: 0.667, blue: 0.667) // #AAAAAA
        static let ytmTextTertiary = Color(red: 0.443, green: 0.443, blue: 0.443) // #717171
        static let ytmSuccess = Color(red: 0.169, green: 0.651, blue: 0.251) // #2BA640
        static let ytmError = Color(red: 1.0,   green: 0.306, blue: 0.271) // #FF4E45
        static let ytmTabBar = Color(red: 0.039, green: 0.039, blue: 0.039) // #0A0A0A
}

private struct AwesomeYouTubeMusicTabScreen: View {
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
            .background(YouTubeMusicTokens.ytmCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(YouTubeMusicTokens.ytmCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(YouTubeMusicTokens.ytmCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(YouTubeMusicTokens.ytmCanvas.opacity(0.12))
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

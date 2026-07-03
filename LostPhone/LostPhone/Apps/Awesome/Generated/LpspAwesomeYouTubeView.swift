import SwiftUI

// Source: Meliwat/awesome-ios-design-md — youtube/DESIGN-swiftui.md
struct LpspAwesomeYouTubeView: View {
    var body: some View {
        TabView {
            AwesomeYouTubeTabScreen(title: "Home", icon: "house.fill", appName: "YouTube")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeYouTubeTabScreen(title: "Shorts", icon: "play.rectangle.fill", appName: "YouTube")
                .tabItem { Label("Shorts", systemImage: "play.rectangle.fill") }
            AwesomeYouTubeTabScreen(title: "Subscriptions", icon: "play.square.stack.fill", appName: "YouTube")
                .tabItem { Label("Subscriptions", systemImage: "play.square.stack.fill") }
            AwesomeYouTubeTabScreen(title: "You", icon: "person.crop.circle.fill", appName: "YouTube")
                .tabItem { Label("You", systemImage: "person.crop.circle.fill") }
        }
        .tint(YouTubeTokens.ytRed)
    }
}

private enum YouTubeTokens {
        static let ytRed = Color(red: 1.0,   green: 0.0,   blue: 0.0)   // #FF0000
        static let ytRedPressed = Color(red: 0.8,   green: 0.0,   blue: 0.0)   // #CC0000
        static let ytRedHover = Color(red: 0.902, green: 0.0,   blue: 0.0)   // #E60000
        static let ytCanvasLight = Color.white                                  // #FFFFFF
        static let ytSurface1Light = Color(red: 0.976, green: 0.976, blue: 0.976) // #F9F9F9
        static let ytSurface2Light = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
        static let ytDividerLight = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
        static let ytCanvasDark = Color(red: 0.059, green: 0.059, blue: 0.059) // #0F0F0F
        static let ytSurface1Dark = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
        static let ytSurface2Dark = Color(red: 0.153, green: 0.153, blue: 0.153) // #272727
        static let ytSurface3Dark = Color(red: 0.247, green: 0.247, blue: 0.247) // #3F3F3F
        static let ytDividerDark = Color(red: 0.188, green: 0.188, blue: 0.188) // #303030
        static let ytTextPrimaryLight = Color(red: 0.059, green: 0.059, blue: 0.059) // #0F0F0F
        static let ytTextSecondaryLight = Color(red: 0.376, green: 0.376, blue: 0.376) // #606060
        static let ytTextTertiaryLight = Color(red: 0.565, green: 0.565, blue: 0.565) // #909090
        static let ytTextPrimaryDark = Color.white
        static let ytTextSecondaryDark = Color(red: 0.667, green: 0.667, blue: 0.667) // #AAAAAA
        static let ytTextTertiaryDark = Color(red: 0.443, green: 0.443, blue: 0.443) // #717171
        static let ytInfoBlue = Color(red: 0.243, green: 0.651, blue: 1.0) // #3EA6FF
}

private struct AwesomeYouTubeTabScreen: View {
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
            .background(YouTubeTokens.ytCanvasLight.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(YouTubeTokens.ytCanvasLight, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(YouTubeTokens.ytRed)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(YouTubeTokens.ytRed.opacity(0.12))
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

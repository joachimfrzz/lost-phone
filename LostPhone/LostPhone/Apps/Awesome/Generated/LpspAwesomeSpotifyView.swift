import SwiftUI

// Source: Meliwat/awesome-ios-design-md — spotify/DESIGN-swiftui.md
struct LpspAwesomeSpotifyView: View {
    var body: some View {
        TabView {
            AwesomeSpotifyTabScreen(title: "Home", icon: "house.fill", appName: "Spotify")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeSpotifyTabScreen(title: "Search", icon: "magnifyingglass", appName: "Spotify")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            AwesomeSpotifyTabScreen(title: "Your Library", icon: "books.vertical.fill", appName: "Spotify")
                .tabItem { Label("Your Library", systemImage: "books.vertical.fill") }
            AwesomeSpotifyTabScreen(title: "Premium", icon: "sparkles", appName: "Spotify")
                .tabItem { Label("Premium", systemImage: "sparkles") }
        }
        .tint(SpotifyTokens.spotifyCanvas)
    }
}

private enum SpotifyTokens {
        static let spotifyCanvas = Color(red: 0.07, green: 0.07, blue: 0.07)   // #121212
        static let spotifyDeepBlack = Color.black                                 // #000000
        static let spotifySurface1 = Color(red: 0.094, green: 0.094, blue: 0.094) // #181818
        static let spotifySurface2 = Color(red: 0.157, green: 0.157, blue: 0.157) // #282828
        static let spotifySurface3 = Color(red: 0.243, green: 0.243, blue: 0.243) // #3E3E3E
        static let spotifyDivider = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let spotifyTextPrimary = Color.white                                // #FFFFFF
        static let spotifyTextSecondary = Color(red: 0.702, green: 0.702, blue: 0.702) // #B3B3B3
        static let spotifyTextTertiary = Color(red: 0.416, green: 0.416, blue: 0.416) // #6A6A6A
        static let spotifyGreen = Color(red: 0.114, green: 0.725, blue: 0.329) // #1DB954
        static let spotifyGreenPressed = Color(red: 0.086, green: 0.612, blue: 0.275) // #169C46
        static let spotifyLogoGreen = Color(red: 0.118, green: 0.843, blue: 0.376) // #1ED760
        static let spotifyErrorRed = Color(red: 0.945, green: 0.369, blue: 0.424) // #F15E6C
}

private struct AwesomeSpotifyTabScreen: View {
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
            .background(SpotifyTokens.spotifyCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(SpotifyTokens.spotifyCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(SpotifyTokens.spotifyCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(SpotifyTokens.spotifyCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — deezer/DESIGN-swiftui.md
struct LpspAwesomeDeezerView: View {
    var body: some View {
        TabView {
            AwesomeDeezerTabScreen(title: "Profile", icon: "person.fill", appName: "Deezer")
                .tabItem { Label("Profile", systemImage: "person.fill") }
            AwesomeDeezerTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Deezer")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomeDeezerTabScreen(title: "Search", icon: "square.grid.2x2.fill", appName: "Deezer")
                .tabItem { Label("Search", systemImage: "square.grid.2x2.fill") }
            AwesomeDeezerTabScreen(title: "Music", icon: "square.grid.2x2.fill", appName: "Deezer")
                .tabItem { Label("Music", systemImage: "square.grid.2x2.fill") }
        }
        .tint(DeezerTokens.dzCanvas)
    }
}

private enum DeezerTokens {
        static let dzCanvas = Color(red: 0.059, green: 0.051, blue: 0.075) // #0F0D13
        static let dzSurface1 = Color(red: 0.098, green: 0.086, blue: 0.122) // #19161F
        static let dzSurface2 = Color(red: 0.133, green: 0.118, blue: 0.169) // #221E2B
        static let dzDivider = Color(red: 0.165, green: 0.149, blue: 0.200) // #2A2633
        static let dzTextPrimary = Color.white                                  // #FFFFFF
        static let dzTextSecondary = Color(red: 0.635, green: 0.612, blue: 0.690) // #A29CB0
        static let dzTextTertiary = Color(red: 0.431, green: 0.408, blue: 0.502) // #6E6880
        static let dzPurple = Color(red: 0.635, green: 0.220, blue: 1.000) // #A238FF
        static let dzPink = Color(red: 1.000, green: 0.000, blue: 0.573) // #FF0092
        static let dzPurpleDeep = Color(red: 0.486, green: 0.157, blue: 0.769) // #7C28C4
        static let dzPinkPress = Color(red: 0.839, green: 0.000, blue: 0.475) // #D60079
        static let dzArtMagenta = Color(red: 0.780, green: 0.122, blue: 0.557) // #C71F8E
        static let dzSuccess = Color(red: 0.118, green: 0.843, blue: 0.376) // #1ED760
        static let dzError = Color(red: 1.000, green: 0.302, blue: 0.369) // #FF4D5E
        static let dzWarning = Color(red: 1.000, green: 0.690, blue: 0.180) // #FFB02E
        static let dzFlow = LinearGradient(
        static let dzPlayButton = LinearGradient(
        static let dzArtwork = LinearGradient(
}

private struct AwesomeDeezerTabScreen: View {
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
            .background(DeezerTokens.dzCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(DeezerTokens.dzCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(DeezerTokens.dzCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(DeezerTokens.dzCanvas.opacity(0.12))
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

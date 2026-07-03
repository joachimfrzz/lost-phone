import SwiftUI

// Source: Meliwat/awesome-ios-design-md — soundcloud/DESIGN-swiftui.md
struct LpspAwesomeSoundCloudView: View {
    var body: some View {
        TabView {
            AwesomeSoundCloudTabScreen(title: "Home", icon: "house.fill", appName: "SoundCloud")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeSoundCloudTabScreen(title: "Search", icon: "magnifyingglass", appName: "SoundCloud")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            AwesomeSoundCloudTabScreen(title: "Library", icon: "play.square.stack", appName: "SoundCloud")
                .tabItem { Label("Library", systemImage: "play.square.stack") }
            AwesomeSoundCloudTabScreen(title: "Upload", icon: "arrow.up.circle.fill", appName: "SoundCloud")
                .tabItem { Label("Upload", systemImage: "arrow.up.circle.fill") }
            AwesomeSoundCloudTabScreen(title: "You", icon: "person.crop.circle", appName: "SoundCloud")
                .tabItem { Label("You", systemImage: "person.crop.circle") }
        }
        .tint(SoundCloudTokens.scCanvas)
    }
}

private enum SoundCloudTokens {
        static let scCanvas = Color(red: 1.00, green: 1.00, blue: 1.00) // #FFFFFF
        static let scSurface = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
        static let scDivider = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
        static let scCanvasDark = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let scSurfaceDark = Color(red: 0.149, green: 0.149, blue: 0.149) // #262626
        static let scDividerDark = Color(red: 0.20, green: 0.20, blue: 0.20)    // #333333
        static let scTextPrimary = Color(red: 0.20, green: 0.20, blue: 0.20) // #333333
        static let scTextSecondary = Color(red: 0.60, green: 0.60, blue: 0.60) // #999999
        static let scTextTertiary = Color(red: 0.749, green: 0.749, blue: 0.749) // #BFBFBF
        static let scOrange = Color(red: 1.00, green: 0.333, blue: 0.00) // #FF5500
        static let scOrangeLight = Color(red: 1.00, green: 0.467, blue: 0.00) // #FF7700
        static let scOrangePressed = Color(red: 0.902, green: 0.290, blue: 0.00) // #E64A00
        static let scErrorRed = Color(red: 0.898, green: 0.282, blue: 0.302) // #E5484D
}

private struct AwesomeSoundCloudTabScreen: View {
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
            .background(SoundCloudTokens.scCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(SoundCloudTokens.scCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(SoundCloudTokens.scCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(SoundCloudTokens.scCanvas.opacity(0.12))
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

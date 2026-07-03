import SwiftUI

// Source: Meliwat/awesome-ios-design-md — apple-music/DESIGN-swiftui.md
struct LpspAwesomeAppleMusicView: View {
    var body: some View {
        TabView {
            AwesomeAppleMusicTabScreen(title: "Home", icon: "house.fill", appName: "Apple Music")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeAppleMusicTabScreen(title: "New", icon: "music.note.list", appName: "Apple Music")
                .tabItem { Label("New", systemImage: "music.note.list") }
            AwesomeAppleMusicTabScreen(title: "Radio", icon: "dot.radiowaves.left.and.right", appName: "Apple Music")
                .tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right") }
            AwesomeAppleMusicTabScreen(title: "Library", icon: "square.stack.fill", appName: "Apple Music")
                .tabItem { Label("Library", systemImage: "square.stack.fill") }
            AwesomeAppleMusicTabScreen(title: "Search", icon: "magnifyingglass", appName: "Apple Music")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
        }
        .tint(AppleMusicTokens.amRed)
    }
}

private enum AppleMusicTokens {
        static let amRed = Color(red: 0.980, green: 0.176, blue: 0.282) // #FA2D48
        static let amCoral = Color(red: 0.988, green: 0.235, blue: 0.267) // #FC3C44
        static let amRedPressed = Color(red: 0.831, green: 0.129, blue: 0.231) // #D4213B
        static let amCanvasLight = Color.white                                  // #FFFFFF
        static let amCanvasDark = Color.black                                  // #000000
        static let amSurface1Light = Color(red: 0.949, green: 0.949, blue: 0.969) // #F2F2F7
        static let amSurface1Dark = Color(red: 0.110, green: 0.110, blue: 0.118) // #1C1C1E
        static let amSurface2Dark = Color(red: 0.173, green: 0.173, blue: 0.180) // #2C2C2E
        static let amSurface3Dark = Color(red: 0.227, green: 0.227, blue: 0.235) // #3A3A3C
        static let amDividerLight = Color(red: 0.776, green: 0.776, blue: 0.784) // #C6C6C8
        static let amDividerDark = Color(red: 0.220, green: 0.220, blue: 0.227) // #38383A
        static let amAtmosGold = Color(red: 0.831, green: 0.659, blue: 0.341) // #D4A857
        static let amLosslessSilver = Color(red: 0.557, green: 0.557, blue: 0.576) // #8E8E93
        static let amSystemBlue = Color(red: 0.0,   green: 0.478, blue: 1.0)   // #007AFF
        static let amSystemGreen = Color(red: 0.204, green: 0.780, blue: 0.349) // #34C759
        static let amSystemRed = Color(red: 1.0,   green: 0.231, blue: 0.188) // #FF3B30
}

private struct AwesomeAppleMusicTabScreen: View {
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
            .background(AppleMusicTokens.amCanvasLight.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(AppleMusicTokens.amCanvasLight, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(AppleMusicTokens.amRed)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AppleMusicTokens.amRed.opacity(0.12))
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

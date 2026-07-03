import SwiftUI

// Source: Meliwat/awesome-ios-design-md — shazam/DESIGN-swiftui.md
struct LpspAwesomeShazamView: View {
    var body: some View {
        TabView {
            AwesomeShazamTabScreen(title: "Accueil", icon: "house.fill", appName: "Shazam")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeShazamTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Shazam")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeShazamTabScreen(title: "Profil", icon: "person.fill", appName: "Shazam")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(ShazamTokens.shazamCore)
    }
}

private enum ShazamTokens {
        static let shazamCore = Color(red: 0.0,   green: 0.314, blue: 1.0)   // #0050FF
        static let shazamBlue = Color(red: 0.0,   green: 0.533, blue: 1.0)   // #0088FF
        static let shazamSpace = Color(red: 0.031, green: 0.035, blue: 0.055) // #08090E
        static let shazamBluePressed = Color(red: 0.0, green: 0.435, blue: 0.878) // #006FE0
        static let shazamTextPrimary = Color.white                                 // #FFFFFF
        static let shazamTextSecondary = Color(red: 0.722, green: 0.769, blue: 1.0)   // #B8C4FF periwinkle
        static let shazamTextTertiary = Color(red: 0.722, green: 0.769, blue: 1.0).opacity(0.55)
        static let shazamGlass = Color.white.opacity(0.08)
        static let shazamGlassStrong = Color.white.opacity(0.14)
        static let shazamDivider = Color.white.opacity(0.12)
        static let appleMusicPink = Color(red: 0.980, green: 0.141, blue: 0.235) // #FA243C
        static let shazamErrorRed = Color(red: 1.0,   green: 0.271, blue: 0.227) // #FF453A
}

private struct AwesomeShazamTabScreen: View {
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
            .background(ShazamTokens.shazamCore.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(ShazamTokens.shazamCore, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(ShazamTokens.shazamCore)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(ShazamTokens.shazamCore.opacity(0.12))
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

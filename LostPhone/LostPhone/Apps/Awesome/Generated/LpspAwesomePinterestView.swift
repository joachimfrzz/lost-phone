import SwiftUI

// Source: Meliwat/awesome-ios-design-md — pinterest/DESIGN-swiftui.md
struct LpspAwesomePinterestView: View {
    var body: some View {
        TabView {
            AwesomePinterestTabScreen(title: "Accueil", icon: "house.fill", appName: "Pinterest")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomePinterestTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Pinterest")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomePinterestTabScreen(title: "Profil", icon: "person.fill", appName: "Pinterest")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(PinterestTokens.pinterestRed)
    }
}

private enum PinterestTokens {
        static let pinterestRed = Color(red: 0.902, green: 0.0,   blue: 0.137)  // #E60023
        static let pinterestRedPressed = Color(red: 0.678, green: 0.031, blue: 0.106)  // #AD081B
        static let pinterestRedHover = Color(red: 0.8,   green: 0.0,   blue: 0.125)  // #CC0020
        static let pinterestCanvasLight = Color.white                                 // #FFFFFF
        static let pinterestSurface1Light = Color(red: 0.973, green: 0.973, blue: 0.973) // #F8F8F8
        static let pinterestInputLight = Color(red: 0.937, green: 0.937, blue: 0.937) // #EFEFEF
        static let pinterestDividerLight = Color(red: 0.914, green: 0.914, blue: 0.914) // #E9E9E9
        static let pinterestCanvasDark = Color(red: 0.071, green: 0.071, blue: 0.071) // #121212
        static let pinterestSurface1Dark = Color(red: 0.118, green: 0.118, blue: 0.118) // #1E1E1E
        static let pinterestSurface2Dark = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let pinterestDividerDark = Color(red: 0.180, green: 0.180, blue: 0.180) // #2E2E2E
        static let pinterestTextPrimaryLight = Color(red: 0.067, green: 0.067, blue: 0.067) // #111111
        static let pinterestTextSecondaryLight = Color(red: 0.463, green: 0.463, blue: 0.463) // #767676
        static let pinterestTextTertiaryLight = Color(red: 0.710, green: 0.710, blue: 0.710) // #B5B5B5
        static let pinterestTextPrimaryDark = Color.white                                   // #FFFFFF
        static let pinterestTextSecondaryDark = Color(red: 0.667, green: 0.667, blue: 0.667) // #AAAAAA
        static let pinterestSuccess = Color(red: 0.0, green: 0.541, blue: 0.235) // #008A3C
        static let pinterestInfo = Color(red: 0.0, green: 0.455, blue: 0.910) // #0074E8
}

private struct AwesomePinterestTabScreen: View {
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
            .background(PinterestTokens.pinterestCanvasLight.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(PinterestTokens.pinterestCanvasLight, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(PinterestTokens.pinterestRed)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(PinterestTokens.pinterestRed.opacity(0.12))
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

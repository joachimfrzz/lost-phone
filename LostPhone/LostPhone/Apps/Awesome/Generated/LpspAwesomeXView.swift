import SwiftUI

// Source: Meliwat/awesome-ios-design-md — x-twitter/DESIGN-swiftui.md
struct LpspAwesomeXView: View {
    var body: some View {
        TabView {
            AwesomeXTabScreen(title: "Accueil", icon: "house.fill", appName: "X")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeXTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "X")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeXTabScreen(title: "Profil", icon: "person.fill", appName: "X")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(XTokens.xCanvas)
    }
}

private enum XTokens {
        static let xCanvas = Color.black                                   // #000000
        static let xSurface1 = Color(red: 0.086, green: 0.094, blue: 0.110) // #16181C
        static let xSurface2 = Color(red: 0.118, green: 0.125, blue: 0.141) // #1E2024
        static let xDivider = Color(red: 0.184, green: 0.200, blue: 0.212) // #2F3336
        static let xDimCanvas = Color(red: 0.082, green: 0.125, blue: 0.173) // #15202B
        static let xDimSurface1 = Color(red: 0.098, green: 0.153, blue: 0.204) // #192734
        static let xDimDivider = Color(red: 0.220, green: 0.267, blue: 0.302) // #38444D
        static let xLightCanvas = Color.white                                  // #FFFFFF
        static let xLightSurface1 = Color(red: 0.969, green: 0.976, blue: 0.976) // #F7F9F9
        static let xLightSurface2 = Color(red: 0.937, green: 0.953, blue: 0.957) // #EFF3F4
        static let xTextPrimaryDark = Color(red: 0.906, green: 0.914, blue: 0.918) // #E7E9EA
        static let xTextPrimaryLight = Color(red: 0.059, green: 0.078, blue: 0.098) // #0F1419
        static let xTextSecondaryDark = Color(red: 0.443, green: 0.463, blue: 0.482) // #71767B
        static let xTextSecondaryLight = Color(red: 0.325, green: 0.392, blue: 0.443) // #536471
        static let xBlue = Color(red: 0.114, green: 0.608, blue: 0.941) // #1D9BF0
        static let xBluePressed = Color(red: 0.102, green: 0.549, blue: 0.847) // #1A8CD8
        static let xRepostGreen = Color(red: 0.000, green: 0.729, blue: 0.486) // #00BA7C
        static let xLikePink = Color(red: 0.976, green: 0.094, blue: 0.502) // #F91880
        static let xVerifiedGold = Color(red: 0.918, green: 0.702, blue: 0.031) // #EAB308
        static let xVerifiedGray = Color(red: 0.510, green: 0.604, blue: 0.671) // #829AAB
        static let xErrorRed = Color(red: 0.957, green: 0.129, blue: 0.180) // #F4212E
}

private struct AwesomeXTabScreen: View {
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
            .background(XTokens.xCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(XTokens.xCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(XTokens.xCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(XTokens.xCanvas.opacity(0.12))
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

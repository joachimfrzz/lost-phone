import SwiftUI

// Source: Meliwat/awesome-ios-design-md — snapchat/DESIGN-swiftui.md
struct LpspAwesomeSnapchatView: View {
    var body: some View {
        TabView {
            AwesomeSnapchatTabScreen(title: "Accueil", icon: "house.fill", appName: "Snapchat")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeSnapchatTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Snapchat")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeSnapchatTabScreen(title: "Profil", icon: "person.fill", appName: "Snapchat")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(SnapchatTokens.snapCanvas)
    }
}

private enum SnapchatTokens {
        static let snapCanvas = Color.black                                   // #000000
        static let snapSurface1 = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let snapSurface2 = Color(red: 0.173, green: 0.173, blue: 0.173) // #2C2C2C
        static let snapDivider = Color(red: 0.200, green: 0.200, blue: 0.200) // #333333
        static let snapLightCanvas = Color.white                                   // #FFFFFF
        static let snapLightSurface1 = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
        static let snapTextPrimary = Color.white                                   // #FFFFFF
        static let snapTextPrimaryLight = Color.black                                  // #000000
        static let snapTextSecondary = Color(red: 0.541, green: 0.541, blue: 0.561) // #8A8A8F
        static let snapTextTertiary = Color(red: 0.333, green: 0.333, blue: 0.333) // #555555
        static let snapYellow = Color(red: 1.000, green: 0.988, blue: 0.000) // #FFFC00
        static let snapYellowPressed = Color(red: 0.902, green: 0.890, blue: 0.000) // #E6E300
        static let snapPhotoRed = Color(red: 1.000, green: 0.180, blue: 0.239) // #FF2E3D
        static let snapVideoPurple = Color(red: 0.608, green: 0.318, blue: 1.000) // #9B51FF
        static let snapChatBlue = Color(red: 0.302, green: 0.655, blue: 1.000) // #4DA7FF
        static let snapAudioGreen = Color(red: 0.298, green: 0.851, blue: 0.392) // #4CD964
        static let snapErrorRed = Color(red: 1.000, green: 0.231, blue: 0.188) // #FF3B30
        static let snapSuccessGreen = Color(red: 0.000, green: 0.847, blue: 0.451) // #00D873
        static let snapLiveRed = Color(red: 1.000, green: 0.180, blue: 0.239) // #FF2E3D
}

private struct AwesomeSnapchatTabScreen: View {
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
            .background(SnapchatTokens.snapCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(SnapchatTokens.snapCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(SnapchatTokens.snapCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(SnapchatTokens.snapCanvas.opacity(0.12))
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

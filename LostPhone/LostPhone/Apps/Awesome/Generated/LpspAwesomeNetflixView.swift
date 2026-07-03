import SwiftUI

// Source: Meliwat/awesome-ios-design-md — netflix/DESIGN-swiftui.md
struct LpspAwesomeNetflixView: View {
    var body: some View {
        TabView {
            AwesomeNetflixTabScreen(title: "Home", icon: "house.fill", appName: "Netflix")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeNetflixTabScreen(title: "New & Hot", icon: "play.rectangle.on.rectangle.fill", appName: "Netflix")
                .tabItem { Label("New & Hot", systemImage: "play.rectangle.on.rectangle.fill") }
            AwesomeNetflixTabScreen(title: "My Netflix", icon: "person.crop.circle.fill", appName: "Netflix")
                .tabItem { Label("My Netflix", systemImage: "person.crop.circle.fill") }
            AwesomeNetflixTabScreen(title: "Downloads", icon: "arrow.down.circle.fill", appName: "Netflix")
                .tabItem { Label("Downloads", systemImage: "arrow.down.circle.fill") }
        }
        .tint(NetflixTokens.netflixRed)
    }
}

private enum NetflixTokens {
        static let netflixRed = Color(red: 0.898, green: 0.035, blue: 0.078)  // #E50914
        static let netflixRedPressed = Color(red: 0.718, green: 0.027, blue: 0.059)  // #B7070F
        static let netflixRedDimmed = Color(red: 0.514, green: 0.063, blue: 0.063)  // #831010
        static let netflixCanvas = Color(red: 0.078, green: 0.078, blue: 0.078) // #141414
        static let netflixDeepBlack = Color.black                                   // #000000
        static let netflixSurface1 = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
        static let netflixSurface2 = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let netflixSurface3 = Color(red: 0.227, green: 0.227, blue: 0.227) // #3A3A3A
        static let netflixDivider = Color(red: 0.169, green: 0.169, blue: 0.169) // #2B2B2B
        static let netflixInput = Color(red: 0.2,   green: 0.2,   blue: 0.2)   // #333333
        static let netflixTextPrimary = Color.white                                // #FFFFFF
        static let netflixTextSecondary = Color(red: 0.667, green: 0.667, blue: 0.667) // #AAAAAA
        static let netflixTextTertiary = Color(red: 0.467, green: 0.467, blue: 0.467) // #777777
        static let netflixProfileRed = Color(red: 0.898, green: 0.035, blue: 0.078) // #E50914
        static let netflixProfileBlue = Color(red: 0.243, green: 0.243, blue: 0.569) // #3E3E91
        static let netflixProfileYellow = Color(red: 0.961, green: 0.847, blue: 0.361) // #F5D85C
        static let netflixProfileGreen = Color(red: 0.294, green: 0.541, blue: 0.243) // #4B8A3E
        static let netflixKidsOrange = Color(red: 0.973, green: 0.596, blue: 0.114) // #F8981D
        static let netflixInfo = Color(red: 0.329, green: 0.725, blue: 0.773) // #54B9C5
}

private struct AwesomeNetflixTabScreen: View {
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
            .background(NetflixTokens.netflixCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(NetflixTokens.netflixCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(NetflixTokens.netflixRed)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(NetflixTokens.netflixRed.opacity(0.12))
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

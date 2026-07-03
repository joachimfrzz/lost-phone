import SwiftUI

// Source: Meliwat/awesome-ios-design-md — threads/DESIGN-swiftui.md
struct LpspAwesomeThreadsView: View {
    var body: some View {
        TabView {
            AwesomeThreadsTabScreen(title: "Accueil", icon: "house.fill", appName: "Threads")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeThreadsTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Threads")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeThreadsTabScreen(title: "Profil", icon: "person.fill", appName: "Threads")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(ThreadsTokens.threadsCanvas)
    }
}

private enum ThreadsTokens {
        static let threadsCanvas = Color.black                                   // #000000
        static let threadsSurface1 = Color(red: 0.063, green: 0.063, blue: 0.063) // #101010
        static let threadsSurface2 = Color(red: 0.094, green: 0.094, blue: 0.094) // #181818
        static let threadsDivider = Color(red: 0.133, green: 0.133, blue: 0.133) // #222222
        static let threadsLine = Color(red: 0.200, green: 0.200, blue: 0.200) // #333333
        static let threadsLightCanvas = Color.white                                   // #FFFFFF
        static let threadsLightSurface1 = Color(red: 0.980, green: 0.980, blue: 0.980) // #FAFAFA
        static let threadsLightSurface2 = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
        static let threadsLightDivider = Color(red: 0.859, green: 0.859, blue: 0.859) // #DBDBDB
        static let threadsLightLine = Color(red: 0.851, green: 0.851, blue: 0.851) // #D9D9D9
        static let threadsTextPrimaryDark = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
        static let threadsTextPrimaryLight = Color.black                                   // #000000
        static let threadsTextSecondary = Color(red: 0.467, green: 0.467, blue: 0.467) // #777777
        static let threadsTextTertiaryDark = Color(red: 0.302, green: 0.302, blue: 0.302) // #4D4D4D
        static let threadsTextTertiaryLight = Color(red: 0.600, green: 0.600, blue: 0.600) // #999999
        static let threadsLinkBlue = Color(red: 0.176, green: 0.498, blue: 0.976) // #2D7FF9
        static let threadsLikeCoral = Color(red: 0.996, green: 0.173, blue: 0.333) // #FE2C55
        static let threadsErrorRed = Color(red: 0.929, green: 0.286, blue: 0.337) // #ED4956
        static let threadsSuccessGreen = Color(red: 0.345, green: 0.765, blue: 0.133) // #58C322
        static let threadsIGVerified = Color(red: 0.000, green: 0.584, blue: 0.965) // #0095F6
}

private struct AwesomeThreadsTabScreen: View {
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
            .background(ThreadsTokens.threadsCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(ThreadsTokens.threadsCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(ThreadsTokens.threadsCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(ThreadsTokens.threadsCanvas.opacity(0.12))
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

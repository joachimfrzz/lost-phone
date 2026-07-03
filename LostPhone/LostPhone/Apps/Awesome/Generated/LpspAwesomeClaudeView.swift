import SwiftUI

// Source: Meliwat/awesome-ios-design-md — claude/DESIGN-swiftui.md
struct LpspAwesomeClaudeView: View {
    var body: some View {
        TabView {
            AwesomeClaudeTabScreen(title: "Accueil", icon: "house.fill", appName: "Claude")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeClaudeTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Claude")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeClaudeTabScreen(title: "Profil", icon: "person.fill", appName: "Claude")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(ClaudeTokens.claudeCream)
    }
}

private enum ClaudeTokens {
        static let claudeCream = Color(red: 0.973, green: 0.957, blue: 0.929) // #F8F4ED canvas
        static let claudePaper = Color(red: 0.984, green: 0.976, blue: 0.957) // #FBF9F4 elevated surfaces
        static let claudeSurface1 = Color(red: 0.941, green: 0.918, blue: 0.878) // #F0EAE0 user pill, callouts
        static let claudeSurface2 = Color(red: 0.910, green: 0.878, blue: 0.824) // #E8E0D2 pressed/chips
        static let claudeSand = Color(red: 0.867, green: 0.824, blue: 0.741) // #DDD2BD divider
        static let claudeInk = Color(red: 0.176, green: 0.145, blue: 0.125) // #2D2520 primary
        static let claudeGraphite = Color(red: 0.353, green: 0.310, blue: 0.267) // #5A4F44 secondary
        static let claudeStone = Color(red: 0.541, green: 0.494, blue: 0.447) // #8A7E72 tertiary
        static let claudeBone = Color(red: 0.710, green: 0.671, blue: 0.620) // #B5AB9E disabled
        static let claudeOrange = Color(red: 0.851, green: 0.467, blue: 0.341) // #D97757
        static let claudeOrangePressed = Color(red: 0.745, green: 0.384, blue: 0.259) // #BE6242
        static let claudeOrangeSoft = Color(red: 0.949, green: 0.867, blue: 0.816) // #F2DDD0 active chip
        static let claudeCodeBg = Color(red: 0.122, green: 0.106, blue: 0.086) // #1F1B16
        static let claudeCodeFg = Color(red: 0.910, green: 0.878, blue: 0.824) // #E8E0D2
        static let claudeSyntaxKey = Color(red: 0.851, green: 0.467, blue: 0.341) // #D97757 keywords
        static let claudeSyntaxString = Color(red: 0.498, green: 0.690, blue: 0.412) // #7FB069 strings
        static let claudeSyntaxNum = Color(red: 0.910, green: 0.725, blue: 0.435) // #E8B96F numbers
        static let claudeSyntaxFunc = Color(red: 0.616, green: 0.643, blue: 0.949) // #9DA4F2 functions
        static let claudeSyntaxCmt = Color(red: 0.541, green: 0.494, blue: 0.447) // #8A7E72 comments
        static let claudeSuccess = Color(red: 0.420, green: 0.616, blue: 0.369) // #6B9D5E sage
        static let claudeWarning = Color(red: 0.831, green: 0.600, blue: 0.322) // #D49952
        static let claudeError = Color(red: 0.757, green: 0.400, blue: 0.329) // #C16654 terracotta
        static let claudeInfo = Color(red: 0.353, green: 0.384, blue: 0.451) // #5A6273
        static let claudeDarkCanvas = Color(red: 0.122, green: 0.106, blue: 0.086) // #1F1B16
}

private struct AwesomeClaudeTabScreen: View {
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
            .background(ClaudeTokens.claudeDarkCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(ClaudeTokens.claudeDarkCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(ClaudeTokens.claudeCream)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(ClaudeTokens.claudeCream.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — reddit/DESIGN-swiftui.md
struct LpspAwesomeRedditView: View {
    var body: some View {
        TabView {
            AwesomeRedditTabScreen(title: "Home", icon: "house.fill", appName: "Reddit")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeRedditTabScreen(title: "Communities", icon: "person.3.fill", appName: "Reddit")
                .tabItem { Label("Communities", systemImage: "person.3.fill") }
            AwesomeRedditTabScreen(title: "Create", icon: "plus.circle.fill", appName: "Reddit")
                .tabItem { Label("Create", systemImage: "plus.circle.fill") }
            AwesomeRedditTabScreen(title: "Chat", icon: "bubble.left.and.bubble.right.fill", appName: "Reddit")
                .tabItem { Label("Chat", systemImage: "bubble.left.and.bubble.right.fill") }
            AwesomeRedditTabScreen(title: "Inbox", icon: "bell.fill", appName: "Reddit")
                .tabItem { Label("Inbox", systemImage: "bell.fill") }
        }
        .tint(RedditTokens.rdBrandRed)
    }
}

private enum RedditTokens {
        static let rdBrandRed = Color(red: 1.000, green: 0.271, blue: 0.000) // #FF4500
        static let rdAlertRed = Color(red: 1.000, green: 0.345, blue: 0.357) // #FF585B
        static let rdBrandRedPressed = Color(red: 0.800, green: 0.216, blue: 0.000) // #CC3700
        static let rdUpvote = Color(red: 1.000, green: 0.529, blue: 0.090) // #FF8717
        static let rdUpvoteDark = Color(red: 1.000, green: 0.667, blue: 0.400) // #FFAA66
        static let rdDownvote = Color(red: 0.443, green: 0.576, blue: 1.000) // #7193FF
        static let rdDownvoteDark = Color(red: 0.580, green: 0.580, blue: 1.000) // #9494FF
        static let rdVoteInactive = Color(red: 0.529, green: 0.541, blue: 0.549) // #878A8C
        static let rdVoteInactiveDark = Color(red: 0.506, green: 0.514, blue: 0.518) // #818384
        static let rdCanvasLight = Color(red: 0.965, green: 0.969, blue: 0.973) // #F6F7F8
        static let rdCanvasClassicLight = Color(red: 0.855, green: 0.878, blue: 0.902) // #DAE0E6
        static let rdCardLight = Color.white                                    // #FFFFFF
        static let rdSurface2Light = Color(red: 0.949, green: 0.953, blue: 0.961)  // #F2F3F5
        static let rdDividerLight = Color(red: 0.929, green: 0.937, blue: 0.945)  // #EDEFF1
        static let rdCanvasDark = Color(red: 0.102, green: 0.102, blue: 0.106) // #1A1A1B
        static let rdCardDark = Color(red: 0.153, green: 0.153, blue: 0.161) // #272729
        static let rdSurface2Dark = Color(red: 0.204, green: 0.208, blue: 0.212) // #343536
        static let rdDividerDark = Color(red: 0.204, green: 0.208, blue: 0.212) // #343536
        static let rdTextPrimary = Color(red: 0.102, green: 0.102, blue: 0.106) // #1A1A1B
        static let rdTextSecondary = Color(red: 0.486, green: 0.486, blue: 0.486) // #7C7C7C
        static let rdTextTertiary = Color(red: 0.686, green: 0.686, blue: 0.686) // #AFAFAF
        static let rdTextPrimaryDark = Color(red: 0.843, green: 0.855, blue: 0.863) // #D7DADC
        static let rdTextSecondaryDark = Color(red: 0.506, green: 0.514, blue: 0.518) // #818384
        static let rdTextLink = Color(red: 0.000, green: 0.475, blue: 0.827) // #0079D3
}

private struct AwesomeRedditTabScreen: View {
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
            .background(RedditTokens.rdCanvasLight.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(RedditTokens.rdCanvasLight, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(RedditTokens.rdBrandRed)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(RedditTokens.rdBrandRed.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — linkedin/DESIGN-swiftui.md
struct LpspAwesomeLinkedInView: View {
    var body: some View {
        TabView {
            AwesomeLinkedInTabScreen(title: "Home", icon: "house.fill", appName: "LinkedIn")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeLinkedInTabScreen(title: "My Network", icon: "person.2.fill", appName: "LinkedIn")
                .tabItem { Label("My Network", systemImage: "person.2.fill") }
            AwesomeLinkedInTabScreen(title: "Post", icon: "plus.app.fill", appName: "LinkedIn")
                .tabItem { Label("Post", systemImage: "plus.app.fill") }
            AwesomeLinkedInTabScreen(title: "Notifications", icon: "bell.fill", appName: "LinkedIn")
                .tabItem { Label("Notifications", systemImage: "bell.fill") }
            AwesomeLinkedInTabScreen(title: "Jobs", icon: "briefcase.fill", appName: "LinkedIn")
                .tabItem { Label("Jobs", systemImage: "briefcase.fill") }
        }
        .tint(LinkedInTokens.liCanvas)
    }
}

private enum LinkedInTokens {
        static let liCanvas = Color(red: 0.953, green: 0.949, blue: 0.937)  // #F3F2EF
        static let liCardSurface = Color.white                                    // #FFFFFF
        static let liElevated = Color(red: 0.976, green: 0.976, blue: 0.976)  // #F9F9F9
        static let liDivider = Color(red: 0.878, green: 0.875, blue: 0.863)  // #E0DFDC
        static let liDividerSubtle = Color(red: 0.929, green: 0.929, blue: 0.929)  // #EDEDED
        static let liTextPrimary = Color.black.opacity(0.9)                      // #000000E6
        static let liTextSecondary = Color.black.opacity(0.6)                      // #00000099
        static let liTextTertiary = Color.black.opacity(0.4)                      // #00000066
        static let liBlue = Color(red: 0.039, green: 0.400, blue: 0.761)  // #0A66C2
        static let liBluePressed = Color(red: 0.000, green: 0.255, blue: 0.510)  // #004182
        static let liBlueSubtle = Color(red: 0.906, green: 0.953, blue: 1.000)  // #E7F3FF
        static let liOpenToWork = Color(red: 0.020, green: 0.463, blue: 0.259)  // #057642
        static let liPremiumGold = Color(red: 0.569, green: 0.349, blue: 0.027)  // #915907
        static let liPremiumGoldHi = Color(red: 0.765, green: 0.490, blue: 0.086)  // #C37D16
        static let liReactLike = Color(red: 0.039, green: 0.400, blue: 0.761)  // #0A66C2
        static let liReactCelebrate = Color(red: 0.961, green: 0.733, blue: 0.000)  // #F5BB00
        static let liReactSupport = Color(red: 0.698, green: 0.251, blue: 0.125)  // #B24020
        static let liReactLove = Color(red: 0.875, green: 0.439, blue: 0.302)  // #DF704D
        static let liReactInsightful = Color(red: 0.906, green: 0.639, blue: 0.243) // #E7A33E
        static let liReactFunny = Color(red: 0.000, green: 0.627, blue: 0.863)  // #00A0DC
        static let liDarkCanvas = Color(red: 0.106, green: 0.122, blue: 0.137)  // #1B1F23
        static let liDarkCard = Color(red: 0.114, green: 0.133, blue: 0.149)  // #1D2226
        static let liDarkBlue = Color(red: 0.439, green: 0.710, blue: 0.976)  // #70B5F9
}

private struct AwesomeLinkedInTabScreen: View {
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
            .background(LinkedInTokens.liCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(LinkedInTokens.liCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(LinkedInTokens.liCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(LinkedInTokens.liCanvas.opacity(0.12))
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

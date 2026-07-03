import SwiftUI

// Source: Meliwat/awesome-ios-design-md — bumble/DESIGN-swiftui.md
struct LpspAwesomeBumbleView: View {
    var body: some View {
        TabView {
            AwesomeBumbleTabScreen(title: "Matches", icon: "heart.fill", appName: "Bumble")
                .tabItem { Label("Matches", systemImage: "heart.fill") }
            AwesomeBumbleTabScreen(title: "Profile", icon: "person.crop.circle", appName: "Bumble")
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
            AwesomeBumbleTabScreen(title: "People", icon: "square.grid.2x2.fill", appName: "Bumble")
                .tabItem { Label("People", systemImage: "square.grid.2x2.fill") }
            AwesomeBumbleTabScreen(title: "Hives", icon: "square.grid.2x2.fill", appName: "Bumble")
                .tabItem { Label("Hives", systemImage: "square.grid.2x2.fill") }
            AwesomeBumbleTabScreen(title: "Chats", icon: "square.grid.2x2.fill", appName: "Bumble")
                .tabItem { Label("Chats", systemImage: "square.grid.2x2.fill") }
        }
        .tint(BumbleTokens.bumbleYellow)
    }
}

private enum BumbleTokens {
        static let bumbleYellow = Color(red: 1.000, green: 0.776, blue: 0.161) // #FFC629
        static let bumbleHoneyDeep = Color(red: 0.961, green: 0.714, blue: 0.086) // #F5B616 pressed
        static let bumbleYellowLight = Color(red: 1.000, green: 0.914, blue: 0.631) // #FFE9A1 soft chip
        static let bumbleBFFTeal = Color(red: 0.067, green: 0.667, blue: 0.659) // #11AAA8
        static let bumbleBizzOrange = Color(red: 1.000, green: 0.502, blue: 0.000) // #FF8000
        static let bumbleCanvas = Color(red: 1.000, green: 1.000, blue: 1.000) // #FFFFFF
        static let bumbleBFFCream = Color(red: 1.000, green: 0.988, blue: 0.949) // #FFFCF2
        static let bumbleSurface1 = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
        static let bumbleSurface2 = Color(red: 0.929, green: 0.929, blue: 0.929) // #EDEDED
        static let bumbleDivider = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
        static let bumbleBlack = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F primary
        static let bumbleSlate = Color(red: 0.353, green: 0.353, blue: 0.353) // #5A5A5A secondary
        static let bumbleMist = Color(red: 0.612, green: 0.612, blue: 0.612) // #9C9C9C tertiary
        static let bumbleMatchPink = Color(red: 0.914, green: 0.294, blue: 0.482) // #E94B7B
        static let bumbleVerified = Color(red: 0.000, green: 0.400, blue: 1.000) // #0066FF
        static let bumbleError = Color(red: 0.843, green: 0.149, blue: 0.220) // #D72638
        static let bumbleSuccess = Color(red: 0.000, green: 0.659, blue: 0.420) // #00A86B
        static let bumbleWarning = Color(red: 1.000, green: 0.584, blue: 0.000) // #FF9500
        static let bumbleDarkCanvas = Color(red: 0.059, green: 0.059, blue: 0.059) // #0F0F0F
        static let bumbleDarkSurface = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let bumbleDarkSurface2 = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let bumbleDarkDivider = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F
        static let bumbleDarkText = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
}

private struct AwesomeBumbleTabScreen: View {
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
            .background(BumbleTokens.bumbleCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(BumbleTokens.bumbleCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(BumbleTokens.bumbleYellow)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(BumbleTokens.bumbleYellow.opacity(0.12))
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

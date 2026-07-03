import SwiftUI

// Source: Meliwat/awesome-ios-design-md — kindle/DESIGN-swiftui.md
struct LpspAwesomeKindleView: View {
    var body: some View {
        TabView {
            AwesomeKindleTabScreen(title: "Home", icon: "house.fill", appName: "Kindle")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeKindleTabScreen(title: "Library", icon: "books.vertical.fill", appName: "Kindle")
                .tabItem { Label("Library", systemImage: "books.vertical.fill") }
            AwesomeKindleTabScreen(title: "Discover", icon: "magnifyingglass", appName: "Kindle")
                .tabItem { Label("Discover", systemImage: "magnifyingglass") }
            AwesomeKindleTabScreen(title: "More", icon: "ellipsis", appName: "Kindle")
                .tabItem { Label("More", systemImage: "ellipsis") }
        }
        .tint(KindleTokens.kdlOrange)
    }
}

private enum KindleTokens {
        static let kdlOrange = Color(red: 1.000, green: 0.600, blue: 0.000) // #FF9900
        static let kdlOrangePressed = Color(red: 0.910, green: 0.545, blue: 0.000) // #E88B00
        static let kdlBlack = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let kdlLink = Color(red: 0.102, green: 0.596, blue: 1.000) // #1A98FF
        static let kdlBlue = Color(red: 0.310, green: 0.702, blue: 0.851) // #4FB3D9
        static let kdlWhitePage = Color.white                                     // #FFFFFF
        static let kdlWhiteInk = Color(red: 0.102, green: 0.102, blue: 0.102)    // #1A1A1A
        static let kdlSepiaPage = Color(red: 0.984, green: 0.941, blue: 0.851)    // #FBF0D9
        static let kdlSepiaInk = Color(red: 0.373, green: 0.294, blue: 0.196)    // #5F4B32
        static let kdlGreenPage = Color(red: 0.773, green: 0.882, blue: 0.773)    // #C5E1C5
        static let kdlGreenInk = Color(red: 0.200, green: 0.286, blue: 0.184)    // #33492F
        static let kdlDarkPage = Color(red: 0.165, green: 0.165, blue: 0.165)    // #2A2A2A
        static let kdlDarkInk = Color(red: 0.847, green: 0.847, blue: 0.847)    // #D8D8D8
        static let kdlBlackPage = Color.black                                     // #000000
        static let kdlBlackInk = Color(red: 0.784, green: 0.784, blue: 0.784)    // #C8C8C8
        static let kdlChromeCanvas = Color.white                                  // #FFFFFF
        static let kdlSurfaceSubtle = Color(red: 0.957, green: 0.949, blue: 0.933) // #F4F2EE
        static let kdlDivider = Color(red: 0.894, green: 0.886, blue: 0.867) // #E4E2DD
        static let kdlDarkCanvas = Color(red: 0.055, green: 0.055, blue: 0.055)  // #0E0E0E
        static let kdlDarkSurface1 = Color(red: 0.102, green: 0.102, blue: 0.102)  // #1A1A1A
        static let kdlDarkSurface2 = Color(red: 0.141, green: 0.141, blue: 0.141)  // #242424
        static let kdlDarkDivider = Color(red: 0.180, green: 0.180, blue: 0.180)  // #2E2E2E
        static let kdlTextPrimary = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let kdlTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420) // #6B6B6B
}

private struct AwesomeKindleTabScreen: View {
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
            .background(KindleTokens.kdlChromeCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(KindleTokens.kdlChromeCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(KindleTokens.kdlOrange)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(KindleTokens.kdlOrange.opacity(0.12))
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

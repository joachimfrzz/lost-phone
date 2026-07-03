import SwiftUI

// Source: Meliwat/awesome-ios-design-md — audible/DESIGN-swiftui.md
struct LpspAwesomeAudibleView: View {
    var body: some View {
        TabView {
            AwesomeAudibleTabScreen(title: "Home", icon: "house.fill", appName: "Audible")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeAudibleTabScreen(title: "Library", icon: "books.vertical.fill", appName: "Audible")
                .tabItem { Label("Library", systemImage: "books.vertical.fill") }
            AwesomeAudibleTabScreen(title: "Discover", icon: "magnifyingglass", appName: "Audible")
                .tabItem { Label("Discover", systemImage: "magnifyingglass") }
            AwesomeAudibleTabScreen(title: "Profile", icon: "person.crop.circle", appName: "Audible")
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
        .tint(AudibleTokens.audCanvas)
    }
}

private enum AudibleTokens {
        static let audCanvas = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let audSurface1 = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let audSurface2 = Color(red: 0.204, green: 0.204, blue: 0.204) // #343434
        static let audDivider = Color(red: 0.227, green: 0.227, blue: 0.227) // #3A3A3A
        static let audTextPrimary = Color.white                                // #FFFFFF
        static let audTextSecondary = Color(red: 0.690, green: 0.690, blue: 0.690) // #B0B0B0
        static let audTextTertiary = Color(red: 0.431, green: 0.431, blue: 0.431) // #6E6E6E
        static let audOrange = Color(red: 1.0,   green: 0.600, blue: 0.0)  // #FF9900
        static let audOrangePressed = Color(red: 0.902, green: 0.541, blue: 0.0)  // #E68A00
        static let audErrorRed = Color(red: 0.898, green: 0.282, blue: 0.302) // #E5484D
}

private struct AwesomeAudibleTabScreen: View {
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
            .background(AudibleTokens.audCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(AudibleTokens.audCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(AudibleTokens.audCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(AudibleTokens.audCanvas.opacity(0.12))
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

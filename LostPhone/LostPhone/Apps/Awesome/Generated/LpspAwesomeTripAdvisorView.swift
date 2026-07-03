import SwiftUI

// Source: Meliwat/awesome-ios-design-md — tripadvisor/DESIGN-swiftui.md
struct LpspAwesomeTripAdvisorView: View {
    var body: some View {
        TabView {
            AwesomeTripAdvisorTabScreen(title: "Explore", icon: "safari.fill", appName: "TripAdvisor")
                .tabItem { Label("Explore", systemImage: "safari.fill") }
            AwesomeTripAdvisorTabScreen(title: "Search", icon: "magnifyingglass", appName: "TripAdvisor")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            AwesomeTripAdvisorTabScreen(title: "Trips", icon: "suitcase.fill", appName: "TripAdvisor")
                .tabItem { Label("Trips", systemImage: "suitcase.fill") }
            AwesomeTripAdvisorTabScreen(title: "Review", icon: "square.and.pencil", appName: "TripAdvisor")
                .tabItem { Label("Review", systemImage: "square.and.pencil") }
            AwesomeTripAdvisorTabScreen(title: "More", icon: "ellipsis", appName: "TripAdvisor")
                .tabItem { Label("More", systemImage: "ellipsis") }
        }
        .tint(TripAdvisorTokens.taCanvas)
    }
}

private enum TripAdvisorTokens {
        static let taCanvas = Color.white                                    // #FFFFFF
        static let taSurface = Color(red: 0.949, green: 0.949, blue: 0.949)   // #F2F2F2
        static let taDivider = Color(red: 0.878, green: 0.878, blue: 0.878)   // #E0E0E0
        static let taSurfacePressed = Color(red: 0.910, green: 0.910, blue: 0.910)  // #E8E8E8
        static let taTextPrimary = Color.black                                    // #000000
        static let taTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)   // #6B6B6B
        static let taTextTertiary = Color(red: 0.608, green: 0.608, blue: 0.608)   // #9B9B9B
        static let taGreen = Color(red: 0.204, green: 0.878, blue: 0.631)   // #34E0A1
        static let taGreenPressed = Color(red: 0.129, green: 0.773, blue: 0.537)   // #21C589
        static let taOwlBlack = Color.black                                    // #000000
        static let taEmptyBubble = Color(red: 0.851, green: 0.851, blue: 0.851)   // #D9D9D9
        static let taErrorRed = Color(red: 0.839, green: 0.071, blue: 0.180)   // #D6122E
}

private struct AwesomeTripAdvisorTabScreen: View {
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
            .background(TripAdvisorTokens.taCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(TripAdvisorTokens.taCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(TripAdvisorTokens.taCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(TripAdvisorTokens.taCanvas.opacity(0.12))
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

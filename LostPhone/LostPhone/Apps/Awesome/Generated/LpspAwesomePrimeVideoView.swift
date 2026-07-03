import SwiftUI

// Source: Meliwat/awesome-ios-design-md — prime-video/DESIGN-swiftui.md
struct LpspAwesomePrimeVideoView: View {
    var body: some View {
        TabView {
            AwesomePrimeVideoTabScreen(title: "Downloads", icon: "arrow.down.circle.fill", appName: "Prime Video")
                .tabItem { Label("Downloads", systemImage: "arrow.down.circle.fill") }
            AwesomePrimeVideoTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Prime Video")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomePrimeVideoTabScreen(title: "Store", icon: "square.grid.2x2.fill", appName: "Prime Video")
                .tabItem { Label("Store", systemImage: "square.grid.2x2.fill") }
            AwesomePrimeVideoTabScreen(title: "Live", icon: "square.grid.2x2.fill", appName: "Prime Video")
                .tabItem { Label("Live", systemImage: "square.grid.2x2.fill") }
            AwesomePrimeVideoTabScreen(title: "Find", icon: "square.grid.2x2.fill", appName: "Prime Video")
                .tabItem { Label("Find", systemImage: "square.grid.2x2.fill") }
        }
        .tint(PrimeVideoTokens.primeCanvas)
    }
}

private enum PrimeVideoTokens {
        static let primeCanvas = Color(red: 0.059, green: 0.090, blue: 0.118) // #0F171E
        static let primeDeepBlack = Color.black                                  // #000000
        static let primeSurface1 = Color(red: 0.102, green: 0.141, blue: 0.184) // #1A242F
        static let primeSurface2 = Color(red: 0.137, green: 0.184, blue: 0.243) // #232F3E
        static let primeSurface3 = Color(red: 0.180, green: 0.231, blue: 0.278) // #2E3B47
        static let primeDivider = Color(red: 0.180, green: 0.231, blue: 0.278) // #2E3B47
        static let primeTextPrimary = Color.white                                // #FFFFFF
        static let primeTextSecondary = Color(red: 0.667, green: 0.718, blue: 0.769) // #AAB7C4
        static let primeTextTertiary = Color(red: 0.431, green: 0.482, blue: 0.537) // #6E7B89
        static let primeBlue = Color(red: 0.000, green: 0.659, blue: 0.882) // #00A8E1
        static let primeBluePressed = Color(red: 0.000, green: 0.549, blue: 0.741) // #008CBD
        static let primeImdbYellow = Color(red: 0.961, green: 0.773, blue: 0.094) // #F5C518
        static let primeLiveRed = Color(red: 0.898, green: 0.035, blue: 0.078) // #E50914
}

private struct AwesomePrimeVideoTabScreen: View {
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
            .background(PrimeVideoTokens.primeCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(PrimeVideoTokens.primeCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(PrimeVideoTokens.primeCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(PrimeVideoTokens.primeCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — perplexity/DESIGN-swiftui.md
struct LpspAwesomePerplexityView: View {
    var body: some View {
        TabView {
            AwesomePerplexityTabScreen(title: "Discover", icon: "safari", appName: "Perplexity")
                .tabItem { Label("Discover", systemImage: "safari") }
            AwesomePerplexityTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Perplexity")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomePerplexityTabScreen(title: "Library", icon: "square.grid.2x2.fill", appName: "Perplexity")
                .tabItem { Label("Library", systemImage: "square.grid.2x2.fill") }
            AwesomePerplexityTabScreen(title: "Spaces", icon: "square.grid.2x2.fill", appName: "Perplexity")
                .tabItem { Label("Spaces", systemImage: "square.grid.2x2.fill") }
        }
        .tint(PerplexityTokens.pplxCanvas)
    }
}

private enum PerplexityTokens {
        static let pplxCanvas = Color(red: 0.039, green: 0.039, blue: 0.039) // #0A0A0A
        static let pplxSurface1 = Color(red: 0.090, green: 0.090, blue: 0.090) // #171717
        static let pplxSurface2 = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
        static let pplxSurface3 = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let pplxDivider = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
        static let pplxTextPrimary = Color(red: 0.980, green: 0.980, blue: 0.980) // #FAFAFA off-white
        static let pplxTextSecondary = Color(red: 0.631, green: 0.631, blue: 0.631) // #A1A1A1
        static let pplxTextTertiary = Color(red: 0.431, green: 0.431, blue: 0.431) // #6E6E6E
        static let pplxTextMuted = Color(red: 0.290, green: 0.290, blue: 0.290) // #4A4A4A
        static let pplxTeal = Color(red: 0.125, green: 0.722, blue: 0.804) // #20B8CD
        static let pplxTealBright = Color(red: 0.239, green: 0.839, blue: 0.925) // #3DD6EC streaming cursor
        static let pplxTealDeep = Color(red: 0.082, green: 0.569, blue: 0.639) // #1591A3 pressed
        static let pplxTealSoft = Color(red: 0.059, green: 0.227, blue: 0.259) // #0F3A42 Pro Steps fill
        static let pplxCodeBg = Color(red: 0.055, green: 0.055, blue: 0.055) // #0E0E0E
        static let pplxCodeFg = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
        static let pplxSyntaxStr = Color(red: 0.659, green: 0.878, blue: 0.388) // #A8E063 lime
        static let pplxSyntaxNum = Color(red: 0.949, green: 0.651, blue: 0.353) // #F2A65A orange
        static let pplxSyntaxFunc = Color(red: 0.725, green: 0.533, blue: 0.949) // #B988F2 purple
        static let pplxSuccess = Color(red: 0.133, green: 0.773, blue: 0.369) // #22C55E
        static let pplxWarning = Color(red: 0.961, green: 0.620, blue: 0.043) // #F59E0B
        static let pplxError = Color(red: 0.937, green: 0.267, blue: 0.267) // #EF4444
        static let pplxProGold = Color(red: 0.878, green: 0.702, blue: 0.255) // #E0B341
        static let pplxLightCanvas = Color(red: 1.000, green: 1.000, blue: 1.000) // #FFFFFF
        static let pplxLightSurface1 = Color(red: 0.969, green: 0.969, blue: 0.969) // #F7F7F7
}

private struct AwesomePerplexityTabScreen: View {
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
            .background(PerplexityTokens.pplxCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(PerplexityTokens.pplxCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(PerplexityTokens.pplxCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(PerplexityTokens.pplxCanvas.opacity(0.12))
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

import SwiftUI

// Source: Meliwat/awesome-ios-design-md — uber-eats/DESIGN-swiftui.md
struct LpspAwesomeUberEatsView: View {
    var body: some View {
        TabView {
            AwesomeUberEatsTabScreen(title: "Account", icon: "person.crop.circle.fill", appName: "Uber Eats")
                .tabItem { Label("Account", systemImage: "person.crop.circle.fill") }
            AwesomeUberEatsTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Uber Eats")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomeUberEatsTabScreen(title: "Browse", icon: "square.grid.2x2.fill", appName: "Uber Eats")
                .tabItem { Label("Browse", systemImage: "square.grid.2x2.fill") }
            AwesomeUberEatsTabScreen(title: "Search", icon: "square.grid.2x2.fill", appName: "Uber Eats")
                .tabItem { Label("Search", systemImage: "square.grid.2x2.fill") }
            AwesomeUberEatsTabScreen(title: "Cart", icon: "square.grid.2x2.fill", appName: "Uber Eats")
                .tabItem { Label("Cart", systemImage: "square.grid.2x2.fill") }
        }
        .tint(UberEatsTokens.ueCanvas)
    }
}

private enum UberEatsTokens {
        static let ueCanvas = Color.white                                       // #FFFFFF
        static let ueSurface = Color(red: 0.953, green: 0.953, blue: 0.953)      // #F3F3F3
        static let ueSurface2 = Color(red: 0.933, green: 0.933, blue: 0.933)      // #EEEEEE
        static let ueDivider = Color(red: 0.910, green: 0.910, blue: 0.910)      // #E8E8E8
        static let ueTextPrimary = Color.black                                   // #000000
        static let ueTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)  // #6B6B6B
        static let ueTextTertiary = Color(red: 0.651, green: 0.651, blue: 0.651)  // #A6A6A6
        static let ueDarkCanvas = Color.black                                   // #000000
        static let ueDarkSurface = Color(red: 0.110, green: 0.110, blue: 0.118)  // #1C1C1E
        static let ueDarkSurface2 = Color(red: 0.173, green: 0.173, blue: 0.180)  // #2C2C2E
        static let ueGreen = Color(red: 0.024, green: 0.757, blue: 0.404)   // #06C167
        static let ueGreenPressed = Color(red: 0.020, green: 0.651, blue: 0.345)   // #05A658
        static let ueGreenTint = Color(red: 0.906, green: 0.973, blue: 0.937)   // #E7F8EF
        static let ueErrorRed = Color(red: 0.882, green: 0.098, blue: 0.000)   // #E11900
        static let ueBusyAmber = Color(red: 1.000, green: 0.541, blue: 0.000)   // #FF8A00
}

private struct AwesomeUberEatsTabScreen: View {
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
            .background(UberEatsTokens.ueCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(UberEatsTokens.ueCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(UberEatsTokens.ueCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(UberEatsTokens.ueCanvas.opacity(0.12))
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

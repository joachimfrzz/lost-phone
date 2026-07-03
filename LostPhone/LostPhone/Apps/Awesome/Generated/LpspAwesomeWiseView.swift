import SwiftUI

// Source: Meliwat/awesome-ios-design-md — wise/DESIGN-swiftui.md
struct LpspAwesomeWiseView: View {
    var body: some View {
        TabView {
            AwesomeWiseTabScreen(title: "Home", icon: "house.fill", appName: "Wise")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeWiseTabScreen(title: "Card", icon: "creditcard.fill", appName: "Wise")
                .tabItem { Label("Card", systemImage: "creditcard.fill") }
            AwesomeWiseTabScreen(title: "Recipients", icon: "person.2.fill", appName: "Wise")
                .tabItem { Label("Recipients", systemImage: "person.2.fill") }
            AwesomeWiseTabScreen(title: "Payments", icon: "arrow.left.arrow.right", appName: "Wise")
                .tabItem { Label("Payments", systemImage: "arrow.left.arrow.right") }
            AwesomeWiseTabScreen(title: "Account", icon: "person.crop.circle.fill", appName: "Wise")
                .tabItem { Label("Account", systemImage: "person.crop.circle.fill") }
        }
        .tint(WiseTokens.wiseCanvas)
    }
}

private enum WiseTokens {
        static let wiseCanvas = Color.white                                  // #FFFFFF
        static let wiseSurface = Color(red: 0.969, green: 0.969, blue: 0.969) // #F7F7F7
        static let wiseSurfaceSunken = Color(red: 0.937, green: 0.937, blue: 0.937) // #EFEFEF
        static let wiseDivider = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
        static let wiseBorder = Color(red: 0.824, green: 0.824, blue: 0.824) // #D2D2D2
        static let wiseTextPrimary = Color(red: 0.055, green: 0.059, blue: 0.047) // #0E0F0C
        static let wiseTextSecondary = Color(red: 0.420, green: 0.435, blue: 0.400) // #6B6F66
        static let wiseTextTertiary = Color(red: 0.604, green: 0.616, blue: 0.584) // #9A9D95
        static let wiseBright = Color(red: 0.624, green: 0.910, blue: 0.439) // #9FE870
        static let wiseBrightPressed = Color(red: 0.541, green: 0.831, blue: 0.361) // #8AD45C
        static let wiseBrightTint = Color(red: 0.918, green: 0.976, blue: 0.863) // #EAF9DC
        static let wiseForest = Color(red: 0.086, green: 0.200, blue: 0.000) // #163300
        static let wiseForestHover = Color(red: 0.055, green: 0.133, blue: 0.000) // #0E2200
        static let wiseSuccess = Color(red: 0.184, green: 0.561, blue: 0.306) // #2F8F4E
        static let wisePending = Color(red: 0.710, green: 0.471, blue: 0.118) // #B5781E
        static let wiseError = Color(red: 0.831, green: 0.200, blue: 0.169) // #D4332B
}

private struct AwesomeWiseTabScreen: View {
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
            .background(WiseTokens.wiseCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(WiseTokens.wiseCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(WiseTokens.wiseCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(WiseTokens.wiseCanvas.opacity(0.12))
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

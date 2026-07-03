import SwiftUI

// Source: Meliwat/awesome-ios-design-md — tinder/DESIGN-swiftui.md
struct LpspAwesomeTinderView: View {
    var body: some View {
        TabView {
            AwesomeTinderTabScreen(title: "Accueil", icon: "house.fill", appName: "Tinder")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeTinderTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Tinder")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeTinderTabScreen(title: "Profil", icon: "person.fill", appName: "Tinder")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(TinderTokens.tdrCanvas)
    }
}

private enum TinderTokens {
        static let tdrCanvas = Color.white                                    // #FFFFFF
        static let tdrSurfaceMuted = Color(red: 0.961, green: 0.961, blue: 0.961)  // #F5F5F5
        static let tdrSurfaceTint = Color(red: 0.980, green: 0.980, blue: 0.980)  // #FAFAFA
        static let tdrDivider = Color(red: 0.898, green: 0.898, blue: 0.898)  // #E5E5E5
        static let tdrTextPrimary = Color(red: 0.259, green: 0.259, blue: 0.259)  // #424242
        static let tdrTextSecondary = Color(red: 0.451, green: 0.451, blue: 0.451)  // #737373
        static let tdrTextTertiary = Color(red: 0.620, green: 0.620, blue: 0.620)  // #9E9E9E
        static let tdrPink = Color(red: 0.992, green: 0.149, blue: 0.478)  // #FD267A
        static let tdrOrange = Color(red: 1.000, green: 0.376, blue: 0.212)  // #FF6036
        static let tdrNopeRed = Color(red: 1.000, green: 0.267, blue: 0.345)  // #FF4458
        static let tdrSuperLikeBlue = Color(red: 0.365, green: 0.553, blue: 0.945)  // #5D8DF1
        static let tdrBoostPurple = Color(red: 0.663, green: 0.322, blue: 1.000)  // #A952FF
        static let tdrRewindGold = Color(red: 1.000, green: 0.741, blue: 0.231)  // #FFBD3B
        static let tdrLikeStampGreen = Color(red: 0.000, green: 0.839, blue: 0.561) // #00D68F
        static let tdrVerifiedBlue = Color(red: 0.161, green: 0.690, blue: 1.000)  // #29B0FF
        static let tdrMatchGlow = Color(red: 0.000, green: 0.839, blue: 0.561)  // #00D68F
        static let tdrDarkCanvas = Color(red: 0.071, green: 0.071, blue: 0.071)  // #121212
        static let tdrDarkSurface1 = Color(red: 0.114, green: 0.114, blue: 0.114)  // #1D1D1D
        static let tdrDarkSurface2 = Color(red: 0.165, green: 0.165, blue: 0.165)  // #2A2A2A
        static let tdrBrand = LinearGradient(
}

private struct AwesomeTinderTabScreen: View {
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
            .background(TinderTokens.tdrCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(TinderTokens.tdrCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(TinderTokens.tdrCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(TinderTokens.tdrCanvas.opacity(0.12))
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

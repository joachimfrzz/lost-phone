import SwiftUI

// Source: Meliwat/awesome-ios-design-md — instagram/DESIGN-swiftui.md
struct LpspAwesomeInstagramView: View {
    var body: some View {
        TabView {
            AwesomeInstagramTabScreen(title: "Accueil", icon: "house.fill", appName: "Instagram")
                .tabItem { Label("Accueil", systemImage: "house.fill") }
            AwesomeInstagramTabScreen(title: "Explorer", icon: "magnifyingglass", appName: "Instagram")
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
            AwesomeInstagramTabScreen(title: "Profil", icon: "person.fill", appName: "Instagram")
                .tabItem { Label("Profil", systemImage: "person.fill") }
        }
        .tint(InstagramTokens.igCanvasLight)
    }
}

private enum InstagramTokens {
        static let igCanvasLight = Color.white
        static let igCanvasDark = Color.black  // true #000000 for OLED
        static let igElevatedDark = Color(red: 0.071, green: 0.071, blue: 0.071)  // #121212
        static let igSurfaceInputL = Color(red: 0.937, green: 0.937, blue: 0.937)  // #EFEFEF
        static let igSurfaceInputD = Color(red: 0.149, green: 0.149, blue: 0.149)  // #262626
        static let igDividerLight = Color(red: 0.859, green: 0.859, blue: 0.859)  // #DBDBDB
        static let igDividerDark = Color(red: 0.149, green: 0.149, blue: 0.149)  // #262626
        static let igTextSecondaryL = Color(red: 0.557, green: 0.557, blue: 0.557) // #8E8E8E
        static let igTextSecondaryD = Color(red: 0.659, green: 0.659, blue: 0.659) // #A8A8A8
        static let igActionBlue = Color(red: 0.000, green: 0.584, blue: 0.965) // #0095F6
        static let igActionPressed = Color(red: 0.094, green: 0.467, blue: 0.949) // #1877F2
        static let igDestructive = Color(red: 0.929, green: 0.286, blue: 0.337) // #ED4956
        static let igLinkLight = Color(red: 0.000, green: 0.216, blue: 0.420) // #00376B
        static let igLinkDark = Color(red: 0.878, green: 0.945, blue: 1.0)   // #E0F1FF
        static let igGradBlue = Color(red: 0.251, green: 0.365, blue: 0.902) // #405DE6
        static let igGradPurpleBlue = Color(red: 0.345, green: 0.318, blue: 0.859) // #5851DB
        static let igGradPurple = Color(red: 0.514, green: 0.227, blue: 0.706) // #833AB4
        static let igGradPurpleRed = Color(red: 0.757, green: 0.208, blue: 0.518) // #C13584
        static let igGradRose = Color(red: 0.882, green: 0.188, blue: 0.424) // #E1306C
        static let igGradRed = Color(red: 0.992, green: 0.114, blue: 0.114) // #FD1D1D
        static let igGradRedOrange = Color(red: 0.961, green: 0.376, blue: 0.251) // #F56040
        static let igGradOrange = Color(red: 0.969, green: 0.467, blue: 0.216) // #F77737
        static let igGradOrangeYellow = Color(red: 0.988, green: 0.686, blue: 0.271) // #FCAF45
        static let igGradYellow = Color(red: 1.0,   green: 0.863, blue: 0.502) // #FFDC80
}

private struct AwesomeInstagramTabScreen: View {
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
            .background(InstagramTokens.igCanvasLight.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(InstagramTokens.igCanvasLight, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(InstagramTokens.igCanvasLight)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(InstagramTokens.igCanvasLight.opacity(0.12))
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

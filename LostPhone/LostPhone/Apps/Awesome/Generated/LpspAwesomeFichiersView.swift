import SwiftUI

// Source: Meliwat/awesome-ios-design-md — dropbox/DESIGN-swiftui.md
struct LpspAwesomeFichiersView: View {
    var body: some View {
        TabView {
            AwesomeFichiersTabScreen(title: "Offline", icon: "arrow.down.circle", appName: "Fichiers")
                .tabItem { Label("Offline", systemImage: "arrow.down.circle") }
            AwesomeFichiersTabScreen(title: "Account", icon: "person.crop.circle", appName: "Fichiers")
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
            AwesomeFichiersTabScreen(title: "Home", icon: "square.grid.2x2.fill", appName: "Fichiers")
                .tabItem { Label("Home", systemImage: "square.grid.2x2.fill") }
            AwesomeFichiersTabScreen(title: "Files", icon: "square.grid.2x2.fill", appName: "Fichiers")
                .tabItem { Label("Files", systemImage: "square.grid.2x2.fill") }
            AwesomeFichiersTabScreen(title: "Photos", icon: "square.grid.2x2.fill", appName: "Fichiers")
                .tabItem { Label("Photos", systemImage: "square.grid.2x2.fill") }
        }
        .tint(FichiersTokens.dbxCanvas)
    }
}

private enum FichiersTokens {
        static let dbxCanvas = Color.white                                   // #FFFFFF
        static let dbxSurface = Color(red: 0.969, green: 0.961, blue: 0.949)   // #F7F5F2
        static let dbxDivider = Color(red: 0.902, green: 0.882, blue: 0.855)   // #E6E1DA
        static let dbxTextPrimary = Color(red: 0.118, green: 0.098, blue: 0.098) // #1E1919
        static let dbxTextSecondary = Color(red: 0.435, green: 0.416, blue: 0.396) // #6F6A65
        static let dbxTextTertiary = Color(red: 0.639, green: 0.620, blue: 0.596) // #A39E98
        static let dbxBlue = Color(red: 0.0,   green: 0.380, blue: 1.0)     // #0061FF
        static let dbxBluePressed = Color(red: 0.0,   green: 0.314, blue: 0.816)   // #0050D0
        static let dbxBlueTint = Color(red: 0.902, green: 0.941, blue: 1.0)     // #E6F0FF
        static let dbxDarkCanvas = Color(red: 0.118, green: 0.098, blue: 0.098)   // #1E1919
        static let dbxDarkSurface = Color(red: 0.165, green: 0.141, blue: 0.141)   // #2A2424
        static let dbxDarkDivider = Color(red: 0.227, green: 0.200, blue: 0.192)   // #3A3331
        static let dbxDarkBlue = Color(red: 0.239, green: 0.545, blue: 1.0)     // #3D8BFF
        static let dbxPdfRed = Color(red: 0.980, green: 0.333, blue: 0.118)     // #FA551E
        static let dbxSheetGreen = Color(red: 0.102, green: 0.529, blue: 0.329)    // #1A8754
        static let dbxImageTeal = Color(red: 0.0,   green: 0.698, blue: 0.663)     // #00B2A9
        static let dbxFolderSlate = Color(red: 0.549, green: 0.592, blue: 0.659)   // #8C97A8
        static let dbxSuccess = Color(red: 0.102, green: 0.529, blue: 0.329)       // #1A8754
        static let dbxWarning = Color(red: 1.0,   green: 0.686, blue: 0.0)         // #FFAF00
        static let dbxError = Color(red: 0.820, green: 0.094, blue: 0.043)       // #D1180B
}

private struct AwesomeFichiersTabScreen: View {
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
            .background(FichiersTokens.dbxCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(FichiersTokens.dbxCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(FichiersTokens.dbxCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(FichiersTokens.dbxCanvas.opacity(0.12))
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

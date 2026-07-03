import SwiftUI

// Source: Meliwat/awesome-ios-design-md — signal/DESIGN-swiftui.md
struct LpspAwesomeSignalView: View {
    var body: some View {
        TabView {
            AwesomeSignalTabScreen(title: "Chats", icon: "message.fill", appName: "Signal")
                .tabItem { Label("Chats", systemImage: "message.fill") }
            AwesomeSignalTabScreen(title: "Calls", icon: "phone.fill", appName: "Signal")
                .tabItem { Label("Calls", systemImage: "phone.fill") }
            AwesomeSignalTabScreen(title: "Stories", icon: "circle.dashed", appName: "Signal")
                .tabItem { Label("Stories", systemImage: "circle.dashed") }
            AwesomeSignalTabScreen(title: "Settings", icon: "gearshape.fill", appName: "Signal")
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(SignalTokens.sigCanvas)
    }
}

private enum SignalTokens {
        static let sigCanvas = Color(red: 1, green: 1, blue: 1)                // #FFFFFF
        static let sigCanvasDark = Color(red: 0.106, green: 0.106, blue: 0.106)    // #1B1B1B
        static let sigSurface = Color(red: 0.961, green: 0.961, blue: 0.961)    // #F5F5F5
        static let sigSurfaceDark = Color(red: 0.165, green: 0.165, blue: 0.165)    // #2A2A2A
        static let sigDivider = Color(red: 0.898, green: 0.898, blue: 0.898)    // #E5E5E5
        static let sigDividerDark = Color(red: 0.227, green: 0.227, blue: 0.227)    // #3A3A3A
        static let sigTextPrimary = Color.black                                    // #000000
        static let sigTextPrimaryD = Color.white                                    // #FFFFFF
        static let sigTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)   // #6B6B6B
        static let sigTextTertiary = Color(red: 0.604, green: 0.604, blue: 0.604)   // #9A9A9A
        static let sigBlue = Color(red: 0.227, green: 0.463, blue: 0.941)     // #3A76F0
        static let sigBluePressed = Color(red: 0.184, green: 0.373, blue: 0.800)     // #2F5FCC
        static let sigBlueTint = Color(red: 0.906, green: 0.933, blue: 0.992)     // #E7EEFD
        static let sigIncoming = Color(red: 0.914, green: 0.914, blue: 0.922)    // #E9E9EB
        static let sigIncomingDark = Color(red: 0.165, green: 0.165, blue: 0.165)    // #2A2A2A
        static let sigOutMeta = Color(red: 0.796, green: 0.851, blue: 0.976)    // #CBD9F9
        static let sigError = Color(red: 0.843, green: 0.149, blue: 0.239)         // #D7263D
        static let sigSuccess = Color(red: 0.227, green: 0.710, blue: 0.290)         // #3AB54A
}

private struct AwesomeSignalTabScreen: View {
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
            .background(SignalTokens.sigCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(SignalTokens.sigCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(SignalTokens.sigCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(SignalTokens.sigCanvas.opacity(0.12))
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

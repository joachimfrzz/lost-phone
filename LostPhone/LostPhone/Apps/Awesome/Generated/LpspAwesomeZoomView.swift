import SwiftUI

// Source: Meliwat/awesome-ios-design-md — zoom/DESIGN-swiftui.md
struct LpspAwesomeZoomView: View {
    var body: some View {
        TabView {
            AwesomeZoomTabScreen(title: "Team Chat", icon: "bubble.left.and.bubble.right.fill", appName: "Zoom")
                .tabItem { Label("Team Chat", systemImage: "bubble.left.and.bubble.right.fill") }
            AwesomeZoomTabScreen(title: "Meetings", icon: "square.grid.2x2.fill", appName: "Zoom")
                .tabItem { Label("Meetings", systemImage: "square.grid.2x2.fill") }
            AwesomeZoomTabScreen(title: "Mail", icon: "square.grid.2x2.fill", appName: "Zoom")
                .tabItem { Label("Mail", systemImage: "square.grid.2x2.fill") }
            AwesomeZoomTabScreen(title: "Phone", icon: "square.grid.2x2.fill", appName: "Zoom")
                .tabItem { Label("Phone", systemImage: "square.grid.2x2.fill") }
            AwesomeZoomTabScreen(title: "More", icon: "square.grid.2x2.fill", appName: "Zoom")
                .tabItem { Label("More", systemImage: "square.grid.2x2.fill") }
        }
        .tint(ZoomTokens.zoomCanvas)
    }
}

private enum ZoomTokens {
        static let zoomCanvas = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let zoomSurface1 = Color(red: 0.176, green: 0.176, blue: 0.176) // #2D2D2D
        static let zoomSurface2 = Color(red: 0.227, green: 0.227, blue: 0.227) // #3A3A3A
        static let zoomDivider = Color(red: 0.227, green: 0.227, blue: 0.227) // #3A3A3A
        static let zoomLightCanvas = Color.white                                // #FFFFFF
        static let zoomLightSurface = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
        static let zoomLightDivider = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
        static let zoomTextPrimary = Color.white                                // #FFFFFF
        static let zoomTextSecondary = Color(red: 0.690, green: 0.690, blue: 0.690) // #B0B0B0
        static let zoomTextTertiary = Color(red: 0.478, green: 0.478, blue: 0.478) // #7A7A7A
        static let zoomBlue = Color(red: 0.176, green: 0.549, blue: 1.0)   // #2D8CFF
        static let zoomBluePressed = Color(red: 0.122, green: 0.435, blue: 0.800) // #1F6FCC
        static let zoomRed = Color(red: 0.878, green: 0.157, blue: 0.157) // #E02828
        static let zoomRedPressed = Color(red: 0.725, green: 0.122, blue: 0.122) // #B91F1F
        static let zoomHandYellow = Color(red: 0.961, green: 0.773, blue: 0.094) // #F5C518
        static let zoomSuccess = Color(red: 0.055, green: 0.541, blue: 0.271) // #0E8A45
}

private struct AwesomeZoomTabScreen: View {
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
            .background(ZoomTokens.zoomCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(ZoomTokens.zoomCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(ZoomTokens.zoomCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(ZoomTokens.zoomCanvas.opacity(0.12))
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

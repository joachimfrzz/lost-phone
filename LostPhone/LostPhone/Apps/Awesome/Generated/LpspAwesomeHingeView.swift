import SwiftUI

// Source: Meliwat/awesome-ios-design-md — hinge/DESIGN-swiftui.md
struct LpspAwesomeHingeView: View {
    var body: some View {
        TabView {
            AwesomeHingeTabScreen(title: "Discover", icon: "square.grid.2x2.fill", appName: "Hinge")
                .tabItem { Label("Discover", systemImage: "square.grid.2x2.fill") }
            AwesomeHingeTabScreen(title: "Likes You", icon: "square.grid.2x2.fill", appName: "Hinge")
                .tabItem { Label("Likes You", systemImage: "square.grid.2x2.fill") }
            AwesomeHingeTabScreen(title: "Standouts", icon: "square.grid.2x2.fill", appName: "Hinge")
                .tabItem { Label("Standouts", systemImage: "square.grid.2x2.fill") }
            AwesomeHingeTabScreen(title: "Matches", icon: "square.grid.2x2.fill", appName: "Hinge")
                .tabItem { Label("Matches", systemImage: "square.grid.2x2.fill") }
            AwesomeHingeTabScreen(title: "Profile", icon: "square.grid.2x2.fill", appName: "Hinge")
                .tabItem { Label("Profile", systemImage: "square.grid.2x2.fill") }
        }
        .tint(HingeTokens.hingeCream)
    }
}

private enum HingeTokens {
        static let hingeCream = Color(red: 0.992, green: 0.973, blue: 0.949) // #FDF8F2 canvas
        static let hingePaper = Color(red: 0.980, green: 0.965, blue: 0.941) // #FAF6F0 cards
        static let hingeSand = Color(red: 0.949, green: 0.922, blue: 0.878) // #F2EBE0 chips/inputs
        static let hingeSand2 = Color(red: 0.910, green: 0.875, blue: 0.816) // #E8DFD0 pressed
        static let hingeDividerBone = Color(red: 0.878, green: 0.839, blue: 0.773) // #E0D6C5
        static let hingeBlack = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A primary
        static let hingeBlackPressed = Color(red: 0.039, green: 0.039, blue: 0.039) // #0A0A0A
        static let hingeGraphite = Color(red: 0.290, green: 0.259, blue: 0.224) // #4A4239 secondary
        static let hingeStone = Color(red: 0.478, green: 0.447, blue: 0.408) // #7A7268 tertiary
        static let hingeBone = Color(red: 0.690, green: 0.659, blue: 0.612) // #B0A89C disabled
        static let hingeRose = Color(red: 0.910, green: 0.627, blue: 0.302) // #E8A04D
        static let hingeRoseDeep = Color(red: 0.773, green: 0.494, blue: 0.180) // #C57E2E pressed
        static let hingeRoseLight = Color(red: 0.961, green: 0.851, blue: 0.659) // #F5D9A8 halo
        static let hingeMatchGreen = Color(red: 0.176, green: 0.478, blue: 0.294) // #2D7A4B
        static let hingeWarning = Color(red: 0.847, green: 0.545, blue: 0.180) // #D88B2E
        static let hingeError = Color(red: 0.702, green: 0.227, blue: 0.184) // #B33A2F
        static let hingeInfo = Color(red: 0.353, green: 0.384, blue: 0.451) // #5A6273
        static let hingeDarkCanvas = Color(red: 0.086, green: 0.075, blue: 0.055) // #16130E
        static let hingeDarkSurface = Color(red: 0.118, green: 0.102, blue: 0.078) // #1E1A14
        static let hingeDarkSurface2 = Color(red: 0.165, green: 0.145, blue: 0.125) // #2A2520
        static let hingeDarkDivider = Color(red: 0.184, green: 0.165, blue: 0.133) // #2F2A22
        static let hingeDarkText = Color(red: 0.937, green: 0.910, blue: 0.855) // #EFE8DA
        static let hingeDarkTextSec = Color(red: 0.659, green: 0.620, blue: 0.557) // #A89E8E
        static let hingeRoseDark = Color(red: 0.941, green: 0.690, blue: 0.361) // #F0B05C OLED-brightened
}

private struct AwesomeHingeTabScreen: View {
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
            .background(HingeTokens.hingeDarkCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(HingeTokens.hingeDarkCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(HingeTokens.hingeCream)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(HingeTokens.hingeCream.opacity(0.12))
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

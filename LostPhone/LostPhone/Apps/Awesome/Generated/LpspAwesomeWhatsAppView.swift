import SwiftUI

// Source: Meliwat/awesome-ios-design-md — whatsapp/DESIGN-swiftui.md
struct LpspAwesomeWhatsAppView: View {
    var body: some View {
        TabView {
            AwesomeWhatsAppTabScreen(title: "Updates", icon: "circle.dashed", appName: "WhatsApp")
                .tabItem { Label("Updates", systemImage: "circle.dashed") }
            AwesomeWhatsAppTabScreen(title: "Calls", icon: "phone.fill", appName: "WhatsApp")
                .tabItem { Label("Calls", systemImage: "phone.fill") }
            AwesomeWhatsAppTabScreen(title: "Communities", icon: "person.3.fill", appName: "WhatsApp")
                .tabItem { Label("Communities", systemImage: "person.3.fill") }
            AwesomeWhatsAppTabScreen(title: "Chats", icon: "message.fill", appName: "WhatsApp")
                .tabItem { Label("Chats", systemImage: "message.fill") }
            AwesomeWhatsAppTabScreen(title: "Settings", icon: "gearshape.fill", appName: "WhatsApp")
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(WhatsAppTokens.waGreen)
    }
}

private enum WhatsAppTokens {
        static let waGreen = Color(red: 0.145, green: 0.827, blue: 0.400) // #25D366
        static let waGreenPressed = Color(red: 0.118, green: 0.745, blue: 0.365) // #1EBE5D
        static let waTeal = Color(red: 0.027, green: 0.369, blue: 0.329) // #075E54
        static let waMidTeal = Color(red: 0.071, green: 0.549, blue: 0.494) // #128C7E
        static let waDarkTeal = Color(red: 0.020, green: 0.302, blue: 0.267) // #054D44
        static let waOutgoingLight = Color(red: 0.851, green: 0.992, blue: 0.827) // #D9FDD3
        static let waOutgoingDark = Color(red: 0.000, green: 0.361, blue: 0.294) // #005C4B
        static let waIncomingLight = Color.white
        static let waIncomingDark = Color(red: 0.122, green: 0.173, blue: 0.204) // #1F2C34
        static let waWallpaperLight = Color(red: 0.925, green: 0.898, blue: 0.867) // #ECE5DD
        static let waWallpaperDark = Color(red: 0.043, green: 0.078, blue: 0.102) // #0B141A
        static let waCanvasLight = Color.white                                   // #FFFFFF
        static let waCanvasDark = Color(red: 0.067, green: 0.106, blue: 0.129) // #111B21
        static let waSurface1Light = Color(red: 0.969, green: 0.973, blue: 0.980) // #F7F8FA
        static let waSurface1Dark = Color(red: 0.125, green: 0.173, blue: 0.200) // #202C33
        static let waSurface2Dark = Color(red: 0.165, green: 0.224, blue: 0.259) // #2A3942
        static let waDividerLight = Color(red: 0.914, green: 0.929, blue: 0.937) // #E9EDEF
        static let waDividerDark = Color(red: 0.133, green: 0.176, blue: 0.204) // #222D34
        static let waTextPrimary = Color(red: 0.067, green: 0.106, blue: 0.129) // #111B21
        static let waTextSecondary = Color(red: 0.400, green: 0.467, blue: 0.506) // #667781
        static let waTextTertiary = Color(red: 0.525, green: 0.588, blue: 0.627) // #8696A0
        static let waTextPrimaryDark = Color(red: 0.914, green: 0.929, blue: 0.937) // #E9EDEF
        static let waTextSecondaryDark = Color(red: 0.525, green: 0.588, blue: 0.627) // #8696A0
        static let waReadBlue = Color(red: 0.325, green: 0.741, blue: 0.922) // #53BDEB
}

private struct AwesomeWhatsAppTabScreen: View {
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
            .background(WhatsAppTokens.waCanvasLight.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(WhatsAppTokens.waCanvasLight, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(WhatsAppTokens.waGreen)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(WhatsAppTokens.waGreen.opacity(0.12))
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

import SwiftUI

/// Point d'entrée Lost Phone — WhatsApp Custom (brief Studio P0).
struct LpspCustomWhatsAppRootView: View {
    var body: some View {
        WhatsAppRootView()
    }
}

struct WhatsAppRootView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            WhatsAppChatListView()
                .tabItem { Label("Discussions", systemImage: "message.fill") }
                .tag(0)

            WhatsAppCallsView()
                .tabItem { Label("Appels", systemImage: "phone.fill") }
                .tag(1)

            WhatsAppSettingsView()
                .tabItem { Label("Vous", systemImage: "gearshape.fill") }
                .tag(2)
        }
        .tint(WhatsAppTheme.accent)
    }
}

#Preview {
    LpspCustomWhatsAppRootView()
}

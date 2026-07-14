import SwiftUI

struct WhatsAppRootApp: View {
    @State private var selectedTab = 3

    var body: some View {
        TabView(selection: $selectedTab) {
            UpdateView()
                .preferredColorScheme(.light)
                .tag(0)
                .tabItem { Label("Updates", systemImage: "pencil.circle") }

            CallView()
                .preferredColorScheme(.light)
                .tag(1)
                .tabItem { Label("Calls", systemImage: "phone") }

            CommunitiesView()
                .preferredColorScheme(.light)
                .tag(2)
                .tabItem { Label("Communities", systemImage: "person.3") }

            ChatView()
                .preferredColorScheme(.dark)
                .tag(3)
                .tabItem { Label("Chats", systemImage: "bubble.left.and.bubble.right") }

            SettingView()
                .preferredColorScheme(.light)
                .tag(4)
                .tabItem { Label("Settings", systemImage: "gear.circle") }
        }
        .tint(Color.primaryColor)
    }
}

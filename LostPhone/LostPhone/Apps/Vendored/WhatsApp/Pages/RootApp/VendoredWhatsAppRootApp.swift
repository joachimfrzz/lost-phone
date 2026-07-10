//
//  VendoredWhatsAppRootApp.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 4/4/24.
//

import SwiftUI

struct VendoredWhatsAppRootApp: View {
    @State private var selectedTab = 3
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VendoredWhatsAppUpdateView()
                .preferredColorScheme(.light)
                .tag(0)
                .tabItem { Label("Updates", systemImage: "pencil.circle") }
            VendoredWhatsAppCallView()
                .preferredColorScheme(.light)
                .tag(1)
                .tabItem { Label("Calls", systemImage: "phone") }
            VendoredWhatsAppCommunitiesView()
                .preferredColorScheme(.light)
                .tag(2)
                .tabItem { Label("Communities", systemImage: "person.3") }
            VendoredWhatsAppChatView()
                .preferredColorScheme(.dark)
                .tag(3)
                .tabItem { Label("Chats", systemImage: "bubble.left.and.bubble.right") }
            VendoredWhatsAppSettingView()
                .preferredColorScheme(.light)
                .tag(4)
                .tabItem { Label("Settings", systemImage: "gear.circle") }
        }
        .tint(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
    }
}

#Preview {
    VendoredWhatsAppRootApp()
}

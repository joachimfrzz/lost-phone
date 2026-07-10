//
//  VendoredWhatsAppRootApp.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 4/4/24.
//

import SwiftUI

struct VendoredWhatsAppRootApp: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView {
            VendoredWhatsAppUpdateView()
                .tabItem {
                    VStack {
                        Image(systemName: "pencil.circle")
                        Text("Updates")
                    }
                }
            VendoredWhatsAppCallView()
                .tabItem {
                    VStack {
                        Image(systemName: "phone")
                        Text("Calls")
                    }
                }
            VendoredWhatsAppCommunitiesView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                        Text("Communities")
                    }
                }
            VendoredWhatsAppChatView()
                .tabItem {
                    VStack {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("Chats")
                    }
                }
            VendoredWhatsAppSettingView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear.circle")
                        Text("Settings")
                    }
                }
        }
    }
}

#Preview {
    VendoredWhatsAppRootApp()
}

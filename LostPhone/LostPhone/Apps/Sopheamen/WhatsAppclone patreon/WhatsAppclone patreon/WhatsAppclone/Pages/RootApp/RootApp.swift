//
//  RootApp.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 4/4/24.
//

import SwiftUI

struct RootApp: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView {
            UpdateView()
                .tabItem {
                    VStack {
                        Image(systemName: "pencil.circle")
                        Text("Updates")
                    }
                }
            CallView()
                .tabItem {
                    VStack {
                        Image(systemName: "phone")
                        Text("Calls")
                    }
                }
            CommunitiesView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                        Text("Communities")
                    }
                }
            ChatView()
                .tabItem {
                    VStack {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("Chats")
                    }
                }
            SettingView()
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
    RootApp()
}

//
//  VendoredSnapchatRootApp.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 23/5/24.


import SwiftUI

struct VendoredSnapchatRootApp: View {
    @State private var selectedIndex = 0
    var body: some View {
        
            TabView {
                VendoredSnapchatMapView()
                .tabItem {
                    VStack {
                        Image(selectedIndex == 0 ? "map_active_icon" : "map_icon")
                        Text("Map")
                    }
                }
                .onAppear { selectedIndex = 0 }
                .tag(0)
                
                VendoredSnapchatChatView()
                .tabItem {
                    VStack {
                        Image(selectedIndex == 1 ? "chat_active_icon" : "chat_icon")
                        Text("Chat")
                    }
                }
                .onAppear { selectedIndex = 1 }
                .tag(1)
                
                VendoredSnapchatCameraView()
                .tabItem {
                    VStack {
                        Image(selectedIndex == 2 ? "camera_active_icon" : "camera_icon")
                        Text("Camera")
                    }
                }
                .onAppear { selectedIndex = 2 }
                .tag(2)
                
                VendoredSnapchatStoriesView()
                .tabItem {
                    VStack {
                        Image(selectedIndex == 3 ? "stories_active_icon" : "stories_icon")
                        Text("Stories")
                    }
                }
                .onAppear { selectedIndex = 3 }
                .tag(3)
                
                VendoredSnapchatSpotlightView()
                .tabItem {
                    VStack {
                        Image(selectedIndex == 4 ? "play_active_icon" : "play_icon")
                        Text("Spotlight")
                    }
                }
                .onAppear { selectedIndex = 4 }
                .tag(4)
                
            }
            .tint(.white)
            .accentColor(.white)
        
        
          
    }
}

#Preview {
    VendoredSnapchatRootApp()
}

//
//  VendoredSnapchatRootApp.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 23/5/24.
//

import SwiftUI

struct VendoredSnapchatRootApp: View {
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            VendoredSnapchatMapView()
                .tabItem {
                    Image(selectedIndex == 0 ? "map_active_icon" : "map_icon")
                    Text("Map")
                }
                .tag(0)

            VendoredSnapchatChatView()
                .tabItem {
                    Image(selectedIndex == 1 ? "chat_active_icon" : "chat_icon")
                    Text("Chat")
                }
                .tag(1)

            VendoredSnapchatCameraView()
                .tabItem {
                    Image(selectedIndex == 2 ? "camera_active_icon" : "camera_icon")
                    Text("Camera")
                }
                .tag(2)

            VendoredSnapchatStoriesView()
                .tabItem {
                    Image(selectedIndex == 3 ? "stories_active_icon" : "stories_icon")
                    Text("Stories")
                }
                .tag(3)

            VendoredSnapchatSpotlightView()
                .tabItem {
                    Image(selectedIndex == 4 ? "play_active_icon" : "play_icon")
                    Text("Spotlight")
                }
                .tag(4)
        }
        .tint(.white)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    VendoredSnapchatRootApp()
}

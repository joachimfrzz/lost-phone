import SwiftUI

struct SnapchatRootApp: View {
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            MapView()
                .tabItem {
                    Image(selectedIndex == 0 ? "map_active_icon" : "map_icon")
                    Text("Map")
                }
                .tag(0)
                .onAppear { selectedIndex = 0 }

            ChatView()
                .tabItem {
                    Image(selectedIndex == 1 ? "chat_active_icon" : "chat_icon")
                    Text("Chat")
                }
                .tag(1)

            CameraView()
                .tabItem {
                    Image(selectedIndex == 2 ? "camera_active_icon" : "camera_icon")
                    Text("Camera")
                }
                .tag(2)

            StoriesView()
                .tabItem {
                    Image(selectedIndex == 3 ? "stories_active_icon" : "stories_icon")
                    Text("Stories")
                }
                .tag(3)

            SpotlightView()
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

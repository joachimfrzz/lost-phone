//
//  VendoredInstagramRootApp.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 8/3/24.
//

import SwiftUI

struct VendoredInstagramRootApp: View {
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            VendoredInstagramHomeView()
                .tabItem {
                    Image((selectedIndex == 0 || selectedIndex == 2) ? "home_active_icon" : "home_icon")
                    Text("Home")
                }
                .tag(0)

            VendoredInstagramSearchView()
                .tabItem {
                    Image(selectedIndex == 1 ? "search_active_icon" : "search_icon")
                    Text("Search")
                }
                .tag(1)

            VendoredInstagramHomeView()
                .tabItem {
                    Image("plus_icon")
                    Text("")
                }
                .tag(2)

            VendoredInstagramReelsView()
                .tabItem {
                    Image(selectedIndex == 3 ? "reels_white_icon" : "reels_icon")
                    Text("Reels")
                }
                .tag(3)

            VendoredInstagramProfileView()
                .tabItem {
                    Image(selectedIndex == 4 ? "account_active_icon" : "account_icon")
                    Text("Profile")
                }
                .tag(4)
        }
        .colorScheme(selectedIndex == 3 ? .dark : .light)
        .onChange(of: selectedIndex) { _, newValue in
            if newValue == 2 { selectedIndex = 0 }
        }
    }
}

#Preview {
    VendoredInstagramRootApp()
}

//
//  VendoredDisneyContentView.swift
//  DisneyPlus
//
//  Created by Goutham S on 05/07/22.
//

import SwiftUI

struct VendoredDisneyContentView: View {
    @State private var _selection = 0
    
    init() {
        UITabBar.appearance().barTintColor = .black
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().alpha = 0.97
    }
    
    var body: some View {
        TabView(selection: $_selection) {
            VendoredDisneyHomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)

            Text("Tab Content 2")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            Text("Tab Content 3")
                .tabItem {
                    Image(systemName: "icloud.and.arrow.down")
                    Text("Download")
                }
                .tag(2)
            
            Text("Tab Content 4")
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}


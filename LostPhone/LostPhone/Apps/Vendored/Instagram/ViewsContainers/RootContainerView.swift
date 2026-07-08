//
//  ContentView.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 03/04/21.
//

import SwiftUI

struct VendoredInstagramRootContainerView: View {
    @State private var selectedView = 0

    var body: some View {
        TabView(selection: $selectedView) {
            VendoredInstagramTimeLineContainerView()
                .tabItem {
                    selectedView == 0 ?
                        Image(systemName: "house.fill") : Image(systemName: "house")
                }
                .tag(0)
            VendoredInstagramSearchContainerView()
                .tabItem {
                    selectedView == 1 ? Image(systemName: "magnifyingglass") : Image(systemName: "magnifyingglass")
                }
                .tag(1)
            VendoredInstagramReelsContainerView()
                .tabItem {
                    selectedView == 2 ? Image(systemName: "film.fill") : Image(systemName: "film")
                }
                .tag(2)
            VendoredInstagramActivityContainerView()
                .tabItem {
                    selectedView == 3 ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                }
                .tag(3)
            VendoredInstagramProfileContainerView()
                .tabItem {
                    selectedView == 4 ? Image(systemName: "person.circle.fill") : Image(systemName: "person.circle")
                }
                .tag(4)
        }
    }
}


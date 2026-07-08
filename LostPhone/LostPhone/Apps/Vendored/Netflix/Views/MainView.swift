//
//  ContentView.swift
//  Notflix
//
//  Created by Quentin Eude on 07/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixMainView: View {
    @VendoredNetflixState public var selectedTab: Int = 0
    @VendoredNetflixState public var showSplashScreen: Bool = true

    init() {
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ZStack {
                    VendoredNetflixHomeView()
                }
                .tabItem {
                    Image(systemName: "house")
                    Text(L10n.Tab.home)
                }.tag(0)
                ZStack {
                    VendoredNetflixSearchView()
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text(L10n.Tab.search)
                }.tag(1)
            }
            .accentColor(.red)
            .font(.headline)
            .zIndex(0)
            if showSplashScreen {
                VendoredNetflixSplashscreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showSplashScreen = false
                        }
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
                .zIndex(1) //Workaround to ensure the transition is working both ways
            }
        }
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        VendoredNetflixMainView()
    }
}

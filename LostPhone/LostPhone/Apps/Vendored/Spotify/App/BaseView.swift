//
//  VendoredSpotifyBaseView.swift
//  SpotifyClone
//
//  Created by ladans on 24/08/25.
//

import SwiftUI

struct VendoredSpotifyBaseView: View {
    @State var selected: VendoredSpotifySpotifyTabItem = .home
    @State var showMenu: Bool = false
    @State var offset: CGFloat = 0
    @State var oldOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    /// Splash animation states
    @State var endAnimation = false
    @State var showTabBar = true
    @Namespace var animation
    @EnvironmentObject private var productStore: VendoredSpotifyProductStore
    
    var body: some View {
        GeometryReader { geometry in
            VendoredSpotifySplashView(
                logoSize: CGSize(width: 128, height: 128),
                endAnimation: $endAnimation,
                animation: animation,
            ) {
                HStack(spacing: .zero) {
                    VendoredSpotifySideMenu(showMenu: $showMenu, geometry: geometry)
                    
                    VendoredSpotifySpotifyTabView(
                        tabItems: VendoredSpotifySpotifyTabItem.allCases,
                        selected: $selected,
                        showTabBar: $showTabBar,
                    ) {
                        NavigationStack {
                            VendoredSpotifyHomeView(
                                endAnimation: $endAnimation,
                                animation: animation,
                            ) {
                                VendoredSpotifyLogo() {
                                    withAnimation {
                                        showMenu.toggle()
                                    }
                                }
                            }
                            .opacity(selected == .home ? 1 : 0)
                        }
                        
                        VendoredSpotifyReelView(
                            geometry: geometry,
                            showTabBar: $showTabBar,
                            selected: $selected,
                        )
                        .opacity(selected == .reels ? 1 : 0)
                        
                        VendoredSpotifySearchView()
                            .opacity(selected == .search ? 1 : 0)
                        
                        VendoredSpotifyPremiumView()
                            .opacity(selected == .premium ? 1 : 0)
                        
                        VendoredSpotifyCreateView()
                            .opacity(selected == .create ? 1 : 0)
                        
                        /// Workaround on leading menu drag start
                        Rectangle()
                            .fill(Color.black.opacity(0.001))
                            .frame(width: 16)
                    }
                    .sideMenuContentOverlay(
                        showMenu: $showMenu,
                        onReset: resetSideMenuState,
                    )
                }
                .padding(.bottom, geometry.safeAreaInsets.bottom)
                .sideMenuPreferences(
                    oldOffset: $oldOffset,
                    offset: $offset,
                    showMenu: showMenu,
                    onEnd: onEnd,
                    onChange: onChange,
                    gestureOffset: $gestureOffset,
                )
            } title: {
                Text("Spotify")
                    .font(.system(size: 36).bold())
                    .foregroundStyle(.spotifyWhite)
            } logo: {
                VendoredSpotifyLogo(onPressed: {})
            }
        }
    }
}

#Preview {
    VendoredSpotifyBaseView()
        .environmentObject(VendoredSpotifyProductStore())
        .environmentObject(VendoredSpotifyUserStore())
}

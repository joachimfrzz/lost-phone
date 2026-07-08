//
//  ViewWrapper.swift
//  SwiftUIClones
//
//  Created by ladans on 16/08/25.
//

import SwiftUI

struct VendoredSpotifyNativeTabView<LogoView: View>: View {
    @State var selected: VendoredSpotifySpotifyTabItem = .home
    @State var searchKey: String = ""
    @Binding var endAnimation: Bool
    var animation: Namespace.ID
    let geometry: GeometryProxy
    let logo: () -> LogoView
            
    var body: some View {
        NavigationStack {        
            TabView(selection: $selected) {
                Tab(
                    VendoredSpotifySpotifyTabItem.home.title,
                    systemImage: VendoredSpotifySpotifyTabItem.home.icon,
                    value: .home
                ) {
                    VendoredSpotifyHomeView(
                        endAnimation: $endAnimation,
                        animation: animation,
                        logo: logo
                    )
                }
                
                Tab(
                    VendoredSpotifySpotifyTabItem.reels.title,
                    systemImage: VendoredSpotifySpotifyTabItem.reels.icon,
                    value: .reels
                ) {
                    VendoredSpotifyReelView(
                        geometry: geometry,
                        showTabBar: .constant(true),
                        selected: .constant(.home),
                    )
                }
                
                Tab(
                    VendoredSpotifySpotifyTabItem.premium.title,
                    systemImage: VendoredSpotifySpotifyTabItem.premium.icon,
                    value: .premium
                ) {
                    VendoredSpotifyPremiumView()
                }
                
                Tab(
                    VendoredSpotifySpotifyTabItem.search.title,
                    systemImage: VendoredSpotifySpotifyTabItem.search.icon,
                    value: .search,
                    role: .search
                ) {
                    VendoredSpotifySearchView()
                        .navigationTitle("Search")
                        .searchable(text: $searchKey)
                        .toolbarColorScheme(.dark, for: .navigationBar)
                }
            }
            .accentColor(Color.spotifyGreen)
        }
    }
}

extension VendoredSpotifyNativeTabView {
    init(
        selected: VendoredSpotifySpotifyTabItem = .home,
        endAnimation: Binding<Bool>,
        animation: Namespace.ID,
        geometry: GeometryProxy,
        @ViewBuilder logo: @escaping () -> LogoView,
    ) {
        self._selected = State(initialValue: selected)
        self._endAnimation = endAnimation
        self.animation = animation
        self.logo = logo
        self.geometry = geometry
    }
}

#Preview {
    GeometryReader { geometry in
        VendoredSpotifyNativeTabView(
            selected: .home,
            endAnimation: .constant(false),
            animation: Namespace().wrappedValue,
            geometry: geometry,
        ) {
            VendoredSpotifyLogo(onPressed: {})
        }
        .environmentObject(VendoredSpotifyProductStore())
    }
}

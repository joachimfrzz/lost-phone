//
//  ViewWrapper.swift
//  SwiftUIClones
//
//  Created by ladans on 16/08/25.
//

import SwiftUI

struct VendoredSpotifySpotifyTabView<Content: View>: View {
    let tabItems: [VendoredSpotifySpotifyTabItem]
    @Binding var selected: VendoredSpotifySpotifyTabItem
    @Binding var showTabBar: Bool
    @ViewBuilder var content: () -> Content
    
    @Namespace var animation
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ZStack { ZStack(alignment: .leading, content: content) }
                    .frame(width: geometry.width)
                    .frame(maxHeight: .infinity)
                    .animation(nil, value: selected)
                    .ignoresSafeArea()
                
                if showTabBar || selected != .reels {
                    VendoredSpotifyTabBar(
                        animation: animation,
                        selected: $selected,
                        tabItems: tabItems,
                    )
                }
            }
            .background(Color.spotifyBlack.ignoresSafeArea())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showTabBar = false
                }
            }
        }
    }
}

#Preview {
    VendoredSpotifySpotifyTabView(
        tabItems: VendoredSpotifySpotifyTabItem.allCases,
        selected: .constant(.home),
        showTabBar: .constant(true)
    ) {
        Text("Screen")
            .foregroundStyle(.white)
    }
    .environmentObject(VendoredSpotifyProductStore())
}


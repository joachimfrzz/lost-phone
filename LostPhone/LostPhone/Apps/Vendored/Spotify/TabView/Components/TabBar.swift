//
//  VendoredSpotifyTabBar.swift
//  SpotifyClone
//
//  Created by ladans on 24/08/25.
//

import SwiftUI

struct VendoredSpotifyTabBar: View {
    let animation: Namespace.ID
    var selected: Binding<VendoredSpotifySpotifyTabItem>
    let tabItems: [VendoredSpotifySpotifyTabItem]
    
    var body: some View {
        Spacer()
            .frame(height: 70)
            .background(LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: .spotifyBlack.opacity(0.0), location: 0.0),
                        .init(color: .spotifyBlack.opacity(0.1), location: 0.1),
                        .init(color: .spotifyBlack.opacity(0.9), location: 0.8),
                        .init(color: .spotifyBlack.opacity(1), location: 0.9),
                        .init(color: .spotifyBlack.opacity(1), location: 1),
                    ],
                ),
                startPoint: .top,
                endPoint: .bottom,
            ))
            .blur(radius: 0.9)
            .shadow(color: .spotifyBlack, radius: 0.0)
            .overlay {
                HStack {
                    ForEach(tabItems, id: \.self) { tab in
                        VendoredSpotifyTabItem(
                            icon: tab.icon,
                            tab: tab,
                            animation: animation,
                            selected: selected
                        )
                        
                        if tab != VendoredSpotifySpotifyTabItem.allCases.last! {
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .ignoresSafeArea(.container, edges: .bottom)
            }
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        VendoredSpotifyTabBar(
            animation: Namespace().wrappedValue,
            selected: .constant(.home),
            tabItems: VendoredSpotifySpotifyTabItem.allCases,
        )
    }
    .frame(maxHeight: .infinity, alignment: .bottom)
    .background(Color.white.ignoresSafeArea())
}

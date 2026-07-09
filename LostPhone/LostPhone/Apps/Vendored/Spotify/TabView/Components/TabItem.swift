//
//  VendoredSpotifyTabItem.swift
//  SwiftUIClones
//
//  Created by ladans on 16/08/25.
//

import SwiftUI

struct VendoredSpotifyTabItem: View {
    var icon: String
    var tab: VendoredSpotifySpotifyTabItem
    var animation: Namespace.ID
    
    @Binding var selected: VendoredSpotifySpotifyTabItem
    @Environment(\.log) private var log

    var body: some View {
        VStack {
            Button {
                withAnimation { selected = tab }
                log("Selected: \(tab.title)")
            } label: {
                VStack {
                    ZStack {
                        VendoredSpotifyTabIndicator()
                            .fill(.clear)
                            .frame(width: 45, height: 6)
                        
                        if selected == tab {
                            VendoredSpotifyTabIndicator()
                                .fill(.spotifyGreen)
                                .frame(width: 45, height: 6)
                                .matchedGeometryEffect(id: "Tab_Change", in: animation)
                        }
                    }
                    .padding(.bottom, 6)
                    
                    Image(systemName: icon)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(selected == tab ? .spotifyGreen : .spotifyLightGrey)
                        .frame(width: 20, height: 20)
                    
                    Text(tab.title)
                        .font(.caption)
                        .foregroundStyle(selected == tab ? .spotifyWhite : .spotifyLightGrey)
                }
            }
        }
    }
}

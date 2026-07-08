//
//  SpotifyPlayingBar.swift
//  SwiftUIClones
//
//  Created by ladans on 15/08/25.
//

import SwiftUI

struct VendoredSpotifyNowPlayingControlBar: View {
    let product: VendoredSpotifyProduct
    
    @Environment(\.log) private var logger
    
    var body: some View {
        HStack {
            HStack(spacing: 24) {
                VendoredSpotifyNetworkImage(imageUrl: product.firstImage)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.spotifyLightGrey, lineWidth: 3)
                }
                .frame(width: 40, height: 50)
                
                Button {

                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 28))
                        .foregroundStyle(.spotifyLightGrey)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 28))
                        .foregroundStyle(.spotifyLightGrey)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18, weight: .light))
                        .foregroundStyle(.spotifyLightGrey)
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button {
                    
                } label: {
                    Image(systemName: "shuffle")
                        .font(.system(size: 28))
                        .foregroundStyle(.spotifyLightGrey)
                }
                
                Button {
                    
                } label: {
                    Circle()
                        .fill(.spotifyGreen)
                        .overlay {
                            Image(systemName: "play.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(.spotifyDarkGrey)
                        }
                        .frame(width: 45, height: 45)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
            .ignoresSafeArea()
        
        VendoredSpotifyNowPlayingControlBar(product: VendoredSpotifyProduct.mock)
    }
}

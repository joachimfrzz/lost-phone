//
//  SpotifyNowPlayingHeader.swift
//  SwiftUIClones
//
//  Created by ladans on 15/08/25.
//

import SwiftUI

struct VendoredSpotifyNowPlayingHeader: View {
    let product: VendoredSpotifyProduct
    
    var body: some View {
        VStack(spacing: 30) {
            VendoredSpotifyProductThumbnail(
                showBadge: true,
                product: product,
                largeSize: true,
            )
            .background(.spotifyDarkGrey)
            .frame(width: 74.w, height: 74.w)
            .clipped()
            
            VendoredSpotifyNowPlayingInfo(product: product)
        }
    }
}

#Preview {
    VendoredSpotifyNowPlayingHeader(product: VendoredSpotifyProduct.mock)
}

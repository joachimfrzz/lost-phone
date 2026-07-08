//
//  SpotifyRecentSectionView.swift
//  SwiftUIClones
//
//  Created by ladans on 13/08/25.
//

import SwiftUI

struct VendoredSpotifyRecentSectionView: View {
    let products: [VendoredSpotifyProduct]
    
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), alignment: .leading),
                GridItem(.flexible(), alignment: .leading),
            ],
            spacing: 10,
        ) {
            ForEach(products) { product in
                NavigationLink(
                    destination: VendoredSpotifyDetailView(product: product)
                ) {
                    VendoredSpotifyRecentTile(product: product)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    VendoredSpotifyRecentSectionView(
        products: (0..<8).map { _ in
            VendoredSpotifyProduct.mock
        }
    )
}

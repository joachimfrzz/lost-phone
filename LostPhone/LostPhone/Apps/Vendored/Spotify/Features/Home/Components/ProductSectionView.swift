//
//  VendoredSpotifyProductSectionView.swift
//  SwiftUIClones
//
//  Created by ladans on 13/08/25.
//

import SwiftUI

struct VendoredSpotifyProductSectionView: View {
    let section: String
    let products: [VendoredSpotifyProduct]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(section)
                .font(.system(size: 23, weight: .bold))
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    Spacer()
                        .frame(width: 0)
                    
                    ForEach(products.indices, id: \.self) { index in
                        let product = products[index]
                        
                        NavigationLink(
                            destination: VendoredSpotifyDetailView(product: product)
                        ) {
                            VendoredSpotifyProductCard(
                                product: product,
                                showBadge: index % 2 == 0,
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    VendoredSpotifyProductSectionView(
        section: "Section name", products: [
            VendoredSpotifyProduct.mock,
            VendoredSpotifyProduct.mock,
            VendoredSpotifyProduct.mock,
            VendoredSpotifyProduct.mock,
        ]
    )
}

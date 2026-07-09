//
//  SpotifyChoiceCard.swift
//  SwiftUIClones
//
//  Created by ladans on 14/08/25.
//

import SwiftUI

struct VendoredSpotifyChoiceCard: View {
    let product: VendoredSpotifyProduct
    
    @Environment(\.log) private var logg
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.spotifyDarkGrey)
            .overlay {
                HStack(spacing: 10) {
                    VendoredSpotifyNetworkImage(imageUrl: product.firstImage)
                        .background(.spotifyGrey)
                        .frame(width: 150)
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 8,
                                bottomLeadingRadius: 8,
                            ),
                        )
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Playlist")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 14))
                                
                                Text(product.title)
                                    .foregroundStyle(.spotifyWhite)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.spotifyLightGrey)
                            }
                        }
                        
                        Text(product.description)
                            .foregroundStyle(.gray)
                            .font(.system(size: 14, weight: .semibold))
                            .lineLimit(2)
                        
                        Spacer()
                            .frame(height: 2)
                        
                        HStack {
                            Button {
                                
                            } label: {
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 25))
                                    .foregroundStyle(.gray)
                            }
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Circle()
                                    .fill(.white.opacity(0.7))
                                    .frame(width: 35, height: 35)
                                    .overlay {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 18))
                                            .foregroundStyle(.spotifyDarkGrey)
                                    }
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.trailing, 24)
                    .padding(.bottom, 20)
                }
            }
            .frame(height: 170)
            .clipped()
    }
}

#Preview {
    VendoredSpotifyChoiceCard(product: VendoredSpotifyProduct.mock)
}

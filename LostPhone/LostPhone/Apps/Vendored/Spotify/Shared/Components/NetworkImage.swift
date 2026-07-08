//
//  ImageLoaderView.swift
//  SwiftUIPractice
//
//  Created by Developer on 02/07/25.
//

import SwiftUI

struct VendoredSpotifyNetworkImage: View {
    var resiizingMode: ContentMode = .fill
    var imageUrl: String = VendoredSpotifyConstants.randomImage
    var width: CGFloat = 55.0
    var height: CGFloat = 55.0
    var cornerRadius: CGFloat = 0

    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: resiizingMode)
                    case .failure:
                        Color.gray.opacity(0.2)
                    default:
                        ProgressView()
                    }
                }
                .allowsHitTesting(false)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .clipped()
    }
}

#Preview {
    VendoredSpotifyNetworkImage(cornerRadius: 30)
        .padding(40)
        .padding(.vertical, 60)
}

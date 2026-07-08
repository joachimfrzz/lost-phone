//
//  ImageLoaderView.swift
//  SwiftUIPractice
//
//  Created by Developer on 02/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

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
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resiizingMode)
                    .allowsHitTesting(false)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .clipped()
        
//        Rectangle()
//            .opacity(0.001)
//            .overlay {
//                AsyncImage(url: URL(string: imageUrl)) { image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                    
//                } placeholder: {
//                    ProgressView()
//                }
//                .frame(width: width, height: height)
//                .aspectRatio(contentMode: resiizingMode)
//                .allowsHitTesting(false)
//            }
//            .clipped()
    }
}

#Preview {
    VendoredSpotifyNetworkImage(cornerRadius: 30)
        .padding(40)
        .padding(.vertical, 60)
}

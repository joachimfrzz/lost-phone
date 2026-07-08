//
//  VendoredInstagramThumbnailImageView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 2/4/24.
//

import SwiftUI

struct VendoredInstagramThumbnailImageView: View {
    let videoURL: URL
    let width, height: CGFloat?
    @State private var thumbnailImage: UIImage?
    
    var body: some View {
        Group {
            if let thumbnailImage = thumbnailImage {
                Image(uiImage: thumbnailImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    
            } else {
                Rectangle()
                    .fill(Color.vendoredInstagramVendoredInstagramPrimary)
                    .frame(width: width, height: height)
                    .onAppear {
                        generateThumbnail(from: videoURL) { image in
                            self.thumbnailImage = image
                        }
                    }
            }
        }
    }
}

#Preview {
    VendoredInstagramThumbnailImageView(videoURL: URL(string: "https://player.vimeo.com/external/521787962.hd.mp4?s=c886caa69e529026d24607bfca3709cb8a14dde4&profile_id=174&oauth2_token_id=57447761")!,width: 140, height: 140)
}

//
//  VendoredInstagramPostGridView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 16/3/24.
//

import SwiftUI
import Kingfisher

struct VendoredInstagramPostGridView: View {

    let columns:[GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    let size = (UIScreen.main.bounds.width / 3) - 2
    

    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(postsData) { post in
                if let urlString = post.imageOrVideoUrl.first, let url = URL(string: urlString) {
                    
                    if(post.postType == 1){
                        NavigationLink(destination: VendoredInstagramPostView(
                            profileImageUrl: vendoredInstagramUserDataCurrent.profileImage,
                            username: vendoredInstagramUserDataCurrent.username,
                            postImages: post.imageOrVideoUrl,
                            caption: post.caption ?? "",
                            totalLikes: post.totalLikes,
                            totalComments: post.totalComments,
                            postType: post.postType
                        ).hideTabBar()) {
                            if(post.imageOrVideoUrl.count > 1){
                                ZStack (alignment: .topTrailing){
                                    KFImage(url)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: size, height: size)
                                        .clipped()
                                    
                                    Image("photo_collection_icon")
                                        .padding(.all, 10)
                                        
                                }
                               
                            }else {
                                KFImage(url)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: size, height: size)
                                    .clipped()
                            }
                        }
                        .buttonStyle(.plain)
                        
                    }else {
                        NavigationLink(destination: VendoredInstagramPostView(
                            profileImageUrl: vendoredInstagramUserDataCurrent.profileImage,
                            username: vendoredInstagramUserDataCurrent.username,
                            postImages: post.imageOrVideoUrl,
                            caption: post.caption ?? "",
                            totalLikes: post.totalLikes,
                            totalComments: post.totalComments,
                            postType: post.postType
                        ).hideTabBar()) {
                            ZStack (alignment: .topTrailing){
                                VendoredInstagramThumbnailImageView(videoURL: URL(string: urlString)!,width: size, height: size)
                                Image("reels_white_icon")
                                    .padding(.all, 10)
                                    
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
   
}

#Preview {
    VendoredInstagramPostGridView()
}


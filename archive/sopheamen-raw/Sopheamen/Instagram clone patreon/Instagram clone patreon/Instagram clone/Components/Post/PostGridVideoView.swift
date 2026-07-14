//
//  PostGridVideoView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 1/4/24.
//
import SwiftUI
import Kingfisher

struct PostGridVideoView: View {

    let columns:[GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    let size = ((UIScreen.main.bounds.width + 10) / 3)
    

    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(postsData) { post in
                if let urlString = post.imageOrVideoUrl.first {
                    
                    if(post.postType == 2){
                        ZStack (alignment: .topTrailing){
                            ThumbnailImageView(videoURL: URL(string: urlString)!,width: size, height: size)
                            Image("reels_white_icon")
                                .padding(.all, 10)
                                
                        }
                        
                    }else {
                       EmptyView()
                    }
                }
                
                
               
                
            }
        }
    }
}

#Preview {
    PostGridVideoView()
}


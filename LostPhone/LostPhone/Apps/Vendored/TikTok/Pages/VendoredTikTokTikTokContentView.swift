//
//  VendoredTikTokTikTokContentView.swift
//  Youtube_Tiktok
//
//  Created by Sopheamen VAN on 11/10/24.
//

import SwiftUI
// import image network lib cache
import Kingfisher
import AVKit

struct VendoredTikTokTikTokContentView: View {
    // load one example record from feed model
    var feed: VendoredTikTokFeedResponse
    // for video player later
    var player: AVPlayer
    
    init(feed: VendoredTikTokFeedResponse, player: AVPlayer) {
        self.feed = feed
        self.player = player
    }
    
    var body: some View {
        ZStack {
            // video player
            VendoredTikTokCustomVideoPlayer(player: player)
                .containerRelativeFrame([.horizontal,.vertical])
            // content info
            VendoredTikTokContentInfoView(feed: feed)
        }
    }
}

#Preview {
    VendoredTikTokTikTokContentView(feed: feedForYouData[0], player: AVPlayer())
}

struct VendoredTikTokContentInfoView:View {
    var feed: VendoredTikTokFeedResponse
    var body: some View {
        VStack {
            // push content to bottom by using spacer
            Spacer()
            
            // left content name, and caption
            // right content profile, and icons
            HStack (alignment: .bottom){
                // name and caption
                VStack(alignment: .leading, spacing: 4){
                    Text(feed.fullName)
                        .font(.headline)
                       
                    Text(feed.caption)
                        .font(.subheadline)
                        
                }
                // set to all text as white
                .foregroundStyle(.white)
                
                Spacer()
                
                // profile and icons
                VStack (spacing: 24){
                    // profile with plus icon
                    ZStack (alignment: .bottom){
                        // music cover url
                        KFImage(URL(string: feed.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white))
                        // plus icon
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.vendoredTikTokIsLikedColor)
                            .background(.white)
                            .clipShape(Circle())
                            .offset(x: 0, y: 6)
                    }
                    .padding(.bottom, 20)
                    
                    
                    // like button
                    Button {
                        
                    }label: {
                        VStack (spacing:2){
                            VendoredTikTokTikTokIconView(icon: .heart, color: feed.isLiked ? Color.vendoredTikTokIsLikedColor : .white)
                            Text(feed.totalLikes)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                    // comment button
                    Button {
                        
                    }label: {
                        VStack (spacing:2){
                            VendoredTikTokTikTokIconView(icon: .comment, color: .white)
                            Text(feed.totalComments)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                    // saved button
                    Button {
                        
                    }label: {
                        VStack (spacing:2){
                            VendoredTikTokTikTokIconView(icon: .saved, size: 26,color: feed.isSaved ? Color.vendoredTikTokIsSavedColor :  .white)
                            Text(feed.totalSaved)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                    // repost button
                    Button {
                        
                    }label: {
                        VStack (spacing:2){
                            VendoredTikTokTikTokIconView(icon: .repost,size: 26 ,color: .white)
                            Text(feed.totalReposts)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                    // music cover url
                    KFImage(URL(string: feed.musicCoverUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
    }
}

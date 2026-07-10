//
//  VendoredTikTokTikTokView.swift
//  Youtube_Tiktok
//
//  Created by Sopheamen VAN on 11/10/24.
//

import SwiftUI
import AVKit

struct VendoredTikTokTikTokView: View {
    // load feed records
    var feedData: [VendoredTikTokFeedResponse] = feedForYouData
    
    // set state player to control the video player
    @State private var player = AVPlayer()
    // need another to control scrollposition
    @State private var scrollPosition: String?
    
    var body: some View {
        
        // main content for scrolling
        NavigationStack {
            ZStack (alignment: .top){
                // content scroll
                ScrollView (showsIndicators: false){
                    LazyVStack (spacing:0){
                        ForEach(feedData) { feed in
                            VendoredTikTokTikTokContentView(feed: feed, player: player)
                                .id(feed.id)
                                .onAppear {
                                    playInitVideoIfNecessary()
                                }
                            
                        }
                    }
                    // set scroll target to control scrol
                    .scrollTargetLayout()
                }
                // set option of scroll ability and same like tiktok
                .onAppear {
                    player.play()
                }
                .scrollPosition(id: $scrollPosition)
                .scrollTargetBehavior(.paging)
                .ignoresSafeArea()
                .onChange(of: scrollPosition) { feedId, newValue in
                    playVideoOnChangeOfScrollPosition(feedId: newValue)
                }
                
                // tab and search view
                VendoredTikTokTabViewAndSearchView()
            }
           
        }
    }
    
    // now set two functions to control the video
    func playInitVideoIfNecessary() {
        guard scrollPosition == nil,
              let post = feedForYouData.first,
              player.currentItem == nil else { return }
        let item = AVPlayerItem(url: URL(string: post.videoUrl)!)
        player.replaceCurrentItem(with: item)
    }
    
    func playVideoOnChangeOfScrollPosition(feedId: String?) {
        guard let currentPost = feedForYouData.first(where: { $0.id == feedId }) else { return }
        
        player.replaceCurrentItem(with: nil)
        let playerItem = AVPlayerItem(url: URL(string: currentPost.videoUrl)!)
        player.replaceCurrentItem(with: playerItem)
    }
    
}

#Preview {
    VendoredTikTokTikTokView()
}

struct VendoredTikTokTabViewAndSearchView:View {
    var body: some View {
        HStack {
            NavigationLink(destination: VendoredTikTokProfileView(feed: feedForYouData[0])) {
                Image(systemName: "person.crop.circle")
                    .font(.title3)
                    .foregroundStyle(.white)
            }
            Spacer()
            HStack (alignment: .top, spacing: 20){
                Text("Following")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.7))
                
                VStack (spacing: 6){
                    Text("For You")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Rectangle()
                        .fill(.white)
                        .frame(width: 30)
                        .frame(height: 2)
                }
            }
            Spacer()
            // search
            Button {
                
            }label: {
                VendoredTikTokTikTokIconView(icon: .search, size:24, color: .white)
            }
        }
        .padding(.horizontal)
    }
}

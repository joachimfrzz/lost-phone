//
//  VendoredInstagramReelsView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 20/3/24.
//

import SwiftUI
import AVKit

struct VendoredInstagramReelsView: View {
    var reelDatas:[VendoredInstagramReelsResponse] = vendoredInstagramReelsData
    @State private var scrollPosition: String?
    @State private var player = AVPlayer()
    
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false){
                LazyVStack(spacing: 0){
                    ForEach (reelDatas) { reels in
                        VendoredInstagramReelsVideoView(reels: reels, player: player)
                            .id(reels.id)
                            .onAppear { playInitVideoIfNecessary() }
                        
                    }
                }
                .scrollTargetLayout()
            }
            .onAppear { player.play() }
            .scrollPosition(id: $scrollPosition)
            .scrollTargetBehavior(.paging)
            .ignoresSafeArea()
            .onChange(of: scrollPosition) { oldValue, newValue in
                playVideoOnChangeOfScrollPosition(postId: newValue)
            }
            
        }
        
    }
    
    func playInitVideoIfNecessary() {
        guard scrollPosition == nil,
              let post = reelDatas.first,
              player.currentItem == nil else { return }
        let item = AVPlayerItem(url: URL(string: post.videoUrl)!)
        player.replaceCurrentItem(with: item)
    }
    
    func playVideoOnChangeOfScrollPosition(postId: String?) {
        guard let currentPost = reelDatas.first(where: { $0.id == postId }) else { return }
        
        player.replaceCurrentItem(with: nil)
        let playerItem = AVPlayerItem(url: URL(string: currentPost.videoUrl)!)
        player.replaceCurrentItem(with: playerItem)
    }
}

#Preview {
    VendoredInstagramReelsView()
}




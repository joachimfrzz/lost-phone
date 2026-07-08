//
//  ReelController.swift
//  SpotifySwiftUI
//
//  Created by ladans on 29/08/25.
//

import SwiftUI
import AVKit

extension VendoredSpotifyVideoPlayer {
    func playPause(_ rect: CGRect, tab: VendoredSpotifySpotifyTabItem? = nil) {
        guard tab == .reels else {
            player?.pause()
            player?.seek(to: .zero)
            return
        }
        
        if -rect.minY < (rect.height * 0.5) && rect.minY < (rect.height * 0.5) {
            player?.play()
        } else {
            player?.pause()
        }
        
        if rect.minY >= rect.height || -rect.minY >= rect.height {
            player?.seek(to: .zero)
        }
    }
    
    func onDoubleTapGesture(_ position: CGPoint) {
        let id = UUID()
        
        likedCounter.append(.init(id: id, tappedRect: position, isAnimated: false))
        
        withAnimation(
            .snappy(duration: 1.2),
            completionCriteria: .logicallyComplete
        ) {
            if let index = likedCounter.firstIndex(where: { $0.id == id }) {
                likedCounter[index].isAnimated = true
            }
        } completion: {
            likedCounter.removeAll(where: { $0.id == id })
        }
        
        reel.isLiked = true
    }
    
    func onTapGesture(_ position: CGPoint) {
        withAnimation(.easeInOut) {
            showTabBar = true
            
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 3.0
            ) {
                showTabBar = false
            }
        }
    }
    
    func onAppear() {
        guard player == nil else { return }
        guard let bundleID = Bundle.main.path(
            forResource: reel.videoID, ofType: "mp4"
        ) else {
            return
        }
        let videoURL = URL(filePath: bundleID)
        
        let playerItem = AVPlayerItem(url: videoURL)
        let queue = AVQueuePlayer(playerItem: playerItem)
        looper = AVPlayerLooper(player: queue, templateItem: playerItem)
        
        player = queue
    }
    
    func onDisapear() {
        player = nil
    }
}

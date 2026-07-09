//
//  VendoredYouTubeMusicPlayerManager.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 5/9/24.
//
// for music player
import SwiftUI
import AVFoundation
import Combine

class VendoredYouTubeMusicPlayerManager: ObservableObject {
    private var player: AVPlayer?
    private var playerItemObserver: NSKeyValueObservation?
    private var timer: Timer?
    @Published var isPlaying: Bool = false
    @Published var currentTime: Double = 0
    @Published var totalDuration: Double = 0
    
    func playMusic(from url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        playerItemObserver = playerItem.observe(\.status, options: [.new, .old]) { [weak self] item, _ in
            guard let self = self else { return }
            if item.status == .readyToPlay {
                self.updateTotalDuration()
            }
        }
        
        player?.play()
        isPlaying = true
        
        startTimer()
    }
    
    func pauseMusic() {
        player?.pause()
        isPlaying = false
    }
    
    func stopMusic() {
        player?.pause()
        player?.seek(to: .zero)
        isPlaying = false
        currentTime = 0
        timer?.invalidate()
        timer = nil
    }
    
    private func updateTotalDuration() {
        DispatchQueue.main.async {
            if let duration = self.player?.currentItem?.duration {
                self.totalDuration = duration.seconds
            }
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player else {
                print("Error: Player is not available.")
                return
            }
            
            self.currentTime = player.currentTime().seconds
            
            if self.currentTime >= self.totalDuration {
                self.stopMusic()
            }
        }
    }
    
    deinit {
        playerItemObserver?.invalidate()
    }
}



















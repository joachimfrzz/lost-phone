//
//  VendoredYouTubeMusicAudioProgressView.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 4/9/24.
//

import SwiftUI

struct VendoredYouTubeMusicAudioProgressView: View {
    @ObservedObject var playerManager: VendoredYouTubeMusicPlayerManager

    var body: some View {
        VStack(spacing: 5) {
            VendoredYouTubeMusicCustomSlider(value: $playerManager.currentTime, range: 0...playerManager.totalDuration, thumbSize: 15, trackHeight: 3)
                .animation(.linear(duration: 0.1), value: playerManager.currentTime)
                .onAppear {
                    print("VendoredYouTubeMusicAudioProgressView appeared with totalDuration: \(playerManager.totalDuration) and currentTime: \(playerManager.currentTime)")
                }

            HStack {
                Text(formatTime(seconds: playerManager.currentTime))
                    .font(.caption)
                    .foregroundColor(.gray)

                Spacer()

                Text(formatTime(seconds: playerManager.totalDuration))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 40)
    }

    func formatTime(seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}


// customer slider view

struct VendoredYouTubeMusicCustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let thumbSize: CGFloat
    let trackHeight: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.6))
                    .frame(height: trackHeight)
                
                Capsule()
                    .fill(Color.white)
                    .frame(width: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * geometry.size.width, height: trackHeight)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: thumbOffset(geometry: geometry))
                    .gesture(
                        DragGesture()
                            .onChanged { dragValue in
                                let sliderWidth = geometry.size.width
                                let newValue = (dragValue.location.x / sliderWidth) * (range.upperBound - range.lowerBound) + range.lowerBound
                                value = min(max(range.lowerBound, newValue), range.upperBound)
                            }
                    )
            }
        }
        .frame(height: thumbSize)
    }
    
    private func thumbOffset(geometry: GeometryProxy) -> CGFloat {
        let sliderWidth = geometry.size.width
        let relativeValue = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
        return relativeValue * sliderWidth - thumbSize / 2
    }
}








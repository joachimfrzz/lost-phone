//
//  ReelDetailView.swift
//  SpotifySwiftUI
//
//  Created by ladans on 29/08/25.
//

import SwiftUI

struct VendoredSpotifyReelDetail: View {
    let geometry: GeometryProxy
    @Binding var reel: VendoredSpotifyReel
    let onMessage: () -> Void
    let onPaperplane: () -> Void
        
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    
                    Text(reel.authorName)
                        .font(.caption)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt")
                    .font(.caption)
                    .foregroundStyle(.spotifyLightGrey)
                    .lineLimit(2)
                    .clipped()
            }
            
            Spacer(minLength: 0)
            
            VStack(spacing: 25) {
                Button("", systemImage: reel.isLiked ? "suit.heart.fill" : "suit.heart") {
                    reel.isLiked.toggle()
                }
                .symbolEffect(.bounce, value: reel.isLiked)
                .foregroundStyle(reel.isLiked ? .red : .spotifyWhite)
                
                Button("", systemImage: "message", action: onMessage)
                
                Button("", systemImage: "paperplane", action: onPaperplane)
                
                Button("", systemImage: "ellipsis") {}
            }
            .font(.title3)
            .foregroundStyle(.spotifyWhite)
        }
        .padding(.leading, 15)
        .padding(.trailing, 10)
        .padding(.bottom, geometry.safeAreaInsets.bottom + 10)
    }
}

//
//  VendoredYouTubeVideoShortsView.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 17/10/24.
//

import SwiftUI

struct VendoredYouTubeVideoShortsView:View {
    var video: VendoredYouTubeVideoResponse
    var body: some View {
        ZStack (alignment: .bottom){
            // thnumbnail
            Image(video.thumbnailUrl)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 240)
            // black overlay
            Rectangle()
                .fill(.black.opacity(0.1))
                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 240)
                .clipped()
            // title
            Text(video.title)
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 8)
                .lineLimit(2)
                .lineSpacing(-10)
                .frame(width: UIScreen.main.bounds.width / 2 - 20)
                .multilineTextAlignment(.leading)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 4)
    }
}

#Preview {
    VendoredYouTubeVideoShortsView(video: videoSection2Data[0])
}

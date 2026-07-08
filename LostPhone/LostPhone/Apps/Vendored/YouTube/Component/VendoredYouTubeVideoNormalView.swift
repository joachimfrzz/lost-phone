//
//  VendoredYouTubeVideoNormalView.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 17/10/24.
//

import SwiftUI
import Kingfisher

struct VendoredYouTubeVideoNormalView:View {
    var video:VendoredYouTubeVideoResponse
    var body: some View {
        VStack (spacing: 22){
            // thumbnail and duration
            ZStack (alignment: .bottomTrailing){
                Image(video.thumbnailUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                // duration
                Text(video.duration)
                    .font(.footnote)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.grayButtonColor.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 12)
                    .foregroundStyle(.white)
            }
            // content info
            HStack (alignment: .top){
                // channel image url
                KFImage(URL(string: video.channelImgUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 46, height: 46)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white.opacity(0.5)))
                    .padding(.top, 5)
                // title
                // view and date
                VStack (alignment: .leading){
                    Text(video.title)
                        .font(.headline)
                        .fontWeight(.regular)
                        .lineLimit(2)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    Text("\(video.channelName) - \(video.totalViews) - \(video.publishedAt)")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2)
                }
                Spacer()
                // icon
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .padding(.top, 12)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal)
        }
        .preferredColorScheme(.dark)
    }
}
#Preview {
    VendoredYouTubeVideoNormalView(video: videoSection1Data[0])
}

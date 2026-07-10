//
//  VendoredYouTubeShortsDetailView.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 17/10/24.
//

import SwiftUI
import Kingfisher

struct VendoredYouTubeShortsDetailView: View {
    var video:VendoredYouTubeVideoResponse
    var body: some View {
        NavigationStack {
            ZStack {
                // video player
                // load video player here
                VendoredYouTubeCustomVideoPlayer(videoFileName: video.videoUrl)
                    .ignoresSafeArea()
                // content info
                VStack {
                    // header
                    VendoredYouTubeHeaderView()
                    Spacer()
                    VendoredYouTubeContentShortsInfoView(video: video)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    VendoredYouTubeShortsDetailView(video: videoSection2Data[0])
}

struct VendoredYouTubeHeaderView:View {
    // trigger back button
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            // back button
            Button {
                dismiss()
            }label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 11, height: 11)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            HStack (spacing:30){
                Button {
                    
                }label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 21, height: 21)
                        .foregroundStyle(.white)
                }
                
                Button {
                    
                }label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 4, height: 4)
                        .foregroundStyle(.white)
                        .rotationEffect(.degrees(90))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct VendoredYouTubeContentShortsInfoView:View {
    var video:VendoredYouTubeVideoResponse
    var body: some View {
        HStack (alignment: .bottom){
            // left content
            VendoredYouTubeLeftContentView(video: video)
            Spacer()
            // right content
            VendoredYouTubeRightContentView(video: video)
        }
        .padding()
    }
}

struct VendoredYouTubeLeftContentView:View {
    var video:VendoredYouTubeVideoResponse
    var body: some View {
        VStack {
            // section 1
            HStack (spacing:12){
                KFImage(URL(string: video.channelImgUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white.opacity(0.5)))
                // name
                Text(video.channelName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                // subscribe button
                Button {
                    
                }label: {
                    Text("Subscribe")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // section 2
            Text(video.title)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct VendoredYouTubeRightContentView:View {
    var video:VendoredYouTubeVideoResponse
    var body: some View {
        VStack (spacing:30){
            // like button
            Button {
                
            }label: {
                VStack {
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(video.totallyLiked)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
            }
            // dislike button
            Button {
                
            }label: {
                VStack {
                    Image(systemName: "hand.thumbsdown.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Dislike")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
            }
            // comment button
            Button {
                
            }label: {
                VStack {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(video.totalcomments)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
            }
            // share button
            Button {
                
            }label: {
                VStack {
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Share")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
            }
            // repost button
            Button {
                
            }label: {
                VStack {
                    Image(systemName: "repeat")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Repost")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
            }
           // music cover
            KFImage(URL(string: video.channelImgUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

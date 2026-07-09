//
//  ShortsDetailView.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 17/10/24.
//

import SwiftUI
import Kingfisher

struct ShortsDetailView: View {
    var video:VideoResponse
    var body: some View {
        NavigationStack {
            ZStack {
                // video player
                // load video player here
                CustomVideoPlayer(videoFileName: video.videoUrl)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                // content info
                VStack {
                    // header
                    HeaderView()
                    Spacer()
                    ContentShortsInfoView(video: video)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ShortsDetailView(video: videoSection2Data[0])
}

struct HeaderView:View {
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

struct ContentShortsInfoView:View {
    var video:VideoResponse
    var body: some View {
        HStack (alignment: .bottom){
            // left content
            LeftContentView(video: video)
            Spacer()
            // right content
            RightContentView(video: video)
        }
        .padding()
    }
}

struct LeftContentView:View {
    var video:VideoResponse
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

struct RightContentView:View {
    var video:VideoResponse
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

//
//  VendoredYouTubeVideoDetailView.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 17/10/24.
//

import SwiftUI
import Kingfisher

struct VendoredYouTubeVideoDetailView: View {
    // trigger back button
    @Environment(\.dismiss) var dismiss
    var video:VendoredYouTubeVideoResponse
    // load videos
    var videos:[VendoredYouTubeVideoResponse] = videoSection3Data
    var body: some View {
        NavigationStack {
            ZStack (alignment: .top){
                // content info
                ScrollView {
                    VStack (spacing: 12){
                        // content info
                        VendoredYouTubeContentInfoView(video: video)
                        // list normal video related video
                        LazyVStack (spacing:32){
                            ForEach(videos) { video in
                                VendoredYouTubeVideoNormalView(video: video)
                            }
                        }
                    }
                }
                .padding(.top, 220)
                // video thnumnail
                ZStack (alignment: .topLeading){
                    // load the actual video player
                    VendoredYouTubeCustomVideoPlayer(videoFileName: video.videoUrl)
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                        .allowsHitTesting(false)
                    // back button
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(.white)
                    }
                    .padding()
                }
                
            }
            // hide default back button
            .navigationBarBackButtonHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    VendoredYouTubeVideoDetailView(video: videoSection1Data[0])
}

struct VendoredYouTubeContentInfoView:View {
    var video:VendoredYouTubeVideoResponse
    var body: some View {
        VStack (spacing:14){
            VStack (spacing: 8){
                // title
                Text(video.title)
                    .font(.title3)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white)
                // total view and date
                HStack {
                    Text("\(video.totalViews) \(video.publishedAt)")
                      
                        .foregroundStyle(.white.opacity(0.7))
                    Text("... more")
                      
                }
                .font(.subheadline)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            // channel info
            HStack {
                HStack {
                    // profile
                    KFImage(URL(string: video.channelImgUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.white.opacity(0.5)))
                        .padding(.trailing, 4)
                    // channel name
                    Text(video.channelName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    // subscriber total
                    Text(video.channelsubscribers)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.white.opacity(0.7))
                }
                Spacer()
                
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "bell")
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 6, height: 6)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Color.grayButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                }
            }
            
            // action button
            VendoredYouTubeActionButtonsView(video: video)
            
            // last comment
            VendoredYouTubeLastCommentView(video: video)
        }
        .padding()
    }
}

struct VendoredYouTubeActionButtonsView:View {
    var video:VendoredYouTubeVideoResponse
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                // like and dislike
                Button {
                    
                }label: {
                    HStack (spacing:10){
                        Image(systemName: "hand.thumbsup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text(video.totallyLiked)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Rectangle()
                            .fill(.white.opacity(0.4))
                            .frame(width: 1, height: 22)
                            .padding(.horizontal, 2)
                        Image(systemName: "hand.thumbsdown")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.grayButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                }
                // share
                Button {
                    
                }label: {
                    HStack (spacing:10){
                        Image(systemName: "arrowshape.turn.up.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                        Text("Share")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.grayButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                }
                
                // remix
                Button {
                    
                }label: {
                    HStack (spacing:10){
                        Image(systemName: "arrow.3.trianglepath")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Remix")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.grayButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                }
                
                // download
                Button {
                    
                }label: {
                    HStack (spacing:10){
                        Image(systemName: "arrow.down.to.line")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12, height: 12)
                        Text("Download")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.grayButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                }
                
                // clip
                Button {
                    
                }label: {
                    HStack (spacing:10){
                        Image(systemName: "scissors")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                        Text("Clip")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.grayButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                }
                
                // save
                Button {
                    
                }label: {
                    HStack (spacing:10){
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12, height: 12)
                        Text("Save")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.grayButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                }
                
                // report
                Button {
                    
                }label: {
                    HStack (spacing:10){
                        Image(systemName: "flag")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Report")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.grayButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

struct VendoredYouTubeLastCommentView:View {
    var video:VendoredYouTubeVideoResponse
    var body: some View {
        VStack (spacing:8){
            // total comment
            HStack (spacing:5){
                Text("Comments")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(video.totalcomments)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // commenter
            HStack {
                KFImage(URL(string: video.lastcommentImgUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white.opacity(0.2)))
                Text(video.lastcommentString)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.grayButtonColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

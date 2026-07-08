//
//  ReelsVideo.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 20/3/24.
//

import SwiftUI
import AVKit
import Kingfisher

struct VendoredInstagramReelsVideoView: View {
    let reels: VendoredInstagramReelsResponse
    var player: AVPlayer
    
    init(reels: VendoredInstagramReelsResponse, player: AVPlayer) {
        self.reels = reels
        self.player = player
    }
    
    var body: some View {
      
            ZStack {
                
                VendoredInstagramCustomVideoPlayer(player: player)
                    .containerRelativeFrame([.horizontal,.vertical])
                VStack {
                    Spacer()
                       
                    HStack (alignment:.bottom){
                        
                        // profile and caption
                        VStack (alignment: .leading, spacing: 8){
                            HStack (spacing: 10){
                                
                                VendoredInstagramProfileImageView(profileImage: reels.user.profileImage, size: 40)
                                
                                Text(reels.user.username)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Button {
                                    
                                } label: {
                                    Text("Follow")
                                        .font(.footnote)
                                        
                                }
                                .frame(width: 60,height: 25)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white))
                                
                            }
                            .foregroundStyle(.white)
                            
                            // caption
                            Text(reels.caption ?? "")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                            
                            // song section
                            HStack {
                                Image("music_note_icon")
                                    .resizable()
                                    .frame(width: 18,height: 18)
                                   
                                Text(reels.song.ownerName+" - " + reels.song.songName)
                                    .foregroundStyle(.white)
                                    .font(.footnote)
                            }

                            
                        }
                        
                        Spacer()
                        
                        VStack (spacing: 30){
                            
                         
                            Button {
                                
                            } label: {
                                VStack (spacing: 3){
                                    Image("like_white_icon")
                                       .resizable()
                                       .frame(width: 28,height: 28)
                                       
                                    
                                    Text("\(reels.totalLikes)k")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                        .bold()
                                }
                                
                            }
                            
                            Button {
                                
                            } label: {
                                VStack(spacing: 3){
                                    Image("comment_white_icon")
                                       .resizable()
                                       .frame(width: 28,height: 28)
                                       .foregroundStyle(.white)
                                    
                                    Text("\(reels.totalComments)k")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                        .bold()
                                }
                            }
                            
                            Button {
                                
                            } label: {
                                VStack(spacing: 3){
                                    Image("send_message_white_icon")
                                       .resizable()
                                       .frame(width: 28,height: 28)
                                       .foregroundStyle(.white)
                                    
                                    Text("\(reels.totalShares)k")
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                        .bold()
                                }
                                
                                
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22,height: 22)
                                    .foregroundColor(.white)
                            }
                            
                            Button {
                                
                            } label: {
                                ZStack {
                                    KFImage(URL(string: reels.song.imageCoverUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 3))
                                        
                                    
                                    Image("music_note_icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18,height: 18)
                                        .padding(.all,5)
                                        .background(.black)
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        .offset(x:20, y: 18)
                                    
                                       
                                        
                                    
                                }
                            }
                        }
                        
                    }
                    .padding(.bottom,80)
                }
                .padding()
            }
            .onTapGesture {
                switch player.timeControlStatus {
                case .paused:
                    player.play()
                case .waitingToPlayAtSpecifiedRate:
                    break
                case .playing:
                    player.pause()
                @unknown default:
                    break
                }
            }
         
    }
}

#Preview {
    VendoredInstagramReelsVideoView(reels: VendoredInstagramReelsResponse(id: reelsData[0].id, user: reelsData[0].user, song: reelsData[0].song, caption: reelsData[0].caption, videoUrl: reelsData[0].videoUrl, totalLikes: reelsData[0].totalLikes, totalComments: reelsData[0].totalComments, totalShares: reelsData[0].totalShares), player: AVPlayer())
}

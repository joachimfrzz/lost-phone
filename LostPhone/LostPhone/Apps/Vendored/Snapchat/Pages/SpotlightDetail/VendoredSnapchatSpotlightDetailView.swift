//
//  VendoredSnapchatSpotlightDetailView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 28/5/24.
//

import SwiftUI
import AVKit

struct VendoredSnapchatSpotlightDetailView: View {
    
    let height = (UIScreen.main.bounds.height) * 0.8
    var player: AVPlayer
    var story: VendoredSnapchatStoriesResponse
    
    
    // init player
    init(story:VendoredSnapchatStoriesResponse,player: AVPlayer) {
        self.story = story
        self.player = player
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VendoredSnapchatCustomVideoPlayer(player: player)
                        .containerRelativeFrame([.horizontal,.vertical])
                        
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
            .onAppear { player.play() }
            .background(.black)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // leading
                ToolbarItem (placement: .topBarLeading){
                    HStack (spacing:10){
                        Button {
                            
                        }label: {
                            VStack (spacing:4){
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 10, height:10)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)

                            }
                        }
                        
                        VStack ( alignment: .leading, spacing:0){
                            Text("Jay All Day")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                            Text("S11 - E8")
                                .font(.footnote)
                                .foregroundStyle(.white)
                        }
                    }
                }
                // trailing
                
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing:20){
                        Button {
                            
                        }label: {
                            Image(systemName: "bookmark")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 14, height:14)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                        
                        Button {
                            
                        }label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 4, height:4)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    VendoredSnapchatSpotlightDetailView(story: VendoredSnapchatStoriesResponse(id: storiesData[0].id, user: storiesData[0].user, title: storiesData[0].title, videoUrl: storiesData[0].videoUrl, totalViews: storiesData[0].totalViews, music: storiesData[0].music),player: AVPlayer())
}

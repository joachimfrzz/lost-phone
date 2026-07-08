//
//  VendoredYouTubeMusicDetailView.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 6/9/24.
//

import SwiftUI
import Kingfisher

struct VendoredYouTubeMusicDetailView: View {
    // param music
    var music:VendoredYouTubeMusicMusicResponse
    // back button trigger
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background blur based on music cover
                KFImage(URL(string: music.coverUrl))
                    .resizable()
                    .frame(height: .infinity)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                // content
                VStack {
                    VendoredYouTubeMusicCoverViewAndInfoView(music: music)
                    VendoredYouTubeMusicButtonsActionView()
                    VendoredYouTubeMusicProgressBarViewAndPlayView(music: music)
                }
            }
            // remove back button
            .navigationBarBackButtonHidden(true)
            .padding()
            // icons
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.white)
                    }
                }
                // trailing
                ToolbarItem (placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    VendoredYouTubeMusicDetailView(music: musicQuickPicData[9])
}

struct VendoredYouTubeMusicCoverViewAndInfoView:View {
    var music:VendoredYouTubeMusicMusicResponse
    var body: some View {
        VStack {
            // cover
            KFImage(URL(string: music.coverUrl))
                .resizable()
                .scaledToFill()
                .frame(width: .infinity, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // info
            VStack (alignment: .leading){
                VendoredYouTubeMusicMarqueeTextView(text: music.name, duration: 20, delay: 1)
                VendoredYouTubeMusicMarqueeTextView(text: music.artistName, font: .subheadline, fontWeight: .regular, boxHeight: 30,duration: 20, delay: 1)
//                Text(music.name)
//                    .font(.title)
//                    .fontWeight(.semibold)
//                Text(music.artistName)
//                    .font(.subheadline)
//                    .foregroundStyle(.gray)
            }
//            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


struct VendoredYouTubeMusicButtonsActionView:View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                // like and dislike button
                HStack (spacing: 8){
                    Image(systemName: "hand.thumbsup")
                    Text("31K")
                        .font(.subheadline)
                    Rectangle()
                        .fill(.white.opacity(0.3))
                        .frame(width: 1, height: 20)
                    Image(systemName: "hand.thumbsdown")
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(Color.vendoredYouTubeMusicButtonColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // comment
                HStack (spacing: 8){
                    Image(systemName: "text.bubble")
                    Text("237")
                        .font(.subheadline)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(Color.vendoredYouTubeMusicButtonColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // save
                HStack (spacing: 8){
                    Image(systemName: "plus.square")
                    Text("Save")
                        .font(.subheadline)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(Color.vendoredYouTubeMusicButtonColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // share
                HStack (spacing: 8){
                    Image(systemName: "arrowshape.turn.up.forward")
                    Text("Share")
                        .font(.subheadline)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(Color.vendoredYouTubeMusicButtonColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // download
                HStack (spacing: 8){
                    Image(systemName: "arrow.down.to.line")
                    Text("Download")
                        .font(.subheadline)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(Color.vendoredYouTubeMusicButtonColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}

struct VendoredYouTubeMusicProgressBarViewAndPlayView:View {
    var music:VendoredYouTubeMusicMusicResponse
    
    // load player manager and play
    @StateObject private var playerManager = VendoredYouTubeMusicPlayerManager()
    
    var body: some View {
        VStack (spacing: -5){
            // progress view
            VendoredYouTubeMusicAudioProgressView(playerManager: playerManager)
            // action button play, pause
            HStack (spacing: 50){
                // shuffle
                Button {
                    
                }label: {
                    Image(systemName: "shuffle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                }
                // start
                Button {
                    
                }label: {
                    Image(systemName: "backward.end")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                }
                // play, pause
                Button {
                    // action here
                    if playerManager.isPlaying {
                        playerManager.pauseMusic()
                    }else {
                        if let url = URL(string: music.musicUrl) {
                            playerManager.playMusic(from: url)
                        }else {
                            print("Invalid URL")
                        }
                    }
                }label: {
                    ZStack {
                        Circle()
                            .fill(Color.vendoredYouTubeMusicButtonColor)
                            .frame(width: 70, height: 70)
                        Image(systemName: playerManager.isPlaying ? "pause" : "play")
                            .resizable()
                           .scaledToFill()
                           .frame(width: playerManager.isPlaying ? 13 : 20, height: playerManager.isPlaying ? 13 : 20)
                           .foregroundStyle(.white)
                           .fontWeight(.semibold)
                           .animation(.easeInOut(duration: 0.3), value: playerManager.isPlaying)
                    }
                }
                // end
                Button {
                    
                }label: {
                    Image(systemName: "forward.end")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                }
                // next
                Button {
                    
                }label: {
                    Image(systemName: "arrow.left.arrow.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                }
                
            }
        }
        .padding(.top, 24)
    }
}

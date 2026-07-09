//
//  VendoredAppleMusicDetailView.swift
//  Youtube_Apple_music_clone
//
//  Created by Sopheamen VAN on 24/12/24.
//

import SwiftUI
import Kingfisher

struct VendoredAppleMusicDetailView: View {
    var music:VendoredAppleMusicMusicResponse
    
    @State var isPlaying = true
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                // background blur color
                KFImage(URL(string: music.coverUrl))
                    .resizable()

                    .frame(height: .infinity)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                // content
                VStack (spacing:30){
                    // cover and content view
                    VendoredAppleMusicCoverContentView(music: music)
                    // progress bar view
                    VendoredAppleMusicProgressBarView(music: music)
                    // action button view
                    VendoredAppleMusicActionButtonsView(isPlaying: $isPlaying)
                }
                .padding(.vertical)
                .padding(.horizontal, 50)
            }
            .navigationBarBackButtonHidden(true)
            .background(.black)
            .toolbar {
                ToolbarItem (placement: .principal){
                    Button {
                        dismiss()
                    }label: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.4))
                            .frame(width: 50, height: 5)
                    }
                }
            }
        }
    }
}

#Preview {
    VendoredAppleMusicDetailView(music: playListData[0])
}

struct VendoredAppleMusicCoverContentView:View {
    var music:VendoredAppleMusicMusicResponse
    var body: some View {
        VStack (spacing:80){
            // image
            KFImage(URL(string: music.coverUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 300, height:300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .gray.opacity(0.1),radius: 20)
            // name, artistname, icon
            HStack {
                VStack (alignment: .leading, spacing: -2){
                    Text(music.name)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text(music.artistName)
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                // button
                Button {
                    
                }label: {
                    ZStack {
                        Circle()
                            .fill(.white.opacity(0.2))
                            .frame(width: 34, height: 34)
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

struct VendoredAppleMusicProgressBarView:View {
    var music:VendoredAppleMusicMusicResponse
    
    // state
    @State private var progress:CGFloat = 0
    @State private var currentTime:CGFloat = 0
    
    var width = UIScreen.main.bounds.width - 100
    let totalDuration:CGFloat = 160
    
    var body: some View {
        VStack {
            // progress bar
            ZStack (alignment: .leading){
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.2))
                    .frame(height: 5)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .frame(width: progress,height: 5)
                    .animation(.linear(duration: 100), value: progress)
                
            }
            // start and end duration
            HStack {
                Text(timeFormatted(currentTime))
                Spacer()
                Text(timeFormatted(totalDuration))
            }
            .font(.footnote)
            .foregroundStyle(.white.opacity(0.6))
        }
        .onAppear {
            withAnimation {
                progress = width
            }
            
            // Start the timer to update the current time
            Timer.scheduledTimer(withTimeInterval: 100 / totalDuration, repeats: true) { _ in
                if currentTime < totalDuration {
                    currentTime += 1
                }
            }
        }
    }
    
    // Helper function to format the time as MM:SS
    func timeFormatted(_ totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct VendoredAppleMusicActionButtonsView:View {
    @Binding var isPlaying:Bool
    var body: some View {
        HStack (spacing:80){
            // back
            Button {
                
            }label: {
                Image(systemName: "backward.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }
            // play and pause
            Button {
                isPlaying.toggle()
            }label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }
            // forward
            Button {
                
            }label: {
                Image(systemName: "forward.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
            }
        }
    }
}

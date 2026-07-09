//
//  DetailView.swift
//  Youtube_Netflix
//
//  Created by Sopheamen VAN on 2/9/24.
//

import SwiftUI
// for video player
import AVKit

struct DetailView: View {
    let movie: MovieResponse
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .top){
                // scrollable content
                ScrollView {
                    VStack {
                        // push to bottom and add height space
                        Spacer()
                            .frame(height: 185)
                        // content info here
                        InfoView(movie: movie)
                        ButtonsView()
                        CastAndDirectorView(movie: movie)
                        MyListRateAndShareView()
                        MoreLikeThisView()
                    }
                    .padding(.all)
                }
                
                // main view trailer and fixed to top
                MainVideoView(movie:movie)
                    .ignoresSafeArea(.all)
            }
            // disable default back button
            .navigationBarBackButtonHidden(true)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    DetailView(movie: koreanMovieData[1])
}

struct MainVideoView:View {
    let movie: MovieResponse
    // back button trigger
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack (alignment: .topTrailing){
            // custom video player
            CustomVideoPlayer(player: AVPlayer(url: URL(string: movie.trailVideoUrl)!))
                .frame(width: .infinity, height: 250)
            
            // close button
            Button {
                dismiss()
            }label: {
                ZStack {
                    Circle()
                        .fill(.black)
                        .frame(width: 35, height: 35)
                    Image(systemName: "xmark")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            .padding(.all, 20)
            .padding(.top, 10)
        }
    }
}

struct InfoView:View {
    let movie: MovieResponse
    var body: some View {
        VStack (spacing: 6){
            Text(movie.name)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text(movie.date)
                    .font(.headline)
                    .fontWeight(.regular)
                Text(movie.ageRestiction)
                    .font(.caption)
                    .padding(.vertical,1)
                    .padding(.horizontal,4)
                    .background(.gray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                Text(movie.movieDuration)
                    .font(.headline)
                    .fontWeight(.regular)
                Text("HD")
                    .font(.caption)
                    .padding(.vertical,1)
                    .padding(.horizontal,4)
                    .background(.gray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                Spacer()
            }
        }
    }
}

struct ButtonsView:View {
    var body: some View {
        VStack (spacing: 10){
            Button {
                
            }label: {
                HStack (spacing: 12){
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.black)
                    Text("Play")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                // custom layout button
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            
            // download button
            Button {
                
            }label: {
                HStack (spacing: 12){
                    Image(systemName: "arrow.down")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.white)
                    Text("Download")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                // custom layout button
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
    }
}

struct CastAndDirectorView:View {
    let movie: MovieResponse
    var body: some View {
        VStack (alignment: .leading){
            Text(movie.description)
                .font(.subheadline)
                .padding(.bottom, 6)
            Text("Cast: \(movie.cast) ...more")
                .font(.footnote)
                .foregroundStyle(.gray)
            Text("Director: \(movie.directors)")
                .font(.footnote)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
    }
}

struct MyListRateAndShareView:View {
    var body: some View {
        HStack (spacing: 50){
            Button {
                
            }label: {
                VStack (spacing: 4){
                    Image(systemName: "plus")
                        .font(.title2)
                    Text("My List")
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
            }
            // rate
            Button {
                
            }label: {
                VStack (spacing: 4){
                    Image(systemName: "hand.thumbsup")
                        .font(.title2)
                    Text("Rate")
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
            }
            // share
            Button {
                
            }label: {
                VStack (spacing: 4){
                    Image(systemName: "paperplane")
                        .font(.title2)
                    Text("Share")
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct MoreLikeThisView:View {
    var moreLikeThisDatas:[MovieResponse] = moreLikeThisData
    
    var columns:[GridItem] = [
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6),
    ]
    var size = (UIScreen.main.bounds.width / 3) - 20
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            // title
            Text("More Like This")
                .font(.headline)
                .padding(.top, 12)
                .overlay(
                    Rectangle()
                        .fill(Color.primaryColor)
                        .frame(height: 4), alignment: .top
                )
            
            // list item as grid
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(moreLikeThisDatas) { movie in
                    MovieRowView(movie: movie)
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//
//  HomeView.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 6/9/24.
//

import SwiftUI
// for image network cache
import Kingfisher

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // set background to blur and with color
                BackgroundBlurView()
                
                // page content
                VStack (spacing: 20){
                    // cagegory view
                    CategoryView()
                    // scrollview
                    ScrollView {
                        VStack (spacing: 24){
                            // quick pick view
                            QuickPicksView()
                            ForgottenMusicView()
                            DanceMusicView()
                            RecommendeMusicView()
                            PopMusicView()
                        }
                    }
                }
                // space
                Spacer()
                
            }
            // icons and title
            .edgesIgnoringSafeArea(.top)
            .toolbar {
                // title music
                ToolbarItem (placement: .topBarLeading){
                    Text("Music")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                // trailing icons
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing: 14){
                        Button {
                            // action
                        }label: {
                            // layout
                            Image(systemName: "bell")
                        }
                        
                        // search
                        Button {
                            // action
                        }label: {
                            // layout
                            Image(systemName: "magnifyingglass")
                        }
                        
                        // profile
                        Button {
                            // action
                        }label: {
                            // layout
                            KFImage(URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D"))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        }
                    }
                    .foregroundStyle(.white)
                }
            }
        }
        // to dark theme
        .preferredColorScheme(.dark)
    }
}

#Preview {
    HomeView()
}

struct CategoryView:View {
    // get category data
    var categories:[CategoryResponse] = categorieData
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack (spacing: 12){
                ForEach(categories) { category in
                    Button {
                        
                    }label: {
                        Text(category.name)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 14)
                            .background(Color.buttonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.white.opacity(0.3)))
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
        .padding(.vertical,10)
    }
}

struct QuickPicksView:View {
    // load from sample data
    var quickPicks:[MusicResponse] = musicQuickPicData
    
    var body: some View {
        VStack (spacing: 12){
            // title
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("start radio from a song")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .textCase(.uppercase)
                    Text("Quick picks")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                Spacer()
                // play all button
                Button {
                    
                }label: {
                    Text("Play all")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(.white.opacity(0.3)))
                }
            }
            .padding(.horizontal)
            // data as tab view and scroll right
            TabView {
                ForEach(0..<quickPicks.count / 4, id:\.self) { pageIndex in
                    VStack (spacing: 12){
                        ForEach(0..<4) { index in
                            let music = quickPicks[pageIndex * 4 + index]
                            //
                            NavigationLink(destination: DetailView(music: music)) {
                                QuickPickRowView(music: music)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 300)
            
        }
    }
}

struct QuickPickRowView:View {
    var music:MusicResponse
    var body: some View {
        HStack (spacing: 14){
            KFImage(URL(string: music.coverUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            VStack (alignment: .leading, spacing: 0){
                Text(music.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Text("\(music.artistName) - \(music.viewCount)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button {
                
            }label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundStyle(.white)
            }
        }
    }
}

struct ForgottenMusicView:View {
    var musics:[MusicResponse] = forgottenFavouriteData
    var body: some View {
        VStack (spacing: 12){
            Text("Forgotten favourites")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // load data and scroll right
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack (spacing: 12){
                    ForEach(musics) { music in
                        NavigationLink(destination: DetailView(music: music)) {
                            ScrollableMusicRowView(music: music)
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// same as forgotten music view
struct DanceMusicView:View {
    var musics:[MusicResponse] = danceAndEelectronicData
    var body: some View {
        VStack (spacing: 12){
            Text("Dance & Electronic")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // load data and scroll right
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack (spacing: 12){
                    ForEach(musics) { music in
                        NavigationLink(destination: DetailView(music: music)) {
                            ScrollableMusicRowView(music: music)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RecommendeMusicView:View {
    var musics:[MusicResponse] = radioData
    var body: some View {
        VStack (spacing: 12){
            Text("Recommended radios")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // load data and scroll right
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack (spacing: 12){
                    ForEach(musics) { music in
                        NavigationLink(destination: DetailView(music: music)) {
                            ScrollableMusicRowView(music: music, width: 160, height: 160)
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PopMusicView:View {
    var musics:[MusicResponse] = popData
    var body: some View {
        VStack (spacing: 12){
            Text("Pop")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            // load data and scroll right
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack (spacing: 12){
                    ForEach(musics) { music in
                        NavigationLink(destination: DetailView(music: music)) {
                            ScrollableMusicRowView(music: music, width: 160, height: 160)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

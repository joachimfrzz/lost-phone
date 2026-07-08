//
//  VendoredAppleMusicHomeView.swift
//  Youtube_Apple_music_clone
//
//  Created by Sopheamen VAN on 24/12/24.
//

import SwiftUI
import Kingfisher // for image load cache network

struct VendoredAppleMusicHomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing:20){
                    // playlists
                    VendoredAppleMusicPlayListsView()
                    // all songs
                    VendoredAppleMusicAllSongsView()
                    // albums
                    VendoredAppleMusicAlbumsView()
                }
                .padding(.vertical)
            }
            .navigationTitle("Listen Now")
            .toolbar {
                ToolbarItem (placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.vendoredAppleMusicVendoredAppleMusicPrimary)
                    }
                }
            }
        }
    }
}

#Preview {
    VendoredAppleMusicHomeView()
}

struct VendoredAppleMusicPlayListsView:View {
    var playListDatas:[VendoredAppleMusicMusicResponse] = playListData
    var body: some View {
        VStack (spacing:12){
            // title
            HStack (spacing:6){
                Text("Playlists")
                    .font(.title2)
                    .fontWeight(.semibold)
                Image(systemName: "chevron.right")
                    .padding(.top, 2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.5))
                Spacer()
                    
            }
            .padding(.horizontal)
            // scrollable list item
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack (spacing:14){
                    ForEach(playListDatas) { music in
                        NavigationLink (destination: VendoredAppleMusicDetailView(music: music)){
                            VendoredAppleMusicMusicRowView(music: music)
                        }
                       
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VendoredAppleMusicAllSongsView:View {
    var allSongsDatas:[VendoredAppleMusicMusicResponse] = allSongsData
    // grid row as 4 items
    let rows = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]
    var body: some View {
        VStack (spacing:12){
            // title
            HStack (spacing:6){
                Text("All Songs")
                    .font(.title2)
                    .fontWeight(.semibold)
                Image(systemName: "chevron.right")
                    .padding(.top, 2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.5))
                Spacer()
                    
            }
            .padding(.horizontal)
            // list items
            ScrollView (.horizontal, showsIndicators: false){
                LazyHGrid(rows: rows, spacing: 14){
                    ForEach(allSongsDatas.indices, id: \.self) { index in
                        NavigationLink (destination: VendoredAppleMusicDetailView(music: allSongsDatas[index])){
                            VendoredAppleMusicAllSongsRowView(music: allSongsDatas[index], index: index)
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct VendoredAppleMusicAllSongsRowView:View {
    var music: VendoredAppleMusicMusicResponse
    var index: Int = 1
    var body: some View {
        HStack (spacing:14){
            // image
            KFImage(URL(string: music.coverUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            // content
            VStack {
                Divider()
                HStack (spacing:14){
                    Text("\(index + 1)")
                        .font(.headline)
                    VStack (alignment: .leading){
                        Text(music.name)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(music.artistName)
                            .font(.subheadline)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                    .frame(width: 180)
                    Spacer()
                    Button {
                        
                    }label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.black)
                    }
                    Spacer()
                }
            }
            .foregroundStyle(.black)
        }
    }
}

struct VendoredAppleMusicAlbumsView:View {
    var albumsDatas:[VendoredAppleMusicMusicResponse] = albumsData
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var width = (UIScreen.main.bounds.width - 50) / 2
    var body: some View {
        VStack (spacing:12){
            // title
            HStack (spacing:6){
                Text("Albums")
                    .font(.title2)
                    .fontWeight(.semibold)
                Image(systemName: "chevron.right")
                    .padding(.top, 2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.5))
                Spacer()
                    
            }
            .padding(.horizontal)
            // list item
            LazyVGrid(columns: columns, spacing: 14){
                ForEach(albumsDatas) { music in
                    NavigationLink (destination: VendoredAppleMusicDetailView(music: music)){
                        VendoredAppleMusicMusicRowView(music: music, width: width, height: width)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}


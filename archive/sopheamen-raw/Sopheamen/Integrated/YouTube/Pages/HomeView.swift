//
//  HomeView.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 17/10/24.
//

import SwiftUI
// load image lib cache network
import Kingfisher

struct YouTubeHome: View {
    @State private var showSearch = false
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing:14){
                    // category
                    CategoryButtonView()
                        .padding()
                    // section 1
                    Section1View()
                    // section 2
                    Section2View()
                    // section 3
                    Section3View()
                    // section 4
                    Section4View()
                    // section 5
                    Section5View()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 8) {
                        Button { showProfile = true } label: {
                            Image(systemName: "person.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.primary)
                        }
                        HStack(spacing: 5) {
                            Image("logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30)
                            Text("YouTube")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 20) {
                        Button {} label: {
                            Image(systemName: "airplayvideo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.primary)
                        }
                        Button {} label: {
                            Image(systemName: "bell")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.primary)
                        }
                        Button { showSearch = true } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showSearch) {
            NavigationStack {
                TextField("Search YouTube", text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .navigationTitle("Search")
            }
        }
        .sheet(isPresented: $showProfile) {
            NavigationStack {
                List {
                    Text("Watch history")
                    Text("Your videos")
                    Text("Playlists")
                }
                .navigationTitle("Profile")
            }
        }
    }
}

#Preview {
    YouTubeHome()
}

struct CategoryButtonView:View {
    var categoryDatas:[CategoryResponse] = categoryData
    // selected index
    @State private var selectedIndex:Int = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 12){
                ForEach(categoryDatas.indices, id: \.self) { index in
                    Button {
                        selectedIndex = index
                    }label: {
                        Text(categoryDatas[index].title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedIndex == index ? .black : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical , 10)
                            .background(selectedIndex == index ? .white : Color.grayButtonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
    }
}

struct Section1View:View {
    // load section 1
    var videos:[VideoResponse] = videoSection1Data
    
    var body: some View {
        LazyVStack (spacing: 32){
            ForEach(videos) { video in
                NavigationLink(destination: VideoDetailView(video: video)){
                    VideoNormalView(video: video)
                }
                
            }
        }
    }
}

struct Section2View:View {
    // load section2 data
    var videos:[VideoResponse] = videoSection2Data
    // grid item
    // it means to item in a row
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack (spacing:12){
            // text and logo shorts
            HStack (spacing:10){
                ZStack {
                    // add white background
                    Rectangle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                    
                    Image("shorts_logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30)
                }
                Text("Shorts")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            // grid item
            LazyVGrid (columns: columns, spacing: 10){
                ForEach(videos) { video in
                    NavigationLink(destination: ShortsDetailView(video: video)){
                        VideoShortsView(video: video)
                    }
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(.bottom)
    }
}

struct Section3View:View {

    var videos:[VideoResponse] = videoSection3Data
    
    var body: some View {
        LazyVStack (spacing: 32){
            ForEach(videos) { video in
                NavigationLink(destination: VideoDetailView(video: video)){
                    VideoNormalView(video: video)
                }
            }
        }
    }
}

struct Section4View:View {
    // load section2 data
    var videos:[VideoResponse] = videoSection4Data
    // grid item
    // it means to item in a row
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack (spacing:12){
            // text and logo shorts
            HStack (spacing:10){
                ZStack {
                    // add white background
                    Rectangle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                    
                    Image("shorts_logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30)
                }
                Text("Shorts")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            // grid item
            LazyVGrid (columns: columns, spacing: 10){
                ForEach(videos) { video in
                    NavigationLink(destination: ShortsDetailView(video: video)){
                        VideoShortsView(video: video)
                    }
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(.bottom)
    }
}

struct Section5View:View {

    var videos:[VideoResponse] = videoSection5Data
    
    var body: some View {
        LazyVStack (spacing: 32){
            ForEach(videos) { video in
                NavigationLink(destination: VideoDetailView(video: video)){
                    VideoNormalView(video: video)
                }
            }
        }
    }
}





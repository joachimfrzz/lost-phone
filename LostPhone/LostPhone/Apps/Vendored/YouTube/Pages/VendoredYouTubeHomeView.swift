//
//  VendoredYouTubeHomeView.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 17/10/24.
//

import SwiftUI
// load image lib cache network
import Kingfisher

struct VendoredYouTubeHomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing:14){
                    // category
                    VendoredYouTubeCategoryButtonView()
                        .padding()
                    // section 1
                    VendoredYouTubeSection1View()
                    // section 2
                    VendoredYouTubeSection2View()
                    // section 3
                    VendoredYouTubeSection3View()
                    // section 4
                    VendoredYouTubeSection4View()
                    // section 5
                    VendoredYouTubeSection5View()
                }
            }
            // set title logo and icons
            .toolbar {
                // logo
                ToolbarItem (placement: .topBarLeading){
                    HStack (spacing:5){
                        ZStack {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 20, height: 20)
                            
                            Image("logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30)
                        }
                        // title
                        Text("Youtube")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
                // icons
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing:20){
                        // tv
                        Button {
                            
                        }label: {
                            Image(systemName: "airplayvideo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.white)
                        }
                        // notification
                        Button {
                            
                        }label: {
                            Image(systemName: "bell")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.white)
                        }
                        // search
                        Button {
                            
                        }label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
        // to dark theme
        .preferredColorScheme(.dark)
    }
}

#Preview {
    VendoredYouTubeHomeView()
}

struct VendoredYouTubeCategoryButtonView:View {
    var categoryDatas:[VendoredYouTubeCategoryResponse] = categoryData
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

struct VendoredYouTubeSection1View:View {
    // load section 1
    var videos:[VendoredYouTubeVideoResponse] = videoSection1Data
    
    var body: some View {
        LazyVStack (spacing: 32){
            ForEach(videos) { video in
                NavigationLink(destination: VendoredYouTubeVideoDetailView(video: video)){
                    VendoredYouTubeVideoNormalView(video: video)
                }
                
            }
        }
    }
}

struct VendoredYouTubeSection2View:View {
    // load section2 data
    var videos:[VendoredYouTubeVideoResponse] = videoSection2Data
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
                    NavigationLink(destination: VendoredYouTubeShortsDetailView(video: video)){
                        VendoredYouTubeVideoShortsView(video: video)
                    }
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(.bottom)
    }
}

struct VendoredYouTubeSection3View:View {

    var videos:[VendoredYouTubeVideoResponse] = videoSection3Data
    
    var body: some View {
        LazyVStack (spacing: 32){
            ForEach(videos) { video in
                NavigationLink(destination: VendoredYouTubeVideoDetailView(video: video)){
                    VendoredYouTubeVideoNormalView(video: video)
                }
            }
        }
    }
}

struct VendoredYouTubeSection4View:View {
    // load section2 data
    var videos:[VendoredYouTubeVideoResponse] = videoSection4Data
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
                    NavigationLink(destination: VendoredYouTubeShortsDetailView(video: video)){
                        VendoredYouTubeVideoShortsView(video: video)
                    }
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(.bottom)
    }
}

struct VendoredYouTubeSection5View:View {

    var videos:[VendoredYouTubeVideoResponse] = videoSection5Data
    
    var body: some View {
        LazyVStack (spacing: 32){
            ForEach(videos) { video in
                NavigationLink(destination: VendoredYouTubeVideoDetailView(video: video)){
                    VendoredYouTubeVideoNormalView(video: video)
                }
            }
        }
    }
}





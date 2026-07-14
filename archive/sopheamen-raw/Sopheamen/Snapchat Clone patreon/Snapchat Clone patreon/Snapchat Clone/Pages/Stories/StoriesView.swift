//
//  StoriesView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 18/5/24.
//

import SwiftUI
import Kingfisher

struct StoriesView: View {
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false){
                VStack {
                    // friends story
                    FriendStoryView()
                    
                    // discover
                    DiscoverView()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .principal) {
                    CustomToolbar(title: "Stories")
                }
            }
        }
    }
}

#Preview {
    StoriesView()
}

struct FriendStoryView:View {
    var storiesDatas:[StoriesResponse] = storiesData
    var body: some View {
        VStack (alignment: .leading, spacing:10){
            Text("Friends")
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack (spacing:20){
                    ForEach(storiesDatas) { story in
                        VStack {
                            ProfileImageView(profileImage: story.user.profileImage, size: 65)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 4)
                                        .padding(2))
                                .overlay(
                                    Circle()
                                        .stroke(Color.purple, lineWidth: 2))
                            Text(story.user.fullname)
                                .font(.subheadline)
                                .bold()
                                .frame(width:60)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.all,2)
            }
            
        }
    }
}

struct DiscoverView:View {
    // grid view
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
    ]
    let size = (UIScreen.main.bounds.width / 2) - 20
    // story data
    var storiesDatas:[StoriesResponse] = storiesData
    var body: some View {
        VStack (alignment: .leading,spacing:10){
            Text("Discover")
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, spacing:10){
                ForEach(storiesDatas) { story in
                    
                    ZStack (alignment: .bottomLeading) {
                        ThumbnailImageView(videoURL: URL(string: story.videoUrl)!,width: size, height: 250)
                            .clipped()
                            .cornerRadius(10)
                        
                        // add gradient black color
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0.0)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .frame(height: 250)
                        .cornerRadius(10)
                        
                        Text(story.title)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                           
                    }

                }
            }
            
        }
    }
}



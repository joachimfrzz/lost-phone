//
//  HomeView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 9/3/24.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    let storiesData:[StoryResponse] = storyData
    let postData:[PostResponse] = postsData
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // story view section
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack (spacing: 16){
                        HomeProfileViewAndStory()
                        // profile add story
                        ForEach(storiesData) { story in
                            StoryView(profileUrl: story.user.profileImage, storyText: story.user.fullname)
                        }
                    }
                }
                .padding(.leading, 16)
                .padding(.top, 10)
                
                // post view section
                LazyVStack {
                    ForEach(postData) { post in
                        PostView(profileImageUrl: post.user.profileImage, username: post.user.username, postImages: post.imageOrVideoUrl, caption: post.caption!, totalLikes: post.totalLikes, totalComments: post.totalComments,postType: post.postType)
                            .padding(.vertical,12)
                    }
                }
                
 
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                   Image("text_logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120)
                }
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing: 10){
                        Button {
                            
                        }label: {
                            Image("like_icon")
                                .resizable()
                                .scaledToFill()
                                .foregroundStyle(.black)
                                .frame(width: 23, height: 23)
                            
                        }
                        NavigationLink(destination: MessagingView().hideTabBar()) {
                                       Image("message_icon")
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 23, height: 23)
                                   }
                      
                    }
                    
                    
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}

// profile view
struct HomeProfileViewAndStory: View {

    var body: some View {
        VStack (spacing: 5){
            ZStack {
                KFImage(URL(string: userDataCurrent.profileImage))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 75,height: 75)
                    .clipShape(Circle())
                
                Button {
                    
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25,height: 25)
                        .background(.white)
                        .clipShape(Circle())
                        .foregroundStyle(Color.primaryColor)
                        .overlay(Circle().stroke(.white, lineWidth: 4))
                }
                .offset(x: 30,y: 25)
                    
                
            }
            .frame(width: 80,height: 80)
            
            Text("Your story")
                .font(.caption)
                .frame(width: 60)
                .lineLimit(1)
        }
    }
}

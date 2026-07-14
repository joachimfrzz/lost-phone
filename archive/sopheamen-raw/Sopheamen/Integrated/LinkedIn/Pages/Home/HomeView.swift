//
//  HomeView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 23/4/24.
//

import SwiftUI
import Kingfisher
struct LinkedInHome: View {
   
    var postAllDatas:[PostResponse] = postData
    
   
    
    var body: some View {
        NavigationStack {
            ScrollView {
                    LazyVStack {
                        ForEach(postAllDatas) { post in
                            PostView(post: post)
                        }
                    }
                    .padding(.vertical, 10)
                   
            }
            
            .background(Color.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
           
        }
    }
}

#Preview {
    LinkedInHome()
}

struct PostView:View {
    var post: PostResponse
    
    var body: some View {
        VStack (spacing:10){
            // user likes post
            HStack {
                HStack {
                    ProfileImageRectangleView(profileImage: post.userLikesThisPost.profileImage, size: 30)
                    Text(post.userLikesThisPost.fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    +
                    Text(" likes this")
                        .font(.footnote)
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundStyle(.black.opacity(0.7))
            }
            .padding(.horizontal, 12)
           
            
            // divider
            Divider()
                .padding(.horizontal, 12)
            
            // profile and follow text and icon
            HStack (alignment: .top){
                // profile
                HStack {
                    ProfileImageView(profileImage: post.user.profileImage, size: 60)
                    VStack (alignment: .leading,spacing:3){
                        HStack {
                            Text(post.user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            +
                            Text(" - 3rd+")
                                .font(.footnote)
                        }
                        Text(post.user.headLineBio)
                            .font(.footnote)
                            .frame(height: 10)
                        HStack (spacing:0){
                            Text("3d - ")
                                .font(.footnote)
                                .frame(height: 20)
                            Image(systemName: "globe.americas.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.black)
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                
                Spacer()
                
                // follow icon and text
                Button {
                    
                }label: {
                    HStack (spacing: 5){
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 13, height: 13)
                            
                            .fontWeight(.semibold)
                        Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(Color.primaryColor)
                }
                
            }
            .padding(.horizontal, 12)
            
            // caption
            Text(post.caption)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
            
            // divider
            Divider()
            
            // post type
            if post.type == 1 {
                // photo
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity,height: 250)
                    .clipped()
            }else {
                // link
                VStack (alignment: .leading){
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                    Text(post.title ?? "")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal, 12)
                        
                    Text("\(post.user.fullname) on Linkedin - \(post.readTimeAgo)")
                        .font(.footnote)
                        .padding(.horizontal, 12)
                    
                }
                
                .padding(.bottom, 10)
                .background(Color.backgroundColor)
                
            }
            
            // total likes, comments, reposts
            HStack {
                // likes
                HStack{
                    ZStack {
                        
                        Image("like")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 11,height: 11)
                            .foregroundStyle(.white)
                            .padding(.all, 5)
                            .background(Color.likeIconColor)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white,lineWidth:1))
                        Image("heart")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 11,height: 11)
                            .foregroundStyle(.white)
                            .padding(.all, 5)
                            .padding(.top,1)
                            .background(Color.heartIconColor)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white,lineWidth:1))
                            .offset(x:15)
                        Image("light")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10,height: 10)
                            .foregroundStyle(.white)
                            .padding(.all, 5)
                            .background(Color.lightIconColor)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white, lineWidth:1))
                            .offset(x:30)
                    }
                    Text("\(post.totalLikes)")
                        .font(.footnote)
                        .offset(x:28)
                    
                }
                Spacer()
                Text("\(post.totalComments) comments")
                    .font(.footnote)
                    .offset(x:10)
                Spacer()
                Text("\(post.totalReposts) reposts")
                    .font(.footnote)
                   
                
            }
            .padding(.horizontal)
            
            Divider()
            
            // like, comment, and reposts
            HStack {
                iconTextButton(title: "Like", icon: "hand.thumbsup", action: {})
                Spacer()
                iconTextButton(title: "Comment", icon: "bubble", action: {})
                Spacer()
                iconTextButton(title: "Repost", icon: "arrow.up.arrow.down", action: {})
                Spacer()
                iconTextButton(title: "Send", icon: "paperplane", action: {})
            }
            .padding(.horizontal)
            
        }
        .padding(.vertical, 10)
        .background(.white)
    }
}

struct iconTextButton:View {
    var title: String
    var icon: String
    var action: () -> Void
    var body: some View {
        Button (action: action){
            VStack (spacing:2){
                Image(systemName: icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16,height: 16)
                Text(title)
                    .font(.footnote)
                    
            }
            .foregroundStyle(.black.opacity(0.7))
            .fontWeight(.semibold)
     }
    }
}

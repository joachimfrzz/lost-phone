//
//  PostView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 16/3/24.
//

import SwiftUI
import Kingfisher

struct PostView: View {
    let profileImageUrl:String
    let username:String
    let postImages:[String]
    let caption:String
    let totalLikes: Int
    let totalComments: Int
    let postType: Int
    @State private var selectedTabIndex = 0
    var body: some View {
        VStack (spacing: 12){
            // header view section
            HStack {
                HStack {
                    ProfileImageView(profileImage: profileImageUrl, size: 40)
                    Text(username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            // image
            if(postType == 1){
                // carousel images
                if(postImages.count > 1){
                    TabView (selection: $selectedTabIndex){
                        ForEach(postImages, id: \.self) { image in
                            KFImage(URL(string: image))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .tag(image)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 380)
                    
                // image view post
                }else {
                    KFImage(URL(string: postImages[0]))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }else {
                // video generate thumbnail
                ThumbnailImageView(videoURL: URL(string: postImages[0])!,width: .infinity, height: 360)
            }
            
            
            
            
            // like, comment, send view post
            HStack {
                HStack (spacing: 12){
                    Button {
                        
                    }label: {
                        Image("like_icon")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(.black)
                            .frame(width: 23, height: 23)
                        
                    }
                    Button {
                        
                    }label: {
                        Image("comment_icon")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(.black)
                            .frame(width: 23, height: 23)
                        
                    }
                    Button {
                        
                    }label: {
                        Image("send_message_icon")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(.black)
                            .frame(width: 25, height: 25)
                        
                    }
                }
                Spacer()
                Button {
                    
                }label: {
                    Image("save_icon")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.black)
                        .frame(width: 23, height: 23)
                    
                }
            }
            .padding(.horizontal)
            
            // like and comment action view section
            Text("\(totalLikes) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 10)
                .padding(.horizontal)
            
            // caption
            HStack {
                Text(username)
                    .fontWeight(.semibold) +
                Text(" \(caption)")
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 10)
            .padding(.horizontal)
            
            // total comment view
            // date ago
            Text("\(totalComments) comments")
                .font(.footnote)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 10)
                .padding(.horizontal)
            
            // date ago
            Text("12 hours ago")
                .font(.footnote)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 8)
                .padding(.horizontal)
            
        }
    }
}

#Preview {
    PostView(profileImageUrl: postsData[0].user.profileImage, username: postsData[0].user.fullname, postImages: postsData[0].imageOrVideoUrl,caption: postsData[0].caption!, totalLikes: postsData[0].totalLikes, totalComments: postsData[0].totalComments,postType: 1)
}

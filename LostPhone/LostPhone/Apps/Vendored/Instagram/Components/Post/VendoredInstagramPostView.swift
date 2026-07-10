//
//  VendoredInstagramPostView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 16/3/24.
//

import SwiftUI
import Kingfisher

struct VendoredInstagramPostView: View {
    let profileImageUrl:String
    let username:String
    let postImages:[String]
    let caption:String
    let totalLikes: Int
    let totalComments: Int
    let postType: Int
    @State private var selectedTabIndex = 0
    @State private var isLiked = false
    @State private var likeCount: Int
    @State private var showComments = false

    init(profileImageUrl: String, username: String, postImages: [String], caption: String, totalLikes: Int, totalComments: Int, postType: Int) {
        self.profileImageUrl = profileImageUrl
        self.username = username
        self.postImages = postImages
        self.caption = caption
        self.totalLikes = totalLikes
        self.totalComments = totalComments
        self.postType = postType
        _likeCount = State(initialValue: totalLikes)
    }

    var body: some View {
        VStack (spacing: 12){
            // header view section
            HStack {
                HStack {
                    VendoredInstagramProfileImageView(profileImage: profileImageUrl, size: 40)
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
                VendoredInstagramThumbnailImageView(videoURL: URL(string: postImages[0])!,width: .infinity, height: 360)
            }
            
            // like, comment, send view post
            HStack {
                HStack (spacing: 12){
                    Button {
                        isLiked.toggle()
                        likeCount += isLiked ? 1 : -1
                    }label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(isLiked ? .red : .black)
                            .frame(width: 23, height: 23)
                    }
                    Button {
                        showComments = true
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
            
            Text("\(likeCount) likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 10)
                .padding(.horizontal)
            
            HStack {
                Text(username)
                    .fontWeight(.semibold) +
                Text(" \(caption)")
            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 10)
            .padding(.horizontal)
            
            Text("\(totalComments) comments")
                .font(.footnote)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 10)
                .padding(.horizontal)
            
            Text("12 hours ago")
                .font(.footnote)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 8)
                .padding(.horizontal)
        }
        .sheet(isPresented: $showComments) {
            NavigationStack {
                List {
                    Text("Great shot! 🔥")
                    Text("Love this")
                    Text("Where was this?")
                }
                .navigationTitle("Comments")
                .navigationBarTitleDisplayMode(.inline)
            }
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    VendoredInstagramPostView(profileImageUrl: postsData[0].user.profileImage, username: postsData[0].user.fullname, postImages: postsData[0].imageOrVideoUrl,caption: postsData[0].caption!, totalLikes: postsData[0].totalLikes, totalComments: postsData[0].totalComments,postType: 1)
}

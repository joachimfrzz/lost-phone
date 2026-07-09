//
//  HomeView.swift
//  Youtube_Threads
//
//  Created by Sopheamen VAN on 26/9/24.
//

import SwiftUI
// for image network and cache
import Kingfisher


struct ThreadsHome: View {
    // get post data from model
    var postDatas:[PostResponse] = postData
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // logo profile and action button
                    LogoAndProfileActionButtonsView()
                    // feeds
                    LazyVStack {
                        ForEach(postDatas) { post in
                            PostView(post: post)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        // set to dark mode
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ThreadsHome()
}

struct LogoAndProfileActionButtonsView:View {
    var body: some View {
        VStack (spacing: 18){
            // logo
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 42)
            // profile and caption
            HStack (spacing: 12){
                KFImage(URL(string: currentUser.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                VStack (spacing: 0){
                    Text(currentUser.username)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("What's new?")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.white.opacity(0.4))
                }
                Spacer()
            }
            .padding(.horizontal)
            // actions button
            HStack (spacing:24){
                // photo
                Button {
                    
                }label: {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23, height: 23)
                        .foregroundStyle(.white.opacity(0.4))
                }
                // camera
                Button {
                    
                }label: {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 21, height: 21)
                        .foregroundStyle(.white.opacity(0.4))
                }
                // sticker
                Button {
                    
                }label: {
                    Image(systemName: "ev.plug.dc.chademo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22, height: 22)
                        .foregroundStyle(.white.opacity(0.4))
                }
                // mic
                Button {
                    
                }label: {
                    Image(systemName: "mic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.white.opacity(0.4))
                }
                // pound sign
                Button {
                    
                }label: {
                    Image(systemName: "number")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 19, height: 19)
                        .foregroundStyle(.white.opacity(0.4))
                }
                // justify
                Button {
                    
                }label: {
                    Image(systemName: "text.alignleft")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 17, height: 17)
                        .foregroundStyle(.white.opacity(0.4))
                }
                Spacer()
            }
            .padding(.leading, 60)
            
            CustomDivider()
        }
    }
}

struct PostView:View {
    var post:PostResponse
    var body: some View {
        VStack (spacing: 12){
            // profile and caption
            HStack {
                // profile
                ZStack (alignment: .bottomTrailing){
                    KFImage(URL(string: post.user.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    // plus icon
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                }
                // username and caption
                VStack(alignment: .leading) {
                    HStack {
                        Text(post.user.username)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        Text(post.postedAt)
                            .fontWeight(.regular)
                            .foregroundStyle(.gray)
                    }
                    .font(.headline)
                    Text(post.caption)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.white)
                }
                Spacer()
                
                // icon option
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white.opacity(0.5))
                
            }
            .padding(.horizontal)
            // images
            NavigationLink (destination: DetailView(post: post)){
                ImagesViewer(post: post)
            }
            
            // button actions
            ButtonOptionsView(post: post)
                .padding(.top, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            // divider
            CustomDivider()
                .padding(.top, 4)
        }
    }
}

struct ImagesViewer:View {
    var post:PostResponse
    var body: some View {
        // check if images count has than 1 add scroll else no scroll
        if post.imagesUrl.count > 1 {
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack (spacing: 14){
                    ForEach(post.imagesUrl, id: \.self) { image in
                        KFImage(URL(string: image))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal)
            }
        } else if post.imagesUrl.count == 1{
            KFImage(URL(string: post.imagesUrl[0]))
                .resizable()
                .scaledToFill()
                .frame(width: 320, height: 420)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
       
    }
}

struct ButtonOptionsView:View {
    var post:PostResponse
    var body: some View {
        HStack (spacing: 22){
            // likes
            Button {
                
            }label: {
                HStack (spacing: 8){
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.white.opacity(0.8))
                    Text("\(post.totalLikes)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            // comments
            Button {
                
            }label: {
                HStack (spacing: 8){
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.white.opacity(0.8))
                    Text("\(post.totalComments)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            // reposts
            Button {
                
            }label: {
                HStack (spacing: 8){
                    Image(systemName: "repeat")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.white.opacity(0.8))
                    Text("\(post.totalReposts)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            // shares
            Button {
                
            }label: {
                HStack (spacing: 8){
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.white.opacity(0.8))
                    Text("\(post.totalShares)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
        }
        
    }
}

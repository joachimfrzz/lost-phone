//
//  VendoredMessengerChatView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 17/9/24.
//

import SwiftUI

struct VendoredMessengerChatView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                // content here
                VStack (spacing: 20){
                    //textfield search
                    VendoredMessengerTextFieldSearchView()
                    // story view
                    VendoredMessengerStoryView()
                    // chat history view
                    VendoredMessengerChatHistoryView()
                }
                .padding(.vertical)
            }
            .background(Color.white)
            // header
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        
                    }label: {
                        Image(systemName: "text.justify")
                            .foregroundStyle(.black)
                    }
                }
                // title
                ToolbarItem (placement: .principal){
                    Text("Chats")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                // trailing
                ToolbarItem (placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    VendoredMessengerChatView()
}

struct VendoredMessengerTextFieldSearchView:View {
    var body: some View {
        HStack {
            // icon
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .foregroundStyle(.gray.opacity(0.8))
            // textfield
            TextField("Search", text: .constant(""))
                .font(.headline)
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .background(Color.vendoredMessengerTextFieldBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct VendoredMessengerStoryView:View {
    // get story data from story data
    var storyDatas:[VendoredMessengerStoryResponse] = vendoredMessengerStoryData
    var body: some View {
        // add scroll to right
        ScrollView (.horizontal, showsIndicators: false){
            LazyHStack (spacing:20){
                // create a call
                VendoredMessengerCreateCallView()
                // load data from story data
                ForEach(storyDatas) { story in
                    VendoredMessengerStoryRowView(story: story)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

struct VendoredMessengerCreateCallView:View {
    var body: some View {
        VStack (spacing: 5){
            // call icon
            ZStack {
                Circle()
                    .fill(Color.vendoredMessengerTextFieldBackgroundColor)
                    .frame(width: 70, height: 70)
                Image(systemName: "video.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
            }
            // text
            Text("Create call")
                .font(.subheadline)
                .frame(width: 60, height: 50)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .padding(.leading)
    }
}

struct VendoredMessengerStoryRowView:View {
    var story:VendoredMessengerStoryResponse
    var body: some View {
        VStack {
            // profile
            ZStack (alignment: .bottomTrailing){
                VendoredMessengerProfileImageView(profileImageUrl: story.user.imgUrl, size: 70)
                // if online show small circle online
                // else show time ago badge
                if story.user.isOnline == 1 {
                    Circle()
                        .fill(Color.vendoredMessengerSucessColor)
                        .frame(width: 18, height: 18)
                        .overlay(Circle().stroke(.white, lineWidth: 2))
                        .offset(x: 0, y: -5)
                } else {
                    Text(story.user.offlineAgo)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.vendoredMessengerSucessColor)
                        .padding(.horizontal, 6)
                        .background(Color.vendoredMessengerSuccessLightColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white, lineWidth: 2))
                }
                
            }
            // name
            Text(story.user.name)
                .font(.subheadline)
                .frame(width: 60, height: 50)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
}

struct VendoredMessengerChatHistoryView:View {
    var chatDatas:[VendoredMessengerChatResponse] = vendoredMessengerChatData
    
    var body: some View {
        LazyVStack (spacing:20){
            ForEach(chatDatas) { chat in
                NavigationLink (destination: VendoredMessengerChatDetailView(chat: chat)){
                    VendoredMessengerChatRowView(chat: chat)
                }
            }
        }
        .padding(.horizontal)
        
    }
}

struct VendoredMessengerChatRowView:View {
    var chat:VendoredMessengerChatResponse
    var body: some View {
        HStack (spacing:16){
            // profile
            // is group and normal user
            if chat.user.isGroup  == 1{
                ZStack (alignment: .bottomTrailing){
                    // two profile
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 50)
                        .offset(x: 10, y: -10)
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgGroupUrl[1], size: 50)
                        .overlay(Circle().stroke(.white, lineWidth: 3))
                        .offset(x: -10, y: 10)
                    // if online show small circle online
                    // else show time ago badge
                    if chat.user.isOnline == 1 {
                        Circle()
                            .fill(Color.vendoredMessengerSucessColor)
                            .frame(width: 18, height: 18)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                            .offset(x: 10, y: 10)
                    } else {
                        Text(chat.user.offlineAgo)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.vendoredMessengerSucessColor)
                            .padding(.horizontal, 6)
                            .background(Color.vendoredMessengerSuccessLightColor)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white, lineWidth: 2))
                    }
                    
                }
                .frame(width: 70, height: 70)
            } else {
                ZStack (alignment: .bottomTrailing){
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgUrl, size: 70)
                    // if online show small circle online
                    // else show time ago badge
                    if chat.user.isOnline == 1 {
                        Circle()
                            .fill(Color.vendoredMessengerSucessColor)
                            .frame(width: 18, height: 18)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                            .offset(x: 0, y: -5)
                    } else {
                        Text(chat.user.offlineAgo)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.vendoredMessengerSucessColor)
                            .padding(.horizontal, 6)
                            .background(Color.vendoredMessengerSuccessLightColor)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white, lineWidth: 2))
                    }
                    
                }
            }
            // info as name, text
            VStack (alignment: .leading, spacing: 0){
                Text(chat.user.name)
                    .font(.headline)
                    .foregroundStyle(.black)
                Text("\(chat.text) - \(chat.timeAgo)")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}


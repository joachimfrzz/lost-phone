//
//  ChatView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 17/9/24.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                // content here
                VStack (spacing: 20){
                    //textfield search
                    TextFieldSearchView()
                    // story view
                    StoryView()
                    // chat history view
                    ChatHistoryView()
                }
                .padding(.vertical)
            }
            // header
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        
                    }label: {
                        Image(systemName: "text.justify")
                    }
                }
                // title
                ToolbarItem (placement: .principal){
                    Text("Chats")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                // trailing
                ToolbarItem (placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }
    }
}

#Preview {
    ChatView()
}

struct TextFieldSearchView:View {
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
        .background(Color.textFieldBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct StoryView:View {
    // get story data from story data
    var storyDatas:[StoryResponse] = storyData
    var body: some View {
        // add scroll to right
        ScrollView (.horizontal, showsIndicators: false){
            LazyHStack (spacing:20){
                // create a call
                CreateCallView()
                // load data from story data
                ForEach(storyDatas) { story in
                    StoryRowView(story: story)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

struct CreateCallView:View {
    var body: some View {
        VStack (spacing: 5){
            // call icon
            ZStack {
                Circle()
                    .fill(Color.textFieldBackgroundColor)
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

struct StoryRowView:View {
    var story:StoryResponse
    var body: some View {
        VStack {
            // profile
            ZStack (alignment: .bottomTrailing){
                ProfileImageView(profileImageUrl: story.user.imgUrl, size: 70)
                // if online show small circle online
                // else show time ago badge
                if story.user.isOnline == 1 {
                    Circle()
                        .fill(Color.sucessColor)
                        .frame(width: 18, height: 18)
                        .overlay(Circle().stroke(.white, lineWidth: 2))
                        .offset(x: 0, y: -5)
                } else {
                    Text(story.user.offlineAgo)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.sucessColor)
                        .padding(.horizontal, 6)
                        .background(Color.successLightColor)
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

struct ChatHistoryView:View {
    var chatDatas:[ChatResponse] = chatData
    
    var body: some View {
        LazyVStack (spacing:20){
            ForEach(chatDatas) { chat in
                NavigationLink (destination: ChatDetailView(chat: chat)){
                    ChatRowView(chat: chat)
                }
            }
        }
        .padding(.horizontal)
        
    }
}

struct ChatRowView:View {
    var chat:ChatResponse
    var body: some View {
        HStack (spacing:16){
            // profile
            // is group and normal user
            if chat.user.isGroup  == 1{
                ZStack (alignment: .bottomTrailing){
                    // two profile
                    ProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 50)
                        .offset(x: 10, y: -10)
                    ProfileImageView(profileImageUrl: chat.user.imgGroupUrl[1], size: 50)
                        .overlay(Circle().stroke(.white, lineWidth: 3))
                        .offset(x: -10, y: 10)
                    // if online show small circle online
                    // else show time ago badge
                    if chat.user.isOnline == 1 {
                        Circle()
                            .fill(Color.sucessColor)
                            .frame(width: 18, height: 18)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                            .offset(x: 10, y: 10)
                    } else {
                        Text(chat.user.offlineAgo)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.sucessColor)
                            .padding(.horizontal, 6)
                            .background(Color.successLightColor)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white, lineWidth: 2))
                    }
                    
                }
                .frame(width: 70, height: 70)
            } else {
                ZStack (alignment: .bottomTrailing){
                    ProfileImageView(profileImageUrl: chat.user.imgUrl, size: 70)
                    // if online show small circle online
                    // else show time ago badge
                    if chat.user.isOnline == 1 {
                        Circle()
                            .fill(Color.sucessColor)
                            .frame(width: 18, height: 18)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                            .offset(x: 0, y: -5)
                    } else {
                        Text(chat.user.offlineAgo)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.sucessColor)
                            .padding(.horizontal, 6)
                            .background(Color.successLightColor)
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


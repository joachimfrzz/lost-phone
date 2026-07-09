//
//  ChatDetailView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 17/9/24.
//

import SwiftUI

struct ChatDetailView: View {
    // back button
    @Environment(\.dismiss) var dismiss
    var chat: ChatResponse
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                // chat scroll
                ScrollView {
                    VStack (spacing: 5){
                        // profile
                        ProfileView(chat: chat)
                        // info
                        InfoView(chat: chat)
                        // chat conversation
                        ChatConversationView(chat: chat)
                    }
                    .padding(.bottom, 60)
                }
                // footer
                FooterView()
            }
            .navigationBarBackButtonHidden(true)
            // title icons
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    HStack {
                        // back button
                        
                        Button {
                            dismiss()
                        }label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 12, height: 12)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.purpleColor)
                        }
                        // profile and info
                        // check if group hide profile
                        if chat.user.isGroup != 1 {
                            ProfileImageView(profileImageUrl: chat.user.imgUrl, size: 35)
                        }
                        VStack (spacing:-2){
                            Text(chat.user.name)
                                .font(.headline)
                            Text("Active now")
                                .font(.subheadline)
                                .foregroundStyle(.black.opacity(0.5))
                        }
                        
                    }
                }
                // call and video icon
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing: 14){
                        // call
                        Button {
                            
                        }label: {
                            Image(systemName: "phone.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 22, height: 22)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.purpleColor)
                        }
                        // video call
                        Button {
                            
                        }label: {
                            HStack (spacing: 10){
                                Image(systemName: "video.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 18, height: 18)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.purpleColor)
                                Circle()
                                    .fill(Color.sucessColor)
                                    .frame(width: 12, height: 12)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ChatDetailView(chat: chatData[2])
}

struct ProfileView:View {
    var chat: ChatResponse
    var body: some View {
        // check two type group or normal user
        if chat.user.isGroup == 1 {
            ZStack (alignment: .bottomTrailing){
                // two profile
                ProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 60)
                    .offset(x: 10, y: -10)
                ProfileImageView(profileImageUrl: chat.user.imgGroupUrl[1], size: 60)
                    .overlay(Circle().stroke(.white, lineWidth: 3))
                    .offset(x: -10, y: 10)
                // if online show small circle online
                // else show time ago badge
                if chat.user.isOnline == 1 {
                    Circle()
                        .fill(Color.sucessColor)
                        .frame(width: 20, height: 20)
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
            .frame(width: 80, height: 80)
        } else {
            // normal user
            ZStack (alignment: .bottomTrailing){
                ProfileImageView(profileImageUrl: chat.user.imgUrl, size: 100)
                // if online show small circle online
                // else show time ago badge
                if chat.user.isOnline == 1 {
                    Circle()
                        .fill(Color.sucessColor)
                        .frame(width: 20, height: 20)
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
    }
}

struct InfoView:View {
    var chat: ChatResponse
    var body: some View {
        VStack {
            Text(chat.user.name)
                .font(.title3)
                .fontWeight(.semibold)
            Text("Facebook")
                .font(.subheadline)
            Text("You're friends on Facebook \n Lives in Cambodia.")
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.5))
                .multilineTextAlignment(.center)
            Text("10:59 PM")
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.4))
                .multilineTextAlignment(.center)
                .padding(.top, 1)
        }
    }
}

struct ChatConversationView:View {
    var chat: ChatResponse
    // load chat conversation from data
    var chatDetail:[ChatDetailResponse] = chatDetailData
    var body: some View {
        LazyVStack (spacing: 10){
            ForEach(chatDetail) { detail in
               //
                switch detail.chatType {
                case 1:
                    TextView(chat: chat, chatDetail: detail)
                case 2:
                    VoiceView(chat: chat, chatDetail: detail)
                case 3:
                    PhotoView(chat: chat, chatDetail: detail)
                case 4:
                    VideoView(chat: chat, chatDetail: detail)
                    
                default:
                    EmptyView()
                }
            }
        }
        .padding()
    }
}

struct TextView:View {
    var chat: ChatResponse
    var chatDetail: ChatDetailResponse
    var body: some View {
        if chatDetail.isMe {
            HStack {
                Spacer()
                BubbleTextView(chatDetails: chatDetail)
            }
        } else {
            HStack (alignment: .bottom){
                if chat.user.isGroup != 1 {
                    ProfileImageView(profileImageUrl: chat.user.imgUrl, size: 30)
                } else {
                    ProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 30)
                }
                BubbleTextView(chatDetails: chatDetail, textColor: .black, backgroundColor: Color.bubbleGrayColor)
               Spacer()
            }
        }
    }
}

struct VoiceView:View {
    var chat: ChatResponse
    var chatDetail: ChatDetailResponse
    var body: some View {
        if chatDetail.isMe {
            HStack {
                Spacer()
                BubbleVoiceView(chatDetails: chatDetail)
            }
        } else {
            HStack (alignment: .bottom){
                if chat.user.isGroup != 1 {
                    ProfileImageView(profileImageUrl: chat.user.imgUrl, size: 30)
                } else {
                    ProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 30)
                }
                BubbleVoiceView(chatDetails: chatDetail, textColor: .black, backgroundColor: Color.bubbleGrayColor)
               Spacer()
            }
        }
    }
}

struct PhotoView:View {
    var chat: ChatResponse
    var chatDetail: ChatDetailResponse
    var body: some View {
        if chatDetail.isMe {
            HStack {
                Spacer()
                Button {
                    
                }label: {
                    ZStack {
                        Circle()
                            .fill(Color.textFieldBackgroundColor)
                            .frame(width: 40)
                        Image(systemName: "square.and.arrow.up")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                    }
                }
                BubblePhotoView(chatDetails: chatDetail)
            }
        } else {
            HStack (alignment: .bottom){
                if chat.user.isGroup != 1 {
                    ProfileImageView(profileImageUrl: chat.user.imgUrl, size: 30)
                } else {
                    ProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 30)
                }
                HStack {
                    BubblePhotoView(chatDetails: chatDetail)
                    Button {
                        
                    }label: {
                        ZStack {
                            Circle()
                                .fill(Color.textFieldBackgroundColor)
                                .frame(width: 40)
                            Image(systemName: "square.and.arrow.up")
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                        }
                    }
                }
               Spacer()
            }
        }
    }
}

struct VideoView:View {
    var chat: ChatResponse
    var chatDetail: ChatDetailResponse
    var body: some View {
        if chatDetail.isMe {
            HStack {
                Spacer()
                Button {
                    
                }label: {
                    ZStack {
                        Circle()
                            .fill(Color.textFieldBackgroundColor)
                            .frame(width: 40)
                        Image(systemName: "square.and.arrow.up")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                    }
                }
                BubbleVideoView(chatDetails: chatDetail)
            }
        } else {
            HStack (alignment: .bottom){
                if chat.user.isGroup != 1 {
                    ProfileImageView(profileImageUrl: chat.user.imgUrl, size: 30)
                } else {
                    ProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 30)
                }
                HStack {
                    BubbleVideoView(chatDetails: chatDetail)
                    Button {
                        
                    }label: {
                        ZStack {
                            Circle()
                                .fill(Color.textFieldBackgroundColor)
                                .frame(width: 40)
                            Image(systemName: "square.and.arrow.up")
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                        }
                    }
                }
               Spacer()
            }
        }
    }
}

struct FooterView:View {
    var body: some View {
        HStack (spacing: 22){
            // location
            Button {
                
            }label: {
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.primaryColor)
            }
            // camera
            Button {
                
            }label: {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 21, height: 21)
                    .foregroundStyle(Color.primaryColor)
            }
            // photo
            Button {
                
            }label: {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.primaryColor)
            }
            // mic
            Button {
                
            }label: {
                Image(systemName: "mic.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color.primaryColor)
            }
            // send message text field
            HStack {
                TextField("Aa", text: .constant(""))
                Spacer()
                Button {
                    
                }label: {
                    Image(systemName: "face.smiling.inverse")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.primaryColor)
                }
            }
            .padding(.horizontal, 10)
            .frame(width: 150, height: 40)
            .background(Color.bubbleGrayColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            // thumb up
            Button {
                
            }label: {
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.primaryColor)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.white)
        .shadow(color: .gray.opacity(0.1),radius: 5)
    }
}




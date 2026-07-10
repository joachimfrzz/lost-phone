//
//  VendoredMessengerChatDetailView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 17/9/24.
//

import SwiftUI

struct VendoredMessengerChatDetailView: View {
    // back button
    @Environment(\.dismiss) var dismiss
    var chat: VendoredMessengerChatResponse
    @State private var messages: [VendoredMessengerChatDetailResponse] = chatDetailData
    @State private var messageText = ""
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                // chat scroll
                ScrollView {
                    VStack (spacing: 5){
                        // profile
                        VendoredMessengerProfileView(chat: chat)
                        // info
                        VendoredMessengerInfoView(chat: chat)
                        // chat conversation
                        VendoredMessengerChatConversationView(messages: messages, chat: chat)
                    }
                    .padding(.bottom, 60)
                }
                // footer
                VendoredMessengerFooterView(messageText: $messageText, onSend: sendMessage)
            }
            .preferredColorScheme(.light)
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
                                .foregroundStyle(Color.vendoredMessengerPurpleColor)
                        }
                        // profile and info
                        // check if group hide profile
                        if chat.user.isGroup != 1 {
                            VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgUrl, size: 35)
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
                                .foregroundStyle(Color.vendoredMessengerPurpleColor)
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
                                    .foregroundStyle(Color.vendoredMessengerPurpleColor)
                                Circle()
                                    .fill(Color.vendoredMessengerSucessColor)
                                    .frame(width: 12, height: 12)
                            }
                        }
                    }
                }
            }
        }
    }

    private func sendMessage() {
        let text = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        messages.append(
            VendoredMessengerChatDetailResponse(
                isMe: true,
                chatType: 1,
                text: text,
                duration: nil,
                mediaUrl: nil
            )
        )
        messageText = ""
    }
}

#Preview {
    VendoredMessengerChatDetailView(chat: vendoredMessengerChatData[2])
}

struct VendoredMessengerProfileView:View {
    var chat: VendoredMessengerChatResponse
    var body: some View {
        // check two type group or normal user
        if chat.user.isGroup == 1 {
            ZStack (alignment: .bottomTrailing){
                // two profile
                VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 60)
                    .offset(x: 10, y: -10)
                VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgGroupUrl[1], size: 60)
                    .overlay(Circle().stroke(.white, lineWidth: 3))
                    .offset(x: -10, y: 10)
                // if online show small circle online
                // else show time ago badge
                if chat.user.isOnline == 1 {
                    Circle()
                        .fill(Color.vendoredMessengerSucessColor)
                        .frame(width: 20, height: 20)
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
            .frame(width: 80, height: 80)
        } else {
            // normal user
            ZStack (alignment: .bottomTrailing){
                VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgUrl, size: 100)
                // if online show small circle online
                // else show time ago badge
                if chat.user.isOnline == 1 {
                    Circle()
                        .fill(Color.vendoredMessengerSucessColor)
                        .frame(width: 20, height: 20)
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
    }
}

struct VendoredMessengerInfoView:View {
    var chat: VendoredMessengerChatResponse
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

struct VendoredMessengerChatConversationView:View {
    var messages: [VendoredMessengerChatDetailResponse]
    var chat: VendoredMessengerChatResponse
    var body: some View {
        LazyVStack (spacing: 10){
            ForEach(messages) { detail in
               //
                switch detail.chatType {
                case 1:
                    VendoredMessengerTextView(chat: chat, chatDetail: detail)
                case 2:
                    VendoredMessengerVoiceView(chat: chat, chatDetail: detail)
                case 3:
                    VendoredMessengerPhotoView(chat: chat, chatDetail: detail)
                case 4:
                    VendoredMessengerVideoView(chat: chat, chatDetail: detail)
                    
                default:
                    EmptyView()
                }
            }
        }
        .padding()
    }
}

struct VendoredMessengerTextView:View {
    var chat: VendoredMessengerChatResponse
    var chatDetail: VendoredMessengerChatDetailResponse
    var body: some View {
        if chatDetail.isMe {
            HStack {
                Spacer()
                VendoredMessengerBubbleTextView(chatDetails: chatDetail)
            }
        } else {
            HStack (alignment: .bottom){
                if chat.user.isGroup != 1 {
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgUrl, size: 30)
                } else {
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 30)
                }
                VendoredMessengerBubbleTextView(chatDetails: chatDetail, textColor: .black, backgroundColor: Color.vendoredMessengerBubbleGrayColor)
               Spacer()
            }
        }
    }
}

struct VendoredMessengerVoiceView:View {
    var chat: VendoredMessengerChatResponse
    var chatDetail: VendoredMessengerChatDetailResponse
    var body: some View {
        if chatDetail.isMe {
            HStack {
                Spacer()
                VendoredMessengerBubbleVoiceView(chatDetails: chatDetail)
            }
        } else {
            HStack (alignment: .bottom){
                if chat.user.isGroup != 1 {
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgUrl, size: 30)
                } else {
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 30)
                }
                VendoredMessengerBubbleVoiceView(chatDetails: chatDetail, textColor: .black, backgroundColor: Color.vendoredMessengerBubbleGrayColor)
               Spacer()
            }
        }
    }
}

struct VendoredMessengerPhotoView:View {
    var chat: VendoredMessengerChatResponse
    var chatDetail: VendoredMessengerChatDetailResponse
    var body: some View {
        if chatDetail.isMe {
            HStack {
                Spacer()
                Button {
                    
                }label: {
                    ZStack {
                        Circle()
                            .fill(Color.vendoredMessengerTextFieldBackgroundColor)
                            .frame(width: 40)
                        Image(systemName: "square.and.arrow.up")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                    }
                }
                VendoredMessengerBubblePhotoView(chatDetails: chatDetail)
            }
        } else {
            HStack (alignment: .bottom){
                if chat.user.isGroup != 1 {
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgUrl, size: 30)
                } else {
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 30)
                }
                HStack {
                    VendoredMessengerBubblePhotoView(chatDetails: chatDetail)
                    Button {
                        
                    }label: {
                        ZStack {
                            Circle()
                                .fill(Color.vendoredMessengerTextFieldBackgroundColor)
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

struct VendoredMessengerVideoView:View {
    var chat: VendoredMessengerChatResponse
    var chatDetail: VendoredMessengerChatDetailResponse
    var body: some View {
        if chatDetail.isMe {
            HStack {
                Spacer()
                Button {
                    
                }label: {
                    ZStack {
                        Circle()
                            .fill(Color.vendoredMessengerTextFieldBackgroundColor)
                            .frame(width: 40)
                        Image(systemName: "square.and.arrow.up")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                    }
                }
                VendoredMessengerBubbleVideoView(chatDetails: chatDetail)
            }
        } else {
            HStack (alignment: .bottom){
                if chat.user.isGroup != 1 {
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgUrl, size: 30)
                } else {
                    VendoredMessengerProfileImageView(profileImageUrl: chat.user.imgGroupUrl[0], size: 30)
                }
                HStack {
                    VendoredMessengerBubbleVideoView(chatDetails: chatDetail)
                    Button {
                        
                    }label: {
                        ZStack {
                            Circle()
                                .fill(Color.vendoredMessengerTextFieldBackgroundColor)
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

struct VendoredMessengerFooterView:View {
    @Binding var messageText: String
    var onSend: () -> Void
    var body: some View {
        HStack (spacing: 22){
            // location
            Button {
                
            }label: {
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.vendoredMessengerVendoredMessengerPrimary)
            }
            // camera
            Button {
                
            }label: {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 21, height: 21)
                    .foregroundStyle(Color.vendoredMessengerVendoredMessengerPrimary)
            }
            // photo
            Button {
                
            }label: {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.vendoredMessengerVendoredMessengerPrimary)
            }
            // mic
            Button {
                
            }label: {
                Image(systemName: "mic.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color.vendoredMessengerVendoredMessengerPrimary)
            }
            // send message text field
            HStack {
                TextField("Aa", text: $messageText)
                    .onSubmit(onSend)
                Spacer()
                Button {
                    
                }label: {
                    Image(systemName: "face.smiling.inverse")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.vendoredMessengerVendoredMessengerPrimary)
                }
            }
            .padding(.horizontal, 10)
            .frame(width: 150, height: 40)
            .background(Color.vendoredMessengerBubbleGrayColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            // thumb up
            Button {
                
            }label: {
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.vendoredMessengerVendoredMessengerPrimary)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color(uiColor: .systemBackground))
        .shadow(color: .gray.opacity(0.1),radius: 5)
    }
}




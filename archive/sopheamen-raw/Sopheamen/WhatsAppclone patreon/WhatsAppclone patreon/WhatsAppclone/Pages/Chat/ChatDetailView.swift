//
//  ChatDetailView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 9/4/24.
//

import SwiftUI

struct ChatDetailView: View {
    @Environment(\.dismiss)  var dismiss
    var chatResponse: ChatResponse
    var chatConversationResponse:[ChatConversationResponse] = chatConversationData
    @State private var sendMessageText = ""
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                Image("chat_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.bottom)
                
                // content chat here
                ScrollView{
                    VStack {
                        // setting header
                        headerSettingView()
                        Spacer()
                        // chat bubble content
                        LazyVStack (spacing: 10){
                            ForEach(chatConversationResponse) { response in
                                BubbleChatView(text: response.text,isMe: response.isMe, timeAgo: response.dateTime, isReaction: response.isReaction ?? nil)
                            }
                        }
                        .padding(.vertical,20)
                        
                    }
                    .padding()
                    .padding(.bottom, 80)
                }
                
                // floating footer view
                VStack {
                    HStack (spacing: 20){
                        // plus button
                        Button {
                            
                        }label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20,height: 20)
                                .foregroundStyle(Color.primaryColor)
                        }
                        // textfield
                        HStack (spacing: 0){

                            TextField("", text: $sendMessageText)
                                .padding(.all,4)
                            Spacer()
                            HStack (spacing: 20){
                                Button {
                                    
                                } label: {
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20,height: 20)
                                        .foregroundStyle(Color.primaryColor)
                                }
                            }
                            
                        }
                        .padding(.horizontal,12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(.gray.opacity(0.3)))

                        // button icons view
                        Button {
                            
                        } label: {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFill()
                                .frame(width:20, height: 20)
                                .foregroundStyle(Color.primaryColor)
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "mic")
                                .resizable()
                                .scaledToFill()
                                .frame(width:15, height: 15)
                                .foregroundStyle(Color.primaryColor)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 85)
                .background(.white)
               
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                           Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.primaryColor)
                                .padding(.top,4)
                        }
                        
                        HStack (spacing: 10){
                            ProfileImageView(profileImage: chatResponse.user.profileUrl, size: 40)
                            Text(chatResponse.user.name)
                                .font(.headline)
                            
                        }
                        

                    }
                }
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing: 20){
                        Button {
                            
                        }label: {
                           Image(systemName: "video")
                                .resizable()
                                .scaledToFill()
                                .frame(width:18, height: 18)
                        }
                        .padding(.top, 3)
                        Button {
                            
                        }label: {
                           Image(systemName: "phone")
                                .resizable()
                                .scaledToFill()
                                .frame(width:22, height: 20)
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    ChatDetailView(chatResponse: chatData[0])
}

struct headerSettingView: View {
    var body: some View {
        VStack (spacing: 12){
            Text("Today")
                .font(.footnote)
                .padding(.vertical, 2)
                .padding(.horizontal)
                .background(Color.todayChatBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack (alignment: .top,spacing: 10){
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width:8, height: 8)
                    .padding(.top, 6)
                Text("Messages and calls are end-to-end encrypted. No one outside of this chat, not even WhatsApp, can read or listen to them. Tap to learn more.")
                    .font(.footnote)
                    
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            .background(Color.settingChatBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 30)
               
            
        }
    }
}

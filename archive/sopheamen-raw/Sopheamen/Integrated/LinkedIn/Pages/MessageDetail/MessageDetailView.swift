//
//  MessageDetailView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 30/4/24.
//

import SwiftUI

struct MessageDetailView: View {
    @Environment(\.dismiss) var dismiss
    var message: MessageResponse
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                // content
                ScrollView(showsIndicators: false) {
                    VStack (spacing:20){
                        // profile section
                        ProfileHeaderView(message: message)
                        
                        // chat content
                        ChatHistoryView(message: message)
                        
                    }
                    .padding(.top,20)
                    .padding(.bottom,100)
                    .padding(.horizontal)
                }
                
                // footer
                FooterView()
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(.white)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        // back button
                        Button {
                            dismiss()
                        }label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 17, height: 17)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                        // fullname
                        Text(message.user.fullname)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack (spacing:15){
                        // icon
                        Button {
                            
                        }label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 4, height: 4)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                        // icon
                        Button {
                            
                        }label: {
                            Image(systemName: "video.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                        // icon
                        Button {
                            
                        }label: {
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(.black.opacity(0.8))
                                .fontWeight(.semibold)
                        }
                       
                    }
                }
            }
        }
    }
}

#Preview {
    MessageDetailView(message: messagesData[0])
}

struct ProfileHeaderView: View {
    var message:MessageResponse
    var body: some View {
        VStack (alignment: .leading,spacing:5){
            // profile
            ProfileImageView(profileImage: message.user.profileImage, size: 70)
            HStack (spacing:0){
                Text(message.user.fullname)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(" - 2nd")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.8))
            }
            Text("\(message.user.headLineBio) At \(message.user.companyLocation ?? "")")
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ChatHistoryView: View {
    var message:MessageResponse
    var messagesDetailDatas:[MessageDetailResponse] = messagesDetailData
    var body: some View {
        VStack (spacing:20){
            // date and line
            HStack {
                Line()
                   .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
                   .frame(height: 1)
                   .foregroundStyle(.gray.opacity(0.5))
                Spacer()
                Text("Saturday")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black.opacity(0.5))
                    .textCase(.uppercase)
                Spacer()
                Line()
                   .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
                   .frame(height: 1)
                   .foregroundStyle(.gray.opacity(0.5))
            }
            // content
            LazyVStack (spacing:20){
                ForEach(messagesDetailDatas) { messageDetail in
                    MessageViewRow(message: message, messageDetail: messageDetail)
                }
            }
            // button
            HStack (spacing:12){
                Button {
                    
                }label: {
                    Text("You're welcome")
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.primaryColor))
                }
                
                Button {
                    
                }label: {
                    Text("My pleasure")
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.primaryColor))
                }
            }
            
        }
    }
}

struct MessageViewRow: View {
    var message:MessageResponse
    var messageDetail: MessageDetailResponse
    var body: some View {
        HStack (alignment: .top,spacing:12){
            ProfileImageView(profileImage: messageDetail.isMe ? userDataCurrent.profileImage : message.user.profileImage, size: 40)
                .padding(.top,5)
            VStack (alignment: .leading){
                HStack (spacing: 0){
                    Text(messageDetail.isMe ? userDataCurrent.fullname : message.user.fullname)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(" - \(messageDetail.time)")
                        .font(.footnote)
                        .foregroundStyle(.black.opacity(0.7))
                }
                Text(messageDetail.text)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct FooterView:View {
    @State private var writeMessage = ""
    var body: some View {
        HStack {
            HStack {
                Button {
                    
                }label: {
                    Image(systemName: "paperclip")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 19, height: 19)
                        .foregroundStyle(.black.opacity(0.8))
                        .fontWeight(.semibold)
                }
                
                // textfield
                TextField("Write a message...", text: $writeMessage)
                    .padding(.horizontal,10)
                    .frame(height: 40)
                    .background(Color.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: AppSetting.smallRadius))
                    .padding(.horizontal,AppSetting.smallPadding)
                
                // voice
                Button {
                    
                }label: {
                    Image(systemName: "mic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.black.opacity(0.8))
                        .fontWeight(.semibold)
                }
                
            }
            .padding(.top,-20)
        
            
        }
        .padding(.horizontal)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .frame(height: 80)
        .background(.white)
        .overlay(RoundedRectangle(cornerRadius: 0).stroke(.gray.opacity(0.15)))
       
       
    }
}

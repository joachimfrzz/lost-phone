//
//  ChatView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 18/5/24.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottomTrailing){
                ScrollView {
                    // load chat item
                    ContactView()
                }
                
                // floating button
                Button {
                    
                }label: {
                    ZStack {
                        Circle()
                            .fill(Color.buttonPrimaryColor)
                            .frame(width:60, height: 60)
                            .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 2)
                        Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 22,height:22)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    
                }
                .padding(.horizontal,20)
                .padding(.vertical)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .principal) {
                    CustomToolbar(title: "Chat")
                }
            }
        }
    }
}

#Preview {
    ChatView()
}

struct ContactView: View {
    var userDatas:[UserSnapchatResponse] = userSnapchatData
    var body: some View {
        LazyVStack (spacing:12){
            ForEach(userDatas) { chat in
                NavigationLink(destination: SnapchatChatDetailView(user: chat)) {
                VStack (alignment: .leading){
                    HStack {
                        ProfileImageView(profileImage: chat.profileImage, size: 55)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1))
                            
                        VStack (alignment: .leading,spacing:0){
                            Text(chat.fullname)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                            // icon and tap to chat
                            HStack {
                                Image(systemName: "arrowtriangle.forward.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 10,height:10)
                                    .foregroundStyle(.gray.opacity(0.4))
                                    .padding(.top,2)
                                Text("Tap to chat")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
                
                // divider
                Divider()
                    .background(.white)
                
            }
        }
        .padding(.vertical)
       
    }
}

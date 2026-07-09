//
//  SettingView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 8/4/24.
//

import SwiftUI

struct SettingView: View {
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack {
            ScrollView {
               

                VStack (spacing: 30){
                    ProfileAndAvatarView()
                    StarredView()
                    AccountView()
                    HelpAndFriendView()
                }
                .padding(.vertical,20)
                
               
            }
            .navigationTitle("Settings")
            .background(Color.backgroundColor)
           
           
            
        }
       
    }
}

#Preview {
    SettingView()
}

struct ProfileAndAvatarView: View {
    var body: some View {
        VStack {
            HStack (spacing: 12){
                ProfileImageView(profileImage: currentUserData.profileUrl, size: 60)
                    .frame(width: 60)
               
               
                VStack (alignment: .leading, spacing: -5){
                    Text(currentUserData.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Hey there! I am using Whatsapp.")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
              
               
                
               
                Image(systemName: "qrcode")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18,height: 18)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.primaryColor)
                    .padding(.all, 12)
                    .background(Color.backgroundColor)
                    .clipShape(Circle())
                    
                
            }
            .frame(maxWidth: .infinity)
            Divider()
            SettingRowView(icon: "face.smiling.inverse", iconSize: 18,title: "Avatar", backgroundColor: Color.avatarColor)
            
            
        }
        .padding(.horizontal,16)
        .padding(.vertical,10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct StarredView: View {
    var body: some View {
        VStack (spacing: 10){
            SettingRowView(icon: "star.fill", iconSize: 18,title: "Starred Messages", backgroundColor: Color.starredMessageColor)
            Divider()
                .padding(.leading, 45)
            SettingRowView(icon: "tv", iconSize: 17, title: "Linked Devices", backgroundColor: Color.linkedDeviceColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct AccountView: View {
    var body: some View {
        VStack (spacing: 10){
            SettingRowView(icon: "key.fill",iconSize: 11, title: "Account", backgroundColor: Color.accountColor)
            Divider()
                .padding(.leading, 45)
            SettingRowView(icon: "lock.fill", title: "Privacy", backgroundColor: Color.privacyColor)
            Divider()
                .padding(.leading, 45)
            SettingRowView(icon: "ellipsis.bubble.fill",iconSize: 18, title: "Chats", backgroundColor: Color.chatColor)
            Divider()
                .padding(.leading, 45)
            SettingRowView(icon: "bell.badge",iconSize: 18, title: "Notifications", backgroundColor: Color.notificationColor)
            Divider()
                .padding(.leading, 45)
            SettingRowView(icon: "folder.fill",iconSize: 15, title: "Storage and Data", backgroundColor: Color.storageDataColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct HelpAndFriendView: View {
    var body: some View {
        VStack (spacing: 10){
            SettingRowView(icon: "info", iconSize: 8,title: "Help", backgroundColor: Color.helpColor)
            Divider()
                .padding(.leading, 45)
            SettingRowView(icon: "heart.fill", iconSize: 17, title: "Tell a Friend", backgroundColor: Color.tellFriendColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

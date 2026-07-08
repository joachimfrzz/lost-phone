//
//  VendoredWhatsAppSettingView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 8/4/24.
//

import SwiftUI

struct VendoredWhatsAppSettingView: View {
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack {
            ScrollView {
               

                VStack (spacing: 30){
                    VendoredWhatsAppProfileAndAvatarView()
                    VendoredWhatsAppStarredView()
                    VendoredWhatsAppAccountView()
                    VendoredWhatsAppHelpAndFriendView()
                }
                .padding(.vertical,20)
                
               
            }
            .navigationTitle("Settings")
            .background(Color.vendoredWhatsAppBackgroundColor)
           
           
            
        }
       
    }
}

#Preview {
    VendoredWhatsAppSettingView()
}

struct VendoredWhatsAppProfileAndAvatarView: View {
    var body: some View {
        VStack {
            HStack (spacing: 12){
                VendoredWhatsAppProfileImageView(profileImage: currentUserData.profileUrl, size: 60)
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
                    .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                    .padding(.all, 12)
                    .background(Color.vendoredWhatsAppBackgroundColor)
                    .clipShape(Circle())
                    
                
            }
            .frame(maxWidth: .infinity)
            Divider()
            VendoredWhatsAppSettingRowView(icon: "face.smiling.inverse", iconSize: 18,title: "Avatar", backgroundColor: Color.vendoredWhatsAppAvatarColor)
            
            
        }
        .padding(.horizontal,16)
        .padding(.vertical,10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct VendoredWhatsAppStarredView: View {
    var body: some View {
        VStack (spacing: 10){
            VendoredWhatsAppSettingRowView(icon: "star.fill", iconSize: 18,title: "Starred Messages", backgroundColor: Color.vendoredWhatsAppStarredMessageColor)
            Divider()
                .padding(.leading, 45)
            VendoredWhatsAppSettingRowView(icon: "tv", iconSize: 17, title: "Linked Devices", backgroundColor: Color.vendoredWhatsAppLinkedDeviceColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct VendoredWhatsAppAccountView: View {
    var body: some View {
        VStack (spacing: 10){
            VendoredWhatsAppSettingRowView(icon: "key.fill",iconSize: 11, title: "Account", backgroundColor: Color.vendoredWhatsAppAccountColor)
            Divider()
                .padding(.leading, 45)
            VendoredWhatsAppSettingRowView(icon: "lock.fill", title: "Privacy", backgroundColor: Color.vendoredWhatsAppPrivacyColor)
            Divider()
                .padding(.leading, 45)
            VendoredWhatsAppSettingRowView(icon: "ellipsis.bubble.fill",iconSize: 18, title: "Chats", backgroundColor: Color.vendoredWhatsAppChatColor)
            Divider()
                .padding(.leading, 45)
            VendoredWhatsAppSettingRowView(icon: "bell.badge",iconSize: 18, title: "Notifications", backgroundColor: Color.vendoredWhatsAppNotificationColor)
            Divider()
                .padding(.leading, 45)
            VendoredWhatsAppSettingRowView(icon: "folder.fill",iconSize: 15, title: "Storage and Data", backgroundColor: Color.vendoredWhatsAppStorageDataColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct VendoredWhatsAppHelpAndFriendView: View {
    var body: some View {
        VStack (spacing: 10){
            VendoredWhatsAppSettingRowView(icon: "info", iconSize: 8,title: "Help", backgroundColor: Color.vendoredWhatsAppHelpColor)
            Divider()
                .padding(.leading, 45)
            VendoredWhatsAppSettingRowView(icon: "heart.fill", iconSize: 17, title: "Tell a Friend", backgroundColor: Color.vendoredWhatsAppTellFriendColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

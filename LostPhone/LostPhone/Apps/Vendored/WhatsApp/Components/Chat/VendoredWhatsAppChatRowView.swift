//
//  VendoredWhatsAppChatRowView.swift
//  WhatsAppclone
//  Created by Sopheamen VAN on 8/4/24.
//

import SwiftUI

struct VendoredWhatsAppChatRowView: View {
    var chatResponse: VendoredWhatsAppChatResponse
    var body: some View {

        HStack (spacing: 5){
            VendoredWhatsAppProfileImageView(profileImage: chatResponse.user.profileUrl, size: 60)
                .overlay(Circle().stroke(.gray.opacity(0.15)))
                
            VStack (alignment: .leading,spacing: 0){
                Text(chatResponse.user.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.black)
                HStack (spacing: 6){
                    VendoredWhatsAppIconTypeView(type: chatResponse.type)
                    Text(chatResponse.text ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.6))
                        .fontWeight(.regular)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.leading, 10)
            
            VStack (alignment: .trailing,spacing: -3){
                if chatResponse.badgeNumber != nil {
                    Text(chatResponse.timeAgo)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }else {
                    Text(chatResponse.timeAgo)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.black.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                if let badgeNumber = chatResponse.badgeNumber, badgeNumber > 0 {
                    ZStack {
                        Circle()
                                .fill(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                                .frame(width: 22,height: 22)
                                
                            Text("\(badgeNumber)")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                    }
                    .padding(.top, 8)
                }
                
            }
            .frame(width: 80)
            
            
        }
           
    }
}

#Preview {
    VendoredWhatsAppChatRowView(chatResponse: chatData[0])
}

struct VendoredWhatsAppIconTypeView: View {
    var type: Int
    var body: some View {
        switch type {
        case 1:
            Image(systemName: "checkmark")
                .resizable()
                .scaledToFill()
                .frame(width: 12,height: 12)
                .foregroundStyle(.gray)
                .padding(.top,3)
        case 2:
            Image(systemName: "phone.arrow.down.left.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 13,height: 13)
                .foregroundStyle(Color.vendoredWhatsAppDangerColor)
                .padding(.top,3)
        case 3:
            Image(systemName: "mic.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 10,height: 10)
                .foregroundStyle(Color.vendoredWhatsAppChatColor)
                .padding(.top,3)
        default:
            Text("Empty")
        }
    }
}

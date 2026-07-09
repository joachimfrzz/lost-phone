//
//  VendoredWhatsAppCallProfileView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 8/4/24.
//

import SwiftUI

struct VendoredWhatsAppCallProfileView: View {
    let callResponse:VendoredWhatsAppCallResponse
   

    var body: some View {
        VStack (spacing:8){
            HStack (spacing: 10){
                VendoredWhatsAppProfileImageView(profileImage: callResponse.user.profileUrl, size: 45)
                    .overlay(Circle().stroke(.gray.opacity(0.2)))
                VStack (alignment: .leading,spacing: -3){
                    Text(callResponse.user.name)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(callResponse.type == 1 ? Color.vendoredWhatsAppDangerColor : .black)
                    
                    HStack (spacing: callResponse.callType == 1 ? 6 : 10){
                        Image(systemName: callResponse.callType == 1 ? "phone.fill" : "video.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: callResponse.callType == 1 ? 14 : 12,height: callResponse.callType == 1 ? 14 : 12)
                            .foregroundStyle(.gray.opacity(0.8))
                        
                        switch callResponse.type {
                        case 1:
                            Text("Missed")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        case 2:
                            Text("Incoming")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        case 3:
                            Text("Outgoing")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        default:
                            Text("Not found")
                        }
                       
                    }
                }
                Spacer()
                HStack (spacing: 10){
                    Text(callResponse.time)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                    
                }
                
            }
            Divider()
                .padding(.leading, 55)
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 12)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .background(.white)
       
    }
}

#Preview {
    VendoredWhatsAppCallProfileView(callResponse: callData[0])
}



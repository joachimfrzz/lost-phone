//
//  VendoredInstagramUserMessagingRowView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 21/3/24.
//

import SwiftUI

struct VendoredInstagramUserMessagingRowView: View {
    let profileImageUrl: String
    let username: String
    let lastModifierDate: String
    var body: some View {
        HStack (spacing: 12){
            VendoredInstagramProfileImageView(profileImage: profileImageUrl, size: 55)
                .overlay(RoundedRectangle(cornerRadius: 55/2).stroke(.black.opacity(0.1)))
            VStack (alignment: .leading, spacing: -2){
                HStack (spacing: 5){
                    Text(username)
                        .font(.subheadline)
                        .fontWeight(.regular)
                    Image("verified")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 16, height: 16)
                        
                }
                Text("Sent \(lastModifierDate)")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "camera")
                .resizable()
                .scaledToFill()
                .frame(width: 18, height: 18)
                .foregroundStyle(.black.opacity(0.5))
                
        }
    }
}

#Preview {
    VendoredInstagramUserMessagingRowView(profileImageUrl: userDataCurrent.profileImage, username: userDataCurrent.fullname, lastModifierDate: "1h ago")
}

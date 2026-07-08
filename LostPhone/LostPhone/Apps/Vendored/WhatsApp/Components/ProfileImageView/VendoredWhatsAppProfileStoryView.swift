//
//  VendoredWhatsAppProfileStoryView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 4/4/24.
//

import SwiftUI

struct VendoredWhatsAppProfileStoryView: View {
    
    var body: some View {
        ZStack {
            VendoredWhatsAppProfileImageView(profileImage: currentUserData.profileUrl, size: 60)
            Button {
                
            }label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 23,height: 23)
                    .background(.white)
                    .clipShape(Circle())
                    .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                    .overlay(Circle().stroke(.white, lineWidth: 2))
            }
            .offset(x: 25,y: 18)
                
            
        }
        .frame(width: 60,height: 60)
    }
}

#Preview {
    VendoredWhatsAppProfileStoryView()
}

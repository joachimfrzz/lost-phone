//
//  VendoredWhatsAppProfileImageView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 4/4/24.
//

import SwiftUI
import Kingfisher

struct VendoredWhatsAppProfileImageView: View {
    let profileImage:String
    let size: CGFloat
    var body: some View {
        KFImage(URL(string: profileImage))
            .resizable()
            .scaledToFill()
            .frame(width: size,height: size)
            .clipShape(Circle())
        
    }
}

#Preview {
    VendoredWhatsAppProfileImageView(profileImage: currentUserData.profileUrl, size: 60)
}

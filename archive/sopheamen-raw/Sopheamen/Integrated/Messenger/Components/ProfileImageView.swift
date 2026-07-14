//
//  ProfileImageView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 16/9/24.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let profileImageUrl: String
    let size: CGFloat
    
    var body: some View {
        KFImage(URL(string: profileImageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

#Preview {
    ProfileImageView(profileImageUrl: userData[0].imgUrl, size: 40)
}

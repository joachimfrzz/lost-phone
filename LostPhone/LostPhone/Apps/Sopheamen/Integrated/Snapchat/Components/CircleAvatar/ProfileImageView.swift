//
//  ProfileImageView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 20/5/24.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let profileImage:String
    let size: CGFloat
    var body: some View {
        Image(profileImage)
            .resizable()
            .scaledToFill()
            .frame(width: size,height: size)
            .clipShape(Circle())
            
        
    }
}

#Preview {
    ProfileImageView(profileImage: userDataCurrent.profileImage, size: 40)
}

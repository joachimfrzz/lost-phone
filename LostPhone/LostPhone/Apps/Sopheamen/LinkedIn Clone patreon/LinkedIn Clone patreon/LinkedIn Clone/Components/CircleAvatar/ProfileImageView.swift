//
//  ProfileImageView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 24/4/24.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let profileImage:String
    let size: CGFloat
    var body: some View {
        KFImage(URL(string: profileImage))
                   .resizable()
                   .scaledToFill()
                   .frame(width: size, height: size)
                   .clipShape(Circle())
                   .overlay(RoundedRectangle(cornerRadius: size-1).stroke(.gray.opacity(0.3)))
    }
}

#Preview {
    ProfileImageView(profileImage: userDataCurrent.profileImage, size: 40)
}


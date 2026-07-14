//
//  ProfileImageRectangleView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 24/4/24.
//

import SwiftUI
import Kingfisher

struct ProfileImageRectangleView: View {
    let profileImage:String
    let size: CGFloat
    var body: some View {
        KFImage(URL(string: profileImage))
                   .resizable()
                   .scaledToFill()
                   .frame(width: size, height: size)
                   .clipped()
                   .overlay(RoundedRectangle(cornerRadius: 0).stroke(.gray.opacity(0.3)))
    }
}

#Preview {
    ProfileImageRectangleView(profileImage: userDataCurrent.profileImage, size: 40)
}

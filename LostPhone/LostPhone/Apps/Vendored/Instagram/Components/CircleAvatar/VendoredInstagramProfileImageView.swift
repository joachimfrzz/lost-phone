//
//  VendoredInstagramProfileImageView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 16/3/24.
//

import SwiftUI
import Kingfisher

struct VendoredInstagramProfileImageView: View {
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
    VendoredInstagramProfileImageView(profileImage: vendoredInstagramUserDataCurrent.profileImage, size: 40)
}

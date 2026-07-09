//
//  VendoredInstagramCircleAvatarProfileBigView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI
import Kingfisher

struct VendoredInstagramCircleAvatarProfileBigView: View {
    var profileUrl: String
    var width, height: Double
    var lineWidth:Double? = 5
    var body: some View {
        KFImage(URL(string: profileUrl))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: lineWidth ?? 5))
            .shadow(radius: 10)
    }
}

#Preview {
    VendoredInstagramCircleAvatarProfileBigView(profileUrl: vendoredInstagramUserDataCurrent.profileImage, width: 200, height: 200)
}

//
//  VendoredInstagramAddStoryView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 9/3/24.
//

import SwiftUI
import Kingfisher

struct VendoredInstagramStoryView: View {
   let profileUrl: String
   let storyText: String
       
       var body: some View {
           VStack (spacing: 5){
               ZStack {
                   Circle()
                       .gradientBorder(width: 4.5, colors: [Color.vendoredInstagramGradientOrange, Color.vendoredInstagramGradientOrange, Color.vendoredInstagramGradientPurple, Color.vendoredInstagramGradientOrange,Color.yellow])
                       .frame(width: 81, height: 81)
                               
                   Circle()
                       .strokeBorder(.white, lineWidth: 4)
                       .frame(width: 74, height: 74) // Making this
                   KFImage(URL(string: profileUrl))
                       .resizable()
                       .scaledToFill()
                       .frame(width: 70,height: 70)
                       .clipShape(Circle())
               }

              Text(storyText)
                  .font(.caption)
                  .frame(width: 60)
                  .lineLimit(1)
           }
       }
}

#Preview {
    VendoredInstagramStoryView(profileUrl: vendoredInstagramUserDataCurrent.profileImage, storyText: vendoredInstagramUserDataCurrent.fullname)
}

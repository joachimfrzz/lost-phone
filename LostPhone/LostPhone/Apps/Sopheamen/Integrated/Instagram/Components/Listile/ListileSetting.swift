//
//  ListtileSetting.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 19/3/24.
//

import SwiftUI

struct ListileSetting: View {
    let icon:String
    let title: String
    let isNewBadgeIcon: Bool?
    var body: some View {
        HStack (alignment: .top,spacing: 18){
            Image(icon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.black)
                .frame(width: 22, height: 22)
            VStack (alignment: .leading,spacing: 12){
                
                HStack{
                    Text(title)
                        .font(.subheadline)
                    Spacer()
                    if isNewBadgeIcon ?? true {
                        Text("NEW")
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                            .background(Color.primaryColor)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.trailing, 14)
                    }
                }
                Divider()
            }
            
           
            
        }
    }
}

#Preview {
    ListileSetting(icon: "comment_icon", title: "Settings and privacy", isNewBadgeIcon: false)
}

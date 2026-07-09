//
//  VendoredSnapchatCircleProfileTextView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 21/5/24.
//

import SwiftUI

struct VendoredSnapchatCircleProfileTextView: View {
    var image:String
    var title: String
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .offset(x:0,y:5)
                .padding(.all,6)
                .background(.white.opacity(0.4))
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 10))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            Text(title)
                .font(.footnote)
                .bold()
                .foregroundStyle(.black)
                .padding(.vertical,0)
                .padding(.horizontal,10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(x:0,y:35)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
       
        
    }
}

#Preview {
    VendoredSnapchatCircleProfileTextView(image: vendoredSnapchatUserDataCurrent.profileImage, title: "My Bitmoji")
}

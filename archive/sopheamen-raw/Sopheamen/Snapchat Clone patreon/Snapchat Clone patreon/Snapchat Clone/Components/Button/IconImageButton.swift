//
//  IconImageButton.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 29/5/24.
//

import SwiftUI

struct IconImageButton: View {
    var imageName: String
    var size: CGFloat?
    var circleSize: CGFloat?
    var backgroundColor: Color?
    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor ?? Color.black.opacity(0.08))
                .frame(width: circleSize ?? 37, height: circleSize ?? 37)
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: size ?? 16, height:size ?? 16)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    IconImageButton(imageName: "earth_icon",backgroundColor: Color.iconBlueColor)
}

//
//  IconButtonOpacity.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 21/5/24.
//

import SwiftUI

struct IconButtonOpacity: View {
    var iconName: String
    var size: CGFloat?
    var circleSize: CGFloat?
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.08))
                .frame(width: circleSize ?? 37, height: circleSize ?? 37)
            Image(systemName: iconName)
                .resizable()
                .scaledToFill()
                .foregroundStyle(.white)
                .frame(width: size ?? 16, height:size ?? 16)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    IconButtonOpacity(iconName: "magnifyingglass")
}

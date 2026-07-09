//
//  IconButton.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 20/5/24.
//

import SwiftUI

struct IconButton: View {
    var iconName: String
    var size: CGFloat?
    var iconColor: Color?
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.backgroundIconOpacity)
                .frame(width: 37, height: 37)
            Image(systemName: iconName)
                .resizable()
                .scaledToFill()
                .foregroundStyle(iconColor ?? .black.opacity(0.5))
                .frame(width: size ?? 16, height:size ?? 16)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    IconButton(iconName: "magnifyingglass")
}

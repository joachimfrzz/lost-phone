//
//  CustomToolbar.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 20/5/24.
//

import SwiftUI

struct CustomToolbar:View {
    var title: String
    var body: some View {
        HStack {
            HStack {
                ProfileImageView(profileImage: userDataCurrent.profileImage, size: 35)
                    .overlay(Circle().stroke(Color.gray.opacity(0.1), lineWidth: 3))
                IconButton(iconName: "magnifyingglass")
            }
            Spacer()
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                IconButton(iconName: "person.fill")
                IconButton(iconName: "ellipsis", size: 4)
            }
        }
        
    }
}

#Preview {
    CustomToolbar(title: "Chats")
}

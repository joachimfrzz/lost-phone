//
//  VendoredSnapchatCustomToolbar.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 20/5/24.
//

import SwiftUI

struct VendoredSnapchatCustomToolbar:View {
    var title: String
    var body: some View {
        HStack {
            HStack {
                VendoredSnapchatProfileImageView(profileImage: userDataCurrent.profileImage, size: 35)
                    .overlay(Circle().stroke(Color.gray.opacity(0.1), lineWidth: 3))
                VendoredSnapchatIconButton(iconName: "magnifyingglass")
            }
            Spacer()
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                VendoredSnapchatIconButton(iconName: "person.fill")
                VendoredSnapchatIconButton(iconName: "ellipsis", size: 4)
            }
        }
        
    }
}

#Preview {
    VendoredSnapchatCustomToolbar(title: "Chats")
}

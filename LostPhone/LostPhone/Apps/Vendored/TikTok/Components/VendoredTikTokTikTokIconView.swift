//
//  VendoredTikTokTikTokIconView.swift
//  Youtube_Tiktok
//
//  Created by Sopheamen VAN on 11/10/24.
//

import SwiftUI

// enum load custom font // TikTokIcons
enum VendoredTikTokTikTokIcon: String {
    case heart = "\u{E80A}"
    case comment = "\u{E808}"
    case saved = "\u{E80C}"
    case repost = "\u{E80E}"
    case search = "\u{E80F}"
}

struct VendoredTikTokTikTokIconView: View {
    var icon: VendoredTikTokTikTokIcon
    var size: CGFloat = 30
    var color: Color = .black
    
    var body: some View {
        if icon == .saved {
            Image(systemName: "bookmark.fill")
                .resizable()
                .frame(width: size, height: size)
                .foregroundStyle(color)
        } else {
            Text(icon.rawValue)
                .font(.custom("TikTokIcons", size: size))
                .foregroundStyle(color)
        }
    }
}


#Preview {
    VendoredTikTokTikTokIconView(icon: VendoredTikTokTikTokIcon.heart)
}

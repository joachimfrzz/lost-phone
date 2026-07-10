//
//  VendoredTikTokTikTokIconView.swift
//  Youtube_Tiktok
//
//  Created by Sopheamen VAN on 11/10/24.
//

import SwiftUI
import UIKit

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
    var color: Color = .white

    private var systemFallback: String {
        switch icon {
        case .heart: return "heart.fill"
        case .comment: return "bubble.right.fill"
        case .saved: return "bookmark.fill"
        case .repost: return "arrow.2.squarepath"
        case .search: return "magnifyingglass"
        }
    }

    var body: some View {
        if UIFont(name: "TikTokIcons", size: size) != nil, icon != .saved {
            Text(icon.rawValue)
                .font(.custom("TikTokIcons", size: size))
                .foregroundStyle(color)
        } else {
            Image(systemName: systemFallback)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(color)
        }
    }
}


#Preview {
    VendoredTikTokTikTokIconView(icon: VendoredTikTokTikTokIcon.heart)
}

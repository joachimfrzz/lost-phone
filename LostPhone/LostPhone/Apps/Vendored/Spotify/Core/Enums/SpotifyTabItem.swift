//
//  CustomTab.swift
//  SwiftUIClones
//
//  Created by ladans on 16/08/25.
//

import Foundation

enum VendoredSpotifySpotifyTabItem: String, CaseIterable {
    case home
    case reels
    case search
    case premium
    case create

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .reels: return "play.diamond"
        case .search: return "magnifyingglass"
        case .premium: return "headphones.dots"
        case .create: return "plus"
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .reels: return "Reels"
        case .premium: return "Premium"
        case .create: return "Create"
        }
    }
}

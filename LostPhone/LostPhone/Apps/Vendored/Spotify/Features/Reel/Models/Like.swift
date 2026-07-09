//
//  VendoredSpotifyLike.swift
//  SpotifySwiftUI
//
//  Created by ladans on 28/08/25.
//

import Foundation

struct VendoredSpotifyLike: Identifiable {
    let id: UUID
    let tappedRect: CGPoint
    var isAnimated: Bool

    init(id: UUID = .init(), tappedRect: CGPoint = .init(), isAnimated: Bool = false) {
        self.id = id
        self.tappedRect = tappedRect
        self.isAnimated = isAnimated
    }
}

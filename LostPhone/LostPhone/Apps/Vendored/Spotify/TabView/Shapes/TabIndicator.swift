//
//  VendoredSpotifyTabIndicator.swift
//  SwiftUIClones
//
//  Created by ladans on 16/08/25.
//

import SwiftUI

struct VendoredSpotifyTabIndicator: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 10, height: 10)
        )
        
        return Path(path.cgPath)
    }
}

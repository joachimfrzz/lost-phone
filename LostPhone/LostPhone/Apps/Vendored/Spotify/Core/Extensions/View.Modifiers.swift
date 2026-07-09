//
//  SelectedItemStyle.swift
//  SwiftUIClones
//
//  Created by ladans on 12/08/25.
//

import SwiftUI

extension View {
    func tileStyle(isSelected: Bool = false) -> some View {
        modifier(VendoredSpotifyTileModifier(isSelected: isSelected))
    }
    
    /// Sets the width and height of the view to the given percentage of the available values.
    func relativeSize(width: Double?, height: Double?) -> some View {
        self.modifier(RelativeFrameModifier(widthPercent: width, heightPercent: height))
    }
}

struct VendoredSpotifyTileModifier: ViewModifier {
    let isSelected: Bool
    func body(content: Content) -> some View {
        content
            .background(isSelected ? .spotifyGreen : .spotifyDarkGrey)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
    }
}

private struct RelativeFrameModifier: ViewModifier {
    let widthPercent: Double?
    let heightPercent: Double?

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let width = widthPercent.map { CGFloat(geometry.size.width * ($0 / 100)) }
            let height = heightPercent.map { CGFloat(geometry.size.height * ($0 / 100)) }

            content
                .frame(width: width, height: height, alignment: .center)
        }
    }
}

//
//  ColorUtils.swift
//  SwiftUIClones
//
//  Created by ladans on 17/08/25.
//

import Foundation

import SwiftUI


@ViewBuilder
func DynamicBackgroundGradient(
    _ color: Color,
    progress: CGFloat? = nil,
) -> some View {
    let blackOpacity: CGFloat = progress != nil ? progress! : 1.0
    let randomColorOpacity: CGFloat = 1.0 - (progress != nil ? progress! : 0.0)
    
    LinearGradient(
        gradient: Gradient(
            stops: [
                .init(color: color.opacity(randomColorOpacity), location: 0.0),
                .init(color: color.opacity(randomColorOpacity), location: 0.3),
                .init(color: .spotifyBlack.opacity(blackOpacity), location: 0.6),
                .init(color: .spotifyBlack, location: 1.0),
            ],
        ),
        startPoint: .top,
        endPoint: .bottom,
    )
    .ignoresSafeArea()
}


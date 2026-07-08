//
//  View.Dialog.Extensions.swift
//  SpotifySwiftUI
//
//  Created by ladans on 30/08/25.
//

import SwiftUI

func toggleView(_ status: Bool, _ presentFullScreenCover: Binding<Bool>) {
    var transaction = Transaction()
    transaction.disablesAnimations = true
    
    withTransaction(transaction) {
        presentFullScreenCover.wrappedValue = status
    }
}

nonisolated func offset(
    _ proxy: GeometryProxy,
    screenHeight: CGFloat,
    animateView: Bool,
) -> CGFloat {
    let viewHeight = proxy.size.height
    return animateView ? 0 : (viewHeight + screenSize.height) / 2
}

var screenSize: CGSize {
    if let screenSize = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.size {
        return screenSize
    }
    
    return .zero
}

struct VendoredSpotifyConfig {
    var backgroundColor: Color = Color.spotifyBlack.opacity(0.6)
}

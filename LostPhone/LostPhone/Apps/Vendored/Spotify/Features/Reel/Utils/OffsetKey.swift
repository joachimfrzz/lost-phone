//
//  VendoredSpotifyOffsetKey.swift
//  SpotifySwiftUI
//
//  Created by ladans on 28/08/25.
//

import SwiftUI

struct VendoredSpotifyOffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct VendoredSpotifyTabKey: PreferenceKey {
    static var defaultValue: VendoredSpotifySpotifyTabItem = .home
    
    static func reduce(value: inout VendoredSpotifySpotifyTabItem, nextValue: () -> VendoredSpotifySpotifyTabItem) {
        value = nextValue()
    }
}

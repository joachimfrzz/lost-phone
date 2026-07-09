//
//  StringUtils.swift
//  SwiftUIClones
//
//  Created by ladans on 15/08/25.
//

import SwiftUI

var madeFor: AttributedString {
    var first = AttributedString("Made for ")
    first.foregroundColor = .spotifyLightGrey
    first.font = .callout
        
    var second = AttributedString("Ladans IO")
    second.foregroundColor = .spotifyWhite
    second.font = .system(.callout, weight: .bold)
    
    return first + second
}

var aboutRecommendationsAndShareImpact: AttributedString {
    var first = AttributedString("About ")
    first.foregroundColor = .spotifyWhite
    first.font = .system(.callout, weight: .bold)
        
    var second = AttributedString("recommendation and Spotify impact")
    second.foregroundColor = .spotifyLightGrey
    second.font = .callout
    
    return first + second
}

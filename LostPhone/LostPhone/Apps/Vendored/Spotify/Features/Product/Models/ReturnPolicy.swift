//
//  VendoredSpotifyReturnPolicy.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

enum VendoredSpotifyReturnPolicy: String, Codable, Hashable {
    case noReturnPolicy = "No return policy"
    case the30DaysReturnPolicy = "30 days return policy"
    case the60DaysReturnPolicy = "60 days return policy"
    case the7DaysReturnPolicy = "7 days return policy"
    case the90DaysReturnPolicy = "90 days return policy"
}

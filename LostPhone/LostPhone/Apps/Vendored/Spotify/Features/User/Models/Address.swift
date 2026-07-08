//
//  VendoredSpotifyAddress.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

struct VendoredSpotifyAddress: Codable {
    let address, city, state, stateCode: String
    let postalCode: String
    let coordinates: VendoredSpotifyCoordinates
    let country: VendoredSpotifyCountry
}

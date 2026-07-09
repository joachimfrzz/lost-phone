//
//  VendoredSpotifyBank.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

struct VendoredSpotifyBank: Codable {
    let cardExpire, cardNumber, cardType, currency: String
    let iban: String
}

//
//  VendoredSpotifyMeta.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

struct VendoredSpotifyMeta: Codable, Hashable {
    let createdAt, updatedAt: VendoredSpotifyCreatedAt
    let barcode: String
    let qrCode: String
}

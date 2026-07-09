//
//  VendoredSpotifyReview.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

struct VendoredSpotifyReview: Codable, Hashable {
    let rating: Int
    let comment: String
    let date: VendoredSpotifyCreatedAt
    let reviewerName, reviewerEmail: String
}

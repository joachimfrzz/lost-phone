//
//  ProductSectionData.swift
//  SwiftUIClones
//
//  Created by ladans on 14/08/25.
//

import Foundation

struct VendoredSpotifyProductSection {
    let id: Int
    let title: String
    let products: [VendoredSpotifyProduct]
    
    static func getData(_ products: [VendoredSpotifyProduct]) -> Array<VendoredSpotifyProductSection> {
        [
            VendoredSpotifyProductSection(id: 1, title: "Plutónio", products: products),
            VendoredSpotifyProductSection(id: 2, title: "Chelsea Dinorath", products: products),
            VendoredSpotifyProductSection(id: 3, title: "Clean Boys", products: products),
            VendoredSpotifyProductSection(id: 4, title: "Andrew Belle", products: products),
            VendoredSpotifyProductSection(id: 5, title: "Twenty Fingers", products: products),
        ]
    }
}

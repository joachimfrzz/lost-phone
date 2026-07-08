//
//  VendoredSpotifyProduct.swift
//  SwiftUIPractice
//
//  Created by Developer on 02/07/25.
//

import Foundation

struct VendoredSpotifyProductArray: Codable {
    let products: [VendoredSpotifyProduct]
    let total, skip, limit: Int
}

struct VendoredSpotifyProduct: Codable, Identifiable, Hashable {
    let id: Int
    let title, description: String
    let category: VendoredSpotifyCategory
    let price, discountPercentage, rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Int
    let dimensions: VendoredSpotifyDimensions
    let warrantyInformation, shippingInformation: String
    let availabilityStatus: VendoredSpotifyAvailabilityStatus
    let reviews: [VendoredSpotifyReview]
    let returnPolicy: VendoredSpotifyReturnPolicy
    let minimumOrderQuantity: Int
    let meta: VendoredSpotifyMeta
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? VendoredSpotifyConstants.randomImage
    }
    
    static var mock: VendoredSpotifyProduct {
        VendoredSpotifyProduct(
            id: 3,
            title: "Ladans good scene",
            description: "Cool and half man half robot",
            category: VendoredSpotifyCategory.beauty,
            price: 234443.98,
            discountPercentage: 23.39,
            rating: 4,
            stock: 3,
            tags: ["nice"],
            brand: "iPhone",
            sku: "1234",
            weight: 23,
            dimensions: VendoredSpotifyDimensions(width: 12, height: 23, depth: 4),
            warrantyInformation: "good",
            shippingInformation: "Road number 2",
            availabilityStatus: .inStock,
            reviews: [
                VendoredSpotifyReview(
                    rating: 23, comment: "nice",
                    date: VendoredSpotifyCreatedAt.the20250430T094102053Z,
                    reviewerName: "Ladans",
                    reviewerEmail: "ladans.me@gmail.com",
                ),
            ],
            returnPolicy: .noReturnPolicy,
            minimumOrderQuantity: 2,
            meta: VendoredSpotifyMeta(
                createdAt: VendoredSpotifyCreatedAt.the20250430T094102053Z,
                updatedAt: VendoredSpotifyCreatedAt.the20250430T094102053Z,
                barcode: "2355443434",
                qrCode: "dsdsd",
            ),
            images: [],
            thumbnail: "nothumbnail",
        )
    }
}

//
//  VendoredUberEatsRestaurantResponse.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 6/6/25.
//


import Foundation

struct VendoredUberEatsRestaurantResponse: Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var coverUrl: String
    var deliveryFee: String // for eg $0.49, $0.78, $1.4
    var duration: String // for 25-45 min, 20-30 min
    var totalRate: String // for eg 100+, 250+
    var rating: String // 4.7, 5.0
    var badgeName:String? // for eg Top offer - 2 offers available
    var distance: String
    var menu: [VendoredUberEatsMenuResponse]
    var isOffer: Bool
    var isFavorite: Bool
}

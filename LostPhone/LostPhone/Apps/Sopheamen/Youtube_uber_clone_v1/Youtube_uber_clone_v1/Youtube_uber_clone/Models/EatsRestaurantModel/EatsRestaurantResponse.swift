//
//  EatsRestaurantResponse.swift
//  Youtube_uber_clone
//
//  Created by Sopheamen VAN on 13/11/24.
//

import Foundation

struct EatsRestaurantResponse: Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var deliveryFee: String // for eg $0.49, $0.78, $1.4
    var duration: String // for 25-45 min, 20-30 min
    var totalRate: String // for eg 4.7, 5.0, 3.5
    var isOffer: Bool
    var isFavorite: Bool
}

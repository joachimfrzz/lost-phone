//
//  VendoredUberEatsCartResponse.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 28/4/25.
//

import Foundation

struct VendoredUberEatsCartResponse:Identifiable {
    var id = UUID()
    var restaurant: VendoredUberEatsRestaurantResponse
    var itemCount: Int // get count from all menu item
    var totalPrice: String // get sum price of all menu price
    var deliveryTo: String // as location
}

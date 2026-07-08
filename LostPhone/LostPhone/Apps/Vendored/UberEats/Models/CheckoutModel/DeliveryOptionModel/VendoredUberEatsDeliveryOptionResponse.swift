//
//  VendoredUberEatsDeliveryOptionResponse.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 28/4/25.
//

import Foundation

struct VendoredUberEatsDeliveryOptionResponse:Identifiable {
    var id = UUID()
    var name: String
    var subName: String
    var icon: String
    var price: String
}

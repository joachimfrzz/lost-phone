//
//  MenuResponse.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 6/6/25.
//
import Foundation

struct MenuResponse: Identifiable, Hashable {
    var id: UUID
    var name: String
    var imageUrl: String
    var description: String
    var price: String
    var isPriceAddOns: Int // 0 get the actual price, 1 price = Priced by add-ons
    var rate: Int // as percentage for eg 100%, 90%
    var totalRate: Int
    var isPopular: Int // 1 is popular, 0 not
}

//
//  VendoredUberEatsAddressResponse.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 28/4/25.
//

import Foundation

struct VendoredUberEatsAddressResponse:Identifiable {
    var id = UUID()
    var name: String
    var subName: String
    var icon: String // for eg home, office
}

//
//  VendoredInstagramSearchPlaceResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import Foundation

struct VendoredInstagramSearchPlaceResponse: Hashable, Identifiable {
    let id: Int
    let locationName: String
    let locationAddress: String?
}

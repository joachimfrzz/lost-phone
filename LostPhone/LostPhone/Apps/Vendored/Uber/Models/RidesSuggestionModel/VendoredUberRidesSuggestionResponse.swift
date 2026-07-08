//
//  VendoredUberRidesSuggestionResponse.swift
//  Youtube_uber_clone
//
//  Created by Sopheamen VAN on 13/11/24.
//

import Foundation

struct VendoredUberRidesSuggestionResponse:Identifiable {
    var id = UUID()
    var name:String
    var imageUrl: String
    var isPromoted: Bool
}

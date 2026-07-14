//
//  RidesHistoryResponse.swift
//  Youtube_uber_clone
//
//  Created by Sopheamen VAN on 13/11/24.
//

import Foundation

struct RidesHistoryResponse: Identifiable {
    var id = UUID()
    var location: String // for eg Work, Home, and Other
    var streetName: String
}

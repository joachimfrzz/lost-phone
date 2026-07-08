//
//  VendoredAppStoreAppResponse.swift
//  Youtube_Appstore
//
//  Created by Sopheamen VAN on 19/9/24.
//

import Foundation

struct VendoredAppStoreAppResponse: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var category: String
    var label: String
}

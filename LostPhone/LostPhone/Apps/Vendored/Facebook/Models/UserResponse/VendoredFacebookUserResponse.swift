//
//  VendoredFacebookUserResponse.swift
//  Youtube_Facebook
//
//  Created by Sopheamen VAN on 21/10/24.
//

import Foundation

struct VendoredFacebookUserResponse: Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var isOnline: Bool
}

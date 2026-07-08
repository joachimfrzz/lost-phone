//
//  VendoredFacebookStoryResponse.swift
//  Youtube_Facebook
//
//  Created by Sopheamen VAN on 21/10/24.
//

import Foundation

struct VendoredFacebookStoryResponse: Identifiable {
    var id = UUID()
    var user: VendoredFacebookUserResponse
    var imageUrl: String
}


//
//  VendoredInstagramStoryResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation

struct VendoredInstagramStoryResponse: Hashable, Identifiable {
    let id: Int
    let user: VendoredInstagramUserInstagramResponse
}

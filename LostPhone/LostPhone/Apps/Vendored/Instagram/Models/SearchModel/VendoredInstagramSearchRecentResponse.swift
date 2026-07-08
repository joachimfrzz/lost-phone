//
//  SearchResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation

struct VendoredInstagramSearchRecentResponse: Hashable, Identifiable {
    let id: Int
    let user: VendoredInstagramUserInstagramResponse
}

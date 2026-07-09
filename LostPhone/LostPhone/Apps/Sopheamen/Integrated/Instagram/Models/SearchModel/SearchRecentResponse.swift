//
//  SearchResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation

struct SearchRecentResponse: Hashable, Identifiable {
    let id: Int
    let user: UserInstagramResponse
}

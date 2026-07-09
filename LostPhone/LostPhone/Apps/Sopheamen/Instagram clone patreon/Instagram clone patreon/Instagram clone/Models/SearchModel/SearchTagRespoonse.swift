//
//  SearchTagRespoonse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import Foundation

struct SearchTagRespoonse: Hashable, Identifiable {
    let id: Int
    let tagName: String
    let totalPosts: Int
}

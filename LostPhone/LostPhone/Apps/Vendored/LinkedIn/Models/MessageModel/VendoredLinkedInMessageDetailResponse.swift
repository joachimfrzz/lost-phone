//
//  VendoredLinkedInMessageDetailResponse.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 2/5/24.
//

import Foundation

struct VendoredLinkedInMessageDetailResponse: Hashable, Identifiable {
    var id: UUID
    var text: String
    var isMe: Bool
    var time: String
}

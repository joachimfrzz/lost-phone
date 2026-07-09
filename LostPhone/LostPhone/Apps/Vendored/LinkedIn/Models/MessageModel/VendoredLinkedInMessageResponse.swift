//
//  VendoredLinkedInMessageResponse.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 24/4/24.
//

import Foundation

struct VendoredLinkedInMessageResponse: Identifiable, Hashable {
    var id: UUID
    var user: VendoredLinkedInUserLinkedInResponse
    var text: String
    var badgeNumber: Int // 0 is nil, has more than 0
    var dateAgo: String // 8:35 am, 9:00 am, Mon, Tue, Apr 12
}

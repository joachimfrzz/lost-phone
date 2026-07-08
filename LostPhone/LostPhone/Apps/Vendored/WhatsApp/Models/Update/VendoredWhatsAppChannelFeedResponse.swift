//
//  UserChannelResponse.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 6/4/24.
//

import Foundation

struct VendoredWhatsAppChannelFeedResponse: Hashable, Identifiable {
    var id: UUID
    var channel: VendoredWhatsAppChannelResponse
    var caption: String
    var imageUrl: String
    var timeAgo: String
}

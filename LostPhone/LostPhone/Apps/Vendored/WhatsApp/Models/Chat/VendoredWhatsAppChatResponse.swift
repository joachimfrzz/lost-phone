//
//  VendoredWhatsAppChatResponse.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 6/4/24.
//

import Foundation

struct VendoredWhatsAppChatResponse: Hashable, Identifiable {
    var id: UUID
    var user: VendoredWhatsAppUserResponse
    var text: String?
    var badgeNumber: Int?
    var type: Int // assuming 1 text, 2 missed voice call, 3 voice record
    var timeAgo: String 
}

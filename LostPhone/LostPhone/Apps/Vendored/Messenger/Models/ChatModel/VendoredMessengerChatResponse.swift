//
//  VendoredMessengerChatResponse.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 14/9/24.
//

import Foundation

struct VendoredMessengerChatResponse: Identifiable {
    var id = UUID()
    var user: VendoredMessengerUserResponse
    var text: String
    var timeAgo: String // Time ago for the message
}


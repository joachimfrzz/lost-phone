//
//  ChatResponse.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 14/9/24.
//

import Foundation

struct ChatResponse: Identifiable {
    var id = UUID()
    var user: UserResponse
    var text: String
    var timeAgo: String // Time ago for the message
}


//
//  ChatResponse.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 14/9/24.
//

import Foundation

struct ChatDetailResponse: Identifiable {
    var id = UUID()
    var isMe: Bool
    var chatType: Int // 1 as text, 2 voice, 3 photo, 4 video
    var text: String // if chatType 1 is text, otherwise empty value
    var duration: String? // For voice messages, e.g., "0:10"
    var mediaUrl: String? // For photo or video messages
}


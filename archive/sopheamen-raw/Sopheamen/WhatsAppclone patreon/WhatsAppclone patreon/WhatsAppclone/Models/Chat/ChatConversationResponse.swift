//
//  ChatConversationResponse.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 6/4/24.
//

import Foundation

struct ChatConversationResponse: Hashable, Identifiable {
    var id: UUID
    var text: String
    var isMe: Bool
    var isReaction: Bool? // assuming true is reaction emoji, false is nil
    var dateTime: String
}

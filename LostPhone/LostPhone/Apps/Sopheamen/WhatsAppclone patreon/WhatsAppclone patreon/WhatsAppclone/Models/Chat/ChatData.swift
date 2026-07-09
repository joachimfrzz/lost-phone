//
//  ChatData.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 6/4/24.
//

import Foundation

let chatData: [ChatResponse] = [
    ChatResponse(id: UUID(), user: userData[0], text: "Hey, how are you?", badgeNumber: nil, type: 1, timeAgo: "Yesterday"),
    ChatResponse(id: UUID(), user: userData[1], text: "Missed voice call", badgeNumber: 1, type: 2, timeAgo: "5m"),
    ChatResponse(id: UUID(), user: userData[2], text: "Let's catch up later.", badgeNumber: nil, type: 1, timeAgo: "10m"),
    ChatResponse(id: UUID(), user: userData[3], text: "0:04", badgeNumber: 2, type: 3, timeAgo: "15m"),
    ChatResponse(id: UUID(), user: userData[4], text: "Can you call me back?", badgeNumber: nil, type: 1, timeAgo: "Saturday"),
    ChatResponse(id: UUID(), user: userData[5], text: "1:22", badgeNumber: nil, type: 3, timeAgo: "25m"),
    ChatResponse(id: UUID(), user: userData[6], text: "I'll send the documents soon.", badgeNumber: nil, type: 1, timeAgo: "Monday"),
    ChatResponse(id: UUID(), user: userData[7], text: "Missed voice call", badgeNumber: 3, type: 2, timeAgo: "2h"),

]

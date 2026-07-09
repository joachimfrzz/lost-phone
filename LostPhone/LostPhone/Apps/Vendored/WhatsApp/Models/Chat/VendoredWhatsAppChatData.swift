//
//  ChatData.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 6/4/24.
//

import Foundation

let vendoredWhatsAppChatData: [VendoredWhatsAppChatResponse] = [
    VendoredWhatsAppChatResponse(id: UUID(), user: vendoredWhatsAppUserData[0], text: "Hey, how are you?", badgeNumber: nil, type: 1, timeAgo: "Yesterday"),
    VendoredWhatsAppChatResponse(id: UUID(), user: vendoredWhatsAppUserData[1], text: "Missed voice call", badgeNumber: 1, type: 2, timeAgo: "5m"),
    VendoredWhatsAppChatResponse(id: UUID(), user: vendoredWhatsAppUserData[2], text: "Let's catch up later.", badgeNumber: nil, type: 1, timeAgo: "10m"),
    VendoredWhatsAppChatResponse(id: UUID(), user: vendoredWhatsAppUserData[3], text: "0:04", badgeNumber: 2, type: 3, timeAgo: "15m"),
    VendoredWhatsAppChatResponse(id: UUID(), user: vendoredWhatsAppUserData[4], text: "Can you call me back?", badgeNumber: nil, type: 1, timeAgo: "Saturday"),
    VendoredWhatsAppChatResponse(id: UUID(), user: vendoredWhatsAppUserData[5], text: "1:22", badgeNumber: nil, type: 3, timeAgo: "25m"),
    VendoredWhatsAppChatResponse(id: UUID(), user: vendoredWhatsAppUserData[6], text: "I'll send the documents soon.", badgeNumber: nil, type: 1, timeAgo: "Monday"),
    VendoredWhatsAppChatResponse(id: UUID(), user: vendoredWhatsAppUserData[7], text: "Missed voice call", badgeNumber: 3, type: 2, timeAgo: "2h"),

]

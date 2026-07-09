//
//  Colors.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 4/4/24.
//

import SwiftUI

extension Color {
    // Hex color initializer
    init(hex: String, opacity: Double = 1.0) {
        let hexSanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }

    // WhatsApp Brand Colors
    static let primaryColor = Color(hex: "#027CFF")
    static let dangerColor = Color(hex: "#FD3C31")
    static let backgroundColor = Color(hex: "#F2F1F6")
    
    // Opacity
    static let blackOpacity = Color.black.opacity(0.6)
    
    // Textfield
    static let textFieldBackgroundColor = Color(hex: "#EFEFEF")
    
    // Setting
    static let avatarColor = Color(hex: "#3379F5")
    static let starredMessageColor = Color(hex: "#FFC700")
    static let linkedDeviceColor = Color(hex: "#0DADA0")
    static let accountColor = Color(hex: "#017AFF")
    static let privacyColor = Color(hex: "#36A8DC")
    static let chatColor = Color(hex: "#4CD862")
    static let notificationColor = Color(hex: "#FF3C31")
    static let storageDataColor = Color(hex: "#36C759")
    static let helpColor = Color(hex: "#017AFF")
    static let tellFriendColor = Color(hex: "#FE2D56")
    
    // Chat Component
    static let todayChatBackground = Color(hex: "#F5F3EF")
    static let settingChatBackground = Color(hex: "#FFF4BB")
    static let meChatBackground = Color(hex: "#E1FFD3")

}

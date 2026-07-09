//
//  AppColor.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 18/5/24.
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

    // Brand Colors
    static let primaryColor = Color(hex: "#0a66c2")
    static let dangerColor = Color(hex: "#FD3C31")
    static let backgroundColor = Color(hex: "#E9E5DF")
    
    // Opacity
    static let blackOpacity = Color.black.opacity(0.6)
    static let backgroundIconOpacity = Color.gray.opacity(0.1)
    
    // Textfield
    static let textFieldBackgroundColor = Color(hex: "#EFF3F6")
    static let notificationBackgroundColor = Color(hex: "#EAF4FE")
    
    
    // Chat Component
    static let todayChatBackground = Color(hex: "#F5F3EF")
    static let settingChatBackground = Color(hex: "#FFF4BB")
    static let meChatBackground = Color(hex: "#E1FFD3")
    static let activeGreenTab = Color(hex:"#397447")
    
    // Button Component
    static let buttonPremiumColor = Color(hex: "#F1C888")
    static let buttonPrimaryColor = Color(hex: "#4EAAF8")
    
    // Icon
    static let iconBlueColor = Color(hex: "#4EABFB")
    static let iconDarkBlueColor = Color(hex: "#2C6BD6")
    
    
}


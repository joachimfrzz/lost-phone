//
//  Colors.swift
//  Youtube_Netflix
//
//  Created by Sopheamen VAN on 30/8/24.
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

    // Netflix Brand Colors
    static let primaryColor = Color(hex: "#E50914")
    static let seondaryColor = Color(hex: "#221F1F")

    // Opacity
    static let blackOpacity = Color.black.opacity(0.6)
    
    // Textfield
    static let textFieldBackgroundColor = Color(hex: "#EFEFEF")

}

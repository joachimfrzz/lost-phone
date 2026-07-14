//
//  Colors.swift
//  Youtube_Phantom_clone
//
//  Created by Sopheamen VAN on 13/3/25.
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

    // primary, secondary color
    static let primaryColor = Color(hex: "#ABA1F3")
    
    static let successColor = Color(hex: "#2FDE79")
    static let successLightColor = Color(hex: "#1F3B2B")
    static let dangerColor = Color(hex: "#D0444B")
    
    static let cardBackgroundColor = Color(hex: "#2C2E2F")
    
}

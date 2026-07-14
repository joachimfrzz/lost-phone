//
//  Colors.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 28/4/25.
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
    static let primaryColor = Color(hex: "#0B8245")
    static let darkOrangeColor = Color(hex: "#B37F34")
    static let backgroundColor = Color(hex: "#FDFBFC")
    
    // other color
    static let textFieldBackgroundColor = Color(hex: "#F3F0F3")
    static let darkButtonColor = Color(hex: "#000002")
    static let favouriteColor = Color(hex: "#C9180B")
    static let cardColor = Color(hex: "#F3F3F3")
}

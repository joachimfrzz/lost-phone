//
//  Colors.swift
//  Youtube_Appstore
//
//  Created by Sopheamen VAN on 19/9/24.
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
   static let primaryColor = Color(hex: "#3771F6") // Deep Blue
   static let backgroundDarkColor = Color(hex: "#1C1C1E")
   static let buttonGrayColor = Color(hex: "#EEEEEE")

}

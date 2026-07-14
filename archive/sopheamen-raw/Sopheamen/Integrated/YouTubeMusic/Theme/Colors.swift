//
//  Colors.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 3/9/24.
//

import SwiftUI

import SwiftUI

extension Color {
    // Hex color initializer
    init(sopheamenHex: String, opacity: Double = 1.0) {
        let hexSanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }

    // Youtube Music Brand Colors
    static let primaryColor = Color(sopheamenHex: "#FFFFFF")
    static let buttonColor = Color(sopheamenHex: "#353A34")

}

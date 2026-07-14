//
//  Colors.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 16/9/24.
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
   static let purpleColor = Color(hex: "#953BF6")
   static let successLightColor = Color(hex: "#E9F9E8")
   static let sucessColor = Color(hex: "#65C95A")
   // Chat
   static let bubbleGrayColor = Color(hex: "#F1F1F1")
   static let buubleBlueColor = Color(hex: "#515AF6")
    
    
    // Textfield
    static let textFieldBackgroundColor = Color(hex: "#F6F6F6")

}

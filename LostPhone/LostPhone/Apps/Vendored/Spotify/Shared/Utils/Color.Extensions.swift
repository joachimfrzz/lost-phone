//
//  Color+Extension.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

import SwiftUI

extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension Color {
    /// Retorna .black para fundos claros, .white para fundos escuros.
    var idealForegroundColor: Color {
        // Converter Color para UIColor (iOS)
        #if canImport(UIKit)
        let uiColor = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 1
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.299 * r + 0.587 * g + 0.114 * b
        return luminance > 0.5 ? Color.spotifyBlack : Color.spotifyWhite
        #else
        // macOS: use NSColor
        return .white
        #endif
    }
}

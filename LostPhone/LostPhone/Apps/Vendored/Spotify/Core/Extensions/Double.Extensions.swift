//
//  Double+Extensions.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

import SwiftUI

@available(*, deprecated, message: "Use .relativeSize(width:, height:) View modifiers instead.")
extension Double {
    /// Deprecated: Use `.relativeSize(width:, height:)` on Views instead.
    var w: Double {
        return UIScreen.main.bounds.width * (self / 100)
    }

    /// Deprecated: Use `.relativeSize(width:, height:)` on Views instead.
    var h: Double {
        // Deprecated API; kept for backward compatibility.
        UIScreen.main.bounds.height * (self / 100)
    }
}

//
//  VendoredSpotifyToast.swift
//  SpotifySwiftUI
//
//  Created by ladans on 29/08/25.
//

import SwiftUI

struct VendoredSpotifyToast: Identifiable {
    private(set) var id: String = UUID().uuidString
    var content: AnyView
    
    init(@ViewBuilder content: @escaping (String) -> some View) {
        self.content = .init(content(id))
    }
    
    var offsetX: CGFloat = 0
    var isDeleting: Bool = false
}

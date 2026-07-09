//
//  ToastHelper.swift
//  SpotifySwiftUI
//
//  Created by ladans on 29/08/25.
//

import SwiftUI

extension Binding<[VendoredSpotifyToast]> {
    func showToast(_ message: String) {
        withAnimation(.bouncy) {
            let toast = VendoredSpotifyToast { id in
                VendoredSpotifyToastView(id: id, message: message, toasts: self)
            }
            wrappedValue.append(toast)
        }
    }
    
    func delete(_ id: String) {
        if let toast = first(where: { $0.id == id }) {
            toast.wrappedValue.isDeleting = true
        }
        withAnimation(.bouncy) {
            self.wrappedValue.removeAll { $0.id == id }
        }
    }
}


nonisolated func offsetY(_ index: Int) -> CGFloat {
    let offset = min(CGFloat(index) * 15, 30)
    
    return -offset
}

nonisolated func scale(_ index: Int) -> CGFloat {
    let scale = min(CGFloat(index) * 0.1, 1)
    
    return 1 - scale
}

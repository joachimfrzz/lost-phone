//
//  VendoredSpotifyToastView.swift
//  SpotifySwiftUI
//
//  Created by ladans on 29/08/25.
//

import SwiftUI

struct VendoredSpotifyToastView: View {
    let id: String
    let message: String
    let toasts: Binding<[VendoredSpotifyToast]>
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle")
                .foregroundStyle(.spotifyGreen)
            
            Text(message)
                .font(.callout)
            
//            Spacer()
//            
//            Button {
//                toasts.delete(id)
//            } label: {
//                Image(systemName: "xmark.circle.fill")
//                    .font(.title2)
//            }
        }
        .foregroundStyle(.spotifyWhite)
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .padding(.trailing, 10)
        .background {
            Capsule()
                .fill(.spotifyBlack)
                .shadow(color: .spotifyWhite.opacity(0.06), radius: 3, x: -1, y: -3)
                .shadow(color: .spotifyWhite.opacity(0.06), radius: 2, x: 1, y: 3)
        }
    }
}

//
//  VendoredSpotifyLogo.swift
//  SpotifySwiftUI
//
//  Created by ladans on 25/08/25.
//

import SwiftUI

struct VendoredSpotifyLogo: View {
    let onPressed: () -> Void
    
    var body: some View {
        Button {
            onPressed()
        } label: {
            Image("VendoredSpotifyLogo")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        VendoredSpotifyLogo() {}
            .frame(width: 128, height: 128)
    }
}

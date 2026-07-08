//
//  SpotifyCategoryTile.swift
//  SwiftUIClones
//
//  Created by ladans on 02/07/25.
//

import SwiftUI

struct VendoredSpotifyCategoryTile: View {
    var title: String = "Music"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .tileStyle(isSelected: isSelected)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack (spacing: 8) {
            VendoredSpotifyCategoryTile()
            VendoredSpotifyCategoryTile(isSelected: true)
            VendoredSpotifyCategoryTile()
        }
    }
}

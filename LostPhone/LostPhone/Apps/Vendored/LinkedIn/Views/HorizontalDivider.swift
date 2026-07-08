//
//  VendoredLinkedInHorizontalDivider.swift
//  linkedin_clone
//
//  Created by Dipak on 25/02/23.
//

import SwiftUI

struct VendoredLinkedInHorizontalDivider: View {
    
    let color: Color
    let height: CGFloat
    
    init(color: Color, height: CGFloat = 0.5) {
        self.color = color
        self.height = height
    }
    
    var body: some View {
        color
            .frame(height: height)
    }
}

struct HorizontalDivider_Previews: PreviewProvider {
    static var previews: some View {
        VendoredLinkedInHorizontalDivider(color:.gray, height:5)
    }
}

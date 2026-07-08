//
//  VendoredNetflixShimmerView.swift
//  Notflix
//
//  Created by Quentin Eude on 14/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixShimmerView: View {

    @State private var opacity: Double = 0.25

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.vendoredNetflixDarkGray)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 0.9)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = 1
                }
        }
    }
}


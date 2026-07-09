//
//  BackgroundBlurView.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 4/9/24.
//

import SwiftUI

struct BackgroundBlurView:View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [.purple, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(height: 110)
            .blur(radius: 150)
    }
}

#Preview {
    BackgroundBlurView()
}

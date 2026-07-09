//
//  GradientBorderModifier.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 16/3/24.
//

import SwiftUI

struct GradientBorderModifier: ViewModifier {
    let width: CGFloat
    let colors:[Color]
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: width)
            )
            .overlay(
                Circle()
                    .stroke(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: width)
                    .padding(width / 2)
            )
    }
}

extension View {
    func gradientBorder(width: CGFloat, colors: [Color]) -> some View {
        self.modifier(GradientBorderModifier(width: width, colors: colors))
    }
}

//
//  VisualEffectBlur.swift
//  Youtube_Netflix
//
//  Created by Sopheamen VAN on 30/8/24.
//
import SwiftUI
import UIKit

struct VisualEffectBlur: UIViewRepresentable {
    var effect: UIBlurEffect.Style
    var intensity: CGFloat

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: nil)
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: effect)

        // This ensures the intensity works correctly
        if let subview = uiView.subviews.first,
           subview.alpha != intensity {
            subview.alpha = intensity
        }
    }
}

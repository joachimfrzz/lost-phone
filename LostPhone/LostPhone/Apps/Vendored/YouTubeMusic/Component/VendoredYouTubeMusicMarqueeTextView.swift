//
//  MarqueeText.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 4/9/24.
//

import SwiftUI

struct VendoredYouTubeMusicMarqueeTextView: View {
    var text: String
    var font: Font = .title
    var fontWeight: Font.Weight = .semibold
    var boxHeight: CGFloat? = 40
    var duration: Double = 10.0
    var delay: Double = 1.0

    @State private var offsetX: CGFloat = UIScreen.main.bounds.width
    @State private var textWidth: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            Text(text)
                .font(font)
                .fontWeight(fontWeight)
                .background(GeometryReader { textGeometry in
                    Color.clear.onAppear {
                        textWidth = textGeometry.size.width
                    }
                })
                .offset(x: offsetX)
                .onAppear {
                    startAnimation(geometry: geometry)
                }
        }
        .frame(height: boxHeight ?? 40)
        .clipped()
    }

    private func startAnimation(geometry: GeometryProxy) {
        offsetX = geometry.size.width
        _ = duration + delay
        let animation = Animation.linear(duration: duration).delay(delay)

        withAnimation(animation.repeatForever(autoreverses: false)) {
            offsetX = -textWidth
        }
    }
}

#Preview {
    VendoredYouTubeMusicMarqueeTextView(text: "Hello, World!")
}

//
//  VendoredAirbnbLoadingView.swift
//  AirbnbClone-SwiftUI
//
//  Created by Keerthi on 14/09/20.
//  Copyright © 2020 Hxtreme. All rights reserved.
//

import SwiftUI

struct VendoredAirbnbLoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if (!self.isShowing) {
                    self.content()
                } else {
                    self.content()
                        .disabled(self.isShowing)
                        .blur(radius: self.isShowing ? 3 : 0)
                    
                    VStack {
                        Text("Loading...")
                        VendoredAirbnbActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                    .frame(width: geometry.size.width / 3,
                           height: 100)
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(Color.primary)
                        .cornerRadius(20)
                        .opacity(self.isShowing ? 1 : 0)
                }
            }
        }
    }

}

struct VendoredAirbnbActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<VendoredAirbnbActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<VendoredAirbnbActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

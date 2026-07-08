//
//  PopViewHelper.swift
//  SpotifySwiftUI
//
//  Created by ladans on 30/08/25.
//


import SwiftUI

extension View {
    func popView<Content: View>(
        config: VendoredSpotifyConfig = .init(),
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> (),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        modifier(
            PopViewHelper(
                config: config,
                isPresented: isPresented,
                onDismiss: onDismiss,
                viewContent: content,
            ),
        )
    }
}

fileprivate struct PopViewHelper<ViewContent: View>: ViewModifier {
    let config: VendoredSpotifyConfig
    @Binding var isPresented: Bool
    let onDismiss: () -> ()
    @ViewBuilder let viewContent: () -> ViewContent
    
    @State private var presentFullScreenCover: Bool = false
    @State private var animateView: Bool = false
    
    func body(content: Content) -> some View {
        let screenHeight = screenSize.height
        let animateView = animateView
        
        content
            .fullScreenCover(
                isPresented: $isPresented,
                onDismiss: onDismiss
            ) {
                ZStack {
                    Rectangle()
                        .fill(config.backgroundColor)
                        .ignoresSafeArea()
                        .opacity(animateView ? 1 : 0)
                    
                    viewContent()
                        .visualEffect { content, proxy in
                            content
                                .offset(
                                    y: offset(
                                        proxy,
                                        screenHeight: screenHeight,
                                        animateView: animateView,
                                    ),
                                )
                        }
                        .presentationBackground(.clear)
                        .task {
                            guard !animateView else { return }
                            withAnimation(.snappy(duration: 0.45, extraBounce: 0.05)) {
                                self.animateView = true
                            }
                        }
                        .ignoresSafeArea(.container, edges: .all)
                }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                if newValue {
                    toggleView(true, $presentFullScreenCover)
                } else {
                    Task {
                        withAnimation(.snappy(duration: 0.45, extraBounce: 0)) {
                            self.animateView = false
                        }
                        try? await Task.sleep(for: .seconds(0.45))
                        toggleView(false, $presentFullScreenCover)
                    }
                }
            }
    }
}

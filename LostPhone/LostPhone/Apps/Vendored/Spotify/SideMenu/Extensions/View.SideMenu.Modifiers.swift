//
//  View+Modifiers.swift
//  SpotifySwiftUI
//
//  Created by ladans on 26/08/25.
//

import SwiftUI

extension View {
    func sideMenuPreferences(
        oldOffset: Binding<CGFloat>,
        offset: Binding<CGFloat>,
        showMenu: Bool,
        onEnd: @escaping (DragGesture.Value, _ sideMenuWidth: CGFloat) -> Void,
        onChange: @escaping (_ sideMenuWidth: CGFloat) -> Void,
        gestureOffset: GestureState<CGFloat>,
    ) -> some View {
        GeometryReader { geometry in
            frame(width: geometry.width + geometry.sideMenuWidth)
                .offset(x: -geometry.sideMenuWidth)
                .offset(x: offset.wrappedValue > 0 ? offset.wrappedValue : 0)
                .gesture(
                    DragGesture()
                        .updating(gestureOffset, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded() { value in
                            onEnd(value, geometry.sideMenuWidth)
                        }
                )
                .onChange(of: showMenu) {
                    if showMenu && offset.wrappedValue == 0 {
                        withAnimation(.easeOut(duration: 0.25)) {
                            offset.wrappedValue = geometry.sideMenuWidth
                            oldOffset.wrappedValue = offset.wrappedValue
                        }
                    }
                    
                    if !showMenu && offset.wrappedValue == geometry.sideMenuWidth {
                        withAnimation(.easeOut(duration: 0.25)) {
                            offset.wrappedValue = 0
                            oldOffset.wrappedValue = 0
                        }
                    }
                }
                .onChange(of: gestureOffset.wrappedValue) {
                    onChange(geometry.sideMenuWidth)
                }
        }
    }
    
    func sideMenuContentOverlay(
        overlayColor: Color? = nil,
        showMenu: Binding<Bool>,
        onReset: @escaping () -> Void,
    ) -> some View {
        overlay {
            Rectangle()
                .fill((overlayColor ?? Color.black).opacity(showMenu.wrappedValue ? 0.5 : 0.0))
                .ignoresSafeArea(.container, edges: .vertical)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        onReset()
                    }
                }
        }
    }
}

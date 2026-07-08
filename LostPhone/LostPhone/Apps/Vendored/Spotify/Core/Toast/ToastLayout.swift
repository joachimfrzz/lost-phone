//
//  InteractiveToast.swift
//  SpotifySwiftUI
//
//  Created by ladans on 29/08/25.
//

import SwiftUI

extension View {
    func interactiveToast(_ toasts: Binding<[VendoredSpotifyToast]>) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                ToastsView(toasts: toasts)
            }
    }
}

fileprivate struct ToastsView: View {
    @Binding var toasts: [VendoredSpotifyToast]
    
    @State var isExpanded: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isExpanded {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isExpanded.toggle()
                    }
            }
            
            let layout = isExpanded
            ? AnyLayout(VStackLayout(spacing: 10))
            : AnyLayout(ZStackLayout())
            
            layout {
                ForEach($toasts) { $toast in
                    let index = (toasts.count - 1) - (toasts.firstIndex(where: { $0.id == toast.id }) ?? 0)
                    
                    toast.content
                        .offset(x: toast.offsetX)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let offsetX = value.translation.width < 0 ? value.translation.width : 0
                                    toast.offsetX = offsetX
                                }
                                .onEnded { value in
                                    let offsetX = value.translation.width + (value.velocity.width / 2)
                                    
                                    if -offsetX > 200 {
                                        $toasts.delete(toast.id)
                                    } else {
                                        toast.offsetX = 0
                                    }
                                }
                        )
                        .visualEffect { [isExpanded] content, proxy in
                            content
                                .scaleEffect(isExpanded ? 1 : scale(index), anchor: .bottom)
                                .offset(y: isExpanded ? 0 : offsetY(index))
                        }
                        .zIndex(toast.isDeleting ? 1000 : 0)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .transition(.asymmetric(insertion: .offset(y: 100), removal: .move(edge: .leading)))
                }
            }
            .onTapGesture {
                isExpanded.toggle()
            }
            .padding(.bottom, 16)
        }
        .animation(.bouncy, value: isExpanded)
        .onChange(of: toasts.isEmpty) { oldValue, newValue in
            if newValue {
                isExpanded = false
            }
        }
    }
}

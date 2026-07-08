//
//  ResizableHeaderScrollView.swift
//  SwiftUIClones
//
//  Created by ladans on 17/08/25.
//

import SwiftUI

struct VendoredSpotifyResizableHeader<Header: View, Content: View>: View {
    var minimumHeight: CGFloat
    var maximumHeight: CGFloat
    var ignoreSafeAreaTop: Bool = false
    var isSticky: Bool = false
    
    @ViewBuilder var header: (CGFloat, EdgeInsets) -> Header
    @ViewBuilder var content: Content
    
    @State private var offsetaY: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let safeArea = ignoreSafeAreaTop ? geometry.safeAreaInsets : .init()
            
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        content
                    } header: {
                        GeometryReader { _ in
                            let progress: CGFloat = min(max(offsetaY / (maximumHeight - minimumHeight), 0), 1)
                            let resizedHeight = (maximumHeight + safeArea.top) - (maximumHeight - minimumHeight) * progress
                            
                            header(progress, safeArea)
                                .frame(height: resizedHeight, alignment: .bottom)
                                .offset(y: isSticky ? (offsetaY < 0 ? offsetaY : 0) : 0) /// make it Sticky
                        }
                        .frame(height: maximumHeight + safeArea.top)
                    }
                }
            }
            .ignoresSafeArea(.container, edges: ignoreSafeAreaTop ? [.top] : [])
            .onScrollGeometryChange(for: CGFloat.self) {
                $0.contentOffset.y + $0.contentInsets.top
            } action: { oldValue, newValue in
                offsetaY = newValue
            }
        }
    }
}

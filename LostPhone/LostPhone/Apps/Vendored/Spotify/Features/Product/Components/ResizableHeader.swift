//
//  ResizableHeaderScrollView.swift
//  SwiftUIClones
//
//  Created by ladans on 17/08/25.
//

import SwiftUI

private struct VendoredSpotifyScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

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
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(
                            key: VendoredSpotifyScrollOffsetKey.self,
                            value: -(proxy.frame(in: .named("vendoredSpotifyScroll")).minY) + safeArea.top
                        )
                    }
                )
            }
            .coordinateSpace(name: "vendoredSpotifyScroll")
            .onPreferenceChange(VendoredSpotifyScrollOffsetKey.self) { offsetaY = $0 }
            .ignoresSafeArea(.container, edges: ignoreSafeAreaTop ? [.top] : [])
        }
    }
}

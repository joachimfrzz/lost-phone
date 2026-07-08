//
//  SpotifyHomeView.swift
//  SwiftUIClones
//
//  Created by ladans on 02/07/25.
//

import SwiftUI

struct VendoredSpotifyDetailView: View {
    let product: VendoredSpotifyProduct
    
    @EnvironmentObject var productStore: VendoredSpotifyProductStore
    @Environment(\.dismiss) private var dismiss
    
    let randomColor = Color.random
    @State private var scrollProgress: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            DynamicBackgroundGradient(
                randomColor,
                progress: scrollProgress,
            )
            
            GeometryReader { geometry in
                VendoredSpotifyResizableHeader(
                    minimumHeight: 70,
                    maximumHeight: 400 + geometry.safeAreaInsets.top,
                    ignoreSafeAreaTop: false,
                    isSticky: false,
                ) { progress, safeArea in
                    Header(progress, color: randomColor) {
                        scrollProgress = progress
                    }
                } content: {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(productStore.products) { product in
                            VendoredSpotifyPlaylistItem(product: product)
                            
                            if (product.id == productStore.products.last?.id) {
                                Spacer()
                                    .frame(height: 70)
                            }
                        }
                    }
                    .padding(20)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func Header(
        _ progress: CGFloat,
        color: Color?,
        onProgressChange: (() -> Void)? = nil,
    ) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            let size: CGFloat = 300 - (progress * 200)
            
            Rectangle()
                .fill(.clear)
                .overlay {
                    VendoredSpotifyProductThumbnail(
                        showBadge: true,
                        product: product,
                        largeSize: true,
                        color: color,
                    )
                    .frame(width: 74.w,  alignment: .center)
                }
                .frame(width: .infinity, height: size)
                .zIndex(1)
            
            VendoredSpotifyNowPlayingInfo(
                product: product,
                dynamicSpacing: progress > 0.2 ? (progress * 1.9 * 60) : nil,
            )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottomLeading,
        )
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(progress)
        }
        .onChange(of: progress) {
            onProgressChange?()
        }
    }
}

#Preview {
    VendoredSpotifyDetailView(product: VendoredSpotifyProduct.mock)
        .environmentObject(VendoredSpotifyProductStore())
}

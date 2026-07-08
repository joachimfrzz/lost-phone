//
//  SpotifyHomeView.swift
//  SwiftUIClones
//
//  Created by ladans on 02/07/25.
//

import SwiftUI

struct VendoredSpotifyHomeView<LogoView: View>: View {
    @State private var selectedCategory: VendoredSpotifyCategoryItem? = nil;
    @Binding var endAnimation: Bool
    var animation: Namespace.ID
    let logo: () -> LogoView
    
    @EnvironmentObject var productStore: VendoredSpotifyProductStore
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                    let data = VendoredSpotifyProductSection.getData(productStore.products)
                    
                    Section {
                        VendoredSpotifyRecentSectionView(products: productStore.products)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        VendoredSpotifyYourChoicesSection(products: productStore.products)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        ForEach(data, id: \.id) { item in
                            VendoredSpotifyProductSectionView(
                                section: item.title,
                                products: item.products,
                            )
                            
                            if item.id != data.last?.id {
                                Spacer()
                                    .frame(height: 10)
                            }
                            
                            if (item.id == data.last?.id) {
                                Spacer()
                                    .frame(height: 70)
                            }
                        }
                    } header: {
                        VendoredSpotifyHeaderMenu(
                            selectedCategory: selectedCategory,
                            animation: animation,
                            endAnimation: $endAnimation,
                        ) { value in
                            selectedCategory = value
                        } logo: {
                            logo()
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, 8)
        }
    }
}

#Preview {
    @Previewable @State var endAnimation: Bool = false
    @Previewable @Namespace var animation
    
    VendoredSpotifyHomeView(
        endAnimation: $endAnimation,
        animation: animation,
    ) {
        VendoredSpotifyLogo(onPressed: {})
    }
    .environmentObject(VendoredSpotifyProductStore())
}

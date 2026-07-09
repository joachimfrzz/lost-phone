//
//  VendoredDisneyHomeView.swift
//  DisneyPlus
//
//  Created by Goutham S on 05/07/22.
//

import SwiftUI

struct VendoredDisneyHomeView: View {
    
    @EnvironmentObject var homeVM: VendoredDisneyHomeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.black, Color.darkGrey.opacity(0.9)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 10) {
                        Image("logo")
                            .resizable()
                            .frame(width: 75, height: 40)
                            .aspectRatio(2, contentMode: .fit)
                        
                        VendoredDisneyMovieCarouselView(pageViews: homeVM.pageViews)
                        
                        VendoredDisneyButtonGroupView()
                            .padding(.top, -15)
                            .padding(.bottom, 15)
                        
                        VendoredDisneyHorizontalList(group: .recommendation)
                        VendoredDisneyHorizontalList(group: .new)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}


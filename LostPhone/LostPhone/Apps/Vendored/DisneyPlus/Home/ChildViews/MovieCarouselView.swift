//
//  VendoredDisneyMovieCarouselView.swift
//  DisneyPlus
//
//  Created by Goutham S on 05/07/22.
//

import SwiftUI

struct VendoredDisneyMovieCarouselView: View {
    
    var pageViews = [Image]()
    @State private var _currentIndex = 0
    
    var body: some View {
        VStack(spacing: 10) {
            TabView(selection: $_currentIndex.animation()) {
                ForEach(0 ..< pageViews.count, id: \.self) { index in
                    pageViews[index]
                        .resizable()
                        .aspectRatio(1.7, contentMode: .fill)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 225)
            
            HStack {
                ForEach(0 ..< pageViews.count, id: \.self) { index in
                    Circle()
                        .fill(index == _currentIndex ? Color.white : Color.white.opacity(0.3))
                        .frame(width: 5, height: 5)
                        .scaleEffect(index == _currentIndex ? 1.5 : 1)
                }
            }
        }
    }
}

struct MovieCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredDisneyMovieCarouselView(pageViews: [Image("pg-mandalorian"), Image("pg-mulan")])
    }
}

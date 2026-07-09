//
//  VendoredDisneyMovieGroupView.swift
//  DisneyPlus
//
//  Created by Goutham S on 05/07/22.
//

import SwiftUI

struct VendoredDisneyScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct VendoredDisneyMovieGroupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var _logoOpacity: CGFloat = 0
    @State private var _bgOpacity: CGFloat = 0
    var movieGroup: VendoredDisneyMovieGroup
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("bg-\(movieGroup.rawValue)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(Double(_bgOpacity))
                
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]),
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .frame(height: 50)
                    .offset(y: -55)
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            
            Text("")
                .toolbar() {
                    ToolbarItem(placement: .principal) {
                        Image("logo-\(movieGroup.rawValue)")
                            .resizable()
                            .aspectRatio(2.8, contentMode: .fit)
                            .frame(height: 25)
                            .opacity(1 - Double(_logoOpacity))
                    }
                }
            
            ScrollView(showsIndicators: false, content: {
                VStack(alignment: .center, spacing: 10, content: {
                    Image("logo-\(movieGroup.rawValue)")
                        .resizable()
                        .aspectRatio(2.8, contentMode: .fit)
                        .frame(height: 75)
                        .padding(.top, 130)
                        .padding(.bottom, 20)
                        .opacity(Double(_logoOpacity))
                    
                    VendoredDisneyHorizontalList(group: .recommendation)
                    VendoredDisneyHorizontalList(group: .new)
                    VendoredDisneyHorizontalList(group: .recommendation)
                    VendoredDisneyHorizontalList(group: .new)
                    VendoredDisneyHorizontalList(group: .recommendation)
                    
                    Spacer()
                })
                GeometryReader { geo in
                    let offset = geo.frame(in: .named("scrollView")).maxY
                    Color.clear.preference(key: VendoredDisneyScrollViewOffsetPreferenceKey.self, value: offset)
                }
            })
            .coordinateSpace(name: "scrollView")
            .onPreferenceChange(VendoredDisneyScrollViewOffsetPreferenceKey.self) { offsetValue in
                if VendoredDisneyScrollViewOffsetPreferenceKey.defaultValue == 0 {
                    VendoredDisneyScrollViewOffsetPreferenceKey.defaultValue = offsetValue
                }
                // approx value to get the fade-in fade-out animation
                let logoHeightToFade: CGFloat = 75
                self._logoOpacity = (logoHeightToFade - max((VendoredDisneyScrollViewOffsetPreferenceKey.defaultValue - offsetValue), 0)) / logoHeightToFade
                
                // approx value to get the fade-in fade-out animation
                let bgHeightToFade: CGFloat = 275
                self._bgOpacity = (bgHeightToFade - max((VendoredDisneyScrollViewOffsetPreferenceKey.defaultValue - offsetValue), 0)) / bgHeightToFade
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrowtriangle.backward.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                })
            })
        }
        .background()
    }
}


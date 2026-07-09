//
//  SearchPlacesView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI

struct SearchPlacesView: View {
    let placesData:[SearchPlaceResponse] = searchPlaceData
    var body: some View {
        LazyVStack {
            ForEach(placesData) { item in
                HStack (spacing: 14){
                    Image("hashtag_icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23,height: 23)
                        .padding(.all,12)
                        .overlay(Circle().stroke(Color.blackOpacity.opacity(0.3)))
                        
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.locationName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(item.locationAddress ?? "")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    
                }
                .padding(.vertical,6)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    SearchPlacesView()
}

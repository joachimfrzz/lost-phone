//
//  VendoredNetflixMovieRowView.swift
//  Youtube_Netflix
//
//  Created by Sopheamen VAN on 30/8/24.
//

import SwiftUI
import Kingfisher

struct VendoredNetflixMovieRowView:View {
    var movie: VendoredNetflixMovieResponse
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        ZStack (alignment: .bottom){
            
            Image(movie.imageUrl)
                  .scaledToFill()
                  .frame(width: width ?? 110, height: height ?? 140)
                  .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // if not empty
            if !movie.highlight.isEmpty {
                Text(movie.highlight)
                    .padding(.vertical,4)
                    .padding(.horizontal,6)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .background(Color.vendoredNetflixVendoredNetflixPrimary)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
                
        }
    }
}

#Preview {
    VendoredNetflixMovieRowView(movie: koreanMovieData[0])
}

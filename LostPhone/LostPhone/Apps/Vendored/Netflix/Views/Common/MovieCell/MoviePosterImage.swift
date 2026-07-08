//
//  VendoredNetflixMoviePosterImage.swift
//  Notflix
//
//  Created by Quentin Eude on 19/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixMoviePosterImage: View {
   private let movie: VendoredNetflixMovie

    init(for movie: VendoredNetflixMovie) {
        self.movie = movie
    }

    var body: some View {
        Group {
            if movie.posterUrl != nil {
                VendoredNetflixAsyncImage(url: movie.posterUrl!,
                           configuration: {AnyView($0.resizable())},
                           defaultView: {
                            AnyView(
                                Text(self.movie.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            )
                })
            } else {
                Text(self.movie.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 150, height: 245)
        .background(Color.vendoredNetflixDarkGray)
        .cornerRadius(8.0)
    }
}


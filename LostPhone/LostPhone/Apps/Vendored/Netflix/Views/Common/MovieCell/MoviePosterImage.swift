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
        .background(Color.darkGray)
        .cornerRadius(8.0)
    }
}

struct MoviePosterImage_Previews: PreviewProvider {
    static var previews: some View {
        VendoredNetflixMoviePosterImage(for: VendoredNetflixMovie(id: 330457,
                                      title: "Frozen II",
                                      overview: """
                Elsa, Anna, Kristoff and Olaf head far into
                the forest to learn the truth about an ancient
                mystery of their kingdom.
        """,
                                      popularity: 190.236,
                                      voteAverage: 7.1,
                                      video: false,
                                      adult: false,
                                      voteCount: 2860,
                                      genreIds: [6125, 2], genres: nil,
                                      posterPath: "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg",
                                      backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
                                      releaseDate: "2019-11-20"))
    }
}

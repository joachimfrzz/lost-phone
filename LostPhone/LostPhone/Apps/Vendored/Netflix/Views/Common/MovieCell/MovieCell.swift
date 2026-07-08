//
//  VendoredNetflixMovieCell.swift
//  Notflix
//
//  Created by Quentin Eude on 19/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixMovieCell: View {
    var movie: VendoredNetflixMovie

    init(for movie: VendoredNetflixMovie) {
        self.movie = movie
    }
    var body: some View {
        NavigationLink(destination: VendoredNetflixMovieDetails(movieId: movie.id)) {
            Group {
                VendoredNetflixMoviePosterImage(for: movie)
            }
        }
    }
}


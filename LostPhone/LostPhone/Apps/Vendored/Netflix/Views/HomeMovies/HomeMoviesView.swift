//
//  MoviesView.swift
//  Notflix
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixHomeMoviesView: View {
    @ObservedObject private var homeMovieViewModel: VendoredNetflixHomeMoviesViewModel

    init() {
        self.homeMovieViewModel = VendoredNetflixHomeMoviesViewModel()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            VendoredNetflixHorizontalMoviesListView(horizontalMoviesListViewModel: VendoredNetflixHorizontalMoviesListViewModel(fetcher: VendoredNetflixAPIEndpoints.popularMovies),
                                     listName: L10n.Movies.Popular.title)
            VendoredNetflixHorizontalMoviesListView(horizontalMoviesListViewModel: VendoredNetflixHorizontalMoviesListViewModel(fetcher: VendoredNetflixAPIEndpoints.topRatedMovies),
                                     listName: L10n.Movies.Toprated.title)
            ForEach(homeMovieViewModel.genres, id: \.id) { genre in
                VendoredNetflixHorizontalMoviesListView(horizontalMoviesListViewModel:
                    VendoredNetflixHorizontalMoviesListViewModel(fetcher: VendoredNetflixAPIEndpoints.moviesForGenre(genreId: genre.id)),
                                         listName: L10n.Movies.With.Genre.title(genre.name))
            }
        }
    }
}

struct HomeMoviesView_Previews: PreviewProvider {
    static var previews: some View {
       ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VendoredNetflixHomeMoviesView()
        }
    }
}

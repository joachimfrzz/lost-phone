//
//  TVShowsView.swift
//  Notflix
//
//  Created by Quentin Eude on 13/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixHomeTVShowsView: View {
    @ObservedObject private var tvShowViewModel: VendoredNetflixHomeTVShowsViewModel

    init() {
        self.tvShowViewModel = VendoredNetflixHomeTVShowsViewModel()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            VendoredNetflixHorizontalTVShowsListView(tvShowsViewModel: VendoredNetflixHorizontalTVShowsListViewModel(fetcher: VendoredNetflixAPIEndpoints.popularTVShows),
                                      listName: L10n.Tvshows.Popular.title)
            VendoredNetflixHorizontalTVShowsListView(tvShowsViewModel: VendoredNetflixHorizontalTVShowsListViewModel(fetcher: VendoredNetflixAPIEndpoints.topRatedTVShows),
                                      listName: L10n.Tvshows.Toprated.title)
            ForEach(tvShowViewModel.genres, id: \.id) { genre in
                VendoredNetflixHorizontalTVShowsListView(tvShowsViewModel: VendoredNetflixHorizontalTVShowsListViewModel(fetcher: VendoredNetflixAPIEndpoints.tvShowsForGenre(genreId: genre.id)),
                                          listName: L10n.Tvshows.With.Genre.title(genre.name))
            }
        }
    }
}

struct HomeTVShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VendoredNetflixHomeTVShowsView()
        }
    }
}

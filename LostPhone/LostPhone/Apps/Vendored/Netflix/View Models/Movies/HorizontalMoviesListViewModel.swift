//
//  MoviesViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 14/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

class VendoredNetflixHorizontalMoviesListViewModel: ObservableObject {
    enum VendoredNetflixState {
        case initial
        case loading
        case error
        case data
    }

    @Published var movies = [VendoredNetflixMovie]()
    @Published var state: VendoredNetflixState = .initial

    private var disposables = Set<AnyCancellable>()

    init(fetcher: VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixMovie>>) {
        self.fetchMovies(fetcher: fetcher)
    }

    private func fetchMovies(fetcher: VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixMovie>>) {
        self.state = .loading
        APIClient().send(fetcher).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.movies = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.movies = response.results
        })
            .store(in: &disposables)
    }
}

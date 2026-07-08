//
//  VendoredNetflixMovieDetailsViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 15/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

class VendoredNetflixMovieDetailsViewModel: ObservableObject {
    enum VendoredNetflixState {
        case initial
        case loading
        case error
        case data
    }

    @Published var movie: VendoredNetflixMovie?
    @Published var state: VendoredNetflixState = .initial

    private var disposables = Set<AnyCancellable>()

    init(movieId: Int) {
        fetchMovieDetails(movieId: movieId)
    }

    private func fetchMovieDetails(movieId: Int) {
        self.state = .loading
        APIClient().send(VendoredNetflixAPIEndpoints.movie(movieId: movieId)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.movie = nil
                self.state = .error
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.movie = response
            self.state = .data
        })
        .store(in: &disposables)
    }
}

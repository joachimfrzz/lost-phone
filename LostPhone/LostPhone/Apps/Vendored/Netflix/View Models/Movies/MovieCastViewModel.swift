//
//  VendoredNetflixMovieCastViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

class VendoredNetflixMovieCastViewModel: ObservableObject {
    enum VendoredNetflixState {
        case initial
        case loading
        case error
        case data
    }

    @Published var actors = [VendoredNetflixActor]()
    @Published var state: VendoredNetflixState = .initial

    private var disposables = Set<AnyCancellable>()

    init(movieId: Int) {
        fetchCastForMovie(movieId: movieId)
    }

    private func fetchCastForMovie(movieId: Int) {
        self.state = .loading
        APIClient().send(VendoredNetflixAPIEndpoints.movieCredits(movieId: movieId)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.actors = []
                self.state = .error
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.actors = Array(response.cast.sorted { $0.order < $1.order }.prefix(10))
            self.state = .data
        })
        .store(in: &disposables)

    }
}

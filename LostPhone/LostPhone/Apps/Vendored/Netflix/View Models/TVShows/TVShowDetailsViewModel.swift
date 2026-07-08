//
//  VendoredNetflixTVShowDetailsViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 20/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

class VendoredNetflixTVShowDetailsViewModel: ObservableObject {
    enum VendoredNetflixState {
        case initial
        case loading
        case error
        case data
    }

    @Published var tvShow: VendoredNetflixTVShow?
    @Published var state: VendoredNetflixState = .initial

    private var disposables = Set<AnyCancellable>()

    init(tvShowId: Int) {
        fetchTvShowDetails(tvShowId: tvShowId)
    }

    private func fetchTvShowDetails(tvShowId: Int) {
        self.state = .loading
        APIClient().send(VendoredNetflixAPIEndpoints.tvShow(tvShowId: tvShowId)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.tvShow = nil
                self.state = .error
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.tvShow = response
            self.state = .data
        })
        .store(in: &disposables)
    }
}

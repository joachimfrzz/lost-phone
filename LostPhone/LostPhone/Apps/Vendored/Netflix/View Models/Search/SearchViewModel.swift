//
//  VendoredNetflixSearchViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

struct VendoredNetflixSearchItemViewModel {
    enum VendoredNetflixSearchItemType {
        case tvShow
        case movie
    }

    init(tvShow: VendoredNetflixTVShow) {
        self.type = .tvShow
        self.id = "\(tvShow.id)_\(self.type)"
        self.sourceId = tvShow.id
        self.title = tvShow.title
        self.posterPath = tvShow.posterPath
        self.popularity = tvShow.popularity
    }

    init(movie: VendoredNetflixMovie) {
        self.type = .movie
        self.id = "\(movie.id)_\(self.type)"
        self.sourceId = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.popularity = movie.popularity
    }

    let id: String
    let sourceId: Int
    let type: VendoredNetflixSearchItemType
    let title: String
    let posterPath: String?
    let popularity: Double

    var posterUrl: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        let url = URL(string: "\(APIClient.baseImageStringUrl)\(posterPath)")
        return url
    }
}

class VendoredNetflixSearchViewModel: ObservableObject {
    enum VendoredNetflixState {
        case initial
        case loading
        case error
        case data
    }

    @Published var searchText = ""
    @Published var items = [[VendoredNetflixSearchItemViewModel]]()
    @Published var state: VendoredNetflixState = .initial

    private var disposables = Set<AnyCancellable>()

    init() {
        $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { searchText in
                if !searchText.isEmpty {
                    self.performSearch(for: searchText)
                } else {
                    self.items = []
                }
        }.store(in: &disposables)
    }

    func performSearch(for text: String) {
        self.state = .loading
        self.items = []
        var movies = [VendoredNetflixSearchItemViewModel]()
        var tvShows = [VendoredNetflixSearchItemViewModel]()
        APIClient().send(VendoredNetflixAPIEndpoints.searchMovies(for: text)).mapError { error -> Error in
            self.state = .error
            self.items = []
            return error
        }
        .flatMap { response -> AnyPublisher<VendoredNetflixAPIResponseList<VendoredNetflixTVShow>, Error> in
            movies = response.results.map { VendoredNetflixSearchItemViewModel(movie: $0)}
            return APIClient().send(VendoredNetflixAPIEndpoints.searchTVShows(for: text))
        }
        .mapError { error -> Error in
            self.state = .error
            self.items = []
            return error
        }
        .map { response -> [VendoredNetflixSearchItemViewModel] in
            tvShows = response.results.map { VendoredNetflixSearchItemViewModel(tvShow: $0)}
            let concatItems = tvShows + movies
            if concatItems.isEmpty {
                self.state = .data
                self.items = []
            }
            return concatItems.sorted { $0.popularity > $1.popularity }
        }
        .flatMap { $0.publisher.setFailureType(to: Error.self) }
        .collect(3)
        .sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.items = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.items += Array(arrayLiteral: response)
        })
            .store(in: &disposables)
    }
}

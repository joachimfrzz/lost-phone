//
//  VendoredNetflixAPIEndpoints+Movies.swift
//  Notflix
//
//  Created by Quentin Eude on 11/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

extension VendoredNetflixAPIEndpoints {
    static let popularMovies = VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixMovie>>(path: "movie/popular")
    static let topRatedMovies = VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixMovie>>(path: "movie/top_rated")
    static let movieGenres = VendoredNetflixAPIRequest<VendoredNetflixAPIResponseGenres>(path: "genre/movie/list")
    static func recommendationsMovies(movieId: Int) -> VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixMovie>> { return VendoredNetflixAPIRequest(path: "movie/\(movieId)/recommendations") }
    static func movie(movieId: Int) -> VendoredNetflixAPIRequest<VendoredNetflixMovie> { return VendoredNetflixAPIRequest(path: "movie/\(movieId)")}
    static func moviesForGenre(genreId: Int) -> VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixMovie>> {
        return VendoredNetflixAPIRequest(
            path: "discover/movie",
            parameters: [
                "with_genres": String(genreId)
            ]
        )
    }
    static func movieCredits(movieId: Int) -> VendoredNetflixAPIRequest<VendoredNetflixAPIResponseCredits> { return VendoredNetflixAPIRequest(path: "movie/\(movieId)/credits")}
    static func searchMovies(for text: String) -> VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixMovie>> {
        return VendoredNetflixAPIRequest(
            path: "search/movie",
            parameters: [
                "query": text
            ]
        )}
}

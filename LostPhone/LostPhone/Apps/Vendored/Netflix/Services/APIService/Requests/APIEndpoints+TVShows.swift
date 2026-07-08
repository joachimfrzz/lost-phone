//
//  VendoredNetflixAPIEndpoints+TVShows.swift
//  Notflix
//
//  Created by Quentin Eude on 11/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

extension VendoredNetflixAPIEndpoints {
    static let popularTVShows = VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixTVShow>>(path: "tv/popular")
    static let topRatedTVShows = VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixTVShow>>(path: "tv/top_rated")
    static let tvShowGenres = VendoredNetflixAPIRequest<VendoredNetflixAPIResponseGenres>(path: "genre/tv/list")
    static func recommendationsTVShows(tvShowId: Int) -> VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixTVShow>> { return VendoredNetflixAPIRequest(path: "tv/\(tvShowId)/recommendations") }
    static func tvShow(tvShowId: Int) -> VendoredNetflixAPIRequest<VendoredNetflixTVShow> { return VendoredNetflixAPIRequest(path: "tv/\(tvShowId)")}
    static func tvSeason(tvShowId: Int, tvSeasonNumber: Int) -> VendoredNetflixAPIRequest<VendoredNetflixAPIResponseTVSeason> { return VendoredNetflixAPIRequest(path: "tv/\(tvShowId)/season/\(tvSeasonNumber)")}
    static func tvShowsForGenre(genreId: Int) -> VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixTVShow>> {
        return VendoredNetflixAPIRequest(
            path: "discover/tv",
            parameters: [
                "with_genres": String(genreId)
            ]
        )
    }
    static func searchTVShows(for text: String) -> VendoredNetflixAPIRequest<VendoredNetflixAPIResponseList<VendoredNetflixTVShow>> {
           return VendoredNetflixAPIRequest(
               path: "search/tv",
               parameters: [
                   "query": text
               ]
           )}
}

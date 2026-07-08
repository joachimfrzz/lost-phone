//
//  APIResponse.swift
//  Notflix
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

struct VendoredNetflixAPIResponseList<ResultType: Decodable>: Decodable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [ResultType]

    enum VendoredNetflixCodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct VendoredNetflixAPIResponseTVSeason: Decodable {
    let episodes: [VendoredNetflixEpisode]

    enum VendoredNetflixCodingKeys: String, CodingKey {
        case episodes
    }
}

struct VendoredNetflixAPIResponseGenres: Decodable {
    let genres: [VendoredNetflixGenre]

    enum VendoredNetflixCodingKeys: String, CodingKey {
        case genres
    }
}

struct VendoredNetflixAPIResponseCredits: Decodable {
    let cast: [VendoredNetflixActor]

    enum VendoredNetflixCodingKeys: String, CodingKey {
        case cast
    }
}

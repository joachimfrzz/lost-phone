//
//  MovieResponse.swift
//  Youtube_Netflix
//
//  Created by Sopheamen VAN on 30/8/24.
//

import Foundation

struct MovieResponse: Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var highlight: String // eg Recently Added, New Season, New Espisodes, and Empty String
    var trailVideoUrl: String
    var date: String // 2021, 2024
    var ageRestiction: String // 13+, 16+ or 18+
    var movieDuration: String
    var description: String // movie description
    var cast: String // for eg including all actors name, actresses with commas
    var directors: String // for eg including director names with commas
}

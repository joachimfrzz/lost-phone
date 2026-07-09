//
//  VendoredDisneyHomeViewModel.swift
//  DisneyPlus
//
//  Created by Goutham S on 05/07/22.
//

import Foundation
import SwiftUI

enum VendoredDisneyListGroup {
    case recommendation
    case new
    
    var list: [Image] {
        switch self {
        case .recommendation:
            return VendoredDisneyHomeViewModel().recommendations
        case .new:
            return VendoredDisneyHomeViewModel().newPosters
        }
    }
    
    var title: String {
        switch self {
        case .recommendation:
            return "Recommended For You"
        case .new:
            return "New to Disney+"
        }
    }
}

enum VendoredDisneyMovieGroup: String {
    case disney
    case pixar
    case marvel
    case starWars
    case natgeo
}

class VendoredDisneyHomeViewModel: ObservableObject, Identifiable {
    @Published var pageViews = [Image]()
    @Published var newPosters = [Image]()
    @Published var recommendations = [Image]()
    
    init() {
        setupPageViews()
        setupRecommendations()
        setupNewMovies()
    }
    
    private func setupPageViews() {
        pageViews = [
            Image("pg-mandalorian"),
            Image("pg-sorcererApprentice"),
            Image("pg-mulan"),
            Image("pg-animalKingdom"),
        ]
    }
    
    private func setupRecommendations() {
        recommendations = [
            Image("poster-avengers"),
            Image("poster-sorcerer"),
            Image("poster-moana"),
            Image("poster-solo"),
            Image("poster-hocusPocus"),
        ]
    }
    
    private func setupNewMovies() {
        newPosters = [
            Image("poster-mandalorian"),
            Image("poster-snowman"),
            Image("poster-sorcerer"),
            Image("poster-animalKingdom"),
            Image("poster-toyStory"),
        ]
    }
}

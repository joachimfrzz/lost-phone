//
//  StoriesResponse.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 18/5/24.
//

import Foundation

struct StoriesResponse: Hashable, Identifiable {
    var id: String
    var user: UserSnapchatResponse
    var title: String
    var videoUrl: String
    var totalViews: Int
    var music: MusicResponse
}

//
//  VendoredSnapchatStoriesResponse.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 18/5/24.
//

import Foundation

struct VendoredSnapchatStoriesResponse: Hashable, Identifiable {
    var id: String
    var user: VendoredSnapchatUserSnapchatResponse
    var title: String
    var videoUrl: String
    var totalViews: Int
    var music: VendoredSnapchatMusicResponse
}

//
//  VendoredYouTubeMusicMusicResponse.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 3/9/24.
//

import Foundation

struct VendoredYouTubeMusicMusicResponse: Identifiable {
    var id = UUID()
    var name: String
    var artistName: String
    var coverUrl: String
    var viewCount: String // for eg 7.6M views, 1.4M views
    var musicUrl: String
}

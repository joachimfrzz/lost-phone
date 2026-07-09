//
//  VendoredSpotifyReel.swift
//  SpotifySwiftUI
//
//  Created by ladans on 28/08/25.
//

import Foundation

struct VendoredSpotifyReel: Identifiable {
    var id: UUID = .init()
    let videoID: String
    let authorName: String
    var isLiked: Bool = false
}

var vendoredSpotifyReelsData: [VendoredSpotifyReel] {
    [
        .init(videoID: "reel1", authorName: "Google Pixel 10 zoom camera"),
        .init(videoID: "reel2", authorName: "Lida com números né?"),
        .init(videoID: "reel3", authorName: "Grany bugatti"),
        .init(videoID: "reel4", authorName: "New iPhone ringtones"),
        .init(videoID: "reel5", authorName: "Tokyo international exibition centre"),
    ]
}

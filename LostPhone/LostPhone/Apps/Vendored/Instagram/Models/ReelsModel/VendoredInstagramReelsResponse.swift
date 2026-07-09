//
//  VendoredInstagramReelsResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation

struct VendoredInstagramReelsResponse: Hashable, Identifiable {
    let id: String
    let user: VendoredInstagramUserInstagramResponse
    let song: VendoredInstagramSearchAudioResponse
    let caption: String?
    let videoUrl: String
    let totalLikes: Int
    let totalComments: Int
    let totalShares: Int
    
}

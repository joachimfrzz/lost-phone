//
//  ReelsResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation

struct ReelsResponse: Hashable, Identifiable {
    let id: String
    let user: UserInstagramResponse
    let song: SearchAudioResponse
    let caption: String?
    let videoUrl: String
    let totalLikes: Int
    let totalComments: Int
    let totalShares: Int
    
}

//
//  VendoredInstagramSearchAudioResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation

struct VendoredInstagramSearchAudioResponse: Hashable, Identifiable {
    let id: Int
    let imageCoverUrl: String
    let songName: String
    let ownerName: String
    let totalReels: Int
}

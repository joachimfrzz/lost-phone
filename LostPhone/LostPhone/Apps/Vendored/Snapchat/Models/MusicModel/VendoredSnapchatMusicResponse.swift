//
//  VendoredSnapchatMusicResponse.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 20/5/24.
//

import Foundation

struct VendoredSnapchatMusicResponse: Identifiable, Hashable {
    var id: UUID
    var musicName: String
    var ownerName: String
    var coverImage: String
}

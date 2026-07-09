//
//  VendoredInstagramPostResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation

struct VendoredInstagramPostResponse: Hashable, Identifiable {
    let id: Int
    let user: VendoredInstagramUserInstagramResponse
    let caption: String?
    let postType: Int  //Assuming 1 for image and 2 for video
    let imageOrVideoUrl: [String]
    let totalLikes: Int
    let totalComments: Int
    
}

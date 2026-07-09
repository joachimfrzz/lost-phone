//
//  PostResponse.swift
//  Youtube_Threads
//
//  Created by Sopheamen VAN on 25/9/24.
//

import Foundation

struct PostResponse: Identifiable {
    var id = UUID()
    var user: UserResponse
    var caption: String
    var imagesUrl: [String] // eg can be empty, 1 item, or more than 1, max is 4 items
    var totalLikes: Int
    var totalComments: Int
    var totalReposts: Int
    var totalShares: Int
    var postedAt: String // eg format something like this 4h, 2h, 2d, 1h
}

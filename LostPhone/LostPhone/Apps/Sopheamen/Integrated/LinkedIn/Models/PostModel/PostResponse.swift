//
//  PostResponse.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 23/4/24.
//

import Foundation

struct PostResponse:Identifiable, Hashable {
    var id: UUID
    var user: UserLinkedInResponse
    var userLikesThisPost: UserLinkedInResponse
    var caption: String
    var type: Int // assuming 1, 2 link
    var imageUrl: String
    var title: String?
    var readTimeAgo: String // for eg 4 min read
    var totalLikes: Int
    var totalComments: Int
    var totalReposts: Int
}

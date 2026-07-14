//
//  FeedResponse.swift
//  Youtube_Facebook
//
//  Created by Sopheamen VAN on 21/10/24.
//

import Foundation

struct FeedResponse: Identifiable {
    var id = UUID()
    var user:UserResponse
    var type: Int // for eg 1 news, 2 photo
    var caption: String?
    var newsCompany: String? // have value unless type = 1, and for eg BBC NEWS - 2-MINS READ
    var newsTitle: String? // have value unless type = 1, and for eg British Airways unveils jumpsuits in uniform..
    var totalLikes: String // for 9.7, 10.5
    var totalComments: String // for 1.5
    var totalShares: String  // 231, 481
    var imageUrls: [String] // if type = 1, value only 1 item, 2 can be more than 2 and max is 4 items
    var dateAgo: String  // for 3d, 4mn, 5hrs
    var companyProfileUrl: String?
}

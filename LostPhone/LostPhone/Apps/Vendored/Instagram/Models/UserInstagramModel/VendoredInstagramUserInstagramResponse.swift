//
//  UserResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 6/3/24.
//

import Foundation

struct VendoredInstagramUserInstagramResponse: Hashable, Identifiable {
     let id: Int
     let username: String
     let profileImage: String
     let fullname: String
     let pronouns: String?
     let bio: String?
     let link: String?
     let gender: String?
     let totalPosts: Int
     let totalFollowers: Int
     let totalFollowing: Int
}


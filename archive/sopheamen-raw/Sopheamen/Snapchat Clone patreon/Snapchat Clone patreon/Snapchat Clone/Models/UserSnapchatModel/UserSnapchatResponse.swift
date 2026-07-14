//
//  UserSnapchatResponse.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 18/5/24.
//

import Foundation

struct UserSnapchatResponse: Hashable, Identifiable {
    let id: UUID
    let username: String
    let fullname: String
    let profileImage: String
}

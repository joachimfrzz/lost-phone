//
//  UserResponse.swift
//  Youtube_Threads
//
//  Created by Sopheamen VAN on 25/9/24.
//

import Foundation

struct UserResponse: Identifiable {
    let id = UUID()
    let username: String
    let imageUrl: String
}

//
//  StoryResponse.swift
//  Youtube_Facebook
//
//  Created by Sopheamen VAN on 21/10/24.
//

import Foundation

struct StoryResponse: Identifiable {
    var id = UUID()
    var user: UserResponse
    var imageUrl: String
}


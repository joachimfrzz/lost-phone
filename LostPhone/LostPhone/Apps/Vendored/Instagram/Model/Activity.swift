//
//  VendoredInstagramActivity.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 22/05/21.
//

import Foundation

enum VendoredInstagramActivityType {
    case liked
    case newFollower
    case suggestFollower
    case comment
}

struct VendoredInstagramActivity: Identifiable {
    let id = UUID()
    let activity: VendoredInstagramActivityType
    let duration: String //Easier to show on UI.
    let usersInContext: [VendoredInstagramUser]
    let post: VendoredInstagramPost
    var comment: String = ""

    func getUsernames() -> String {
        return usersInContext.map{$0.userName}.joined(separator: ", ")
    }
}

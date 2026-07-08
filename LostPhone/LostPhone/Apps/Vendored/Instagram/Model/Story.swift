//
//  VendoredInstagramStory.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 04/04/21.
//

import Foundation

struct VendoredInstagramStory: Identifiable {
    let id = UUID()
    let user: VendoredInstagramUser
    var hasSeen: Bool = false
    var isMyStory: Bool = false
}

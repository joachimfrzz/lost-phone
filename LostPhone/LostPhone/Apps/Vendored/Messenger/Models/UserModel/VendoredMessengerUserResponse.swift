//
//  VendoredMessengerUserResponse.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 14/9/24.
//

import Foundation

struct VendoredMessengerUserResponse: Identifiable {
    var id = UUID()
    var name: String // isGroup = 1 fullname should be two names format like this Name, Name
    var imgUrl: String
    var isOnline: Int // for 1 online, 2 offline
    var offlineAgo: String // get from isOnline and value as 11m, 12h, 10m
    var isGroup: Int // 1 as group
    var imgGroupUrl: [String] // profile user and only two items
}

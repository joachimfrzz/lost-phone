//
//  VendoredAppStoreArticleResponse.swift
//  Youtube_Appstore
//
//  Created by Sopheamen VAN on 19/9/24.
//

import Foundation

struct VendoredAppStoreArticleResponse: Identifiable {
    var id = UUID()
    var header: String?
    var title: String
    var description: String
    var image: String
    var type: Int // 1: featured, 2: list app icons, 3: highlight
    var appInfo: [VendoredAppStoreAppResponse] // more than 6 items
}

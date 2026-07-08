//
//  VendoredPhantomOptionsResponse.swift
//  Youtube_Phantom_clone
//
//  Created by Sopheamen VAN on 13/3/25.
//

import Foundation

struct VendoredPhantomOptionsResponse:Identifiable {
    var id = UUID()
    var title: String
    var icon: String
    var size:CGFloat?
}

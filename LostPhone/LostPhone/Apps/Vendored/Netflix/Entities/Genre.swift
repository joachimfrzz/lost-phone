//
//  VendoredNetflixGenre.swift
//  Notflix
//
//  Created by Quentin Eude on 20/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
struct VendoredNetflixGenre: Decodable, Identifiable {
    let id: Int
    let name: String

    enum VendoredNetflixCodingKeys: String, CodingKey {
        case id
        case name
    }
}

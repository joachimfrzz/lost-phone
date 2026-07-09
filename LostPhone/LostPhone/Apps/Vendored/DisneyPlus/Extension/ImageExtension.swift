//
//  ImageExtension.swift
//  DisneyPlus
//
//  Created by Goutham S on 05/07/22.
//

import SwiftUI

extension Image: Identifiable {
    public var id: String {
        return UUID().uuidString
    }
}

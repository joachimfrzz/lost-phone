//
//  UserResponse.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 6/4/24.
//

import Foundation

struct UserResponse: Hashable, Identifiable {
    var id: UUID
    var name: String
    var profileUrl: String
}

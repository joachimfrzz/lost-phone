//
//  MessagingResponse.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 1/4/24.
//

import Foundation

struct MessagingResponse: Hashable, Identifiable {
    let id: Int
    let text: String
    let isMe: Bool
}

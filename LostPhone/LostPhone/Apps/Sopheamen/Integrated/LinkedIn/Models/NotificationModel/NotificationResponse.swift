//
//  NotificationResponse.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 24/4/24.
//

import Foundation

struct NotificationResponse:Identifiable, Hashable {
    var id: UUID
    var user: UserLinkedInResponse
    var title: String
    var buttonType: Int // assuming 1 view jobs, 2 message, 0 no button view
    var timeAgo: String // 16h 
}

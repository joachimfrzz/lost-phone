//
//  AudioEventModel.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 24/4/24.
//

import Foundation

struct VendoredLinkedInAudioEventResponse: Identifiable, Hashable {
    var id: UUID
    var imageCover: String
    var title: String
    var date: String
    var totalAttendees: Int
}

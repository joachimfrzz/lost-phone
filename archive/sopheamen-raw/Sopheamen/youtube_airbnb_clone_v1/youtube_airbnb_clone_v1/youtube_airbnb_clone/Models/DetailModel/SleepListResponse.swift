//
//  SleepListResponse.swift
//  youtube_airbnb_clone
//
//  Created by Sopheamen VAN on 21/1/25.
//

import Foundation

struct SleepListResponse:Identifiable {
    var id = UUID()
    var imgUrl:String
    var name:String // for eg. Bedroom 1, Bedroom 2
    var description: String // for eg. 1 king bed, 1 queen bed
}

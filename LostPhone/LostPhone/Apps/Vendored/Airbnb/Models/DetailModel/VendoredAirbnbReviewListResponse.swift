//
//  VendoredAirbnbReviewListResponse.swift
//  youtube_airbnb_clone
//
//  Created by Sopheamen VAN on 21/1/25.
//

import Foundation

struct VendoredAirbnbReviewListResponse:Identifiable {
    var id = UUID()
    var name:String
    var profileUrl:String
    var description:String
    var dateAgo:String
}



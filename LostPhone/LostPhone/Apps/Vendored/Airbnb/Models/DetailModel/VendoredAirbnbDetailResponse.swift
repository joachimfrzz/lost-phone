//
//  VendoredAirbnbDetailResponse.swift
//  youtube_airbnb_clone
//
//  Created by Sopheamen VAN on 21/1/25.
//

import Foundation

struct VendoredAirbnbDetailResponse:Identifiable {
    var id = UUID()
    var hostBy:String
    var hostImgUrl:String
    var hostAgo: String
    var hostList:[VendoredAirbnbHostListResponse]
    var bedRoomDetail:[VendoredAirbnbSleepListResponse]
    var placeOfferList:[VendoredAirbnbPlaceOfferResponse]
    var reviewList:[VendoredAirbnbReviewListResponse]
}

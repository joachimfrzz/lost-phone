//
//  DetailResponse.swift
//  youtube_airbnb_clone
//
//  Created by Sopheamen VAN on 21/1/25.
//

import Foundation

struct DetailResponse:Identifiable {
    var id = UUID()
    var hostBy:String
    var hostImgUrl:String
    var hostAgo: String
    var hostList:[HostListResponse]
    var bedRoomDetail:[SleepListResponse]
    var placeOfferList:[PlaceOfferResponse]
    var reviewList:[ReviewListResponse]
}

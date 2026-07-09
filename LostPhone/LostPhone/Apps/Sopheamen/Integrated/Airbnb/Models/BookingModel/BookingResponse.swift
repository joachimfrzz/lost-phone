//
//  BookingResponse.swift
//  youtube_airbnb_clone
//
//  Created by Sopheamen VAN on 21/1/25.
//

import Foundation

struct BookingResponse: Identifiable {
    var id = UUID()
    var placeImages:[String] //for eg images more than 2 items to 5 items
    var name:String
    var description:String // for eg Dreamtime - Modern A - Frame Cabin w/ Hot tub
    var capacity: String // for eg 4 guests - 2 bedrooms - 2 beds - 2 baths
    var rating:String // for eg 4.99
    var totalRating: String // for eg 239
    var mileAway:String // for eg 56 miles away
    var date:String // Feb 4-9
    var price:String // $290 night
    var isFavourite:Bool
}

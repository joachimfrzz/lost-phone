//
//  HostListResponse.swift
//  youtube_airbnb_clone
//
//  Created by Sopheamen VAN on 21/1/25.
//

import Foundation

struct HostListResponse:Identifiable {
    var id = UUID()
    var name:String
    var description:String
    var icon:String
}

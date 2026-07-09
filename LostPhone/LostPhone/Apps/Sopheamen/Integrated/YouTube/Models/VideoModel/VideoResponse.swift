//
//  VideoResponse.swift
//  Youtube_Youtube
//
//  Created by Sopheamen VAN on 14/10/24.
//

import Foundation

struct VideoResponse: Identifiable {
    let id = UUID()
    let videoType: Int // 1 as normal video, 2 shorts video
    let title: String
    let thumbnailUrl: String
    let duration: String
    let videoUrl: String
    let channelName: String
    let channelImgUrl: String
    let channelsubscribers: String
    let totalViews: String
    let totallyLiked: String
    let publishedAt: String // for eg like 21h ago, 2 days ago, 1 month ago and other
    let totalcomments: String
    let lastcommentString: String // for eg this is the best video ever
    let lastcommentImgUrl: String
}
  

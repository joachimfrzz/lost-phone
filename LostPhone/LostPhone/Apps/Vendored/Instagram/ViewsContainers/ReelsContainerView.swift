//
//  ReelsView.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 03/04/21.
//

import SwiftUI
import AVKit

struct VendoredInstagramReelsContainerView: View {
    
    @State private var index = 0
    @State private var top = 0
    @State private var videos = VendoredInstagramMockData().videos
    
    var body: some View{
        ZStack{
            VendoredInstagramPlayerPageView(videos: self.$videos)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}


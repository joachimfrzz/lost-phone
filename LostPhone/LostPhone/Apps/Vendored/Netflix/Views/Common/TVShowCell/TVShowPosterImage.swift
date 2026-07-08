//
//  VendoredNetflixTVShowPosterImage.swift
//  Notflix
//
//  Created by Quentin Eude on 19/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixTVShowPosterImage: View {
    private let tvShow: VendoredNetflixTVShow

    init(for tvShow: VendoredNetflixTVShow) {
        self.tvShow = tvShow
    }

    var body: some View {
        Group {
            if tvShow.posterUrl != nil {
                VendoredNetflixAsyncImage(url: tvShow.posterUrl!,
                           configuration: {AnyView($0.resizable())},
                           defaultView: {
                            AnyView(
                                Text(self.tvShow.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            )
                })
            } else {
                Text(self.tvShow.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 150, height: 245)
        .background(Color.vendoredNetflixDarkGray)
        .cornerRadius(8.0)
    }
}


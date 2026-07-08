//
//  VendoredNetflixTVShowCell.swift
//  Notflix
//
//  Created by Quentin Eude on 14/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixTVShowCell: View {
    var tvShow: VendoredNetflixTVShow

    init(for tvShow: VendoredNetflixTVShow) {
        self.tvShow = tvShow
    }

    var body: some View {
        NavigationLink(destination: VendoredNetflixTVShowDetails(tvShowId: tvShow.id)) {
            Group {
                VendoredNetflixTVShowPosterImage(for: tvShow)
            }
        }
    }
}


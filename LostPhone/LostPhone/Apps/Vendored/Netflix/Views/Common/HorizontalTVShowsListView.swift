//
//  TVShowsView.swift
//  Notflix
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixHorizontalTVShowsListView: View {
    @ObservedObject var tvShowsViewModel: VendoredNetflixHorizontalTVShowsListViewModel

    var listName: String

    init(tvShowsViewModel: VendoredNetflixHorizontalTVShowsListViewModel, listName: String = "") {
        self.tvShowsViewModel = tvShowsViewModel
        self.listName = listName
    }

    var body: some View {
        Group {
            if tvShowsViewModel.state == .loading {
                VStack(alignment: .leading, spacing: 10) {
                    VendoredNetflixShimmerView().frame(height: 32)
                    VendoredNetflixShimmerView().frame(height: 245)
                }.padding([.leading, .trailing], 10)
            } else {
                if !tvShowsViewModel.tvShows.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(listName)
                            .padding(.leading, 16)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(tvShowsViewModel.tvShows) { tvShow in
                                    VendoredNetflixTVShowCell(for: tvShow)
                                }
                            }
                            .frame(height: 245)
                            .padding([.leading, .trailing], 10)
                        }
                    }
                } else {
                    Rectangle().fill(Color.clear)
                }
            }
        }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
    }
}


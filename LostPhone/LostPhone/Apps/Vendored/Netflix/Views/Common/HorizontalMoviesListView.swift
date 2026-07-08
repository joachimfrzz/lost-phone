//
//  VendoredNetflixHorizontalMoviesListView.swift
//  Notflix
//
//  Created by Quentin Eude on 14/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixHorizontalMoviesListView: View {
   @ObservedObject var horizontalMoviesListViewModel: VendoredNetflixHorizontalMoviesListViewModel

        var listName: String

        init(horizontalMoviesListViewModel: VendoredNetflixHorizontalMoviesListViewModel, listName: String = "") {
            self.horizontalMoviesListViewModel = horizontalMoviesListViewModel
            self.listName = listName
        }

        var body: some View {
            Group {
                if horizontalMoviesListViewModel.state == .loading {
                    VStack(alignment: .leading, spacing: 10) {
                        VendoredNetflixShimmerView().frame(height: 32)
                        VendoredNetflixShimmerView().frame(height: 245)
                    }.padding([.leading, .trailing], 10)
                } else {
                    if !horizontalMoviesListViewModel.movies.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(listName)
                                .padding(.leading, 16)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(horizontalMoviesListViewModel.movies) { movie in
                                        VendoredNetflixMovieCell(for: movie)
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
struct HorizontalMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VendoredNetflixHorizontalMoviesListView(horizontalMoviesListViewModel: VendoredNetflixHorizontalMoviesListViewModel(fetcher: VendoredNetflixAPIEndpoints.popularMovies),
                                     listName: "Popular Movies")
        }
    }
}

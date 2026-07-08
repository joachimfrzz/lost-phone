//
//  VendoredNetflixMovieCastListView.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixMovieCastListView: View {
    @ObservedObject private var movieCastViewModel: VendoredNetflixMovieCastViewModel

    init(movieId: Int) {
        self.movieCastViewModel = VendoredNetflixMovieCastViewModel(movieId: movieId)
    }

    var body: some View {
        Group {
            if self.movieCastViewModel.state != .loading {
                VStack(alignment: .leading, spacing: 10) {
                    Text(L10n.Movie.Details.Cast.list)
                        .padding(.leading, 16)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            Group {
                                ForEach(movieCastViewModel.actors) { actor in
                                    self.cellFor(actor: actor)
                                }
                            }
                        }
                        .frame(height: 170)
                        .padding([.leading, .trailing], 10)
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    VendoredNetflixShimmerView().frame(height: 32)
                    VendoredNetflixShimmerView().frame(height: 170)
                }.padding([.leading, .trailing], 10)
            }
        }
    }

    func cellFor(actor: VendoredNetflixActor) -> some View {
        return Group {
            if actor.profileUrl != nil {
                VStack(alignment: .center, spacing: 16) {
                    VendoredNetflixAsyncImage(url: actor.profileUrl!,
                               configuration: {AnyView($0.resizable().scaledToFill())},
                               defaultView: {
                                AnyView(
                                    VendoredNetflixShimmerView()
                                )
                    })
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    Text(actor.name).foregroundColor(.white)
                }
            } else {
               VStack(alignment: .center, spacing: 16) {
                Color.darkerGray
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                Text(actor.name).foregroundColor(.white)
                }
            }
        }
    }
}

struct MovieCastListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VendoredNetflixMovieCastListView(movieId: 330457)
        }
    }
}

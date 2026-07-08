//
//  VendoredNetflixHomeView.swift
//  Notflix
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

enum VendoredNetflixSelectedType {
    case tvShows
    case movies
}

struct VendoredNetflixHomeView: View {
    @State public var selectedType: VendoredNetflixSelectedType = .tvShows

    var body: some View {
        NavigationView {
            ZStack {
                Color(.black).edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        header
                        self.containedView()
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }

    var header: some View {
        HStack {
            Button(L10n.Home.Tab.tvshows) {
                self.selectedType = .tvShows
            }
            .font(.system(size: 18, weight: .bold))
            .accentColor(self.selectedType == .tvShows ? .red : .white)
            .padding()
            Button(L10n.Home.Tab.movies) {
                self.selectedType = .movies
            }
                .font(.system(size: 18, weight: .bold))

            .accentColor(self.selectedType == .movies ? .red : .white)
            .padding()
        }.padding(.bottom, 40)
    }

    func containedView() -> AnyView {
        switch selectedType {
        case .tvShows: return AnyView(VendoredNetflixHomeTVShowsView())
        case .movies: return AnyView(VendoredNetflixHomeMoviesView())
        }
    }
}


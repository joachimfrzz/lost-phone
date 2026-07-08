//
//  VendoredNetflixAsyncImage.swift
//  Notflix
//
//  Created by Quentin Eude on 03/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixAsyncImage: View {
    @ObservedObject private var loader: VendoredNetflixImageLoaderViewModel
    @VendoredNetflixState var shouldAnimate = true
    private let configuration: (Image) -> AnyView
    private let defaultView: (() -> AnyView?)?

    init(url: URL,
         configuration: @escaping (Image) -> AnyView = { AnyView($0) },
         defaultView: (() -> AnyView?)? = nil ) {
        self.configuration = configuration
        loader = VendoredNetflixImageLoaderViewModel(url: url)
        self.defaultView = defaultView
    }
    var body: some View {
        image
    }

    private var image: some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!)
                    .renderingMode(.original))
            } else {
                if defaultView != nil {
                    defaultView?().onAppear(perform: loader.load)
                        .onDisappear(perform: loader.cancel)
                } else {
                    VendoredNetflixActivityIndicator(shouldAnimate: self.$shouldAnimate)
                        .onAppear(perform: loader.load)
                        .onDisappear(perform: loader.cancel)
                }
            }
        }
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        VendoredNetflixAsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!)
    }
}

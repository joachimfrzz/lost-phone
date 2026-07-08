//
//  VendoredNetflixSearchBar.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixSearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(Color.vendoredNetflixLightGray)

                TextField("Search", text: $text)
                    .foregroundColor(Color.vendoredNetflixLightGray)

                Group {
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill").foregroundColor(Color.vendoredNetflixLightGray)

                        })
                    } else {
                        EmptyView()
                    }
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(Color.vendoredNetflixLightGray)
            .background(Color.vendoredNetflixDarkGray)
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}


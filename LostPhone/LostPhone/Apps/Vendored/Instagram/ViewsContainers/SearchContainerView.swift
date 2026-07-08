//
//  SearchView.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 03/04/21.
//

import SwiftUI

struct VendoredInstagramSearchContainerView: View {
    
    private let searchStrings: [String] = []
    @State private var searchText : String = ""

    var body: some View {
        ScrollView {
            VendoredInstagramSearchBar(text: $searchText, placeholder: "Search")
            VendoredInstagramPostGridView(posts: VendoredInstagramMockData().posts)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredInstagramSearchContainerView()
    }
}

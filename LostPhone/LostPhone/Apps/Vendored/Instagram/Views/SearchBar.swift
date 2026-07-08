//
//  Searchbar.swift
//  Instagram-SwiftUI
//
//  Created by Pankaj Gaikar on 22/05/21.
//

import Foundation
import SwiftUI

struct VendoredInstagramSearchBar: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String

    class VendoredInstagramCoordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> VendoredInstagramSearchBar.VendoredInstagramCoordinator {
        return VendoredInstagramCoordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<VendoredInstagramSearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<VendoredInstagramSearchBar>) {
        uiView.text = text
    }
}

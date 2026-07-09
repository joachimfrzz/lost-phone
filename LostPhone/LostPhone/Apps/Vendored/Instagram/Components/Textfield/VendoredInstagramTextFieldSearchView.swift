//
//  VendoredInstagramTextFieldSearchView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI

struct VendoredInstagramTextFieldSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack (spacing: 0){
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.black.opacity(0.3))
                .padding(.leading, 8)
            TextField("Search", text: $searchText)
                .padding(.all,6)
        }
        .background(Color.vendoredInstagramTextFieldBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    VendoredInstagramTextFieldSearchView()
}

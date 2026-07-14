//
//  SearchView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 16/3/24.
//

import SwiftUI
import Kingfisher
struct SearchView: View {
   @State private var isSearching = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // search text field view
                TextFieldSearchView()
                    .padding(.horizontal)
                    .padding(.bottom,4)
                    .onTapGesture {
                        isSearching = true
                    }
                
                
                // grid photo and video view
                PostGridView()
            }
            .navigationDestination(isPresented: $isSearching) {
                SearchDetailView()
            }
            
        }
    }
}

#Preview {
    SearchView()
}

//
//  VendoredInstagramSearchView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 16/3/24.
//

import SwiftUI
import Kingfisher
struct VendoredInstagramSearchView: View {
   @State private var isSearching = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // search text field view
                VendoredInstagramTextFieldSearchView()
                    .padding(.horizontal)
                    .padding(.bottom,4)
                    .onTapGesture {
                        isSearching = true
                    }
                
                
                // grid photo and video view
                VendoredInstagramPostGridView()
            }
            .navigationDestination(isPresented: $isSearching) {
                VendoredInstagramSearchDetailView()
            }
            
        }
    }
}

#Preview {
    VendoredInstagramSearchView()
}

//
//  VendoredFacebookContentView.swift
//  Youtube_Facebook
//
//  Created by Sopheamen VAN on 21/10/24.
//

import SwiftUI

struct VendoredFacebookContentView: View {
    var body: some View {
        NavigationStack {
            VendoredFacebookHomeView()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink {
                            VendoredFacebookProfileView()
                        } label: {
                            Image(systemName: "person.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Color.vendoredFacebookVendoredFacebookPrimary)
                        }
                    }
                }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    VendoredFacebookContentView()
}

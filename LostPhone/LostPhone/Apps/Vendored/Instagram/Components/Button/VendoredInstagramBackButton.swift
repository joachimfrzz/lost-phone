//
//  VendoredInstagramBackButton.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct VendoredInstagramBackButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10)
                .foregroundStyle(.black)
               
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

#Preview {
    VendoredInstagramBackButton(action: {})
}

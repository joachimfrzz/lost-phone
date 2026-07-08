//
//  PrimaryButton.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct VendoredInstagramPrimaryButtonView: View {
    var title: String
   
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .background(Color.vendoredInstagramVendoredInstagramPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    VendoredInstagramPrimaryButtonView(title: "Log in")
}

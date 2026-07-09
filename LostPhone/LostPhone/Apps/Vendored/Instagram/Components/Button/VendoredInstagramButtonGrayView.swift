//
//  VendoredInstagramButtonGrayView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 18/3/24.
//

import SwiftUI

struct VendoredInstagramButtonGrayView: View {
    var title: String
    var body: some View {
        Text(title)
           .font(.subheadline)
           .fontWeight(.semibold)
           .padding(.horizontal,12)
           .padding(.vertical,6)
           .foregroundStyle(.black)
        .frame(width: 150)
        .background(Color.vendoredInstagramTextFieldBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    
    }
}

#Preview {
    VendoredInstagramButtonGrayView(title: "Edit profile")
}

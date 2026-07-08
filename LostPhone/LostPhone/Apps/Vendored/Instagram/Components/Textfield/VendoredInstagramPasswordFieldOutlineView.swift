//
//  VendoredInstagramPasswordFieldOutlineView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct VendoredInstagramPasswordFieldOutlineView: View {
    var placeHolder: String
    @Binding var controller: String
    
    var body: some View {
        SecureField(placeHolder, text: $controller)
            .padding(.vertical,12)
            .padding(.horizontal)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.4)))
            
    }
}

#Preview {
    VendoredInstagramPasswordFieldOutlineView(placeHolder: "Password", controller: .constant(""))
}

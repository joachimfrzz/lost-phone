//
//  PasswordFieldOutlineView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct PasswordFieldOutlineView: View {
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
    PasswordFieldOutlineView(placeHolder: "Password", controller: .constant(""))
}

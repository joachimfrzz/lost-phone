//
//  PrimaryOutlineButtonView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct PrimaryOutlineButtonView: View {
    var title:String
    var foregroundColor: Color?
    var outlineColor: Color?
    var action: ()-> Void
    var body: some View {
        Button (action: action){
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(foregroundColor ?? .black.opacity(0.8))
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(outlineColor ?? .black.opacity(0.5)))
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
}

#Preview {
    PrimaryOutlineButtonView(title: "Log into another account", action: {})
}

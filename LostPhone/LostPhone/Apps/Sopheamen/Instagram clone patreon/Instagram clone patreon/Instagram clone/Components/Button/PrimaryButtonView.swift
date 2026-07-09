//
//  PrimaryButton.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct PrimaryButtonView: View {
    var title: String
   
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .background(Color.primaryColor)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    PrimaryButtonView(title: "Log in")
}

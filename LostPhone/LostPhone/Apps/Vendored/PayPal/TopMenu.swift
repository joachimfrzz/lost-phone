//
//  VendoredPayPalCircleButton.swift
//  PayPal_clone
//
//  Created by Natalia Ogorek on 18.03.25.
//

import SwiftUI

struct VendoredPayPalCircleButton: View {
    let systemImage: String
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 50)
            .overlay(
                Image(systemName: systemImage)
                    .foregroundColor(.blue)
                    .bold()
            )
    }
}


struct VendoredPayPalTopMenu: View {
    
    var body: some View {
        HStack {
            VendoredPayPalCircleButton(systemImage: "line.3.horizontal")
            VendoredPayPalCircleButton(systemImage: "questionmark")
            VendoredPayPalCircleButton(systemImage: "qrcode")
            NavigationLink(destination: VendoredPayPalProfileView()) {
                VendoredPayPalCircleButton(systemImage: "person")
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    VendoredPayPalTopMenu()
}

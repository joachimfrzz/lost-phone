//
//  VendoredInstagramLoginView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct VendoredInstagramLoginView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var username: String = vendoredInstagramUserDataCurrent.fullname
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            VStack {
            // back button
            VendoredInstagramBackButton(action: {
                dismiss()
            })
            // logo
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60,height: 60)
            }
            .frame(width: .infinity,height: 200)
                
            // form
            VStack (spacing: 12){
                VendoredInstagramTextFieldOutlineView(placeHolder: "Username, email or mobile number", controller: $username)
                VendoredInstagramPasswordFieldOutlineView(placeHolder: "Password", controller: $password)
                NavigationLink(destination: VendoredInstagramSaveLoginInfoView()) {
                    VendoredInstagramPrimaryButtonView(title: "Log in")
                }
                Button {
                    
                }label: {
                    Text("Forgot Password?")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.vendoredInstagramBlackOpacity)
                }
            }
            Spacer()
            VendoredInstagramPrimaryOutlineButtonView(title: "Create new account",foregroundColor: Color.vendoredInstagramVendoredInstagramPrimary, outlineColor: Color.vendoredInstagramVendoredInstagramPrimary, action: {})
                Image("meta_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
        }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            
           
            
        }
       
    }
}

#Preview {
    VendoredInstagramLoginView()
}

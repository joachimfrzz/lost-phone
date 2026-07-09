//
//  LoginView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var username: String = userDataCurrent.fullname
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            VStack {
            // back button
            BackButton(action: {
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
                TextFieldOutlineView(placeHolder: "Username, email or mobile number", controller: $username)
                PasswordFieldOutlineView(placeHolder: "Password", controller: $password)
                NavigationLink(destination: SaveLoginInfoView()) {
                    PrimaryButtonView(title: "Log in")
                }
                Button {
                    
                }label: {
                    Text("Forgot Password?")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blackOpacity)
                }
            }
            Spacer()
            PrimaryOutlineButtonView(title: "Create new account",foregroundColor: Color.primaryColor, outlineColor: Color.primaryColor, action: {})
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
    LoginView()
}

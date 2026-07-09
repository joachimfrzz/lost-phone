//
//  LoginView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI
import Kingfisher

struct LandingLoginView: View {
    var body: some View {
        NavigationStack {
            VStack {
                VStack (spacing: 20){
                    // header gear and logo
                    Image(systemName: "gearshape")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22,height:22)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .trailing)
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50,height: 50)
                    
                }
                Spacer()
                
                VStack (spacing: 30){
                    // logo and username
                    CircleAvatarProfileBigView(profileUrl: userDataCurrent.profileImage, width: 200, height: 200)
                    Text(userDataCurrent.username)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    // button
                    VStack (spacing: 12){
                        NavigationLink(destination: LoginView()) {
                            PrimaryButtonView(title: "Log in")
                        }
                        PrimaryOutlineButtonView(title: "Log into another account", action: {})
                        
                        
                    }
                }
                
                Spacer()
                
                VStack (spacing: 5){
                    Text("Create new account")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black.opacity(0.8))
                    Image("meta_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                }
                
            }
            .padding()
            
        }
    }
}

#Preview {
    LandingLoginView()
}

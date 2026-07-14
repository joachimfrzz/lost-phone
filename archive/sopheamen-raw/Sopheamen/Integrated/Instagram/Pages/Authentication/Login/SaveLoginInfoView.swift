//
//  SaveLoginInfoView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 7/3/24.
//

import SwiftUI

struct SaveLoginInfoView: View {
    @Environment(\.dismiss) var dismiss
//    @State private var isAuthenticated = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // title and sub title
                VStack (alignment: .center){
                    Text("Save your login info?")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    Text("We'll save the login info for ")
                        .font(.body) +
                    Text(userDataCurrent.username)
                        .font(.body)
                        .fontWeight(.semibold) +
                    Text(", so you won't need to enter it on your iCloud devices next time you log in.")
                }
                Spacer()
                CircleAvatarProfileBigView(profileUrl: userDataCurrent.profileImage, width: 200, height: 200)
                Spacer()
                VStack (spacing: 12){
                    NavigationLink(destination: RootApp()){
                        PrimaryButtonView(title: "Save")
                    }
                    PrimaryOutlineButtonView(title: "Not now", action: {
                        dismiss()
                    })
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical, 40)
//            .navigationDestination(isPresented: $isAuthenticated) {
//                RootApp()
//            }
        }
    }
}

#Preview {
    SaveLoginInfoView()
}

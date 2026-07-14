//
//  EditProfileView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var nameTextfield = userDataCurrent.fullname
    @State private var usernameTextfield = userDataCurrent.username
    @State private var pronounsTextfield = ""
    @State private var bioTextfield = ""
    @State private var addLinkTextfield = ""
    @State private var genderTextfield = "Male"
    
    @Environment(\.dismiss)  var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 14){
                    // image profile view
                    ProfileImageView(profileImage: userDataCurrent.profileImage, size: 100)
                    Button {
                        
                    }label: {
                        Text("Edit picture or avatar")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primaryColor)
                    }
                    // divider line
                    Divider()
                    
                    VStack (alignment: .leading){
                        TextFieldBottomBorderLineView(placeHolder: "Name", controller: $nameTextfield)
                        TextFieldBottomBorderLineView(placeHolder: "Username", controller: $usernameTextfield)
                        TextFieldBottomBorderLineView(placeHolder: "Pronouns", controller: $pronounsTextfield)
                        TextFieldBottomBorderLineView(placeHolder: "Bio", controller: $bioTextfield)
                        
                    }
                    .padding(.horizontal)
                    
                    // add links
                    VStack (spacing: 12){
                        HStack {
                            Text("Links")
                                .fontWeight(.regular)
                                .frame(maxWidth: 100,alignment: .leading)
                            TextField("Add Links",text: $addLinkTextfield)
                                .disabled(true)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.blackOpacity.opacity(0.5))
                        }
                        .padding(.horizontal)
                        Divider()
                    }
                    
                    // gender
                    VStack (spacing: 12){
                        HStack {
                            Text("Gender")
                                .fontWeight(.regular)
                                .frame(maxWidth: 100,alignment: .leading)
                            TextField("Gender",text: $genderTextfield)
                                .disabled(true)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.blackOpacity.opacity(0.5))
                        }
                        .padding(.horizontal)
                        Divider()
                    }
                    
                    // switch account
                    VStack (alignment: .leading,spacing: 12){
                        Text("Switch to professional account")
                            .fontWeight(.regular)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundStyle(Color.primaryColor)
                            .padding(.horizontal)
                        Divider()
                        
                    }
                    
                    // personal information settings
                    Text("Personal information settings")
                        .fontWeight(.regular)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundStyle(Color.primaryColor)
                        .padding(.horizontal)
                        .padding(.vertical, -6)
                
                   
                }
                
            }
            .navigationTitle("Edit profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    }label: {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundStyle(.black)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    }label: {
                        Text("Done")
                            .font(.headline)
                            .foregroundStyle(Color.primaryColor)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    EditProfileView()
}

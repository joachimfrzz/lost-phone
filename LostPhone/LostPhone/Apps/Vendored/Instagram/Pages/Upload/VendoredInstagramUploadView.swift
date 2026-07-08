//
//  VendoredInstagramUploadView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 3/4/24.
//

import SwiftUI

struct VendoredInstagramUploadView: View {
    @Environment(\.dismiss)  var dismiss
    var displayImage: UIImage?
    @State private var captionTextField = ""
    @State private var isOnFacebook = false
    var body: some View {
        NavigationStack {
            VStack {
                HStack (alignment: .top){
                    if let image = displayImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 65, height: 80)
                            .clipped()
                    }else {
                        Rectangle()
                            .fill(Color.vendoredInstagramVendoredInstagramPrimary)
                            .frame(width: 65, height: 80)
                    }
                   
                    Spacer()
                    TextField("Write a caption", text: $captionTextField)

                }
                .padding()
                
                VStack (spacing: 14){
                    // divider
                    Divider()
                        .background(.white)
                    HStack {
                        Text("Tag people")
                            .font(.subheadline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    Divider()
                        .background(.white)
                    HStack {
                        Text("Add location")
                            .font(.subheadline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    Divider()
                        .background(.white)
                    HStack {
                        Text("Facebook")
                            .font(.subheadline)
                        Spacer()
                        Toggle(isOn: $isOnFacebook) {
                            
                        }
                    }
                    .padding(.vertical, -5)
                    .padding(.horizontal)
                }
                Spacer()
                
                
            }
            .navigationTitle("New post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.white)
                          
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        
                    }label: {
                        Text("Share")
                            .font(.headline)
                            .foregroundStyle(Color.vendoredInstagramVendoredInstagramPrimary)
                    }
                }
            }
            
        }
        .colorScheme(.dark)
    }
}

#Preview {
    VendoredInstagramUploadView()
}

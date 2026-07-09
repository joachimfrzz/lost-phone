//
//  NewCommunityView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 11/4/24.
//

import SwiftUI

struct NewCommunityView: View {
    @Environment(\.dismiss)  var dismiss
    @State private var communityName = ""
    @State private var communityPurpose = ""
    var body: some View {
        NavigationStack {
            ScrollView {
               
                VStack (spacing: 20){
                    
                    Spacer()
                    
                    // example difference coummnities
                    HStack (spacing:14){
                        Image(systemName: "circle.square.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.primaryColor)
                        Text("See examples")
                            .font(.subheadline)
                            .foregroundStyle(Color.primaryColor) +
                        Text(" of difference communities")
                            .font(.subheadline)
                            .foregroundStyle(Color.black)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,14)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack (spacing: 5){
                        // edit profile
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 26, height: 26)
                            .foregroundStyle(Color.white)
                            .padding(.all,30)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.gray.opacity(0.4)]), startPoint: .bottomTrailing, endPoint: .topTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Button {
                            
                        } label: {
                            Text("Edit")
                                .font(.headline)
                                .foregroundStyle(Color.primaryColor)
                        }
                    }
                    // textfield
                    TextField("Community name", text: $communityName)
                        .padding(.vertical, 8)
                        .padding(.horizontal,12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    TextEditor(text: $communityPurpose)
                        .frame(minHeight: 100, maxHeight: 200)
                        .padding(.vertical, 8)
                        .padding(.horizontal,12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Spacer()
                    Spacer()
                    
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
                
            }
            .navigationBarTitle("New Community", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    }label: {
                        Text("Cancel")
                            .font(.subheadline)
                            .foregroundStyle(Color.primaryColor)
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Text("Next")
                        .font(.subheadline)
                        .foregroundStyle(Color.primaryColor)
                }
            }
            .background(Color.backgroundColor)
        }
        
    }
}

#Preview {
    NewCommunityView()
}

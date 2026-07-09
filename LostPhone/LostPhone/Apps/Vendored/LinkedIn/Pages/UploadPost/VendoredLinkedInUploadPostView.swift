//
//  VendoredLinkedInUploadPostView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 7/5/24.
//

import SwiftUI
import Kingfisher

struct VendoredLinkedInUploadPostView: View {
    @Environment(\.dismiss)  var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // profile
                    VendoredLinkedInProfileView()
                    
                    // caption field
                    VendoredLinkedIncaptionFieldView()
                    
                    // photo browse
                    VendoredLinkedInPhotoBrowseView()
                    
                    // browse options
                    VendoredLinkedInBrowseOptionView()
                }
                .padding(.vertical,20)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Start post")
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15,height: 15)
                            .foregroundStyle(.black.opacity(0.7))
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        
                    }label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal,14)
                            .padding(.vertical,6)
                            .background(Color.vendoredLinkedInVendoredLinkedInPrimary)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
        }
        
    }
}

#Preview {
    VendoredLinkedInUploadPostView()
}

struct VendoredLinkedInProfileView: View {
    var body: some View {
        HStack {
            VendoredLinkedInProfileImageView(profileImage: vendoredLinkedInUserDataCurrent.profileImage, size: 48)
            VStack (alignment: .leading,spacing:2){
                Text(vendoredLinkedInUserDataCurrent.fullname)
                    .font(.headline)
                    .fontWeight(.semibold)
                Button {
                    
                }label: {
                    HStack (spacing:8){
                        Image(systemName: "globe.americas.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.semibold)
                        Text("Anyone")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.5))
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFill()
                            .frame(width:6, height: 6)
                            .foregroundStyle(.black.opacity(0.5))
                            .fontWeight(.semibold)
                            .padding(.top,2)
                    }
                    
                }
                .padding(.horizontal,10)
                .padding(.vertical,2)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray))
            }
            Spacer()
        }
        .padding(.horizontal)
        
    }
}

struct VendoredLinkedIncaptionFieldView : View {
    @State private var captionField = ""
    var body: some View {
        TextField("What do you want to talk about?",text: $captionField)
            .padding()
    }
}

struct VendoredLinkedInPhotoBrowseView : View {
    var body: some View {
        VStack (alignment: .leading, spacing:10){
            ZStack (alignment: .topTrailing){
                KFImage(URL(string: "https://images.pexels.com/photos/3184299/pexels-photo-3184299.jpeg?auto=compress&cs=tinysrgb&w=600"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                   
                    
               
                    Button {
                        
                    }label: {
                        HStack (spacing:8){
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 14, height: 14)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                            Text("Edit")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFill()
                                .frame(width:12, height: 12)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .padding(.top,2)
                        }
                        
                    }
                    .padding(.horizontal,14)
                    .padding(.vertical,4)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal,30)
                    .padding(.vertical)
                
            }
            Text("Add hashtag")
                .font(.headline)
                .foregroundStyle(Color.vendoredLinkedInVendoredLinkedInPrimary)
            
        }
        .padding(.horizontal)
    }
}

struct VendoredLinkedInBrowseOptionView: View {
    var body: some View {
        HStack {
            // left icons
            HStack (spacing:20){
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                    
                
                Image(systemName: "video.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16, height: 16)
                
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(.gray.opacity(0.7))
            .fontWeight(.semibold)
            
            Spacer()
            
            HStack (spacing:20){
                
                HStack {
                    Image(systemName: "text.bubble")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18)
                    Text("Connections")
                        .font(.subheadline)
                }
               
                
                Image(systemName: "keyboard")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18, height: 18)
                
            }
            .foregroundStyle(.gray.opacity(0.7))
            .fontWeight(.semibold)
        }
        .padding(.horizontal)
    }
}

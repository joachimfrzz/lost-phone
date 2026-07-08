//
//  VendoredLinkedInProfileAndPostView.swift
//  linkedin_clone
//
//  Created by Dipak on 26/02/23.
//

import SwiftUI

struct VendoredLinkedInProfileAndPostView: View {
    var body: some View {
        VStack(){
            VendoredLinkedInSearchBarView().padding(.bottom)
            VStack(alignment: .leading){
                Divider()
                HStack(){
                    Image(systemName: "square.and.pencil").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 25, height:25, alignment: .leading).foregroundColor(.gray)
                    Text("Start a post").font(.title2).padding(.horizontal).fontWeight(.medium)
                }.padding(.horizontal)
                
                Divider().padding(.bottom)
                
                HStack(){
                    Image(systemName: "photo").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 25, height:25, alignment: .leading).foregroundColor(.blue)
                    Text("Photo")
                    Spacer()
                    Image(systemName: "video.fill").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 25, height:25, alignment: .leading).foregroundColor(.green)
                    Text("Video")
                    Spacer()
                    Image(systemName: "calendar").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 25, height:25, alignment: .leading).foregroundColor(.orange)
                    Text("Event")
                }.padding(.horizontal)
                
            }
        }
       
    }
}


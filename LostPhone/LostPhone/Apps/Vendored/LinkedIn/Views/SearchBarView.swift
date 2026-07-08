//
//  VendoredLinkedInSearchBarView.swift
//  linkedin_clone
//
//  Created by Dipak on 21/02/23.
//

import SwiftUI

struct VendoredLinkedInSearchBarView: View {
    var body: some View {
        HStack(alignment: .center){
            Image("00").resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 50, height:50)
             
            
            RoundedRectangle(cornerRadius: 8).foregroundColor(.blue.opacity(0.2)).frame(width: 270, height: 30).overlay(HStack(){
                Image(systemName: "magnifyingglass") .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 35, height:35)
                Text("Search").font(.body).multilineTextAlignment(.leading).foregroundColor(.gray)
                
                Spacer()
            }.padding())
            // Message Box
            Image(systemName: "ellipses.bubble.fill").edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 25))
          
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredLinkedInSearchBarView()
    }
}

//
//  VendoredLinkedInInvitationView.swift
//  linkedin_clone
//
//  Created by Dipak on 25/02/23.
//

import SwiftUI

let sampleData = VendoredLinkedInNetworkModel(id: 1, name: "Dipak", position: "SDE at Google", mutual: 34, image: "00")
struct VendoredLinkedInInvitationView: View {
    var profileData: VendoredLinkedInNetworkModel;
    var body: some View {
       
        HStack(alignment: .center){
            Image(profileData.image).resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 60, height:60, alignment: .leading)
            
          
            VStack(alignment: .leading) {
                            Text(profileData.name)
                                .font(.body)
                            Text(profileData.position)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("⚭ \(profileData.mutual) mutual connections")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }.frame(width: 150, height: 20, alignment: .leading)
            HStack(){
                Image(systemName: "x.circle").font(.system(size:30)).foregroundColor(.gray)
                Image(systemName: "checkmark.circle").font(.system(size:30)).foregroundColor(.blue)
            }.padding(.horizontal)
        }
    }
}

struct InvitationView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredLinkedInInvitationView(profileData: sampleData)
    }
}

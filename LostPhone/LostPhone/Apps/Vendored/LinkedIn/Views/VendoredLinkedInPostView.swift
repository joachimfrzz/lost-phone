//
//  VendoredLinkedInPostView.swift
//  linkedin_clone
//
//  Created by Dipak on 26/02/23.
//

import SwiftUI

var postData: [VendoredLinkedInPostModel] = [
    .init(id: 0, image: "0", title: "iNeuron", followers: 4066, profileImage: "00"),
    .init(id: 1, image: "1", title: "Learnyst", followers: 2345, profileImage: "01"),
    .init(id: 2, image: "2", title: "Synopsys inc", followers: 1235, profileImage: "02"),
    .init(id: 3, image: "3", title: "Skill-Lync", followers: 908, profileImage: "03"),
    .init(id: 4, image: "4", title: "Intel", followers: 1234, profileImage: "04"),
    .init(id: 5, image: "5", title: "HP", followers: 567, profileImage: "05"),
    .init(id: 6, image: "6", title: "JungleWorks", followers: 346, profileImage: "00")
    
    ]
struct VendoredLinkedInPostView: View {
    var body: some View {
            ScrollView(.vertical, showsIndicators: false){
                VendoredLinkedInProfileAndPostView()
                Divider()
                VStack(){
                    ForEach(postData, id:\.id){ data in
                        VendoredLinkedInPostCardView(data: data)
                        HStack(alignment: .center){
                            ForEach(socialView, id: \.id){ data in
                                VStack(){
                                    Image(systemName: data.image)
                                    Text(data.title)
                                }
                                .foregroundColor(.black.opacity(0.8 )).font(.subheadline).padding(.horizontal, 20).padding(.vertical, 5)
                            }
                        }
                    }
                }
        }
        
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredLinkedInPostView()
    }
}

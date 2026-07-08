//
//  VendoredLinkedInPostCardView.swift
//  linkedin_clone
//
//  Created by Dipak on 26/02/23.
//

import SwiftUI

struct VendoredLinkedInSocialView{
    var id: Int
    var image: String
    var title: String
}

var socialView : [VendoredLinkedInSocialView]=[
    .init(id: 0, image: "hand.thumbsup", title: "Like"),
    .init(id: 1, image: "text.bubble", title: "Comment"),
    .init(id: 2, image: "arrow.turn.up.right", title: "Share"),
    .init(id: 3, image: "paperplane.fill", title: "Send")


]

var samplePostCardData = VendoredLinkedInPostModel(id: 1, image: "01", title: "Dipak Raut", followers: 1788, profileImage: "00")

struct VendoredLinkedInPostCardView: View {
    var data: VendoredLinkedInPostModel;
    var body: some View {
        VStack(alignment: .leading){
            VendoredLinkedInHorizontalDivider(color: .gray, height: 10).opacity(0.5)
//            Rectangle().fill(.gray.opacity(0.5)).frame(width: .infinity, height: 10).ignoresSafeArea(.all)
            HStack(){
                Image(data.profileImage).resizable().aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 60, height:60, alignment: .leading)
                VStack(alignment: .leading){
                    Text(data.title).font(.body)
                    Text("\(data.followers) followers").font(.subheadline).foregroundColor(.gray)
                    Text("8m").font(.system(size: 12)).foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "ellipsis")
            }.padding(.horizontal, 20)

            Text("Looking for iOS-15 online course ?").padding(.horizontal)
                Text("Learn Swift with iOS-15 now at udemy").padding(.horizontal)
            Image(data.image).resizable().aspectRatio(contentMode: .fit)
                .frame(width: .infinity, height: .infinity, alignment: .center)

        }
    }
}


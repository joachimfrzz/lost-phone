//
//  VendoredInstagramSearchAccountsView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI

struct VendoredInstagramSearchAccountsView: View {
    let searchAccountsData:[VendoredInstagramSearchRecentResponse] = searchRecentData
    var body: some View {
        ForEach(searchAccountsData) { searchData in
            NavigationLink {
                VendoredInstagramPostView(
                    profileImageUrl: searchData.user.profileImage,
                    username: searchData.user.username,
                    postImages: postsData.first?.imageOrVideoUrl ?? [],
                    caption: postsData.first?.caption ?? "",
                    totalLikes: postsData.first?.totalLikes ?? 0,
                    totalComments: postsData.first?.totalComments ?? 0,
                    postType: 1
                )
            } label: {
                HStack (spacing: 14){
                VendoredInstagramProfileImageView(profileImage: searchData.user.profileImage, size: 45)
                VStack (alignment: .leading,spacing: 0){
                    HStack (spacing: 5){
                        Text(searchData.user.username)
                            .fontWeight(.semibold)
                        Image("verified")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17,height: 17)
                            .padding(.top,3)
                    }
                    HStack (spacing: 0){
                        Text(searchData.user.fullname)
                        Text(" - 3.4M followers")
                    }
                    .font(.footnote)
                    .foregroundStyle(.gray)
                       
                }
                .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical,6)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    VendoredInstagramSearchAccountsView()
}

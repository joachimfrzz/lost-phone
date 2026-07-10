//
//  VendoredFacebookProfileView.swift
//  Youtube_Facebook
//

import SwiftUI
import Kingfisher

struct VendoredFacebookProfileView: View {
    private let currentUser = vendoredFacebookUserData[0]
    private var friends: [VendoredFacebookUserResponse] {
        var seen = Set<UUID>()
        return feedData.compactMap { feed in
            guard feed.type == 2, !seen.contains(feed.user.id) else { return nil }
            seen.insert(feed.user.id)
            return feed.user
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                KFImage(URL(string: currentUser.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.top, 24)

                Text(currentUser.name)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(currentUser.isOnline ? "Active now" : "Offline")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                NavigationLink {
                    VendoredFacebookFriendsView(friends: friends)
                } label: {
                    HStack {
                        Text("Friends")
                            .font(.headline)
                        Spacer()
                        Text("\(friends.count)")
                            .foregroundStyle(.secondary)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color.vendoredFacebookGrayBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
            }
        }
        .background(Color.vendoredFacebookBackgroundColor)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        VendoredFacebookProfileView()
    }
}

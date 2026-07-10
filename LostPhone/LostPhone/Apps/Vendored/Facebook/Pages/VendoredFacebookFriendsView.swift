//
//  VendoredFacebookFriendsView.swift
//  Youtube_Facebook
//

import SwiftUI
import Kingfisher

struct VendoredFacebookFriendsView: View {
    let friends: [VendoredFacebookUserResponse]

    var body: some View {
        List(friends) { friend in
            HStack(spacing: 12) {
                KFImage(URL(string: friend.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text(friend.name)
                        .font(.headline)
                    Text(friend.isOnline ? "Active now" : "Offline")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Friends")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private var vendoredFacebookFriendsFromFeed: [VendoredFacebookUserResponse] {
    var seen = Set<UUID>()
    return feedData.compactMap { feed in
        guard feed.type == 2, !seen.contains(feed.user.id) else { return nil }
        seen.insert(feed.user.id)
        return feed.user
    }
}

#Preview {
    NavigationStack {
        VendoredFacebookFriendsView(friends: vendoredFacebookFriendsFromFeed)
    }
}

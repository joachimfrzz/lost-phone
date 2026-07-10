//
//  VendoredTikTokProfileView.swift
//

import SwiftUI
import Kingfisher

struct VendoredTikTokProfileView: View {
    var feed: VendoredTikTokFeedResponse
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                KFImage(URL(string: feed.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 96, height: 96)
                    .clipShape(Circle())

                Text(feed.fullName)
                    .font(.title2)
                    .fontWeight(.bold)

                HStack(spacing: 32) {
                    profileStat("Following", value: "142")
                    profileStat("Followers", value: feed.totalLikes)
                    profileStat("Likes", value: feed.totalComments)
                }

                Text(feed.caption)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button("Follow") {}
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.vendoredTikTokIsLikedColor, in: Capsule())
                    .padding(.horizontal, 40)
            }
            .padding(.vertical, 24)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }

    private func profileStat(_ label: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

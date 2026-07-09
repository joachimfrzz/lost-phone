//
//  PostGridView.swift
//  Instagram clone
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    let size = (UIScreen.main.bounds.width / 3) - 2

    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(postsData) { post in
                if let urlString = post.imageOrVideoUrl.first, let url = URL(string: urlString) {
                    NavigationLink {
                        PostView(
                            profileImageUrl: post.user.profileImage,
                            username: post.user.username,
                            postImages: post.imageOrVideoUrl,
                            caption: post.caption ?? "",
                            totalLikes: post.totalLikes,
                            totalComments: post.totalComments,
                            postType: post.postType
                        )
                    } label: {
                        gridCell(post: post, url: url, urlString: urlString)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    @ViewBuilder
    private func gridCell(post: PostResponse, url: URL, urlString: String) -> some View {
        if post.postType == 1 {
            if post.imageOrVideoUrl.count > 1 {
                ZStack(alignment: .topTrailing) {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipped()
                    Image("photo_collection_icon")
                        .padding(.all, 10)
                }
            } else {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
            }
        } else {
            ZStack(alignment: .topTrailing) {
                ThumbnailImageView(videoURL: URL(string: urlString)!, width: size, height: size)
                Image("reels_white_icon")
                    .padding(.all, 10)
            }
        }
    }
}

#Preview {
    PostGridView()
}

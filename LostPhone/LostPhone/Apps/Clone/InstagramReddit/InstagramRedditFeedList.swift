import SwiftUI

struct InstagramRedditFeedList: View {
    let posts: [LpspInstagramPost]
    let username: String

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(posts) { post in
                InstagramRedditFeedPost(
                    username: username,
                    caption: post.caption,
                    likes: post.likes,
                    date: post.date
                )
                Divider()
            }
        }
    }

    /// Fallback démo du clone original.
    static func demo(username: String = "mathieu.garnier.studio") -> some View {
        LazyVStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { idx in
                InstagramRedditFeedPost(
                    username: username,
                    location: idx.isMultiple(of: 2) ? "Paris, France" : nil
                )
                Divider()
            }
        }
    }
}

import SwiftUI

struct InstagramRedditStoriesBar: View {
    var ownStoryLabel: String = "Votre story"

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 14) {
                InstagramRedditStoryItem(username: ownStoryLabel, isOwn: true)
                ForEach(1..<12, id: \.self) { idx in
                    InstagramRedditStoryItem(username: "User \(idx)")
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
        }
    }
}

struct InstagramRedditStoryItem: View {
    var username: String
    var isOwn: Bool = false

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 70, height: 70)
                Circle()
                    .fill(Color(uiColor: .systemBackground))
                    .frame(width: 65, height: 65)
                Circle()
                    .fill(.gray.opacity(0.4))
                    .frame(width: 65, height: 65)
                    .overlay(Image(systemName: "person.fill"))
            }
            .overlay(alignment: .bottomTrailing) {
                if isOwn {
                    ZStack {
                        Circle().fill(.blue)
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 18, height: 18)
                    .offset(x: 2, y: 0)
                }
            }
            Text(username)
                .font(.caption)
                .lineLimit(1)
        }
        .frame(width: 70)
    }
}

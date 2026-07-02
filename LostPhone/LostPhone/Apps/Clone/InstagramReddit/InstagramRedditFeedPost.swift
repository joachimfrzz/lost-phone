import SwiftUI

struct InstagramRedditFeedPost: View {
    var username: String
    var location: String?
    var caption: String?
    var likes: Int?
    var date: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Circle()
                    .fill(.gray.opacity(0.4))
                    .frame(width: 36, height: 36)
                    .overlay(Image(systemName: "person.fill"))
                VStack(alignment: .leading, spacing: 2) {
                    Text(username)
                        .font(.subheadline)
                    if let location {
                        Text(location)
                            .font(.caption)
                    }
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
            }
            .padding(.horizontal)
            .padding(.vertical, 8)

            ZStack {
                Rectangle()
                    .fill(.gray.opacity(0.25))
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(Image("post").resizable().scaledToFill())
            }
            .clipped()

            HStack {
                HStack(spacing: 16) {
                    Image(systemName: "heart")
                    Image(systemName: "bubble.right")
                    Image(systemName: "paperplane")
                }
                .font(.title2)
                Spacer()
                Image(systemName: "bookmark")
                    .font(.title2)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                if let likes {
                    Text("Aimé par \(Text("\(likes) personnes").fontWeight(.semibold))")
                } else {
                    Text("Aimé par \(Text("swiftdev").fontWeight(.semibold)) et d'autres")
                }
                Text("\(Text(username).fontWeight(.semibold))  \(caption ?? "Publication Instagram.")")
                Text("Voir les 42 commentaires").foregroundStyle(.secondary)
                Text(date ?? "Il y a 2 h").font(.caption2).foregroundStyle(.secondary)
            }
            .font(.footnote)
            .padding(.vertical, 8)
            .padding(.horizontal)
        }
    }
}

import SwiftUI

struct NetflixRedditPosterCard: View {
    var title: String?
    var progress: CGFloat?
    var width: CGFloat = 100
    var height: CGFloat = 150

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [NetflixRedditTheme.customDarkGray, .black],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: width, height: height)
                .overlay {
                    Image(systemName: "film")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.35))
                }

            if let progress {
                GeometryReader { geo in
                    Rectangle()
                        .fill(NetflixRedditTheme.red)
                        .frame(width: geo.size.width * progress, height: 3)
                }
                .frame(height: 3)
            }
        }
        .overlay(alignment: .bottomLeading) {
            if let title, progress != nil {
                Text(title)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .padding(6)
                    .frame(width: width, alignment: .leading)
            }
        }
    }
}

struct NetflixRedditSectionRow: View {
    let title: String
    let count: Int
    var useProgress: Bool = false
    var itemTitles: [String] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.top, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(0..<count, id: \.self) { index in
                        if useProgress {
                            NetflixRedditPosterCard(
                                title: itemTitles.indices.contains(index) ? itemTitles[index] : nil,
                                progress: 0.35 + CGFloat(index) * 0.1,
                                width: 148,
                                height: 84
                            )
                        } else {
                            NetflixRedditPosterCard(width: 100, height: 150)
                        }
                    }
                }
            }
        }
    }
}

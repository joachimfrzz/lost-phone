import SwiftUI
import Kingfisher

struct InstagramStoryDetailView: View {
    let user: UserInstagramResponse
    @Environment(\.dismiss) private var dismiss

    private var slides: [UserStoryResponse] {
        userStoriesData.filter { _ in true }.prefix(3).map { $0 }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            TabView {
                ForEach(slides) { slide in
                    KFImage(URL(string: slide.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .overlay(alignment: .bottomLeading) {
                            Text(slide.caption)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.black.opacity(0.35))
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .ignoresSafeArea()

            HStack(spacing: 10) {
                ProfileImageView(profileImage: user.profileImage, size: 36)
                Text(user.username)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding()

            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
        }
        .background(.black)
    }
}

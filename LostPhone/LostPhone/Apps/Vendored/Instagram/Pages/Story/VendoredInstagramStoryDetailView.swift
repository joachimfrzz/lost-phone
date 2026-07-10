import SwiftUI
import Kingfisher

struct VendoredInstagramStoryDetailView: View {
    let user: VendoredInstagramUserInstagramResponse
    @Environment(\.dismiss) private var dismiss

    private var slides: [VendoredInstagramUserStoryResponse] {
        Array(userStoriesData.prefix(3))
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
                VendoredInstagramProfileImageView(profileImage: user.profileImage, size: 36)
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

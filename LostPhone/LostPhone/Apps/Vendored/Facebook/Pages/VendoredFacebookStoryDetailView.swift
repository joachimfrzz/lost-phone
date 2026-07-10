import SwiftUI
import Kingfisher

struct VendoredFacebookStoryDetailView: View {
    let story: VendoredFacebookStoryResponse
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            KFImage(URL(string: story.imageUrl))
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                HStack {
                    KFImage(URL(string: story.user.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    Text(story.user.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding()
                Spacer()
            }
            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
            }
        }
        .background(.black)
    }
}

import SwiftUI

struct VendoredTinderLikesView: View {
    private let columns = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)]

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        Text("\(VendoredTinderData.likesGrid.count) Likes")
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                        Text("Top Picks")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.black.opacity(0.5))
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 20)

                    Divider()

                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(VendoredTinderData.likesGrid) { profile in
                            ZStack(alignment: .bottomLeading) {
                                VendoredTinderBundledPhoto(imageName: profile.imageName)
                                    .frame(height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                                LinearGradient(
                                    colors: [.black.opacity(0.25), .clear],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                                HStack(spacing: 5) {
                                    Circle()
                                        .fill(profile.active ? Color.green : Color.gray)
                                        .frame(width: 8, height: 8)
                                    Text(profile.active ? "Recently Active" : "Offline")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                }
                                .padding(8)
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
                .padding(.bottom, 100)
            }

            Text("SEE WHO LIKES YOU")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(VendoredTinderTheme.goldGradient, in: Capsule())
                .padding(.horizontal, 35)
                .padding(.bottom, 20)
        }
        .background(Color.white)
    }
}

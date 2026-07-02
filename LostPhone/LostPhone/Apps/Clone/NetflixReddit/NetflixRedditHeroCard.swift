import SwiftUI

// Vendored from debuging-life/netflix-clone — MainCardView (sans Kingfisher / TMDB)

struct NetflixRedditHeroCard: View {
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [NetflixRedditTheme.bgLightGray, .black],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 420)
                    .overlay {
                        Image(systemName: "play.rectangle.fill")
                            .font(.system(size: 72))
                            .foregroundStyle(.white.opacity(0.25))
                    }

                LinearGradient(
                    colors: [.clear, .black],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack {
                    Spacer()
                    HStack {
                        NetflixRedditButton(
                            text: "Lecture",
                            disabled: readOnly,
                            configuration: .init(
                                backgroundColor: .white,
                                textConfiguration: .init(foregroundColor: .black)
                            ),
                            icon: {
                                Image(systemName: "play.fill")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            },
                            action: {}
                        )
                        NetflixRedditButton(
                            text: "Ma liste",
                            disabled: readOnly,
                            configuration: .init(backgroundColor: NetflixRedditTheme.buttonGrayDark),
                            icon: {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                            },
                            action: {}
                        )
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .frame(height: 420)
    }
}

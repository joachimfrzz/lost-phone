import SwiftUI

struct VendoredSpotifyReelView: View {
    let geometry: GeometryProxy
    @Binding var showTabBar: Bool
    @Binding var selected: VendoredSpotifySpotifyTabItem
    
    @State private var reels: [VendoredSpotifyReel] = reelsData
    @State private var likedCounter: [VendoredSpotifyLike] = []
    @State private var toasts: [VendoredSpotifyToast] = []
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach($reels) { $reel in
                    VendoredSpotifyVideoPlayer(
                        geometry: geometry,
                        reel: $reel,
                        likedCounter: $likedCounter,
                        showTabBar: $showTabBar,
                        selected: $selected,
                    )
                    .overlay(alignment: .bottom) {
                        VendoredSpotifyReelDetail(
                            geometry: geometry,
                            reel: $reel,
                            onMessage: {
                                $toasts.showToast("Message sent")
                            },
                            onPaperplane: {
                                $toasts.showToast("Content shared")
                            }
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .containerRelativeFrame(
                        .vertical,
                        count: 1,
                        spacing: geometry.safeAreaInsets.bottom + 70,
                    )
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .background(.spotifyBlack)
        .overlay(alignment: .topLeading, content: {
            ZStack {
                ForEach(likedCounter) { like in
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 75))
                        .foregroundStyle(.red.gradient)
                        .frame(width: 100, height: 100)
                        .animation(.smooth) { view in
                            view
                                .scaleEffect(like.isAnimated ? 1 : 1.8)
                                .rotationEffect(
                                    .init(degrees: like.isAnimated ? 0 : .random(in: -30...30)),
                                )
                        }
                        .offset(x: like.tappedRect.x - 50, y: like.tappedRect.y - 100)
                        .offset(y: like.isAnimated ? -(like.tappedRect.y + geometry.safeAreaInsets.top) : 0)
                }
            }
        })
        .overlay(alignment: .top) {
            Text("Reels")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button("", systemImage: "camera") {
                        
                    }
                    .font(.title2)
                }
                .foregroundStyle(.spotifyWhite)
                .padding(.top, geometry.safeAreaInsets.top + 25)
                .padding(.trailing, 15)
        }
        .interactiveToast($toasts)
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    GeometryReader {
        VendoredSpotifyReelView(
            geometry: $0,
            showTabBar: .constant(false),
            selected: .constant(.reels)
        )
    }
}

import SwiftUI
import AVKit

struct VendoredSpotifyVideoPlayer: View {
    let geometry: GeometryProxy
    @Binding var reel: VendoredSpotifyReel
    @Binding var likedCounter: [VendoredSpotifyLike]
    @Binding var showTabBar: Bool
    @Binding var selected: VendoredSpotifySpotifyTabItem
    
    @State var player: AVPlayer?
    @State var looper: AVPlayerLooper?
    
    var body: some View {
        GeometryReader{
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            
            ZStack {
                VendoredSpotifyVideoPlayerViewController(player: $player)
                    .preference(key: VendoredSpotifyOffsetKey.self, value: rect)
                    .onPreferenceChange(VendoredSpotifyOffsetKey.self, perform: { _ in
                        playPause(rect, tab: selected)
                    })
                    .preference(key: VendoredSpotifyTabKey.self, value: selected)
                    .onPreferenceChange(VendoredSpotifyTabKey.self, perform: { _ in
                        playPause(rect, tab: selected)
                    })
                
                Color.spotifyBlack.opacity(0.0000001)
                    .onTapGesture(perform: onTapGesture)
                    .onTapGesture(count: 2, perform: onDoubleTapGesture)
                    .onAppear(perform: onAppear)
                    .onDisappear(perform: onDisapear)
            }
        }
    }
}

#Preview {
    GeometryReader {
        VendoredSpotifyReelView(
            geometry: $0,
            showTabBar: .constant(true),
            selected: .constant(.reels)
        )
    }
}

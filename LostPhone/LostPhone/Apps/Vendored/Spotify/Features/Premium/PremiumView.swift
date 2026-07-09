import SwiftUI

struct VendoredSpotifyPremiumView: View {
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            Text("Premium")
                .foregroundColor(.spotifyWhite)
        }
    }
}

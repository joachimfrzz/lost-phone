import SwiftUI

/// Point d'entrée Lost Phone — clone vendored (préfixe `VendoredSpotify`).
struct LpspVendoredSpotifyRootView: View {
    @StateObject private var productStore = VendoredSpotifyProductStore()
    @StateObject private var userStore = VendoredSpotifyUserStore()

    var body: some View {
        VendoredSpotifyBaseView()
            .environmentObject(productStore)
            .environmentObject(userStore)
    }
}

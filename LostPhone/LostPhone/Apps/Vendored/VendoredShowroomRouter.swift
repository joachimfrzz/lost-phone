import SwiftUI

/// Routage showroom → clones GitHub vendored (`Apps/Vendored/`).
enum VendoredShowroomRouter {
    @ViewBuilder
    static func view(for appName: String) -> some View {
        switch LpspAppAliases.canonical(appName) {
        case "TikTok":
            LpspVendoredTikTokRootView()
        case "Instagram":
            LpspVendoredInstagramRootView()
        case "LinkedIn":
            LpspVendoredLinkedInRootView()
        case "Teams":
            LpspVendoredTeamsRootView()
        case "Spotify":
            LpspVendoredSpotifyRootView()
        case "Netflix":
            LpspVendoredNetflixRootView()
        case "Disney+":
            LpspVendoredDisneyPlusRootView()
        case "ChatGPT":
            LpspVendoredChatGPTRootView()
        case "PayPal":
            LpspVendoredPayPalRootView()
        case "Uber":
            LpspVendoredUberRootView()
        case "Airbnb", "Booking":
            LpspVendoredAirbnbRootView()
        default:
            AwesomeShowroomRouter.view(for: appName)
        }
    }
}

import SwiftUI

/// Routage showroom → clones vendored Sopheamen (+ fallback Awesome pour Flutter).
enum VendoredShowroomRouter {
    @ViewBuilder
    static func view(for appName: String) -> some View {
        switch LpspAppAliases.canonical(appName) {
        case "WhatsApp":
            LpspVendoredWhatsAppRootView()
        case "Instagram":
            LpspVendoredInstagramRootView()
        case "Snapchat":
            LpspVendoredSnapchatRootView()
        case "LinkedIn":
            LpspVendoredLinkedInRootView()
        case "Facebook":
            LpspVendoredFacebookRootView()
        case "Messenger":
            LpspVendoredMessengerRootView()
        case "Threads":
            LpspVendoredThreadsRootView()
        case "Grok":
            LpspVendoredGrokRootView()
        case "Gemini":
            LpspVendoredGeminiRootView()
        case "Netflix":
            LpspVendoredNetflixRootView()
        case "YouTube":
            LpspVendoredYouTubeRootView()
        case "YouTube Music":
            LpspVendoredYouTubeMusicRootView()
        case "Coinbase":
            LpspVendoredPhantomRootView()
        case "Uber":
            LpspVendoredUberRootView()
        case "Uber Eats":
            LpspVendoredUberEatsRootView()
        case "Airbnb":
            LpspVendoredAirbnbRootView()
        case "Tinder":
            LpspVendoredTinderRootView()
        case "TikTok":
            LpspVendoredTikTokRootView()
        default:
            AwesomeShowroomRouter.view(for: appName)
        }
    }
}

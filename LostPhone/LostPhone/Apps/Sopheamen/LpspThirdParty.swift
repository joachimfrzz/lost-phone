import SwiftUI

/// Route les apps tierces Sopheamen (clones Patreon) — même rôle que sur le showroom Cloud.
enum LpspThirdParty {
    @ViewBuilder
    static func view(for appName: String) -> some View {
        switch appName {
        case "TikTok": TikTokView()
        case "Uber": UberHomeView()
        case "Uber Eats": UberEatsHomeView()
        case "Facebook": FacebookContentRoot()
        case "Messenger": MessengerContentRoot()
        case "Gemini": GeminiContentRoot()
        case "Grok": GrokContentRoot()
        case "Tinder": TinderContentRoot()
        case "Instagram": InstagramContentRoot()
        case "WhatsApp": WhatsAppContentRoot()
        case "Netflix": NetflixContentRoot()
        case "YouTube": YouTubeContentRoot()
        case "YouTube Music": YTMusicContentRoot()
        case "Airbnb": AirbnbContentRoot()
        case "LinkedIn": LinkedInContentRoot()
        case "Snapchat": SnapchatContentRoot()
        case "App Store": AppStoreView()
        case "Wallet", "CoinBase (app crypto)", "Coinbase": PhantomContentRoot()
        case "Threads":
            ThreadsUnavailableView()
        default:
            EmptyView()
        }
    }

    static func handles(_ appName: String) -> Bool {
        switch appName {
        case "TikTok", "Uber", "Uber Eats", "Facebook", "Messenger", "Gemini", "Grok", "Tinder",
             "Instagram", "WhatsApp", "Netflix", "YouTube", "YouTube Music", "Airbnb", "LinkedIn",
             "Snapchat", "App Store", "Wallet", "CoinBase (app crypto)", "Coinbase", "Threads":
            return true
        default:
            return false
        }
    }
}

/// Threads retiré du showroom (Notion).
private struct ThreadsUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "Threads",
            systemImage: "xmark.circle",
            description: Text("Cette application n'est pas disponible dans cette histoire.")
        )
    }
}

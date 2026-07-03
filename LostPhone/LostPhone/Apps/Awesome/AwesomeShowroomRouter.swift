import SwiftUI

/// Routage showroom → vues Awesome v3 (Spectr / Meliwat DESIGN-swiftui.md).
enum AwesomeShowroomRouter {
    @ViewBuilder
    static func view(for appName: String) -> some View {
        switch LpspAppAliases.canonical(appName) {
        case "WhatsApp": LpspAwesomeWhatsAppView()
        case "Signal": LpspAwesomeSignalView()
        case "Telegram": LpspAwesomeTelegramView()
        case "Messenger": LpspAwesomeMessengerView()
        case "Discord": LpspAwesomeDiscordView()
        case "Teams": LpspAwesomeTeamsView()
        case "Instagram": LpspAwesomeInstagramView()
        case "TikTok": LpspAwesomeTikTokView()
        case "Snapchat": LpspAwesomeSnapchatView()
        case "X": LpspAwesomeXView()
        case "Reddit": LpspAwesomeRedditView()
        case "LinkedIn": LpspAwesomeLinkedInView()
        case "Facebook": LpspAwesomeFacebookView()
        case "Threads": LpspAwesomeThreadsView()
        case "Pinterest": LpspAwesomePinterestView()
        case "Tinder": LpspAwesomeTinderView()
        case "Bumble": LpspAwesomeBumbleView()
        case "Hinge": LpspAwesomeHingeView()
        case "Happn": LpspAwesomeHappnView()
        case "Spotify": LpspAwesomeSpotifyView()
        case "Apple Music": LpspAwesomeAppleMusicView()
        case "Deezer": LpspAwesomeDeezerView()
        case "SoundCloud": LpspAwesomeSoundCloudView()
        case "YouTube Music": LpspAwesomeYouTubeMusicView()
        case "Shazam": LpspAwesomeShazamView()
        case "Audible": LpspAwesomeAudibleView()
        case "YouTube": LpspAwesomeYouTubeView()
        case "Netflix": LpspAwesomeNetflixView()
        case "Disney+": LpspAwesomeDisneyView()
        case "Prime Video": LpspAwesomePrimeVideoView()
        case "Apple TV": LpspAwesomeAppleTVView()
        case "Twitch": LpspAwesomeTwitchView()
        case "ChatGPT": LpspAwesomeChatGPTView()
        case "Gemini": LpspAwesomeGeminiView()
        case "Claude": LpspAwesomeClaudeView()
        case "Perplexity": LpspAwesomePerplexityView()
        case "Grok": LpspAwesomeGrokView()
        case "Revolut": LpspAwesomeRevolutView()
        case "Wise": LpspAwesomeWiseView()
        case "PayPal": LpspAwesomePayPalView()
        case "Binance": LpspAwesomeBinanceView()
        case "Coinbase": LpspAwesomeCoinbaseView()
        case "Amazon": LpspAwesomeAmazonView()
        case "Uber": LpspAwesomeUberView()
        case "Uber Eats": LpspAwesomeUberEatsView()
        case "Deliveroo": LpspAwesomeDeliverooView()
        case "Waze": LpspAwesomeWazeView()
        case "Google Maps": LpspAwesomeGoogleMapsView()
        case "Booking": LpspAwesomeBookingView()
        case "Airbnb": LpspAwesomeAirbnbView()
        case "Expedia": LpspAwesomeExpediaView()
        case "Flighty": LpspAwesomeFlightyView()
        case "TripAdvisor": LpspAwesomeTripAdvisorView()
        case "Strava": LpspAwesomeStravaView()
        case "Google Calendar": LpspAwesomeGoogleCalendarView()
        case "Dropbox": LpspAwesomeDropboxView()
        case "Zoom": LpspAwesomeZoomView()
        case "Kindle": LpspAwesomeKindleView()
        case "Banque": LpspAwesomeBanqueView()
        case "Plans": LpspAwesomePlansView()
        case "Fichiers": LpspAwesomeFichiersView()
        default:
            AwesomeShowroomFallbackView(appName: appName)
        }
    }
}

struct AwesomeShowroomFallbackView: View {
    let appName: String
    var body: some View {
        NavigationStack {
            ContentUnavailableView(appName, systemImage: "app.fill", description: Text("Vue Awesome en cours"))
        }
    }
}

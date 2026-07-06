import SwiftUI
import UIKit

/// B — Renders each Awesome app home (ShowroomRoot tab 0) to PNG for Spectr pixel diff.
/// Trigger: env `LPSP_CAPTURE_AWESOME=1` (see ios-awesome-pixel-capture.sh).
enum AwesomeSpectrPixelCapture {
    static var isEnabled: Bool {
        ProcessInfo.processInfo.environment["LPSP_CAPTURE_AWESOME"] == "1"
    }

    static let width: CGFloat = 390
    static let height: CGFloat = 844

    /// Maps tier catalog app name → spectr slug (matches spectr_previews/manifest.json).
    static func slug(for appName: String) -> String {
        switch LpspAppAliases.canonical(appName) {
        case "WhatsApp": return "whatsapp"
        case "Signal": return "signal"
        case "Telegram": return "telegram"
        case "Messenger": return "messenger"
        case "Discord": return "discord"
        case "Teams": return "microsoft-teams"
        case "Instagram": return "instagram"
        case "TikTok": return "tiktok"
        case "Snapchat": return "snapchat"
        case "X": return "x-twitter"
        case "Reddit": return "reddit"
        case "LinkedIn": return "linkedin"
        case "Facebook": return "facebook"
        case "Threads": return "threads"
        case "Pinterest": return "pinterest"
        case "Tinder": return "tinder"
        case "Bumble": return "bumble"
        case "Hinge": return "hinge"
        case "Happn": return "happn"
        case "Spotify": return "spotify"
        case "Apple Music": return "apple-music"
        case "Deezer": return "deezer"
        case "SoundCloud": return "soundcloud"
        case "YouTube Music": return "youtube-music"
        case "Shazam": return "shazam"
        case "Audible": return "audible"
        case "YouTube": return "youtube"
        case "Netflix": return "netflix"
        case "Disney+": return "disney-plus"
        case "Prime Video": return "prime-video"
        case "Apple TV": return "apple-tv"
        case "Twitch": return "twitch"
        case "ChatGPT": return "chatgpt"
        case "Gemini": return "gemini"
        case "Claude": return "claude"
        case "Perplexity": return "perplexity"
        case "Grok": return "grok"
        case "Revolut", "Banque": return "revolut"
        case "Wise": return "wise"
        case "PayPal": return "paypal"
        case "Binance": return "binance"
        case "Coinbase": return "coinbase"
        case "Amazon": return "amazon"
        case "Uber": return "uber"
        case "Uber Eats": return "uber-eats"
        case "Deliveroo": return "deliveroo"
        case "Waze": return "waze"
        case "Google Maps", "Plans": return "google-maps"
        case "Booking": return "booking"
        case "Airbnb": return "airbnb"
        case "Expedia": return "expedia"
        case "Flighty": return "flighty"
        case "TripAdvisor": return "tripadvisor"
        case "Strava": return "strava"
        case "Google Calendar": return "google-calendar"
        case "Dropbox", "Fichiers": return "dropbox"
        case "Rappels": return "apple-reminders"
        case "Zoom": return "zoom"
        case "Kindle": return "kindle"
        default:
            return appName.lowercased().replacingOccurrences(of: " ", with: "-")
        }
    }

    @MainActor
    static func runCapture() async {
        var apps = AwesomeShowroomCatalog.tierApps
        if !apps.contains("Google Maps") {
            apps.append("Google Maps")
        }
        let dir = captureDirectory()
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)

        var saved = 0
        for (index, app) in apps.enumerated() {
            let slug = slug(for: app)
            let view = AwesomeShowroomRouter.view(for: app)
                .frame(width: width, height: height)
                .clipped()

            let renderer = ImageRenderer(content: view)
            renderer.scale = 1.0
            renderer.proposedSize = ProposedViewSize(width: width, height: height)

            guard let uiImage = renderer.uiImage,
                  let data = uiImage.pngData() else {
                print("LPSP_CAPTURE_FAIL slug=\(slug) app=\(app)")
                continue
            }

            let url = dir.appendingPathComponent("\(slug).png")
            do {
                try data.write(to: url)
                saved += 1
                print("LPSP_CAPTURE_OK \(index + 1)/\(apps.count) \(slug)")
            } catch {
                print("LPSP_CAPTURE_FAIL slug=\(slug) error=\(error)")
            }
            await Task.yield()
        }

        print("LPSP_CAPTURE_DONE dir=\(dir.path) count=\(saved)/\(apps.count)")
    }

    private static func captureDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("spectr_captures", isDirectory: true)
    }
}

struct AwesomeSpectrPixelCaptureHost: View {
    @State private var status = "Capture Awesome × Spectr…"

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 12) {
                ProgressView()
                    .tint(.white)
                Text(status)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
        }
        .task {
            await AwesomeSpectrPixelCapture.runCapture()
            status = "Terminé — voir Documents/spectr_captures"
        }
    }
}

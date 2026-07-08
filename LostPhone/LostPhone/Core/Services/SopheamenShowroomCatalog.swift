import Foundation

/// 21 clones Patreon Sopheamen Van — catalogue showroom pages 3+.
/// 3 apps Apple (Mail, App Store, Musique) sont sur page 1 / dock via `LpspAppRouter.showroomCloneView`.
enum SopheamenShowroomCatalog {
    /// 18 apps tierces du bundle (pages 3+).
    static let tierApps: [String] = [
        "WhatsApp",
        "Instagram",
        "Snapchat",
        "LinkedIn",
        "Facebook",
        "Messenger",
        "Threads",
        "Grok",
        "Gemini",
        "Netflix",
        "YouTube",
        "YouTube Music",
        "Coinbase", // Phantom wallet (zip Sopheamen)
        "Uber",
        "Uber Eats",
        "Airbnb",
        "Tinder",
        "TikTok",
    ]

    /// Les 21 archives du bundle (tier + Apple Sopheamen).
    static let bundleApps: [String] = tierApps + [
        "Mail",
        "App Store",
        "Musique",
    ]

    static func isSopheamen(_ appName: String) -> Bool {
        bundleApps.contains(LpspAppAliases.canonical(appName))
    }

    static func isTierApp(_ appName: String) -> Bool {
        tierApps.contains(LpspAppAliases.canonical(appName))
    }
}

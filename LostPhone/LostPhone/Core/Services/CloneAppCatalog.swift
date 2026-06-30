import SwiftUI

/// Les 14 apps du clone zerocode117 — noms LPSP (FR) et routes.
enum CloneAppCatalog {
    static let lpspNames: [String] = [
        "Messages",
        "Telephone",
        "Photos",
        "Safari",
        "Mail",
        "Notes",
        "Calendrier",
        "Réglages",
        "Météo",
        "Horloge",
        "Calculatrice",
        "Appareil photo",
        "App Store",
        "Musique",
    ]

    static func appType(for lpspName: String) -> AppType? {
        switch lpspName {
        case "Messages": return .messages
        case "Telephone", "Phone": return .phone
        case "Photos": return .photos
        case "Safari": return .safari
        case "Mail": return .mail
        case "Notes": return .notes
        case "Calendrier", "Calendar": return .calendar
        case "Réglages", "Settings": return .settings
        case "Météo", "Weather": return .weather
        case "Horloge", "Clock": return .clock
        case "Calculatrice", "Calculator": return .calculator
        case "Appareil photo", "Camera", "Caméra": return .camera
        case "App Store": return .appStore
        case "Musique", "Music": return .music
        default: return nil
        }
    }

    static func isCloneApp(_ lpspName: String) -> Bool {
        appType(for: lpspName) != nil
    }
}

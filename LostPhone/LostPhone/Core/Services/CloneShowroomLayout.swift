import Foundation

/// Disposition exacte du clone zerocode117/iOS-26-clone (Reddit) — 14 apps.
enum CloneShowroomLayout {
    static let storyId = "showroom-clone14"

    /// Page 1 — `ContentView.homeApps` (ordre Reddit).
    static let gridApps: [String] = [
        "Météo",
        "Calendrier",
        "Photos",
        "Appareil photo",
        "Notes",
        "Calculatrice",
        "Réglages",
        "Mail",
        "Horloge",
        "App Store",
    ]

    /// Dock — `ContentView.dockApps`.
    static let dockApps: [String] = [
        "Telephone",
        "Safari",
        "Messages",
        "Musique",
    ]

    static let allApps: [String] = gridApps + dockApps

    static func isShowroom(storyId: String?) -> Bool {
        storyId == Self.storyId
    }
}

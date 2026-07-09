import Foundation

/// Disposition showroom — page 1 = clone zerocode117 (gelée), pages suivantes = apps ajoutées.
enum CloneShowroomLayout {
    static let storyId = "showroom-clone14"

    /// Page 1 — ordre zerocode117 (ne pas modifier).
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

    /// Page 2 — Étape 1 (apps Apple ajoutées).
    static let gridAppsPage2: [String] = [
        "Contacts",
        "Rappels",
        "Dictaphone",
        "Wallet",
    ]

    /// Pages 3+ — 18 apps tierces Sopheamen Patreon (bundle 21 zip).
    static let gridAppsTier: [String] = SopheamenShowroomCatalog.tierApps

    /// Dock — `ContentView.dockApps` (gelé).
    static let dockApps: [String] = [
        "Telephone",
        "Safari",
        "Messages",
        "Musique",
    ]

    static var allGridApps: [String] {
        gridApps + gridAppsPage2 + gridAppsTier
    }

    static let allApps: [String] = allGridApps + dockApps

    /// Grille paginée (16 icônes max par page, comme J-3).
    static var gridPages: [[String]] {
        let apps = allGridApps
        guard !apps.isEmpty else { return [[]] }
        return stride(from: 0, to: apps.count, by: 16).map { start in
            Array(apps.dropFirst(start).prefix(16))
        }
    }

    static func isShowroom(storyId: String?) -> Bool {
        storyId == Self.storyId
    }
}

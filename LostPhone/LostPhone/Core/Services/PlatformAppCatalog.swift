import Foundation

// MARK: - Catalogue plateforme Lost Phone
//
// Bibliothèque complète d'apps → chaque histoire choisit un sous-ensemble via
// `manifest.apps_presentes` dans lpsp.json.
//
// Développement : une app / template à la fois, par ordre de `devPriority`
// (1 = prochaine à coder). Les marques d'un même template partagent une UI.

enum PlatformAppCatalog {

    enum Template: String, CaseIterable {
        case appleClone
        case chat
        case maps
        case rideHailing
        case socialFeed
        case bank
        case streamingVideo
        case streamingMusic
        case files
        case reminders
        case dating
        case commerce
        case travel
        case wallet
        case generic
    }

    enum ImplementationStatus: String {
        case ready           // UI + LPSP
        case lpspReady       // clone Apple + LPSP
        case cloneDemo       // clone Apple demo
        case jsonOnly        // JSON ok, UI manquante
        case planned
    }

    /// Fidélité visuelle réaliste avec SwiftUI + captures de référence.
    enum CloneFidelity: String {
        case done = "✅ Livré"
        case high = "🎯 Clone quasi identique (objectif)"
        case medium = "📱 UX reconnaissable, détails simplifiés"
        case low = "📋 Liste / écran minimal suffisant au récit"
    }

    struct Entry: Identifiable {
        var id: String { lpspKey }
        let lpspKey: String
        let template: Template
        let status: ImplementationStatus
        /// 0 = terminé · 1 = prochain · 2+ = file d'attente
        let devPriority: Int
        let fidelity: CloneFidelity
        let notes: String
        /// Débloque les autres apps du même template une fois codée.
        var isTemplateAnchor: Bool { devPriority >= 1 && devPriority < 90 }
    }

    // MARK: - Liste complète

    static let all: [Entry] = [
        // ——— ✅ Déjà jouables ———
        Entry(lpspKey: "Messages", template: .appleClone, status: .lpspReady, devPriority: 0, fidelity: .done, notes: "Clone + threads LPSP"),
        Entry(lpspKey: "Telephone", template: .appleClone, status: .lpspReady, devPriority: 0, fidelity: .done, notes: "Clone + récents/contacts"),
        Entry(lpspKey: "Photos", template: .appleClone, status: .lpspReady, devPriority: 0, fidelity: .done, notes: "Clone + galerie LPSP"),
        Entry(lpspKey: "Safari", template: .appleClone, status: .lpspReady, devPriority: 0, fidelity: .done, notes: "Clone + onglets/historique"),
        Entry(lpspKey: "Mail", template: .appleClone, status: .lpspReady, devPriority: 0, fidelity: .done, notes: "Clone + boîtes LPSP"),
        Entry(lpspKey: "Notes", template: .appleClone, status: .lpspReady, devPriority: 0, fidelity: .done, notes: "Clone + notes LPSP"),
        Entry(lpspKey: "Calendrier", template: .appleClone, status: .lpspReady, devPriority: 0, fidelity: .done, notes: "Clone + événements LPSP"),
        Entry(lpspKey: "Contacts", template: .appleClone, status: .lpspReady, devPriority: 0, fidelity: .done, notes: "Standalone + onglet Téléphone"),
        Entry(lpspKey: "WhatsApp", template: .chat, status: .ready, devPriority: 0, fidelity: .done, notes: "LpspWhatsAppView — polish possible"),
        Entry(lpspKey: "Signal", template: .chat, status: .ready, devPriority: 0, fidelity: .done, notes: "LpspSignalView — polish possible"),

        // ——— Templates tiers (file dev J-3) ———
        Entry(lpspKey: "Uber", template: .rideHailing, status: .ready, devPriority: 0, fidelity: .done, notes: "Clone Reddit 264Gaurav/UBER-ios + Activité LPSP"),
        Entry(lpspKey: "Banque", template: .bank, status: .ready, devPriority: 0, fidelity: .done, notes: "Clone GeraudLuku/YT-BankingApp + opérations LPSP J-3"),
        Entry(lpspKey: "Plans", template: .maps, status: .ready, devPriority: 0, fidelity: .done, notes: "LpspPlansView · pixel polish · carte + trajets"),
        Entry(lpspKey: "Fichiers", template: .files, status: .ready, devPriority: 0, fidelity: .done, notes: "LpspFichiersView · pixel polish · parcourir + supprimés"),
        Entry(lpspKey: "Rappels", template: .reminders, status: .ready, devPriority: 0, fidelity: .done, notes: "Clone azamsharp/RemindersClone + listes LPSP J-3"),
        Entry(lpspKey: "Instagram", template: .socialFeed, status: .ready, devPriority: 0, fidelity: .done, notes: "Clone NDCSwift/InstagramRecreation2 + profil LPSP"),
        Entry(lpspKey: "Spotify", template: .streamingMusic, status: .ready, devPriority: 0, fidelity: .done, notes: "LpspSpotifyView · pixel polish · accueil sombre"),
        Entry(lpspKey: "Netflix", template: .streamingVideo, status: .ready, devPriority: 0, fidelity: .done, notes: "Clone debuging-life/netflix-clone + LPSP profils/Reprendre"),

        // ——— Extension templates (après ancres ci-dessus) ———
        Entry(lpspKey: "Bolt", template: .rideHailing, status: .planned, devPriority: 10, fidelity: .high, notes: "Même UI qu'Uber · branding Bolt"),
        Entry(lpspKey: "Uber Eats", template: .rideHailing, status: .planned, devPriority: 11, fidelity: .medium, notes: "Onglet Eats dans template Uber"),
        Entry(lpspKey: "LCL", template: .bank, status: .planned, devPriority: 12, fidelity: .high, notes: "Même UI banque"),
        Entry(lpspKey: "BNP Paribas", template: .bank, status: .planned, devPriority: 13, fidelity: .high, notes: "Même UI banque"),
        Entry(lpspKey: "Revolut", template: .bank, status: .planned, devPriority: 14, fidelity: .high, notes: "Variante néobanque"),
        Entry(lpspKey: "Waze", template: .maps, status: .planned, devPriority: 16, fidelity: .medium, notes: "Variante navigation · même UI Plans"),
        Entry(lpspKey: "Telegram", template: .chat, status: .planned, devPriority: 17, fidelity: .high, notes: "Skin chat · template existant"),
        Entry(lpspKey: "Messenger", template: .chat, status: .planned, devPriority: 18, fidelity: .high, notes: "Skin Meta · template existant"),
        Entry(lpspKey: "TikTok", template: .socialFeed, status: .planned, devPriority: 19, fidelity: .medium, notes: "Feed vertical"),
        Entry(lpspKey: "X", template: .socialFeed, status: .planned, devPriority: 20, fidelity: .medium, notes: "Fil + notifications"),
        Entry(lpspKey: "Snapchat", template: .socialFeed, status: .planned, devPriority: 21, fidelity: .medium, notes: "Stories + carte simplifiée"),
        Entry(lpspKey: "Disney+", template: .streamingVideo, status: .planned, devPriority: 22, fidelity: .medium, notes: "Même template Netflix"),

        // ——— Clones Apple à brancher LPSP ———
        Entry(lpspKey: "Réglages", template: .appleClone, status: .cloneDemo, devPriority: 30, fidelity: .medium, notes: "Showroom · owner LPSP"),
        Entry(lpspKey: "Météo", template: .appleClone, status: .cloneDemo, devPriority: 31, fidelity: .medium, notes: "Showroom · ville LPSP"),
        Entry(lpspKey: "Musique", template: .appleClone, status: .cloneDemo, devPriority: 32, fidelity: .medium, notes: "Showroom · ≠ Spotify"),
        Entry(lpspKey: "Horloge", template: .appleClone, status: .cloneDemo, devPriority: 33, fidelity: .low, notes: "Showroom · rare en enquête"),
        Entry(lpspKey: "Calculatrice", template: .appleClone, status: .cloneDemo, devPriority: 34, fidelity: .low, notes: "Showroom"),
        Entry(lpspKey: "Appareil photo", template: .appleClone, status: .cloneDemo, devPriority: 35, fidelity: .low, notes: "Showroom"),
        Entry(lpspKey: "App Store", template: .appleClone, status: .cloneDemo, devPriority: 36, fidelity: .low, notes: "Showroom"),

        // ——— Histoires futures ———
        Entry(lpspKey: "Amazon", template: .commerce, status: .planned, devPriority: 40, fidelity: .medium, notes: "Commandes · souvent couvert par Mail"),
        Entry(lpspKey: "Airbnb", template: .travel, status: .planned, devPriority: 41, fidelity: .medium, notes: "Réservations + messages hôte"),
        Entry(lpspKey: "Tinder", template: .dating, status: .planned, devPriority: 42, fidelity: .medium, notes: "Matchs + chat"),
        Entry(lpspKey: "Bumble", template: .dating, status: .planned, devPriority: 43, fidelity: .medium, notes: "Même template dating"),
        Entry(lpspKey: "Wallet", template: .wallet, status: .planned, devPriority: 44, fidelity: .medium, notes: "Cartes + tickets"),
        Entry(lpspKey: "Apple Music", template: .streamingMusic, status: .ready, devPriority: 0, fidelity: .done, notes: "Clone aisultanios/MyPlaylists · distinct Musique Showroom"),
        Entry(lpspKey: "Deliveroo", template: .rideHailing, status: .planned, devPriority: 46, fidelity: .medium, notes: "Livraison · proche Uber Eats"),
    ]

    // MARK: - Helpers

    static func entry(for lpspKey: String) -> Entry? {
        all.first { $0.lpspKey == lpspKey }
    }

    static func isKnownApp(_ lpspKey: String) -> Bool {
        entry(for: lpspKey) != nil || CloneAppCatalog.isCloneApp(lpspKey)
    }

    /// Prochaines apps à développer (une par template anchor, ordre strict).
    static var developmentQueue: [Entry] {
        all
            .filter { $0.devPriority > 0 && $0.status != .ready && $0.status != .lpspReady }
            .sorted { $0.devPriority < $1.devPriority }
    }

    static var nextToBuild: Entry? {
        developmentQueue.first
    }

    /// Apps d'une histoire sans UI jouable.
    static func missingUI(for appNames: [String]) -> [Entry] {
        appNames.compactMap { name in
            guard let entry = entry(for: name) else {
                return Entry(lpspKey: name, template: .generic, status: .planned, devPriority: 99, fidelity: .low, notes: "Hors catalogue")
            }
            guard entry.status == .jsonOnly || entry.status == .planned else { return nil }
            return entry
        }
        .sorted { $0.devPriority < $1.devPriority }
    }

    static var completedCount: Int {
        all.filter { $0.status == .ready || $0.status == .lpspReady }.count
    }

    static var totalCount: Int { all.count }
}

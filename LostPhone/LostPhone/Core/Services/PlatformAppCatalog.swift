import Foundation

// MARK: - Catalogue plateforme Lost Phone
//
// Toutes les apps *possibles* pour les histoires. Chaque histoire choisit un sous-ensemble
// via `manifest.apps_presentes` dans son lpsp.json — on ne met jamais tout sur l'accueil.
//
// Implémentation : une fois par **template** (chat, VTC, banque…), pas une fois par marque
// si l'UX est identique. `AppBranding` gère le nom affiché (plan B juridique).

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
        case generic
    }

    enum ImplementationStatus: String {
        /// UI + injection LPSP complètes
        case ready
        /// Clone UI OK, données LPSP branchées
        case lpspReady
        /// Clone UI demo (showroom), LPSP optionnel
        case cloneDemo
        /// JSON LPSP possible, écran = dump ou placeholder
        case jsonOnly
        /// Prévu plateforme, pas encore codé
        case planned
    }

    struct Entry: Identifiable {
        var id: String { lpspKey }
        let lpspKey: String
        let template: Template
        let status: ImplementationStatus
        let notes: String
    }

    /// Clés LPSP canoniques — une entrée par app que le moteur peut reconnaître.
    static let all: [Entry] = [
        // ——— Apple (clone zerocode117) ———
        Entry(lpspKey: "Messages", template: .appleClone, status: .lpspReady, notes: "Clone + threads LPSP"),
        Entry(lpspKey: "Telephone", template: .appleClone, status: .lpspReady, notes: "Clone + récents/contacts"),
        Entry(lpspKey: "Photos", template: .appleClone, status: .lpspReady, notes: "Clone + galerie LPSP"),
        Entry(lpspKey: "Safari", template: .appleClone, status: .lpspReady, notes: "Clone + onglets/historique"),
        Entry(lpspKey: "Mail", template: .appleClone, status: .lpspReady, notes: "Clone + boîtes LPSP"),
        Entry(lpspKey: "Notes", template: .appleClone, status: .lpspReady, notes: "Clone + notes LPSP"),
        Entry(lpspKey: "Calendrier", template: .appleClone, status: .lpspReady, notes: "Clone + événements LPSP"),
        Entry(lpspKey: "Contacts", template: .appleClone, status: .lpspReady, notes: "Standalone + onglet Téléphone"),
        Entry(lpspKey: "Réglages", template: .appleClone, status: .cloneDemo, notes: "Showroom — demo"),
        Entry(lpspKey: "Météo", template: .appleClone, status: .cloneDemo, notes: "Showroom — demo"),
        Entry(lpspKey: "Horloge", template: .appleClone, status: .cloneDemo, notes: "Showroom — demo"),
        Entry(lpspKey: "Calculatrice", template: .appleClone, status: .cloneDemo, notes: "Showroom — demo"),
        Entry(lpspKey: "Appareil photo", template: .appleClone, status: .cloneDemo, notes: "Showroom — demo"),
        Entry(lpspKey: "App Store", template: .appleClone, status: .cloneDemo, notes: "Showroom — demo"),
        Entry(lpspKey: "Musique", template: .appleClone, status: .cloneDemo, notes: "Showroom — demo partiel"),

        // ——— Messagerie (template chat) ———
        Entry(lpspKey: "WhatsApp", template: .chat, status: .ready, notes: "LpspWhatsAppView"),
        Entry(lpspKey: "Signal", template: .chat, status: .ready, notes: "LpspSignalView"),
        Entry(lpspKey: "Telegram", template: .chat, status: .planned, notes: "Même template chat"),
        Entry(lpspKey: "Messenger", template: .chat, status: .planned, notes: "Même template chat"),

        // ——— Cartographie ———
        Entry(lpspKey: "Google Maps", template: .maps, status: .jsonOnly, notes: "J-3 JSON prêt — UI à coder"),
        Entry(lpspKey: "Plans", template: .maps, status: .planned, notes: "Alias Apple Maps — même template"),
        Entry(lpspKey: "Waze", template: .maps, status: .planned, notes: "Même template trajets"),

        // ——— VTC / livraison (template ride) ———
        Entry(lpspKey: "Uber", template: .rideHailing, status: .jsonOnly, notes: "J-3 JSON prêt — UI à coder"),
        Entry(lpspKey: "Bolt", template: .rideHailing, status: .planned, notes: "Même template courses"),
        Entry(lpspKey: "Uber Eats", template: .rideHailing, status: .planned, notes: "Onglet Eats du template Uber"),

        // ——— Réseaux sociaux (template feed) ———
        Entry(lpspKey: "Instagram", template: .socialFeed, status: .jsonOnly, notes: "J-3 JSON prêt — UI à coder"),
        Entry(lpspKey: "TikTok", template: .socialFeed, status: .planned, notes: "Même template feed vertical"),
        Entry(lpspKey: "X", template: .socialFeed, status: .planned, notes: "Fil + DMs optionnel"),
        Entry(lpspKey: "Snapchat", template: .socialFeed, status: .planned, notes: "Stories-first"),

        // ——— Banque (template bank) ———
        Entry(lpspKey: "Crédit Agricole", template: .bank, status: .jsonOnly, notes: "J-3 JSON prêt — UI à coder"),
        Entry(lpspKey: "LCL", template: .bank, status: .planned, notes: "Même template relevé/virements"),
        Entry(lpspKey: "BNP Paribas", template: .bank, status: .planned, notes: "Même template"),
        Entry(lpspKey: "Revolut", template: .bank, status: .planned, notes: "Même template néobanque"),

        // ——— Streaming ———
        Entry(lpspKey: "Netflix", template: .streamingVideo, status: .jsonOnly, notes: "J-3 JSON prêt — UI à coder"),
        Entry(lpspKey: "Disney+", template: .streamingVideo, status: .planned, notes: "Même template VOD"),
        Entry(lpspKey: "Spotify", template: .streamingMusic, status: .jsonOnly, notes: "J-3 JSON prêt — UI à coder"),
        Entry(lpspKey: "Apple Music", template: .streamingMusic, status: .planned, notes: "Différencier du clone Musique demo"),

        // ——— Système iOS (custom) ———
        Entry(lpspKey: "Fichiers", template: .files, status: .jsonOnly, notes: "J-3 JSON prêt — UI à coder"),
        Entry(lpspKey: "Rappels", template: .reminders, status: .jsonOnly, notes: "J-3 JSON prêt — UI à coder"),

        // ——— Autres (stories futures) ———
        Entry(lpspKey: "Amazon", template: .generic, status: .planned, notes: "Commandes — ou via Mail"),
        Entry(lpspKey: "Airbnb", template: .generic, status: .planned, notes: "Réservations"),
        Entry(lpspKey: "Tinder", template: .generic, status: .planned, notes: "Matchs / chat"),
        Entry(lpspKey: "Wallet", template: .generic, status: .planned, notes: "Cartes / tickets"),
    ]

    static func entry(for lpspKey: String) -> Entry? {
        all.first { $0.lpspKey == lpspKey }
    }

    static func isKnownApp(_ lpspKey: String) -> Bool {
        entry(for: lpspKey) != nil || CloneAppCatalog.isCloneApp(lpspKey)
    }

    /// Apps d'une histoire absentes du catalogue ou sans UI jouable.
    static func validateStoryApps(_ appNames: [String]) -> [String] {
        appNames.filter { name in
            guard let entry = entry(for: name) else { return true }
            return entry.status == .jsonOnly || entry.status == .planned
        }
    }

    static var templatesToImplement: [Template] {
        let needsWork: Set<ImplementationStatus> = [.jsonOnly, .planned]
        return Template.allCases.filter { template in
            all.contains { $0.template == template && needsWork.contains($0.status) }
        }
    }
}

import Foundation

/// Affichage des noms d'apps à l'écran (accueil, barres de navigation).
///
/// Par défaut : noms réels (WhatsApp, Uber…) pour l'immersion.
/// Si rejet App Store / marque : passer `useFictionalDisplayNames` à `true`
/// sans modifier le JSON LPSP (clés internes inchangées).
enum AppBranding {
    /// Basculer à `true` en plan B (Guideline 5.2) — resoumission rapide.
    static let useFictionalDisplayNames = false

    private static let fictionalNames: [String: String] = [
        "WhatsApp": "Chatsy",
        "Signal": "Cipher",
        "Instagram": "PixFeed",
        "Uber": "GoRide",
        "Plans": "Carto",
        "Spotify": "TuneUp",
        "Banque": "Ma Banque",
    ]

    static func displayName(for lpspKey: String) -> String {
        let key = LpspAppAliases.canonical(lpspKey)
        if useFictionalDisplayNames, let alias = fictionalNames[key] {
            return alias
        }
        return key
    }
}

import Foundation

/// Apps tierces servies par un clone GitHub vendored (copy-paste, pas de génération Awesome).
/// Ajouter le nom ici uniquement quand `VendoredShowroomRouter` a une entrée prête.
enum VendoredShowroomCatalog {
    static let tierApps: [String] = [
        "TikTok",
    ]

    static func isVendored(_ appName: String) -> Bool {
        tierApps.contains(LpspAppAliases.canonical(appName))
    }
}

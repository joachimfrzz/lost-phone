import Foundation

/// Apps tierces servies par clones vendored (Sopheamen Patreon + GitHub legacy).
enum VendoredShowroomCatalog {
    static let tierApps: [String] = SopheamenShowroomCatalog.tierApps

    static func isVendored(_ appName: String) -> Bool {
        tierApps.contains(LpspAppAliases.canonical(appName))
    }
}

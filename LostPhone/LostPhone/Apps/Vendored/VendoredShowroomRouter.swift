import SwiftUI

/// Routage showroom → clones GitHub vendored (`Apps/Vendored/`).
enum VendoredShowroomRouter {
    @ViewBuilder
    static func view(for appName: String) -> some View {
        switch LpspAppAliases.canonical(appName) {
        case "TikTok":
            LpspVendoredTikTokRootView()
        default:
            AwesomeShowroomRouter.view(for: appName)
        }
    }
}

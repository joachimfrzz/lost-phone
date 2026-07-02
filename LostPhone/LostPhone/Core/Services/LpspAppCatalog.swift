import SwiftUI

enum LpspAppAliases {
    private static let legacy: [String: String] = [
        "Google Maps": "Plans",
        "Crédit Agricole": "Banque",
    ]

    static func canonical(_ name: String) -> String {
        legacy[name] ?? name
    }
}

enum LpspAppCatalog {
    static func cloneType(for lpspName: String) -> AppType? {
        CloneAppCatalog.appType(for: LpspAppAliases.canonical(lpspName))
    }

    static func iconAsset(for lpspName: String) -> String? {
        let name = LpspAppAliases.canonical(lpspName)
        if name == "Contacts" { return "contacts" }
        return cloneType(for: name)?.assetName
    }

    static func displayName(_ lpspName: String) -> String {
        AppBranding.displayName(for: LpspAppAliases.canonical(lpspName))
    }

    static func accentColor(for lpspName: String) -> Color {
        let name = LpspAppAliases.canonical(lpspName)
        if let clone = cloneType(for: name) { return clone.color }
        switch name {
        case "WhatsApp": return Color(red: 0.15, green: 0.78, blue: 0.45)
        case "Signal": return .indigo
        case "Instagram": return .purple
        case "Uber": return .black
        case "Plans": return .green
        case "Banque": return Color(red: 0.0, green: 0.45, blue: 0.25)
        case "Contacts": return .gray
        case "Fichiers": return .blue
        case "Rappels": return .orange
        case "Spotify": return Color(red: 0.11, green: 0.73, blue: 0.33)
        case "Netflix": return .red
        default: return .blue
        }
    }
}

struct LpspAppIconView: View {
    let appName: String
    var showLabel = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                if let asset = LpspAppCatalog.iconAsset(for: appName) {
                    Image(asset)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 65, height: 65)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                } else {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(LpspAppCatalog.accentColor(for: appName).gradient)
                        .frame(width: 65, height: 65)
                        .overlay {
                            Text(String(appName.prefix(1)))
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(.white)
                        }
                }

                if showLabel {
                    Text(LpspAppCatalog.displayName(appName))
                        .font(.caption)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

import SwiftUI

enum LpspAppCatalog {
    static func cloneType(for lpspName: String) -> AppType? {
        switch lpspName {
        case "Messages": return .messages
        case "Telephone": return .phone
        case "Photos": return .photos
        case "Safari": return .safari
        case "Notes": return .notes
        case "Mail": return .mail
        case "Calendrier": return .calendar
        case "Réglages", "Settings": return .settings
        case "Spotify": return .music
        case "Netflix": return .music
        default: return nil
        }
    }

    static func iconAsset(for lpspName: String) -> String? {
        cloneType(for: lpspName)?.assetName
    }

    static func displayName(_ lpspName: String) -> String {
        lpspName
    }

    static func accentColor(for lpspName: String) -> Color {
        if let clone = cloneType(for: lpspName) { return clone.color }
        switch lpspName {
        case "WhatsApp": return Color(red: 0.15, green: 0.78, blue: 0.45)
        case "Signal": return .indigo
        case "Instagram": return .purple
        case "Uber": return .black
        case "Google Maps": return .green
        case "Crédit Agricole": return Color(red: 0.0, green: 0.45, blue: 0.25)
        case "Contacts": return .gray
        case "Fichiers": return .blue
        case "Rappels": return .orange
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
                if let clone = LpspAppCatalog.cloneType(for: appName), let asset = clone.assetName {
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

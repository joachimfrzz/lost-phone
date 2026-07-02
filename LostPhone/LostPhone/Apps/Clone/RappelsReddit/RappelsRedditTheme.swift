import SwiftUI

enum RappelsRedditTheme {
    static let accent = LpspThirdPartyBrand.remindersYellow

    static func listColor(named raw: String) -> Color {
        switch raw.lowercased() {
        case "bleu", "blue": return .blue
        case "rouge", "red": return .red
        case "orange": return .orange
        case "vert", "green": return Color(hex: "34C759")
        case "violet", "purple": return .purple
        case "jaune", "yellow": return accent
        case "gris", "gray", "grey": return .gray
        case "rose", "pink": return .pink
        default: return Color(hex: "34C759")
        }
    }
}

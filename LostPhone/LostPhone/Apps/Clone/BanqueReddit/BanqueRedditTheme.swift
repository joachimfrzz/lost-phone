import SwiftUI

enum BanqueRedditTheme {
    static let green = Color(red: 0xE0 / 255, green: 0xFE / 255, blue: 0x0E / 255)
    static let dark = Color(red: 0x07 / 255, green: 0x07 / 255, blue: 0x09 / 255)
    static let purple = Color(red: 0xCA / 255, green: 0xC1 / 255, blue: 0xF8 / 255)

    static func categoryStyle(for category: String) -> (icon: String, color: Color) {
        switch category.lowercased() {
        case let c where c.contains("restauration"), let c where c.contains("alimentation"):
            return ("takeoutbag.and.cup.and.straw.fill", .pink)
        case let c where c.contains("transport"), let c where c.contains("mobilité"):
            return ("car.fill", .blue)
        case let c where c.contains("abonnement"), let c where c.contains("telecom"):
            return ("repeat", .purple)
        case let c where c.contains("loyer"), let c where c.contains("logement"):
            return ("house.fill", .orange)
        case let c where c.contains("salaire"), let c where c.contains("virement"):
            return ("arrow.left.arrow.right", .green)
        default:
            return ("creditcard.fill", BanqueRedditTheme.green)
        }
    }
}

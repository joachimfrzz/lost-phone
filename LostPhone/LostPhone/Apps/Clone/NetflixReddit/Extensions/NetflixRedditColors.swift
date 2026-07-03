import SwiftUI

// Asset catalog colors vendored from netflix-clone (Symbols not auto-generated in merged target).
extension Color {
    static let netflixRed = Color("netflixRed")
    static let buttonGrayDark = Color("buttonGrayDark")
    static let bgLightGray = Color("bgLightGray")
    static let customDarkGray = Color("customDarkGray")
    static let profileBG = Color("profileBG")
}

extension ShapeStyle where Self == Color {
    static var netflixRed: Color { Color.netflixRed }
    static var buttonGrayDark: Color { Color.buttonGrayDark }
    static var bgLightGray: Color { Color.bgLightGray }
    static var customDarkGray: Color { Color.customDarkGray }
    static var profileBG: Color { Color.profileBG }
}

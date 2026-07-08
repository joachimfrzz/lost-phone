import SwiftUI

extension Color {
    static let spotifyBlack = Color("SpotifyBlack")
    static let spotifyWhite = Color("SpotifyWhite")
    static let spotifyGreen = Color("SpotifyGreen")
    static let spotifyGrey = Color("SpotifyGrey")
    static let spotifyDarkGrey = Color("SpotifyDarkGrey")
    static let spotifyLightGrey = Color("SpotifyLightGrey")
}

extension ShapeStyle where Self == Color {
    static var spotifyBlack: Color { Color.spotifyBlack }
    static var spotifyWhite: Color { Color.spotifyWhite }
    static var spotifyGreen: Color { Color.spotifyGreen }
    static var spotifyGrey: Color { Color.spotifyGrey }
    static var spotifyDarkGrey: Color { Color.spotifyDarkGrey }
    static var spotifyLightGrey: Color { Color.spotifyLightGrey }
}

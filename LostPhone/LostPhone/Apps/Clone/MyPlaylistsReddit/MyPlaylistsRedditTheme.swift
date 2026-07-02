import SwiftUI

enum MyPlaylistsRedditTheme {
    static let accent = Color.pink
    static let artworkGradient = LinearGradient(
        colors: [Color.pink.opacity(0.55), Color.purple.opacity(0.45)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

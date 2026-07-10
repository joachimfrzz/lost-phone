import SwiftUI
import AVFoundation
import Combine

// Modèles zerocode117 conservés pour LpspCloneBridge / LpspAdapters.
// Email + MailManager → EmailApp.swift ; vues Mail → MailView dans le même fichier.

struct Track: Identifiable, Codable, Hashable {
    let trackId: Int
    let trackName: String
    let artistName: String
    let artworkUrl100: String
    let previewUrl: String?

    var id: Int { trackId }

    init(stableId: String, trackName: String, artistName: String, artworkUrl100: String = "", previewUrl: String? = nil) {
        self.trackId = abs(stableId.hashValue)
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.previewUrl = previewUrl
    }

    init(trackId: Int, trackName: String, artistName: String, artworkUrl100: String, previewUrl: String?) {
        self.trackId = trackId
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.previewUrl = previewUrl
    }
}

final class MusicManager: ObservableObject {
    @Published var tracks: [Track] = []

    static let storyFallbackTracks: [Track] = [
        Track(stableId: "m1", trackName: "Louvre — ambiance ref", artistName: "Playlist perso"),
        Track(stableId: "m2", trackName: "La Dame à l'hermine", artistName: "Podcast Arte"),
        Track(stableId: "m3", trackName: "Nuit blanche", artistName: "Archive locale"),
        Track(stableId: "m4", trackName: "Hugo 💙", artistName: "Mix maison"),
    ]

    init(tracks: [Track] = storyFallbackTracks) {
        self.tracks = tracks.isEmpty ? Self.storyFallbackTracks : tracks
    }
}

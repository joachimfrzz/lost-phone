import SwiftUI
import AVFoundation
import Combine

// Modèles zerocode117 conservés pour LpspCloneBridge / LpspAdapters.
// Vues remplacées par les clones Sopheamen dans Apps/Vendored/.

struct Email: Identifiable, Hashable {
    let id: UUID
    let sender: String
    let subject: String
    let body: String
    let date: Date
    var isRead: Bool
    var isFlagged: Bool

    init(stableId: String, sender: String, subject: String, body: String, date: Date, isRead: Bool, isFlagged: Bool) {
        self.id = LpspStableId.uuid(stableId)
        self.sender = sender
        self.subject = subject
        self.body = body
        self.date = date
        self.isRead = isRead
        self.isFlagged = isFlagged
    }

    var preview: String {
        body.replacingOccurrences(of: "\n", with: " ")
    }
}

final class MailManager: ObservableObject {
    @Published var emails: [Email] = []

    init(emails: [Email] = []) {
        self.emails = emails
    }
}

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

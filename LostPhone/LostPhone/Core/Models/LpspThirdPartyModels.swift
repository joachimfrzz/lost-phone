import Foundation

struct LpspRide: Identifiable, Equatable, Hashable {
    let id: String
    let date: Date?
    let dateRaw: String
    let pickup: String
    let dropoff: String
    let duration: String
    let price: String
    let driver: String
    let vehicle: String
    let status: String
}

struct LpspBankAccount: Identifiable, Equatable {
    let id: String
    let type: String
    let partialNumber: String
    let balance: Double
    let currency: String
}

struct LpspBankOperation: Identifiable, Equatable, Hashable {
    let id: String
    let date: Date?
    let dateRaw: String
    let label: String
    let amount: Double
    let category: String
}

struct LpspBankData: Equatable {
    let holderName: String
    let advisor: String
    let branch: String
    let accounts: [LpspBankAccount]
    let operations: [LpspBankOperation]
    let cardPartial: String
}

struct LpspMapPlace: Identifiable, Equatable, Hashable {
    let id: String
    let label: String
    let address: String
}

struct LpspMapTrip: Identifiable, Equatable, Hashable {
    let id: String
    let date: Date?
    let dateRaw: String
    let origin: String
    let destination: String
    let mode: String
    let duration: String
}

struct LpspSavedRoute: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let origin: String
    let destination: String
    let duration: String
}

struct LpspMapsData: Equatable {
    let places: [LpspMapPlace]
    let trips: [LpspMapTrip]
    let routes: [LpspSavedRoute]
}

struct LpspFileItem: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let path: String
    let type: String
    let size: String
    let description: String
    let modifiedRaw: String
    var isDeleted: Bool = false
}

struct LpspReminderItem: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let notes: String
    let completed: Bool
    let dueRaw: String
    let priority: String
}

struct LpspReminderList: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let emoji: String
    let colorName: String
    let items: [LpspReminderItem]
}

struct LpspInstagramPost: Identifiable, Equatable, Hashable {
    let id: String
    let author: String
    let caption: String
    let date: String
    let dateParsed: Date?
    let likes: Int
}

struct LpspInstagramProfile: Equatable {
    let username: String
    let bio: String
    let posts: [LpspInstagramPost]
}

struct LpspUberAccount: Equatable {
    let name: String
    let email: String
    let phone: String
    let passengerRating: Double
    let paymentMethod: String
    let savedPlaces: [LpspMapPlace]
}

struct LpspSpotifyTrack: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let artist: String
    let playedAtRaw: String?
    let playedAt: Date?
}

struct LpspSpotifyPlaylist: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let trackCount: Int
    let tracks: [LpspSpotifyTrack]
}

struct LpspSpotifyData: Equatable {
    let username: String
    let plan: String
    let playlists: [LpspSpotifyPlaylist]
    let recentTracks: [LpspSpotifyTrack]
}

struct LpspAppleMusicTrack: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let artist: String
}

struct LpspAppleMusicPlaylist: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let trackCount: Int
    let tracks: [LpspAppleMusicTrack]
}

struct LpspAppleMusicData: Equatable {
    let username: String
    let plan: String
    let playlists: [LpspAppleMusicPlaylist]
    let recentTracks: [LpspAppleMusicTrack]
}

struct LpspNetflixProfile: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let avatar: String
    let isKids: Bool
}

struct LpspNetflixItem: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let kind: String
    let progress: String
    let profileName: String
}

struct LpspNetflixData: Equatable {
    let holder: String
    let plan: String
    let profiles: [LpspNetflixProfile]
    let continueWatching: [LpspNetflixItem]
}

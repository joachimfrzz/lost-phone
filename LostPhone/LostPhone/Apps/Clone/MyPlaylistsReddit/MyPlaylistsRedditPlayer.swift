import SwiftUI

@MainActor
final class MyPlaylistsRedditPlayer: ObservableObject {
    @Published var currentTrack: LpspAppleMusicTrack?
    @Published var isPlaying = false
    @Published var showFullPlayer = false
    @Published var progress: Double = 0.18

    func play(_ track: LpspAppleMusicTrack) {
        if currentTrack?.id == track.id {
            isPlaying.toggle()
            if isPlaying { showFullPlayer = true }
            return
        }
        currentTrack = track
        isPlaying = true
        progress = 0.18
        withAnimation(.spring(response: 0.45, dampingFraction: 0.82)) {
            showFullPlayer = true
        }
    }

    func togglePlayPause() {
        isPlaying.toggle()
    }

    func next(in tracks: [LpspAppleMusicTrack]) {
        guard let current = currentTrack,
              let index = tracks.firstIndex(where: { $0.id == current.id }) else { return }
        play(tracks[(index + 1) % tracks.count])
    }

    func previous(in tracks: [LpspAppleMusicTrack]) {
        guard let current = currentTrack,
              let index = tracks.firstIndex(where: { $0.id == current.id }) else { return }
        play(tracks[(index - 1 + tracks.count) % tracks.count])
    }
}

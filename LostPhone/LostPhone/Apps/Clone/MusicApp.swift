import SwiftUI
import AVFoundation
import Combine

// MARK: - Models

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
    
    var artworkLarge: URL? {
        guard !artworkUrl100.isEmpty else { return nil }
        return URL(string: artworkUrl100.replacingOccurrences(of: "100x100", with: "600x600"))
    }
    
    var artworkSmall: URL? {
        guard !artworkUrl100.isEmpty else { return nil }
        return URL(string: artworkUrl100)
    }
}

struct ITunesResponse: Codable {
    let results: [Track]
}

// MARK: - Logic Manager

@MainActor
class MusicManager: ObservableObject {
    @Published var tracks: [Track] = []
    @Published var currentTrack: Track?
    @Published var isPlaying: Bool = false
    @Published var showFullPlayer: Bool = false
    @Published var searchText: String = ""
    
    @Published var currentTime: Double = 0.0
    @Published var duration: Double = 29.0
    
    private var player: AVPlayer?
    private var cancellables = Set<AnyCancellable>()
    private var timeObserver: Any?

    static let storyFallbackTracks: [Track] = [
        Track(stableId: "m1", trackName: "Louvre — ambiance ref", artistName: "Playlist perso"),
        Track(stableId: "m2", trackName: "La Dame à l'hermine", artistName: "Podcast Arte"),
        Track(stableId: "m3", trackName: "Nuit blanche", artistName: "Archive locale"),
        Track(stableId: "m4", trackName: "Hugo 💙", artistName: "Mix maison"),
    ]
    
    init(tracks: [Track] = storyFallbackTracks) {
        self.tracks = tracks.isEmpty ? Self.storyFallbackTracks : tracks
    }
    
    func searchMusic() {
        // Lecture seule Lost Phone — pas d'appel iTunes.
        guard !searchText.isEmpty else { return }
        let query = searchText.lowercased()
        tracks = (tracks.isEmpty ? Self.storyFallbackTracks : tracks).filter {
            $0.trackName.lowercased().contains(query) || $0.artistName.lowercased().contains(query)
        }
    }
    
    func play(_ track: Track) {
        // 1. If tapping the same song, just toggle playback and open player
        if currentTrack?.id == track.id {
            if !isPlaying { togglePlayPause() }
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                showFullPlayer = true
            }
            return
        }
        
        guard let urlString = track.previewUrl, let url = URL(string: urlString) else {
            currentTrack = track
            isPlaying = false
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                showFullPlayer = true
            }
            return
        }
        
        // Remove the old observer from the OLD player instance before overwriting 'player'
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }
        
        // Setup New Player
        currentTrack = track
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        isPlaying = true
        
        // 4. Open Player UI
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            showFullPlayer = true
        }
        
        // 5. Add New Observer
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 10), queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
        }
        
        // 6. Loop Playback
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: .zero)
            self?.player?.play()
        }
    }
    
    func togglePlayPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
    
    func nextTrack() {
        guard let current = currentTrack, let index = tracks.firstIndex(where: { $0.id == current.id }) else { return }
        let nextIndex = (index + 1) % tracks.count
        play(tracks[nextIndex])
    }
    
    func previousTrack() {
        guard let current = currentTrack, let index = tracks.firstIndex(where: { $0.id == current.id }) else { return }
        let prevIndex = (index - 1 + tracks.count) % tracks.count
        play(tracks[prevIndex])
    }
}

// MARK: - Main View

struct MusicView: View {
    @StateObject private var manager: MusicManager
    @Namespace private var animation
    @Environment(\.lpspReadOnly) private var readOnly

    init(manager: MusicManager = MusicManager()) {
        _manager = StateObject(wrappedValue: manager)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 1. Tab View
            TabView {
                HomeView(manager: manager)
                    .tabItem { Label("Listen Now", systemImage: "play.circle.fill") }
                
                BrowseView(manager: manager)
                    .tabItem { Label("Browse", systemImage: "square.grid.2x2.fill") }
                
                MusicRadioView(manager: manager)
                    .tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right") }
                
                MusicLibraryView(manager: manager)
                    .tabItem { Label("Library", systemImage: "square.stack.fill") }
                
                MusicSearchView(manager: manager)
                    .tabItem { Label("Search", systemImage: "magnifyingglass") }
            }
            .accentColor(.red)
            
            // 2. Mini Player
            if let track = manager.currentTrack, !manager.showFullPlayer {
                FloatingMiniPlayer(track: track, manager: manager, animation: animation)
                    .padding(.bottom, 55)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
            }
            
            // 3. Full Player
            if let track = manager.currentTrack, manager.showFullPlayer {
                FullPlayerView(track: track, manager: manager, animation: animation)
                    .zIndex(2)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Floating Mini Player

struct FloatingMiniPlayer: View {
    let track: Track
    @ObservedObject var manager: MusicManager
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 15) {
            // Artwork
            AsyncImage(url: track.artworkSmall) { image in
                image.resizable()
            } placeholder: {
                Color(uiColor: .systemGray5)
            }
            .frame(width: 42, height: 42)
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            .matchedGeometryEffect(id: "artwork", in: animation)
            
            // Title
            Text(track.trackName)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
                .matchedGeometryEffect(id: "title", in: animation)
            
            Spacer()
            
            // Controls
            Button(action: manager.togglePlayPause) {
                Image(systemName: manager.isPlaying ? "pause.fill" : "play.fill")
                    .font(.title)
                    .foregroundStyle(.white)
            }
            
            Button(action: manager.nextTrack) {
                Image(systemName: "forward.fill")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .glassEffect(.regular)
        .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 5)
        .padding(.horizontal, 10)
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                manager.showFullPlayer = true
            }
        }
    }
}

// MARK: - Full Player (Detailed)

struct FullPlayerView: View {
    let track: Track
    @ObservedObject var manager: MusicManager
    var animation: Namespace.ID
    
    @State private var dragOffset: CGSize = .zero
    @State private var volume: Double = 0.75
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background
                AsyncImage(url: track.artworkLarge) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .blur(radius: 60)
                        .overlay(Color.black.opacity(0.7))
                } placeholder: {
                    Rectangle().fill(Color(uiColor: .darkGray))
                }
                
                VStack(spacing: 0) {
                    // Grabber
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 40, height: 5)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    // Artwork
                    AsyncImage(url: track.artworkLarge) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 10)
                    .matchedGeometryEffect(id: "artwork", in: animation)
                    .frame(width: geo.size.width - 50, height: geo.size.width - 50)
                    .padding(.bottom, 40)
                    
                    // Info & Controls
                    VStack(spacing: 0) {
                        
                        // Title & Artist
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(track.trackName)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .lineLimit(1)
                                    .matchedGeometryEffect(id: "title", in: animation)
                                
                                Text(track.artistName)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white.opacity(0.6))
                                    .lineLimit(1)
                            }
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "ellipsis.circle.fill")
                                    .font(.system(size: 26))
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        
                        // Scrubber
                        VStack(spacing: 8) {
                            GeometryReader { barGeo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(Color.white.opacity(0.2))
                                        .frame(height: 4)
                                    
                                    Capsule()
                                        .fill(Color.white.opacity(0.8))
                                        .frame(width: barGeo.size.width * (manager.currentTime / manager.duration), height: 4)
                                    
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 8, height: 8)
                                        .offset(x: barGeo.size.width * (manager.currentTime / manager.duration) - 4)
                                }
                            }
                            .frame(height: 10)
                            
                            HStack {
                                Text(formatTime(manager.currentTime))
                                Spacer()
                                Text("-" + formatTime(manager.duration - manager.currentTime))
                            }
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                        
                        // Controls
                        HStack(spacing: 50) {
                            Button(action: manager.previousTrack) {
                                Image(systemName: "backward.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.white)
                            }
                            
                            Button(action: manager.togglePlayPause) {
                                Image(systemName: manager.isPlaying ? "pause.fill" : "play.fill")
                                    .font(.system(size: 55))
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.white)
                            }
                            
                            Button(action: manager.nextTrack) {
                                Image(systemName: "forward.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.bottom, 40)
                        
                        // Volume
                        HStack(spacing: 15) {
                            Image(systemName: "speaker.fill")
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.6))
                            
                            CustomVolumeSlider(value: $volume)
                                .frame(height: 5)
                            
                            Image(systemName: "speaker.wave.3.fill")
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.6))
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 40)
                        
                        // Bottom Icons
                        HStack(spacing: 0) {
                            Button(action: {}) {
                                Image(systemName: "quote.bubble")
                                    .font(.title2)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Button(action: {}) {
                                Image(systemName: "airplayaudio")
                                    .font(.title2)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Button(action: {}) {
                                Image(systemName: "list.bullet")
                                    .font(.title2)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.bottom, 20) // Adjusted padding
                    }
                    
                    Spacer().frame(height: 30)
                }
            }
            .offset(y: dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 {
                            dragOffset = value.translation
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 100 {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                manager.showFullPlayer = false
                            }
                        }
                        withAnimation { dragOffset = .zero }
                    }
            )
        }
    }
    
    func formatTime(_ time: Double) -> String {
        let seconds = Int(time) % 60
        let minutes = Int(time) / 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

// MARK: - Custom Volume Slider

struct CustomVolumeSlider: View {
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 5)
                
                Capsule()
                    .fill(Color.white)
                    .frame(width: geo.size.width * value, height: 5)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let percent = min(max(gesture.location.x / geo.size.width, 0), 1)
                        value = percent
                    }
            )
        }
    }
}

// MARK: - Home View

struct HomeView: View {
    @ObservedObject var manager: MusicManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Top Picks")
                            .font(.title2).bold()
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(manager.tracks.prefix(5)) { track in
                                    Button(action: { manager.play(track) }) {
                                        VStack(alignment: .leading) {
                                            AsyncImage(url: track.artworkLarge) { img in
                                                img.resizable()
                                            } placeholder: {
                                                Color(uiColor: .secondarySystemBackground)
                                            }
                                            .aspectRatio(1, contentMode: .fill)
                                            .frame(width: 240, height: 240)
                                            .cornerRadius(10)
                                            .shadow(radius: 3)
                                            
                                            Text(track.trackName)
                                                .foregroundStyle(.primary)
                                                .lineLimit(1)
                                                .font(.headline)
                                            Text(track.artistName)
                                                .foregroundStyle(.secondary)
                                                .font(.subheadline)
                                        }
                                        .frame(width: 240)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Divider().padding(.leading, 20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Made For You")
                            .font(.title2).bold()
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(manager.tracks.dropFirst(5).prefix(8)) { track in
                                    Button(action: { manager.play(track) }) {
                                        VStack(alignment: .leading) {
                                            AsyncImage(url: track.artworkLarge) { img in
                                                img.resizable()
                                            } placeholder: {
                                                Color(uiColor: .secondarySystemBackground)
                                            }
                                            .aspectRatio(1, contentMode: .fill)
                                            .frame(width: 160, height: 160)
                                            .cornerRadius(8)
                                            
                                            Text(track.trackName)
                                                .foregroundStyle(.primary)
                                                .lineLimit(1)
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                        }
                                        .frame(width: 160)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recently Played")
                            .font(.title2).bold()
                            .padding(.horizontal)
                        
                        ForEach(manager.tracks.suffix(8)) { track in
                            Button(action: { manager.play(track) }) {
                                HStack(spacing: 15) {
                                    AsyncImage(url: track.artworkSmall) { img in
                                        img.resizable()
                                    } placeholder: { Color.gray }
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(4)
                                    
                                    VStack(alignment: .leading) {
                                        Text(track.trackName)
                                            .foregroundStyle(.primary)
                                            .lineLimit(1)
                                        Text(track.artistName)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "ellipsis")
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                            .buttonStyle(.plain)
                            
                            Divider().padding(.leading, 80)
                        }
                    }
                    .padding(.bottom, 100)
                }
                .padding(.top)
            }
            .navigationTitle("Listen Now")
        }
    }
}

struct MusicSearchView: View {
    @ObservedObject var manager: MusicManager
    
    var body: some View {
        NavigationStack {
            List(manager.tracks) { track in
                Button(action: { manager.play(track) }) {
                    HStack(spacing: 12) {
                        AsyncImage(url: track.artworkSmall) { image in
                            image.resizable()
                        } placeholder: { Color.gray }
                            .frame(width: 50, height: 50)
                            .cornerRadius(6)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(track.trackName)
                                .font(.body)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                            Text(track.artistName)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        
                        if manager.currentTrack?.id == track.id {
                            Image(systemName: "waveform")
                                .foregroundStyle(.red)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
            .searchable(text: $manager.searchText)
            .onSubmit(of: .search) {
                manager.searchMusic()
            }
            .navigationTitle("Search")
        }
    }
}

struct BrowseView: View {
    @ObservedObject var manager: MusicManager

    private let categories: [(String, String, Color)] = [
        ("Découvertes", "sparkles", .pink),
        ("Podcasts", "mic.fill", .purple),
        ("Classique", "music.quarternote.3", .brown),
        ("Hip-Hop", "headphones", .orange),
        ("Chill", "leaf.fill", .teal),
        ("Workout", "figure.run", .red),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(categories, id: \.0) { title, symbol, color in
                        Button(action: {}) {
                            ZStack(alignment: .bottomLeading) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        LinearGradient(
                                            colors: [color.opacity(0.85), color.opacity(0.45)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(height: 120)
                                VStack(alignment: .leading, spacing: 6) {
                                    Image(systemName: symbol)
                                        .font(.title2)
                                    Text(title)
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                }
                                .foregroundStyle(.white)
                                .padding(14)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Playlists récentes")
                        .font(.title3.bold())
                        .padding(.horizontal)

                    ForEach(manager.tracks.prefix(4)) { track in
                        Button(action: { manager.play(track) }) {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(uiColor: .secondarySystemBackground))
                                    .frame(width: 50, height: 50)
                                    .overlay(Image(systemName: "music.note.list").foregroundStyle(.red))
                                VStack(alignment: .leading) {
                                    Text(track.trackName)
                                        .foregroundStyle(.primary)
                                        .lineLimit(1)
                                    Text(track.artistName)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.bottom, 100)
            }
            .navigationTitle("Browse")
        }
    }
}

struct MusicRadioView: View {
    @ObservedObject var manager: MusicManager

    private let stations: [(String, String, Color)] = [
        ("Apple Music 1", "Live worldwide", .red),
        ("Apple Music Hits", "Today's hits", .pink),
        ("Apple Music Country", "Country mix", .orange),
        ("Chill", "Relax & focus", .teal),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(stations, id: \.0) { name, subtitle, color in
                        Button(action: {
                            if let track = manager.tracks.first {
                                manager.play(track)
                            }
                        }) {
                            HStack(spacing: 16) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(color.gradient)
                                    .frame(width: 72, height: 72)
                                    .overlay {
                                        Image(systemName: "dot.radiowaves.left.and.right")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                    }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(name)
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    Text(subtitle)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text("LIVE")
                                        .font(.caption2.bold())
                                        .foregroundStyle(.red)
                                }
                                Spacer()
                                Image(systemName: "play.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.red)
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Radio")
        }
    }
}

struct MusicLibraryView: View {
    @ObservedObject var manager: MusicManager
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        NavigationStack {
            List {
                Section {
                    LibraryRow(icon: "arrow.down.circle.fill", color: .red, title: "Downloaded")
                    LibraryRow(icon: "person.crop.circle.fill", color: .gray, title: "Artists")
                    LibraryRow(icon: "music.note", color: .red, title: "Songs", count: manager.tracks.count)
                    LibraryRow(icon: "square.stack.fill", color: .red, title: "Albums")
                }

                Section("Recently Added") {
                    ForEach(manager.tracks) { track in
                        Button(action: { manager.play(track) }) {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(uiColor: .secondarySystemBackground))
                                    .frame(width: 50, height: 50)
                                    .overlay(Image(systemName: "music.note").foregroundStyle(.secondary))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(track.trackName)
                                        .foregroundStyle(.primary)
                                        .lineLimit(1)
                                    Text(track.artistName)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                    .disabled(readOnly)
                }
            }
        }
    }
}

private struct LibraryRow: View {
    let icon: String
    let color: Color
    let title: String
    var count: Int?

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 28)
            Text(title)
            Spacer()
            if let count {
                Text("\(count)")
                    .foregroundStyle(.secondary)
            }
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
    }
}


#Preview {
    MusicView()
}

import SwiftUI
import Combine

// MARK: - Models

struct GalleryPhoto: Identifiable, Hashable {
    let id: String
    let caption: String
    let place: String?
    let capturedAt: Date?
    let capturedLabel: String?
}

struct PicsumPhoto: Identifiable, Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
    
    // Smart URL helpers to get specific sizes for performance
    var thumbnailURL: URL? {
        URL(string: "https://picsum.photos/id/\(id)/250/250")
    }
    
    var detailURL: URL? {
        // Fetch a 1080 width version, maintaining aspect ratio roughly
        URL(string: "https://picsum.photos/id/\(id)/1080/\(Int(1080 * (Double(height)/Double(width))))")
    }
}

@MainActor
class PhotoLibrary: ObservableObject {
    @Published var photos: [PicsumPhoto] = []
    @Published var galleryPhotos: [GalleryPhoto] = []
    @Published var isLoading = false

    init(galleryPhotos: [GalleryPhoto] = []) {
        self.galleryPhotos = galleryPhotos
    }

    var isEmpty: Bool { galleryPhotos.isEmpty && photos.isEmpty }
    var totalCount: Int { galleryPhotos.isEmpty ? photos.count : galleryPhotos.count }
    
    func fetchPhotos() async {
        isLoading = false
    }
}

// MARK: - Main Tab View
struct PhotosView: View {
    @StateObject private var library: PhotoLibrary

    init(library: PhotoLibrary = PhotoLibrary()) {
        _library = StateObject(wrappedValue: library)
    }
    
    var body: some View {
        TabView {
            LibraryView(library: library)
                .tabItem {
                    Label("Library", systemImage: "photo.fill.on.rectangle.fill")
                }
            
            Text("For You")
                .tabItem {
                    Label("For You", systemImage: "heart.text.square.fill")
                }
            
            Text("Albums")
                .tabItem {
                    Label("Albums", systemImage: "rectangle.stack.fill")
                }
            
            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

// MARK: - Library Grid View
struct LibraryView: View {
    @ObservedObject var library: PhotoLibrary
    @State private var gridColumns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 3)
    @State private var selectedSegment = 2 // Default to "All Photos"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 1) {
                        if !library.galleryPhotos.isEmpty {
                            ForEach(library.galleryPhotos) { photo in
                                NavigationLink(destination: GalleryPhotoDetailView(photo: photo)) {
                                    GalleryPhotoTile(photo: photo)
                                }
                            }
                        } else {
                            ForEach(library.photos) { photo in
                                NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                    AsyncImage(url: photo.thumbnailURL) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(minWidth: 0, maxWidth: .infinity)
                                                .aspectRatio(1, contentMode: .fit)
                                                .clipped()
                                        case .failure, .empty:
                                            Color(uiColor: .secondarySystemBackground)
                                                .aspectRatio(1, contentMode: .fit)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .id(photo.id)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 20)

                    VStack(spacing: 5) {
                        Text("\(library.totalCount) Photos")
                            .font(.system(size: 15, weight: .medium))
                        Text("Synced with iCloud Just Now")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.bottom, 50)
                    .opacity(library.isLoading ? 0 : 1)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    // Simulated Segmented Control (Years/Months/All)
                    Picker("", selection: $selectedSegment) {
                        Text("Years").tag(0)
                        Text("Months").tag(1)
                        Text("All").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 220)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Select") { }
                        .fontWeight(.medium)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .task {
                await library.fetchPhotos()
            }
        }
    }
}

struct GalleryPhotoTile: View {
    let photo: GalleryPhoto

    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color(hue: Double(abs(photo.id.hashValue) % 360) / 360, saturation: 0.35, brightness: 0.5),
                        Color(hue: Double(abs(photo.id.hashValue) % 360) / 360, saturation: 0.45, brightness: 0.28),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                Image(systemName: "photo.fill")
                    .foregroundStyle(.white.opacity(0.45))
            }
    }
}

struct GalleryPhotoDetailView: View {
    let photo: GalleryPhoto

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "photo.artframe")
                    .font(.system(size: 56))
                    .foregroundStyle(.white.opacity(0.35))
                Text(photo.caption)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                if let place = photo.place {
                    Label(place, systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.55))
                }
                if let label = photo.capturedLabel ?? photo.capturedAt?.formatted(date: .abbreviated, time: .shortened) {
                    Text(label)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.45))
                }
                Spacer()
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

// MARK: - Photo Detail View
struct PhotoDetailView: View {
    let photo: PicsumPhoto
    @State private var isLiked = false
    @State private var showInfo = false
    @Environment(\.dismiss) var dismiss
    
    // Zoom state
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Image Layer
            GeometryReader { geometry in
                AsyncImage(url: photo.detailURL) { phase in
                    switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(currentScale)
                                .offset(offset)
                                .gesture(
                                    // Zoom Gesture
                                    MagnificationGesture()
                                        .onChanged { value in
                                            let delta = value / lastScale
                                            lastScale = value
                                            let newScale = currentScale * delta
                                            currentScale = min(max(newScale, 1), 5)
                                        }
                                        .onEnded { _ in
                                            lastScale = 1.0
                                            withAnimation(.spring()) {
                                                if currentScale < 1 {
                                                    currentScale = 1
                                                    offset = .zero
                                                }
                                            }
                                        }
                                )
                            // Double tap to reset
                                .onTapGesture(count: 2) {
                                    withAnimation {
                                        currentScale = 1
                                        offset = .zero
                                    }
                                }
                        case .empty:
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundStyle(.white)
                        @unknown default:
                            EmptyView()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarBackground(.visible, for: .bottomBar) // Semi-transparent bottom bar
        .toolbar {
            // Top Toolbar
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isLiked.toggle() }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundStyle(isLiked ? .white : .white) // iOS Photos uses white icon unless active, then solid
                }
            }
            
            // Bottom Toolbar
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    Spacer()
                    Button(action: { isLiked.toggle() }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundStyle(isLiked ? .red : .blue) // iOS uses Blue/Red in bottom bar context sometimes
                    }
                    Spacer()
                    Button(action: { showInfo.toggle() }) {
                        Image(systemName: "info.circle")
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .sheet(isPresented: $showInfo) {
            InfoSheet(photo: photo)
                .presentationDetents([.medium, .fraction(0.3)])
        }
    }
}

struct InfoSheet: View {
    let photo: PicsumPhoto
    
    var body: some View {
        List {
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Apple iPhone 15 Pro")
                            .font(.headline)
                        Text("Main Camera — 24 mm f/1.78")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("ISO 64")
                        Text("24MP • \(photo.width) x \(photo.height) • 4.2 MB")
                            .foregroundStyle(.secondary)
                    }
                    .font(.caption)
                }
            } header: {
                Text(Date().formatted(date: .complete, time: .shortened))
                    .textCase(nil)
            }
            
            Section {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.title2)
                        .foregroundStyle(.blue)
                    VStack(alignment: .leading) {
                        Text("Cupertino, CA")
                            .font(.headline)
                        Text("Taken locally")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}

// Helper to init with hex if needed, or just standard Preview
#Preview {
    PhotosView()
}

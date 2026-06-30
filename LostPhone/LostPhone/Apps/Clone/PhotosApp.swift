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

@MainActor
class PhotoLibrary: ObservableObject {
    @Published var galleryPhotos: [GalleryPhoto] = []
    @Published var isLoading = false

    init(galleryPhotos: [GalleryPhoto] = []) {
        self.galleryPhotos = galleryPhotos
    }

    var isEmpty: Bool { galleryPhotos.isEmpty }
    var totalCount: Int { galleryPhotos.count }
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
    @State private var selectedSegment = 2
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    if library.isEmpty {
                        ContentUnavailableView(
                            "Aucune photo",
                            systemImage: "photo.on.rectangle.angled",
                            description: Text("Ajoutez des photos dans lpsp.json → content.apps.Photos")
                        )
                        .padding(.top, 80)
                    } else {
                        LazyVGrid(columns: gridColumns, spacing: 1) {
                            ForEach(library.galleryPhotos) { photo in
                                NavigationLink(destination: GalleryPhotoDetailView(photo: photo)) {
                                    GalleryPhotoTile(photo: photo)
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
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
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
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: photo.caption.lowercased().contains("capture") ? "iphone" : "photo.artframe")
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "heart")
                }
                .disabled(readOnly)
            }
        }
    }
}

#Preview {
    PhotosView()
}

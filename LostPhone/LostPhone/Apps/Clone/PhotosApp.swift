import SwiftUI
import Combine

// MARK: - Models

struct GalleryPhoto: Identifiable, Hashable {
    let id: String
    let caption: String
    let place: String?
    let capturedAt: Date?
    let capturedLabel: String?
    let assetSource: String?
    let isScreenshot: Bool
    let album: String?
}

class PhotoLibrary: ObservableObject {
    @Published var galleryPhotos: [GalleryPhoto] = []
    @Published var albums: [String] = []
    @Published var isLoading = false

    init(galleryPhotos: [GalleryPhoto] = [], albums: [String] = ["Récents"]) {
        self.galleryPhotos = galleryPhotos
        self.albums = albums.isEmpty ? ["Récents"] : albums
    }

    var isEmpty: Bool { galleryPhotos.isEmpty }
    var totalCount: Int { galleryPhotos.count }

    func photos(in album: String?) -> [GalleryPhoto] {
        guard let album, album != "Récents" else { return galleryPhotos }
        return galleryPhotos.filter { $0.album == album }
    }
}

// MARK: - Main Tab View

struct PhotosView: View {
    @StateObject private var library: PhotoLibrary
    @Environment(\.lpspStoryId) private var storyId

    init(library: PhotoLibrary = PhotoLibrary()) {
        _library = StateObject(wrappedValue: library)
    }

    var body: some View {
        TabView {
            LibraryView(library: library, storyId: storyId)
                .tabItem {
                    Label("Bibliothèque", systemImage: "photo.fill.on.rectangle.fill")
                }

            PhotosForYouView(library: library, storyId: storyId)
                .tabItem {
                    Label("Pour vous", systemImage: "heart.text.square.fill")
                }

            PhotosAlbumsView(library: library, storyId: storyId)
                .tabItem {
                    Label("Albums", systemImage: "rectangle.stack.fill")
                }

            PhotosSearchView(library: library, storyId: storyId)
                .tabItem {
                    Label("Rechercher", systemImage: "magnifyingglass")
                }
        }
    }
}

// MARK: - Library Grid View

struct LibraryView: View {
    @ObservedObject var library: PhotoLibrary
    var storyId: String?
    @State private var gridColumns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 3)
    @State private var selectedSegment = 2
    @Environment(\.lpspReadOnly) private var readOnly

    private var displayedPhotos: [GalleryPhoto] {
        let calendar = Calendar.current
        switch selectedSegment {
        case 0:
            let year = calendar.component(.year, from: Date())
            return library.galleryPhotos.filter { photo in
                guard let date = photo.capturedAt else { return false }
                return calendar.component(.year, from: date) == year
            }
        case 1:
            return library.galleryPhotos.filter { photo in
                guard let date = photo.capturedAt else { return false }
                return calendar.isDate(date, equalTo: Date(), toGranularity: .month)
            }
        default:
            return library.galleryPhotos
        }
    }

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
                            ForEach(displayedPhotos) { photo in
                                NavigationLink(destination: GalleryPhotoDetailView(photo: photo, storyId: storyId)) {
                                    GalleryPhotoTile(photo: photo, storyId: storyId)
                                }
                            }
                        }
                        .padding(.bottom, 20)

                        VStack(spacing: 5) {
                            Text("\(displayedPhotos.count) Photos")
                                .font(.system(size: 15, weight: .medium))
                            Text("Synchronisé avec iCloud à l'instant")
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
                        Text("Années").tag(0)
                        Text("Mois").tag(1)
                        Text("Tout").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 220)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sélectionner") { }
                        .fontWeight(.medium)
                        .disabled(readOnly)
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
    var storyId: String?

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            PhotoAssetView(
                source: photo.assetSource,
                storyId: storyId,
                fallbackLabel: photo.caption,
                isScreenshot: photo.isScreenshot
            )
            .aspectRatio(1, contentMode: .fill)
            .clipped()

            if photo.isScreenshot {
                Image(systemName: "camera.viewfinder")
                    .font(.system(size: 10))
                    .foregroundStyle(.white)
                    .padding(4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(4)
                    .padding(4)
            }
        }
    }
}

struct PhotoAssetView: View {
    let source: String?
    var storyId: String?
    let fallbackLabel: String
    var isScreenshot: Bool = false

    var body: some View {
        Group {
            if let uiImage = PhotoAssetResolver.uiImage(source: source, storyId: storyId) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                RoundedRectangle(cornerRadius: 0)
                    .fill(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay {
                        VStack(spacing: 4) {
                            Image(systemName: isScreenshot ? "camera.viewfinder" : "photo.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(.white.opacity(0.85))
                            Text(shortCaption)
                                .font(.system(size: 8, weight: .medium))
                                .foregroundStyle(.white.opacity(0.75))
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                                .padding(.horizontal, 4)
                        }
                    }
            }
        }
    }

    private var shortCaption: String {
        let trimmed = fallbackLabel.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.count <= 48 { return trimmed }
        return String(trimmed.prefix(45)) + "…"
    }

    private var gradientColors: [Color] {
        let hue = Double(abs(fallbackLabel.hashValue) % 360) / 360
        return [
            Color(hue: hue, saturation: 0.35, brightness: 0.5),
            Color(hue: hue, saturation: 0.45, brightness: 0.28),
        ]
    }
}

struct GalleryPhotoDetailView: View {
    let photo: GalleryPhoto
    var storyId: String?
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            PhotoAssetView(
                source: photo.assetSource,
                storyId: storyId,
                fallbackLabel: photo.caption,
                isScreenshot: photo.isScreenshot
            )
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 8)

            VStack {
                Spacer()
                VStack(spacing: 8) {
                    Text(photo.caption)
                        .font(.subheadline)
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
                }
                .padding(.bottom, 32)
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

// MARK: - For You

struct PhotosForYouView: View {
    @ObservedObject var library: PhotoLibrary
    var storyId: String?

    var body: some View {
        NavigationStack {
            ScrollView {
                if library.isEmpty {
                    ContentUnavailableView(
                        "For You",
                        systemImage: "heart.text.square",
                        description: Text("Aucun souvenir pour l'instant")
                    )
                    .padding(.top, 80)
                } else {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Souvenirs")
                                .font(.system(size: 22, weight: .bold))
                                .padding(.horizontal, 16)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(Array(library.galleryPhotos.prefix(5))) { photo in
                                        NavigationLink {
                                            GalleryPhotoDetailView(photo: photo, storyId: storyId)
                                        } label: {
                                            PhotosMemoryCard(photo: photo, storyId: storyId)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Sélection")
                                .font(.system(size: 22, weight: .bold))
                                .padding(.horizontal, 16)

                            LazyVGrid(
                                columns: [GridItem(.flexible()), GridItem(.flexible())],
                                spacing: 4
                            ) {
                                ForEach(Array(library.galleryPhotos.prefix(6))) { photo in
                                    NavigationLink {
                                        GalleryPhotoDetailView(photo: photo, storyId: storyId)
                                    } label: {
                                        GalleryPhotoTile(photo: photo, storyId: storyId)
                                            .aspectRatio(1, contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("Pour vous")
        }
    }
}

struct PhotosMemoryCard: View {
    let photo: GalleryPhoto
    var storyId: String?

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            PhotoAssetView(
                source: photo.assetSource,
                storyId: storyId,
                fallbackLabel: photo.caption,
                isScreenshot: photo.isScreenshot
            )
            .frame(width: 200, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(photo.place ?? shortTitle)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .padding(12)
                .shadow(radius: 4)
        }
    }

    private var shortTitle: String {
        let words = photo.caption.split(separator: " ").prefix(4)
        return words.joined(separator: " ")
    }
}

// MARK: - Albums

struct PhotosAlbumsView: View {
    @ObservedObject var library: PhotoLibrary
    var storyId: String?
    @State private var selectedAlbum: PhotosAlbumSheetItem?

    var body: some View {
        NavigationStack {
            ScrollView {
                if library.isEmpty {
                    ContentUnavailableView(
                        "Albums",
                        systemImage: "rectangle.stack",
                        description: Text("Aucun album")
                    )
                    .padding(.top, 80)
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        PhotosAlbumCard(
                            title: "Récents",
                            count: library.totalCount,
                            cover: library.galleryPhotos.first,
                            storyId: storyId
                        )
                        .onTapGesture {
                            selectedAlbum = PhotosAlbumSheetItem(name: "Récents")
                        }

                        ForEach(displayAlbums, id: \.self) { name in
                            let items = library.photos(in: name)
                            PhotosAlbumCard(
                                title: name,
                                count: items.count,
                                cover: items.first ?? library.galleryPhotos.first,
                                storyId: storyId
                            )
                            .onTapGesture {
                                selectedAlbum = PhotosAlbumSheetItem(name: name)
                            }
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Albums")
            .sheet(item: $selectedAlbum) { item in
                PhotosAlbumDetailView(
                    title: item.name,
                    photos: item.name == "Récents" ? library.galleryPhotos : library.photos(in: item.name),
                    storyId: storyId
                )
            }
        }
    }

    private var displayAlbums: [String] {
        library.albums.filter { $0 != "Récents" }
    }
}

private struct PhotosAlbumSheetItem: Identifiable {
    let name: String
    var id: String { name }
}

struct PhotosAlbumCard: View {
    let title: String
    let count: Int
    let cover: GalleryPhoto?
    var storyId: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                if let cover {
                    PhotoAssetView(
                        source: cover.assetSource,
                        storyId: storyId,
                        fallbackLabel: cover.caption,
                        isScreenshot: cover.isScreenshot
                    )
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.35))
                }
            }
            .aspectRatio(1, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(title)
                .font(.system(size: 15, weight: .medium))

            Text("\(count) photo\(count > 1 ? "s" : "")")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
        }
    }
}

struct PhotosAlbumDetailView: View {
    let title: String
    let photos: [GalleryPhoto]
    var storyId: String?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 3),
                    spacing: 2
                ) {
                    ForEach(photos) { photo in
                        NavigationLink {
                            GalleryPhotoDetailView(photo: photo, storyId: storyId)
                        } label: {
                            GalleryPhotoTile(photo: photo, storyId: storyId)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fermer") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Search

struct PhotosSearchView: View {
    @ObservedObject var library: PhotoLibrary
    var storyId: String?
    @State private var searchText = ""

    private var filteredPhotos: [GalleryPhoto] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return [] }
        return library.galleryPhotos.filter { photo in
            photo.caption.lowercased().contains(query)
                || (photo.place?.lowercased().contains(query) ?? false)
                || (photo.album?.lowercased().contains(query) ?? false)
        }
    }

    private var suggestions: [String] {
        var items: [String] = []
        for photo in library.galleryPhotos {
            if let place = photo.place, !place.isEmpty { items.append(place) }
            if let album = photo.album, !album.isEmpty { items.append(album) }
            let words = photo.caption.split(separator: " ").prefix(3).joined(separator: " ")
            if !words.isEmpty { items.append(words) }
        }
        return Array(Set(items)).sorted().prefix(8).map { $0 }
    }

    var body: some View {
        NavigationStack {
            Group {
                if searchText.isEmpty {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            if library.isEmpty {
                                ContentUnavailableView(
                                    "Search",
                                    systemImage: "magnifyingglass",
                                    description: Text("Aucune photo à rechercher")
                                )
                                .padding(.top, 60)
                            } else {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Suggestions")
                                        .font(.headline)
                                        .padding(.horizontal, 16)
                                    ForEach(suggestions, id: \.self) { suggestion in
                                        Button {
                                            searchText = suggestion
                                        } label: {
                                            HStack {
                                                Image(systemName: "magnifyingglass")
                                                    .foregroundStyle(.secondary)
                                                Text(suggestion)
                                                    .foregroundStyle(.primary)
                                                Spacer()
                                            }
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                    }
                } else if filteredPhotos.isEmpty {
                    ContentUnavailableView(
                        "Aucun résultat",
                        systemImage: "photo.on.rectangle.angled",
                        description: Text("Essayez un autre mot-clé")
                    )
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 3),
                            spacing: 2
                        ) {
                            ForEach(filteredPhotos) { photo in
                                NavigationLink {
                                    GalleryPhotoDetailView(photo: photo, storyId: storyId)
                                } label: {
                                    GalleryPhotoTile(photo: photo, storyId: storyId)
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Rechercher")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

#Preview {
    PhotosView()
}

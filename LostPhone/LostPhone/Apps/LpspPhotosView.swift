import SwiftUI

/// Photos — UI clone zerocode117, contenu LPSP (lecture seule).
struct LpspPhotosView: View {
    let photos: [LpspPhoto]
    @State private var selected: LpspPhoto?

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 1), count: 3)

    var body: some View {
        NavigationStack {
            Group {
                if photos.isEmpty {
                    ContentUnavailableView(
                        "Photos",
                        systemImage: "photo.on.rectangle",
                        description: Text("Ajoutez des photos dans lpsp.json → content.apps.Photos")
                    )
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 1) {
                            ForEach(photos) { photo in
                                Button { selected = photo } label: {
                                    LpspPhotoTile(photo: photo)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        VStack(spacing: 5) {
                            Text("\(photos.count) Photos")
                                .font(.system(size: 15, weight: .medium))
                            Text("Bibliothèque LPSP")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 24)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("", selection: .constant(2)) {
                        Text("Years").tag(0)
                        Text("Months").tag(1)
                        Text("All").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 220)
                    .disabled(true)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Select") {}.disabled(true).fontWeight(.medium)
                }
            }
            .navigationDestination(item: $selected) { photo in
                LpspPhotoDetailView(photo: photo)
            }
        }
    }
}

struct LpspPhotoTile: View {
    let photo: LpspPhoto

    var body: some View {
        Rectangle()
            .fill(photoGradient)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                Image(systemName: "photo.fill")
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.5))
            }
    }

    private var photoGradient: LinearGradient {
        let hash = abs(photo.id.hashValue)
        let hue = Double(hash % 360) / 360.0
        return LinearGradient(
            colors: [
                Color(hue: hue, saturation: 0.35, brightness: 0.45),
                Color(hue: hue, saturation: 0.5, brightness: 0.25),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct LpspPhotoDetailView: View {
    let photo: LpspPhoto

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "photo.artframe")
                    .font(.system(size: 64))
                    .foregroundStyle(.white.opacity(0.35))
                Text(photo.description)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                if let place = photo.place {
                    Label(place, systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.55))
                }
                Text(LpspAdapters.formatShortDate(photo.date, fallback: photo.dateRaw))
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.45))
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

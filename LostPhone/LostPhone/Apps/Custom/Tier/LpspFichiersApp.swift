import SwiftUI

// Clone Apple Fichiers (Browse) — même discipline que NotesApp.

struct LpspFichiersView: View {
    let files: [LpspFileItem]
    @State private var selected: LpspFileItem?
    @State private var browsePath: String?

    var body: some View {
        NavigationStack {
            Group {
                if files.isEmpty {
                    ContentUnavailableView("Fichiers", systemImage: "folder.fill")
                } else if let browsePath {
                    folderView(path: browsePath)
                } else {
                    browseRoot
                }
            }
            .navigationTitle(browsePath == nil ? "Parcourir" : folderTitle)
            .navigationBarTitleDisplayMode(browsePath == nil ? .large : .inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        Button {} label: { Image(systemName: "ellipsis.circle") }
                        Button {} label: { Image(systemName: "magnifyingglass") }
                    }
                    .disabled(true)
                }
                if browsePath != nil {
                    ToolbarItem(placement: .topBarLeading) {
                        Button { browsePath = parent(of: browsePath!) } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                Text("Parcourir")
                            }
                        }
                    }
                }
            }
            .navigationDestination(item: $selected) { file in
                FichiersDetailView(file: file)
            }
        }
    }

    private var folderTitle: String {
        browsePath?.trimmingCharacters(in: CharacterSet(charactersIn: "/")).components(separatedBy: "/").last ?? "Dossier"
    }

    private var browseRoot: some View {
        List {
            Section {
                locationRow("clock", "Récents", "iCloud Drive et iPhone")
                locationRow("person.2", "Partagé", "Dossiers partagés")
            }

            Section {
                Button { browsePath = "iCloud Drive/" } label: {
                    locationRow("icloud.fill", "iCloud Drive", "\(count(in: "iCloud Drive/")) éléments")
                }
                .buttonStyle(.plain)
                Button { browsePath = "Sur mon iPhone/" } label: {
                    locationRow("iphone", "Sur mon iPhone", "\(count(in: "Sur mon iPhone/")) éléments")
                }
                .buttonStyle(.plain)
            }

            if !deleted.isEmpty {
                Section {
                    Button { browsePath = "Récemment supprimés/" } label: {
                        locationRow("trash", "Récemment supprimés", "\(deleted.count) éléments")
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private func locationRow(_ icon: String, _ title: String, _ subtitle: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }

    private func folderView(path: String) -> some View {
        List {
            ForEach(subfolders(in: path), id: \.self) { folder in
                Button { browsePath = path + folder + "/" } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "folder.fill")
                            .foregroundStyle(.blue)
                            .font(.title3)
                        Text(folder)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.tertiary)
                    }
                }
                .buttonStyle(.plain)
            }
            ForEach(filesAt(path)) { file in
                Button { selected = file } label: {
                    FichiersRow(file: file)
                }
                .buttonStyle(.plain)
            }
        }
        .listStyle(.insetGrouped)
    }

    private var deleted: [LpspFileItem] { files.filter(\.isDeleted) }

    private func count(in location: String) -> Int {
        files.filter { !$0.isDeleted && $0.path.hasPrefix(location) }.count
    }

    private func subfolders(in path: String) -> [String] {
        var names = Set<String>()
        for f in files where !f.isDeleted && f.path.hasPrefix(path) {
            let rest = String(f.path.dropFirst(path.count))
            if let first = rest.split(separator: "/").first, !first.isEmpty {
                names.insert(String(first))
            }
        }
        return names.sorted()
    }

    private func filesAt(_ path: String) -> [LpspFileItem] {
        if path == "Récemment supprimés/" { return deleted }
        return files.filter { !$0.isDeleted && $0.path == path }
    }

    private func parent(of path: String) -> String? {
        let parts = path.trimmingCharacters(in: CharacterSet(charactersIn: "/")).split(separator: "/").map(String.init)
        guard parts.count > 1 else { return nil }
        return parts.dropLast().joined(separator: "/") + "/"
    }
}

private struct FichiersRow: View {
    let file: LpspFileItem

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(file.name)
                    .font(.body)
                    .lineLimit(1)
                if !file.size.isEmpty {
                    Text(file.size)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
    }

    private var icon: String {
        switch file.type.uppercased() {
        case "PDF": return "doc.fill"
        case "JPG", "JPEG", "PNG": return "photo.fill"
        case "M4A": return "waveform"
        default: return "doc.text.fill"
        }
    }

    private var color: Color {
        switch file.type.uppercased() {
        case "PDF": return .red
        case "JPG", "JPEG", "PNG": return .purple
        default: return .blue
        }
    }
}

private struct FichiersDetailView: View {
    let file: LpspFileItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(uiColor: .secondarySystemBackground))
                    .frame(height: 220)
                    .overlay {
                        VStack(spacing: 8) {
                            Image(systemName: "doc.richtext.fill")
                                .font(.system(size: 48))
                                .foregroundStyle(.secondary)
                            Text(file.type)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.secondary)
                        }
                    }
                Text(file.name)
                    .font(.title3.weight(.semibold))
                if file.isDeleted {
                    Label("Récemment supprimé", systemImage: "trash")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }
                if !file.modifiedRaw.isEmpty {
                    Text(LpspThirdPartyFormat.frenchDateRaw(file.modifiedRaw))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Divider()
                Text(file.description)
                    .font(.body)
            }
            .padding(20)
        }
        .navigationTitle(file.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

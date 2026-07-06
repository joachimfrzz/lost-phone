import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/dropbox
// Meliwat/awesome-ios-design-md/productivity/dropbox/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDropboxView: View {
    var body: some View {
        LpspDropboxShowroomRoot(store: LpspDropboxStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspDropboxFonts {
    static let dbxTitleLarge  = Font.system(size: 28, weight: .regular)
    static let dbxSection     = Font.system(size: 22, weight: .regular)
    static let dbxSheetTitle  = Font.system(size: 20, weight: .regular)
    static let dbxCardTitle   = Font.system(size: 17, weight: .regular)
    static let dbxRowName     = Font.system(size: 16, weight: .regular)
    static let dbxBody        = Font.system(size: 15, weight: .regular)
    static let dbxMeta        = Font.system(size: 14, weight: .regular)
    static let dbxCaption     = Font.system(size: 12, weight: .regular)
    static let dbxLabelUpper  = Font.system(size: 11, weight: .regular)
    static let dbxButton      = Font.system(size: 16, weight: .regular)
    static let dbxTab         = Font.system(size: 11, weight: .regular)
    static func dbx(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspDropboxTokens {
    // MARK: - Canvas & Surfaces (Light)
    static let dbxCanvas     = Color.white                                   // #FFFFFF
    static let dbxSurface    = Color(red: 0.969, green: 0.961, blue: 0.949)   // #F7F5F2
    static let dbxDivider    = Color(red: 0.902, green: 0.882, blue: 0.855)   // #E6E1DA

    // MARK: - Text
    static let dbxTextPrimary   = Color(red: 0.118, green: 0.098, blue: 0.098) // #1E1919
    static let dbxTextSecondary = Color(red: 0.435, green: 0.416, blue: 0.396) // #6F6A65
    static let dbxTextTertiary  = Color(red: 0.639, green: 0.620, blue: 0.596) // #A39E98

    // MARK: - Brand
    static let dbxBlue        = Color(red: 0.0,   green: 0.380, blue: 1.0)     // #0061FF
    static let dbxBluePressed = Color(red: 0.0,   green: 0.314, blue: 0.816)   // #0050D0
    static let dbxBlueTint    = Color(red: 0.902, green: 0.941, blue: 1.0)     // #E6F0FF

    // MARK: - Dark
    static let dbxDarkCanvas  = Color(red: 0.118, green: 0.098, blue: 0.098)   // #1E1919
    static let dbxDarkSurface = Color(red: 0.165, green: 0.141, blue: 0.141)   // #2A2424
    static let dbxDarkDivider = Color(red: 0.227, green: 0.200, blue: 0.192)   // #3A3331
    static let dbxDarkBlue    = Color(red: 0.239, green: 0.545, blue: 1.0)     // #3D8BFF

    // MARK: - File-Type Icons
    static let dbxPdfRed    = Color(red: 0.980, green: 0.333, blue: 0.118)     // #FA551E
    static let dbxSheetGreen = Color(red: 0.102, green: 0.529, blue: 0.329)    // #1A8754
    static let dbxImageTeal = Color(red: 0.0,   green: 0.698, blue: 0.663)     // #00B2A9
    static let dbxFolderSlate = Color(red: 0.549, green: 0.592, blue: 0.659)   // #8C97A8

    // MARK: - Semantic
    static let dbxSuccess = Color(red: 0.102, green: 0.529, blue: 0.329)       // #1A8754
    static let dbxWarning = Color(red: 1.0,   green: 0.686, blue: 0.0)         // #FFAF00
    static let dbxError   = Color(red: 0.820, green: 0.094, blue: 0.043)       // #D1180B
}



// If Sharp Grotesk / Inter is unavailable, fall back to the system grotesque:


// Tabular figures for file sizes / dates / counts
fileprivate extension View {
    func dbxTabularNumbers() -> some View { self.monospacedDigit() }
}

fileprivate struct LpspDropboxDbxPrimaryButton: View {
    let title: String
    var enabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspDropboxFonts.dbxButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspDropboxTokens.dbxBlue.opacity(enabled ? 1 : 0.4))
                )
        }
        .disabled(!enabled)
        .buttonStyle(LpspDropboxDbxPressableStyle(pressedScale: 0.98))
    }
}

fileprivate struct LpspDropboxDbxPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspDropboxDbxUploadFAB: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(LpspDropboxTokens.dbxBlue))
                .shadow(color: LpspDropboxTokens.dbxBlue.opacity(0.32), radius: 20, y: 8)
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: UUID())
        .buttonStyle(LpspDropboxDbxPressableStyle(pressedScale: 0.92))
        .padding(.trailing, 16)
        .padding(.bottom, 16) // sits above the tab bar
    }
}

fileprivate enum LpspDropboxDbxFileKind { case pdf, doc, sheet, image, folder }

fileprivate struct LpspDropboxDbxFileRow: View {
    let name: String
    let meta: String
    let kind: LpspDropboxDbxFileKind
    var isSelected: Bool = false
    let onTap: () -> Void

    private var iconColor: Color {
        switch kind {
        case .pdf:    return LpspDropboxTokens.dbxPdfRed
        case .doc:    return LpspDropboxTokens.dbxBlue
        case .sheet:  return LpspDropboxTokens.dbxSheetGreen
        case .image:  return LpspDropboxTokens.dbxImageTeal
        case .folder: return LpspDropboxTokens.dbxFolderSlate
        }
    }
    private var iconSymbol: String {
        switch kind {
        case .pdf:    return "doc.richtext.fill"
        case .doc:    return "doc.text.fill"
        case .sheet:  return "tablecells.fill"
        case .image:  return "photo.fill"
        case .folder: return "folder.fill"
        }
    }

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(LpspDropboxTokens.dbxBlue)
                        .frame(width: 40, height: 40)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(iconColor.opacity(0.14))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: iconSymbol)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(iconColor)
                        )
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(LpspDropboxFonts.dbxRowName)
                        .foregroundStyle(LpspDropboxTokens.dbxTextPrimary)
                        .lineLimit(1)
                    Text(meta)
                        .font(LpspDropboxFonts.dbxMeta)
                        .foregroundStyle(LpspDropboxTokens.dbxTextSecondary)
                        .dbxTabularNumbers()
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: kind == .folder ? "chevron.right" : "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(LpspDropboxTokens.dbxTextSecondary)
            }
            .padding(.horizontal, 16)
            .frame(height: 60)
            .background(isSelected ? LpspDropboxTokens.dbxBlueTint : LpspDropboxTokens.dbxCanvas)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspDropboxDbxRecentCard: View {
    let name: String
    let meta: String
    let thumbnail: Image?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 4).fill(LpspDropboxTokens.dbxSurface)
                if let thumbnail {
                    thumbnail.resizable().aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } else {
                    Image(systemName: "doc.fill")
                        .font(.system(size: 28)).foregroundStyle(LpspDropboxTokens.dbxBlue)
                }
            }
            .frame(width: 140, height: 96)

            VStack(alignment: .leading, spacing: 2) {
                Text(name).font(LpspDropboxFonts.dbxCardTitle)
                    .foregroundStyle(LpspDropboxTokens.dbxTextPrimary).lineLimit(2)
                Text(meta).font(LpspDropboxFonts.dbxCaption)
                    .foregroundStyle(LpspDropboxTokens.dbxTextSecondary).dbxTabularNumbers()
            }
        }
        .padding(12)
        .frame(width: 140, height: 160, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LpspDropboxTokens.dbxCanvas)
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(LpspDropboxTokens.dbxDivider, lineWidth: 1))
        )
    }
}

fileprivate struct LpspDropboxDbxUploadBar: View {
    let label: String
    let progress: Double // 0...1, real byte ratio
    var done: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label).font(LpspDropboxFonts.dbxMeta.weight(.semibold))
                    .foregroundStyle(LpspDropboxTokens.dbxTextPrimary)
                Spacer()
                if done {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(LpspDropboxTokens.dbxSuccess)
                }
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(LpspDropboxTokens.dbxDivider)
                    Capsule().fill(LpspDropboxTokens.dbxBlue)
                        .frame(width: geo.size.width * progress)
                        .animation(.linear(duration: 0.2), value: progress)
                }
            }
            .frame(height: 3)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(LpspDropboxTokens.dbxCanvas)
    }
}


fileprivate struct LpspDropboxDbxPhotoGrid: View {
    let photos: [Image]
    @State private var selected: Set<Int> = []

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(photos.indices, id: \.self) { i in
                    photos[i]
                        .resizable().aspectRatio(1, contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .overlay(alignment: .topTrailing) {
                            if selected.contains(i) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(LpspDropboxTokens.dbxBlue, .white)
                                    .padding(6)
                            }
                        }
                        .overlay(
                            Rectangle().strokeBorder(
                                selected.contains(i) ? LpspDropboxTokens.dbxBlue : .clear, lineWidth: 4)
                        )
                        .onLongPressGesture { toggle(i) }
                }
            }
        }
    }
    private func toggle(_ i: Int) {
        if selected.contains(i) { selected.remove(i) } else { selected.insert(i) }
    }
}

// MARK: - Données & état (showroom Spectr)

private enum LpspDropboxShowroomTab: String, CaseIterable, Identifiable {
    case home
    case files
    case photos
    case offline
    case account

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .files: return "Files"
        case .photos: return "Photos"
        case .offline: return "Offline"
        case .account: return "Account"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house"
        case .files: return "folder"
        case .photos: return "photo.on.rectangle"
        case .offline: return "arrow.down.circle"
        case .account: return "person.crop.circle"
        }
    }
}

fileprivate struct LpspDropboxFileItem: Identifiable, Equatable {
    let id: String
    let name: String
    let meta: String
    let recentMeta: String?
    let kind: LpspDropboxDbxFileKind
    var isSelected: Bool
    var isOffline: Bool
}

private enum LpspDropboxShowroomData {
    static let files: [LpspDropboxFileItem] = [
        .init(
            id: "q3-report",
            name: "Q3 Report.pdf",
            meta: "2.4 MB · Modified Apr 12",
            recentMeta: "2.4 MB · Today",
            kind: .pdf,
            isSelected: true,
            isOffline: true
        ),
        .init(
            id: "design-assets",
            name: "Design Assets",
            meta: "28 items",
            recentMeta: nil,
            kind: .folder,
            isSelected: false,
            isOffline: false
        ),
        .init(
            id: "project-brief",
            name: "Project Brief.paper",
            meta: "16 KB · Modified Apr 10",
            recentMeta: nil,
            kind: .doc,
            isSelected: false,
            isOffline: false
        ),
        .init(
            id: "mockup-v4",
            name: "Mockup_v4.png",
            meta: "880 KB · Modified Apr 8",
            recentMeta: "880 KB · Apr 14",
            kind: .image,
            isSelected: false,
            isOffline: true
        ),
        .init(
            id: "budget-q3",
            name: "Budget Q3.xlsx",
            meta: "44 KB · Modified Apr 6",
            recentMeta: "44 KB · Apr 9",
            kind: .sheet,
            isSelected: false,
            isOffline: false
        ),
    ]

    static let recentIDs = ["q3-report", "mockup-v4", "budget-q3"]

    static let photoNames = ["Mockup_v4.png", "Hero_shot.jpg", "Wireframe_02.png", "Palette.png", "Launch_day.jpg", "Team_photo.png"]
}

@MainActor
fileprivate final class LpspDropboxStore: ObservableObject {
    @Published var selectedTab: LpspDropboxShowroomTab = .files
    @Published var files: [LpspDropboxFileItem]
    @Published var uploadProgress: Double = 0.375
    @Published var uploadLabel = "Uploading 3 of 8 · 4.2 MB"
    @Published var isUploading = true
    @Published var searchQuery = ""
    @Published var selectedPhotoIndices: Set<Int> = []

    init() {
        files = LpspDropboxShowroomData.files
    }

    var recentFiles: [LpspDropboxFileItem] {
        LpspDropboxShowroomData.recentIDs.compactMap { id in
            files.first { $0.id == id }
        }
    }

    var offlineFiles: [LpspDropboxFileItem] {
        files.filter(\.isOffline)
    }

    var filteredFiles: [LpspDropboxFileItem] {
        guard !searchQuery.isEmpty else { return files }
        return files.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
    }

    func selectFile(_ id: String) {
        files = files.map { item in
            var copy = item
            copy.isSelected = item.id == id
            return copy
        }
    }

    func toggleOffline(_ id: String) {
        files = files.map { item in
            guard item.id == id else { return item }
            var copy = item
            copy.isOffline.toggle()
            return copy
        }
    }

    func startUpload() {
        isUploading = true
        uploadProgress = min(uploadProgress + 0.125, 1.0)
        let completed = Int(uploadProgress * 8)
        uploadLabel = completed >= 8
            ? "Upload complete · 8 of 8"
            : "Uploading \(completed) of 8 · 4.2 MB"
        if completed >= 8 {
            isUploading = false
        }
    }

    func togglePhotoSelection(_ index: Int) {
        if selectedPhotoIndices.contains(index) {
            selectedPhotoIndices.remove(index)
        } else {
            selectedPhotoIndices.insert(index)
        }
    }
}

// MARK: - Écrans showroom

private struct LpspDropboxShowroomRoot: View {
    @ObservedObject var store: LpspDropboxStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspDropboxShowroomTab.allCases) { tab in
                LpspDropboxShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .tint(LpspDropboxTokens.dbxBlue)
        .preferredColorScheme(.light)
    }
}

private struct LpspDropboxShowroomTabScreen: View {
    @ObservedObject var store: LpspDropboxStore
    let tab: LpspDropboxShowroomTab

    var body: some View {
        NavigationStack {
            Group {
                switch tab {
                case .home:
                    LpspDropboxHomeTabScreen(store: store)
                case .files:
                    LpspDropboxFilesTabScreen(store: store)
                case .photos:
                    LpspDropboxPhotosTabScreen(store: store)
                case .offline:
                    LpspDropboxOfflineTabScreen(store: store)
                case .account:
                    LpspDropboxAccountTabScreen()
                }
            }
            .background(LpspDropboxTokens.dbxCanvas.ignoresSafeArea())
        }
    }
}

private struct LpspDropboxFilesTabScreen: View {
    @ObservedObject var store: LpspDropboxStore

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    LpspDropboxFilesNavBar(searchQuery: $store.searchQuery)

                    Text("Recents")
                        .font(LpspDropboxFonts.dbxLabelUpper.weight(.semibold))
                        .foregroundStyle(LpspDropboxTokens.dbxTextSecondary)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 8)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(store.recentFiles) { file in
                                Button {
                                    store.selectFile(file.id)
                                } label: {
                                    LpspDropboxDbxRecentCard(
                                        name: file.name,
                                        meta: file.recentMeta ?? file.meta,
                                        thumbnail: nil
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    Text("All files")
                        .font(LpspDropboxFonts.dbxLabelUpper.weight(.semibold))
                        .foregroundStyle(LpspDropboxTokens.dbxTextSecondary)
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        .padding(.bottom, 4)

                    VStack(spacing: 0) {
                        ForEach(store.filteredFiles) { file in
                            LpspDropboxDbxFileRow(
                                name: file.name,
                                meta: file.meta,
                                kind: file.kind,
                                isSelected: file.isSelected,
                                onTap: { store.selectFile(file.id) }
                            )

                            if file.id != store.filteredFiles.last?.id {
                                Divider()
                                    .background(LpspDropboxTokens.dbxDivider)
                                    .padding(.leading, 68)
                            }
                        }
                    }
                    .padding(.bottom, store.isUploading ? 88 : 72)
                }
            }

            if store.isUploading {
                VStack {
                    Spacer()
                    LpspDropboxDbxUploadBar(
                        label: store.uploadLabel,
                        progress: store.uploadProgress,
                        done: store.uploadProgress >= 1.0
                    )
                }
            }

            LpspDropboxDbxUploadFAB {
                store.startUpload()
            }
        }
        .navigationBarHidden(true)
    }
}

private struct LpspDropboxFilesNavBar: View {
    @Binding var searchQuery: String

    var body: some View {
        HStack {
            Text("Files")
                .font(LpspDropboxFonts.dbxTitleLarge.weight(.bold))
                .foregroundStyle(LpspDropboxTokens.dbxTextPrimary)

            Spacer()

            Button {
                searchQuery = searchQuery.isEmpty ? "Q3" : ""
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(LpspDropboxTokens.dbxTextPrimary)
            }

            Button {} label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(LpspDropboxTokens.dbxTextPrimary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}

private struct LpspDropboxHomeTabScreen: View {
    @ObservedObject var store: LpspDropboxStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Good afternoon")
                    .font(LpspDropboxFonts.dbxSection.weight(.semibold))
                    .foregroundStyle(LpspDropboxTokens.dbxTextPrimary)

                Text("Jump back into your recent work")
                    .font(LpspDropboxFonts.dbxBody)
                    .foregroundStyle(LpspDropboxTokens.dbxTextSecondary)

                ForEach(store.recentFiles.prefix(2)) { file in
                    LpspDropboxDbxFileRow(
                        name: file.name,
                        meta: file.recentMeta ?? file.meta,
                        kind: file.kind,
                        isSelected: false,
                        onTap: {
                            store.selectFile(file.id)
                            store.selectedTab = .files
                        }
                    )
                }

                LpspDropboxDbxPrimaryButton(title: "Open Files") {
                    store.selectedTab = .files
                }
            }
            .padding(16)
        }
        .navigationTitle("Home")
    }
}

private struct LpspDropboxPhotosTabScreen: View {
    @ObservedObject var store: LpspDropboxStore

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(LpspDropboxShowroomData.photoNames.indices, id: \.self) { index in
                    Button {
                        store.togglePhotoSelection(index)
                    } label: {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        LpspDropboxTokens.dbxImageTeal.opacity(0.35),
                                        LpspDropboxTokens.dbxSurface,
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .aspectRatio(1, contentMode: .fill)
                            .overlay(alignment: .topTrailing) {
                                if store.selectedPhotoIndices.contains(index) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(LpspDropboxTokens.dbxBlue, .white)
                                        .padding(6)
                                }
                            }
                            .overlay(
                                Rectangle()
                                    .strokeBorder(
                                        store.selectedPhotoIndices.contains(index)
                                            ? LpspDropboxTokens.dbxBlue
                                            : .clear,
                                        lineWidth: 4
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Photos")
    }
}

private struct LpspDropboxOfflineTabScreen: View {
    @ObservedObject var store: LpspDropboxStore

    var body: some View {
        List {
            ForEach(store.offlineFiles) { file in
                LpspDropboxDbxFileRow(
                    name: file.name,
                    meta: file.meta,
                    kind: file.kind,
                    isSelected: file.isSelected,
                    onTap: { store.selectFile(file.id) }
                )
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Offline")
    }
}

private struct LpspDropboxAccountTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Circle()
                    .fill(LpspDropboxTokens.dbxBlueTint)
                    .frame(width: 84, height: 84)
                    .overlay {
                        Text("Y")
                            .font(.title.weight(.bold))
                            .foregroundStyle(LpspDropboxTokens.dbxBlue)
                    }

                Text("your.name@email.com")
                    .font(LpspDropboxFonts.dbxCardTitle.weight(.semibold))
                    .foregroundStyle(LpspDropboxTokens.dbxTextPrimary)

                Text("Dropbox Plus · 2.1 GB of 2 TB used")
                    .font(LpspDropboxFonts.dbxMeta)
                    .foregroundStyle(LpspDropboxTokens.dbxTextSecondary)

                LpspDropboxDbxPrimaryButton(title: "Manage account") {}
                    .padding(.horizontal, 16)
            }
            .padding(.vertical, 24)
        }
        .navigationTitle("Account")
    }
}



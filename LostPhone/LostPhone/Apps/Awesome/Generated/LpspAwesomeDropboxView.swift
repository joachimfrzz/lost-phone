import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/productivity/dropbox/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/dropbox
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDropboxView: View {
    var body: some View {
        LpspDropboxShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
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
}

// If Sharp Grotesk / Inter is unavailable, fall back to the system grotesque:
private enum LpspDropboxFonts {
    static func dbx(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

// Tabular figures for file sizes / dates / counts
extension View {
    func dbxTabularNumbers() -> some View { self.monospacedDigit() }
}

private struct LpspDropboxDbxPrimaryButton: View {
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

private struct LpspDropboxDbxPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

private struct LpspDropboxDbxUploadFAB: View {
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

private enum LpspDropboxDbxFileKind { case pdf, doc, sheet, image, folder }

private struct LpspDropboxDbxFileRow: View {
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

private struct LpspDropboxDbxRecentCard: View {
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

private struct LpspDropboxDbxUploadBar: View {
    let label: String
    let progress: Double // 0...1, real byte ratio
    var done: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label).font(.dbxMeta.weight(.semibold))
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

private struct LpspDropboxDbxRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(LpspDropboxTokens.dbxCanvas).withAlphaComponent(0.94)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView().tabItem    { Label("Home",    systemImage: "house") }
            FilesView().tabItem   { Label("Files",   systemImage: "folder") }
            PhotosView().tabItem  { Label("Photos",  systemImage: "photo.on.rectangle") }
            OfflineView().tabItem { Label("Offline", systemImage: "arrow.down.circle") }
            AccountView().tabItem { Label("Account", systemImage: "person.crop.circle") }
        }
        .tint(LpspDropboxTokens.dbxBlue) // active = Dropbox Blue
    }
}

private struct LpspDropboxDbxPhotoGrid: View {
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

// MARK: - Écrans showroom

private struct LpspDropboxShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspDropboxGenericTabScreen(title: "Offline", tabIndex: 0)
                .tabItem { Label("Offline", systemImage: "arrow.down.circle") }
                .tag(0)
            LpspDropboxGenericTabScreen(title: "Account", tabIndex: 1)
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
                .tag(1)
        }
        .tint(LpspDropboxTokens.dbxSheetGreen)
        
    }
}


private struct LpspDropboxGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspDropboxTokens.dbxSheetGreen.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspDropboxTokens.dbxSheetGreen))
                    VStack(alignment: .leading) {
                        Text("\(title) \(i + 1)").font(.system(size: 17, weight: .semibold))
                        Text("Contenu démo").font(.system(size: 14)).foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}


private struct LpspDropboxMessagingTabScreen: View {
    let title: String
    var body: some View { LpspDropboxGenericTabScreen(title: title, tabIndex: 0) }
}



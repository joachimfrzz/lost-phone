import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/dropbox
// Meliwat/awesome-ios-design-md/productivity/dropbox/DESIGN-swiftui.md
struct LpspAwesomeFichiersView: View {
    var files: [LpspFileItem]?

    var body: some View {
        let storyFiles = files?.isEmpty == false ? files : nil
        LpspFichiersShowroomRoot(
            store: LpspFichiersStore(
                roots: storyFiles.map { LpspFichiersStore.roots(from: $0) } ?? LpspFichiersShowroomData.roots,
                deleted: storyFiles.map { LpspFichiersStore.deleted(from: $0) } ?? LpspFichiersShowroomData.deleted
            ),
            isStoryMode: storyFiles != nil
        )
    }
}

// MARK: - Tokens & composants

private enum LpspFichiersFonts {
    static let titleLarge  = Font.system(size: 28, weight: .semibold)
    static let section     = Font.system(size: 22, weight: .semibold)
    static let rowTitle    = Font.system(size: 16, weight: .medium)
    static let body        = Font.system(size: 15, weight: .regular)
    static let meta        = Font.system(size: 14, weight: .regular)
    static let caption     = Font.system(size: 12, weight: .regular)
    static let tab         = Font.system(size: 10, weight: .regular)
    static let button      = Font.system(size: 16, weight: .semibold)
}

private enum LpspFichiersTokens {
    static let canvas       = Color.white
    static let surface      = Color(red: 0.969, green: 0.961, blue: 0.949)
    static let divider      = Color(red: 0.902, green: 0.882, blue: 0.855)
    static let textPrimary  = Color(red: 0.118, green: 0.098, blue: 0.098)
    static let textSecondary = Color(red: 0.435, green: 0.416, blue: 0.396)
    static let blue         = Color(red: 0.0, green: 0.380, blue: 1.0)
    static let blueTint     = Color(red: 0.902, green: 0.941, blue: 1.0)
    static let pdfRed       = Color(red: 0.980, green: 0.333, blue: 0.118)
    static let sheetGreen   = Color(red: 0.102, green: 0.529, blue: 0.329)
    static let imageTeal    = Color(red: 0.0, green: 0.698, blue: 0.663)
    static let folderSlate  = Color(red: 0.549, green: 0.592, blue: 0.659)
    static let audioPurple  = Color(red: 0.576, green: 0.361, blue: 0.878)
    static let success      = Color(red: 0.102, green: 0.529, blue: 0.329)
    static let warning      = Color(red: 1.0, green: 0.686, blue: 0.0)
}

fileprivate struct LpspFichiersPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate extension View {
    func fichiersTabularNumbers() -> some View { monospacedDigit() }
}

fileprivate enum LpspFichiersFileKind: Hashable {
    case pdf, doc, sheet, image, folder, audio, archive

    var icon: String {
        switch self {
        case .pdf: return "doc.richtext.fill"
        case .doc: return "doc.text.fill"
        case .sheet: return "tablecells.fill"
        case .image: return "photo.fill"
        case .folder: return "folder.fill"
        case .audio: return "waveform"
        case .archive: return "doc.zipper"
        }
    }

    var color: Color {
        switch self {
        case .pdf: return LpspFichiersTokens.pdfRed
        case .doc: return LpspFichiersTokens.blue
        case .sheet: return LpspFichiersTokens.sheetGreen
        case .image: return LpspFichiersTokens.imageTeal
        case .folder: return LpspFichiersTokens.folderSlate
        case .audio: return LpspFichiersTokens.audioPurple
        case .archive: return LpspFichiersTokens.folderSlate
        }
    }

    static func from(type: String, isFolder: Bool) -> LpspFichiersFileKind {
        if isFolder { return .folder }
        let upper = type.uppercased()
        if upper.contains("PDF") { return .pdf }
        if upper.contains("PNG") || upper.contains("JPEG") || upper.contains("JPG") { return .image }
        if upper.contains("XLS") { return .sheet }
        if upper.contains("M4A") || upper.contains("MP3") { return .audio }
        if upper.contains("ZIP") { return .archive }
        return .doc
    }
}

fileprivate struct LpspFichiersFileRow: View {
    let name: String
    let meta: String
    let kind: LpspFichiersFileKind
    var isSelected = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(kind.color.opacity(0.14))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: kind.icon)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(kind.color)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(LpspFichiersFonts.rowTitle)
                        .foregroundStyle(LpspFichiersTokens.textPrimary)
                        .lineLimit(1)
                    Text(meta)
                        .font(LpspFichiersFonts.meta)
                        .foregroundStyle(LpspFichiersTokens.textSecondary)
                        .fichiersTabularNumbers()
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: kind == .folder ? "chevron.right" : "ellipsis")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(LpspFichiersTokens.textSecondary)
            }
            .padding(.horizontal, 16)
            .frame(height: 60)
            .background(isSelected ? LpspFichiersTokens.blueTint : LpspFichiersTokens.canvas)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspFichiersRecentCard: View {
    let name: String
    let meta: String
    let kind: LpspFichiersFileKind
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: [kind.color.opacity(0.25), LpspFichiersTokens.surface],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 132, height: 88)
                    .overlay(
                        Image(systemName: kind.icon)
                            .font(.system(size: 28))
                            .foregroundStyle(kind.color)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(LpspFichiersFonts.rowTitle)
                        .foregroundStyle(LpspFichiersTokens.textPrimary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Text(meta)
                        .font(LpspFichiersFonts.caption)
                        .foregroundStyle(LpspFichiersTokens.textSecondary)
                        .fichiersTabularNumbers()
                }
            }
            .padding(12)
            .frame(width: 156, height: 168, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(LpspFichiersTokens.canvas)
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(LpspFichiersTokens.divider, lineWidth: 1))
            )
        }
        .buttonStyle(LpspFichiersPressableStyle())
    }
}

fileprivate struct LpspFichiersLocationTile: View {
    let title: String
    let subtitle: String
    let icon: String
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(tint.opacity(0.15))
                    .frame(width: 44, height: 44)
                    .overlay(Image(systemName: icon).foregroundStyle(tint))
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(LpspFichiersFonts.rowTitle)
                        .foregroundStyle(LpspFichiersTokens.textPrimary)
                    Text(subtitle)
                        .font(LpspFichiersFonts.meta)
                        .foregroundStyle(LpspFichiersTokens.textSecondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(LpspFichiersTokens.textSecondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(LpspFichiersTokens.canvas)
        }
        .buttonStyle(LpspFichiersPressableStyle())
    }
}

fileprivate struct LpspFichiersUploadBar: View {
    let label: String
    let progress: Double
    var done = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                    .font(LpspFichiersFonts.meta.weight(.semibold))
                    .foregroundStyle(LpspFichiersTokens.textPrimary)
                Spacer()
                if done {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(LpspFichiersTokens.success)
                } else {
                    Text("\(Int(progress * 100)) %")
                        .font(LpspFichiersFonts.caption)
                        .foregroundStyle(LpspFichiersTokens.textSecondary)
                        .fichiersTabularNumbers()
                }
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(LpspFichiersTokens.divider)
                    Capsule()
                        .fill(LpspFichiersTokens.blue)
                        .frame(width: geo.size.width * progress)
                }
            }
            .frame(height: 3)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(LpspFichiersTokens.surface)
    }
}

// MARK: - Données & état

fileprivate struct LpspFichiersShowroomNode: Identifiable, Hashable {
    let id: String
    let name: String
    let kind: LpspFichiersFileKind
    let size: String
    let dateLabel: String
    let detail: String
    let children: [LpspFichiersShowroomNode]?

    var isFolder: Bool { kind == .folder }

    var itemCountLabel: String? {
        guard let children, isFolder else { return nil }
        let files = children.filter { !$0.isFolder }.count
        let folders = children.filter(\.isFolder).count
        if folders > 0 && files > 0 { return "\(folders + files) éléments" }
        if folders > 0 { return "\(folders) dossiers" }
        return "\(files) fichiers"
    }

    var metaLabel: String {
        if isFolder { return itemCountLabel ?? "Dossier" }
        if size.isEmpty { return dateLabel }
        return "\(size) · \(dateLabel)"
    }

    func flattenedFiles() -> [LpspFichiersShowroomNode] {
        guard let children else { return isFolder ? [] : [self] }
        return children.flatMap { $0.flattenedFiles() }
    }
}

fileprivate struct LpspFichiersDeletedItem: Identifiable, Hashable {
    let id: String
    let name: String
    let kind: LpspFichiersFileKind
    let size: String
    let deletedLabel: String
    let daysRemaining: Int
    let detail: String
}

private enum LpspFichiersTab: CaseIterable {
    case browse, icloud, recents, deleted, account

    var label: String {
        switch self {
        case .browse: "Parcourir"
        case .icloud: "iCloud"
        case .recents: "Récents"
        case .deleted: "Supprimés"
        case .account: "Compte"
        }
    }

    var icon: String {
        switch self {
        case .browse: "square.grid.2x2.fill"
        case .icloud: "icloud.fill"
        case .recents: "clock.fill"
        case .deleted: "trash.fill"
        case .account: "person.crop.circle.fill"
        }
    }
}

@MainActor
fileprivate final class LpspFichiersStore: ObservableObject {
    @Published var selectedTab: LpspFichiersTab = .browse
    @Published var navigationStack: [LpspFichiersShowroomNode] = []
    @Published var selectedFile: LpspFichiersShowroomNode?
    @Published var showFileDetail = false
    @Published var showSearch = false
    @Published var searchQuery = ""
    @Published var uploadProgress: Double = 0.62
    @Published var deletedItems: [LpspFichiersDeletedItem]

    let roots: [LpspFichiersShowroomNode]

    init(roots: [LpspFichiersShowroomNode], deleted: [LpspFichiersDeletedItem]) {
        self.roots = roots
        self.deletedItems = deleted
    }

    var currentFolder: LpspFichiersShowroomNode? {
        navigationStack.last
    }

    var displayedItems: [LpspFichiersShowroomNode] {
        if let folder = currentFolder {
            return folder.children ?? []
        }
        return roots
    }

    var breadcrumb: String {
        if navigationStack.isEmpty { return "iCloud Drive" }
        return (["iCloud Drive"] + navigationStack.map(\.name)).joined(separator: " / ")
    }

    var allRecentFiles: [LpspFichiersShowroomNode] {
        roots.flatMap { $0.flattenedFiles() }
            .sorted { $0.dateLabel > $1.dateLabel }
    }

    var filteredSearchResults: [LpspFichiersShowroomNode] {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return [] }
        return allRecentFiles.filter {
            $0.name.lowercased().contains(query) || $0.detail.lowercased().contains(query)
        }
    }

    func open(_ node: LpspFichiersShowroomNode) {
        if node.isFolder {
            navigationStack.append(node)
            selectedTab = .icloud
        } else {
            selectedFile = node
            showFileDetail = true
        }
    }

    func openRoot(_ root: LpspFichiersShowroomNode) {
        navigationStack = [root]
        selectedTab = .icloud
    }

    func navigateUp() {
        guard !navigationStack.isEmpty else { return }
        navigationStack.removeLast()
    }

    func resetNavigation() {
        navigationStack.removeAll()
    }

    func restoreDeleted(_ item: LpspFichiersDeletedItem) {
        deletedItems.removeAll { $0.id == item.id }
    }

    static func roots(from items: [LpspFileItem]) -> [LpspFichiersShowroomNode] {
        let active = items.filter { !$0.isDeleted }
        var rootMap: [String: LpspFichiersShowroomNode] = [:]

        for item in active {
            let parts = item.path.split(separator: "/").map(String.init).filter { !$0.isEmpty }
            let rootName = parts.first ?? "iCloud Drive"
            if rootMap[rootName] == nil {
                rootMap[rootName] = LpspFichiersShowroomNode(
                    id: "root-\(rootName)",
                    name: rootName,
                    kind: .folder,
                    size: "",
                    dateLabel: "",
                    detail: "",
                    children: []
                )
            }
        }

        var mutableRoots = rootMap
        for item in active {
            let parts = item.path.split(separator: "/").map(String.init).filter { !$0.isEmpty }
            guard let rootName = parts.first else { continue }
            insert(item: item, into: &mutableRoots, rootName: rootName, folderParts: Array(parts.dropFirst()))
        }

        return Array(mutableRoots.values).sorted { $0.name < $1.name }
    }

    static func deleted(from items: [LpspFileItem]) -> [LpspFichiersDeletedItem] {
        items.filter(\.isDeleted).map { item in
            LpspFichiersDeletedItem(
                id: item.id,
                name: item.name,
                kind: LpspFichiersFileKind.from(type: item.type, isFolder: false),
                size: item.size,
                deletedLabel: item.modifiedRaw.isEmpty ? "Récemment" : item.modifiedRaw,
                daysRemaining: 18,
                detail: item.description
            )
        }
    }

    private static func insert(
        item: LpspFileItem,
        into roots: inout [String: LpspFichiersShowroomNode],
        rootName: String,
        folderParts: [String]
    ) {
        guard var root = roots[rootName] else { return }
        var children = root.children ?? []

        if folderParts.isEmpty {
            children.append(node(from: item))
        } else {
            let folderName = folderParts[0]
            let folderID = "\(root.id)/\(folderName)"
            if let index = children.firstIndex(where: { $0.id == folderID && $0.isFolder }) {
                var folder = children[index]
                var subChildren = folder.children ?? []
                if folderParts.count == 1 {
                    subChildren.append(node(from: item))
                } else {
                    let nested = LpspFileItem(
                        id: item.id,
                        name: item.name,
                        path: folderParts.dropFirst().joined(separator: "/") + "/",
                        type: item.type,
                        size: item.size,
                        description: item.description,
                        modifiedRaw: item.modifiedRaw
                    )
                    insertIntoFolder(item: nested, folderName: folderParts[1], folderParts: Array(folderParts.dropFirst(2)), children: &subChildren, parentID: folderID)
                }
                folder = LpspFichiersShowroomNode(
                    id: folder.id,
                    name: folder.name,
                    kind: .folder,
                    size: "",
                    dateLabel: "",
                    detail: "",
                    children: subChildren.sorted(by: sortNodes)
                )
                children[index] = folder
            } else {
                let newFolder = makeFolder(id: folderID, name: folderName, item: item, remainingParts: Array(folderParts.dropFirst()))
                children.append(newFolder)
            }
        }

        root = LpspFichiersShowroomNode(
            id: root.id,
            name: root.name,
            kind: .folder,
            size: "",
            dateLabel: "",
            detail: "",
            children: children.sorted(by: sortNodes)
        )
        roots[rootName] = root
    }

    private static func insertIntoFolder(
        item: LpspFileItem,
        folderName: String,
        folderParts: [String],
        children: inout [LpspFichiersShowroomNode],
        parentID: String
    ) {
        let folderID = "\(parentID)/\(folderName)"
        if folderParts.isEmpty {
            children.append(node(from: item))
            return
        }
        if let index = children.firstIndex(where: { $0.id == folderID && $0.isFolder }) {
            var folder = children[index]
            var subChildren = folder.children ?? []
            insertIntoFolder(
                item: item,
                folderName: folderParts[0],
                folderParts: Array(folderParts.dropFirst()),
                children: &subChildren,
                parentID: folderID
            )
            folder = LpspFichiersShowroomNode(
                id: folder.id,
                name: folder.name,
                kind: .folder,
                size: "",
                dateLabel: "",
                detail: "",
                children: subChildren.sorted(by: sortNodes)
            )
            children[index] = folder
        } else {
            children.append(makeFolder(id: folderID, name: folderName, item: item, remainingParts: folderParts))
        }
    }

    private static func makeFolder(
        id: String,
        name: String,
        item: LpspFileItem,
        remainingParts: [String]
    ) -> LpspFichiersShowroomNode {
        if remainingParts.isEmpty {
            return LpspFichiersShowroomNode(
                id: id,
                name: name,
                kind: .folder,
                size: "",
                dateLabel: "",
                detail: "",
                children: [node(from: item)]
            )
        }
        let childID = "\(id)/\(remainingParts[0])"
        return LpspFichiersShowroomNode(
            id: id,
            name: name,
            kind: .folder,
            size: "",
            dateLabel: "",
            detail: "",
            children: [makeFolder(id: childID, name: remainingParts[0], item: item, remainingParts: Array(remainingParts.dropFirst()))]
        )
    }

    private static func node(from item: LpspFileItem) -> LpspFichiersShowroomNode {
        LpspFichiersShowroomNode(
            id: item.id,
            name: item.name,
            kind: LpspFichiersFileKind.from(type: item.type, isFolder: false),
            size: item.size,
            dateLabel: item.modifiedRaw.isEmpty ? "—" : item.modifiedRaw,
            detail: item.description,
            children: nil
        )
    }

    private static func sortNodes(_ lhs: LpspFichiersShowroomNode, _ rhs: LpspFichiersShowroomNode) -> Bool {
        if lhs.isFolder != rhs.isFolder { return lhs.isFolder }
        return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
    }
}

private enum LpspFichiersShowroomData {
    static let roots: [LpspFichiersShowroomNode] = [
        icloudDrive,
        surMonIPhone,
    ]

    static let deleted: [LpspFichiersDeletedItem] = [
        .init(
            id: "del-1",
            name: "itineraire_fuite_B.png",
            kind: .image,
            size: "1,8 Mo",
            deletedLabel: "12 juin · 22h15",
            daysRemaining: 18,
            detail: "Itinéraire Louvre → Gennevilliers via Sébastopol. Supprimé le soir du 12 juin."
        ),
        .init(
            id: "del-2",
            name: "selfie_vincent_mathieu_louvre.jpg",
            kind: .image,
            size: "3,2 Mo",
            deletedLabel: "10 juin · 20h03",
            daysRemaining: 20,
            detail: "Selfie dans un couloir du Louvre, porte « Accès réservé au personnel » visible."
        ),
    ]

    private static let icloudDrive = LpspFichiersShowroomNode(
        id: "root-icloud",
        name: "iCloud Drive",
        kind: .folder,
        size: "",
        dateLabel: "",
        detail: "",
        children: [
            LpspFichiersShowroomNode(
                id: "clients",
                name: "Clients",
                kind: .folder,
                size: "",
                dateLabel: "",
                detail: "",
                children: [
                    LpspFichiersShowroomNode(
                        id: "projet-dame",
                        name: "Projet Dame — EventsCult",
                        kind: .folder,
                        size: "",
                        dateLabel: "",
                        detail: "",
                        children: [
                            file("brief-v1", "brief_dame_v1.pdf", .pdf, "1,8 Mo", "26 avr.", "Brief EventsCult — version de couverture."),
                            file("brief-v2", "brief_dame_v2.pdf", .pdf, "2,4 Mo", "16 mai", "Annotations Prosegur et croquis couloir Denon."),
                            file("brief-v3", "brief_dame_v3.pdf", .pdf, "3,6 Mo", "11 juin", "Plan opérationnel salle 710 — pièce maîtresse."),
                            file("badge", "badge_louvre_pro_scan.jpg", .image, "1,1 Mo", "8 mai", "Badge prestataire Vincent Morel, périmé."),
                            file("plan-denon", "plan_denon_N1.png", .image, "5,3 Mo", "3 mai", "Plan architectural aile Denon, salle 710."),
                            file("maintenance", "horaires_maintenance_juin.pdf", .pdf, "340 Ko", "3 juin", "Maintenance 18/06 — effectif sécurité réduit."),
                        ]
                    ),
                    LpspFichiersShowroomNode(
                        id: "brasserie",
                        name: "Brasserie Maillot — Menu 2025",
                        kind: .folder,
                        size: "",
                        dateLabel: "",
                        detail: "",
                        children: [
                            file("menu", "menu_printemps_v2.pdf", .pdf, "4,2 Mo", "3 avr.", "Maquette menu brasserie — travail propre."),
                            file("facture-maillot", "facture_maillot_0322.pdf", .pdf, "87 Ko", "5 avr.", "Facture 1 200 € — impayée."),
                        ]
                    ),
                    LpspFichiersShowroomNode(
                        id: "soma",
                        name: "Atelier Sōma — Identité visuelle",
                        kind: .folder,
                        size: "",
                        dateLabel: "",
                        detail: "",
                        children: [
                            file("logo-soma", "logo_soma_propositions.pdf", .pdf, "8,1 Mo", "9 mai", "6 propositions logo céramique."),
                            file("annulation-soma", "mail_annulation_soma.pdf", .pdf, "52 Ko", "14 mai", "Client annule le projet à la rentrée."),
                        ]
                    ),
                ]
            ),
            LpspFichiersShowroomNode(
                id: "admin",
                name: "Admin",
                kind: .folder,
                size: "",
                dateLabel: "",
                detail: "",
                children: [
                    file("bail", "bail_bastille_2023.pdf", .pdf, "890 Ko", "2023", "Studio Roquette — 1 150 €/mois."),
                    file("jugement", "jugement_garde_hugo_2024.pdf", .pdf, "1,2 Mo", "juin 2024", "Garde Hugo — pension 450 €/mois."),
                    file("avocat", "courrier_avocat_claire.pdf", .pdf, "420 Ko", "22 mai", "Mise en demeure — arriérés pension."),
                    file("impot", "avis_impot_2024.pdf", .pdf, "650 Ko", "10 avr.", "Revenus 2023 : 14 200 € nets."),
                ]
            ),
            LpspFichiersShowroomNode(
                id: "hugo",
                name: "Hugo",
                kind: .folder,
                size: "",
                dateLabel: "",
                detail: "",
                children: [
                    file("dessin", "dessin_papa_hugo_mars2025.jpg", .image, "2,8 Mo", "15 mars", "Dessin « PAPA ET MOI » — anniversaire Hugo."),
                    file("bulletin", "bulletin_T2_hugo_2025.pdf", .pdf, "380 Ko", "2 avr.", "Bulletin CM1 — créativité en arts plastiques."),
                    file("vacances", "planning_vacances_ete_2025.pdf", .pdf, "120 Ko", "28 mai", "Été chez papa — Bretagne si budget OK."),
                ]
            ),
            LpspFichiersShowroomNode(
                id: "downloads",
                name: "Téléchargements",
                kind: .folder,
                size: "",
                dateLabel: "",
                detail: "",
                children: [
                    file("ricoh", "ricoh_gr3_manuel_fr.pdf", .pdf, "12,4 Mo", "24 avr.", "Manuel GR III — signets mode silencieux."),
                    file("wiki", "dame_hermine_wiki.pdf", .pdf, "2,1 Mo", "18 avr.", "Wikipédia La Dame à l'hermine."),
                    file("evacuation", "plan_evacuation_denon.jpg", .image, "3,7 Mo", "2 mai", "Plan évacuation Denon — même image que Messages Hugo."),
                    file("facture-ricoh", "facture_amazon_ricoh.pdf", .pdf, "95 Ko", "26 avr.", "Ricoh GR III — 899 €."),
                ]
            ),
        ]
    )

    private static let surMonIPhone = LpspFichiersShowroomNode(
        id: "root-iphone",
        name: "Sur mon iPhone",
        kind: .folder,
        size: "",
        dateLabel: "",
        detail: "",
        children: [
            LpspFichiersShowroomNode(
                id: "vocaux",
                name: "Enregistrements vocaux",
                kind: .folder,
                size: "",
                dateLabel: "",
                detail: "",
                children: [
                    file("memo", "Mémo vocal 12-06 21h47.m4a", .audio, "1,4 Mo", "12 juin", "Récap braquage — « C'est pour Hugo »."),
                ]
            ),
            LpspFichiersShowroomNode(
                id: "signal-dl",
                name: "Signal",
                kind: .folder,
                size: "",
                dateLabel: "",
                detail: "",
                children: [
                    file("signal-photo", "signal-2025-06-06-photo.jpg", .image, "2,9 Mo", "6 juin", "Photo réunion équipe — 4 verres de thé."),
                ]
            ),
        ]
    )

    private static func file(
        _ id: String,
        _ name: String,
        _ kind: LpspFichiersFileKind,
        _ size: String,
        _ date: String,
        _ detail: String
    ) -> LpspFichiersShowroomNode {
        LpspFichiersShowroomNode(id: id, name: name, kind: kind, size: size, dateLabel: date, detail: detail, children: nil)
    }
}

// MARK: - Écrans showroom

private struct LpspFichiersShowroomRoot: View {
    @ObservedObject var store: LpspFichiersStore
    var isStoryMode = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .browse:
                        LpspFichiersBrowseTabScreen(store: store)
                    case .icloud:
                        LpspFichiersBrowseFolderScreen(store: store)
                    case .recents:
                        LpspFichiersRecentsTabScreen(store: store)
                    case .deleted:
                        LpspFichiersDeletedTabScreen(store: store)
                    case .account:
                        LpspFichiersAccountTabScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspFichiersTabBar(selectedTab: $store.selectedTab, deletedCount: store.deletedItems.count)
            }
            .background(LpspFichiersTokens.canvas.ignoresSafeArea())

            if store.selectedTab == .browse || store.selectedTab == .icloud {
                Button {
                    store.uploadProgress = min(store.uploadProgress + 0.08, 1)
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 56, height: 56)
                        .background(Circle().fill(LpspFichiersTokens.blue))
                        .shadow(color: LpspFichiersTokens.blue.opacity(0.32), radius: 16, y: 6)
                }
                .buttonStyle(LpspFichiersPressableStyle())
                .padding(.trailing, 16)
                .padding(.bottom, 72)
            }
        }
        .sheet(isPresented: $store.showFileDetail) {
            if let file = store.selectedFile {
                LpspFichiersFileDetailSheet(file: file)
            }
        }
        .sheet(isPresented: $store.showSearch) {
            LpspFichiersSearchSheet(store: store)
        }
    }
}

private struct LpspFichiersTabBar: View {
    @Binding var selectedTab: LpspFichiersTab
    let deletedCount: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspFichiersTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selectedTab = tab
                        if tab != .icloud { /* keep stack when switching back */ }
                    }
                } label: {
                    VStack(spacing: 2) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 18, weight: selectedTab == tab ? .semibold : .regular))
                            if tab == .deleted, deletedCount > 0 {
                                Text("\(deletedCount)")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 1)
                                    .background(Capsule().fill(LpspFichiersTokens.pdfRed))
                                    .offset(x: 8, y: -4)
                            }
                        }
                        Text(tab.label)
                            .font(LpspFichiersFonts.tab)
                    }
                    .foregroundStyle(selectedTab == tab ? LpspFichiersTokens.textPrimary : LpspFichiersTokens.textSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(LpspFichiersPressableStyle())
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspFichiersTokens.canvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspFichiersTokens.divider).frame(height: 0.5)
        }
    }
}

private struct LpspFichiersBrowseTabScreen: View {
    @ObservedObject var store: LpspFichiersStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Button {
                        store.showSearch = true
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(LpspFichiersTokens.textSecondary)
                            Text("Rechercher dans Fichiers")
                                .font(LpspFichiersFonts.rowTitle)
                                .foregroundStyle(LpspFichiersTokens.textSecondary)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LpspFichiersTokens.surface)
                        )
                    }
                    .buttonStyle(LpspFichiersPressableStyle())
                    .padding(.horizontal, 16)

                    if store.uploadProgress < 1 {
                        LpspFichiersUploadBar(
                            label: "Import en cours · 3 sur 8 fichiers",
                            progress: store.uploadProgress
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, 16)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Récents")
                            .font(LpspFichiersFonts.section)
                            .foregroundStyle(LpspFichiersTokens.textPrimary)
                            .padding(.horizontal, 16)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(store.allRecentFiles.prefix(6)) { file in
                                    LpspFichiersRecentCard(
                                        name: file.name,
                                        meta: file.metaLabel,
                                        kind: file.kind
                                    ) {
                                        store.open(file)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }

                    VStack(alignment: .leading, spacing: 0) {
                        Text("Emplacements")
                            .font(LpspFichiersFonts.section)
                            .foregroundStyle(LpspFichiersTokens.textPrimary)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)

                        ForEach(store.roots) { root in
                            LpspFichiersLocationTile(
                                title: root.name,
                                subtitle: root.itemCountLabel ?? "Dossier",
                                icon: root.name.contains("iCloud") ? "icloud.fill" : "iphone",
                                tint: LpspFichiersTokens.blue
                            ) {
                                store.openRoot(root)
                            }
                            Divider().padding(.leading, 74)
                        }
                    }
                    .background(LpspFichiersTokens.canvas)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 12)
            }
            .navigationTitle("Parcourir")
        }
    }
}

private struct LpspFichiersBrowseFolderScreen: View {
    @ObservedObject var store: LpspFichiersStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !store.navigationStack.isEmpty {
                    HStack {
                        Button {
                            store.navigateUp()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                Text("Retour")
                            }
                            .font(LpspFichiersFonts.meta)
                            .foregroundStyle(LpspFichiersTokens.blue)
                        }
                        .buttonStyle(LpspFichiersPressableStyle())
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(LpspFichiersTokens.surface)

                    Text(store.breadcrumb)
                        .font(LpspFichiersFonts.caption)
                        .foregroundStyle(LpspFichiersTokens.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }

                if store.displayedItems.isEmpty {
                    ContentUnavailableView("Dossier vide", systemImage: "folder")
                        .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(store.displayedItems) { item in
                                LpspFichiersFileRow(
                                    name: item.name,
                                    meta: item.metaLabel,
                                    kind: item.kind
                                ) {
                                    store.open(item)
                                }
                                Divider().padding(.leading, 68)
                            }
                        }
                    }
                }
            }
            .navigationTitle(store.currentFolder?.name ?? "iCloud Drive")
            .toolbar {
                if store.navigationStack.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            store.showSearch = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
            }
        }
    }
}

private struct LpspFichiersRecentsTabScreen: View {
    @ObservedObject var store: LpspFichiersStore

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(store.allRecentFiles) { file in
                        LpspFichiersFileRow(
                            name: file.name,
                            meta: file.metaLabel,
                            kind: file.kind
                        ) {
                            store.open(file)
                        }
                        Divider().padding(.leading, 68)
                    }
                }
            }
            .navigationTitle("Récents")
        }
    }
}

private struct LpspFichiersDeletedTabScreen: View {
    @ObservedObject var store: LpspFichiersStore

    var body: some View {
        NavigationStack {
            Group {
                if store.deletedItems.isEmpty {
                    ContentUnavailableView(
                        "Corbeille vide",
                        systemImage: "trash",
                        description: Text("Les fichiers supprimés apparaissent ici pendant 30 jours.")
                    )
                } else {
                    List {
                        Section {
                            ForEach(store.deletedItems) { item in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(spacing: 12) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(item.kind.color.opacity(0.14))
                                            .frame(width: 40, height: 40)
                                            .overlay(
                                                Image(systemName: item.kind.icon)
                                                    .foregroundStyle(item.kind.color)
                                            )
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(item.name)
                                                .font(LpspFichiersFonts.rowTitle)
                                            Text("\(item.size) · Supprimé \(item.deletedLabel)")
                                                .font(LpspFichiersFonts.meta)
                                                .foregroundStyle(LpspFichiersTokens.textSecondary)
                                        }
                                    }

                                    Text(item.detail)
                                        .font(LpspFichiersFonts.body)
                                        .foregroundStyle(LpspFichiersTokens.textSecondary)
                                        .lineLimit(3)

                                    HStack(spacing: 12) {
                                        Button("Restaurer") {
                                            store.restoreDeleted(item)
                                        }
                                        .font(LpspFichiersFonts.button)
                                        .foregroundStyle(LpspFichiersTokens.blue)

                                        Text("\(item.daysRemaining) jours restants")
                                            .font(LpspFichiersFonts.caption)
                                            .foregroundStyle(LpspFichiersTokens.warning)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        } footer: {
                            Text("Les fichiers supprimés récemment peuvent contenir des indices — vérifiez la corbeille.")
                        }
                    }
                }
            }
            .navigationTitle("Supprimés récemment")
        }
    }
}

private struct LpspFichiersAccountTabScreen: View {
    @ObservedObject var store: LpspFichiersStore

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 14) {
                        Circle()
                            .fill(LpspFichiersTokens.blue.opacity(0.15))
                            .frame(width: 56, height: 56)
                            .overlay(
                                Text("MG")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(LpspFichiersTokens.blue)
                            )
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Mathieu Garnier")
                                .font(LpspFichiersFonts.rowTitle)
                            Text("mathieu.garnier@icloud.com")
                                .font(LpspFichiersFonts.meta)
                                .foregroundStyle(LpspFichiersTokens.textSecondary)
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Stockage iCloud") {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Utilisé")
                            Spacer()
                            Text("38,4 Go sur 50 Go")
                                .fichiersTabularNumbers()
                                .foregroundStyle(LpspFichiersTokens.textSecondary)
                        }
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule().fill(LpspFichiersTokens.divider)
                                Capsule()
                                    .fill(LpspFichiersTokens.blue)
                                    .frame(width: geo.size.width * 0.768)
                            }
                        }
                        .frame(height: 6)
                    }
                    .padding(.vertical, 4)

                    Label("Fichiers · 4,2 Go", systemImage: "folder.fill")
                    Label("Photos · 21,8 Go", systemImage: "photo.fill")
                    Label("Sauvegardes · 8,1 Go", systemImage: "iphone")
                }

                Section("Synchronisation") {
                    Label("iCloud Drive activé", systemImage: "checkmark.icloud.fill")
                    Label("\(store.allRecentFiles.count) fichiers indexés", systemImage: "doc.text.magnifyingglass")
                    Label("\(store.deletedItems.count) élément(s) dans Supprimés récemment", systemImage: "trash")
                }
            }
            .navigationTitle("Compte")
        }
    }
}

private struct LpspFichiersFileDetailSheet: View {
    let file: LpspFichiersShowroomNode
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [file.kind.color.opacity(0.2), LpspFichiersTokens.surface],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 180)
                        .overlay(
                            Image(systemName: file.kind.icon)
                                .font(.system(size: 56))
                                .foregroundStyle(file.kind.color)
                        )

                    VStack(alignment: .leading, spacing: 6) {
                        Text(file.name)
                            .font(LpspFichiersFonts.section)
                        Text(file.metaLabel)
                            .font(LpspFichiersFonts.meta)
                            .foregroundStyle(LpspFichiersTokens.textSecondary)
                    }

                    if !file.detail.isEmpty {
                        Text(file.detail)
                            .font(LpspFichiersFonts.body)
                            .foregroundStyle(LpspFichiersTokens.textPrimary)
                    }

                    HStack(spacing: 12) {
                        actionButton("square.and.arrow.up", "Partager")
                        actionButton("square.and.arrow.down", "Enregistrer")
                        actionButton("ellipsis", "Plus")
                    }
                }
                .padding(20)
            }
            .navigationTitle("Aperçu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private func actionButton(_ icon: String, _ title: String) -> some View {
        Button { } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(LpspFichiersTokens.surface))
                Text(title)
                    .font(LpspFichiersFonts.caption)
            }
            .foregroundStyle(LpspFichiersTokens.textPrimary)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(LpspFichiersPressableStyle())
    }
}

private struct LpspFichiersSearchSheet: View {
    @ObservedObject var store: LpspFichiersStore
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focused: Bool

    var body: some View {
        NavigationStack {
            List {
                if store.searchQuery.isEmpty {
                    Section("Suggestions") {
                        ForEach(["brief", "louvre", "hugo", "pension"], id: \.self) { term in
                            Button {
                                store.searchQuery = term
                            } label: {
                                Label(term.capitalized, systemImage: "magnifyingglass")
                            }
                        }
                    }
                } else {
                    Section("Résultats") {
                        ForEach(store.filteredSearchResults) { file in
                            Button {
                                store.open(file)
                                dismiss()
                            } label: {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(file.name)
                                        .font(LpspFichiersFonts.rowTitle)
                                        .foregroundStyle(LpspFichiersTokens.textPrimary)
                                    Text(file.metaLabel)
                                        .font(LpspFichiersFonts.meta)
                                        .foregroundStyle(LpspFichiersTokens.textSecondary)
                                }
                            }
                        }
                    }
                }
            }
            .searchable(text: $store.searchQuery, prompt: "Nom, type, contenu…")
            .navigationTitle("Recherche")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
        }
    }
}

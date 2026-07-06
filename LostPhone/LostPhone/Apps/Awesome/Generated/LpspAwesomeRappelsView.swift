import SwiftUI

// Fidélité Apple Rappels — tokens LpspThirdPartyBrand.remindersYellow
struct LpspAwesomeRappelsView: View {
    var lists: [LpspReminderList]?

    var body: some View {
        let storyLists = lists?.isEmpty == false ? lists : nil
        LpspRappelsShowroomRoot(
            store: LpspRappelsStore(
                lists: storyLists.map { LpspRappelsStore.lists(from: $0) } ?? LpspRappelsShowroomData.lists
            ),
            isStoryMode: storyLists != nil
        )
    }
}

// MARK: - Tokens & composants

private enum LpspRappelsFonts {
    static let largeTitle = Font.system(size: 34, weight: .bold)
    static let section    = Font.system(size: 22, weight: .semibold)
    static let rowTitle   = Font.system(size: 17, weight: .regular)
    static let meta       = Font.system(size: 15, weight: .regular)
    static let caption    = Font.system(size: 13, weight: .regular)
    static let tab        = Font.system(size: 10, weight: .regular)
}

private enum LpspRappelsTokens {
    static let canvas        = Color(uiColor: .systemGroupedBackground)
    static let surface       = Color(uiColor: .secondarySystemGroupedBackground)
    static let textPrimary   = Color.primary
    static let textSecondary = Color.secondary
    static let yellow        = LpspThirdPartyBrand.remindersYellow
    static let divider       = Color(uiColor: .separator)
}

fileprivate struct LpspRappelsPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

fileprivate struct LpspRappelsCheckButton: View {
    let isCompleted: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .stroke(isCompleted ? LpspRappelsTokens.textSecondary.opacity(0.35) : LpspRappelsTokens.yellow, lineWidth: 2)
                    .frame(width: 24, height: 24)
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(LpspRappelsTokens.textSecondary)
                }
            }
        }
        .buttonStyle(LpspRappelsPressableStyle())
    }
}

fileprivate struct LpspRappelsItemRow: View {
    let item: LpspRappelsShowroomItem
    let onToggle: () -> Void
    let onTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            LpspRappelsCheckButton(isCompleted: item.isCompleted, action: onToggle)
                .padding(.top, 2)

            Button(action: onTap) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(item.title)
                            .font(LpspRappelsFonts.rowTitle)
                            .foregroundStyle(item.isCompleted ? LpspRappelsTokens.textSecondary : LpspRappelsTokens.textPrimary)
                            .strikethrough(item.isCompleted, color: LpspRappelsTokens.textSecondary)
                            .multilineTextAlignment(.leading)

                        if item.isHighPriority, !item.isCompleted {
                            Image(systemName: "exclamationmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(LpspRappelsTokens.yellow)
                        }
                    }

                    HStack(spacing: 8) {
                        if !item.dueLabel.isEmpty {
                            Text(item.dueLabel)
                                .font(LpspRappelsFonts.caption)
                                .foregroundStyle(item.isOverdue ? .red : LpspRappelsTokens.textSecondary)
                        }
                        if !item.listName.isEmpty {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(item.listColor)
                                    .frame(width: 8, height: 8)
                                Text(item.listName)
                                    .font(LpspRappelsFonts.caption)
                                    .foregroundStyle(LpspRappelsTokens.textSecondary)
                            }
                        }
                    }

                    if !item.notes.isEmpty, !item.isCompleted {
                        Text(item.notes)
                            .font(LpspRappelsFonts.caption)
                            .foregroundStyle(LpspRappelsTokens.textSecondary)
                            .lineLimit(2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(LpspRappelsTokens.surface)
    }
}

fileprivate struct LpspRappelsListCard: View {
    let list: LpspRappelsShowroomList
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(list.color.opacity(0.18))
                        .frame(width: 44, height: 44)
                    Text(list.emoji)
                        .font(.system(size: 22))
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(list.name)
                        .font(LpspRappelsFonts.rowTitle)
                        .foregroundStyle(LpspRappelsTokens.textPrimary)
                    Text("\(list.openCount) ouvert · \(list.completedCount) terminé")
                        .font(LpspRappelsFonts.caption)
                        .foregroundStyle(LpspRappelsTokens.textSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(LpspRappelsTokens.textSecondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(LpspRappelsTokens.surface)
        }
        .buttonStyle(LpspRappelsPressableStyle())
    }
}

// MARK: - Données & état

fileprivate struct LpspRappelsShowroomItem: Identifiable, Hashable {
    let id: String
    let listID: String
    let listName: String
    let listColor: Color
    let title: String
    let notes: String
    let dueLabel: String
    let isOverdue: Bool
    let isHighPriority: Bool
    var isCompleted: Bool
    var isToday: Bool
    var isScheduled: Bool
}

fileprivate struct LpspRappelsShowroomList: Identifiable, Hashable {
    let id: String
    let name: String
    let emoji: String
    let color: Color
    var items: [LpspRappelsShowroomItem]

    var openCount: Int { items.filter { !$0.isCompleted }.count }
    var completedCount: Int { items.filter(\.isCompleted).count }
}

private enum LpspRappelsTab: CaseIterable {
    case today, scheduled, all, completed, lists

    var label: String {
        switch self {
        case .today: "Aujourd'hui"
        case .scheduled: "Programmés"
        case .all: "Tous"
        case .completed: "Terminés"
        case .lists: "Listes"
        }
    }

    var icon: String {
        switch self {
        case .today: "calendar.circle.fill"
        case .scheduled: "calendar.badge.clock"
        case .all: "tray.fill"
        case .completed: "checkmark.circle.fill"
        case .lists: "list.bullet"
        }
    }
}

@MainActor
fileprivate final class LpspRappelsStore: ObservableObject {
    @Published var lists: [LpspRappelsShowroomList]
    @Published var selectedTab: LpspRappelsTab = .today
    @Published var selectedListID: String?
    @Published var showSearch = false
    @Published var searchQuery = ""
    @Published var selectedItemID: String?
    @Published var showItemDetail = false

    init(lists: [LpspRappelsShowroomList]) {
        self.lists = lists
    }

    var allItems: [LpspRappelsShowroomItem] {
        lists.flatMap(\.items)
    }

    var todayItems: [LpspRappelsShowroomItem] {
        allItems.filter { !$0.isCompleted && $0.isToday }
    }

    var scheduledItems: [LpspRappelsShowroomItem] {
        allItems.filter { !$0.isCompleted && $0.isScheduled }
    }

    var openItems: [LpspRappelsShowroomItem] {
        allItems.filter { !$0.isCompleted }
    }

    var completedItems: [LpspRappelsShowroomItem] {
        allItems.filter(\.isCompleted)
    }

    var filteredSearchResults: [LpspRappelsShowroomItem] {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return [] }
        return allItems.filter {
            $0.title.lowercased().contains(query)
                || $0.notes.lowercased().contains(query)
                || $0.listName.lowercased().contains(query)
        }
    }

    var selectedList: LpspRappelsShowroomList? {
        guard let selectedListID else { return nil }
        return lists.first { $0.id == selectedListID }
    }

    var selectedItem: LpspRappelsShowroomItem? {
        guard let selectedItemID else { return nil }
        return allItems.first { $0.id == selectedItemID }
    }

    func toggleItem(_ item: LpspRappelsShowroomItem) {
        guard let listIndex = lists.firstIndex(where: { $0.id == item.listID }),
              let itemIndex = lists[listIndex].items.firstIndex(where: { $0.id == item.id }) else { return }
        lists[listIndex].items[itemIndex].isCompleted.toggle()
    }

    func openList(_ list: LpspRappelsShowroomList) {
        selectedListID = list.id
        selectedTab = .lists
    }

    func openItem(_ item: LpspRappelsShowroomItem) {
        selectedItemID = item.id
        showItemDetail = true
    }

    static func lists(from storyLists: [LpspReminderList]) -> [LpspRappelsShowroomList] {
        storyLists.map { list in
            LpspRappelsShowroomList(
                id: list.id,
                name: list.name,
                emoji: list.emoji,
                color: color(for: list.colorName),
                items: list.items.map { item in
                    showroomItem(from: item, list: list)
                }
            )
        }
    }

    private static func showroomItem(from item: LpspReminderItem, list: LpspReminderList) -> LpspRappelsShowroomItem {
        let due = item.dueRaw
        let hasDue = !item.dueRaw.isEmpty
        return LpspRappelsShowroomItem(
            id: item.id,
            listID: list.id,
            listName: list.name,
            listColor: color(for: list.colorName),
            title: item.title,
            notes: item.notes,
            dueLabel: due,
            isOverdue: !item.completed && due.contains("juin") && due.contains("4"),
            isHighPriority: item.priority.lowercased().contains("haute"),
            isCompleted: item.completed,
            isToday: !item.completed && (due.contains("15") || due.contains("Aujourd")),
            isScheduled: !item.completed && hasDue
        )
    }

    static func color(for name: String) -> Color {
        switch name.lowercased() {
        case "bleu", "blue": return .blue
        case "orange": return .orange
        case "vert", "green": return .green
        case "violet", "purple": return .purple
        case "rouge", "red": return .red
        default: return LpspRappelsTokens.yellow
        }
    }
}

private enum LpspRappelsShowroomData {
    static let lists: [LpspRappelsShowroomList] = [
        LpspRappelsShowroomList(
            id: "perso",
            name: "Perso",
            emoji: "🏠",
            color: .blue,
            items: [
                item("p1", "perso", "Perso", .blue, "Pension Hugo — virement 1er juin", "", "1 juin", high: true, today: true, scheduled: true),
                item("p2", "perso", "Perso", .blue, "Loyer juin — payer AVANT le 5", "3 mois de retard. Proprio menace mise en demeure", "4 juin", overdue: true, high: true, today: true, scheduled: true),
                item("p3", "perso", "Perso", .blue, "Courrier avocat Claire — lire + réfléchir", "Deadline 30 juin", "23 mai", completed: true),
                item("p4", "perso", "Perso", .blue, "Cadeau Hugo — maillot PSG floqué", "Taille 12 ans", "13 juin", today: true, scheduled: true),
                item("p5", "perso", "Perso", .blue, "Week-end Hugo 21-22 juin — confirmer Claire", "Lui dire que tout va s'arranger", "16 juin", scheduled: true),
                item("p6", "perso", "Perso", .blue, "Relancer Sophie compta — décla revenus", "", "2 avr.", completed: true),
            ]
        ),
        LpspRappelsShowroomList(
            id: "projet",
            name: "Projet",
            emoji: "📐",
            color: .orange,
            items: [
                item("r1", "projet", "Projet", .orange, "Effacer historique Safari", "", "12 juin · 22h", high: true, today: true, scheduled: true),
                item("r2", "projet", "Projet", .orange, "Formater carte SD compact après transfert", "Tout doit être propre avant mercredi soir", "17 juin", high: true, scheduled: true),
                item("r3", "projet", "Projet", .orange, "Compact : carte SD 64Go", "SanDisk Extreme. Fnac Bastille", "24 avr.", completed: true),
                item("r4", "projet", "Projet", .orange, "Dernière visite — mercredi 11", "Confirmer écart ronde PM", "11 juin", completed: true),
                item("r5", "projet", "Projet", .orange, "Réunion chez N. — vendredi 6", "Dernière avant J. Apporter compact + SD", "6 juin", completed: true),
                item("r6", "projet", "Projet", .orange, "Vérifier horaires équipe soir — noter changements", "Rotation pas fixe. Le grand barbu fait S7 le mardi", "10 mai", completed: true),
            ]
        ),
        LpspRappelsShowroomList(
            id: "courses",
            name: "Courses",
            emoji: "🛒",
            color: .green,
            items: [
                item("c1", "courses", "Courses", .green, "Courses week-end Hugo 21-22 — à faire après mercredi", "Lui faire son gâteau au chocolat", "19 juin", scheduled: true),
                item("c2", "courses", "Courses", .green, "Racheter chargeur USB-C — celui de la chambre est mort", "", "", scheduled: false),
                item("c3", "courses", "Courses", .green, "Gants nitrile noirs — boîte de 100", "Taille M. Pharmacie ou Amazon", "9 juin", completed: true),
                item("c4", "courses", "Courses", .green, "Courses week-end Hugo — pizza surgelée + jus d'orange", "Chocapic pas les autres", "6 juin", completed: true),
            ]
        ),
        LpspRappelsShowroomList(
            id: "boulot",
            name: "Boulot",
            emoji: "💻",
            color: .purple,
            items: [
                item("b1", "boulot", "Boulot", .purple, "Envoyer devis Atelier Sōma — version organique", "Palette terre cuite + sauge", "9 mai", completed: true),
                item("b2", "boulot", "Boulot", .purple, "Facture Maillot — relance paiement", "1 200 € impayés", "8 mai", completed: true),
                item("b3", "boulot", "Boulot", .purple, "Préparer planche logo Sōma v3", "", "14 mai", completed: true),
            ]
        ),
    ]

    private static func item(
        _ id: String,
        _ listID: String,
        _ listName: String,
        _ color: Color,
        _ title: String,
        _ notes: String,
        _ due: String,
        completed: Bool = false,
        overdue: Bool = false,
        high: Bool = false,
        today: Bool = false,
        scheduled: Bool = true
    ) -> LpspRappelsShowroomItem {
        LpspRappelsShowroomItem(
            id: id,
            listID: listID,
            listName: listName,
            listColor: color,
            title: title,
            notes: notes,
            dueLabel: due,
            isOverdue: overdue,
            isHighPriority: high,
            isCompleted: completed,
            isToday: today,
            isScheduled: scheduled && !due.isEmpty
        )
    }
}

// MARK: - Écrans showroom

private struct LpspRappelsShowroomRoot: View {
    @ObservedObject var store: LpspRappelsStore
    var isStoryMode = false

    var body: some View {
        VStack(spacing: 0) {
            Group {
                if let list = store.selectedList, store.selectedTab == .lists {
                    LpspRappelsListDetailScreen(store: store, list: list)
                } else {
                    switch store.selectedTab {
                    case .today:
                        LpspRappelsItemsScreen(store: store, title: "Aujourd'hui", items: store.todayItems, empty: "Rien pour aujourd'hui")
                    case .scheduled:
                        LpspRappelsItemsScreen(store: store, title: "Programmés", items: store.scheduledItems, empty: "Aucun rappel programmé")
                    case .all:
                        LpspRappelsItemsScreen(store: store, title: "Tous", items: store.openItems, empty: "Tout est terminé")
                    case .completed:
                        LpspRappelsItemsScreen(store: store, title: "Terminés", items: store.completedItems, empty: "Aucun rappel terminé")
                    case .lists:
                        LpspRappelsListsScreen(store: store)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspRappelsTabBar(
                selectedTab: $store.selectedTab,
                openCount: store.openItems.count,
                onListsTap: { store.selectedListID = nil }
            )
        }
        .background(LpspRappelsTokens.canvas.ignoresSafeArea())
        .sheet(isPresented: $store.showItemDetail) {
            if let item = store.selectedItem {
                LpspRappelsItemDetailSheet(store: store, item: item)
            }
        }
        .sheet(isPresented: $store.showSearch) {
            LpspRappelsSearchSheet(store: store)
        }
    }
}

private struct LpspRappelsTabBar: View {
    @Binding var selectedTab: LpspRappelsTab
    let openCount: Int
    let onListsTap: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspRappelsTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        if tab == .lists { onListsTap() }
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 2) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 18, weight: selectedTab == tab ? .semibold : .regular))
                            if tab == .all, openCount > 0 {
                                Text("\(openCount)")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 1)
                                    .background(Capsule().fill(LpspRappelsTokens.yellow))
                                    .offset(x: 8, y: -4)
                            }
                        }
                        Text(tab.label)
                            .font(LpspRappelsFonts.tab)
                    }
                    .foregroundStyle(selectedTab == tab ? LpspRappelsTokens.textPrimary : LpspRappelsTokens.textSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(LpspRappelsPressableStyle())
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(Color(uiColor: .systemBackground))
        .overlay(alignment: .top) {
            Rectangle().fill(LpspRappelsTokens.divider).frame(height: 0.5)
        }
    }
}

private struct LpspRappelsItemsScreen: View {
    @ObservedObject var store: LpspRappelsStore
    let title: String
    let items: [LpspRappelsShowroomItem]
    let empty: String

    var body: some View {
        NavigationStack {
            Group {
                if items.isEmpty {
                    ContentUnavailableView(empty, systemImage: "checkmark.circle")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(items) { item in
                                LpspRappelsItemRow(
                                    item: item,
                                    onToggle: { store.toggleItem(item) },
                                    onTap: { store.openItem(item) }
                                )
                                Divider().padding(.leading, 52)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        store.showSearch = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}

private struct LpspRappelsListsScreen: View {
    @ObservedObject var store: LpspRappelsStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(store.lists) { list in
                        LpspRappelsListCard(list: list) {
                            store.openList(list)
                        }
                        if list.id != store.lists.last?.id {
                            Divider().padding(.leading, 74)
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Tags")
                        .font(LpspRappelsFonts.section)
                        .padding(.horizontal, 16)
                    HStack(spacing: 8) {
                        tagChip("Hugo", color: .blue)
                        tagChip("Urgent", color: .red)
                        tagChip("Louvre", color: .orange)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 12)
            }
            .navigationTitle("Listes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(LpspRappelsTokens.yellow)
                    }
                }
            }
        }
    }

    private func tagChip(_ title: String, color: Color) -> some View {
        Text(title)
            .font(LpspRappelsFonts.caption.weight(.medium))
            .foregroundStyle(color)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Capsule().fill(color.opacity(0.12)))
    }
}

private struct LpspRappelsListDetailScreen: View {
    @ObservedObject var store: LpspRappelsStore
    let list: LpspRappelsShowroomList

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(list.items) { item in
                        LpspRappelsItemRow(
                            item: item,
                            onToggle: { store.toggleItem(item) },
                            onTap: { store.openItem(item) }
                        )
                        Divider().padding(.leading, 52)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .navigationTitle(list.name)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Listes") {
                        store.selectedListID = nil
                    }
                }
            }
        }
    }
}

private struct LpspRappelsItemDetailSheet: View {
    @ObservedObject var store: LpspRappelsStore
    let item: LpspRappelsShowroomItem
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(alignment: .top, spacing: 12) {
                        LpspRappelsCheckButton(isCompleted: item.isCompleted) {
                            store.toggleItem(item)
                        }
                        Text(item.title)
                            .font(LpspRappelsFonts.section)
                    }
                }

                if !item.notes.isEmpty {
                    Section("Notes") {
                        Text(item.notes)
                            .font(LpspRappelsFonts.rowTitle)
                    }
                }

                Section("Détails") {
                    if !item.dueLabel.isEmpty {
                        LabeledContent("Échéance", value: item.dueLabel)
                    }
                    LabeledContent("Liste") {
                        HStack(spacing: 6) {
                            Circle().fill(item.listColor).frame(width: 8, height: 8)
                            Text(item.listName)
                        }
                    }
                    if item.isHighPriority {
                        LabeledContent("Priorité", value: "Haute")
                    }
                }
            }
            .navigationTitle("Rappel")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

private struct LpspRappelsSearchSheet: View {
    @ObservedObject var store: LpspRappelsStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                if store.searchQuery.isEmpty {
                    Section("Suggestions") {
                        ForEach(["pension", "hugo", "safari", "louvre"], id: \.self) { term in
                            Button {
                                store.searchQuery = term
                            } label: {
                                Label(term.capitalized, systemImage: "magnifyingglass")
                            }
                        }
                    }
                } else {
                    Section("Résultats") {
                        ForEach(store.filteredSearchResults) { item in
                            Button {
                                store.openItem(item)
                                dismiss()
                            } label: {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.title)
                                        .font(LpspRappelsFonts.rowTitle)
                                    Text(item.listName)
                                        .font(LpspRappelsFonts.caption)
                                        .foregroundStyle(LpspRappelsTokens.textSecondary)
                                }
                            }
                        }
                    }
                }
            }
            .searchable(text: $store.searchQuery, prompt: "Rappels, listes, notes…")
            .navigationTitle("Recherche")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fermer") { dismiss() }
                }
            }
        }
    }
}

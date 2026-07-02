import SwiftUI

struct RappelsRedditListDetailView: View {
    let list: LpspReminderList
    @State private var selected: LpspReminderItem?

    private var accent: Color {
        RappelsRedditTheme.listColor(named: list.colorName)
    }

    var body: some View {
        List {
            ForEach(list.items) { item in
                RappelsRedditCellView(item: item, accent: accent) {
                    selected = item
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("\(list.emoji) \(list.name)")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selected) { item in
            NavigationStack {
                RappelsRedditItemDetailView(item: item, accent: accent)
            }
        }
    }
}

struct RappelsRedditSmartListView: View {
    let type: RappelsRedditSmartList
    let lists: [LpspReminderList]
    @State private var selected: LpspReminderItem?

    private var items: [LpspReminderItem] {
        RappelsRedditLPSP.filtered(type, lists: lists)
    }

    private var accent: Color {
        RappelsRedditTheme.listColor(named: type.tint)
    }

    var body: some View {
        List {
            if items.isEmpty {
                ContentUnavailableView("Aucun rappel", systemImage: "checklist")
            } else {
                ForEach(items) { item in
                    RappelsRedditCellView(item: item, accent: listAccent(for: item)) {
                        selected = item
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(type.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selected) { item in
            NavigationStack {
                RappelsRedditItemDetailView(
                    item: item,
                    accent: listAccent(for: item),
                    listName: RappelsRedditLPSP.list(for: item, in: lists)?.name
                )
            }
        }
    }

    private func listAccent(for item: LpspReminderItem) -> Color {
        if let list = RappelsRedditLPSP.list(for: item, in: lists) {
            return RappelsRedditTheme.listColor(named: list.colorName)
        }
        return accent
    }
}

/// Détail read-only — inspiré de ReminderEditScreen (sans édition).
struct RappelsRedditItemDetailView: View {
    let item: LpspReminderItem
    var accent: Color = RappelsRedditTheme.accent
    var listName: String?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section {
                LabeledContent("Titre", value: item.title)
                if !item.notes.isEmpty {
                    LabeledContent("Notes", value: item.notes)
                }
                if let listName {
                    LabeledContent("Liste", value: listName)
                }
            }

            if !item.dueRaw.isEmpty {
                Section {
                    LabeledContent("Date") {
                        Text(RappelsRedditLPSP.formatDue(item.dueRaw))
                    }
                    let time = RappelsRedditLPSP.formatTime(item.dueRaw)
                    if !time.isEmpty {
                        LabeledContent("Heure") {
                            Text(time)
                        }
                    }
                }
            }

            Section {
                LabeledContent("État") {
                    Text(item.completed ? "Terminé" : "À faire")
                        .foregroundStyle(item.completed ? .secondary : accent)
                }
                if item.priority == "haute" {
                    LabeledContent("Priorité") {
                        Text("Haute").foregroundStyle(.red)
                    }
                }
            }
        }
        .navigationTitle("Détail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Fermer") { dismiss() }
            }
        }
    }
}

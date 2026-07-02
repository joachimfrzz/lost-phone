import SwiftUI

// Clone Apple Rappels — listes intelligentes + listes perso.

struct LpspRappelsView: View {
    let lists: [LpspReminderList]
    @State private var selected: LpspReminderList?

    private var openTotal: Int {
        lists.flatMap(\.items).filter { !$0.completed }.count
    }

    var body: some View {
        NavigationStack {
            Group {
                if lists.isEmpty {
                    ContentUnavailableView("Rappels", systemImage: "checklist")
                } else {
                    List {
                        Section {
                            smartRow("sun.max.fill", "Aujourd'hui", openTotal, color: .blue)
                            smartRow("calendar", "Programmés", scheduledCount, color: .red)
                            smartRow("tray.fill", "Tous", allCount, color: .gray)
                            smartRow("checkmark.circle", "Terminés", completedCount, color: .gray)
                        }

                        Section {
                            ForEach(lists) { list in
                                Button { selected = list } label: {
                                    ReminderListRow(list: list)
                                }
                                .buttonStyle(.plain)
                            }
                        } header: {
                            Text("Mes listes")
                                .font(.title3.weight(.bold))
                                .textCase(nil)
                                .foregroundStyle(.primary)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Rappels")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: { Image(systemName: "plus") }
                        .disabled(true)
                }
            }
            .navigationDestination(item: $selected) { list in
                ReminderDetailView(list: list)
            }
        }
    }

    private var scheduledCount: Int {
        lists.flatMap(\.items).filter { !$0.completed && !$0.dueRaw.isEmpty }.count
    }

    private var allCount: Int { lists.flatMap(\.items).count }
    private var completedCount: Int { lists.flatMap(\.items).filter(\.completed).count }

    private func smartRow(_ icon: String, _ title: String, _ count: Int, color: Color) -> some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(color)
                .frame(width: 28, height: 28)
                .overlay {
                    Image(systemName: icon)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                }
            Text(title)
                .font(.body)
            Spacer()
            Text("\(count)")
                .font(.body)
                .foregroundStyle(.secondary)
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }
}

private struct ReminderListRow: View {
    let list: LpspReminderList

    var body: some View {
        HStack(spacing: 14) {
            Text(list.emoji)
                .font(.title2)
                .frame(width: 32)
            Text(list.name)
                .font(.body)
                .foregroundStyle(.primary)
            Spacer()
            Text("\(list.items.filter { !$0.completed }.count)")
                .foregroundStyle(.secondary)
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }
}

private struct ReminderDetailView: View {
    let list: LpspReminderList

    var body: some View {
        List {
            ForEach(list.items) { item in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: item.completed ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(item.completed ? Color(uiColor: .systemGray3) : LpspThirdPartyBrand.remindersYellow)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .strikethrough(item.completed)
                            .foregroundStyle(item.completed ? .secondary : .primary)
                        if !item.notes.isEmpty {
                            Text(item.notes)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        if !item.dueRaw.isEmpty {
                            Text(LpspThirdPartyFormat.frenchDateRaw(item.dueRaw))
                                .font(.caption2)
                                .foregroundStyle(item.priority == "haute" ? .red : .secondary)
                        }
                    }
                }
                .padding(.vertical, 2)
            }
        }
        .listStyle(.plain)
        .navigationTitle("\(list.emoji) \(list.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

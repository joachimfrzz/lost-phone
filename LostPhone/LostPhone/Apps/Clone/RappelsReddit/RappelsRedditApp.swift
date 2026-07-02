import SwiftUI

// Point d'entrée Lost Phone — clone azamsharp/RemindersClone + LPSP J-3.
// Source vendored : https://github.com/azamsharp/RemindersClone
// Accueil en liste iOS natif (pas la grille 2×2 du clone) + cellules vendored.

struct RappelsRedditAppView: View {
    let lists: [LpspReminderList]
    @State private var selectedList: LpspReminderList?
    @State private var selectedSmartList: RappelsRedditSmartList?
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        NavigationStack {
            Group {
                if lists.isEmpty {
                    ContentUnavailableView("Rappels", systemImage: "checklist")
                } else {
                    List {
                        Section {
                            ForEach(RappelsRedditSmartList.allCases) { type in
                                Button { selectedSmartList = type } label: {
                                    smartRow(type)
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        Section {
                            ForEach(lists) { list in
                                Button { selectedList = list } label: {
                                    RappelsRedditListCellView(list: list)
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
                        .disabled(readOnly)
                }
            }
            .navigationDestination(item: $selectedList) { list in
                RappelsRedditListDetailView(list: list)
            }
            .navigationDestination(item: $selectedSmartList) { type in
                RappelsRedditSmartListView(type: type, lists: lists)
            }
        }
    }

    private func smartRow(_ type: RappelsRedditSmartList) -> some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(RappelsRedditTheme.listColor(named: type.tint))
                .frame(width: 28, height: 28)
                .overlay {
                    Image(systemName: type.icon)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                }
            Text(type.title)
                .font(.body)
            Spacer()
            Text("\(RappelsRedditLPSP.count(for: type, lists: lists))")
                .font(.body)
                .foregroundStyle(.secondary)
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }
}

/// Route LPSP — même nom qu'avant pour le router.
struct LpspRappelsView: View {
    let lists: [LpspReminderList]

    var body: some View {
        RappelsRedditAppView(lists: lists)
    }
}

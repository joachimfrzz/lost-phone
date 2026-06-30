import SwiftUI

/// Notes — UI clone zerocode117, contenu LPSP (lecture seule).
struct LpspNotesView: View {
    let notes: [LpspNote]
    @State private var selected: LpspNote?

    var body: some View {
        NavigationStack {
            Group {
                if notes.isEmpty {
                    ContentUnavailableView(
                        "Notes",
                        systemImage: "note.text",
                        description: Text("Ajoutez des notes dans lpsp.json → content.apps.Notes")
                    )
                } else {
                    List(notes) { note in
                        Button { selected = note } label: {
                            LpspNoteRow(note: note)
                        }
                        .buttonStyle(.plain)
                        .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 16))
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Modifier") {}.disabled(true).foregroundStyle(.yellow)
                }
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Text("\(notes.count) Notes")
                            .font(.caption)
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.yellow.opacity(0.35))
                    }
                }
            }
            .navigationDestination(item: $selected) { note in
                LpspNoteDetailView(note: note)
            }
        }
        .accentColor(.yellow)
    }
}

struct LpspNoteRow: View {
    let note: LpspNote

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.title)
                .font(.system(size: 17, weight: .bold))
                .lineLimit(1)
            HStack(spacing: 6) {
                Text(LpspAdapters.formatShortDate(note.modified, fallback: note.modifiedRaw))
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)
                    .fixedSize()
                Text(note.preview)
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct LpspNoteDetailView: View {
    let note: LpspNote

    var body: some View {
        ScrollView {
            Text(note.content)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .navigationTitle(note.title)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Text("Lecture seule — contenu LPSP")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.bar)
        }
    }
}

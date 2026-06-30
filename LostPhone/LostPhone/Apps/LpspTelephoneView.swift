import SwiftUI

/// Téléphone — UI clone zerocode117, contenu LPSP (lecture seule).
struct LpspTelephoneView: View {
    let recents: [LpspCall]
    @State private var filter = 0

    var body: some View {
        TabView {
            LpspRecentsTab(allRecents: recents, filter: $filter)
                .tabItem { Label("Recents", systemImage: "clock.fill") }

            ContentUnavailableView("Favoris", systemImage: "star.fill", description: Text("Lecture seule"))
                .tabItem { Label("Favorites", systemImage: "star.fill") }

            ContentUnavailableView("Contacts", systemImage: "person.circle.fill", description: Text("Voir l'app Contacts"))
                .tabItem { Label("Contacts", systemImage: "person.circle.fill") }

            LpspKeypadPlaceholder()
                .tabItem { Label("Keypad", systemImage: "circle.grid.3x3.fill") }

            ContentUnavailableView("Messagerie", systemImage: "recordingtape", description: Text("Contenu LPSP à venir"))
                .tabItem { Label("Voicemail", systemImage: "recordingtape") }
        }
        .accentColor(.blue)
    }
}

struct LpspRecentsTab: View {
    let allRecents: [LpspCall]
    @Binding var filter: Int

    private var recents: [LpspCall] {
        filter == 1 ? allRecents.filter(\.isMissed) : allRecents
    }

    var body: some View {
        NavigationStack {
            Group {
                if recents.isEmpty {
                    ContentUnavailableView(
                        "Recents",
                        systemImage: "clock",
                        description: Text("Ajoutez des appels dans lpsp.json → content.apps.Telephone")
                    )
                } else {
                    List(recents) { call in
                        LpspCallRow(call: call)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Recents")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Filter", selection: $filter) {
                        Text("All").tag(0)
                        Text("Missed").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 180)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {}.disabled(true)
                }
            }
        }
    }
}

struct LpspCallRow: View {
    let call: LpspCall

    var body: some View {
        HStack(spacing: 12) {
            if call.isOutgoing {
                Image(systemName: "phone.arrow.up.right.fill")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(width: 12)
            } else {
                Spacer().frame(width: 12)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(call.contact)
                    .font(.headline)
                    .foregroundStyle(call.isMissed ? .red : .primary)
                Text(callTypeLabel)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }

            Spacer()

            Text(LpspAdapters.formatShortDate(call.date, fallback: call.dateRaw))
                .font(.subheadline)
                .foregroundStyle(.gray)

            Image(systemName: "info.circle")
                .font(.title2)
                .foregroundStyle(.blue.opacity(0.35))
        }
        .padding(.vertical, 2)
    }

    private var callTypeLabel: String {
        if call.isMissed { return "missed" }
        if call.isOutgoing { return "mobile" }
        return "mobile"
    }
}

struct LpspKeypadPlaceholder: View {
    let columns = Array(repeating: GridItem(.fixed(78), spacing: 24), count: 3)

    var body: some View {
        VStack {
            Spacer()
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"], id: \.self) { key in
                    Circle()
                        .fill(Color(uiColor: .systemGray5))
                        .frame(width: 78, height: 78)
                        .overlay {
                            Text(key)
                                .font(.system(size: 32, weight: .light))
                        }
                        .opacity(0.5)
                }
            }
            Spacer()
            Text("Lecture seule")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.bottom, 24)
        }
    }
}

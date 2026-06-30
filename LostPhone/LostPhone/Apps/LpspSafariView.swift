import SwiftUI

/// Safari — UI clone zerocode117, contenu LPSP (lecture seule, pas de navigation web).
struct LpspSafariView: View {
    let tabs: [LpspSafariTab]
    let history: [LpspSafariSearch]
    @State private var selectedTab: LpspSafariTab?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if !tabs.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Onglets")
                                .font(.headline)
                                .padding(.horizontal, 16)
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                ForEach(tabs) { tab in
                                    Button { selectedTab = tab } label: {
                                        LpspSafariTabCard(tab: tab)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }

                    if !history.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Historique récent")
                                .font(.headline)
                                .padding(.horizontal, 16)
                            ForEach(history) { entry in
                                HStack(spacing: 12) {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .foregroundStyle(.secondary)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(entry.query)
                                            .font(.body)
                                            .lineLimit(2)
                                        Text(LpspAdapters.formatShortDate(entry.date, fallback: entry.dateRaw))
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            }
                        }
                    }

                    if tabs.isEmpty && history.isEmpty {
                        ContentUnavailableView(
                            "Safari",
                            systemImage: "safari.fill",
                            description: Text("Ajoutez onglets et historique dans lpsp.json → content.apps.Safari")
                        )
                        .padding(.top, 40)
                    }
                }
                .padding(.vertical, 16)
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Safari")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(item: $selectedTab) { tab in
                LpspSafariTabDetailView(tab: tab)
            }
        }
    }
}

struct LpspSafariTabCard: View {
    let tab: LpspSafariTab

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(uiColor: .secondarySystemBackground))
                .frame(height: 100)
                .overlay {
                    Image(systemName: "globe")
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            Text(tab.title)
                .font(.caption)
                .lineLimit(2)
                .foregroundStyle(.primary)
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(uiColor: .secondarySystemBackground).opacity(0.5))
        }
    }
}

struct LpspSafariTabDetailView: View {
    let tab: LpspSafariTab

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "lock.fill")
                    .font(.caption2)
                Text(tab.url)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(tab.title)
                        .font(.title2.weight(.semibold))
                    Text("Contenu de la page — lecture seule LPSP.\n\nCe téléphone ne navigue pas sur le web : le joueur lit les traces laissées par le protagoniste.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

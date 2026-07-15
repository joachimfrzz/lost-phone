import SwiftUI

struct WhatsAppSettingsView: View {
    private let rows = ["Compte", "Discussions", "Notifications", "Stockage", "Confidentialité", "Apparence"]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 14) {
                        WhatsAppAvatar(title: "Moi", size: 56)
                        VStack(alignment: .leading) {
                            Text("Propriétaire")
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text("Statut Lost Phone")
                                .font(.subheadline)
                                .foregroundStyle(WhatsAppTheme.secondaryText)
                        }
                    }
                    .listRowBackground(WhatsAppTheme.header)
                }
                Section {
                    ForEach(rows, id: \.self) { row in
                        HStack {
                            Image(systemName: icon(for: row))
                                .frame(width: 28)
                                .foregroundStyle(WhatsAppTheme.accent)
                            Text(row)
                                .foregroundStyle(.white)
                        }
                        .listRowBackground(WhatsAppTheme.listBackground)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(WhatsAppTheme.background)
            .navigationTitle("Vous")
            .toolbarBackground(WhatsAppTheme.header, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    private func icon(for row: String) -> String {
        switch row {
        case "Compte": return "person.crop.circle"
        case "Discussions": return "message"
        case "Notifications": return "bell"
        case "Stockage": return "internaldrive"
        case "Confidentialité": return "lock"
        default: return "paintbrush"
        }
    }
}

#Preview {
    WhatsAppSettingsView()
}

import SwiftUI

struct MessengerMenuView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            Section {
                MessengerSettingsRow(title: "Profil", icon: "person.circle", subtitle: "Lost Phone")
            }
            Section {
                MessengerSettingsRow(title: "Paramètres", icon: "gearshape")
                MessengerSettingsRow(title: "Archives", icon: "archivebox")
            }
        }
        .navigationTitle("Menu")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Fermer") { dismiss() }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MessengerMenuView()
    }
}

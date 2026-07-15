import SwiftUI

/// E08 — Informations discussion 1:1 · E09/E10 via paramètres.
struct MessengerThreadInfoView: View {
    let thread: MessengerThread

    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    MessengerAvatar(
                        title: thread.title,
                        initials: thread.contact?.initials,
                        showOnline: thread.contact?.isOnline == true,
                        size: 88
                    )
                    Text(thread.title)
                        .font(.title2.weight(.semibold))
                    if let label = thread.contact?.activeLabel {
                        Text(label)
                            .foregroundStyle(MessengerTheme.secondaryText)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            Section {
                NavigationLink {
                    MessengerThreadSettingsView(thread: thread)
                } label: {
                    MessengerSettingsRow(title: "Paramètres de la discussion", icon: "slider.horizontal.3")
                }
            }
            Section("Médias partagés") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(0..<4, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(MessengerTheme.secondaryBackground)
                                .frame(width: 72, height: 72)
                                .overlay {
                                    Image(systemName: "photo")
                                        .foregroundStyle(MessengerTheme.secondaryText)
                                }
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }
        }
        .navigationTitle("Infos")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// E09 + E10 — Paramètres discussion.
struct MessengerThreadSettingsView: View {
    let thread: MessengerThread

    var body: some View {
        List {
            Section {
                MessengerSettingsRow(title: "Sourdine", icon: "bell.slash")
                MessengerSettingsRow(title: "Rechercher dans la conversation", icon: "magnifyingglass")
            }
            Section("Messages épinglés") {
                ForEach(MessengerSampleData.pinnedMessages, id: \.self) { msg in
                    Text(msg)
                        .font(.subheadline)
                }
            }
            Section {
                NavigationLink("Confidentialité") {
                    MessengerPrivacySettingsView()
                }
            }
        }
        .navigationTitle("Paramètres")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MessengerPrivacySettingsView: View {
    var body: some View {
        List {
            Section {
                Toggle("Confirmations de lecture", isOn: .constant(true))
                Toggle("Messages éphémères", isOn: .constant(false))
            } footer: {
                Text("Affichage décoratif — pas de modification réelle.")
            }
        }
        .navigationTitle("Confidentialité")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// E11 + E12 — Groupe.
struct MessengerGroupInfoView: View {
    let thread: MessengerThread

    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    MessengerAvatar(title: thread.title, isGroup: true, size: 88)
                    Text(thread.title)
                        .font(.title2.weight(.semibold))
                    if let count = thread.memberCount {
                        Text("\(count) membres")
                            .foregroundStyle(MessengerTheme.secondaryText)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            Section {
                NavigationLink {
                    MessengerGroupSettingsView(thread: thread)
                } label: {
                    MessengerSettingsRow(title: "Paramètres du groupe", icon: "slider.horizontal.3")
                }
            }
            Section("Membres") {
                ForEach(MessengerSampleData.groupMembers, id: \.self) { member in
                    Text(member)
                }
            }
            Section("Médias partagés") {
                MessengerSettingsRow(title: "Voir les photos", icon: "photo.on.rectangle")
            }
        }
        .navigationTitle("Infos groupe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MessengerGroupSettingsView: View {
    let thread: MessengerThread

    var body: some View {
        List {
            Section("Messages épinglés") {
                ForEach(MessengerSampleData.pinnedMessages, id: \.self) { msg in
                    Text(msg)
                }
            }
            Section {
                MessengerSettingsRow(title: "Rechercher", icon: "magnifyingglass")
                MessengerSettingsRow(title: "Notifications", icon: "bell")
            }
        }
        .navigationTitle("Paramètres groupe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MessengerThreadInfoView(thread: MessengerSampleData.threads[0])
    }
}

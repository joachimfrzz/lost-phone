import SwiftUI

struct WhatsAppContactInfoView: View {
    let contact: WhatsAppContact
    let chat: WhatsAppChat

    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    WhatsAppAvatar(title: contact.name, size: 88)
                    Text(contact.name)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                    Text(contact.phone)
                        .foregroundStyle(WhatsAppTheme.secondaryText)
                    if contact.isOnline {
                        Text("en ligne")
                            .foregroundStyle(WhatsAppTheme.accent)
                    } else if let lastSeen = contact.lastSeen {
                        Text("vu \(lastSeen)")
                            .foregroundStyle(WhatsAppTheme.secondaryText)
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(WhatsAppTheme.listBackground)
            }
            actionSection
            mediaSection
            groupsSection
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(WhatsAppTheme.background)
        .navigationTitle("Infos contact")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(WhatsAppTheme.header, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .preferredColorScheme(.dark)
    }

    private var actionSection: some View {
        Section {
            infoRow("Audio", icon: "phone")
            infoRow("Vidéo", icon: "video")
            infoRow("Rechercher", icon: "magnifyingglass")
        }
    }

    private var mediaSection: some View {
        Section("Médias, liens et documents") {
            infoRow("Médias partagés", icon: "photo.on.rectangle")
            infoRow("Documents", icon: "doc")
        }
    }

    private var groupsSection: some View {
        Section("Groupes en commun") {
            Text("Coloc 🏠")
                .foregroundStyle(.white)
        }
    }

    private func infoRow(_ title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 28)
                .foregroundStyle(WhatsAppTheme.accent)
            Text(title)
                .foregroundStyle(.white)
        }
        .listRowBackground(WhatsAppTheme.listBackground)
    }
}

#Preview {
    NavigationStack {
        WhatsAppContactInfoView(contact: WhatsAppSampleData.contacts[0], chat: WhatsAppSampleData.chats[0])
    }
}

import SwiftUI

struct WhatsAppGroupInfoView: View {
    let chat: WhatsAppChat

    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    WhatsAppAvatar(title: chat.title, isGroup: true, size: 88)
                    Text(chat.title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                    if let count = chat.groupMemberCount {
                        Text("\(count) participants")
                            .foregroundStyle(WhatsAppTheme.secondaryText)
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(WhatsAppTheme.listBackground)
            }
            Section {
                groupRow("Audio", icon: "phone")
                groupRow("Vidéo", icon: "video")
                groupRow("Ajouter", icon: "person.badge.plus")
                groupRow("Recherche", icon: "magnifyingglass")
            }
            Section("Membres") {
                ForEach(WhatsAppSampleData.groupMembers, id: \.self) { member in
                    HStack {
                        WhatsAppAvatar(title: member, size: 36)
                        Text(member)
                            .foregroundStyle(.white)
                    }
                    .listRowBackground(WhatsAppTheme.listBackground)
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(WhatsAppTheme.background)
        .navigationTitle("Infos groupe")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(WhatsAppTheme.header, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .preferredColorScheme(.dark)
    }

    private func groupRow(_ title: String, icon: String) -> some View {
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
        WhatsAppGroupInfoView(chat: WhatsAppSampleData.chats[1])
    }
}

import SwiftUI

struct WhatsAppChatListView: View {
    @State private var filter = "Toutes"
    @State private var searchText = ""
    private let filters = ["Toutes", "Non lues", "Favoris", "Groupes"]
    private let chats = WhatsAppSampleData.chats.filter { !$0.isArchived }

    private var filteredChats: [WhatsAppChat] {
        chats.filter { chat in
            let matchesSearch = searchText.isEmpty || chat.title.localizedCaseInsensitiveContains(searchText)
            let matchesFilter: Bool = switch filter {
            case "Non lues": chat.unreadCount > 0
            case "Groupes": chat.isGroup
            case "Favoris": false
            default: true
            }
            return matchesSearch && matchesFilter
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filterBar
                List(filteredChats) { chat in
                    NavigationLink {
                        WhatsAppConversationView(chat: chat)
                    } label: {
                        WhatsAppChatRow(chat: chat)
                    }
                    .listRowBackground(WhatsAppTheme.listBackground)
                    .listRowSeparatorTint(WhatsAppTheme.divider)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .background(WhatsAppTheme.listBackground)
            .navigationTitle("Discussions")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(WhatsAppTheme.header, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .searchable(text: $searchText, prompt: "Rechercher")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 18) {
                        Image(systemName: "camera")
                        Image(systemName: "square.and.pencil")
                    }
                    .foregroundStyle(WhatsAppTheme.accent)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(filters, id: \.self) { item in
                    Button {
                        filter = item
                    } label: {
                        Text(item)
                            .font(.subheadline.weight(.medium))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                            .background(filter == item ? WhatsAppTheme.accent.opacity(0.25) : WhatsAppTheme.header)
                            .foregroundStyle(filter == item ? WhatsAppTheme.accent : WhatsAppTheme.secondaryText)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        .background(WhatsAppTheme.listBackground)
    }
}

private struct WhatsAppChatRow: View {
    let chat: WhatsAppChat

    var body: some View {
        HStack(spacing: 12) {
            WhatsAppAvatar(title: chat.title, isGroup: chat.isGroup)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(chat.title)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.white)
                    Spacer()
                    Text(chat.timeLabel)
                        .font(.caption)
                        .foregroundStyle(WhatsAppTheme.secondaryText)
                }
                HStack {
                    if chat.isRead && chat.unreadCount == 0 {
                        Image(systemName: "checkmark")
                            .font(.caption2)
                            .foregroundStyle(WhatsAppTheme.accent)
                    }
                    Text(chat.preview)
                        .font(.subheadline)
                        .foregroundStyle(WhatsAppTheme.secondaryText)
                        .lineLimit(1)
                    Spacer()
                    if chat.unreadCount > 0 {
                        Text("\(chat.unreadCount)")
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(WhatsAppTheme.unreadBadge)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct WhatsAppAvatar: View {
    let title: String
    var isGroup: Bool = false
    var size: CGFloat = 48

    var body: some View {
        ZStack {
            Circle()
                .fill(WhatsAppTheme.header)
            if isGroup {
                Image(systemName: "person.3.fill")
                    .foregroundStyle(WhatsAppTheme.secondaryText)
            } else {
                Text(String(title.prefix(1)).uppercased())
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(WhatsAppTheme.accent)
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    WhatsAppChatListView()
}

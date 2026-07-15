import SwiftUI

struct MessengerChatListView: View {
    @State private var searchText = ""
    @State private var showMenu = false
    @State private var showNotifications = false
    private let threads = MessengerSampleData.threads

    private var filteredThreads: [MessengerThread] {
        guard !searchText.isEmpty else { return threads }
        return threads.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            List(filteredThreads) { thread in
                NavigationLink {
                    MessengerConversationView(thread: thread)
                } label: {
                    MessengerThreadRow(thread: thread)
                }
                .listRowSeparatorTint(MessengerTheme.divider)
            }
            .listStyle(.plain)
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Rechercher")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showMenu = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(MessengerTheme.headerIcon)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNotifications = true
                    } label: {
                        Image(systemName: "bell")
                            .foregroundStyle(MessengerTheme.headerIcon)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(MessengerTheme.headerIcon)
                }
            }
            .sheet(isPresented: $showMenu) {
                NavigationStack {
                    MessengerMenuView()
                }
            }
            .sheet(isPresented: $showNotifications) {
                NavigationStack {
                    MessengerNotificationsView()
                }
            }
        }
        .tint(MessengerTheme.accent)
    }
}

private struct MessengerThreadRow: View {
    let thread: MessengerThread

    var body: some View {
        HStack(spacing: 12) {
            MessengerAvatar(
                title: thread.title,
                initials: thread.contact?.initials,
                isGroup: thread.isGroup,
                showOnline: thread.contact?.isOnline == true
            )
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(thread.title)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(MessengerTheme.primaryText)
                    Spacer()
                    Text(thread.timeLabel)
                        .font(.caption)
                        .foregroundStyle(MessengerTheme.secondaryText)
                }
                HStack {
                    Text(thread.preview)
                        .font(.subheadline)
                        .foregroundStyle(MessengerTheme.secondaryText)
                        .lineLimit(1)
                    Spacer()
                    if thread.unreadCount > 0 {
                        Text("\(thread.unreadCount)")
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(MessengerTheme.accent)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MessengerChatListView()
}

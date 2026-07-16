import SwiftUI

struct MessengerNotificationRow: Identifiable {
    let notification: MessengerNotification
    let thread: MessengerThread

    var id: String { notification.id }

    static func linked(from items: [MessengerNotification]) -> [MessengerNotificationRow] {
        items.compactMap { item in
            guard let thread = MessengerSampleData.thread(for: item.threadId) else { return nil }
            return MessengerNotificationRow(notification: item, thread: thread)
        }
    }
}

struct MessengerNotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    private let rows = MessengerNotificationRow.linked(from: MessengerSampleData.notifications)

    var body: some View {
        List(rows) { row in
            NavigationLink {
                MessengerConversationView(thread: row.thread)
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(row.notification.title)
                            .font(.body.weight(.semibold))
                        Spacer()
                        Text(row.notification.timeLabel)
                            .font(.caption)
                            .foregroundStyle(MessengerTheme.secondaryText)
                    }
                    Text(row.notification.body)
                        .font(.subheadline)
                        .foregroundStyle(MessengerTheme.secondaryText)
                        .lineLimit(2)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Notifications")
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
        MessengerNotificationsView()
    }
}

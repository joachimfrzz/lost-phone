import SwiftUI

struct MessengerNotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    private let items = MessengerSampleData.notifications

    var body: some View {
        List(items) { item in
            if let thread = MessengerSampleData.thread(for: item.threadId) {
                NavigationLink {
                    MessengerConversationView(thread: thread)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(item.title)
                                .font(.body.weight(.semibold))
                            Spacer()
                            Text(item.timeLabel)
                                .font(.caption)
                                .foregroundStyle(MessengerTheme.secondaryText)
                        }
                        Text(item.body)
                            .font(.subheadline)
                            .foregroundStyle(MessengerTheme.secondaryText)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 4)
                }
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

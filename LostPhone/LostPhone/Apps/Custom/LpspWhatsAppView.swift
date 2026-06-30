import SwiftUI

/// WhatsApp — style clone iOS, contenu 100 % LPSP (lecture seule).
struct LpspWhatsAppView: View {
    let conversations: [LpspConversation]
    @State private var selected: LpspConversation?

    private let headerGreen = Color(red: 0.027, green: 0.369, blue: 0.329)
    private let avatarGreen = Color(red: 0.145, green: 0.827, blue: 0.4)

    var body: some View {
        NavigationStack {
            Group {
                if conversations.isEmpty {
                    ContentUnavailableView(
                        "WhatsApp",
                        systemImage: "message.fill",
                        description: Text("Ajoutez des threads dans lpsp.json → content.apps.WhatsApp")
                    )
                } else {
                    List(conversations) { conversation in
                        Button {
                            selected = conversation
                        } label: {
                            LpspWhatsAppInboxRow(conversation: conversation, avatarColor: avatarGreen)
                        }
                        .buttonStyle(.plain)
                        .listRowBackground(Color(uiColor: .systemBackground))
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("WhatsApp")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(headerGreen, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(item: $selected) { conversation in
                LpspThemedChatDetailView(conversation: conversation, theme: .whatsApp)
                    .toolbarBackground(headerGreen, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)
            }
        }
        .tint(.white)
    }
}

struct LpspWhatsAppInboxRow: View {
    let conversation: LpspConversation
    let avatarColor: Color

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(avatarColor.gradient)
                .frame(width: 48, height: 48)
                .overlay {
                    Text(String(conversation.contactName.prefix(1)))
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.contactName)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.primary)
                    Spacer()
                    Text(LpspAdapters.formatShortDate(conversation.lastDate, fallback: conversation.lastDateRaw))
                        .font(.subheadline)
                        .foregroundStyle(conversation.isUnread ? avatarColor : .secondary)
                }

                Text(conversation.preview)
                    .font(.subheadline)
                    .foregroundStyle(conversation.isUnread ? .primary : .secondary)
                    .lineLimit(2)
                    .fontWeight(conversation.isUnread ? .semibold : .regular)
            }
        }
        .padding(.vertical, 4)
    }
}

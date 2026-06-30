import SwiftUI

/// Messages — UI clone zerocode117, contenu 100 % LPSP (lecture seule).
struct LpspMessagesView: View {
    let conversations: [LpspConversation]
    @State private var selected: LpspConversation?

    var body: some View {
        NavigationStack {
            Group {
                if conversations.isEmpty {
                    ContentUnavailableView(
                        "Messages",
                        systemImage: "message.fill",
                        description: Text("Ajoutez des threads dans lpsp.json → content.apps.Messages")
                    )
                } else {
                    List(conversations) { conversation in
                        Button {
                            selected = conversation
                        } label: {
                            LpspInboxRow(conversation: conversation)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Messages")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Modifier") {}.disabled(true) }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: { Image(systemName: "square.and.pencil") }
                        .disabled(true)
                }
            }
            .navigationDestination(item: $selected) { conversation in
                LpspChatDetailView(conversation: conversation)
            }
        }
        .accentColor(.blue)
    }
}

struct LpspInboxRow: View {
    let conversation: LpspConversation

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.blue.gradient)
                .frame(width: 45, height: 45)
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
                        .foregroundStyle(conversation.isUnread ? .blue : .secondary)
                }

                Text(conversation.preview)
                    .font(.subheadline)
                    .foregroundStyle(conversation.isUnread ? .primary : .secondary)
                    .lineLimit(2)
                    .fontWeight(conversation.isUnread ? .bold : .regular)
            }
        }
        .padding(.vertical, 4)
    }
}

struct LpspChatDetailView: View {
    let conversation: LpspConversation

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(conversation.messages) { message in
                    LpspMessageBubble(message: message)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }
        .navigationTitle(conversation.contactName)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            HStack {
                Image(systemName: "plus")
                Text("Lecture seule — contenu LPSP")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .background(.bar)
        }
    }
}

struct LpspMessageBubble: View {
    let message: LpspMessage

    var body: some View {
        HStack(alignment: .bottom) {
            if message.isUser { Spacer() }

            Text(message.text)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .foregroundStyle(message.isUser ? .white : .primary)
                .background(
                    message.isUser
                        ? AnyShapeStyle(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
                        : AnyShapeStyle(Color(uiColor: .systemGray5))
                )
                .clipShape(ChatBubbleShape(isUser: message.isUser))
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: message.isUser ? .trailing : .leading)

            if !message.isUser { Spacer() }
        }
        .padding(.vertical, 2)
    }
}

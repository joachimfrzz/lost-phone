import SwiftUI

struct WhatsAppConversationView: View {
    let chat: WhatsAppChat
    @State private var showAttachments = false
    @State private var showInfo = false
    @State private var messages: [WhatsAppMessage]

    init(chat: WhatsAppChat) {
        self.chat = chat
        _messages = State(initialValue: WhatsAppSampleData.messages(for: chat.id))
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 6) {
                    ForEach(messages) { message in
                        WhatsAppMessageBubble(message: message)
                    }
                }
                .padding()
            }
            inputBar
        }
        .background(WhatsAppTheme.background)
        .navigationTitle(chat.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(WhatsAppTheme.header, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 16) {
                    Button {
                        showInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    Image(systemName: "video")
                    Image(systemName: "phone")
                }
                .foregroundStyle(WhatsAppTheme.accent)
            }
        }
        .background {
            NavigationLink(isActive: $showInfo) {
                if chat.isGroup {
                    WhatsAppGroupInfoView(chat: chat)
                } else if let contact = chat.contact {
                    WhatsAppContactInfoView(contact: contact, chat: chat)
                }
            } label: {
                EmptyView()
            }
            .hidden()
        }
        .sheet(isPresented: $showAttachments) {
            WhatsAppAttachmentsSheet()
        }
        .preferredColorScheme(.dark)
    }

    private var inputBar: some View {
        HStack(spacing: 10) {
            Button { showAttachments = true } label: {
                Image(systemName: "plus")
                    .font(.title3)
            }
            RoundedRectangle(cornerRadius: 20)
                .fill(WhatsAppTheme.header)
                .frame(height: 36)
                .overlay(alignment: .leading) {
                    Text("Message")
                        .foregroundStyle(WhatsAppTheme.secondaryText)
                        .padding(.horizontal, 12)
                }
            Image(systemName: "camera")
            Image(systemName: "mic")
        }
        .foregroundStyle(WhatsAppTheme.secondaryText)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(WhatsAppTheme.header)
    }
}

private struct WhatsAppMessageBubble: View {
    let message: WhatsAppMessage

    var body: some View {
        switch message.kind {
        case .system(let text):
            Text(text)
                .font(.caption)
                .foregroundStyle(WhatsAppTheme.secondaryText)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
        default:
            HStack {
                if message.isSent { Spacer(minLength: 48) }
                VStack(alignment: message.isSent ? .trailing : .leading, spacing: 4) {
                    if let sender = message.senderName {
                        Text(sender)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(WhatsAppTheme.accent)
                    }
                    bubbleContent
                    HStack(spacing: 4) {
                        Text(message.time)
                            .font(.caption2)
                            .foregroundStyle(WhatsAppTheme.secondaryText.opacity(0.9))
                        if message.isSent {
                            Image(systemName: "checkmark")
                                .font(.caption2)
                                .foregroundStyle(WhatsAppTheme.accent)
                        }
                    }
                }
                if !message.isSent { Spacer(minLength: 48) }
            }
        }
    }

    @ViewBuilder
    private var bubbleContent: some View {
        Group {
            switch message.kind {
            case .text(let text):
                Text(text)
            case .reply(let text, let quoted):
                VStack(alignment: .leading, spacing: 6) {
                    Text(quoted)
                        .font(.caption)
                        .foregroundStyle(WhatsAppTheme.secondaryText)
                        .padding(6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.black.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    Text(text)
                }
            case .voice(let label):
                Label(label, systemImage: "waveform")
            case .document(let name):
                Label(name, systemImage: "doc.fill")
            case .image(let caption):
                Label(caption, systemImage: "photo")
            case .reaction(let text, let emoji):
                HStack {
                    Text(text)
                    Text(emoji)
                }
            case .system:
                EmptyView()
            }
        }
        .font(.body)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(message.isSent ? WhatsAppTheme.sentBubble : WhatsAppTheme.receivedBubble)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    NavigationStack {
        WhatsAppConversationView(chat: WhatsAppSampleData.chats[0])
    }
}

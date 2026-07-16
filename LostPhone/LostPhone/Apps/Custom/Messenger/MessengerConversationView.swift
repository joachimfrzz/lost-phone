import SwiftUI

struct MessengerConversationView: View {
    let thread: MessengerThread
    @State private var messages: [MessengerMessage]
    @State private var showInfo = false
    @State private var showCall = false
    @State private var contextMessage: MessengerMessage?
    @State private var draft = ""

    init(thread: MessengerThread) {
        self.thread = thread
        _messages = State(initialValue: MessengerSampleData.messages(for: thread.id))
    }

    var body: some View {
        VStack(spacing: 0) {
            if let label = thread.contact?.activeLabel {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(MessengerTheme.secondaryText)
                    .padding(.vertical, 4)
            }
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(messages) { message in
                        MessengerMessageBubble(message: message)
                            .onLongPressGesture {
                                contextMessage = message
                            }
                    }
                }
                .padding()
            }
            inputBar
        }
        .background(MessengerTheme.background)
        .navigationTitle(thread.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 18) {
                    Button { showInfo = true } label: {
                        Image(systemName: "info.circle")
                    }
                    Button { showCall = true } label: {
                        Image(systemName: "phone")
                    }
                    Image(systemName: "video")
                }
                .foregroundStyle(MessengerTheme.headerIcon)
            }
        }
        .navigationDestination(isPresented: $showInfo) {
            if thread.isGroup {
                MessengerGroupInfoView(thread: thread)
            } else {
                MessengerThreadInfoView(thread: thread)
            }
        }
        .fullScreenCover(isPresented: $showCall) {
            MessengerCallOverlayView(contactName: thread.title)
        }
        .confirmationDialog("Message", isPresented: Binding(
            get: { contextMessage != nil },
            set: { if !$0 { contextMessage = nil } }
        )) {
            Button("Réagir ❤️") { contextMessage = nil }
            Button("Répondre") { contextMessage = nil }
            Button("Transférer") { contextMessage = nil }
            Button("Annuler", role: .cancel) { contextMessage = nil }
        }
    }

    private var inputBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "plus.circle.fill")
                .font(.title2)
                .foregroundStyle(MessengerTheme.accent)
            HStack {
                TextField("Aa", text: $draft)
                Image(systemName: "face.smiling")
                    .foregroundStyle(MessengerTheme.accent)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(MessengerTheme.secondaryBackground)
            .clipShape(Capsule())
            Image(systemName: "camera.fill")
                .foregroundStyle(MessengerTheme.accent)
            Image(systemName: "thumbs.up.fill")
                .foregroundStyle(MessengerTheme.accent)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(MessengerTheme.background)
        .overlay(alignment: .top) {
            Rectangle().fill(MessengerTheme.divider).frame(height: 0.5)
        }
    }
}

private struct MessengerMessageBubble: View {
    let message: MessengerMessage

    var body: some View {
        switch message.kind {
        case .system(let text):
            Text(text)
                .font(.caption)
                .foregroundStyle(MessengerTheme.secondaryText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
        default:
            HStack(alignment: .bottom) {
                if message.isSent { Spacer(minLength: 56) }
                VStack(alignment: message.isSent ? .trailing : .leading, spacing: 4) {
                    if let sender = message.senderName {
                        Text(sender)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(MessengerTheme.accent)
                    }
                    bubble
                    Text(message.time)
                        .font(.caption2)
                        .foregroundStyle(MessengerTheme.secondaryText)
                }
                if !message.isSent { Spacer(minLength: 56) }
            }
        }
    }

    @ViewBuilder
    private var bubble: some View {
        Group {
            switch message.kind {
            case .text(let text):
                Text(text)
            case .image(let caption):
                VStack(alignment: .leading, spacing: 6) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(MessengerTheme.secondaryBackground)
                        .frame(width: 200, height: 140)
                        .overlay {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(MessengerTheme.secondaryText)
                        }
                    Text(caption)
                        .font(.caption)
                }
            case .reply(let text, let quoted):
                VStack(alignment: .leading, spacing: 6) {
                    Text(quoted)
                        .font(.caption)
                        .foregroundStyle(MessengerTheme.secondaryText)
                        .padding(6)
                        .background(Color.black.opacity(0.06))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    Text(text)
                }
            case .reaction(let text, let emoji):
                HStack { Text(text); Text(emoji) }
            case .system:
                EmptyView()
            }
        }
        .font(.body)
        .foregroundStyle(message.isSent ? .white : MessengerTheme.primaryText)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(message.isSent ? MessengerTheme.sentBubble : MessengerTheme.receivedBubble)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    NavigationStack {
        MessengerConversationView(thread: MessengerSampleData.threads[0])
    }
}

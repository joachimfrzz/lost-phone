import SwiftUI

enum LpspChatTheme {
    case messages
    case whatsApp
    case signal

    var chatBackground: Color {
        switch self {
        case .messages: return Color(uiColor: .systemBackground)
        case .whatsApp: return Color(red: 0.898, green: 0.867, blue: 0.835)
        case .signal: return Color(red: 0.043, green: 0.043, blue: 0.043)
        }
    }

    var composerBackground: Color {
        switch self {
        case .messages: return Color(uiColor: .systemBackground)
        case .whatsApp: return Color(red: 0.941, green: 0.941, blue: 0.941)
        case .signal: return Color(red: 0.11, green: 0.11, blue: 0.118)
        }
    }

    var composerBorder: Color {
        switch self {
        case .messages: return Color(uiColor: .separator)
        case .whatsApp: return Color.black.opacity(0.06)
        case .signal: return Color.white.opacity(0.08)
        }
    }

    var composerFieldBackground: Color {
        switch self {
        case .messages: return Color(uiColor: .systemBackground)
        case .whatsApp: return .white
        case .signal: return Color(red: 0.173, green: 0.173, blue: 0.18)
        }
    }

    var composerAccent: Color {
        switch self {
        case .messages: return .blue
        case .whatsApp: return Color(red: 0.145, green: 0.827, blue: 0.4)
        case .signal: return Color(red: 0.176, green: 0.424, blue: 0.875)
        }
    }

    var placeholder: String {
        switch self {
        case .messages: return "iMessage"
        case .whatsApp: return "Message"
        case .signal: return "Message Signal"
        }
    }

    func incomingBubbleBackground(isUser: Bool) -> AnyShapeStyle {
        switch self {
        case .messages:
            return isUser
                ? AnyShapeStyle(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
                : AnyShapeStyle(Color(uiColor: .systemGray5))
        case .whatsApp:
            return AnyShapeStyle(isUser ? Color(red: 0.863, green: 0.973, blue: 0.776) : .white)
        case .signal:
            return AnyShapeStyle(isUser ? Color(red: 0.176, green: 0.424, blue: 0.875) : Color(red: 0.173, green: 0.173, blue: 0.18))
        }
    }

    func bubbleTextColor(isUser: Bool) -> Color {
        switch self {
        case .messages: return isUser ? .white : .primary
        case .whatsApp: return .primary
        case .signal: return .white
        }
    }

    var usesIMessageTail: Bool { self == .messages }
}

struct LpspThemedMessageBubble: View {
    let message: LpspMessage
    let theme: LpspChatTheme

    var body: some View {
        HStack(alignment: .bottom) {
            if message.isUser { Spacer(minLength: 48) }

            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                messageText
                    .shadow(color: theme == .whatsApp && !message.isUser ? .black.opacity(0.08) : .clear, radius: 1, y: 1)

                if let time = LpspAdapters.formatMessageTime(message), !time.isEmpty {
                    Text(time)
                        .font(.caption2)
                        .foregroundStyle(theme == .signal ? Color(white: 0.55) : .secondary)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.78, alignment: message.isUser ? .trailing : .leading)

            if !message.isUser { Spacer(minLength: 48) }
        }
        .padding(.vertical, 2)
    }

    private var messageText: some View {
        Group {
            if theme.usesIMessageTail {
                bubbleBody.clipShape(ChatBubbleShape(isUser: message.isUser))
            } else {
                bubbleBody.clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
        }
    }

    private var bubbleBody: some View {
        Text(message.text)
            .font(.body)
            .foregroundStyle(theme.bubbleTextColor(isUser: message.isUser))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(theme.incomingBubbleBackground(isUser: message.isUser))
    }
}

struct LpspReadOnlyComposer: View {
    let theme: LpspChatTheme

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Image(systemName: "plus")
                .font(.system(size: 20))
                .foregroundStyle(theme == .signal ? Color(white: 0.4) : Color(uiColor: .systemGray2))
                .frame(width: 32, height: 32)

            Text(theme.placeholder)
                .font(.body)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(theme.composerFieldBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(theme.composerBorder, lineWidth: 0.5)
                }

            Image(systemName: "arrow.up.circle.fill")
                .font(.system(size: 28))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, theme.composerAccent.opacity(0.35))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(theme.composerBackground)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(theme.composerBorder)
                .frame(height: 0.5)
        }
    }
}

struct LpspThemedChatDetailView: View {
    let conversation: LpspConversation
    let theme: LpspChatTheme
    var headerAccessory: AnyView? = nil

    var body: some View {
        VStack(spacing: 0) {
            if let headerAccessory {
                headerAccessory
            }

            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(conversation.messages) { message in
                        LpspThemedMessageBubble(message: message, theme: theme)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            }
            .background(theme.chatBackground)

            LpspReadOnlyComposer(theme: theme)
        }
        .navigationTitle(conversation.contactName)
        .navigationBarTitleDisplayMode(.inline)
        .background(theme.chatBackground)
    }
}

struct LpspSignalEncryptionBanner: View {
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "lock.fill")
                .font(.caption2)
            Text("Chiffré de bout en bout")
                .font(.caption)
        }
        .foregroundStyle(Color(white: 0.55))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
        .background(Color(red: 0.043, green: 0.043, blue: 0.043))
    }
}

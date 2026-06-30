import SwiftUI
import Combine

// MARK: - Models (clone zerocode117)

struct Message: Identifiable, Equatable {
    let id: UUID
    let content: String
    let isUser: Bool
    let date: Date

    init(stableId: String, content: String, isUser: Bool, date: Date) {
        self.id = LpspStableId.uuid(stableId)
        self.content = content
        self.isUser = isUser
        self.date = date
    }
}

struct Conversation: Identifiable, Hashable {
    let id: UUID
    let contactName: String
    let avatarColor: Color
    let messages: [Message]
    let isUnread: Bool

    init(stableId: String, contactName: String, avatarColor: Color, messages: [Message], isUnread: Bool) {
        self.id = LpspStableId.uuid(stableId)
        self.contactName = contactName
        self.avatarColor = avatarColor
        self.messages = messages
        self.isUnread = isUnread
    }

    var lastMessage: String { messages.last?.content ?? "" }
    var lastDate: Date { messages.last?.date ?? .distantPast }

    static func == (lhs: Conversation, rhs: Conversation) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

// MARK: - View Model

@MainActor
class MessagesViewModel: ObservableObject {
    let conversations: [Conversation]

    init(conversations: [Conversation] = []) {
        self.conversations = conversations
    }
}

// MARK: - Main Views

struct MessagesView: View {
    @StateObject private var viewModel: MessagesViewModel

    init(viewModel: MessagesViewModel = MessagesViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.conversations.isEmpty {
                    ContentUnavailableView("Messages", systemImage: "message.fill", description: Text("Aucune conversation"))
                } else {
                    List(viewModel.conversations) { conversation in
                        NavigationLink(value: conversation) {
                            InboxRow(conversation: conversation)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Messages")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Edit") {}
                        .disabled(true)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: { Image(systemName: "square.and.pencil") }
                        .disabled(true)
                }
            }
            .navigationDestination(for: Conversation.self) { conversation in
                ChatDetailView(conversation: conversation)
            }
        }
        .accentColor(.blue)
    }
}

struct InboxRow: View {
    let conversation: Conversation

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(conversation.avatarColor.gradient)
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
                    Spacer()
                    Text(formatDate(conversation.lastDate))
                        .font(.subheadline)
                        .foregroundStyle(conversation.isUnread ? .blue : .secondary)
                }

                Text(conversation.lastMessage)
                    .font(.subheadline)
                    .foregroundStyle(conversation.isUnread ? .primary : .secondary)
                    .lineLimit(2)
                    .fontWeight(conversation.isUnread ? .bold : .regular)
            }
        }
        .padding(.vertical, 4)
    }

    private func formatDate(_ date: Date) -> String {
        if date == .distantPast { return "" }
        if Calendar.current.isDateInToday(date) {
            return date.formatted(date: .omitted, time: .shortened)
        }
        return date.formatted(date: .numeric, time: .omitted)
    }
}

// MARK: - Chat Detail

struct ChatDetailView: View {
    let conversation: Conversation
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(conversation.messages) { msg in
                        MessageBubble(message: msg)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            }

            if readOnly {
                HStack(alignment: .bottom, spacing: 12) {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .foregroundStyle(Color(uiColor: .systemGray2))
                    Text("iMessage")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .strokeBorder(Color(uiColor: .systemGray4), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(uiColor: .systemBackground))
            }
        }
        .navigationTitle(conversation.contactName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "person.circle")
                    .font(.title3)
            }
        }
    }
}

struct MessageBubble: View {
    let message: Message

    var body: some View {
        HStack(alignment: .bottom) {
            if message.isUser { Spacer() }

            Text(message.content)
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

struct ChatBubbleShape: Shape {
    let isUser: Bool

    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let radius: CGFloat = 18
        let path = UIBezierPath()

        if isUser {
            path.move(to: CGPoint(x: width - 4, y: height))
            path.addCurve(to: CGPoint(x: width, y: height - 4),
                          controlPoint1: CGPoint(x: width - 2, y: height),
                          controlPoint2: CGPoint(x: width, y: height - 1))
            path.addLine(to: CGPoint(x: width, y: radius))
            path.addArc(withCenter: CGPoint(x: width - radius, y: radius), radius: radius, startAngle: 0, endAngle: -.pi / 2, clockwise: false)
            path.addLine(to: CGPoint(x: radius, y: 0))
            path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: -.pi / 2, endAngle: .pi, clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: height - radius))
            path.addArc(withCenter: CGPoint(x: radius, y: height - radius), radius: radius, startAngle: .pi, endAngle: .pi / 2, clockwise: false)
            path.addLine(to: CGPoint(x: width - 12, y: height))
            path.addQuadCurve(to: CGPoint(x: width - 4, y: height), controlPoint: CGPoint(x: width - 8, y: height))
        } else {
            path.move(to: CGPoint(x: 4, y: height))
            path.addCurve(to: CGPoint(x: 0, y: height - 4),
                          controlPoint1: CGPoint(x: 2, y: height),
                          controlPoint2: CGPoint(x: 0, y: height - 1))
            path.addLine(to: CGPoint(x: 0, y: radius))
            path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: .pi, endAngle: -.pi / 2, clockwise: true)
            path.addLine(to: CGPoint(x: width - radius, y: 0))
            path.addArc(withCenter: CGPoint(x: width - radius, y: radius), radius: radius, startAngle: -.pi / 2, endAngle: 0, clockwise: true)
            path.addLine(to: CGPoint(x: width, y: height - radius))
            path.addArc(withCenter: CGPoint(x: width - radius, y: height - radius), radius: radius, startAngle: 0, endAngle: .pi / 2, clockwise: true)
            path.addLine(to: CGPoint(x: 12, y: height))
            path.addQuadCurve(to: CGPoint(x: 4, y: height), controlPoint: CGPoint(x: 8, y: height))
        }

        return Path(path.cgPath)
    }
}

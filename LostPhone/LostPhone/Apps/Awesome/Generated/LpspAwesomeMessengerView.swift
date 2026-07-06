import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/messenger
// Meliwat/awesome-ios-design-md/messaging/messenger/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeMessengerView: View {
    var conversations: [LpspConversation]?

    var body: some View {
        let storyThreads = conversations?.isEmpty == false ? conversations : nil
        let threads = storyThreads ?? LpspMessengerShowroomData.conversations
        LpspMessengerShowroomRoot(
            store: LpspMessengerStore(conversations: threads),
            isStoryMode: storyThreads != nil
        )
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspMessengerFonts {
    static let msgLargeTitle   = Font.system(size: 28, weight: .regular)
    static let msgConvoName    = Font.system(size: 17, weight: .regular)
    static let msgConvoUnread  = Font.system(size: 17, weight: .regular)
    static let msgThreadTitle  = Font.system(size: 16, weight: .regular)
    static let msgMessageBody  = Font.system(size: 16, weight: .regular)
    static let msgPreview      = Font.system(size: 15, weight: .regular)
    static let msgSection      = Font.system(size: 13, weight: .regular)
    static let msgTimestamp    = Font.system(size: 13, weight: .regular)
    static let msgBubbleMeta   = Font.system(size: 12, weight: .regular)
    static let msgReactCount   = Font.system(size: 12, weight: .regular)
    static let msgButton       = Font.system(size: 16, weight: .regular)
    static let msgTab          = Font.system(size: 10, weight: .regular)
    static let msgActiveNow    = Font.system(size: 12, weight: .regular)
    static let msgSystem       = Font.system(size: 13, weight: .regular)
    static func messenger(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspMessengerTokens {
    // MARK: - Gradient stops (outgoing bubble only)
    static let msgGradBlue   = Color(red: 0.039, green: 0.486, blue: 1.000) // #0A7CFF
    static let msgGradViolet = Color(red: 0.616, green: 0.306, blue: 0.867) // #9D4EDD
    static let msgGradPink   = Color(red: 1.000, green: 0.361, blue: 0.627) // #FF5CA0

    // MARK: - UI blue
    static let msgBlue        = Color(red: 0.039, green: 0.486, blue: 1.000) // #0A7CFF
    static let msgBluePressed = Color(red: 0.031, green: 0.400, blue: 0.839) // #0866D6

    // MARK: - Canvas & Surfaces
    static let msgCanvas       = Color(red: 1, green: 1, blue: 1)             // #FFFFFF
    static let msgCanvasDark   = Color.black                                  // #000000 (true black)
    static let msgSurface      = Color(red: 0.945, green: 0.945, blue: 0.949) // #F1F1F2
    static let msgSurfaceDark  = Color(red: 0.110, green: 0.110, blue: 0.114) // #1C1C1D
    static let msgIncoming     = Color(red: 0.945, green: 0.945, blue: 0.949) // #F1F1F2
    static let msgIncomingDark = Color(red: 0.188, green: 0.188, blue: 0.188) // #303030
    static let msgDivider      = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
    static let msgDividerDark  = Color(red: 0.227, green: 0.231, blue: 0.235) // #3A3B3C

    // MARK: - Text
    static let msgTextPrimary   = Color(red: 0.020, green: 0.020, blue: 0.020) // #050505
    static let msgTextPrimaryD  = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
    static let msgTextSecondary = Color(red: 0.396, green: 0.404, blue: 0.420) // #65676B
    static let msgTextTertiary  = Color(red: 0.541, green: 0.553, blue: 0.569) // #8A8D91

    // MARK: - Semantic
    static let msgActiveGreen = Color(red: 0.192, green: 0.820, blue: 0.345)  // #31D158
    static let msgError       = Color(red: 0.980, green: 0.220, blue: 0.243)  // #FA383E
    static let msgSuccess     = Color(red: 0.192, green: 0.635, blue: 0.298)  // #31A24C
}

private enum LpspMessengerGradients {
    // The signature outgoing-bubble ribbon (≈135°)
    static let msgBubble = LinearGradient(
        colors: [LpspMessengerTokens.msgGradBlue, LpspMessengerTokens.msgGradViolet, LpspMessengerTokens.msgGradPink],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}

// MARK: - Données & état

@MainActor
fileprivate final class LpspMessengerStore: ObservableObject {
    @Published private(set) var threads: [LpspConversation]
    @Published var messagesByThread: [String: [LpspMessengerDisplayMessage]]

    init(conversations: [LpspConversation]) {
        self.threads = conversations
        self.messagesByThread = Dictionary(
            uniqueKeysWithValues: conversations.map { ($0.id, LpspMessengerStore.makeDisplayMessages(for: $0)) }
        )
    }

    func thread(id: String) -> LpspConversation? {
        threads.first { $0.id == id }
    }

    func markAsRead(threadId: String) {
        guard let index = threads.firstIndex(where: { $0.id == threadId }),
              threads[index].isUnread else { return }
        let old = threads[index]
        threads[index] = LpspConversation(
            id: old.id,
            contactName: old.contactName,
            messages: old.messages,
            isUnread: false
        )
    }

    func send(text: String, threadId: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let now = Date()
        let time = LpspAdapters.formatSignalBubbleTime(raw: nil, date: now)
        var bucket = messagesByThread[threadId, default: []]
        if let last = bucket.last, last.isOutgoing {
            bucket[bucket.count - 1] = LpspMessengerDisplayMessage(
                id: last.id,
                text: last.text,
                isOutgoing: true,
                time: last.time,
                showsMeta: false,
                reaction: last.reaction,
                readState: last.readState
            )
        }
        bucket.append(
            LpspMessengerDisplayMessage(
                id: UUID().uuidString,
                text: trimmed,
                isOutgoing: true,
                time: time,
                showsMeta: true,
                reaction: nil,
                readState: .delivered
            )
        )
        messagesByThread[threadId] = bucket

        if let index = threads.firstIndex(where: { $0.id == threadId }) {
            let old = threads[index]
            let newMessage = LpspMessage(
                id: "sent-\(UUID().uuidString)",
                text: trimmed,
                isUser: true,
                date: now,
                dateRaw: time
            )
            threads[index] = LpspConversation(
                id: old.id,
                contactName: old.contactName,
                messages: old.messages + [newMessage],
                isUnread: false
            )
        }
    }

    private static func makeDisplayMessages(for conversation: LpspConversation) -> [LpspMessengerDisplayMessage] {
        if conversation.id == LpspMessengerShowroomData.theoThreadId {
            return LpspMessengerShowroomData.theoDisplayMessages
        }
        return buildDisplayMessages(from: conversation.messages)
    }

    static func buildDisplayMessages(from messages: [LpspMessage]) -> [LpspMessengerDisplayMessage] {
        messages.enumerated().map { index, message in
            let isOutgoing = message.isUser
            let nextSame = index < messages.count - 1 && messages[index + 1].isUser == isOutgoing
            let showsMeta = !nextSame
            let time = showsMeta ? LpspAdapters.formatSignalBubbleTime(message) : ""
            let readState: LpspMessengerReadState? = isOutgoing
                ? (showsMeta ? .delivered : nil)
                : nil
            return LpspMessengerDisplayMessage(
                id: message.id,
                text: message.text,
                isOutgoing: isOutgoing,
                time: time,
                showsMeta: showsMeta,
                reaction: nil,
                readState: readState
            )
        }
    }
}

fileprivate struct LpspMessengerDisplayMessage: Identifiable {
    let id: String
    let text: String
    let isOutgoing: Bool
    let time: String
    let showsMeta: Bool
    let reaction: (emoji: String, count: Int)?
    let readState: LpspMessengerReadState?
}

fileprivate enum LpspMessengerReadState {
    case sent, delivered, read
}

private enum LpspMessengerShowroomData {
    static let theoThreadId = "msg-theo-marchetti"

    static var conversations: [LpspConversation] {
        [
            LpspConversation(
                id: theoThreadId,
                contactName: "Theo Marchetti",
                messages: theoPlainMessages,
                isUnread: false
            ),
            LpspConversation(
                id: "msg-lea",
                contactName: "Léa Dupont",
                messages: [
                    LpspMessage(id: "l1", text: "Merci pour hier !", isUser: false, date: nil, dateRaw: "Hier"),
                    LpspMessage(id: "l2", text: "Avec plaisir 😊", isUser: true, date: nil, dateRaw: "Hier"),
                ],
                isUnread: true
            ),
            LpspConversation(
                id: "msg-famille",
                contactName: "Famille",
                messages: [
                    LpspMessage(id: "f1", text: "Photo: vacances", isUser: false, date: nil, dateRaw: "Lun."),
                ],
                isUnread: false
            ),
        ]
    }

    static let theoDisplayMessages: [LpspMessengerDisplayMessage] = [
        .init(id: "t1", text: "Did you see the new gradient bubbles?", isOutgoing: false, time: "", showsMeta: false, reaction: nil, readState: nil),
        .init(id: "t2", text: "They flow down the whole conversation now 🌈", isOutgoing: false, time: "9:36 AM", showsMeta: true, reaction: nil, readState: nil),
        .init(id: "t3", text: "Yes! It looks like one continuous ribbon.", isOutgoing: true, time: "", showsMeta: false, reaction: nil, readState: .read),
        .init(id: "t4", text: "Way more fun than a flat color.", isOutgoing: true, time: "9:38 AM", showsMeta: true, reaction: ("❤️", 2), readState: .read),
        .init(id: "t5", text: "Long-press one to react 👇", isOutgoing: false, time: "", showsMeta: true, reaction: nil, readState: nil),
    ]

    private static var theoPlainMessages: [LpspMessage] {
        theoDisplayMessages.map { msg in
            LpspMessage(
                id: msg.id,
                text: msg.text,
                isUser: msg.isOutgoing,
                date: nil,
                dateRaw: msg.time.isEmpty ? nil : msg.time
            )
        }
    }
}

private struct LpspMessengerThreadHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct LpspMessengerBubbleYKey: PreferenceKey {
    static var defaultValue: [String: CGFloat] = [:]
    static func reduce(value: inout [String: CGFloat], nextValue: () -> [String: CGFloat]) {
        value.merge(nextValue()) { $1 }
    }
}





fileprivate struct LpspMessengerSpectrBubble: View {
    let message: LpspMessengerDisplayMessage
    let threadHeight: CGFloat
    let bubbleOriginY: CGFloat
    let isDark: Bool

    private var isLastInRun: Bool { message.showsMeta }
    private var incomingFill: Color { isDark ? LpspMessengerTokens.msgIncomingDark : LpspMessengerTokens.msgIncoming }
    private var incomingText: Color { isDark ? LpspMessengerTokens.msgTextPrimaryD : LpspMessengerTokens.msgTextPrimary }

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if message.isOutgoing { Spacer(minLength: 48) }

            ZStack(alignment: message.isOutgoing ? .bottomTrailing : .bottomLeading) {
                VStack(alignment: message.isOutgoing ? .trailing : .leading, spacing: 4) {
                    Text(message.text)
                        .font(LpspMessengerFonts.msgMessageBody)
                        .foregroundStyle(message.isOutgoing ? .white : incomingText)
                        .multilineTextAlignment(message.isOutgoing ? .trailing : .leading)
                        .fixedSize(horizontal: false, vertical: true)

                    if message.showsMeta {
                        HStack(spacing: 4) {
                            if !message.time.isEmpty {
                                Text(message.time)
                                    .font(LpspMessengerFonts.msgBubbleMeta)
                            }
                            if message.isOutgoing, message.readState != nil {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 10, weight: .bold))
                            }
                        }
                        .foregroundStyle(
                            message.isOutgoing
                                ? Color.white.opacity(0.75)
                                : LpspMessengerTokens.msgTextSecondary
                        )
                    }
                }
                .padding(.vertical, 9)
                .padding(.horizontal, 14)
                .background {
                    if message.isOutgoing {
                        LinearGradient(
                            colors: [
                                LpspMessengerTokens.msgGradBlue,
                                LpspMessengerTokens.msgGradViolet,
                                LpspMessengerTokens.msgGradPink,
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: max(threadHeight, 1))
                        .offset(y: -bubbleOriginY)
                        .frame(height: 0, alignment: .top)
                    } else {
                        incomingFill
                    }
                }
                .clipShape(
                    LpspMessengerBubbleShape(
                        radius: 18,
                        tightCorner: message.isOutgoing ? .bottomRight : .bottomLeft,
                        tight: isLastInRun ? 6 : 18
                    )
                )
                .frame(maxWidth: 270, alignment: message.isOutgoing ? .trailing : .leading)

                if let reaction = message.reaction {
                    LpspMessengerReactionBadge(emoji: reaction.emoji, count: reaction.count)
                        .offset(x: message.isOutgoing ? 8 : -8, y: 10)
                }
            }

            if !message.isOutgoing { Spacer(minLength: 48) }
        }
        .padding(.horizontal, 10)
    }
}

fileprivate struct LpspMessengerBubbleShape: Shape {
    var radius: CGFloat
    var tightCorner: UIRectCorner
    var tight: CGFloat
    func path(in rect: CGRect) -> Path {
        let normal: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        let p = UIBezierPath(roundedRect: rect, byRoundingCorners: normal.subtracting(tightCorner),
                             cornerRadii: CGSize(width: radius, height: radius))
        let tp = UIBezierPath(roundedRect: rect, byRoundingCorners: tightCorner,
                              cornerRadii: CGSize(width: tight, height: tight))
        p.append(tp)
        return Path(p.cgPath)
    }
}

fileprivate struct LpspMessengerReactionsPopover: View {
    let onPick: (String) -> Void
    @State private var shown = false
    private let emoji = ["👍", "❤️", "😆", "😮", "😢", "😡"]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(Array(emoji.enumerated()), id: \.offset) { i, e in
                Text(e)
                    .font(.system(size: 30))
                    .scaleEffect(shown ? 1 : 0.4)
                    .animation(.spring(response: 0.3, dampingFraction: 0.55)
                        .delay(Double(i) * 0.02), value: shown)
                    .onTapGesture { onPick(e) }
            }
            Image(systemName: "plus")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(LpspMessengerTokens.msgTextSecondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            Capsule().fill(LpspMessengerTokens.msgCanvas)
                .shadow(color: .black.opacity(0.18), radius: 14, y: 8)
        )
        .scaleEffect(shown ? 1 : 0.7)
        .animation(.spring(response: 0.32, dampingFraction: 0.6), value: shown)
        .onAppear { shown = true }
    }
}

// Corner reaction badge that lands with a bounce
fileprivate struct LpspMessengerReactionBadge: View {
    let emoji: String
    let count: Int
    @State private var landed = false
    var body: some View {
        HStack(spacing: 3) {
            Text(emoji).font(.system(size: 14))
            if count > 1 { Text("\(count)").font(LpspMessengerFonts.msgReactCount).foregroundStyle(LpspMessengerTokens.msgTextSecondary) }
        }
        .padding(.horizontal, 6).padding(.vertical, 3)
        .background(Capsule().fill(LpspMessengerTokens.msgCanvas)
            .overlay(Capsule().stroke(LpspMessengerTokens.msgDivider, lineWidth: 1)))
        .scaleEffect(landed ? 1 : 1.25)
        .animation(.spring(response: 0.25, dampingFraction: 0.5), value: landed)
        .onAppear { landed = true }
    }
}

fileprivate struct LpspMessengerComposerBar: View {
    @Binding var text: String
    let isDark: Bool
    let onSend: () -> Void

    private var hasText: Bool { !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    var body: some View {
        HStack(spacing: 10) {
            if !hasText {
                HStack(spacing: 16) {
                    ForEach(["camera", "photo", "mic"], id: \.self) {
                        Image(systemName: $0).font(.system(size: 22))
                            .foregroundStyle(LpspMessengerTokens.msgBlue)
                    }
                }
                .transition(.opacity.combined(with: .scale))
            }
            HStack {
                TextField("Aa", text: $text, axis: .vertical)
                    .font(LpspMessengerFonts.msgMessageBody).lineLimit(1...5)
                    .foregroundStyle(isDark ? LpspMessengerTokens.msgTextPrimaryD : LpspMessengerTokens.msgTextPrimary)
                Image(systemName: "face.smiling").font(.system(size: 20))
                    .foregroundStyle(LpspMessengerTokens.msgTextSecondary)
            }
            .padding(.horizontal, 12).frame(minHeight: 36)
            .background(Capsule().fill(isDark ? LpspMessengerTokens.msgSurfaceDark : LpspMessengerTokens.msgSurface))

            Button {
                if hasText { onSend() }
            } label: {
                if hasText {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16, weight: .bold)).foregroundStyle(.white)
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(LpspMessengerTokens.msgBlue))
                } else {
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 22)).foregroundStyle(LpspMessengerTokens.msgBlue)
                        .frame(width: 32, height: 32)
                }
            }
            .sensoryFeedback(.impact(weight: .light), trigger: hasText)
        }
        .padding(.horizontal, 10).padding(.vertical, 8)
        .background(isDark ? LpspMessengerTokens.msgCanvasDark : LpspMessengerTokens.msgCanvas)
        .animation(.spring(response: 0.18, dampingFraction: 0.7), value: hasText)
    }
}

fileprivate struct LpspMessengerConversationRow: View {
    let name: String
    let preview: String
    let time: String
    let unread: Bool
    let activeNow: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                Circle().fill(LpspMessengerTokens.msgSurface).frame(width: 56, height: 56)
                if activeNow {
                    Circle().fill(LpspMessengerTokens.msgActiveGreen)
                        .frame(width: 14, height: 14)
                        .overlay(Circle().stroke(LpspMessengerTokens.msgCanvas, lineWidth: 2))
                }
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(unread ? LpspMessengerFonts.msgConvoUnread : LpspMessengerFonts.msgConvoName)
                    .foregroundStyle(LpspMessengerTokens.msgTextPrimary)
                Text(preview).font(LpspMessengerFonts.msgPreview)
                    .foregroundStyle(LpspMessengerTokens.msgTextSecondary).lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Text(time).font(LpspMessengerFonts.msgTimestamp).foregroundStyle(LpspMessengerTokens.msgTextSecondary)
                if unread { Circle().fill(LpspMessengerTokens.msgBlue).frame(width: 8, height: 8) }
            }
        }
        .padding(.vertical, 12).padding(.horizontal, 16)
        .frame(height: 72).contentShape(Rectangle())
    }
}

fileprivate struct LpspMessengerTypingBubble: View {
    @State private var phase = 0.0
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { i in
                Circle().fill(LpspMessengerTokens.msgTextSecondary).frame(width: 7, height: 7)
                    .offset(y: sin(phase + Double(i) * 0.6) * 3)
            }
        }
        .padding(.vertical, 12).padding(.horizontal, 14)
        .background(Capsule().fill(LpspMessengerTokens.msgIncoming))
        .onAppear {
            withAnimation(.linear(duration: 0.9).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
        }
    }
}



// MARK: - Écrans interactifs (Spectr + LPSP)

private enum LpspMessengerTab: Int, CaseIterable {
    case chats, marketplace, stories

    var label: String {
        switch self {
        case .chats: "Chats"
        case .marketplace: "Marketplace"
        case .stories: "Stories"
        }
    }

    var icon: String {
        switch self {
        case .chats: "message.fill"
        case .marketplace: "storefront.fill"
        case .stories: "play.circle.fill"
        }
    }
}

private enum LpspMessengerChatRoute: Hashable {
    case thread(String)
}

private enum LpspMessengerContactStyle {
    static func isActiveNow(_ name: String) -> Bool {
        name.contains("Theo")
    }
}

private struct LpspMessengerShowroomRoot: View {
    @ObservedObject var store: LpspMessengerStore
    var isStoryMode = false
    @State private var selectedTab: LpspMessengerTab = .chats
    @State private var chatsPath = NavigationPath()

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .chats:
                    LpspMessengerChatsTabScreen(store: store, path: $chatsPath, isStoryMode: isStoryMode)
                case .marketplace:
                    LpspMessengerMarketplaceTabScreen()
                case .stories:
                    LpspMessengerStoriesTabScreen(isStoryMode: isStoryMode)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspMessengerSpectrTabBar(selectedTab: $selectedTab)
        }
        .background(LpspMessengerTokens.msgCanvas.ignoresSafeArea())
    }
}

private struct LpspMessengerSpectrTabBar: View {
    @Binding var selectedTab: LpspMessengerTab

    var body: some View {
        HStack {
            ForEach(LpspMessengerTab.allCases, id: \.rawValue) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: 3) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22))
                        Text(tab.label)
                            .font(LpspMessengerFonts.msgTab)
                    }
                    .foregroundStyle(
                        selectedTab == tab
                            ? LpspMessengerTokens.msgBlue
                            : LpspMessengerTokens.msgTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 4)
        .background(LpspMessengerTokens.msgCanvas)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspMessengerTokens.msgDivider)
                .frame(height: 0.5)
        }
    }
}

private struct LpspMessengerChatsTabScreen: View {
    @ObservedObject var store: LpspMessengerStore
    @Binding var path: NavigationPath
    var isStoryMode = false

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(store.threads) { thread in
                    Button {
                        path.append(LpspMessengerChatRoute.thread(thread.id))
                    } label: {
                        LpspMessengerConversationRow(
                            name: thread.contactName,
                            preview: thread.preview,
                            time: LpspAdapters.formatShortDate(thread.lastDate, fallback: thread.lastDateRaw),
                            unread: thread.isUnread,
                            activeNow: LpspMessengerContactStyle.isActiveNow(thread.contactName)
                        )
                    }
                    .buttonStyle(.plain)
                    .listRowSeparatorTint(LpspMessengerTokens.msgDivider)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: LpspMessengerChatRoute.self) { route in
                if case .thread(let id) = route {
                    LpspMessengerChatScreen(
                        store: store,
                        threadId: id,
                        isStoryMode: isStoryMode,
                        onBack: { path.removeLast() }
                    )
                }
            }
        }
    }
}

private struct LpspMessengerChatScreen: View {
    @ObservedObject var store: LpspMessengerStore
    let threadId: String
    var isStoryMode = false
    let onBack: () -> Void

    @State private var draft = ""
    @State private var threadHeight: CGFloat = 600
    @State private var bubbleYs: [String: CGFloat] = [:]
    @FocusState private var inputFocused: Bool

    private var thread: LpspConversation? { store.thread(id: threadId) }
    private var contactName: String { thread?.contactName ?? "" }
    private var messages: [LpspMessengerDisplayMessage] { store.messagesByThread[threadId] ?? [] }
    private var isTheoThread: Bool { threadId == LpspMessengerShowroomData.theoThreadId }

    var body: some View {
        VStack(spacing: 0) {
            LpspMessengerThreadHeader(
                contactName: contactName,
                subtitle: isTheoThread ? "Active now" : nil,
                isActiveNow: LpspMessengerContactStyle.isActiveNow(contactName),
                onBack: onBack
            )
            LpspMessengerThreadBody(
                messages: messages,
                threadHeight: $threadHeight,
                bubbleYs: $bubbleYs
            )
            LpspMessengerComposerBar(text: $draft, isDark: true, onSend: sendMessage)
        }
        .background(LpspMessengerTokens.msgCanvasDark.ignoresSafeArea())
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .onAppear { store.markAsRead(threadId: threadId) }
    }

    private func sendMessage() {
        store.send(text: draft, threadId: threadId)
        draft = ""
        inputFocused = false
    }
}

private struct LpspMessengerThreadHeader: View {
    let contactName: String
    let subtitle: String?
    let isActiveNow: Bool
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(LpspMessengerTokens.msgBlue)
            }
            .buttonStyle(.plain)

            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(LpspMessengerTokens.msgSurfaceDark)
                    .frame(width: 32, height: 32)
                if isActiveNow {
                    Circle()
                        .fill(LpspMessengerTokens.msgActiveGreen)
                        .frame(width: 10, height: 10)
                        .overlay(Circle().stroke(LpspMessengerTokens.msgCanvasDark, lineWidth: 2))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(contactName)
                    .font(LpspMessengerFonts.msgThreadTitle)
                    .foregroundStyle(LpspMessengerTokens.msgTextPrimaryD)
                if let subtitle {
                    Text(subtitle)
                        .font(LpspMessengerFonts.msgActiveNow)
                        .foregroundStyle(LpspMessengerTokens.msgTextSecondary)
                }
            }

            Spacer()

            HStack(spacing: 18) {
                Image(systemName: "phone.fill")
                Image(systemName: "video.fill")
            }
            .font(.system(size: 18))
            .foregroundStyle(LpspMessengerTokens.msgBlue)
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(LpspMessengerTokens.msgCanvasDark)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(LpspMessengerTokens.msgDividerDark)
                .frame(height: 0.5)
        }
    }
}

private struct LpspMessengerThreadBody: View {
    let messages: [LpspMessengerDisplayMessage]
    @Binding var threadHeight: CGFloat
    @Binding var bubbleYs: [String: CGFloat]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 2) {
                    ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in
                        if index > 0 && messages[index - 1].isOutgoing != message.isOutgoing {
                            Color.clear.frame(height: 8)
                        }
                        LpspMessengerSpectrBubble(
                            message: message,
                            threadHeight: threadHeight,
                            bubbleOriginY: bubbleYs[message.id] ?? 0,
                            isDark: true
                        )
                        .id(message.id)
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(
                                    key: LpspMessengerBubbleYKey.self,
                                    value: [message.id: geo.frame(in: .named("msgThread")).minY]
                                )
                            }
                        )
                    }
                }
                .padding(.vertical, 8)
                .background(
                    GeometryReader { geo in
                        Color.clear.preference(key: LpspMessengerThreadHeightKey.self, value: geo.size.height)
                    }
                )
            }
            .coordinateSpace(name: "msgThread")
            .background(LpspMessengerTokens.msgCanvasDark)
            .onPreferenceChange(LpspMessengerThreadHeightKey.self) { threadHeight = $0 }
            .onPreferenceChange(LpspMessengerBubbleYKey.self) { bubbleYs = $0 }
            .onAppear {
                if let last = messages.last {
                    proxy.scrollTo(last.id, anchor: .bottom)
                }
            }
            .onChange(of: messages.count) { _, _ in
                if let last = messages.last {
                    withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                }
            }
        }
    }
}

private struct LpspMessengerMarketplaceTabScreen: View {
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspMessengerTokens.msgBlue.opacity(0.12))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "bag.fill").foregroundStyle(LpspMessengerTokens.msgBlue))
                    VStack(alignment: .leading) {
                        Text("Listing \(i + 1)")
                            .font(.system(size: 17, weight: .semibold))
                        Text("Marketplace item")
                            .font(.system(size: 14))
                            .foregroundStyle(LpspMessengerTokens.msgTextSecondary)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Marketplace")
        }
    }
}

private struct LpspMessengerStoriesTabScreen: View {
    var isStoryMode = false

    var body: some View {
        NavigationStack {
            Group {
                if isStoryMode {
                    ContentUnavailableView(
                        "No stories",
                        systemImage: "play.circle",
                        description: Text("Stories from your contacts will appear here.")
                    )
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(["Your story", "Theo", "Léa"], id: \.self) { name in
                                VStack(spacing: 4) {
                                    Circle()
                                        .strokeBorder(LpspMessengerTokens.msgBlue, lineWidth: 2)
                                        .frame(width: 66, height: 66)
                                    Text(name)
                                        .font(.caption)
                                        .lineLimit(1)
                                        .frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Stories")
        }
    }
}


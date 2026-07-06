import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/signal
// Meliwat/awesome-ios-design-md/messaging/signal/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeSignalView: View {
    var conversations: [LpspConversation]?

    var body: some View {
        let storyThreads = conversations?.isEmpty == false ? conversations : nil
        let threads = storyThreads ?? LpspSignalShowroomData.conversations
        LpspSignalShowroomRoot(
            store: LpspSignalStore(conversations: threads),
            isStoryMode: storyThreads != nil
        )
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspSignalFonts {
    static let sigLargeTitle    = Font.system(size: 28, weight: .regular)
    static let sigConvoName     = Font.system(size: 17, weight: .regular)
    static let sigThreadTitle   = Font.system(size: 17, weight: .regular)
    static let sigMessageBody   = Font.system(size: 16, weight: .regular)
    static let sigPreview       = Font.system(size: 15, weight: .regular)
    static let sigSectionHeader = Font.system(size: 13, weight: .regular)
    static let sigTimestamp     = Font.system(size: 13, weight: .regular)
    static let sigBubbleMeta    = Font.system(size: 12, weight: .regular)
    static let sigButton        = Font.system(size: 16, weight: .regular)
    static let sigButtonText    = Font.system(size: 16, weight: .regular)
    static let sigTab           = Font.system(size: 10, weight: .regular)
    static let sigTimerChip     = Font.system(size: 12, weight: .regular)
    static let sigSystemNote    = Font.system(size: 13, weight: .regular)
    static let sigSafetyNumber  = Font.system(size: 15, weight: .regular)
    static func signal(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspSignalTokens {
    // MARK: - Canvas & Surfaces (light / dark via asset or scheme)
    static let sigCanvas       = Color(red: 1, green: 1, blue: 1)                // #FFFFFF
    static let sigCanvasDark   = Color(red: 0.106, green: 0.106, blue: 0.106)    // #1B1B1B
    static let sigSurface      = Color(red: 0.961, green: 0.961, blue: 0.961)    // #F5F5F5
    static let sigSurfaceDark  = Color(red: 0.165, green: 0.165, blue: 0.165)    // #2A2A2A
    static let sigDivider      = Color(red: 0.898, green: 0.898, blue: 0.898)    // #E5E5E5
    static let sigDividerDark  = Color(red: 0.227, green: 0.227, blue: 0.227)    // #3A3A3A

    // MARK: - Text
    static let sigTextPrimary   = Color.black                                    // #000000
    static let sigTextPrimaryD  = Color.white                                    // #FFFFFF
    static let sigTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)   // #6B6B6B
    static let sigTextTertiary  = Color(red: 0.604, green: 0.604, blue: 0.604)   // #9A9A9A

    // MARK: - Brand
    static let sigBlue        = Color(red: 0.227, green: 0.463, blue: 0.941)     // #3A76F0
    static let sigBluePressed = Color(red: 0.184, green: 0.373, blue: 0.800)     // #2F5FCC
    static let sigBlueTint    = Color(red: 0.906, green: 0.933, blue: 0.992)     // #E7EEFD

    // MARK: - Message
    static let sigIncoming     = Color(red: 0.914, green: 0.914, blue: 0.922)    // #E9E9EB
    static let sigIncomingDark = Color(red: 0.165, green: 0.165, blue: 0.165)    // #2A2A2A
    static let sigOutMeta      = Color(red: 0.796, green: 0.851, blue: 0.976)    // #CBD9F9

    // MARK: - Semantic
    static let sigError   = Color(red: 0.843, green: 0.149, blue: 0.239)         // #D7263D
    static let sigSuccess = Color(red: 0.227, green: 0.710, blue: 0.290)         // #3AB54A
}





// MARK: - Données & état

@MainActor
fileprivate final class LpspSignalStore: ObservableObject {
    @Published private(set) var threads: [LpspConversation]
    @Published var messagesByThread: [String: [LpspSignalDisplayMessage]]

    init(conversations: [LpspConversation]) {
        self.threads = conversations
        self.messagesByThread = Dictionary(
            uniqueKeysWithValues: conversations.map { ($0.id, LpspSignalStore.makeDisplayMessages(for: $0)) }
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
            bucket[bucket.count - 1] = LpspSignalDisplayMessage(
                id: last.id,
                text: last.text,
                isOutgoing: true,
                time: last.time,
                showsMeta: false,
                readState: last.readState
            )
        }
        bucket.append(
            LpspSignalDisplayMessage(
                id: UUID().uuidString,
                text: trimmed,
                isOutgoing: true,
                time: time,
                showsMeta: true,
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

    private static func makeDisplayMessages(for conversation: LpspConversation) -> [LpspSignalDisplayMessage] {
        if conversation.id == LpspSignalShowroomData.renataThreadId {
            return LpspSignalShowroomData.renataDisplayMessages
        }
        return buildDisplayMessages(from: conversation.messages)
    }

    static func buildDisplayMessages(from messages: [LpspMessage]) -> [LpspSignalDisplayMessage] {
        messages.enumerated().map { index, message in
            let isOutgoing = message.isUser
            let nextSame = index < messages.count - 1 && messages[index + 1].isUser == isOutgoing
            let showsMeta = !nextSame
            let time = showsMeta ? LpspAdapters.formatSignalBubbleTime(message) : ""
            let readState: LpspSignalReadState? = isOutgoing
                ? (showsMeta ? .read : nil)
                : nil
            return LpspSignalDisplayMessage(
                id: message.id,
                text: message.text,
                isOutgoing: isOutgoing,
                time: time,
                showsMeta: showsMeta,
                readState: readState
            )
        }
    }
}

fileprivate struct LpspSignalDisplayMessage: Identifiable {
    let id: String
    let text: String
    let isOutgoing: Bool
    let time: String
    let showsMeta: Bool
    let readState: LpspSignalReadState?
}

fileprivate enum LpspSignalReadState {
    case sent, delivered, read
}

private enum LpspSignalShowroomData {
    static let renataThreadId = "sig-renata-vogel"

    static var conversations: [LpspConversation] {
        [
            LpspConversation(
                id: renataThreadId,
                contactName: "Renata Vogel",
                messages: renataPlainMessages,
                isUnread: false
            ),
            LpspConversation(
                id: "sig-nadia-events",
                contactName: "Nadia K. — Events",
                messages: [
                    LpspMessage(id: "sn1", text: "V. vient de m'appeler. Il dit que t'es retourné là-bas aujourd'hui.", isUser: false, date: nil, dateRaw: "2025-06-15T14:47:00"),
                    LpspMessage(id: "sn2", text: "Dis-moi que c'est pas vrai.", isUser: false, date: nil, dateRaw: "2025-06-15T14:48:00"),
                    LpspMessage(id: "sn3", text: "Tu ne réponds plus. J'espère que tu n'as pas fait de connerie.", isUser: false, date: nil, dateRaw: "2025-06-15T15:12:00"),
                    LpspMessage(id: "sn4", text: "On ne revient pas sur ce qui a été dit. Tu restes loin.", isUser: false, date: nil, dateRaw: "2025-06-15T15:38:00"),
                ],
                isUnread: true
            ),
        ]
    }

    static let renataDisplayMessages: [LpspSignalDisplayMessage] = [
        .init(id: "r1", text: "Are we still on for the design review tomorrow?", isOutgoing: false, time: "", showsMeta: false, readState: nil),
        .init(id: "r2", text: "Pushed it to 2pm so the whole team can make it.", isOutgoing: false, time: "9:38 AM", showsMeta: true, readState: nil),
        .init(id: "r3", text: "Perfect, 2pm works.", isOutgoing: true, time: "", showsMeta: false, readState: .read),
        .init(id: "r4", text: "I'll bring the updated bubble specs and the timer-chip mocks.", isOutgoing: true, time: "9:40 AM", showsMeta: true, readState: .read),
        .init(id: "r5", text: "See you then 🙌", isOutgoing: false, time: "9:41 AM", showsMeta: true, readState: nil),
    ]

    private static var renataPlainMessages: [LpspMessage] {
        renataDisplayMessages.map { msg in
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

fileprivate struct LpspSignalSpectrBubble: View {
    let message: LpspSignalDisplayMessage

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if message.isOutgoing { Spacer(minLength: UIScreen.main.bounds.width * 0.25) }

            VStack(alignment: message.isOutgoing ? .trailing : .leading, spacing: 3) {
                Text(message.text)
                    .font(LpspSignalFonts.sigMessageBody)
                    .foregroundStyle(message.isOutgoing ? .white : LpspSignalTokens.sigTextPrimaryD)
                    .multilineTextAlignment(message.isOutgoing ? .trailing : .leading)
                    .fixedSize(horizontal: false, vertical: true)

                if message.showsMeta {
                    HStack(spacing: 4) {
                        if !message.time.isEmpty {
                            Text(message.time)
                                .font(LpspSignalFonts.sigBubbleMeta)
                        }
                        if message.isOutgoing, let state = message.readState {
                            LpspSignalReadTicks(state: state)
                        }
                    }
                    .foregroundStyle(
                        message.isOutgoing
                            ? LpspSignalTokens.sigOutMeta
                            : LpspSignalTokens.sigTextSecondary
                    )
                }
            }
            .padding(.vertical, 9)
            .padding(.horizontal, 13)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(message.isOutgoing ? LpspSignalTokens.sigBlue : LpspSignalTokens.sigIncomingDark)
            )
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: message.isOutgoing ? .trailing : .leading)

            if !message.isOutgoing { Spacer(minLength: UIScreen.main.bounds.width * 0.25) }
        }
        .padding(.horizontal, 12)
    }
}

fileprivate struct LpspSignalReadTicks: View {
    let state: LpspSignalReadState

    var body: some View {
        HStack(spacing: -4) {
            Image(systemName: "checkmark")
            if state != .sent {
                Image(systemName: "checkmark")
            }
        }
        .font(.system(size: 10, weight: .bold))
        .foregroundStyle(state == .read ? LpspSignalTokens.sigOutMeta : LpspSignalTokens.sigOutMeta.opacity(0.7))
    }
}

fileprivate struct LpspSignalComposerBar: View {
    @Binding var text: String
    let onSend: () -> Void

    private var hasText: Bool { !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspSignalTokens.sigTextSecondary)
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text("Signal message")
                            .font(LpspSignalFonts.sigMessageBody)
                            .foregroundStyle(LpspSignalTokens.sigTextTertiary)
                    }
                    TextField("", text: $text, axis: .vertical)
                        .font(LpspSignalFonts.sigMessageBody)
                        .foregroundStyle(LpspSignalTokens.sigTextPrimaryD)
                        .lineLimit(1...5)
                }
                Image(systemName: "camera")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspSignalTokens.sigTextSecondary)
            }
            .padding(.horizontal, 12)
            .frame(minHeight: 36)
            .background(Capsule().fill(LpspSignalTokens.sigSurfaceDark))

            LpspSignalSendCircle(showSend: hasText) {
                onSend()
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(LpspSignalTokens.sigCanvasDark)
        .animation(.spring(response: 0.18, dampingFraction: 0.8), value: hasText)
    }
}

fileprivate struct LpspSignalSendCircle: View {
    let showSend: Bool
    let action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle().fill(pressed ? LpspSignalTokens.sigBluePressed : LpspSignalTokens.sigBlue)
                Image(systemName: showSend ? "arrow.up" : "mic.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 32, height: 32)
            .scaleEffect(pressed ? 0.90 : 1)
            .opacity(showSend ? 1 : 0.92)
            .offset(y: showSend ? 0 : 4) // slides up into place when text appears
        }
        .sensoryFeedback(.impact(weight: .light), trigger: showSend)
        .simultaneousGesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in pressed = true }
            .onEnded { _ in pressed = false })
    }
}

fileprivate struct LpspSignalConversationRow: View {
    let name: String
    let preview: String
    let time: String
    let unread: Int
    let disappearing: Bool

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color(red: 0.424, green: 0.608, blue: 0.788), Color(red: 0.180, green: 0.361, blue: 0.561)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 48, height: 48)
                .overlay(
                    Text(LpspSignalContactStyle.initials(for: name))
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                )
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 5) {
                    Text(name)
                        .font(LpspSignalFonts.sigConvoName)
                        .foregroundStyle(LpspSignalTokens.sigTextPrimaryD)
                    if disappearing {
                        Image(systemName: "timer")
                            .font(.system(size: 12))
                            .foregroundStyle(LpspSignalTokens.sigTextSecondary)
                    }
                }
                Text(preview)
                    .font(LpspSignalFonts.sigPreview)
                    .foregroundStyle(LpspSignalTokens.sigTextSecondary)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Text(time)
                    .font(LpspSignalFonts.sigTimestamp)
                    .foregroundStyle(LpspSignalTokens.sigTextSecondary)
                if unread > 0 {
                    Text("\(unread)")
                        .font(LpspSignalFonts.sigBubbleMeta)
                        .foregroundStyle(.white)
                        .frame(minWidth: 20, minHeight: 20)
                        .background(Circle().fill(LpspSignalTokens.sigBlue))
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(height: 72)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspSignalTimerChip: View {
    let duration: String  // "1w", "8h", "Off"
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "timer").font(.system(size: 12))
            Text(duration).font(LpspSignalFonts.sigTimerChip)
        }
        .foregroundStyle(LpspSignalTokens.sigTextSecondary) // privacy is quiet — neutral, never blue/red
    }
}

fileprivate struct LpspSignalEncryptionNote: View {
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "lock.fill").font(.system(size: 11))
            Text("Messages and calls are end-to-end encrypted.")
                .font(LpspSignalFonts.sigSystemNote)
        }
        .foregroundStyle(LpspSignalTokens.sigTextSecondary)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }
}



// MARK: - Écrans interactifs (Spectr + LPSP)

private enum LpspSignalTab: Int, CaseIterable {
    case chats, calls, stories, settings

    var label: String {
        switch self {
        case .chats: "Chats"
        case .calls: "Calls"
        case .stories: "Stories"
        case .settings: "Settings"
        }
    }

    var icon: String {
        switch self {
        case .chats: "message.fill"
        case .calls: "phone.fill"
        case .stories: "circle.dashed"
        case .settings: "gearshape.fill"
        }
    }
}

private enum LpspSignalChatRoute: Hashable {
    case thread(String)
}

private enum LpspSignalContactStyle {
    static func initials(for name: String) -> String {
        let cleaned = name.filter { $0.isLetter || $0.isWhitespace }
        let parts = cleaned.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        }
        return String(cleaned.prefix(2)).uppercased()
    }

    static func timerLabel(for name: String, isStory: Bool) -> String {
        if isStory && name.contains("Nadia") { return "Off" }
        if name.contains("Renata") { return "1 week" }
        return "Off"
    }
}

private struct LpspSignalShowroomRoot: View {
    @ObservedObject var store: LpspSignalStore
    var isStoryMode = false
    @State private var selectedTab: LpspSignalTab = .chats
    @State private var chatsPath = NavigationPath()

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .chats:
                    LpspSignalChatsTabScreen(store: store, path: $chatsPath, isStoryMode: isStoryMode)
                case .calls:
                    LpspSignalCallsTabScreen(store: store)
                case .stories:
                    LpspSignalStoriesTabScreen(isStoryMode: isStoryMode)
                case .settings:
                    LpspSignalSettingsTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspSignalSpectrTabBar(selectedTab: $selectedTab)
        }
        .background(LpspSignalTokens.sigCanvasDark.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspSignalSpectrTabBar: View {
    @Binding var selectedTab: LpspSignalTab

    var body: some View {
        HStack {
            ForEach(LpspSignalTab.allCases, id: \.rawValue) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: 3) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22))
                        Text(tab.label)
                            .font(LpspSignalFonts.sigTab)
                    }
                    .foregroundStyle(
                        selectedTab == tab
                            ? LpspSignalTokens.sigBlue
                            : LpspSignalTokens.sigTextSecondary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 4)
        .background(LpspSignalTokens.sigCanvasDark)
    }
}

private struct LpspSignalChatsTabScreen: View {
    @ObservedObject var store: LpspSignalStore
    @Binding var path: NavigationPath
    var isStoryMode = false

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(store.threads) { thread in
                    Button {
                        path.append(LpspSignalChatRoute.thread(thread.id))
                    } label: {
                        LpspSignalConversationRow(
                            name: thread.contactName,
                            preview: thread.preview,
                            time: LpspAdapters.formatShortDate(thread.lastDate, fallback: thread.lastDateRaw),
                            unread: thread.isUnread ? 1 : 0,
                            disappearing: thread.contactName.contains("Renata")
                        )
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(LpspSignalTokens.sigCanvasDark)
                    .listRowSeparatorTint(LpspSignalTokens.sigDividerDark)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(LpspSignalTokens.sigCanvasDark)
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(for: LpspSignalChatRoute.self) { route in
                if case .thread(let id) = route {
                    LpspSignalChatScreen(
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

private struct LpspSignalChatScreen: View {
    @ObservedObject var store: LpspSignalStore
    let threadId: String
    var isStoryMode = false
    let onBack: () -> Void

    @State private var draft = ""
    @FocusState private var inputFocused: Bool

    private var thread: LpspConversation? { store.thread(id: threadId) }
    private var contactName: String { thread?.contactName ?? "" }
    private var messages: [LpspSignalDisplayMessage] { store.messagesByThread[threadId] ?? [] }

    var body: some View {
        VStack(spacing: 0) {
            LpspSignalThreadHeader(
                contactName: contactName,
                timerLabel: LpspSignalContactStyle.timerLabel(for: contactName, isStory: isStoryMode),
                onBack: onBack
            )
            LpspSignalThreadBody(messages: messages)
            LpspSignalComposerBar(text: $draft, onSend: sendMessage)
        }
        .background(LpspSignalTokens.sigCanvasDark.ignoresSafeArea())
        .navigationBarHidden(true)
        .onAppear { store.markAsRead(threadId: threadId) }
    }

    private func sendMessage() {
        store.send(text: draft, threadId: threadId)
        draft = ""
        inputFocused = false
    }
}

private struct LpspSignalThreadHeader: View {
    let contactName: String
    let timerLabel: String
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(LpspSignalTokens.sigBlue)
            }
            .buttonStyle(.plain)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color(red: 0.424, green: 0.608, blue: 0.788), Color(red: 0.180, green: 0.361, blue: 0.561)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(contactName)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(LpspSignalTokens.sigTextPrimaryD)
                LpspSignalTimerChip(duration: timerLabel)
            }

            Spacer()

            HStack(spacing: 18) {
                Image(systemName: "video.fill")
                Image(systemName: "phone.fill")
            }
            .font(.system(size: 18))
            .foregroundStyle(LpspSignalTokens.sigBlue)
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(LpspSignalTokens.sigCanvasDark)
    }
}

private struct LpspSignalThreadBody: View {
    let messages: [LpspSignalDisplayMessage]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 2) {
                    LpspSignalEncryptionNote()
                    ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in
                        if index > 0 && messages[index - 1].isOutgoing != message.isOutgoing {
                            Color.clear.frame(height: 6)
                        }
                        LpspSignalSpectrBubble(message: message)
                            .id(message.id)
                    }
                }
                .padding(.vertical, 8)
            }
            .background(LpspSignalTokens.sigCanvasDark)
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

private struct LpspSignalCallsTabScreen: View {
    @ObservedObject var store: LpspSignalStore

    var body: some View {
        NavigationStack {
            List(store.threads) { thread in
                HStack(spacing: 12) {
                    Circle()
                        .fill(LpspSignalTokens.sigSurfaceDark)
                        .frame(width: 40, height: 40)
                        .overlay(Image(systemName: "phone.fill").foregroundStyle(LpspSignalTokens.sigBlue))
                    VStack(alignment: .leading, spacing: 2) {
                        Text(thread.contactName)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(LpspSignalTokens.sigTextPrimaryD)
                        Text("Voice call · \(LpspAdapters.formatShortDate(thread.lastDate, fallback: thread.lastDateRaw))")
                            .font(.system(size: 14))
                            .foregroundStyle(LpspSignalTokens.sigTextSecondary)
                    }
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundStyle(LpspSignalTokens.sigTextSecondary)
                }
                .listRowBackground(LpspSignalTokens.sigCanvasDark)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(LpspSignalTokens.sigCanvasDark)
            .navigationTitle("Calls")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

private struct LpspSignalStoriesTabScreen: View {
    var isStoryMode = false

    var body: some View {
        NavigationStack {
            Group {
                if isStoryMode {
                    ContentUnavailableView(
                        "No stories",
                        systemImage: "circle.dashed",
                        description: Text("Stories from your contacts will appear here.")
                    )
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(["My story", "Renata", "Alex"], id: \.self) { name in
                                VStack(spacing: 4) {
                                    Circle()
                                        .strokeBorder(LpspSignalTokens.sigTextSecondary, lineWidth: 2)
                                        .frame(width: 66, height: 66)
                                    Text(name)
                                        .font(.caption)
                                        .foregroundStyle(LpspSignalTokens.sigTextPrimaryD)
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
            .background(LpspSignalTokens.sigCanvasDark)
            .navigationTitle("Stories")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

private struct LpspSignalSettingsTabScreen: View {
    @Environment(\.deviceOwner) private var owner

    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(owner.name).foregroundStyle(LpspSignalTokens.sigTextSecondary)
                    }
                    Label("Privacy", systemImage: "lock")
                    Label("Notifications", systemImage: "bell")
                }
                Section("Chats") {
                    HStack {
                        Text("Disappearing messages")
                        Spacer()
                        Text("Off").foregroundStyle(LpspSignalTokens.sigTextSecondary)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(LpspSignalTokens.sigCanvasDark)
            .navigationTitle("Settings")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}



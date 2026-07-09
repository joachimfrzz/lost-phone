import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/telegram
// Meliwat/awesome-ios-design-md/messaging/telegram/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTelegramView: View {
    var conversations: [LpspConversation]?

    var body: some View {
        let storyThreads = conversations?.isEmpty == false ? conversations : nil
        let threads = storyThreads ?? LpspTelegramShowroomData.conversations
        LpspTelegramShowroomRoot(
            store: LpspTelegramStore(conversations: threads),
            isStoryMode: storyThreads != nil
        )
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTelegramTokens {
    // MARK: - Default Accent (user-themeable)
    static let tgAccent        = Color(red: 0.000, green: 0.533, blue: 0.800) // #0088CC
    static let tgAccentLight   = Color(red: 0.251, green: 0.655, blue: 0.890) // #40A7E3
    static let tgAccentPressed = Color(red: 0.000, green: 0.443, blue: 0.690) // #0071B0

    // MARK: - Bubble (default blue theme)
    static let tgBubbleOutgoing     = Color(red: 0.169, green: 0.525, blue: 0.992) // #2B86FD
    static let tgBubbleOutgoingTop  = Color(red: 0.169, green: 0.525, blue: 0.992) // #2B86FD (gradient top)
    static let tgBubbleOutgoingBot  = Color(red: 0.380, green: 0.702, blue: 1.000) // #61B3FF (gradient bottom)
    static let tgBubbleIncomingLight = Color.white
    static let tgBubbleIncomingDark  = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A

    // MARK: - Canvas
    static let tgCanvasLight   = Color.white                                    // #FFFFFF
    static let tgCanvasDark    = Color(red: 0.129, green: 0.129, blue: 0.129)   // #212121
    static let tgCanvasOLED    = Color.black                                     // #000000
    static let tgChatBGBlue    = Color(red: 0.859, green: 0.906, blue: 0.957)   // #DBE7F4 (default blue wallpaper)
    static let tgSurface1Light = Color(red: 0.969, green: 0.969, blue: 0.969)   // #F7F7F7
    static let tgSurface1Dark  = Color(red: 0.110, green: 0.110, blue: 0.110)   // #1C1C1C
    static let tgSurface2Dark  = Color(red: 0.173, green: 0.173, blue: 0.180)   // #2C2C2E
    static let tgDividerLight  = Color(red: 0.780, green: 0.780, blue: 0.800)   // #C7C7CC
    static let tgDividerDark   = Color(red: 0.220, green: 0.220, blue: 0.220)   // #383838

    // MARK: - Text
    static let tgTextPrimary       = Color.black
    static let tgTextSecondary     = Color(red: 0.439, green: 0.459, blue: 0.475) // #707579
    static let tgTextTertiary      = Color(red: 0.627, green: 0.651, blue: 0.678) // #A0A6AD
    static let tgTextPrimaryDark   = Color.white
    static let tgTextSecondaryDark = Color(red: 0.553, green: 0.557, blue: 0.576) // #8D8E93

    // MARK: - Semantic
    static let tgOnlineGreen   = Color(red: 0.302, green: 0.827, blue: 0.392) // #4DD364
    static let tgErrorRed      = Color(red: 0.898, green: 0.224, blue: 0.208) // #E53935
    static let tgDestructive   = Color(red: 0.890, green: 0.333, blue: 0.380) // #E35561
    static let tgPremiumA      = Color(red: 0.682, green: 0.435, blue: 0.992) // #AE6FFD
    static let tgPremiumB      = Color(red: 0.808, green: 0.420, blue: 1.000) // #CE6BFF
}

// Sender color palette (for group chats)
fileprivate enum LpspTelegramTgSenderColor: Int, CaseIterable {
    case red, orange, purple, green, teal, blue, pink
    var color: Color {
        switch self {
        case .red:    return Color(red: 0.988, green: 0.361, blue: 0.318)
        case .orange: return Color(red: 0.980, green: 0.475, blue: 0.059)
        case .purple: return Color(red: 0.537, green: 0.365, blue: 0.835)
        case .green:  return Color(red: 0.059, green: 0.698, blue: 0.592)
        case .teal:   return Color(red: 0.000, green: 0.757, blue: 0.651)
        case .blue:   return Color(red: 0.235, green: 0.647, blue: 0.925)
        case .pink:   return Color(red: 1.000, green: 0.322, blue: 0.455)
        }
    }
    static func forSender(_ id: Int) -> Color {
        return allCases[abs(id) % allCases.count].color
    }
}

fileprivate struct LpspTelegramTelegramTheme {
    var accent: Color = LpspTelegramTokens.tgAccent
    var outgoingBubble: Color = LpspTelegramTokens.tgBubbleOutgoing
    var useGradientBubbles: Bool = false
    var isDark: Bool = false
    var isOLED: Bool = false
}

private struct LpspTelegramThemeKey: EnvironmentKey {
    static let defaultValue = LpspTelegramTelegramTheme()
}

fileprivate extension EnvironmentValues {
    var telegramTheme: LpspTelegramTelegramTheme {
        get { self[LpspTelegramThemeKey.self] }
        set { self[LpspTelegramThemeKey.self] = newValue }
    }
}

private enum LpspTelegramFonts {
    static let tgLargeTitle     = Font.system(size: 34, weight: .bold)
    static let tgNavTitle       = Font.system(size: 17, weight: .semibold)
    static let tgContactName    = Font.system(size: 17, weight: .semibold)
    static let tgBubbleBody     = Font.system(size: 17, weight: .regular)
    static let tgGroupSender    = Font.system(size: 14, weight: .semibold)
    static let tgMessagePreview = Font.system(size: 15, weight: .regular)
    static let tgTimestampList  = Font.system(size: 13, weight: .regular)
    static let tgTimestampBubble = Font.system(size: 11, weight: .regular)
    static let tgCaption        = Font.system(size: 12, weight: .regular)
    static let tgTabLabel       = Font.system(size: 10, weight: .medium)
    static let tgButton         = Font.system(size: 17, weight: .semibold)
    static let tgCode           = Font.system(size: 15, weight: .regular)
}

// MARK: - Données & état (showroom + histoire LPSP)

@MainActor
fileprivate final class LpspTelegramStore: ObservableObject {
    @Published private(set) var threads: [LpspConversation]
    @Published var messagesByThread: [String: [LpspTelegramSpectrMessage]]

    init(conversations: [LpspConversation]) {
        self.threads = conversations
        self.messagesByThread = Dictionary(
            uniqueKeysWithValues: conversations.map { ($0.id, LpspTelegramStore.makeDisplayMessages(for: $0)) }
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
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let time = formatter.string(from: Date())
        messagesByThread[threadId, default: []].append(
            .init(id: "sent-\(UUID().uuidString)", kind: .outgoing(text: trimmed, time: time, readState: .delivered))
        )
        if let index = threads.firstIndex(where: { $0.id == threadId }) {
            let old = threads[index]
            let newMessage = LpspMessage(
                id: "sent-\(UUID().uuidString)",
                text: trimmed,
                isUser: true,
                date: Date(),
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

    private static func makeDisplayMessages(for conversation: LpspConversation) -> [LpspTelegramSpectrMessage] {
        if conversation.id == LpspTelegramShowroomData.oliviaThreadId {
            return LpspTelegramShowroomData.oliviaDisplayMessages
        }
        return conversation.messages.map { message in
            let time = LpspAdapters.formatWhatsAppBubbleTime(message)
            if message.isUser {
                return LpspTelegramSpectrMessage(
                    id: message.id,
                    kind: .outgoing(text: message.text, time: time, readState: .read)
                )
            }
            return LpspTelegramSpectrMessage(
                id: message.id,
                kind: .incoming(text: message.text, time: time)
            )
        }
    }
}

fileprivate struct LpspTelegramSpectrMessage: Identifiable {
    enum Kind {
        case incoming(text: String, time: String)
        case outgoing(text: String, time: String, readState: LpspTelegramReadState)
    }

    let id: String
    let kind: Kind
}

fileprivate enum LpspTelegramReadState {
    case sent, delivered, read
}

private enum LpspTelegramShowroomData {
    static let oliviaThreadId = "tg-olivia-park"
    static let oliviaPinnedMessage = "Demo day Friday — bring a laptop."

    static var conversations: [LpspConversation] {
        [
            LpspConversation(
                id: oliviaThreadId,
                contactName: "Olivia Park",
                messages: oliviaPlainMessages,
                isUnread: false
            ),
            LpspConversation(
                id: "tg-alex-martin",
                contactName: "Alex Martin",
                messages: [
                    LpspMessage(id: "a1", text: "On se voit ce soir ?", isUser: false, date: nil, dateRaw: "10:24"),
                    LpspMessage(id: "a2", text: "Oui, vers 19h", isUser: true, date: nil, dateRaw: "10:26"),
                ],
                isUnread: true
            ),
            LpspConversation(
                id: "tg-lea-dupont",
                contactName: "Léa Dupont",
                messages: [
                    LpspMessage(id: "l1", text: "Merci pour hier", isUser: false, date: nil, dateRaw: "Hier"),
                ],
                isUnread: false
            ),
        ]
    }

    static let oliviaDisplayMessages: [LpspTelegramSpectrMessage] = [
        .init(id: "o1", kind: .incoming(text: "Ok quick update — the gradient prototype is running.", time: "10:21")),
        .init(id: "o2", kind: .outgoing(text: "Amazing, want me to test on the old iPhone?", time: "10:22", readState: .read)),
        .init(id: "o3", kind: .incoming(text: "yes pls 🙏", time: "10:23")),
        .init(id: "o4", kind: .incoming(text: "perfect, on it", time: "10:26")),
    ]

    private static var oliviaPlainMessages: [LpspMessage] {
        oliviaDisplayMessages.map { msg in
            switch msg.kind {
            case .incoming(let text, let time):
                return LpspMessage(id: msg.id, text: text, isUser: false, date: nil, dateRaw: time)
            case .outgoing(let text, let time, _):
                return LpspMessage(id: msg.id, text: text, isUser: true, date: nil, dateRaw: time)
            }
        }
    }

    static func pinnedMessage(for threadId: String) -> String? {
        threadId == oliviaThreadId ? oliviaPinnedMessage : nil
    }

    static func isPinned(threadId: String) -> Bool {
        threadId == oliviaThreadId
    }
}

private enum LpspTelegramContactStyle {
    static func initials(for name: String) -> String {
        let cleaned = name.filter { $0.isLetter || $0.isWhitespace }
        let parts = cleaned.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        }
        return String(cleaned.prefix(2)).uppercased()
    }

    static func gradient(for name: String) -> [Color] {
        if name.contains("Olivia") {
            return [Color(red: 0.424, green: 0.608, blue: 0.788), Color(red: 0.180, green: 0.361, blue: 0.561)]
        }
        return [LpspTelegramTokens.tgAccentLight, LpspTelegramTokens.tgAccent]
    }

    static func subtitle(for name: String) -> String {
        if name.contains("Olivia") { return "last seen recently" }
        if name.contains("Alex") { return "last seen today at 10:26" }
        return "last seen recently"
    }
}

fileprivate struct LpspTelegramTgComposeBar: View {
    @State private var text: String = ""
    @State private var showSilentMenu = false
    @Environment(\.telegramTheme) private var theme

    var body: some View {
        HStack(spacing: 16) {
            Button { /* attach */ } label: {
                Image(systemName: "paperclip")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    .rotationEffect(.degrees(45))
            }

            TextField("Message", text: $text, axis: .vertical)
                .font(.system(size: 16))
                .lineLimit(1...5)

            Button { /* emoji */ } label: {
                Image(systemName: "face.smiling")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
            }

            if text.isEmpty {
                Button { } label: {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(theme.accent)
                }
            } else {
                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(theme.accent)
                }
                .sensoryFeedback(.impact(flexibility: .soft), trigger: text)
                .contextMenu {
                    Button("Send Without Sound", systemImage: "speaker.slash") { sendSilent() }
                    Button("Schedule Message", systemImage: "calendar") { scheduleSend() }
                    Button("Send When Online", systemImage: "person.wave.2") { sendWhenOnline() }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(LpspTelegramTokens.tgSurface1Light)
        .overlay(Divider(), alignment: .top)
    }

    private func sendMessage() { text = "" }
    private func sendSilent() { text = "" }
    private func scheduleSend() { }
    private func sendWhenOnline() { }
}

fileprivate struct LpspTelegramTgOutgoingBubble: View {
    let text: String
    let timestamp: String
    let isRead: Bool
    @Environment(\.telegramTheme) private var theme

    var body: some View {
        HStack {
            Spacer(minLength: UIScreen.main.bounds.width * 0.2)
            VStack(alignment: .trailing, spacing: 4) {
                Text(text)
                    .font(LpspTelegramFonts.tgBubbleBody)
                    .foregroundStyle(.white)
                HStack(spacing: 2) {
                    Text(timestamp)
                        .font(LpspTelegramFonts.tgTimestampBubble)
                        .foregroundStyle(.white.opacity(0.8))
                    Image(systemName: isRead ? "checkmark.circle.fill" : "checkmark")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(bubbleBackground)
        }
        .padding(.trailing, 8)
    }

    @ViewBuilder
    private var bubbleBackground: some View {
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: 17,
            bottomLeadingRadius: 17,
            bottomTrailingRadius: 6, // the "notch" tail corner
            topTrailingRadius: 17
        )
        if theme.useGradientBubbles {
            shape.fill(LinearGradient(colors: [LpspTelegramTokens.tgBubbleOutgoingTop, LpspTelegramTokens.tgBubbleOutgoingBot], startPoint: .top, endPoint: .bottom))
        } else {
            shape.fill(theme.outgoingBubble)
        }
    }
}

fileprivate struct LpspTelegramTgIncomingBubble: View {
    let text: String
    let senderName: String?
    let senderId: Int?

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                if let senderName, let senderId {
                    Text(senderName)
                        .font(LpspTelegramFonts.tgGroupSender)
                        .foregroundStyle(LpspTelegramTgSenderColor.forSender(senderId))
                }
                Text(text).font(LpspTelegramFonts.tgBubbleBody).foregroundStyle(LpspTelegramTokens.tgTextPrimary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 17,
                    bottomLeadingRadius: 6, // tail notch
                    bottomTrailingRadius: 17,
                    topTrailingRadius: 17
                )
                .fill(Color.white)
            )
            Spacer(minLength: UIScreen.main.bounds.width * 0.2)
        }
        .padding(.leading, 8)
    }
}

fileprivate struct LpspTelegramTgVoiceMiniPlayer: View {
    let title: String
    let progress: Double
    var onClose: () -> Void = {}

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "pause.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(LpspTelegramTokens.tgAccent)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(LpspTelegramTokens.tgDividerLight).frame(height: 2)
                        Capsule().fill(LpspTelegramTokens.tgAccent).frame(width: geo.size.width * progress, height: 2)
                    }
                }
                .frame(height: 2)
            }
            Button(action: onClose) {
                Image(systemName: "xmark").font(.system(size: 13, weight: .bold)).foregroundStyle(LpspTelegramTokens.tgTextSecondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .frame(height: 40)
        .background(
            Capsule()
                .fill(Color.white)
                .shadow(color: .black.opacity(0.16), radius: 16, y: 4)
        )
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspTelegramTgSwipeToReply<Content: View>: View {
    @ViewBuilder let content: Content
    @State private var offset: CGFloat = 0
    @State private var hasTicked = false
    let threshold: CGFloat = 60

    var body: some View {
        content
            .offset(x: offset)
            .overlay(alignment: .leading) {
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .foregroundStyle(LpspTelegramTokens.tgAccent)
                    .opacity(min(1, offset / threshold))
                    .padding(.leading, -32 + offset * 0.3)
            }
            .gesture(
                DragGesture()
                    .onChanged { g in
                        offset = max(0, min(g.translation.width, threshold + 20))
                        if offset >= threshold && !hasTicked {
                            hasTicked = true
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        }
                    }
                    .onEnded { _ in
                        if offset >= threshold { /* trigger reply */ }
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) { offset = 0 }
                        hasTicked = false
                    }
            )
    }
}

fileprivate struct LpspTelegramTgChatListRow<Avatar: View>: View {
    let avatar: Avatar
    let name: String
    let preview: String
    let timestamp: String
    let unreadCount: Int
    let isPinned: Bool
    let isMuted: Bool

    var body: some View {
        HStack(spacing: 12) {
            avatar
                .frame(width: 54, height: 54)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text(name)
                        .font(LpspTelegramFonts.tgContactName)
                        .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                        .lineLimit(1)
                    if isMuted {
                        Image(systemName: "speaker.slash.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    }
                }
                Text(preview)
                    .font(LpspTelegramFonts.tgMessagePreview)
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(timestamp)
                    .font(LpspTelegramFonts.tgTimestampList)
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                HStack(spacing: 4) {
                    if isPinned {
                        Image(systemName: "pin.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    }
                    if unreadCount > 0 {
                        Text("\(unreadCount)")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(RoundedRectangle(cornerRadius: 10).fill(isMuted ? LpspTelegramTokens.tgTextTertiary : LpspTelegramTokens.tgAccent))
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 76)
        .background(isPinned ? LpspTelegramTokens.tgSurface1Light : Color.clear)
        .contentShape(Rectangle())
    }
}



// MARK: - Écrans showroom

private enum LpspTelegramTab: Int, CaseIterable {
    case contacts, calls, chats, settings

    var label: String {
        switch self {
        case .contacts: "Contacts"
        case .calls: "Calls"
        case .chats: "Chats"
        case .settings: "Settings"
        }
    }

    var icon: String {
        switch self {
        case .contacts: "person.2.fill"
        case .calls: "phone.fill"
        case .chats: "bubble.left.and.bubble.right.fill"
        case .settings: "gearshape.fill"
        }
    }
}

private enum LpspTelegramChatRoute: Hashable {
    case thread(String)
}

private struct LpspTelegramShowroomRoot: View {
    @ObservedObject var store: LpspTelegramStore
    var isStoryMode = false
    @State private var selectedTab: LpspTelegramTab = .chats
    @State private var chatsPath = NavigationPath()

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .contacts:
                    LpspTelegramContactsTabScreen(store: store, isStoryMode: isStoryMode)
                case .calls:
                    LpspTelegramCallsTabScreen(store: store)
                case .chats:
                    LpspTelegramChatsTabScreen(store: store, path: $chatsPath)
                case .settings:
                    LpspTelegramSettingsTabScreen(isStoryMode: isStoryMode)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspTelegramSpectrTabBar(selectedTab: $selectedTab)
        }
        .background(LpspTelegramTokens.tgCanvasLight.ignoresSafeArea())
        .preferredColorScheme(.light)
    }
}

private struct LpspTelegramSpectrTabBar: View {
    @Binding var selectedTab: LpspTelegramTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspTelegramTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22))
                        Text(tab.label)
                            .font(LpspTelegramFonts.tgTabLabel)
                    }
                    .foregroundStyle(selectedTab == tab ? LpspTelegramTokens.tgAccent : LpspTelegramTokens.tgTextSecondary)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(LpspTelegramPressableStyle(pressedScale: 0.95))
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 2)
        .background(LpspTelegramTokens.tgSurface1Light)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspTelegramTokens.tgDividerLight)
                .frame(height: 0.5)
        }
    }
}

private struct LpspTelegramPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.22, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

private struct LpspTelegramDemoAvatar: View {
    let initials: String
    let gradient: [Color]

    var body: some View {
        Circle()
            .fill(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay(Text(initials).font(.system(size: 13, weight: .semibold)).foregroundStyle(.white))
    }
}

private struct LpspTelegramChatsTabScreen: View {
    @ObservedObject var store: LpspTelegramStore
    @Binding var path: NavigationPath

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(store.threads) { thread in
                    Button {
                        path.append(LpspTelegramChatRoute.thread(thread.id))
                    } label: {
                        LpspTelegramTgChatListRow(
                            avatar: LpspTelegramDemoAvatar(
                                initials: LpspTelegramContactStyle.initials(for: thread.contactName),
                                gradient: LpspTelegramContactStyle.gradient(for: thread.contactName)
                            ),
                            name: thread.contactName,
                            preview: thread.preview,
                            timestamp: LpspAdapters.formatShortDate(thread.lastDate, fallback: thread.lastDateRaw),
                            unreadCount: thread.isUnread ? 1 : 0,
                            isPinned: LpspTelegramShowroomData.isPinned(threadId: thread.id),
                            isMuted: false
                        )
                    }
                    .buttonStyle(.plain)
                    .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(.plain)
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    }
                    .disabled(true)
                }
            }
            .navigationDestination(for: LpspTelegramChatRoute.self) { route in
                if case .thread(let id) = route {
                    LpspTelegramChatScreen(store: store, threadId: id, onBack: { path.removeLast() })
                }
            }
        }
    }
}

private struct LpspTelegramChatScreen: View {
    @ObservedObject var store: LpspTelegramStore
    let threadId: String
    let onBack: () -> Void

    @State private var draft = ""
    @FocusState private var inputFocused: Bool

    private var thread: LpspConversation? { store.thread(id: threadId) }
    private var contactName: String { thread?.contactName ?? "" }
    private var messages: [LpspTelegramSpectrMessage] { store.messagesByThread[threadId] ?? [] }
    private var pinnedMessage: String? { LpspTelegramShowroomData.pinnedMessage(for: threadId) }

    var body: some View {
        VStack(spacing: 0) {
            LpspTelegramSpectrChatNav(contactName: contactName, onBack: onBack)
            if let pinnedMessage {
                LpspTelegramSpectrPinnedBanner(text: pinnedMessage)
            }
            LpspTelegramSpectrChatBody(messages: messages)
            LpspTelegramSpectrComposerBar(
                text: $draft,
                isFocused: $inputFocused,
                onSend: sendMessage
            )
        }
        .background(LpspTelegramTokens.tgChatBGBlue.ignoresSafeArea())
        .navigationBarHidden(true)
        .onAppear { store.markAsRead(threadId: threadId) }
    }

    private func sendMessage() {
        store.send(text: draft, threadId: threadId)
        draft = ""
        inputFocused = false
    }
}

private struct LpspTelegramSpectrChatNav: View {
    let contactName: String
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Button(action: onBack) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                    Text("Back")
                        .font(.system(size: 17))
                }
                .foregroundStyle(LpspTelegramTokens.tgAccent)
            }
            .buttonStyle(LpspTelegramPressableStyle())

            LpspTelegramDemoAvatar(
                initials: LpspTelegramContactStyle.initials(for: contactName),
                gradient: LpspTelegramContactStyle.gradient(for: contactName)
            )
            .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(contactName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                Text(LpspTelegramContactStyle.subtitle(for: contactName))
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
            }

            Spacer()

            Button { } label: {
                Image(systemName: "video.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(LpspTelegramTokens.tgAccent)
            }
            .buttonStyle(LpspTelegramPressableStyle())
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(LpspTelegramTokens.tgCanvasLight)
    }
}

private struct LpspTelegramSpectrPinnedBanner: View {
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 1.5)
                .fill(LpspTelegramTokens.tgAccent)
                .frame(width: 3, height: 34)
            VStack(alignment: .leading, spacing: 2) {
                Text("Pinned Message")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(LpspTelegramTokens.tgAccent)
                Text(text)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                    .lineLimit(1)
            }
            Spacer()
            Image(systemName: "pin.fill")
                .font(.system(size: 14))
                .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(LpspTelegramTokens.tgCanvasLight)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(LpspTelegramTokens.tgDividerLight)
                .frame(height: 0.5)
        }
    }
}

private struct LpspTelegramSpectrChatBody: View {
    let messages: [LpspTelegramSpectrMessage]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 4) {
                    ForEach(messages) { message in
                        switch message.kind {
                        case .incoming(let text, let time):
                            LpspTelegramSpectrTextBubble(text: text, time: time, outgoing: false)
                                .id(message.id)
                        case .outgoing(let text, let time, let readState):
                            LpspTelegramSpectrTextBubble(text: text, time: time, outgoing: true, readState: readState)
                                .id(message.id)
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            .background(LpspTelegramTokens.tgChatBGBlue)
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

private struct LpspTelegramSpectrTextBubble: View {
    let text: String
    let time: String
    let outgoing: Bool
    var readState: LpspTelegramReadState?

    private var bubbleShape: UnevenRoundedRectangle {
        if outgoing {
            UnevenRoundedRectangle(
                topLeadingRadius: 17,
                bottomLeadingRadius: 17,
                bottomTrailingRadius: 6,
                topTrailingRadius: 17
            )
        } else {
            UnevenRoundedRectangle(
                topLeadingRadius: 17,
                bottomLeadingRadius: 6,
                bottomTrailingRadius: 17,
                topTrailingRadius: 17
            )
        }
    }

    private var metaTrailingPadding: CGFloat {
        guard !time.isEmpty || (outgoing && readState != nil) else { return 12 }
        let timeWidth = CGFloat(max(time.count, 4)) * 5.5
        let ticks: CGFloat = (outgoing && readState != nil) ? 16 : 0
        return timeWidth + ticks + 14
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if outgoing { Spacer(minLength: UIScreen.main.bounds.width * 0.2) }

            Text(verbatim: text)
                .font(LpspTelegramFonts.tgBubbleBody)
                .foregroundStyle(outgoing ? .white : LpspTelegramTokens.tgTextPrimary)
                .lineSpacing(2)
                .multilineTextAlignment(outgoing ? .trailing : .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 8)
                .padding(.leading, 12)
                .padding(.trailing, metaTrailingPadding)
                .padding(.bottom, 20)
                .background(
                    bubbleShape
                        .fill(outgoing ? LpspTelegramTokens.tgBubbleOutgoing : LpspTelegramTokens.tgBubbleIncomingLight)
                        .shadow(color: .black.opacity(outgoing ? 0.06 : 0.04), radius: 0.5, y: 1)
                )
                .overlay(alignment: .bottomTrailing) {
                    HStack(spacing: 3) {
                        if !time.isEmpty {
                            Text(time)
                                .font(LpspTelegramFonts.tgTimestampBubble)
                                .foregroundStyle(outgoing ? .white.opacity(0.8) : LpspTelegramTokens.tgTextSecondary)
                        }
                        if outgoing, let readState {
                            LpspTelegramSpectrReadTicks(state: readState)
                        }
                    }
                    .padding(.trailing, 10)
                    .padding(.bottom, 5)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.78, alignment: outgoing ? .trailing : .leading)

            if !outgoing { Spacer(minLength: UIScreen.main.bounds.width * 0.2) }
        }
    }
}

private struct LpspTelegramSpectrReadTicks: View {
    let state: LpspTelegramReadState

    var body: some View {
        HStack(spacing: -4) {
            Image(systemName: "checkmark")
            Image(systemName: "checkmark")
        }
        .font(.system(size: 9, weight: .bold))
        .foregroundStyle(.white.opacity(state == .read ? 0.95 : 0.7))
    }
}

private struct LpspTelegramSpectrComposerBar: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    let onSend: () -> Void

    private var hasText: Bool { !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    var body: some View {
        HStack(spacing: 16) {
            Button { } label: {
                Image(systemName: "paperclip")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    .rotationEffect(.degrees(45))
            }
            .buttonStyle(LpspTelegramPressableStyle())

            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("Message")
                        .font(.system(size: 16))
                        .foregroundStyle(LpspTelegramTokens.tgTextTertiary)
                }
                TextField("", text: $text, axis: .vertical)
                    .font(.system(size: 16))
                    .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                    .lineLimit(1...5)
                    .focused(isFocused)
            }

            Button { } label: {
                Image(systemName: "face.smiling")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
            }
            .buttonStyle(LpspTelegramPressableStyle())

            Button {
                if hasText { onSend() }
            } label: {
                Image(systemName: hasText ? "paperplane.fill" : "mic.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspTelegramTokens.tgAccent)
            }
            .buttonStyle(LpspTelegramPressableStyle(pressedScale: 0.92))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(LpspTelegramTokens.tgSurface1Light)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspTelegramTokens.tgDividerLight)
                .frame(height: 0.5)
        }
    }
}

private struct LpspTelegramCallsTabScreen: View {
    @ObservedObject var store: LpspTelegramStore

    var body: some View {
        NavigationStack {
            List(store.threads) { thread in
                HStack(spacing: 12) {
                    LpspTelegramDemoAvatar(
                        initials: LpspTelegramContactStyle.initials(for: thread.contactName),
                        gradient: LpspTelegramContactStyle.gradient(for: thread.contactName)
                    )
                    .frame(width: 40, height: 40)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(thread.contactName)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                        Text("Voice call · \(LpspAdapters.formatShortDate(thread.lastDate, fallback: thread.lastDateRaw))")
                            .font(.system(size: 14))
                            .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    }
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Calls")
        }
    }
}

private struct LpspTelegramContactsTabScreen: View {
    @ObservedObject var store: LpspTelegramStore
    var isStoryMode = false

    var body: some View {
        NavigationStack {
            Group {
                if isStoryMode {
                    ContentUnavailableView(
                        "No contacts",
                        systemImage: "person.2",
                        description: Text("Your Telegram contacts will appear here.")
                    )
                } else {
                    List(store.threads) { thread in
                        HStack(spacing: 12) {
                            LpspTelegramDemoAvatar(
                                initials: LpspTelegramContactStyle.initials(for: thread.contactName),
                                gradient: LpspTelegramContactStyle.gradient(for: thread.contactName)
                            )
                            .frame(width: 40, height: 40)
                            Text(thread.contactName)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Contacts")
        }
    }
}

private struct LpspTelegramSettingsTabScreen: View {
    var isStoryMode = false
    @Environment(\.deviceOwner) private var owner

    var body: some View {
        NavigationStack {
            Group {
                if isStoryMode {
                    ContentUnavailableView(
                        "Settings",
                        systemImage: "gearshape",
                        description: Text("Telegram settings are not available in this story.")
                    )
                } else {
                    List {
                        Section("Account") {
                            HStack {
                                Text("Name")
                                Spacer()
                                Text(owner.name).foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                            }
                            Label("Privacy", systemImage: "lock")
                            Label("Notifications", systemImage: "bell")
                        }
                        Section("Chats") {
                            HStack {
                                Text("Chat wallpaper")
                                Spacer()
                                Text("Blue").foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Settings")
        }
    }
}


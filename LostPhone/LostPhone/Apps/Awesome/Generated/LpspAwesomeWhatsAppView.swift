import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/whatsapp
// Meliwat/awesome-ios-design-md/messaging/whatsapp/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeWhatsAppView: View {
    var conversations: [LpspConversation]?

    var body: some View {
        let storyThreads = conversations?.isEmpty == false ? conversations : nil
        let threads = storyThreads ?? LpspWhatsAppShowroomData.conversations
        LpspWhatsAppShowroomRoot(
            store: LpspWhatsAppStore(conversations: threads),
            isStoryMode: storyThreads != nil
        )
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspWhatsAppTokens {
    // MARK: - Brand
    static let waGreen         = Color(red: 0.145, green: 0.827, blue: 0.400) // #25D366
    static let waGreenPressed  = Color(red: 0.118, green: 0.745, blue: 0.365) // #1EBE5D
    static let waTeal          = Color(red: 0.027, green: 0.369, blue: 0.329) // #075E54
    static let waMidTeal       = Color(red: 0.071, green: 0.549, blue: 0.494) // #128C7E
    static let waDarkTeal      = Color(red: 0.020, green: 0.302, blue: 0.267) // #054D44

    // MARK: - Bubbles
    static let waOutgoingLight = Color(red: 0.851, green: 0.992, blue: 0.827) // #D9FDD3
    static let waOutgoingDark  = Color(red: 0.000, green: 0.361, blue: 0.294) // #005C4B
    static let waIncomingLight = Color.white
    static let waIncomingDark  = Color(red: 0.122, green: 0.173, blue: 0.204) // #1F2C34

    // MARK: - Canvas
    static let waWallpaperLight = Color(red: 0.925, green: 0.898, blue: 0.867) // #ECE5DD
    static let waWallpaperDark  = Color(red: 0.043, green: 0.078, blue: 0.102) // #0B141A
    static let waCanvasLight    = Color.white                                   // #FFFFFF
    static let waCanvasDark     = Color(red: 0.067, green: 0.106, blue: 0.129) // #111B21
    static let waSurface1Light  = Color(red: 0.969, green: 0.973, blue: 0.980) // #F7F8FA
    static let waSurface1Dark   = Color(red: 0.125, green: 0.173, blue: 0.200) // #202C33
    static let waSurface2Dark   = Color(red: 0.165, green: 0.224, blue: 0.259) // #2A3942
    static let waDividerLight   = Color(red: 0.914, green: 0.929, blue: 0.937) // #E9EDEF
    static let waDividerDark    = Color(red: 0.133, green: 0.176, blue: 0.204) // #222D34

    // MARK: - Text
    static let waTextPrimary    = Color(red: 0.067, green: 0.106, blue: 0.129) // #111B21
    static let waTextSecondary  = Color(red: 0.400, green: 0.467, blue: 0.506) // #667781
    static let waTextTertiary   = Color(red: 0.525, green: 0.588, blue: 0.627) // #8696A0
    static let waTextPrimaryDark   = Color(red: 0.914, green: 0.929, blue: 0.937) // #E9EDEF
    static let waTextSecondaryDark = Color(red: 0.525, green: 0.588, blue: 0.627) // #8696A0

    // MARK: - Semantic
    static let waReadBlue      = Color(red: 0.325, green: 0.741, blue: 0.922) // #53BDEB
    static let waErrorRed      = Color(red: 0.945, green: 0.361, blue: 0.427) // #F15C6D
}

// MARK: - Données & état (showroom + histoire LPSP)

@MainActor
fileprivate final class LpspWhatsAppStore: ObservableObject {
    @Published private(set) var threads: [LpspConversation]
    @Published var messagesByThread: [String: [LpspWhatsAppSpectrMessage]]

    init(conversations: [LpspConversation]) {
        self.threads = conversations
        self.messagesByThread = Dictionary(
            uniqueKeysWithValues: conversations.map { ($0.id, LpspWhatsAppStore.makeDisplayMessages(for: $0)) }
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
            .init(kind: .outgoing(text: trimmed, time: time, readState: .delivered))
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
            let updated = LpspConversation(
                id: old.id,
                contactName: old.contactName,
                messages: old.messages + [newMessage],
                isUnread: false
            )
            threads[index] = updated
        }
    }

    private static func makeDisplayMessages(for conversation: LpspConversation) -> [LpspWhatsAppSpectrMessage] {
        if conversation.id == LpspWhatsAppShowroomData.mayaThreadId {
            return LpspWhatsAppSpectrMayaThread.seed
        }
        return conversation.messages.map { message in
            let time = LpspAdapters.formatWhatsAppBubbleTime(message)
            if message.isUser {
                return LpspWhatsAppSpectrMessage(
                    kind: .outgoing(text: message.text, time: time, readState: .read)
                )
            }
            return LpspWhatsAppSpectrMessage(
                kind: .incoming(text: message.text, time: time)
            )
        }
    }
}

private enum LpspWhatsAppShowroomData {
    static let mayaThreadId = "wa-maya-rivera"

    static var conversations: [LpspConversation] {
        [
            LpspConversation(
                id: mayaThreadId,
                contactName: "Maya Rivera",
                messages: mayaPlainMessages,
                isUnread: false
            ),
            LpspConversation(
                id: "wa-nadia",
                contactName: "Nadia Kerrouche",
                messages: [
                    LpspMessage(id: "n1", text: "T'as vu le message de hier ?", isUser: false, date: nil, dateRaw: "J-1 22:15"),
                    LpspMessage(id: "n2", text: "Oui, j'y réponds demain", isUser: true, date: nil, dateRaw: "J-1 22:18"),
                    LpspMessage(id: "n3", text: "T'es où ??", isUser: false, date: nil, dateRaw: "J 14:28"),
                ],
                isUnread: true
            ),
            LpspConversation(
                id: "wa-hugo",
                contactName: "Hugo 💙",
                messages: [
                    LpspMessage(id: "h1", text: "Papa tu me manques, vivement samedi 💙", isUser: false, date: nil, dateRaw: "Hier"),
                ],
                isUnread: false
            ),
            LpspConversation(
                id: "wa-vincent",
                contactName: "Vincent M.",
                messages: [
                    LpspMessage(id: "v1", text: "T'as vu le coffrage ? C'est du sérieux.", isUser: false, date: nil, dateRaw: "Lun."),
                ],
                isUnread: false
            ),
        ]
    }

    private static var mayaPlainMessages: [LpspMessage] {
        [
            LpspMessage(id: "m1", text: "Morning! Did the mockups get sent over last night?", isUser: false, date: nil, dateRaw: "10:21"),
            LpspMessage(id: "m2", text: "Yep, the review file dropped in your inbox around 11pm. Look at the last two screens first.", isUser: true, date: nil, dateRaw: "10:24"),
            LpspMessage(id: "m3", text: "Amazing, pulling it up now 🎉", isUser: false, date: nil, dateRaw: "10:25"),
            LpspMessage(id: "m4", text: "This is gorgeous. Calling in 2", isUser: false, date: nil, dateRaw: "10:29"),
        ]
    }
}

private enum LpspWhatsAppContactStyle {
    static func initials(for name: String) -> String {
        let cleaned = name.filter { $0.isLetter || $0.isWhitespace }
        let parts = cleaned.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        }
        return String(cleaned.prefix(2)).uppercased()
    }

    static func gradient(for name: String) -> [Color] {
        if name.contains("Maya") {
            return [Color(red: 0.431, green: 0.784, blue: 0.710), LpspWhatsAppTokens.waMidTeal]
        }
        if name.contains("Hugo") {
            return [Color(red: 0.45, green: 0.62, blue: 0.95), Color(red: 0.28, green: 0.42, blue: 0.82)]
        }
        return [LpspWhatsAppTokens.waMidTeal, LpspWhatsAppTokens.waTeal]
    }

    static func subtitle(for name: String) -> String {
        if name.contains("Maya") { return "online" }
        if name.contains("Nadia") { return "last seen today at 14:28" }
        return "last seen recently"
    }

    static func isOnline(_ name: String) -> Bool {
        name.contains("Maya")
    }
}

private enum LpspWhatsAppFonts {
    static let waLargeTitle    = Font.system(size: 34, weight: .bold)
    static let waNavTitle      = Font.system(size: 17, weight: .semibold)
    static let waContactName   = Font.system(size: 17, weight: .semibold)
    static let waMessagePreview = Font.system(size: 15, weight: .regular)
    static let waBubbleBody    = Font.system(size: 17, weight: .regular)
    static let waGroupSender   = Font.system(size: 13, weight: .semibold)
    static let waTimestampList = Font.system(size: 12, weight: .regular)
    static let waTimestampBubble = Font.system(size: 11, weight: .regular)
    static let waSectionHeader = Font.system(size: 13, weight: .semibold)
    static let waSystemMessage = Font.system(size: 12, weight: .medium)
    static let waTabLabel      = Font.system(size: 10, weight: .medium)
    static let waButton        = Font.system(size: 17, weight: .semibold)
    static let waInputPlaceholder = Font.system(size: 16, weight: .regular)
}

fileprivate struct LpspWhatsAppWASendButton: View {
    let hasText: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: hasText ? "paperplane.fill" : "mic.fill")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(Circle().fill(LpspWhatsAppTokens.waGreen))
                .contentTransition(.symbolEffect(.replace))
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: hasText)
        .buttonStyle(LpspWhatsAppWAPressableStyle(pressedScale: 0.92))
    }
}

fileprivate struct LpspWhatsAppWAPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.22, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspWhatsAppWAOutgoingBubble: View {
    let text: String
    let timestamp: String
    let readState: ReadState

    enum ReadState { case sent, delivered, read }

    var body: some View {
        LpspWhatsAppSpectrTextBubble(
            text: text,
            time: timestamp,
            outgoing: true,
            readState: readState
        )
    }
}

fileprivate struct LpspWhatsAppWAChatListRow<Avatar: View>: View {
    let avatar: Avatar
    let name: String
    let preview: String
    let timestamp: String
    let unreadCount: Int
    let hasStatusRing: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                if hasStatusRing {
                    Circle()
                        .strokeBorder(LpspWhatsAppTokens.waGreen, lineWidth: 2.5)
                        .frame(width: 54, height: 54)
                }
                avatar
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(LpspWhatsAppFonts.waContactName)
                    .foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
                    .lineLimit(1)
                Text(preview)
                    .font(LpspWhatsAppFonts.waMessagePreview)
                    .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(timestamp)
                    .font(LpspWhatsAppFonts.waTimestampList)
                    .foregroundStyle(unreadCount > 0 ? LpspWhatsAppTokens.waGreen : LpspWhatsAppTokens.waTextSecondary)
                if unreadCount > 0 {
                    Text("\(unreadCount)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(LpspWhatsAppTokens.waGreen))
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspWhatsAppWAVoiceWaveformBubble: View {
    let duration: String
    @State private var isPlaying = false
    @State private var progress: Double = 0.0
    // Amplitude samples normalized 0..1
    let amplitudes: [CGFloat] = (0..<48).map { _ in CGFloat.random(in: 0.2...1.0) }

    var body: some View {
        HStack(spacing: 10) {
            Button {
                isPlaying.toggle()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(LpspWhatsAppTokens.waGreen))
            }
            .sensoryFeedback(.impact(flexibility: .soft), trigger: isPlaying)

            GeometryReader { geo in
                HStack(spacing: 2) {
                    ForEach(0..<amplitudes.count, id: \.self) { i in
                        let playedFraction = Double(i) / Double(amplitudes.count)
                        Capsule()
                            .fill(playedFraction <= progress ? LpspWhatsAppTokens.waGreen : LpspWhatsAppTokens.waTextTertiary)
                            .frame(width: 2, height: max(4, amplitudes[i] * 20))
                    }
                }
                .frame(height: 24)
            }
            .frame(height: 24)

            Text(duration)
                .font(LpspWhatsAppFonts.waTimestampBubble)
                .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: 12,
                bottomLeadingRadius: 12,
                bottomTrailingRadius: 0,
                topTrailingRadius: 12
            )
            .fill(LpspWhatsAppTokens.waOutgoingLight)
        )
    }
}

fileprivate struct LpspWhatsAppWAComposeBar: View {
    @State private var text: String = ""

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 10) {
                Button { } label: {
                    Image(systemName: "face.smiling")
                        .font(.system(size: 22))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                }
                TextField("Message", text: $text, axis: .vertical)
                    .font(LpspWhatsAppFonts.waInputPlaceholder)
                    .lineLimit(1...5)
                Button { } label: {
                    Image(systemName: "paperclip")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                        .rotationEffect(.degrees(-45))
                }
                Button { } label: {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .background(Capsule().fill(Color.white))

            LpspWhatsAppWASendButton(hasText: !text.isEmpty) {
                text = ""
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(LpspWhatsAppTokens.waSurface1Light)
    }
}

fileprivate struct LpspWhatsAppWAChatScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top nav handled by NavigationStack
            ScrollView {
                LazyVStack(spacing: 2) {
                    LpspWhatsAppWAEncryptionBanner()
                    LpspWhatsAppWAOutgoingBubble(
                        text: "Hey are you around?",
                        timestamp: "10:24",
                        readState: .read
                    )
                    LpspWhatsAppWAIncomingBubble(text: "Yes, about to head out")
                    LpspWhatsAppWAVoiceWaveformBubble(duration: "0:23")
                }
                .padding(.vertical, 8)
            }
            .background(
                LpspWhatsAppTokens.waWallpaperLight
                    .overlay(LpspWhatsAppWADoodleWallpaper().opacity(0.08))
            )
            LpspWhatsAppWAComposeBar()
        }
    }
}

fileprivate struct LpspWhatsAppWAEncryptionBanner: View {
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "lock.fill").font(.system(size: 10))
            Text("Messages are end-to-end encrypted. No one outside this chat, not even WhatsApp, can read or listen to them.")
                .font(LpspWhatsAppFonts.waSystemMessage)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Capsule().fill(Color(red: 1.0, green: 0.96, blue: 0.77)))
        .padding(.horizontal, 24)
    }
}

fileprivate struct LpspWhatsAppWAIncomingBubble: View {
    let text: String
    var timestamp: String = ""

    var body: some View {
        LpspWhatsAppSpectrTextBubble(text: text, time: timestamp, outgoing: false)
    }
}

fileprivate struct LpspWhatsAppWADoodleWallpaper: View {
    // Decorative doodle tile — use an Image asset in production
    var body: some View { Color.clear }
}



// MARK: - Écrans showroom

private enum LpspWhatsAppTab: Int, CaseIterable {
    case updates, calls, communities, chats, settings

    var label: String {
        switch self {
        case .updates: "Updates"
        case .calls: "Calls"
        case .communities: "Communities"
        case .chats: "Chats"
        case .settings: "Settings"
        }
    }

    var icon: String {
        switch self {
        case .updates: "circle.dashed"
        case .calls: "phone.fill"
        case .communities: "person.3.fill"
        case .chats: "message.fill"
        case .settings: "gearshape.fill"
        }
    }
}

private enum LpspWhatsAppChatRoute: Hashable {
    case thread(String)
}

private struct LpspWhatsAppShowroomRoot: View {
    @ObservedObject var store: LpspWhatsAppStore
    var isStoryMode = false
    @State private var selectedTab: LpspWhatsAppTab = .chats
    @State private var chatsPath = NavigationPath()

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .updates:
                    LpspWhatsAppUpdatesTabScreen(contacts: store.threads.map(\.contactName))
                case .calls:
                    LpspWhatsAppCallsTabScreen(store: store)
                case .communities:
                    LpspWhatsAppCommunitiesTabScreen(isStoryMode: isStoryMode)
                case .chats:
                    LpspWhatsAppChatsTabScreen(store: store, path: $chatsPath)
                case .settings:
                    LpspWhatsAppSettingsTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspWhatsAppSpectrTabBar(selectedTab: $selectedTab)
        }
        .background(LpspWhatsAppTokens.waCanvasLight.ignoresSafeArea())
        .preferredColorScheme(.light)
    }
}


private struct LpspWhatsAppGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspWhatsAppTokens.waErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspWhatsAppTokens.waErrorRed))
                    VStack(alignment: .leading) {
                        Text("\(title) \(i + 1)").font(.system(size: 17, weight: .semibold))
                        Text("Contenu démo").font(.system(size: 14)).foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}


private struct LpspWhatsAppDemoChat: Identifiable, Hashable {
    let id: String
    let name: String
    let preview: String
    let time: String
    let unread: Int
    let hasRing: Bool
    let initials: String
    let isOnline: Bool

    var avatarGradient: [Color] {
        switch id {
        case LpspWhatsAppDemoChats.mayaRiveraId:
            [Color(red: 0.431, green: 0.784, blue: 0.710), LpspWhatsAppTokens.waMidTeal]
        default:
            [LpspWhatsAppTokens.waMidTeal, LpspWhatsAppTokens.waTeal]
        }
    }
}

private enum LpspWhatsAppDemoChats {
    static let mayaRiveraId = "maya-rivera"

    static let chats: [LpspWhatsAppDemoChat] = [
        .init(
            id: mayaRiveraId,
            name: "Maya Rivera",
            preview: "This is gorgeous. Calling in 2",
            time: "10:29",
            unread: 0,
            hasRing: false,
            initials: "MR",
            isOnline: true
        ),
        .init(id: "alex-martin", name: "Alex Martin", preview: "On se voit ce soir ?", time: "10:24", unread: 2, hasRing: true, initials: "AM", isOnline: false),
        .init(id: "lea-dupont", name: "Léa Dupont", preview: "Merci pour hier", time: "Hier", unread: 0, hasRing: false, initials: "LD", isOnline: false),
        .init(id: "famille", name: "Famille", preview: "Photo: vacances", time: "Lun.", unread: 5, hasRing: true, initials: "FA", isOnline: false),
    ]

    static func chat(id: String) -> LpspWhatsAppDemoChat? {
        chats.first { $0.id == id }
    }
}

private struct LpspWhatsAppChatsTabScreen: View {
    @ObservedObject var store: LpspWhatsAppStore
    @Binding var path: NavigationPath

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(store.threads) { thread in
                    Button {
                        path.append(LpspWhatsAppChatRoute.thread(thread.id))
                    } label: {
                        LpspWhatsAppWAChatListRow(
                            avatar: LpspWhatsAppDemoAvatar(
                                initials: LpspWhatsAppContactStyle.initials(for: thread.contactName),
                                gradient: LpspWhatsAppContactStyle.gradient(for: thread.contactName)
                            ),
                            name: thread.contactName,
                            preview: thread.preview,
                            timestamp: LpspAdapters.formatShortDate(thread.lastDate, fallback: thread.lastDateRaw),
                            unreadCount: thread.isUnread ? 1 : 0,
                            hasStatusRing: false
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                    }
                    .disabled(true)
                }
            }
            .navigationDestination(for: LpspWhatsAppChatRoute.self) { route in
                switch route {
                case .thread(let id):
                    LpspWhatsAppChatScreen(store: store, threadId: id, onBack: { path.removeLast() })
                }
            }
        }
    }
}

private struct LpspWhatsAppDemoAvatar: View {
    let initials: String
    let gradient: [Color]

    var body: some View {
        Circle()
            .fill(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay(Text(initials).font(.system(size: 13, weight: .semibold)).foregroundStyle(.white))
    }
}


private struct LpspWhatsAppCallsTabScreen: View {
    @ObservedObject var store: LpspWhatsAppStore
    @State private var activeContact: String?

    var body: some View {
        NavigationStack {
            List(store.threads) { thread in
                Button {
                    activeContact = thread.contactName
                } label: {
                    HStack(spacing: 12) {
                        LpspWhatsAppDemoAvatar(
                            initials: LpspWhatsAppContactStyle.initials(for: thread.contactName),
                            gradient: LpspWhatsAppContactStyle.gradient(for: thread.contactName)
                        )
                        .frame(width: 40, height: 40)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(thread.contactName).font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
                            Text("Appel vocal · \(LpspAdapters.formatShortDate(thread.lastDate, fallback: thread.lastDateRaw))")
                                .font(.system(size: 14))
                                .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                        }
                        Spacer()
                        Image(systemName: "info.circle")
                            .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                    }
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
            .navigationTitle("Calls")
            .sheet(isPresented: Binding(
                get: { activeContact != nil },
                set: { if !$0 { activeContact = nil } }
            )) {
                if let name = activeContact {
                    LpspWhatsAppCallSheet(contactName: name)
                }
            }
        }
    }
}

private struct LpspWhatsAppCallSheet: View {
    let contactName: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            LpspWhatsAppDemoAvatar(
                initials: LpspWhatsAppContactStyle.initials(for: contactName),
                gradient: LpspWhatsAppContactStyle.gradient(for: contactName)
            )
            .frame(width: 96, height: 96)
            Text(contactName).font(.system(size: 24, weight: .semibold))
            Text("Appel vocal…").foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
            Spacer()
            HStack(spacing: 48) {
                Button { dismiss() } label: {
                    Image(systemName: "phone.down.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                        .frame(width: 64, height: 64)
                        .background(Circle().fill(LpspWhatsAppTokens.waErrorRed))
                }
                .buttonStyle(LpspWhatsAppWAPressableStyle())
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LpspWhatsAppTokens.waTeal.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspWhatsAppMessagingTabScreen: View {
    let title: String
    var body: some View {
        let low = title.lowercased()
        if low.contains("update") { LpspWhatsAppUpdatesTabScreen(contacts: []) }
        else if low.contains("setting") || low.contains("réglage") { LpspWhatsAppSettingsTabScreen() }
        else if low.contains("communit") { LpspWhatsAppCommunitiesTabScreen() }
        else if low.contains("contact") { LpspWhatsAppContactsTabScreen() }
        else { LpspWhatsAppChatsTabScreen(store: LpspWhatsAppStore(conversations: []), path: .constant(NavigationPath())) }
    }
}

private struct LpspWhatsAppUpdatesTabScreen: View {
    let contacts: [String]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            LpspWhatsAppStatusCircle(label: "My status", isAdd: true)
                            ForEach(contacts.prefix(6), id: \.self) { name in
                                LpspWhatsAppStatusCircle(label: name, isAdd: false)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                    }
                    Text("Recent updates")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                        .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Updates")
        }
    }
}

private struct LpspWhatsAppStatusCircle: View {
    let label: String
    let isAdd: Bool

    var body: some View {
        VStack(spacing: 4) {
            Circle()
                .strokeBorder(isAdd ? LpspWhatsAppTokens.waTextTertiary : LpspWhatsAppTokens.waGreen, lineWidth: 2)
                .frame(width: 66, height: 66)
                .overlay(
                    Circle()
                        .fill(LpspWhatsAppTokens.waSurface1Light)
                        .frame(width: 58, height: 58)
                        .overlay(
                            Image(systemName: isAdd ? "plus" : "person.fill")
                                .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                        )
                )
            Text(label)
                .font(.system(size: 11))
                .foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
                .lineLimit(1)
                .frame(width: 72)
        }
    }
}

private struct LpspWhatsAppSettingsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    NavigationLink { LpspWhatsAppSettingsDetailScreen(title: "Profile") } label: {
                        Label("Profile", systemImage: "person.circle")
                    }
                    NavigationLink { LpspWhatsAppSettingsDetailScreen(title: "Privacy") } label: {
                        Label("Privacy", systemImage: "lock")
                    }
                }
                Section("App") {
                    NavigationLink { LpspWhatsAppSettingsDetailScreen(title: "Notifications") } label: {
                        Label("Notifications", systemImage: "bell")
                    }
                    NavigationLink { LpspWhatsAppSettingsDetailScreen(title: "Storage") } label: {
                        Label("Storage and data", systemImage: "internaldrive")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
        }
    }
}

private struct LpspWhatsAppSettingsDetailScreen: View {
    let title: String
    @Environment(\.deviceOwner) private var owner

    var body: some View {
        List {
            if title == "Privacy" {
                Toggle("Read receipts", isOn: .constant(true))
                Toggle("Profile photo", isOn: .constant(true))
                Toggle("Last seen", isOn: .constant(true))
            } else if title == "Notifications" {
                Toggle("Message notifications", isOn: .constant(true))
                Toggle("Reaction notifications", isOn: .constant(true))
                Toggle("Show previews", isOn: .constant(false))
            } else if title == "Storage" {
                HStack {
                    Text("Network usage")
                    Spacer()
                    Text("142 MB").foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                }
                HStack {
                    Text("Manage storage")
                    Spacer()
                    Text("1.2 GB").foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                }
            } else {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(owner.name).foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                }
                HStack {
                    Text("About")
                    Spacer()
                    Text("Available").foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct LpspWhatsAppCommunitiesTabScreen: View {
    var isStoryMode = false

    var body: some View {
        NavigationStack {
            Group {
                if isStoryMode {
                    ContentUnavailableView(
                        "No communities",
                        systemImage: "person.3",
                        description: Text("Communities you join will appear here.")
                    )
                } else {
                    List {
                        NavigationLink { LpspWhatsAppCommunityDetailScreen(name: "Design Guild") } label: {
                            Label("Design Guild", systemImage: "person.3")
                        }
                        NavigationLink { LpspWhatsAppCommunityDetailScreen(name: "Famille") } label: {
                            Label("Famille", systemImage: "person.3")
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Communities")
        }
    }
}

private struct LpspWhatsAppCommunityDetailScreen: View {
    let name: String

    var body: some View {
        List {
            Section("Announcements") {
                Text("Demo day Friday — bring a laptop.")
            }
            Section("Groups") {
                Text("general")
                Text("design-crit")
            }
        }
        .navigationTitle(name)
    }
}

private struct LpspWhatsAppContactsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Alex Martin", "Léa Dupont"], id: \.self) { Label($0, systemImage: "person.circle") }
            .navigationTitle("Contacts")
        }
    }
}

private struct LpspWhatsAppDemoBubble: View {
    let text: String
    var outgoing: Bool = true
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 60) }
            Text(text)
                .font(.system(size: 17))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspWhatsAppTokens.waErrorRed.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 8)
    }
}

private struct LpspWhatsAppDemoComposeBar: View {
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Message", text: $text)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill")
                .foregroundStyle(LpspWhatsAppTokens.waErrorRed)
                .font(.title2)
        }
        .padding(8)
        .background(.ultraThinMaterial)
    }
}


// MARK: - Spectr chat (https://www.spectr.to/gallery/whatsapp)

fileprivate struct LpspWhatsAppSpectrMessage: Identifiable {
    enum Kind {
        case incoming(text: String, time: String)
        case outgoing(text: String, time: String, readState: LpspWhatsAppWAOutgoingBubble.ReadState)
        case voice(time: String, duration: String, readState: LpspWhatsAppWAOutgoingBubble.ReadState)
    }

    let id = UUID()
    let kind: Kind
}

fileprivate enum LpspWhatsAppSpectrMayaThread {
    static let seed: [LpspWhatsAppSpectrMessage] = [
        .init(kind: .incoming(text: "Morning! Did the mockups get sent over last night?", time: "10:21")),
        .init(kind: .outgoing(text: "Yep, the review file dropped in your inbox around 11pm. Look at the last two screens first.", time: "10:24", readState: .read)),
        .init(kind: .incoming(text: "Amazing, pulling it up now 🎉", time: "10:25")),
        .init(kind: .voice(time: "10:27", duration: "0:23", readState: .read)),
        .init(kind: .incoming(text: "This is gorgeous. Calling in 2", time: "10:29")),
    ]
}

/// Conversation interactive — rendu Spectr, données showroom ou histoire LPSP.
private struct LpspWhatsAppChatScreen: View {
    @ObservedObject var store: LpspWhatsAppStore
    let threadId: String
    let onBack: () -> Void

    @State private var draft = ""
    @State private var showVideoCall = false
    @State private var showVoiceCall = false
    @FocusState private var inputFocused: Bool

    private var thread: LpspConversation? { store.thread(id: threadId) }
    private var contactName: String { thread?.contactName ?? "" }
    private var messages: [LpspWhatsAppSpectrMessage] { store.messagesByThread[threadId] ?? [] }

    var body: some View {
        VStack(spacing: 0) {
            LpspWhatsAppSpectrChatNav(
                contactName: contactName,
                onBack: onBack,
                onVideo: { showVideoCall = true },
                onPhone: { showVoiceCall = true }
            )
            LpspWhatsAppSpectrChatBody(messages: messages)
            LpspWhatsAppSpectrInputBar(
                text: $draft,
                isFocused: $inputFocused,
                onSend: sendMessage
            )
        }
        .background(LpspWhatsAppTokens.waWallpaperLight.ignoresSafeArea())
        .navigationBarHidden(true)
        .onAppear { store.markAsRead(threadId: threadId) }
        .sheet(isPresented: $showVideoCall) {
            LpspWhatsAppCallSheet(contactName: contactName)
        }
        .sheet(isPresented: $showVoiceCall) {
            LpspWhatsAppCallSheet(contactName: contactName)
        }
    }

    private func sendMessage() {
        store.send(text: draft, threadId: threadId)
        draft = ""
        inputFocused = false
    }
}

private struct LpspWhatsAppSpectrInputBarStatic: View {
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 10) {
                Image(systemName: "face.smiling")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                Text("Message")
                    .font(.system(size: 16))
                    .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                Spacer(minLength: 0)
                Image(systemName: "paperclip")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                    .rotationEffect(.degrees(-45))
                Image(systemName: "camera.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 14)
            .background(Capsule().fill(Color.white))
            Circle()
                .fill(LpspWhatsAppTokens.waGreen)
                .frame(width: 34, height: 34)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                )
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(LpspWhatsAppTokens.waSurface1Light)
    }
}

private struct LpspWhatsAppSpectrChatNav: View {
    let contactName: String
    let onBack: () -> Void
    let onVideo: () -> Void
    let onPhone: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(LpspWhatsAppTokens.waGreen)
            }
            .buttonStyle(LpspWhatsAppWAPressableStyle())

            Button(action: onBack) {
                HStack(spacing: 10) {
                    LpspWhatsAppDemoAvatar(
                        initials: LpspWhatsAppContactStyle.initials(for: contactName),
                        gradient: LpspWhatsAppContactStyle.gradient(for: contactName)
                    )
                    .frame(width: 32, height: 32)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(contactName)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
                        Text(LpspWhatsAppContactStyle.subtitle(for: contactName))
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(
                                LpspWhatsAppContactStyle.isOnline(contactName)
                                    ? LpspWhatsAppTokens.waMidTeal
                                    : LpspWhatsAppTokens.waTextSecondary
                            )
                    }
                }
            }
            .buttonStyle(LpspWhatsAppWAPressableStyle(pressedScale: 0.98))

            Spacer()
            HStack(spacing: 16) {
                Button(action: onVideo) {
                    Image(systemName: "video.fill")
                }
                Button(action: onPhone) {
                    Image(systemName: "phone.fill")
                }
            }
            .font(.system(size: 18))
            .foregroundStyle(LpspWhatsAppTokens.waMidTeal)
            .buttonStyle(LpspWhatsAppWAPressableStyle())
        }
        .padding(.horizontal, 12)
        .frame(height: 56)
        .background(LpspWhatsAppTokens.waCanvasLight)
    }
}

private struct LpspWhatsAppSpectrChatBody: View {
    let messages: [LpspWhatsAppSpectrMessage]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 3) {
                    LpspWhatsAppSpectrE2EBanner()
                    ForEach(messages) { message in
                        switch message.kind {
                        case .incoming(let text, let time):
                            LpspWhatsAppSpectrTextBubble(text: text, time: time, outgoing: false)
                                .id(message.id)
                        case .outgoing(let text, let time, let readState):
                            LpspWhatsAppSpectrTextBubble(text: text, time: time, outgoing: true, readState: readState)
                                .id(message.id)
                        case .voice(let time, let duration, let readState):
                            LpspWhatsAppSpectrVoiceBubble(time: time, duration: duration, readState: readState)
                                .id(message.id)
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            .background(LpspWhatsAppTokens.waWallpaperLight)
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

private struct LpspWhatsAppSpectrE2EBanner: View {
    var body: some View {
        Text("Messages and calls are end-to-end encrypted.")
            .font(.system(size: 10.5, weight: .medium))
            .foregroundStyle(Color(red: 0.329, green: 0.388, blue: 0.427))
            .multilineTextAlignment(.center)
            .lineSpacing(2)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(maxWidth: 240)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(red: 1.0, green: 0.961, blue: 0.769))
                    .shadow(color: .black.opacity(0.04), radius: 0.5, y: 1)
            )
            .padding(.bottom, 8)
    }
}

private struct LpspWhatsAppSpectrTextBubble: View {
    let text: String
    let time: String
    let outgoing: Bool
    var readState: LpspWhatsAppWAOutgoingBubble.ReadState?

    private var bubbleShape: UnevenRoundedRectangle {
        if outgoing {
            UnevenRoundedRectangle(
                topLeadingRadius: 8,
                bottomLeadingRadius: 8,
                bottomTrailingRadius: 2,
                topTrailingRadius: 8
            )
        } else {
            UnevenRoundedRectangle(
                topLeadingRadius: 8,
                bottomLeadingRadius: 2,
                bottomTrailingRadius: 8,
                topTrailingRadius: 8
            )
        }
    }

    private var metaTrailingPadding: CGFloat {
        guard !time.isEmpty || (outgoing && readState != nil) else { return 10 }
        let timeWidth = CGFloat(max(time.count, 4)) * 5.5
        let ticks: CGFloat = (outgoing && readState != nil) ? 16 : 0
        return timeWidth + ticks + 14
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if outgoing { Spacer(minLength: UIScreen.main.bounds.width * 0.22) }

            Text(verbatim: text)
                .font(.system(size: 13))
                .foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
                .lineSpacing(2)
                .multilineTextAlignment(outgoing ? .trailing : .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 6)
                .padding(.leading, 10)
                .padding(.trailing, metaTrailingPadding)
                .padding(.bottom, 18)
                .background(
                    bubbleShape
                        .fill(outgoing ? LpspWhatsAppTokens.waOutgoingLight : LpspWhatsAppTokens.waIncomingLight)
                        .shadow(color: .black.opacity(0.08), radius: 0.5, y: 1)
                )
                .overlay(alignment: .bottomTrailing) {
                    HStack(spacing: 3) {
                        if !time.isEmpty {
                            Text(time)
                                .font(.system(size: 10.5, weight: .regular))
                                .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                        }
                        if outgoing, let readState {
                            LpspWhatsAppSpectrReadTicks(state: readState)
                        }
                    }
                    .padding(.trailing, 10)
                    .padding(.bottom, 4)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.78, alignment: outgoing ? .trailing : .leading)

            if !outgoing { Spacer(minLength: UIScreen.main.bounds.width * 0.22) }
        }
    }
}

private struct LpspWhatsAppSpectrReadTicks: View {
    let state: LpspWhatsAppWAOutgoingBubble.ReadState

    var body: some View {
        HStack(spacing: -4) {
            Image(systemName: "checkmark")
            Image(systemName: "checkmark")
        }
        .font(.system(size: 9, weight: .bold))
        .foregroundStyle(state == .read ? LpspWhatsAppTokens.waReadBlue : LpspWhatsAppTokens.waTextTertiary)
    }
}

private struct LpspWhatsAppSpectrVoiceBubble: View {
    let time: String
    let duration: String
    let readState: LpspWhatsAppWAOutgoingBubble.ReadState

    @State private var isPlaying = false

    private let playedHeights: [CGFloat] = [0.30, 0.50, 0.70, 0.45, 0.85, 0.65, 0.40, 0.75, 0.55, 0.90, 0.60, 0.35, 0.70, 0.50, 0.80]
    private let unplayedHeights: [CGFloat] = [0.40, 0.60, 0.30, 0.75, 0.45, 0.65, 0.35, 0.55, 0.70, 0.40, 0.60, 0.30, 0.50, 0.65, 0.45]

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Spacer(minLength: UIScreen.main.bounds.width * 0.22)
            HStack(spacing: 8) {
                Button { isPlaying.toggle() } label: {
                    Circle()
                        .fill(LpspWhatsAppTokens.waGreen)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(.white)
                                .offset(x: isPlaying ? 0 : 1)
                        )
                }
                .buttonStyle(LpspWhatsAppWAPressableStyle(pressedScale: 0.92))
                HStack(spacing: 1.5) {
                    ForEach(Array(playedHeights.enumerated()), id: \.offset) { _, h in
                        Capsule()
                            .fill(LpspWhatsAppTokens.waGreen)
                            .frame(width: 2, height: max(4, h * 22))
                    }
                    ForEach(Array(unplayedHeights.enumerated()), id: \.offset) { _, h in
                        Capsule()
                            .fill(LpspWhatsAppTokens.waTextTertiary.opacity(isPlaying ? 0.75 : 0.55))
                            .frame(width: 2, height: max(4, h * 22))
                    }
                }
                .frame(height: 22)
                Text(duration)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
            }
            .padding(.top, 8)
            .padding(.bottom, 18)
            .padding(.horizontal, 10)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 8,
                    bottomLeadingRadius: 8,
                    bottomTrailingRadius: 2,
                    topTrailingRadius: 8
                )
                .fill(LpspWhatsAppTokens.waOutgoingLight)
                .shadow(color: .black.opacity(0.08), radius: 0.5, y: 1)
            )
            .overlay(alignment: .bottomTrailing) {
                HStack(spacing: 3) {
                    Text(time)
                        .font(.system(size: 10.5, weight: .regular))
                        .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                    LpspWhatsAppSpectrReadTicks(state: readState)
                }
                .padding(.trailing, 10)
                .padding(.bottom, 4)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.78, alignment: .trailing)
        }
    }
}

private struct LpspWhatsAppSpectrInputBar: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    let onSend: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 10) {
                Button { } label: {
                    Image(systemName: "face.smiling")
                        .font(.system(size: 22))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                }
                .buttonStyle(LpspWhatsAppWAPressableStyle())

                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text("Message")
                            .font(.system(size: 16))
                            .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                    }
                    TextField("", text: $text, axis: .vertical)
                        .font(.system(size: 16))
                        .foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
                        .lineLimit(1...5)
                        .focused(isFocused)
                }

                Button { } label: {
                    Image(systemName: "paperclip")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                        .rotationEffect(.degrees(-45))
                }
                .buttonStyle(LpspWhatsAppWAPressableStyle())

                Button { } label: {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                }
                .buttonStyle(LpspWhatsAppWAPressableStyle())
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 14)
            .background(Capsule().fill(Color.white))

            Button {
                if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    isFocused.wrappedValue = false
                } else {
                    onSend()
                }
            } label: {
                Circle()
                    .fill(LpspWhatsAppTokens.waGreen)
                    .frame(width: 34, height: 34)
                    .overlay(
                        Image(systemName: text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "mic.fill" : "paperplane.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    )
            }
            .buttonStyle(LpspWhatsAppWAPressableStyle(pressedScale: 0.92))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(LpspWhatsAppTokens.waSurface1Light)
    }
}

private struct LpspWhatsAppSpectrTabBar: View {
    @Binding var selectedTab: LpspWhatsAppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspWhatsAppTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22))
                        Text(tab.label)
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundStyle(selectedTab == tab ? LpspWhatsAppTokens.waGreen : LpspWhatsAppTokens.waTextTertiary)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(LpspWhatsAppWAPressableStyle(pressedScale: 0.95))
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 2)
        .background(LpspWhatsAppTokens.waSurface1Light)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspWhatsAppTokens.waDividerLight)
                .frame(height: 0.5)
        }
    }
}



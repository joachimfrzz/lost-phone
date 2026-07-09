import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/grok
// Meliwat/awesome-ios-design-md/misc/grok/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeGrokView: View {
    var body: some View {
        LpspGrokShowroomRoot(store: LpspGrokStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspGrokFonts {
    static let grokScreenTitle  = Font.system(size: 28, weight: .regular)
    static let grokSectionHeader = Font.system(size: 20, weight: .regular)
    static let grokConvoTitle   = Font.system(size: 17, weight: .regular)
    static let grokBody         = Font.system(size: 16, weight: .regular)
    static let grokPromptInput  = Font.system(size: 16, weight: .regular)
    static let grokModePill     = Font.system(size: 14, weight: .regular)
    static let grokCiteAuthor   = Font.system(size: 14, weight: .regular)
    static let grokCiteMeta     = Font.system(size: 13, weight: .regular)
    static let grokBodySmall    = Font.system(size: 14, weight: .regular)
    static let grokCode         = Font.system(size: 13.5, weight: .regular)
    static let grokButton       = Font.system(size: 15, weight: .regular)
    static let grokCaption      = Font.system(size: 12, weight: .regular)
    static let grokLabelUpper   = Font.system(size: 11, weight: .regular)
    static func grok(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspGrokTokens {
    // MARK: - Canvas & Surfaces
    static let grokCanvas    = Color.black                                  // #000000
    static let grokSurface1  = Color(red: 0.086, green: 0.094, blue: 0.110) // #16181C
    static let grokSurface2  = Color(red: 0.118, green: 0.129, blue: 0.149) // #1E2126
    static let grokSurface3  = Color(red: 0.153, green: 0.165, blue: 0.180) // #272A2E
    static let grokDivider   = Color(red: 0.184, green: 0.200, blue: 0.212) // #2F3336

    // MARK: - Text
    static let grokTextPrimary   = Color(red: 0.906, green: 0.914, blue: 0.918) // #E7E9EA
    static let grokTextSecondary = Color(red: 0.443, green: 0.463, blue: 0.482) // #71767B
    static let grokTextTertiary  = Color(red: 0.302, green: 0.318, blue: 0.337) // #4D5156

    // MARK: - Functional / Brand
    static let grokAccentWhite   = Color.white                                  // #FFFFFF
    static let grokPressedWhite  = Color(red: 0.843, green: 0.859, blue: 0.863) // #D7DBDC
    static let grokLinkBlue      = Color(red: 0.114, green: 0.608, blue: 0.941) // #1D9BF0
    static let grokLinkPressed   = Color(red: 0.102, green: 0.549, blue: 0.847) // #1A8CD8
    static let grokSuccess       = Color(red: 0.000, green: 0.729, blue: 0.486) // #00BA7C
    static let grokError         = Color(red: 0.957, green: 0.129, blue: 0.180) // #F4212E
}



// Enable the slashed zero on numeral-bearing Text (technical identity)
fileprivate extension View {
    func grokSlashedZero() -> some View {
        self.font(LpspGrokFonts.grokBody).monospacedDigit()
    }
}

// Convenience until Inter is registered:


fileprivate struct LpspGrokGrokGlyphMark: View {
    var size: CGFloat = 24

    var body: some View {
        Text("G")
            .font(.system(size: size * 0.58, weight: .bold, design: .rounded))
            .foregroundStyle(LpspGrokTokens.grokTextPrimary)
            .frame(width: size, height: size)
    }
}

fileprivate struct LpspGrokGrokUserBubble: View {
    let text: String

    var body: some View {
        HStack {
            Spacer(minLength: 48)
            Text(text)
                .font(LpspGrokFonts.grokBody)
                .foregroundStyle(LpspGrokTokens.grokTextPrimary)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(topLeading: 20, bottomLeading: 20,
                                           bottomTrailing: 6, topTrailing: 20)
                    )
                    .fill(LpspGrokTokens.grokSurface1)
                )
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

fileprivate struct LpspGrokGrokAssistantResponse: View {
    let text: String
    let isStreaming: Bool
    @State private var cursorVisible = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            LpspGrokGrokGlyphMark(size: 24)

            (Text(text)
                + (isStreaming
                   ? Text("▍").foregroundColor(cursorVisible ? LpspGrokTokens.grokTextPrimary : .clear)
                   : Text("")))
                .font(LpspGrokFonts.grokBody)
                .foregroundStyle(LpspGrokTokens.grokTextPrimary)
                .lineSpacing(6) // ~1.55 line-height at 16pt
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .onAppear { startBlink() }
    }

    private func startBlink() {
        guard isStreaming else { return }
        withAnimation(.easeInOut(duration: 0).repeatForever(autoreverses: true)) {}
        Timer.scheduledTimer(withTimeInterval: 0.53, repeats: true) { t in
            if !isStreaming { t.invalidate(); cursorVisible = false; return }
            cursorVisible.toggle()
        }
    }
}

fileprivate struct LpspGrokXCitationCard: View {
    let author: String
    let handle: String
    let timeAgo: String
    let isVerified: Bool
    let postText: String
    let replies: Int
    let reposts: Int
    let likes: Int
    let onOpen: () -> Void

    @State private var pressed = false

    var body: some View {
        Button(action: onOpen) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Circle().fill(LpspGrokTokens.grokSurface3).frame(width: 28, height: 28)
                    Text(author).font(LpspGrokFonts.grokCiteAuthor).foregroundStyle(LpspGrokTokens.grokTextPrimary)
                    if isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 14)).foregroundStyle(LpspGrokTokens.grokLinkBlue)
                    }
                    Text("@\(handle) · \(timeAgo)")
                        .font(LpspGrokFonts.grokCiteMeta).foregroundStyle(LpspGrokTokens.grokTextSecondary)
                    Spacer()
                    Text("𝕏")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(LpspGrokTokens.grokTextSecondary)
                }
                Text(postText)
                    .font(LpspGrokFonts.grokBodySmall).foregroundStyle(LpspGrokTokens.grokTextPrimary)
                    .lineLimit(4)
                HStack(spacing: 20) {
                    metric("bubble.left", replies)
                    metric("arrow.2.squarepath", reposts)
                    metric("heart", likes)
                }
                .font(LpspGrokFonts.grokCaption).foregroundStyle(LpspGrokTokens.grokTextSecondary)
            }
            .padding(14)
            .background(RoundedRectangle(cornerRadius: 16)
                .fill(pressed ? LpspGrokTokens.grokSurface3 : LpspGrokTokens.grokSurface2))
            .overlay(RoundedRectangle(cornerRadius: 16)
                .strokeBorder(pressed ? LpspGrokTokens.grokLinkBlue : LpspGrokTokens.grokDivider, lineWidth: 1))
        }
        .buttonStyle(.plain)
        .onLongPressGesture(minimumDuration: 0, pressing: { pressed = $0 }, perform: {})
    }

    private func metric(_ symbol: String, _ n: Int) -> some View {
        HStack(spacing: 4) {
            Image(systemName: symbol).font(.system(size: 14))
            Text("\(n)")
        }
    }
}

fileprivate struct LpspGrokGrokSendButton: View {
    enum State { case disabled, enabled, streaming }
    let state: State
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Group {
                switch state {
                case .streaming:
                    Image(systemName: "stop.fill")
                        .foregroundStyle(LpspGrokTokens.grokTextPrimary)
                default:
                    Image(systemName: "arrow.up")
                        .foregroundStyle(state == .enabled ? Color.black : LpspGrokTokens.grokTextSecondary)
                }
            }
            .font(.system(size: 16, weight: .semibold))
            .frame(width: 32, height: 32)
            .background(Circle().fill(fill))
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: state)
        .buttonStyle(LpspGrokGrokPressableStyle(scale: 0.92))
        .disabled(state == .disabled)
    }

    private var fill: Color {
        switch state {
        case .disabled:  return LpspGrokTokens.grokSurface3
        case .enabled:   return LpspGrokTokens.grokAccentWhite
        case .streaming: return LpspGrokTokens.grokSurface3
        }
    }
}

fileprivate struct LpspGrokGrokPressableStyle: ButtonStyle {
    var scale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspGrokGrokModeToggle: View {
    @Binding var isFun: Bool
    @Namespace private var ns

    var body: some View {
        HStack(spacing: 0) {
            segment("Regular", active: !isFun) { isFun = false }
            segment("Fun",     active:  isFun) { isFun = true }
        }
        .padding(3)
        .background(Capsule().fill(LpspGrokTokens.grokSurface1))
        .overlay(Capsule().stroke(LpspGrokTokens.grokDivider, lineWidth: 1))
        .sensoryFeedback(.selection, trigger: isFun)
    }

    private func segment(_ label: String, active: Bool, tap: @escaping () -> Void) -> some View {
        Text(label)
            .font(LpspGrokFonts.grokModePill)
            .foregroundStyle(active ? (label == "Fun" ? LpspGrokTokens.grokLinkBlue : .black)
                                    : LpspGrokTokens.grokTextSecondary)
            .padding(.vertical, 7).padding(.horizontal, 14)
            .background {
                if active {
                    Capsule()
                        .fill(label == "Fun" ? LpspGrokTokens.grokSurface1 : LpspGrokTokens.grokAccentWhite)
                        .matchedGeometryEffect(id: "pill", in: ns)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture { withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) { tap() } }
    }
}

fileprivate struct LpspGrokGrokPromptBar: View {
    @Binding var text: String
    @FocusState private var focused: Bool
    let sendState: LpspGrokGrokSendButton.State
    let onSend: () -> Void

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Image(systemName: "paperclip")
                .font(.system(size: 18)).foregroundStyle(LpspGrokTokens.grokTextSecondary)
            TextField("Ask Grok anything", text: $text, axis: .vertical)
                .font(LpspGrokFonts.grokPromptInput)
                .foregroundStyle(LpspGrokTokens.grokTextPrimary)
                .tint(LpspGrokTokens.grokTextPrimary)
                .lineLimit(1...5)
                .focused($focused)
            LpspGrokGrokSendButton(state: sendState, action: onSend)
        }
        .padding(.horizontal, 12).padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 24).fill(LpspGrokTokens.grokSurface1))
        .overlay(RoundedRectangle(cornerRadius: 24)
            .strokeBorder(focused ? Color(red: 0.243, green: 0.255, blue: 0.275) : LpspGrokTokens.grokDivider,
                          lineWidth: 1))
        .padding(.horizontal, 16)
    }
}



// MARK: - Données & état (showroom Lost Phone)

fileprivate enum LpspGrokShowroomRole {
    case user, assistant
}

fileprivate enum LpspGrokAssistantState {
    case complete
    case streaming
}

fileprivate struct LpspGrokCitation: Identifiable {
    let id: String
    let author: String
    let handle: String
    let timeAgo: String
    let isVerified: Bool
    let postText: String
    let replies: Int
    let reposts: Int
    let likes: Int
}

fileprivate struct LpspGrokShowroomMessage: Identifiable {
    let id: String
    let role: LpspGrokShowroomRole
    let text: String
    var assistantState: LpspGrokAssistantState = .complete
    var citation: LpspGrokCitation?
}

fileprivate struct LpspGrokShowroomConversation: Identifiable {
    let id: String
    var title: String
    let section: String
    var messages: [LpspGrokShowroomMessage]
}

@MainActor
fileprivate final class LpspGrokStore: ObservableObject {
    @Published var conversations: [LpspGrokShowroomConversation]
    @Published var activeConversationID: String
    @Published var composeText = ""
    @Published var isGenerating = false
    @Published var isFunMode = false
    @Published var showDrawer = false
    @Published var drawerSearch = ""

    init() {
        self.conversations = LpspGrokShowroomData.conversations
        self.activeConversationID = LpspGrokShowroomData.defaultConversationID
    }

    var activeConversation: LpspGrokShowroomConversation {
        conversations.first { $0.id == activeConversationID } ?? conversations[0]
    }

    var sendState: LpspGrokGrokSendButton.State {
        if isGenerating { return .streaming }
        return composeText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .disabled : .enabled
    }

    var drawerSections: [(title: String, chats: [LpspGrokShowroomConversation])] {
        let ordered = ["TODAY", "PREVIOUS 7 DAYS", "PREVIOUS 30 DAYS"]
        let filtered = conversations.filter { conv in
            let q = drawerSearch.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            return q.isEmpty || conv.title.lowercased().contains(q)
        }
        return ordered.compactMap { section in
            let chats = filtered.filter { $0.section == section }
            return chats.isEmpty ? nil : (section, chats)
        }
    }

    func selectConversation(_ id: String) {
        activeConversationID = id
        composeText = ""
        showDrawer = false
    }

    func newChat() {
        let id = "new-\(UUID().uuidString.prefix(6))"
        conversations.insert(
            LpspGrokShowroomConversation(id: id, title: "New chat", section: "TODAY", messages: []),
            at: 0
        )
        activeConversationID = id
        composeText = ""
        showDrawer = false
    }

    func sendMessage() {
        let trimmed = composeText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !isGenerating else {
            if isGenerating { stopGenerating() }
            return
        }

        appendMessage(.init(id: UUID().uuidString, role: .user, text: trimmed))
        composeText = ""
        updateTitleIfNeeded(from: trimmed)
        isGenerating = true

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 800_000_000)
            var streaming = LpspGrokShowroomData.reply(for: trimmed, funMode: isFunMode)
            streaming.assistantState = .streaming
            appendMessage(streaming)
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            mutateActive { conv in
                if let idx = conv.messages.lastIndex(where: { $0.role == .assistant }) {
                    var msg = conv.messages[idx]
                    msg.assistantState = .complete
                    conv.messages[idx] = msg
                }
            }
            isGenerating = false
        }
    }

    func stopGenerating() {
        isGenerating = false
        mutateActive { conv in
            if let idx = conv.messages.lastIndex(where: { $0.assistantState == .streaming }) {
                var msg = conv.messages[idx]
                msg.assistantState = .complete
                conv.messages[idx] = msg
            }
        }
    }

    private func appendMessage(_ message: LpspGrokShowroomMessage) {
        mutateActive { $0.messages.append(message) }
    }

    private func updateTitleIfNeeded(from prompt: String) {
        mutateActive { conv in
            if conv.title == "New chat" || conv.title.hasPrefix("What's the latest") {
                conv.title = String(prompt.prefix(42))
            }
        }
    }

    private func mutateActive(_ update: (inout LpspGrokShowroomConversation) -> Void) {
        guard let index = conversations.firstIndex(where: { $0.id == activeConversationID }) else { return }
        var conversation = conversations[index]
        update(&conversation)
        conversations[index] = conversation
    }
}

private enum LpspGrokShowroomData {
    static let defaultConversationID = "grok4-x-launch"

    static let spectrCitation = LpspGrokCitation(
        id: "cite1",
        author: "Devin Park",
        handle: "devbuilds",
        timeAgo: "2h",
        isVerified: true,
        postText: "Grok 4's real-time X access is the actual moat here. Asked it about a thread from 10 minutes ago and it cited the exact posts.",
        replies: 128,
        reposts: 342,
        likes: 2100
    )

    static let conversations: [LpspGrokShowroomConversation] = [
        .init(
            id: "grok4-x-launch",
            title: "What's the latest reaction to the Grok 4 launch on X?",
            section: "TODAY",
            messages: [
                .init(id: "u1", role: .user, text: "What's the latest reaction to the Grok 4 launch on X?"),
                .init(
                    id: "a1",
                    role: .assistant,
                    text: "Developers are focused on real-time X integration — Grok can cite posts from minutes ago, not just training data. Sentiment is mostly impressed, with some skepticism about moderation.",
                    assistantState: .streaming,
                    citation: spectrCitation
                ),
            ]
        ),
        .init(
            id: "louvre-rumors",
            title: "Rumeurs couloir Denon",
            section: "TODAY",
            messages: [
                .init(id: "lu1", role: .user, text: "Que dit X sur les rumeurs de travaux nocturnes au Louvre ?"),
                .init(
                    id: "la1",
                    role: .assistant,
                    text: "Peu de posts publics — surtout des photos floues de camionnettes côté Rivoli. Rien de confirmé, mais plusieurs comptes locaux mentionnent des badges maintenance après 19h.",
                    assistantState: .complete
                ),
            ]
        ),
        .init(
            id: "eventscult-discord",
            title: "EventsCult sur X",
            section: "PREVIOUS 7 DAYS",
            messages: [
                .init(id: "e1", role: .user, text: "Trouve des mentions d'EventsCult sur X cette semaine."),
                .init(
                    id: "ea1",
                    role: .assistant,
                    text: "Aucun compte vérifié. Quelques posts anonymes sur des pop-ups Marais — probablement du bruit. Le fil Discord reste plus actif.",
                    assistantState: .complete
                ),
            ]
        ),
        .init(
            id: "gennevilliers",
            title: "Zone Gennevilliers",
            section: "PREVIOUS 30 DAYS",
            messages: [
                .init(id: "g1", role: .user, text: "Y a-t-il des posts récents sur rue des Caboeufs ?"),
                .init(
                    id: "ga1",
                    role: .assistant,
                    text: "Rien de récent sur X. Sam a validé le point de transfert le 2 juin — mieux vaut rester discret que poster.",
                    assistantState: .complete
                ),
            ]
        ),
    ]

    static func reply(for prompt: String, funMode: Bool) -> LpspGrokShowroomMessage {
        let lower = prompt.lowercased()
        if funMode {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "Fun mode activated 😎 — I'll keep it spicy. Ask me anything about X drama or Lost Phone mysteries.",
                assistantState: .complete
            )
        }
        if lower.contains("louvre") || lower.contains("denon") || lower.contains("maintenance") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "Peu de posts publics — surtout des rumeurs sur des camionnettes Rivoli après 19h. Le créneau **18/06** reste le plus crédible côté maintenance.",
                assistantState: .complete
            )
        }
        if lower.contains("eventscult") || lower.contains("discord") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "EventsCult n'a pas de présence X notable. Le serveur Discord (#planning-s7) est plus parlant pour le brief Dame.",
                assistantState: .complete
            )
        }
        if lower.contains("grok") || lower.contains("x ") || lower.contains("launch") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "Real-time X access remains the headline feature — Grok cites fresh posts with handles and timestamps.",
                assistantState: .complete,
                citation: spectrCitation
            )
        }
        return .init(
            id: UUID().uuidString,
            role: .assistant,
            text: "Je peux chercher sur X si tu précises le sujet, le lieu ou la date.",
            assistantState: .complete
        )
    }
}

// MARK: - Écrans showroom

private struct LpspGrokShowroomRoot: View {
    @ObservedObject var store: LpspGrokStore

    var body: some View {
        ZStack(alignment: .leading) {
            LpspGrokChatScreen(store: store)

            if store.showDrawer {
                Color.black.opacity(0.55)
                    .ignoresSafeArea()
                    .onTapGesture { store.showDrawer = false }

                LpspGrokDrawer(store: store)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.22), value: store.showDrawer)
        .preferredColorScheme(.dark)
    }
}

private struct LpspGrokChatScreen: View {
    @ObservedObject var store: LpspGrokStore

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Button { store.showDrawer = true } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspGrokTokens.grokTextPrimary)
                }
                LpspGrokGrokModeToggle(isFun: $store.isFunMode)
                Spacer()
                Button { store.newChat() } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 18))
                        .foregroundStyle(LpspGrokTokens.grokTextPrimary)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 44)

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(store.activeConversation.messages) { message in
                            LpspGrokMessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(.vertical, 16)
                }
                .onChange(of: store.activeConversation.messages.count) { _, _ in
                    scrollToBottom(proxy: proxy)
                }
            }

            LpspGrokGrokPromptBar(
                text: $store.composeText,
                sendState: store.sendState,
                onSend: { store.sendMessage() }
            )
            .padding(.bottom, 8)
        }
        .background(LpspGrokTokens.grokCanvas.ignoresSafeArea())
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let last = store.activeConversation.messages.last {
            withAnimation(.easeOut(duration: 0.2)) {
                proxy.scrollTo(last.id, anchor: .bottom)
            }
        }
    }
}

private struct LpspGrokMessageView: View {
    let message: LpspGrokShowroomMessage

    var body: some View {
        switch message.role {
        case .user:
            LpspGrokGrokUserBubble(text: message.text)
                .padding(.horizontal, 16)
        case .assistant:
            VStack(alignment: .leading, spacing: 12) {
                LpspGrokGrokAssistantResponse(
                    text: message.text,
                    isStreaming: message.assistantState == .streaming
                )
                if let citation = message.citation {
                    LpspGrokXCitationCard(
                        author: citation.author,
                        handle: citation.handle,
                        timeAgo: citation.timeAgo,
                        isVerified: citation.isVerified,
                        postText: citation.postText,
                        replies: citation.replies,
                        reposts: citation.reposts,
                        likes: citation.likes,
                        onOpen: {}
                    )
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

private struct LpspGrokDrawer: View {
    @ObservedObject var store: LpspGrokStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button { store.newChat() } label: {
                    Text("New chat")
                        .font(LpspGrokFonts.grokButton.weight(.semibold))
                        .foregroundStyle(LpspGrokTokens.grokTextPrimary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(LpspGrokTokens.grokSurface1))
                }
                Spacer()
                Button { store.showDrawer = false } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(LpspGrokTokens.grokTextSecondary)
                }
            }
            .padding(16)

            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(LpspGrokTokens.grokTextSecondary)
                TextField("Search chats", text: $store.drawerSearch)
                    .font(LpspGrokFonts.grokCiteMeta)
                    .foregroundStyle(LpspGrokTokens.grokTextPrimary)
            }
            .padding(12)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(LpspGrokTokens.grokDivider, lineWidth: 1))
            .padding(.horizontal, 16)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(store.drawerSections, id: \.title) { section in
                        Text(section.title)
                            .font(LpspGrokFonts.grokLabelUpper.weight(.semibold))
                            .foregroundStyle(LpspGrokTokens.grokTextSecondary)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .padding(.bottom, 6)

                        ForEach(section.chats) { chat in
                            Button { store.selectConversation(chat.id) } label: {
                                HStack(spacing: 10) {
                                    LpspGrokGrokGlyphMark(size: 18)
                                    Text(chat.title)
                                        .font(LpspGrokFonts.grokConvoTitle)
                                        .foregroundStyle(LpspGrokTokens.grokTextPrimary)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 48)
                                .background(
                                    chat.id == store.activeConversationID
                                        ? LpspGrokTokens.grokSurface2
                                        : Color.clear,
                                    in: Capsule()
                                )
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 8)
                        }
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.82, alignment: .leading)
        .frame(maxHeight: .infinity)
        .background(LpspGrokTokens.grokSurface1)
    }
}

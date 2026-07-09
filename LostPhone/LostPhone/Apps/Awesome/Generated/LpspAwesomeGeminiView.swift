import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/gemini
// Meliwat/awesome-ios-design-md/misc/gemini/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeGeminiView: View {
    var body: some View {
        LpspGeminiShowroomRoot(store: LpspGeminiStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspGeminiFonts {
    static let gemGreeting    = Font.system(size: 28, weight: .medium)
    static let gemTitle       = Font.system(size: 22, weight: .regular)
    static let gemSection     = Font.system(size: 18, weight: .regular)
    static let gemAnswerH2    = Font.system(size: 20, weight: .regular)
    static let gemAnswerH3    = Font.system(size: 17, weight: .regular)
    static let gemAnswerBody  = Font.system(size: 16, weight: .regular)
    static let gemUserTurn    = Font.system(size: 16, weight: .regular)
    static let gemPromptInput = Font.system(size: 16, weight: .regular)
    static let gemChip        = Font.system(size: 14, weight: .medium)
    static let gemMeta        = Font.system(size: 13, weight: .regular)
    static let gemCode        = Font.system(size: 14, weight: .regular)
    static let gemLabelUpper  = Font.system(size: 11, weight: .regular)
    static let gemButton      = Font.system(size: 15, weight: .regular)
    static func gem(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspGeminiTokens {
    // MARK: - Canvas & Surfaces (Light)
    static let gemCanvas   = Color.white                                     // #FFFFFF
    static let gemSurface  = Color(red: 0.941, green: 0.957, blue: 0.976)    // #F0F4F9
    static let gemDivider  = Color(red: 0.890, green: 0.890, blue: 0.890)    // #E3E3E3

    // MARK: - Canvas & Surfaces (Dark)
    static let gemDarkCanvas  = Color(red: 0.118, green: 0.118, blue: 0.118) // #1E1E1E
    static let gemDarkSurface = Color(red: 0.157, green: 0.165, blue: 0.173) // #282A2C
    static let gemDarkDivider = Color(red: 0.235, green: 0.235, blue: 0.235) // #3C3C3C

    // MARK: - Text
    static let gemTextPrimary    = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
    static let gemTextSecondary  = Color(red: 0.373, green: 0.388, blue: 0.408) // #5F6368
    static let gemTextTertiary   = Color(red: 0.604, green: 0.627, blue: 0.651) // #9AA0A6
    static let gemDarkTextPrimary = Color(red: 0.890, green: 0.890, blue: 0.890) // #E3E3E3

    // MARK: - Brand
    static let gemBlue        = Color(red: 0.259, green: 0.522, blue: 0.957) // #4285F4
    static let gemBluePressed = Color(red: 0.200, green: 0.404, blue: 0.839) // #3367D6
    static let gemDarkBlue    = Color(red: 0.541, green: 0.706, blue: 0.973) // #8AB4F8
    static let gemViolet      = Color(red: 0.608, green: 0.447, blue: 0.796) // #9B72CB
    static let gemCoral       = Color(red: 0.851, green: 0.396, blue: 0.439) // #D96570

    // MARK: - Semantic
    static let gemSuccess = Color(red: 0.118, green: 0.557, blue: 0.243)     // #1E8E3E
    static let gemWarning = Color(red: 0.976, green: 0.671, blue: 0.0)       // #F9AB00
    static let gemError   = Color(red: 0.851, green: 0.188, blue: 0.145)     // #D93025
}

// The single brand gesture — used for sparkle, streaming edge, focus ring, chip accents.
private enum LpspGeminiGradients {
    static let gemini = LinearGradient(
        colors: [LpspGeminiTokens.gemBlue, LpspGeminiTokens.gemViolet, LpspGeminiTokens.gemCoral],
        startPoint: .leading, endPoint: .trailing
    )
}





fileprivate struct LpspGeminiGemSparkle: View {
    var size: CGFloat = 20

    var body: some View {
        Image(systemName: "sparkle")
            .font(.system(size: size, weight: .semibold))
            .foregroundStyle(LpspGeminiGradients.gemini) // gradient-filled glyph
            .frame(width: size, height: size)
    }
}

fileprivate struct LpspGeminiGemUserTurn: View {
    let text: String

    var body: some View {
        HStack {
            Spacer(minLength: 48)
            Text(text)
                .font(LpspGeminiFonts.gemUserTurn)
                .foregroundStyle(LpspGeminiTokens.gemTextPrimary)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 20, bottomLeadingRadius: 20,
                        bottomTrailingRadius: 4, topTrailingRadius: 20
                    )
                    .fill(LpspGeminiTokens.gemSurface)
                )
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspGeminiGemAssistantTurn: View {
    let markdown: AttributedString
    let isStreaming: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 10) {
                LpspGeminiGemSparkle(size: 20)
                Text(markdown)
                    .font(LpspGeminiFonts.gemAnswerBody)
                    .foregroundStyle(LpspGeminiTokens.gemTextPrimary)
                    .lineSpacing(8) // ≈ 1.55 line-height at 16pt
                    .textSelection(.enabled)
            }
            if !isStreaming {
                HStack(spacing: 20) {
                    actionIcon("doc.on.doc")     // Copy
                    actionIcon("arrow.clockwise") // Regenerate
                    actionIcon("square.and.arrow.up") // Share
                    actionIcon("ellipsis")
                }
                .padding(.leading, 30)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }

    private func actionIcon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.system(size: 18))
            .foregroundStyle(LpspGeminiTokens.gemTextSecondary)
            .frame(width: 44, height: 44)
            .contentShape(Rectangle())
    }
}

fileprivate struct LpspGeminiGemStreamingText: View {
    let text: String
    @State private var phase: CGFloat = -0.3

    var body: some View {
        Text(text)
            .font(LpspGeminiFonts.gemAnswerBody)
            .foregroundStyle(LpspGeminiTokens.gemTextPrimary)
            .lineSpacing(8)
            .overlay(
                LinearGradient(
                    colors: [.clear, LpspGeminiTokens.gemViolet.opacity(0.28), .clear],
                    startPoint: .init(x: phase, y: 0.5),
                    endPoint: .init(x: phase + 0.3, y: 0.5)
                )
                .blendMode(.plusLighter)
                .allowsHitTesting(false)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.1).repeatForever(autoreverses: false)) {
                    phase = 1.3
                }
            }
    }
}

// Thinking indicator (before first token)
fileprivate struct LpspGeminiGemThinking: View {
    @State private var t = false
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<3) { i in
                Circle()
                    .fill(LpspGeminiGradients.gemini)
                    .frame(width: 7, height: 7)
                    .scaleEffect(t ? 1 : 0.5)
                    .animation(.easeInOut(duration: 0.5).repeatForever().delay(Double(i) * 0.15), value: t)
            }
        }
        .onAppear { t = true }
    }
}

fileprivate struct LpspGeminiGemPromptBar: View {
    @Binding var text: String
    @FocusState private var focused: Bool
    var isStreaming: Bool = false
    let onSend: () -> Void
    let onStop: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Button { /* attach */ } label: {
                Image(systemName: "plus")
                    .font(.system(size: 22)).foregroundStyle(LpspGeminiTokens.gemTextSecondary)
            }
            TextField("Ask Gemini", text: $text, axis: .vertical)
                .font(LpspGeminiFonts.gemPromptInput)
                .focused($focused)
                .lineLimit(1...5)
            Button { /* mic */ } label: {
                Image(systemName: "mic")
                    .font(.system(size: 22)).foregroundStyle(LpspGeminiTokens.gemTextSecondary)
            }
            sendButton
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .frame(minHeight: 52)
        .background(Capsule(style: .continuous).fill(LpspGeminiTokens.gemSurface))
        .overlay(
            Capsule(style: .continuous)
                .strokeBorder(LpspGeminiGradients.gemini, lineWidth: focused ? 1.5 : 0)
                .animation(.easeOut(duration: 0.18), value: focused)
        )
        .padding(.horizontal, 16)
    }

    @ViewBuilder private var sendButton: some View {
        if isStreaming {
            Button(action: onStop) {
                Image(systemName: "stop.fill")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(LpspGeminiTokens.gemBlue))
            }
        } else {
            let active = !text.isEmpty
            Button(action: onSend) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(active ? .white : LpspGeminiTokens.gemTextTertiary)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(active ? LpspGeminiTokens.gemBlue : .clear))
            }
            .disabled(!active)
            .sensoryFeedback(.impact(flexibility: .soft), trigger: active)
        }
    }
}

fileprivate struct LpspGeminiGemSuggestionChip: View {
    let label: String
    var featured: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if featured { LpspGeminiGemSparkle(size: 12) }
                Text(label).font(LpspGeminiFonts.gemChip).foregroundStyle(LpspGeminiTokens.gemTextPrimary)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Capsule().fill(LpspGeminiTokens.gemSurface))
            .overlay(
                Capsule().strokeBorder(
                    featured ? AnyShapeStyle(LpspGeminiGradients.gemini)
                             : AnyShapeStyle(LpspGeminiTokens.gemDivider),
                    lineWidth: 1)
            )
        }
        .buttonStyle(LpspGeminiGemPressableStyle())
    }
}

fileprivate struct LpspGeminiGemPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isPressed)
    }
}




// MARK: - Données & état (showroom Lost Phone)

fileprivate enum LpspGeminiShowroomRole {
    case user, assistant
}

fileprivate enum LpspGeminiAssistantState {
    case complete
    case thinking
    case streaming
}

fileprivate struct LpspGeminiShowroomMessage: Identifiable {
    let id: String
    let role: LpspGeminiShowroomRole
    let text: String
    var assistantState: LpspGeminiAssistantState = .complete
}

fileprivate struct LpspGeminiShowroomConversation: Identifiable {
    let id: String
    var title: String
    let section: String
    var messages: [LpspGeminiShowroomMessage]
}

fileprivate struct LpspGeminiSuggestionChip: Identifiable {
    let id: String
    let label: String
    let featured: Bool
    let prompt: String
}

@MainActor
fileprivate final class LpspGeminiStore: ObservableObject {
    @Published var conversations: [LpspGeminiShowroomConversation]
    @Published var activeConversationID: String
    @Published var composeText = ""
    @Published var isGenerating = false
    @Published var showDrawer = false
    @Published var drawerSearch = ""
    @Published var showModelPicker = false

    let userName = "Mathieu"
    let suggestions: [LpspGeminiSuggestionChip] = LpspGeminiShowroomData.suggestions

    init() {
        self.conversations = LpspGeminiShowroomData.conversations
        self.activeConversationID = LpspGeminiShowroomData.defaultConversationID
    }

    var activeConversation: LpspGeminiShowroomConversation {
        conversations.first { $0.id == activeConversationID } ?? conversations[0]
    }

    var isEmptyChat: Bool {
        activeConversation.messages.isEmpty
    }

    var drawerSections: [(title: String, chats: [LpspGeminiShowroomConversation])] {
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
            LpspGeminiShowroomConversation(id: id, title: "New chat", section: "TODAY", messages: []),
            at: 0
        )
        activeConversationID = id
        composeText = ""
        showDrawer = false
    }

    func applySuggestion(_ chip: LpspGeminiSuggestionChip) {
        composeText = chip.prompt
        sendMessage()
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

        appendMessage(.init(id: "thinking-\(UUID().uuidString)", role: .assistant, text: "", assistantState: .thinking))

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 900_000_000)
            removeThinkingMessage()
            let reply = LpspGeminiShowroomData.reply(for: trimmed)
            var streaming = reply
            streaming.assistantState = .streaming
            appendMessage(streaming)
            try? await Task.sleep(nanoseconds: 1_200_000_000)
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
        removeThinkingMessage()
        mutateActive { conv in
            if let idx = conv.messages.lastIndex(where: { $0.assistantState == .streaming }) {
                var msg = conv.messages[idx]
                msg.assistantState = .complete
                conv.messages[idx] = msg
            }
        }
    }

    private func appendMessage(_ message: LpspGeminiShowroomMessage) {
        mutateActive { $0.messages.append(message) }
    }

    private func removeThinkingMessage() {
        mutateActive { conv in
            conv.messages.removeAll { $0.assistantState == .thinking }
        }
    }

    private func updateTitleIfNeeded(from prompt: String) {
        mutateActive { conv in
            if conv.title == "New chat" || conv.title.hasPrefix("Explain what") {
                conv.title = String(prompt.prefix(40))
            }
        }
    }

    private func mutateActive(_ update: (inout LpspGeminiShowroomConversation) -> Void) {
        guard let index = conversations.firstIndex(where: { $0.id == activeConversationID }) else { return }
        var conversation = conversations[index]
        update(&conversation)
        conversations[index] = conversation
    }
}

private enum LpspGeminiShowroomData {
    static let defaultConversationID = "transformer-demo"

    static let suggestions: [LpspGeminiSuggestionChip] = [
        .init(id: "s1", label: "Explain transformers", featured: true, prompt: "Explain what a transformer is, simply."),
        .init(id: "s2", label: "Créneaux maintenance 18/06", featured: false, prompt: "Résume les fenêtres d'accès maintenance Salle 710 le 18 juin."),
        .init(id: "s3", label: "Brief vitrine S7", featured: true, prompt: "Quels indices croiser entre Gennevilliers et la vitrine ?"),
    ]

    static let conversations: [LpspGeminiShowroomConversation] = [
        .init(
            id: "transformer-demo",
            title: "Explain what a transformer is, simply.",
            section: "TODAY",
            messages: [
                .init(id: "u1", role: .user, text: "Explain what a transformer is, simply."),
                .init(
                    id: "a1",
                    role: .assistant,
                    text: "A **transformer** is a neural network architecture that reads an entire sequence at once and learns which parts matter most using a mechanism called **attention**. Instead of processing words one by one, it weighs every word against every other word in parallel — which is why it scales so well to long context.",
                    assistantState: .complete
                ),
                .init(id: "a2", role: .assistant, text: "", assistantState: .thinking),
            ]
        ),
        .init(
            id: "louvre-windows",
            title: "Fenêtres maintenance Louvre",
            section: "TODAY",
            messages: [
                .init(id: "lu1", role: .user, text: "Résume les fenêtres d'accès maintenance Salle 710 le 18 juin."),
                .init(
                    id: "la1",
                    role: .assistant,
                    text: "**Mercredi 18/06** — intervention clim **19h15–19h27** (effectif réduit).\n\nAngle mort caméra confirmé entre pilier et porte latérale (~3 s). La vitrine reste faisable en **4 min** si l'équipe tient le hall.",
                    assistantState: .complete
                ),
            ]
        ),
        .init(
            id: "brief-s7",
            title: "Brief vitrine S7",
            section: "PREVIOUS 7 DAYS",
            messages: [
                .init(id: "b1", role: .user, text: "Quels indices croiser entre Gennevilliers et la vitrine ?"),
                .init(
                    id: "ba1",
                    role: .assistant,
                    text: "Local **Gennevilliers** = stockage discret + accès camionnette.\n\nVitrine = fenêtre **18/06** + badge périmé mais couloirs connus.\n\nRecoupe avec photos **sans EXIF** dans Fichiers et fil **#planning-s7** sur Teams.",
                    assistantState: .complete
                ),
            ]
        ),
        .init(
            id: "gennevilliers",
            title: "Accès Gennevilliers discret",
            section: "PREVIOUS 30 DAYS",
            messages: [
                .init(id: "g1", role: .user, text: "Comment valider un point de transfert discret ?"),
                .init(
                    id: "ga1",
                    role: .assistant,
                    text: "Zone indus rue des Caboeufs : propre, discret, accès camionnette facile. Sam l'a validé le 2 juin — transfert avant **23h** max.",
                    assistantState: .complete
                ),
            ]
        ),
    ]

    static func reply(for prompt: String) -> LpspGeminiShowroomMessage {
        let lower = prompt.lowercased()
        if lower.contains("transformer") || lower.contains("attention") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "Think of **attention** as a spotlight: for each word, the model asks “which other words should I look at right now?” That parallel lookup is what makes transformers fast at long documents.",
                assistantState: .complete
            )
        }
        if lower.contains("louvre") || lower.contains("maintenance") || lower.contains("18") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "Le créneau du **18/06 après 19h10** reste le plus propre : ronde réduite, angle mort caméra, accès camionnette côté Gennevilliers déjà validé.",
                assistantState: .complete
            )
        }
        if lower.contains("vitrine") || lower.contains("gennevilliers") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "Recoupe **Gennevilliers** (stockage) avec la fenêtre **18/06** et les messages Nadia sur Teams. Évite les photos dans les salles chaudes.",
                assistantState: .complete
            )
        }
        return .init(
            id: UUID().uuidString,
            role: .assistant,
            text: "Je peux approfondir si tu précises le lieu, la date ou les personnes impliquées.",
            assistantState: .complete
        )
    }
}

// MARK: - Écrans showroom

private struct LpspGeminiShowroomRoot: View {
    @ObservedObject var store: LpspGeminiStore

    var body: some View {
        ZStack(alignment: .leading) {
            LpspGeminiChatScreen(store: store)

            if store.showDrawer {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture { store.showDrawer = false }

                LpspGeminiDrawer(store: store)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.22), value: store.showDrawer)
        .sheet(isPresented: $store.showModelPicker) {
            LpspGeminiModelPickerSheet(store: store)
        }
    }
}

private struct LpspGeminiChatScreen: View {
    @ObservedObject var store: LpspGeminiStore

    var body: some View {
        VStack(spacing: 0) {
            LpspGeminiTopBar(store: store)

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 20) {
                        if store.isEmptyChat {
                            LpspGeminiGreetingBlock(store: store)
                        }

                        ForEach(store.activeConversation.messages) { message in
                            LpspGeminiMessageView(message: message, isGenerating: store.isGenerating)
                                .id(message.id)
                        }
                    }
                    .padding(.vertical, 16)
                }
                .onChange(of: store.activeConversation.messages.count) { _, _ in
                    scrollToBottom(proxy: proxy)
                }
            }

            LpspGeminiGemPromptBar(
                text: $store.composeText,
                isStreaming: store.isGenerating,
                onSend: { store.sendMessage() },
                onStop: { store.stopGenerating() }
            )
            .padding(.bottom, 8)
        }
        .background(LpspGeminiTokens.gemCanvas.ignoresSafeArea())
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let last = store.activeConversation.messages.last {
            withAnimation(.easeOut(duration: 0.2)) {
                proxy.scrollTo(last.id, anchor: .bottom)
            }
        }
    }
}

private struct LpspGeminiTopBar: View {
    @ObservedObject var store: LpspGeminiStore

    var body: some View {
        HStack(spacing: 12) {
            Button { store.showDrawer = true } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspGeminiTokens.gemTextPrimary)
                    .frame(width: 44, height: 44)
            }

            Button { store.showModelPicker = true } label: {
                HStack(spacing: 4) {
                    Text("Gemini")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(LpspGeminiTokens.gemTextPrimary)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(LpspGeminiTokens.gemTextSecondary)
                }
            }

            Spacer()

            Circle()
                .fill(LpspGeminiTokens.gemSurface)
                .frame(width: 32, height: 32)
                .overlay(
                    Text("MG")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(LpspGeminiTokens.gemTextSecondary)
                )
        }
        .padding(.horizontal, 8)
        .frame(height: 44)
        .background(LpspGeminiTokens.gemCanvas)
    }
}

private struct LpspGeminiGreetingBlock: View {
    @ObservedObject var store: LpspGeminiStore

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hello, \(store.userName)")
                .font(LpspGeminiFonts.gemGreeting)
                .foregroundStyle(LpspGeminiTokens.gemTextPrimary)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(store.suggestions) { chip in
                        LpspGeminiGemSuggestionChip(label: chip.label, featured: chip.featured) {
                            store.applySuggestion(chip)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct LpspGeminiMessageView: View {
    let message: LpspGeminiShowroomMessage
    let isGenerating: Bool

    var body: some View {
        switch message.role {
        case .user:
            LpspGeminiGemUserTurn(text: message.text)
        case .assistant:
            switch message.assistantState {
            case .thinking:
                HStack(alignment: .top, spacing: 10) {
                    LpspGeminiGemSparkle(size: 20)
                    LpspGeminiGemThinking()
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            case .streaming:
                HStack(alignment: .top, spacing: 10) {
                    LpspGeminiGemSparkle(size: 20)
                    LpspGeminiGemStreamingText(text: message.text)
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            case .complete:
                LpspGeminiGemAssistantTurn(
                    markdown: (try? AttributedString(markdown: message.text)) ?? AttributedString(message.text),
                    isStreaming: false
                )
            }
        }
    }
}

private struct LpspGeminiDrawer: View {
    @ObservedObject var store: LpspGeminiStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button { store.newChat() } label: {
                    Text("New chat")
                        .font(LpspGeminiFonts.gemButton.weight(.semibold))
                        .foregroundStyle(LpspGeminiTokens.gemTextPrimary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(LpspGeminiTokens.gemSurface))
                }
                Spacer()
                Button { store.showDrawer = false } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(LpspGeminiTokens.gemTextSecondary)
                }
            }
            .padding(16)

            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(LpspGeminiTokens.gemTextSecondary)
                TextField("Search chats", text: $store.drawerSearch)
                    .font(LpspGeminiFonts.gemMeta)
            }
            .padding(12)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(LpspGeminiTokens.gemDivider, lineWidth: 1))
            .padding(.horizontal, 16)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(store.drawerSections, id: \.title) { section in
                        Text(section.title)
                            .font(LpspGeminiFonts.gemLabelUpper.weight(.semibold))
                            .foregroundStyle(LpspGeminiTokens.gemTextSecondary)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .padding(.bottom, 6)

                        ForEach(section.chats) { chat in
                            Button {
                                store.selectConversation(chat.id)
                            } label: {
                                HStack(spacing: 10) {
                                    Image(systemName: "bubble.left")
                                        .font(.system(size: 18))
                                        .foregroundStyle(LpspGeminiTokens.gemTextSecondary)
                                    Text(chat.title)
                                        .font(LpspGeminiFonts.gemButton)
                                        .foregroundStyle(LpspGeminiTokens.gemTextPrimary)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 48)
                                .background(
                                    chat.id == store.activeConversationID
                                        ? LpspGeminiTokens.gemSurface
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
        .background(LpspGeminiTokens.gemCanvas)
    }
}

private struct LpspGeminiModelPickerSheet: View {
    @ObservedObject var store: LpspGeminiStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Label("Gemini 2.0 Flash", systemImage: "checkmark.circle.fill")
                Label("Gemini 1.5 Pro", systemImage: "circle")
                Label("Gemini 1.5 Flash", systemImage: "circle")
            }
            .navigationTitle("Model")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("OK") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}


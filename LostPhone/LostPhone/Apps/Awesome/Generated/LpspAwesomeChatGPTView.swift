import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/chatgpt
// Meliwat/awesome-ios-design-md/misc/chatgpt/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeChatGPTView: View {
    var body: some View {
        LpspChatGPTShowroomRoot(store: LpspChatGPTStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspChatGPTTokens {
    // MARK: - Canvas
    static let gptCanvas          = Color.white                                    // #FFFFFF
    static let gptDarkCanvas      = Color(red: 0.129, green: 0.129, blue: 0.129)  // #212121

    // MARK: - Sidebar
    static let gptSidebarLight    = Color(red: 0.976, green: 0.976, blue: 0.976) // #F9F9F9
    static let gptSidebarDark     = Color(red: 0.094, green: 0.094, blue: 0.094) // #181818
    static let gptSidebarActive   = Color(red: 0.925, green: 0.925, blue: 0.925) // #ECECEC
    static let gptSidebarActiveDark = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F
    static let gptDivider         = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
    static let gptDividerDark     = Color(red: 0.259, green: 0.259, blue: 0.259) // #424242

    // MARK: - Text
    static let gptTextPrimary     = Color(red: 0.051, green: 0.051, blue: 0.051) // #0D0D0D
    static let gptTextSecondary   = Color(red: 0.404, green: 0.404, blue: 0.404) // #676767
    static let gptTextTertiary    = Color(red: 0.557, green: 0.557, blue: 0.557) // #8E8E8E
    static let gptDarkTextPrimary = Color(red: 0.925, green: 0.925, blue: 0.925) // #ECECEC
    static let gptDarkTextSecondary = Color(red: 0.706, green: 0.706, blue: 0.706) // #B4B4B4

    // MARK: - User Bubble
    static let gptUserBubbleLight = Color(red: 0.969, green: 0.969, blue: 0.973) // #F7F7F8
    static let gptUserBubbleDark  = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F

    // MARK: - Code
    static let gptCodeBlockLight  = Color(red: 0.969, green: 0.969, blue: 0.973) // #F7F7F8
    static let gptCodeBlockDark   = Color(red: 0.118, green: 0.118, blue: 0.118) // #1E1E1E
    static let gptCodeInlineLight = Color(red: 0.941, green: 0.941, blue: 0.941) // #F0F0F0
    static let gptCodeInlineDark  = Color(red: 0.259, green: 0.259, blue: 0.259) // #424242

    // MARK: - Send Button
    static let gptSendLight       = Color(red: 0.051, green: 0.051, blue: 0.051) // #0D0D0D
    static let gptSendDark        = Color.white                                    // #FFFFFF
    static let gptSendDisabled    = Color(red: 0.800, green: 0.800, blue: 0.800) // #CCCCCC

    // MARK: - Semantic
    static let gptLinkBlue        = Color(red: 0.165, green: 0.498, blue: 1.000) // #2A7FFF
    static let gptLegacyGreen     = Color(red: 0.063, green: 0.639, blue: 0.498) // #10A37F (legacy, mostly retired)
    static let gptErrorRed        = Color(red: 0.898, green: 0.243, blue: 0.243) // #E53E3E

    // MARK: - Voice Mode Sphere
    static let gptVoiceBlue1      = Color(red: 0.231, green: 0.510, blue: 0.965) // #3B82F6
    static let gptVoiceBlue2      = Color(red: 0.376, green: 0.647, blue: 0.980) // #60A5FA
    static let gptVoiceBlue3      = Color(red: 0.576, green: 0.773, blue: 0.988) // #93C5FD
}

private enum LpspChatGPTFonts {
    static let gptBody         = Font.system(size: 16, weight: .regular)
    static let gptBodyCompact  = Font.system(size: 15, weight: .regular)
    static let gptH1           = Font.system(size: 24, weight: .semibold)
    static let gptH2           = Font.system(size: 20, weight: .semibold)
    static let gptH3           = Font.system(size: 17, weight: .semibold)
    static let gptModelChip    = Font.system(size: 14, weight: .medium)
    static let gptSidebarTitle = Font.system(size: 15, weight: .regular)
    static let gptSidebarSection = Font.system(size: 12, weight: .regular)
    static let gptButton       = Font.system(size: 14, weight: .regular)
    static let gptMeta         = Font.system(size: 13, weight: .regular)
    static let gptPlaceholder  = Font.system(size: 16, weight: .regular)

    // Code
    static let gptCodeInline   = Font.system(size: 14, weight: .regular)
    static let gptCodeBlock    = Font.system(size: 13, weight: .regular)

    // Inter fallback
    static func gptInter(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.custom("Inter-\(weight == .medium ? "Medium" : weight == .semibold ? "SemiBold" : "Regular")", size: size).weight(weight)
    }

    // System fallback (SF Pro)
    static func gptSystem(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

fileprivate struct LpspChatGPTSendButton: View {
    let isEnabled: Bool
    let isGenerating: Bool
    let action: () -> Void

    @Environment(\.colorScheme) var scheme

    var circleColor: Color {
        if !isEnabled { return LpspChatGPTTokens.gptSendDisabled }
        return scheme == .dark ? LpspChatGPTTokens.gptSendDark : LpspChatGPTTokens.gptSendLight
    }
    var iconColor: Color {
        scheme == .dark ? LpspChatGPTTokens.gptSendLight : LpspChatGPTTokens.gptSendDark
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: isGenerating ? "stop.fill" : "arrow.up")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(iconColor)
                .frame(width: 32, height: 32)
                .background(Circle().fill(circleColor))
        }
        .disabled(!isEnabled && !isGenerating)
        .buttonStyle(LpspChatGPTSendPressStyle())
        .sensoryFeedback(.impact(flexibility: .solid), trigger: isGenerating)
    }
}

fileprivate struct LpspChatGPTSendPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspChatGPTUserMessageBubble: View {
    let text: String
    let attachmentUrl: String?

    @Environment(\.colorScheme) var scheme

    var body: some View {
        HStack {
            Spacer(minLength: 60)  // push to right, max-width ~80%
            VStack(alignment: .trailing, spacing: 8) {
                if let attachmentUrl {
                    LpspChatGPTAttachmentTile(url: attachmentUrl)
                }
                Text(text)
                    .font(LpspChatGPTFonts.gptBody)
                    .foregroundStyle(scheme == .dark ? LpspChatGPTTokens.gptDarkTextPrimary : LpspChatGPTTokens.gptTextPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 18, bottomLeadingRadius: 18, bottomTrailingRadius: 4, topTrailingRadius: 18
                        )
                        .fill(scheme == .dark ? LpspChatGPTTokens.gptUserBubbleDark : LpspChatGPTTokens.gptUserBubbleLight)
                    )
            }
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspChatGPTAttachmentTile: View {
    let url: String

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4)
                .fill(LpspChatGPTTokens.gptCodeInlineLight)
                .frame(width: 40, height: 40)
                .overlay(Image(systemName: "doc.fill").foregroundStyle(LpspChatGPTTokens.gptTextSecondary))
            Text(URL(string: url)?.lastPathComponent ?? "file")
                .font(LpspChatGPTFonts.gptMeta)
                .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                .lineLimit(1)
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 8).fill(LpspChatGPTTokens.gptCodeBlockLight))
    }
}

fileprivate struct LpspChatGPTAssistantMessage: View {
    var intro: String? = nil
    let content: String
    var showActions: Bool = true
    var showAvatar: Bool = false
    let onRegenerate: () -> Void
    let onCopy: () -> Void
    let onThumbUp: () -> Void
    let onThumbDown: () -> Void

    @Environment(\.colorScheme) private var scheme
    @State private var thumbState: LpspChatGPTThumbState = .neutral
    enum LpspChatGPTThumbState { case neutral, up, down }

    private var primaryText: Color {
        scheme == .dark ? LpspChatGPTTokens.gptDarkTextPrimary : LpspChatGPTTokens.gptTextPrimary
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 8) {
                if showAvatar {
                    Image(systemName: "sparkles")
                        .font(.system(size: 18))
                        .foregroundStyle(primaryText)
                        .frame(width: 24, height: 24)
                }

                VStack(alignment: .leading, spacing: 8) {
                    if let intro {
                        Text(intro)
                            .font(LpspChatGPTFonts.gptBody)
                            .foregroundStyle(primaryText)
                    }
                    Text(LocalizedStringKey(content))
                        .font(LpspChatGPTFonts.gptBody)
                        .foregroundStyle(primaryText)
                        .lineSpacing(6)
                }
            }

            if showActions {
                HStack(spacing: 8) {
                    LpspChatGPTFeedbackIconButton(icon: "arrow.triangle.2.circlepath", action: onRegenerate)
                    LpspChatGPTFeedbackIconButton(icon: "doc.on.doc", action: onCopy)
                    LpspChatGPTFeedbackIconButton(
                        icon: thumbState == .up ? "hand.thumbsup.fill" : "hand.thumbsup",
                        action: { thumbState = .up; onThumbUp() }
                    )
                    LpspChatGPTFeedbackIconButton(
                        icon: thumbState == .down ? "hand.thumbsdown.fill" : "hand.thumbsdown",
                        action: { thumbState = .down; onThumbDown() }
                    )
                }
                .padding(.leading, showAvatar ? 32 : 0)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

fileprivate struct LpspChatGPTFeedbackIconButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                .frame(width: 32, height: 32)
                .background(Circle().fill(Color.clear))
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(flexibility: .soft), trigger: UUID())
    }
}

fileprivate struct LpspChatGPTCodeBlockView: View {
    let language: String
    let code: String
    @State private var showCopied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(language)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                Spacer()
                Button {
                    UIPasteboard.general.string = code
                    withAnimation { showCopied = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation { showCopied = false }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: showCopied ? "checkmark" : "doc.on.doc")
                            .font(.system(size: 12))
                        Text(showCopied ? "Copied!" : "Copy")
                            .font(LpspChatGPTFonts.gptButton)
                    }
                    .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(LpspChatGPTTokens.gptCodeBlockLight)
            .overlay(Rectangle().fill(LpspChatGPTTokens.gptDivider).frame(height: 1), alignment: .bottom)

            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(LpspChatGPTFonts.gptCodeBlock)
                    .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                    .padding(12)
            }
        }
        .background(LpspChatGPTTokens.gptCodeBlockLight)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(LpspChatGPTTokens.gptDivider, lineWidth: 1))
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspChatGPTModelSelectorChip: View {
    let modelName: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .font(.system(size: 14))
                    .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                Text(modelName)
                    .font(LpspChatGPTFonts.gptModelChip)
                    .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                Image(systemName: "chevron.down")
                    .font(.system(size: 10))
                    .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Capsule().fill(Color.clear))
            .overlay(Capsule().stroke(LpspChatGPTTokens.gptDivider, lineWidth: 1))
        }
    }
}

fileprivate struct LpspChatGPTComposer: View {
    @Binding var text: String
    var isGenerating: Bool = false
    var spectrLayout: Bool = false
    let onSend: () -> Void
    let onVoice: () -> Void
    let onAttach: () -> Void
    let onWebSearch: () -> Void

    @Environment(\.colorScheme) private var scheme

    var isEmpty: Bool { text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .bottom, spacing: 8) {
                Button(action: onAttach) {
                    Image(systemName: spectrLayout ? "photo.on.rectangle.angled" : "plus")
                        .font(.system(size: spectrLayout ? 18 : 20))
                        .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                        .frame(width: 40, height: 40)
                }

                TextField("Message ChatGPT…", text: $text, axis: .vertical)
                    .font(LpspChatGPTFonts.gptBody)
                    .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                    .lineLimit(1...6)
                    .padding(.vertical, 10)
                    .disabled(isGenerating)

                HStack(spacing: 4) {
                    if isEmpty, !spectrLayout {
                        Button(action: onWebSearch) {
                            Image(systemName: "globe")
                                .font(.system(size: 18))
                                .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                                .frame(width: 40, height: 40)
                        }
                    }
                    if isEmpty || spectrLayout {
                        Button(action: onVoice) {
                            Image(systemName: "mic.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                                .frame(width: 32, height: 32)
                        }
                    }
                    if !isEmpty || spectrLayout {
                        LpspChatGPTSendButton(
                            isEnabled: !isEmpty || isGenerating,
                            isGenerating: isGenerating,
                            action: onSend
                        )
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(scheme == .dark ? LpspChatGPTTokens.gptCodeBlockDark : LpspChatGPTTokens.gptCodeBlockLight)
                    .overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(LpspChatGPTTokens.gptDivider, lineWidth: 1))
            )

            Text("ChatGPT can make mistakes. Check important info.")
                .font(.system(size: 11))
                .foregroundStyle(LpspChatGPTTokens.gptTextTertiary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
    }
}

fileprivate struct LpspChatGPTVoiceModeView: View {
    @Binding var isShown: Bool
    @State private var pulseScale: CGFloat = 1.0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Circle()
                .fill(
                    RadialGradient(
                        colors: [LpspChatGPTTokens.gptVoiceBlue1, LpspChatGPTTokens.gptVoiceBlue2, LpspChatGPTTokens.gptVoiceBlue3],
                        center: .center,
                        startRadius: 50,
                        endRadius: 180
                    )
                )
                .frame(width: 280, height: 280)
                .scaleEffect(pulseScale)
                .shadow(color: LpspChatGPTTokens.gptVoiceBlue1.opacity(0.4), radius: 40)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        pulseScale = 1.05
                    }
                }

            VStack {
                Spacer()
                Text("ChatGPT is listening…")
                    .font(LpspChatGPTFonts.gptMeta)
                    .foregroundStyle(.white.opacity(0.7))

                HStack {
                    Button("Mute") { }
                        .font(LpspChatGPTFonts.gptButton)
                        .foregroundStyle(.white)

                    Spacer()

                    Button { isShown = false } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(Circle().fill(.white.opacity(0.2)))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .transition(.opacity.combined(with: .scale(scale: 0.9)))
        .sensoryFeedback(.impact(flexibility: .solid), trigger: isShown)
    }
}

fileprivate struct LpspChatGPTGPTSidebar: View {
    let sections: [LpspChatGPTConversationSection]
    var activeID: String = ""
    var onSelect: (String) -> Void = { _ in }

    struct LpspChatGPTConversationSection: Identifiable {
        let id = UUID()
        let title: String
        let chats: [LpspChatGPTConversationItem]
    }

    struct LpspChatGPTConversationItem: Identifiable {
        let id: String
        let title: String
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(sections) { section in
                        Text(section.title)
                            .font(LpspChatGPTFonts.gptSidebarSection)
                            .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                            .padding(.horizontal, 12)
                            .padding(.top, 16)
                            .padding(.bottom, 4)

                        ForEach(section.chats) { chat in
                            Button {
                                onSelect(chat.id)
                            } label: {
                                LpspChatGPTChatSidebarRow(
                                    title: chat.title,
                                    isActive: chat.id == activeID
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(LpspChatGPTTokens.gptSidebarLight)
    }
}

fileprivate struct LpspChatGPTChatSidebarRow: View {
    let title: String
    let isActive: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(LpspChatGPTFonts.gptSidebarTitle)
                .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                .lineLimit(1)
            Spacer()
        }
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(isActive ? LpspChatGPTTokens.gptSidebarActive : Color.clear)
    }
}

fileprivate struct LpspChatGPTTypingIndicator: View {
    @State private var dot1: CGFloat = 0.3
    @State private var dot2: CGFloat = 0.3
    @State private var dot3: CGFloat = 0.3

    var body: some View {
        HStack(spacing: 6) {
            Circle().fill(LpspChatGPTTokens.gptTextSecondary).frame(width: 8, height: 8).opacity(dot1)
            Circle().fill(LpspChatGPTTokens.gptTextSecondary).frame(width: 8, height: 8).opacity(dot2)
            Circle().fill(LpspChatGPTTokens.gptTextSecondary).frame(width: 8, height: 8).opacity(dot3)
        }
        .onAppear { animate() }
    }

    private func animate() {
        withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) { dot1 = 1.0 }
        withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.2)) { dot2 = 1.0 }
        withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true).delay(0.4)) { dot3 = 1.0 }
    }
}

fileprivate struct LpspChatGPTGPTTheme: ViewModifier {
    @Environment(\.colorScheme) var scheme

    func body(content: Content) -> some View {
        content
            .background(scheme == .dark ? LpspChatGPTTokens.gptDarkCanvas : LpspChatGPTTokens.gptCanvas)
            .foregroundStyle(scheme == .dark ? LpspChatGPTTokens.gptDarkTextPrimary : LpspChatGPTTokens.gptTextPrimary)
    }
}

fileprivate extension View {
    func gptTheme() -> some View { modifier(LpspChatGPTGPTTheme()) }
}

// MARK: - Données & état (showroom Lost Phone)

fileprivate enum LpspChatGPTShowroomRole: Hashable {
    case user, assistant
}

fileprivate struct LpspChatGPTShowroomMessage: Identifiable, Hashable {
    let id: String
    let role: LpspChatGPTShowroomRole
    let text: String
    var intro: String?
    var attachmentName: String?
    var showActions: Bool = false
}

fileprivate struct LpspChatGPTShowroomConversation: Identifiable {
    let id: String
    var title: String
    let section: String
    var messages: [LpspChatGPTShowroomMessage]
}

fileprivate struct LpspChatGPTModelOption: Identifiable, Hashable {
    let id: String
    let name: String
    let subtitle: String
}

private enum LpspChatGPTMobileTab: CaseIterable {
    case chat, history

    var label: String {
        switch self {
        case .chat: "Chat"
        case .history: "Historique"
        }
    }

    var icon: String {
        switch self {
        case .chat: "bubble.left.fill"
        case .history: "clock"
        }
    }
}

@MainActor
fileprivate final class LpspChatGPTStore: ObservableObject {
    @Published var selectedTab: LpspChatGPTMobileTab = .chat
    @Published var conversations: [LpspChatGPTShowroomConversation]
    @Published var activeConversationID: String
    @Published var composeText = ""
    @Published var isGenerating = false
    @Published var showSidebar = false
    @Published var showVoiceMode = false
    @Published var showModelPicker = false
    @Published var selectedModelID = "gpt-4o"
    @Published var sidebarSearch = ""

    let models: [LpspChatGPTModelOption] = [
        .init(id: "gpt-4o", name: "GPT-4o", subtitle: "Rapide, multimodal, le meilleur pour la plupart des tâches"),
        .init(id: "gpt-4", name: "GPT-4", subtitle: "Raisonnement avancé, plus lent"),
        .init(id: "gpt-3.5", name: "GPT-3.5", subtitle: "Classique, économique"),
    ]

    init() {
        self.conversations = LpspChatGPTShowroomData.conversations
        self.activeConversationID = LpspChatGPTShowroomData.defaultConversationID
    }

    var selectedModelName: String {
        models.first { $0.id == selectedModelID }?.name ?? "GPT-4o"
    }

    var activeConversation: LpspChatGPTShowroomConversation {
        conversations.first { $0.id == activeConversationID }
            ?? conversations[0]
    }

    var sidebarSections: [(title: String, chats: [LpspChatGPTShowroomConversation])] {
        let ordered = ["Today", "Yesterday", "Previous 7 Days", "Previous 30 Days", "June 2026"]
        return ordered.compactMap { section in
            let chats = filteredConversations.filter { $0.section == section }
            return chats.isEmpty ? nil : (section, chats)
        }
    }

    private var filteredConversations: [LpspChatGPTShowroomConversation] {
        let query = sidebarSearch.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return conversations }
        return conversations.filter { $0.title.lowercased().contains(query) }
    }

    func selectConversation(_ id: String) {
        activeConversationID = id
        selectedTab = .chat
        showSidebar = false
    }

    func newChat() {
        let id = "new-\(UUID().uuidString.prefix(6))"
        let conversation = LpspChatGPTShowroomConversation(
            id: id,
            title: "New chat",
            section: "Today",
            messages: []
        )
        conversations.insert(conversation, at: 0)
        activeConversationID = id
        composeText = ""
        selectedTab = .chat
        showSidebar = false
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
            try? await Task.sleep(nanoseconds: 900_000_000)
            guard isGenerating else { return }
            let reply = LpspChatGPTShowroomData.reply(for: trimmed, conversationID: activeConversationID)
            appendMessage(reply)
            isGenerating = false
        }
    }

    func stopGenerating() {
        isGenerating = false
    }

    func regenerateLastResponse() {
        guard let lastAssistantIndex = activeConversation.messages.lastIndex(where: { $0.role == .assistant }) else { return }
        mutateActiveConversation { conversation in
            conversation.messages.remove(at: lastAssistantIndex)
        }
        isGenerating = true
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 700_000_000)
            let fallback = LpspChatGPTShowroomMessage(
                id: UUID().uuidString,
                role: .assistant,
                text: "Voici une autre formulation, plus concise.",
                showActions: true
            )
            appendMessage(fallback)
            isGenerating = false
        }
    }

    func copyMessage(_ text: String) {
        UIPasteboard.general.string = text
    }

    private func appendMessage(_ message: LpspChatGPTShowroomMessage) {
        mutateActiveConversation { conversation in
            conversation.messages.append(message)
        }
    }

    private func updateTitleIfNeeded(from prompt: String) {
        mutateActiveConversation { conversation in
            if conversation.title == "New chat" || conversation.title.hasPrefix("Write a haiku") {
                conversation.title = String(prompt.prefix(42))
            }
        }
    }

    private func mutateActiveConversation(_ update: (inout LpspChatGPTShowroomConversation) -> Void) {
        guard let index = conversations.firstIndex(where: { $0.id == activeConversationID }) else { return }
        var conversation = conversations[index]
        update(&conversation)
        conversations[index] = conversation
    }
}

private enum LpspChatGPTShowroomData {
    static let defaultConversationID = "spectr-haiku"

    static let conversations: [LpspChatGPTShowroomConversation] = [
        .init(
            id: "spectr-haiku",
            title: "Write a haiku about sunrises",
            section: "Today",
            messages: [
                .init(id: "s1", role: .user, text: "Write a haiku about sunrises"),
                .init(
                    id: "s2",
                    role: .assistant,
                    text: "Quiet golden line\nBirds rehearse the morning song\nDew remembers night",
                    intro: "A haiku about sunrises:",
                    showActions: true
                ),
                .init(id: "s3", role: .user, text: "Try one with more imagery"),
                .init(
                    id: "s4",
                    role: .assistant,
                    text: "Amber spills slow-honey\nAcross the chimney rooftops\nSteam curls like a cat",
                    showActions: false
                ),
            ]
        ),
        .init(
            id: "louvre-windows",
            title: "Fenêtres maintenance Louvre",
            section: "Today",
            messages: [
                .init(id: "l1", role: .user, text: "Résume les fenêtres d'accès maintenance Salle 710 cette semaine."),
                .init(
                    id: "l2",
                    role: .assistant,
                    text: "**Mercredi 18/06** — intervention clim 19h15–19h27 (effectif réduit).\n**Jeudi 19/06** — contrôle portes Denon 06h40–07h05.\n\nAngle mort caméra confirmé entre pilier et porte latérale (~3 s).",
                    intro: "Fenêtres repérées dans le brief v3 :",
                    showActions: true
                ),
                .init(id: "l3", role: .user, text: "Et si l'équipe est à 3 personnes ?"),
                .init(
                    id: "l4",
                    role: .assistant,
                    text: "La vitrine reste faisable en **4 min** si le rôle « diversion » tient le hall. Évite la ronde PM du jeudi — préfère le créneau du 18 après 19h10.",
                    showActions: true
                ),
            ]
        ),
        .init(
            id: "denon-alias",
            title: "Alias couloir Denon",
            section: "Yesterday",
            messages: [
                .init(id: "d1", role: .user, text: "Liste 3 alias crédibles pour un freelance événementiel à Paris."),
                .init(
                    id: "d2",
                    role: .assistant,
                    text: "1. **Maison Lumière** — agence pop-up Marais\n2. **Atelier Sōma** — identité visuelle (déjà dans tes mails)\n3. **EventsCult** — serveur Discord actif sur le projet Dame",
                    showActions: true
                ),
            ]
        ),
        .init(
            id: "brief-dame",
            title: "Brief Dame de Fer v3",
            section: "Previous 7 Days",
            messages: [
                .init(id: "b1", role: .user, text: "Quels indices croiser entre Gennevilliers et la vitrine ?"),
                .init(
                    id: "b2",
                    role: .assistant,
                    text: "Local **Gennevilliers** = stockage discret + accès camionnette.\nVitrine = fenêtre **18/06** + badge périmé mais couloirs connus.\n\nRecoupe avec les photos **sans EXIF** dans Fichiers et le fil **#planning-s7** sur Discord.",
                    showActions: true
                ),
            ]
        ),
        .init(
            id: "codes-juin",
            title: "Codes maintenance juin",
            section: "Previous 30 Days",
            messages: [
                .init(id: "c1", role: .user, text: "Traduis « maintenance window » en contexte musée."),
                .init(
                    id: "c2",
                    role: .assistant,
                    text: "Créneau technique où les équipes HVAC/sécurité circulent sans alerte visiteur. Souvent **19h–21h**, effectif réduit, portes de service ouvertes.",
                    showActions: true
                ),
            ]
        ),
        .init(
            id: "swiftui-tips",
            title: "SwiftUI tips",
            section: "June 2026",
            messages: [
                .init(id: "t1", role: .user, text: "Explique-moi SwiftUI en une phrase."),
                .init(
                    id: "t2",
                    role: .assistant,
                    text: "SwiftUI est le framework déclaratif d'Apple pour décrire une interface en état, pas en impératif.",
                    showActions: true
                ),
            ]
        ),
    ]

    static func reply(for prompt: String, conversationID: String) -> LpspChatGPTShowroomMessage {
        let lower = prompt.lowercased()
        if lower.contains("louvre") || lower.contains("vitrine") || lower.contains("denon") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "Les créneaux du **18/06** restent les plus propres : ronde réduite, angle mort caméra, accès camionnette côté Gennevilliers déjà validé.",
                showActions: true
            )
        }
        if lower.contains("haiku") || lower.contains("sunrise") || lower.contains("lever") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "Pink rim on glass\nMuseum keys still cold in hand\nCity wakes in grey",
                intro: "Another sunrise haiku:",
                showActions: true
            )
        }
        if lower.contains("code") || lower.contains("swift") {
            return .init(
                id: UUID().uuidString,
                role: .assistant,
                text: "```swift\n@State private var isShown = false\n\nButton(\"Toggle\") { isShown.toggle() }\n```",
                intro: "Exemple minimal :",
                showActions: true
            )
        }
        return .init(
            id: UUID().uuidString,
            role: .assistant,
            text: "Je peux approfondir si tu précises le contexte (lieu, date, personnes impliquées).",
            showActions: true
        )
    }
}

// MARK: - Écrans showroom

private struct LpspChatGPTShowroomRoot: View {
    @ObservedObject var store: LpspChatGPTStore

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .chat:
                        LpspChatGPTChatScreen(store: store)
                    case .history:
                        LpspChatGPTHistoryScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspChatGPTMobileTabBar(store: store)
            }

            if store.showVoiceMode {
                LpspChatGPTVoiceModeView(isShown: $store.showVoiceMode)
                    .zIndex(2)
            }
        }
        .background(LpspChatGPTTokens.gptCanvas.ignoresSafeArea())
        .sheet(isPresented: $store.showSidebar) {
            LpspChatGPTSidebarSheet(store: store)
        }
        .sheet(isPresented: $store.showModelPicker) {
            LpspChatGPTModelPickerSheet(store: store)
        }
    }
}

private struct LpspChatGPTMobileTabBar: View {
    @ObservedObject var store: LpspChatGPTStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspChatGPTMobileTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.label)
                            .font(.system(size: 10))
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspChatGPTTokens.gptTextPrimary : LpspChatGPTTokens.gptTextSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspChatGPTTokens.gptCanvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspChatGPTTokens.gptDivider).frame(height: 0.5)
        }
    }
}

private struct LpspChatGPTChatScreen: View {
    @ObservedObject var store: LpspChatGPTStore

    var body: some View {
        VStack(spacing: 0) {
            LpspChatGPTTopNav(store: store)

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(store.activeConversation.messages) { message in
                            LpspChatGPTMessageRow(message: message, store: store)
                                .id(message.id)
                        }
                        if store.isGenerating {
                            HStack {
                                LpspChatGPTTypingIndicator()
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .id("typing")
                        }
                    }
                    .padding(.vertical, 8)
                }
                .onChange(of: store.activeConversation.messages.count) { _, _ in
                    scrollToBottom(proxy: proxy)
                }
                .onChange(of: store.isGenerating) { _, _ in
                    scrollToBottom(proxy: proxy)
                }
            }

            LpspChatGPTComposer(
                text: $store.composeText,
                isGenerating: store.isGenerating,
                spectrLayout: store.activeConversationID == LpspChatGPTShowroomData.defaultConversationID,
                onSend: { store.sendMessage() },
                onVoice: { store.showVoiceMode = true },
                onAttach: {},
                onWebSearch: {}
            )
        }
        .background(LpspChatGPTTokens.gptCanvas.ignoresSafeArea())
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        withAnimation(.easeOut(duration: 0.2)) {
            if store.isGenerating {
                proxy.scrollTo("typing", anchor: .bottom)
            } else if let last = store.activeConversation.messages.last {
                proxy.scrollTo(last.id, anchor: .bottom)
            }
        }
    }
}

private struct LpspChatGPTTopNav: View {
    @ObservedObject var store: LpspChatGPTStore

    var body: some View {
        HStack(spacing: 12) {
            Button { store.showSidebar = true } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                    .frame(width: 44, height: 44)
            }

            Button { store.showModelPicker = true } label: {
                HStack(spacing: 4) {
                    Text(store.selectedModelName)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
            }

            Spacer()

            Button { store.newChat() } label: {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                    .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal, 8)
        .frame(height: 44)
        .background(LpspChatGPTTokens.gptCanvas)
    }
}

private struct LpspChatGPTMessageRow: View {
    let message: LpspChatGPTShowroomMessage
    @ObservedObject var store: LpspChatGPTStore

    var body: some View {
        switch message.role {
        case .user:
            LpspChatGPTUserMessageBubble(
                text: message.text,
                attachmentUrl: message.attachmentName
            )
        case .assistant:
            LpspChatGPTAssistantMessage(
                intro: message.intro,
                content: message.text,
                showActions: message.showActions,
                showAvatar: false,
                onRegenerate: { store.regenerateLastResponse() },
                onCopy: { store.copyMessage(message.text) },
                onThumbUp: {},
                onThumbDown: {}
            )
        }
    }
}

private struct LpspChatGPTHistoryScreen: View {
    @ObservedObject var store: LpspChatGPTStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.sidebarSections, id: \.title) { section in
                    Section(section.title) {
                        ForEach(section.chats) { chat in
                            Button {
                                store.selectConversation(chat.id)
                            } label: {
                                HStack {
                                    Text(chat.title)
                                        .font(LpspChatGPTFonts.gptSidebarTitle)
                                        .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                                        .lineLimit(1)
                                    Spacer()
                                    if chat.id == store.activeConversationID {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Historique")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { store.newChat() } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
    }
}

private struct LpspChatGPTSidebarSheet: View {
    @ObservedObject var store: LpspChatGPTStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                LpspChatGPTGPTSidebar(sections: store.sidebarSections.map { section in
                    .init(
                        title: section.title,
                        chats: section.chats.map { .init(title: $0.title, id: $0.id) }
                    )
                }, activeID: store.activeConversationID) { id in
                    store.selectConversation(id)
                    dismiss()
                }
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Fermer") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { store.newChat(); dismiss() } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

private struct LpspChatGPTModelPickerSheet: View {
    @ObservedObject var store: LpspChatGPTStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(store.models) { model in
                Button {
                    store.selectedModelID = model.id
                    dismiss()
                } label: {
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(model.name)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                            Text(model.subtitle)
                                .font(LpspChatGPTFonts.gptMeta)
                                .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                        }
                        Spacer()
                        if store.selectedModelID == model.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                        }
                    }
                }
            }
            .navigationTitle("Modèle")
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


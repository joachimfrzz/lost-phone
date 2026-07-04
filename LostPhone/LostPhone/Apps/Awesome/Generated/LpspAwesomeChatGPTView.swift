import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/misc/chatgpt/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/chatgpt
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeChatGPTView: View {
    var body: some View {
        LpspChatGPTShowroomRoot()
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
    static let gptH1           = Font.system(size: 24, weight: .regular)
    static let gptH2           = Font.system(size: 20, weight: .regular)
    static let gptH3           = Font.system(size: 17, weight: .regular)
    static let gptModelChip    = Font.system(size: 14, weight: .regular)
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
    let content: String  // markdown-rendered
    let onRegenerate: () -> Void
    let onCopy: () -> Void
    let onThumbUp: () -> Void
    let onThumbDown: () -> Void

    @State private var thumbState: LpspChatGPTThumbState = .neutral
    enum LpspChatGPTThumbState { case neutral, up, down }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Optional sparkle avatar
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 18))
                    .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                    .frame(width: 24, height: 24)

                // Replace this Text with a MarkdownRenderer in production
                Text(LocalizedStringKey(content))
                    .font(LpspChatGPTFonts.gptBody)
                    .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                    .lineSpacing(8)
            }

            // Feedback row
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
            .padding(.leading, 32)
        }
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
    let onSend: () -> Void
    let onVoice: () -> Void
    let onAttach: () -> Void
    let onWebSearch: () -> Void

    var isEmpty: Bool { text.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Button(action: onAttach) {
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                    .frame(width: 40, height: 40)
            }

            TextField("Message ChatGPT…", text: $text, axis: .vertical)
                .font(LpspChatGPTFonts.gptBody)
                .foregroundStyle(LpspChatGPTTokens.gptTextPrimary)
                .lineLimit(1...6)
                .padding(.vertical, 10)

            if isEmpty {
                HStack(spacing: 4) {
                    Button(action: onWebSearch) {
                        Image(systemName: "globe")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                            .frame(width: 40, height: 40)
                    }
                    Button(action: onVoice) {
                        Image(systemName: "mic.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                            .frame(width: 32, height: 32)
                            .background(Circle().strokeBorder(LpspChatGPTTokens.gptDivider, lineWidth: 1))
                    }
                }
            } else {
                LpspChatGPTSendButton(isEnabled: true, isGenerating: false, action: onSend)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(LpspChatGPTTokens.gptCanvas)
                .overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(LpspChatGPTTokens.gptDivider, lineWidth: 1))
        )
        .padding(.horizontal, 16)
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

    struct LpspChatGPTConversationSection: Identifiable {
        let id = UUID()
        let title: String  // "Today", "Yesterday", etc.
        let chats: [LpspChatGPTConversationItem]
    }
    struct LpspChatGPTConversationItem: Identifiable {
        let id = UUID()
        let title: String
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // New chat button
            Button { } label: {
                HStack(spacing: 10) {
                    Image(systemName: "square.and.pencil").font(.system(size: 18))
                    Text("New chat").font(LpspChatGPTFonts.gptButton)
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(RoundedRectangle(cornerRadius: 8).fill(LpspChatGPTTokens.gptSidebarActive))
            }
            .padding(12)

            // Search
            HStack {
                Image(systemName: "magnifyingglass").foregroundStyle(LpspChatGPTTokens.gptTextSecondary)
                TextField("Search chats", text: .constant(""))
                    .font(LpspChatGPTFonts.gptMeta)
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 8).fill(LpspChatGPTTokens.gptSidebarActive))
            .padding(.horizontal, 12)

            // Conversation list
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
                            LpspChatGPTChatSidebarRow(title: chat.title, isActive: false)
                        }
                    }
                }
            }
        }
        .frame(width: 260)
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

// MARK: - Écrans showroom

private struct LpspChatGPTShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspChatGPTAiTabScreen(title: "Chat", tabIndex: 0)
                .tabItem { Label("Chat", systemImage: "bubble.left.fill") }
                .tag(0)
            LpspChatGPTAiTabScreen(title: "Historique", tabIndex: 1)
                .tabItem { Label("Historique", systemImage: "clock") }
                .tag(1)
        }
        .tint(LpspChatGPTTokens.gptErrorRed)
        
    }
}


private struct LpspChatGPTGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspChatGPTTokens.gptErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspChatGPTTokens.gptErrorRed))
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


private struct LpspChatGPTDemoBubble: View {
    let text: String
    var outgoing: Bool
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 40) }
            Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspChatGPTTokens.gptErrorRed.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 40) }
        }
    }
}

private struct LpspChatGPTDemoComposeBar: View {
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Message…", text: $text).padding(10).background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill").foregroundStyle(LpspChatGPTTokens.gptErrorRed)
        }
        .padding(8)
    }
}

private struct LpspChatGPTAiChatTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 12) {

                    LpspChatGPTUserMessageBubble(text: "Explique-moi SwiftUI")
                    LpspChatGPTAssistantMessage(text: "SwiftUI est le framework déclaratif d'Apple pour construire des interfaces iOS.")

                }
                .padding()
            }
            .background(LpspChatGPTTokens.gptCanvas.ignoresSafeArea())
            
            LpspChatGPTComposer(
                text: .constant(""),
                onSend: {},
                onVoice: {},
                onAttach: {},
                onWebSearch: {}
            )

        }
    }
}


private struct LpspChatGPTAiHistoryTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Showroom Lost Phone", "SwiftUI tips"], id: \.self) { Label($0, systemImage: "bubble.left") }
            .navigationTitle("Historique")
        }
    }
}


private struct LpspChatGPTAiTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        if tabIndex == 0 || title.lowercased().contains("chat") { LpspChatGPTAiChatTabScreen() }
        else { LpspChatGPTAiHistoryTabScreen() }
    }
}



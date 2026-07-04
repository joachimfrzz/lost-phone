import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/misc/claude/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/claude
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeClaudeView: View {
    var body: some View {
        LpspClaudeShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspClaudeFonts {
    static let claudeDisplay      = Font.system(size: 32, weight: .regular)
    static let claudeConvTitle    = Font.system(size: 18, weight: .regular)
    static let claudeH1           = Font.system(size: 24, weight: .regular)
    static let claudeH2           = Font.system(size: 20, weight: .regular)
    static let claudeH3           = Font.system(size: 17, weight: .regular)
    static let claudeBody         = Font.system(size: 16, weight: .regular)
    static let claudeBodyBold     = Font.system(size: 16, weight: .regular)
    static let claudeBodyItalic   = Font.system(size: 16, weight: .regular)
    static let claudeBlockquote   = Font.system(size: 16, weight: .regular)
    static let claudeUser         = Font.system(size: 16, weight: .regular)
    static let claudeAction       = Font.system(size: 15, weight: .regular)
    static let claudeChip         = Font.system(size: 13, weight: .regular)
    static let claudeMeta         = Font.system(size: 12, weight: .regular)
    static let claudeCaption      = Font.system(size: 11, weight: .regular)
    static let claudeSenderLabel  = Font.system(size: 13, weight: .regular)
    static let claudeGroupHeader  = Font.system(size: 11, weight: .regular)
    static let claudeCodeInline   = Font.system(size: 14, weight: .regular)
    static let claudeCodeBlock    = Font.system(size: 14, weight: .regular)
    static let claudeCodeBlockSm  = Font.system(size: 13, weight: .regular)
    static let claudeCodeLang     = Font.system(size: 11, weight: .regular)
    static func claude(_ size: CGFloat, weight: Font.Weight = .regular, serif: Bool = false) -> Font {
        .system(size: size, weight: weight, design: serif ? .serif : .default)
    }
}

private enum LpspClaudeTokens {
    // MARK: - Canvas (the Claude paper)
    static let claudeCream     = Color(red: 0.973, green: 0.957, blue: 0.929) // #F8F4ED canvas
    static let claudePaper     = Color(red: 0.984, green: 0.976, blue: 0.957) // #FBF9F4 elevated surfaces
    static let claudeSurface1  = Color(red: 0.941, green: 0.918, blue: 0.878) // #F0EAE0 user pill, callouts
    static let claudeSurface2  = Color(red: 0.910, green: 0.878, blue: 0.824) // #E8E0D2 pressed/chips
    static let claudeSand      = Color(red: 0.867, green: 0.824, blue: 0.741) // #DDD2BD divider

    // MARK: - Text (warm-tinted ink)
    static let claudeInk       = Color(red: 0.176, green: 0.145, blue: 0.125) // #2D2520 primary
    static let claudeGraphite  = Color(red: 0.353, green: 0.310, blue: 0.267) // #5A4F44 secondary
    static let claudeStone     = Color(red: 0.541, green: 0.494, blue: 0.447) // #8A7E72 tertiary
    static let claudeBone      = Color(red: 0.710, green: 0.671, blue: 0.620) // #B5AB9E disabled

    // MARK: - Claude Orange (the signature accent)
    static let claudeOrange       = Color(red: 0.851, green: 0.467, blue: 0.341) // #D97757
    static let claudeOrangePressed = Color(red: 0.745, green: 0.384, blue: 0.259) // #BE6242
    static let claudeOrangeSoft   = Color(red: 0.949, green: 0.867, blue: 0.816) // #F2DDD0 active chip

    // MARK: - Code & Syntax (warm palette)
    static let claudeCodeBg       = Color(red: 0.122, green: 0.106, blue: 0.086) // #1F1B16
    static let claudeCodeFg       = Color(red: 0.910, green: 0.878, blue: 0.824) // #E8E0D2
    static let claudeSyntaxKey    = Color(red: 0.851, green: 0.467, blue: 0.341) // #D97757 keywords
    static let claudeSyntaxString = Color(red: 0.498, green: 0.690, blue: 0.412) // #7FB069 strings
    static let claudeSyntaxNum    = Color(red: 0.910, green: 0.725, blue: 0.435) // #E8B96F numbers
    static let claudeSyntaxFunc   = Color(red: 0.616, green: 0.643, blue: 0.949) // #9DA4F2 functions
    static let claudeSyntaxCmt    = Color(red: 0.541, green: 0.494, blue: 0.447) // #8A7E72 comments

    // MARK: - Semantic
    static let claudeSuccess   = Color(red: 0.420, green: 0.616, blue: 0.369) // #6B9D5E sage
    static let claudeWarning   = Color(red: 0.831, green: 0.600, blue: 0.322) // #D49952
    static let claudeError     = Color(red: 0.757, green: 0.400, blue: 0.329) // #C16654 terracotta
    static let claudeInfo      = Color(red: 0.353, green: 0.384, blue: 0.451) // #5A6273

    // MARK: - Dark mode (warm dark — preserves paper feel)
    static let claudeDarkCanvas   = Color(red: 0.122, green: 0.106, blue: 0.086) // #1F1B16
    static let claudeDarkSurface  = Color(red: 0.165, green: 0.145, blue: 0.125) // #2A2520
    static let claudeDarkSurface2 = Color(red: 0.227, green: 0.200, blue: 0.173) // #3A332C
    static let claudeDarkDivider  = Color(red: 0.227, green: 0.200, blue: 0.173) // #3A332C
    static let claudeDarkText     = Color(red: 0.910, green: 0.878, blue: 0.824) // #E8E0D2
    static let claudeDarkTextSec  = Color(red: 0.710, green: 0.671, blue: 0.620) // #B5AB9E
    static let claudeOrangeSoftDk = Color(red: 0.290, green: 0.208, blue: 0.165) // #4A352A
}



// Fallback when Tiempos isn't bundled — Source Serif Pro / SF Pro is the closest pairing


fileprivate struct LpspClaudeClaudeMark: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * 0.18

        // 6 narrow petals radiating from center, 60° apart
        for i in 0..<6 {
            let angle = CGFloat.pi / 3 * CGFloat(i) - CGFloat.pi / 2
            let tip = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
            let leftAngle = angle + CGFloat.pi / 2
            let leftBase = CGPoint(
                x: center.x + innerRadius * cos(leftAngle),
                y: center.y + innerRadius * sin(leftAngle)
            )
            let rightBase = CGPoint(
                x: center.x - innerRadius * cos(leftAngle),
                y: center.y - innerRadius * sin(leftAngle)
            )
            path.move(to: leftBase)
            path.addQuadCurve(to: tip, control: CGPoint(
                x: (leftBase.x + tip.x) / 2 + 1, y: (leftBase.y + tip.y) / 2 + 1))
            path.addQuadCurve(to: rightBase, control: CGPoint(
                x: (tip.x + rightBase.x) / 2 - 1, y: (tip.y + rightBase.y) / 2 - 1))
            path.closeSubpath()
        }
        return path
    }
}

fileprivate struct LpspClaudeClaudeAvatar: View {
    var size: CGFloat = 18
    var color: Color = LpspClaudeTokens.claudeOrange

    var body: some View {
        LpspClaudeClaudeMark()
            .fill(color)
            .frame(width: size, height: size)
    }
}

fileprivate struct LpspClaudeAssistantMessage: View {
    let modelName: String          // "Claude Opus 4.5"
    let content: AttributedString  // Pre-rendered markdown
    let isStreaming: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header strip
            HStack(spacing: 8) {
                LpspClaudeClaudeAvatar(size: 18)
                HStack(spacing: 6) {
                    Text("Claude")
                        .font(LpspClaudeFonts.claudeSenderLabel)
                        .foregroundStyle(LpspClaudeTokens.claudeGraphite)
                    Text("·")
                        .foregroundStyle(LpspClaudeTokens.claudeStone)
                    Text(modelName)
                        .font(LpspClaudeFonts.claudeChip)
                        .foregroundStyle(LpspClaudeTokens.claudeStone)
                }
            }
            .padding(.leading, 4)

            // Body — markdown-rendered Tiempos prose
            Text(content)
                .font(LpspClaudeFonts.claudeBody)
                .foregroundStyle(LpspClaudeTokens.claudeInk)
                .lineSpacing(8) // Approximates 1.55 line-height

            if isStreaming {
                LpspClaudeStreamingCursor()
            }
        }
        .padding(.horizontal, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate struct LpspClaudeStreamingCursor: View {
    @State private var visible = true

    var body: some View {
        Rectangle()
            .fill(LpspClaudeTokens.claudeOrange)
            .frame(width: 8, height: 18)
            .cornerRadius(1)
            .opacity(visible ? 1 : 0)
            .onAppear {
                withAnimation(.linear(duration: 0.3).repeatForever()) {
                    visible = false
                }
            }
            .accessibilityLabel("Claude is responding")
    }
}

fileprivate struct LpspClaudeUserMessage: View {
    let text: String

    var body: some View {
        HStack {
            Spacer(minLength: 40)
            Text(text)
                .font(LpspClaudeFonts.claudeUser)
                .foregroundStyle(LpspClaudeTokens.claudeInk)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(LpspClaudeTokens.claudeSurface1)
                )
                .frame(maxWidth: UIScreen.main.bounds.width * 0.8, alignment: .trailing)
        }
        .padding(.horizontal, 4)
    }
}

fileprivate struct LpspClaudeChatInput: View {
    @Binding var text: String
    @FocusState private var focused: Bool
    var onSend: () -> Void
    var onAttach: () -> Void

    var canSend: Bool { !text.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 8) {
                // Paperclip / attach
                Button(action: onAttach) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 24))
                        .foregroundStyle(LpspClaudeTokens.claudeGraphite)
                }
                .padding(.bottom, 14)

                // Auto-growing text field
                TextField("Reply to Claude…", text: $text, axis: .vertical)
                    .focused($focused)
                    .font(LpspClaudeFonts.claudeUser)
                    .foregroundStyle(LpspClaudeTokens.claudeInk)
                    .padding(.vertical, 14)
                    .lineLimit(1...8)

                // Send circle
                Button(action: {
                    if canSend {
                        onSend()
                        text = ""
                    }
                }) {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(canSend ? LpspClaudeTokens.claudePaper : LpspClaudeTokens.claudeStone)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle().fill(canSend ? LpspClaudeTokens.claudeOrange : LpspClaudeTokens.claudeSurface2)
                        )
                }
                .disabled(!canSend)
                .padding(.bottom, 6)
                .sensoryFeedback(.impact(weight: .medium), trigger: canSend)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(LpspClaudeTokens.claudePaper)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .strokeBorder(
                                focused ? LpspClaudeTokens.claudeOrange : LpspClaudeTokens.claudeSand,
                                lineWidth: focused ? 1.5 : 1
                            )
                    )
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
    }
}

fileprivate struct LpspClaudeModelPickerChip: View {
    let modelName: String
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                LpspClaudeClaudeAvatar(size: 14)
                Text(modelName)
                    .font(LpspClaudeFonts.claudeChip)
                    .foregroundStyle(LpspClaudeTokens.claudeInk)
                Image(systemName: "chevron.down")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(LpspClaudeTokens.claudeStone)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(LpspClaudeTokens.claudeSurface1)
            )
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspClaudeModelPickerSheet: View {
    @Binding var selectedModel: String
    let models: [LpspClaudeModelOption]
    var onClose: () -> Void

    struct LpspClaudeModelOption: Identifiable {
        var id: String { name }
        let name: String
        let subtitle: String
        let available: Bool
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Select Model").font(LpspClaudeFonts.claudeAction).foregroundStyle(LpspClaudeTokens.claudeInk)
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(LpspClaudeTokens.claudeStone)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)

            ForEach(models) { model in
                Button {
                    if model.available {
                        selectedModel = model.name
                        onClose()
                    }
                } label: {
                    HStack(spacing: 16) {
                        LpspClaudeClaudeAvatar(size: 24, color: model.available ? LpspClaudeTokens.claudeOrange : LpspClaudeTokens.claudeBone)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(model.name).font(.system(size: 16, weight: .medium)).foregroundStyle(LpspClaudeTokens.claudeInk)
                            Text(model.subtitle).font(LpspClaudeFonts.claudeChip).foregroundStyle(LpspClaudeTokens.claudeGraphite)
                        }
                        Spacer()
                        if model.name == selectedModel {
                            Circle().fill(LpspClaudeTokens.claudeOrange).frame(width: 12, height: 12)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                }
                .buttonStyle(.plain)
                Rectangle().fill(LpspClaudeTokens.claudeSurface1).frame(height: 1).padding(.leading, 60)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(LpspClaudeTokens.claudePaper)
        )
        .sensoryFeedback(.selection, trigger: selectedModel)
    }
}

fileprivate struct LpspClaudeCodeBlock: View {
    let language: String
    let code: String                  // Pre-syntax-highlighted via AttributedString
    @State private var copied = false

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text(language).font(LpspClaudeFonts.claudeCodeLang).foregroundStyle(LpspClaudeTokens.claudeStone)
                Spacer()
                Button {
                    UIPasteboard.general.string = code
                    withAnimation(.easeInOut(duration: 0.15)) { copied = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation { copied = false }
                    }
                } label: {
                    Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(LpspClaudeTokens.claudeCodeFg)
                        .frame(width: 32, height: 32)
                        .background(Color.white.opacity(0.05).clipShape(Circle()))
                }
                .sensoryFeedback(.impact(weight: .light), trigger: copied)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Rectangle().fill(LpspClaudeTokens.claudeDarkSurface2.opacity(0.4)))

            // Body
            ScrollView(.horizontal, showsIndicators: false) {
                Text(code)
                    .font(LpspClaudeFonts.claudeCodeBlock)
                    .foregroundStyle(LpspClaudeTokens.claudeCodeFg)
                    .padding(16)
            }
        }
        .background(LpspClaudeTokens.claudeCodeBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12).strokeBorder(LpspClaudeTokens.claudeSand, lineWidth: 1)
        )
    }
}

fileprivate struct LpspClaudeThinkingIndicator: View {
    let elapsedSeconds: Int?
    @State private var pulse = false

    var body: some View {
        HStack(spacing: 8) {
            LpspClaudeClaudeAvatar(size: 14)
                .scaleEffect(pulse ? 1.15 : 1.0)
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulse)
            Text(elapsedSeconds.map { "Thought for \($0)s" } ?? "Thinking…")
                .font(LpspClaudeFonts.claudeChip)
                .foregroundStyle(LpspClaudeTokens.claudeGraphite)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(Capsule().fill(LpspClaudeTokens.claudeOrangeSoft))
        .onAppear { pulse = true }
    }
}

fileprivate struct LpspClaudeArtifactCard: View {
    let title: String
    let kind: LpspClaudeArtifactKind             // .document / .code / .chart
    let preview: String
    var onOpen: () -> Void

    enum LpspClaudeArtifactKind { case document, code, chart }

    var icon: String {
        switch kind {
        case .document: return "doc.text"
        case .code:     return "chevron.left.forwardslash.chevron.right"
        case .chart:    return "chart.bar"
        }
    }

    var body: some View {
        Button(action: onOpen) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: icon).font(.system(size: 14)).foregroundStyle(LpspClaudeTokens.claudeGraphite)
                    Text(title).font(.system(size: 17, weight: .medium)).foregroundStyle(LpspClaudeTokens.claudeInk)
                    Spacer()
                    Image(systemName: "arrow.up.right").font(.system(size: 12)).foregroundStyle(LpspClaudeTokens.claudeStone)
                }

                Text(preview)
                    .font(LpspClaudeFonts.claudeCodeBlockSm)
                    .foregroundStyle(LpspClaudeTokens.claudeGraphite)
                    .lineLimit(6)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 8).padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8).fill(LpspClaudeTokens.claudeSurface1)
                    )
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(LpspClaudeTokens.claudePaper)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12).strokeBorder(LpspClaudeTokens.claudeSand, lineWidth: 1)
                    )
            )
            .shadow(color: Color.black.opacity(0.06), radius: 8, y: 2)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspClaudeConversationView: View {
    @State private var input = ""
    @State private var modelName = "Claude Opus 4.5"
    @State private var showingModelPicker = false

    var body: some View {
        VStack(spacing: 0) {
            // Top header
            HStack {
                Button { /* open sidebar */ } label: {
                    Image(systemName: "line.3.horizontal").font(.system(size: 18)).foregroundStyle(LpspClaudeTokens.claudeInk)
                }
                Spacer()
                Text("Untitled chat").font(LpspClaudeFonts.claudeConvTitle).foregroundStyle(LpspClaudeTokens.claudeInk)
                Spacer()
                Button { /* ... */ } label: {
                    Image(systemName: "ellipsis").font(.system(size: 18)).foregroundStyle(LpspClaudeTokens.claudeInk)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            .background(LpspClaudeTokens.claudeCream)

            // Model chip
            HStack {
                LpspClaudeModelPickerChip(modelName: modelName) { showingModelPicker = true }
                Spacer()
            }
            .padding(.horizontal, 20).padding(.bottom, 8)

            ScrollView {
                VStack(spacing: 32) {
                    LpspClaudeUserMessage(text: "Explain Bayesian inference like I'm a curious 15-year-old.")
                    LpspClaudeAssistantMessage(
                        modelName: modelName,
                        content: AttributedString("Imagine you're trying to figure out…"),
                        isStreaming: true
                    )
                }
                .padding(.horizontal, 16).padding(.vertical, 16)
            }
            .background(LpspClaudeTokens.claudeCream)

            LpspClaudeChatInput(text: $input, onSend: {}, onAttach: {})
        }
        .background(LpspClaudeTokens.claudeCream.ignoresSafeArea())
        .sheet(isPresented: $showingModelPicker) {
            LpspClaudeModelPickerSheet(
                selectedModel: $modelName,
                models: [
                    .init(name: "Claude Opus 4.5",   subtitle: "Most intelligent",     available: true),
                    .init(name: "Claude Sonnet 4.5", subtitle: "Fast and capable",     available: true),
                    .init(name: "Claude Haiku 4.5",  subtitle: "Quickest responses",   available: true),
                ],
                onClose: { showingModelPicker = false }
            )
            .presentationDetents([.medium])
        }
    }
}

// MARK: - Écrans showroom

private struct LpspClaudeShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspClaudeAiTabScreen(title: "Chat", tabIndex: 0)
                .tabItem { Label("Chat", systemImage: "bubble.left.fill") }
                .tag(0)
            LpspClaudeAiTabScreen(title: "Historique", tabIndex: 1)
                .tabItem { Label("Historique", systemImage: "clock") }
                .tag(1)
        }
        .tint(LpspClaudeTokens.claudeCream)
        
    }
}


private struct LpspClaudeGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspClaudeTokens.claudeCream.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspClaudeTokens.claudeCream))
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


private struct LpspClaudeDemoBubble: View {
    let text: String
    var outgoing: Bool
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 40) }
            Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspClaudeTokens.claudeCream.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 40) }
        }
    }
}

private struct LpspClaudeDemoComposeBar: View {
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Message…", text: $text).padding(10).background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill").foregroundStyle(LpspClaudeTokens.claudeCream)
        }
        .padding(8)
    }
}

private struct LpspClaudeAiChatTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 12) {

                    LpspClaudeDemoBubble(text: "Bonjour !", outgoing: true)
                    LpspClaudeDemoBubble(text: "Comment puis-je vous aider ?", outgoing: false)

                }
                .padding()
            }
            .background(LpspClaudeTokens.claudeDarkCanvas.ignoresSafeArea())
            LpspClaudeDemoComposeBar()
        }
    }
}


private struct LpspClaudeAiHistoryTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Showroom Lost Phone", "SwiftUI tips"], id: \.self) { Label($0, systemImage: "bubble.left") }
            .navigationTitle("Historique")
        }
    }
}


private struct LpspClaudeAiTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        if tabIndex == 0 || title.lowercased().contains("chat") { LpspClaudeAiChatTabScreen() }
        else { LpspClaudeAiHistoryTabScreen() }
    }
}



import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/gemini
// Meliwat/awesome-ios-design-md/misc/gemini/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeGeminiView: View {
    var body: some View {
        LpspGeminiShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspGeminiFonts {
    static let gemGreeting    = Font.system(size: 28, weight: .regular)
    static let gemTitle       = Font.system(size: 22, weight: .regular)
    static let gemSection     = Font.system(size: 18, weight: .regular)
    static let gemAnswerH2    = Font.system(size: 20, weight: .regular)
    static let gemAnswerH3    = Font.system(size: 17, weight: .regular)
    static let gemAnswerBody  = Font.system(size: 16, weight: .regular)
    static let gemUserTurn    = Font.system(size: 16, weight: .regular)
    static let gemPromptInput = Font.system(size: 16, weight: .regular)
    static let gemChip        = Font.system(size: 14, weight: .regular)
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




// MARK: - Écrans showroom

private struct LpspGeminiShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspGeminiSpectrHomeTabScreen()
                .tabItem { Label("Chat", systemImage: "bubble.left.fill") }
                .tag(0)
            LpspGeminiAiTabScreen(title: "Historique", tabIndex: 1)
                .tabItem { Label("Historique", systemImage: "clock") }
                .tag(1)
        }
        .tint(LpspGeminiTokens.gemCoral)
        
    }
}


private struct LpspGeminiGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspGeminiTokens.gemCoral.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspGeminiTokens.gemCoral))
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


private struct LpspGeminiDemoBubble: View {
    let text: String
    var outgoing: Bool
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 40) }
            Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspGeminiTokens.gemCoral.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 40) }
        }
    }
}

private struct LpspGeminiDemoComposeBar: View {
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Message…", text: $text).padding(10).background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill").foregroundStyle(LpspGeminiTokens.gemCoral)
        }
        .padding(8)
    }
}

private struct LpspGeminiAiChatTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 12) {

                    LpspGeminiDemoBubble(text: "Bonjour !", outgoing: true)
                    LpspGeminiDemoBubble(text: "Comment puis-je vous aider ?", outgoing: false)

                }
                .padding()
            }
            .background(LpspGeminiTokens.gemCanvas.ignoresSafeArea())
            LpspGeminiDemoComposeBar()
        }
    }
}


private struct LpspGeminiAiHistoryTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Showroom Lost Phone", "SwiftUI tips"], id: \.self) { Label($0, systemImage: "bubble.left") }
            .navigationTitle("Historique")
        }
    }
}


private struct LpspGeminiAiTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        if tabIndex == 0 || title.lowercased().contains("chat") { LpspGeminiAiChatTabScreen() }
        else { LpspGeminiAiHistoryTabScreen() }
    }
}


private struct LpspGeminiSpectrBubble: View {
    let text: String
    let outgoing: Bool
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 32) }
            Text(text).font(.system(size: 16)).padding(12)
                .background(outgoing ? LpspGeminiTokens.gemCoral.opacity(0.15) : Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            if !outgoing { Spacer(minLength: 32) }
        }
        .padding(.horizontal, 16)
    }
}

private struct LpspGeminiSpectrHomeTabScreen: View {
    var body: some View {

        VStack(spacing: 0) {
            HStack {
                Image(systemName: "line.3.horizontal").font(.title3)
                Spacer()
                Text("Gemini").font(.system(size: 15, weight: .semibold))
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(Color(.systemGray6)).clipShape(Capsule())
                Spacer()
                Image(systemName: "square.and.pencil").font(.title3)
            }
            .padding(.horizontal, 16).padding(.vertical, 10)
            ScrollView {
                VStack(spacing: 16) {

                        LpspGeminiSpectrBubble(text: "Write me a short poem about Paris", outgoing: true)
                        LpspGeminiSpectrBubble(text: "Beneath the zinc and morning light, the Seine holds silver in its arms…", outgoing: false)

                }
                .padding(.vertical, 12)
            }
            LpspGeminiDemoComposeBar()
        }
        .background(LpspGeminiTokens.gemCanvas.ignoresSafeArea())

    }
}



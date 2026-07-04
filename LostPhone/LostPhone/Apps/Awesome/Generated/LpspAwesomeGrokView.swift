import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/misc/grok/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/grok
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeGrokView: View {
    var body: some View {
        LpspGrokShowroomRoot()
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
            Image("grok-glyph") // 24pt mark, once per response
                .resizable().frame(width: 24, height: 24)
                .foregroundStyle(LpspGrokTokens.grokTextPrimary)

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
                    Image("x-glyph").resizable().frame(width: 16, height: 16)
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
        .overlay(Capsule().strokeBorder(LpspGrokTokens.grokDivider, lineWidth: 1))
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



// MARK: - Écrans showroom

private struct LpspGrokShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspGrokGenericTabScreen(title: "Chat", tabIndex: 0)
                .tabItem { Label("Chat", systemImage: "bubble.left.fill") }
                .tag(0)
            LpspGrokGenericTabScreen(title: "Historique", tabIndex: 1)
                .tabItem { Label("Historique", systemImage: "clock") }
                .tag(1)
        }
        .tint(LpspGrokTokens.grokAccentWhite)
        
    }
}


private struct LpspGrokGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspGrokTokens.grokAccentWhite.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspGrokTokens.grokAccentWhite))
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


private struct LpspGrokMessagingTabScreen: View {
    let title: String
    var body: some View { LpspGrokGenericTabScreen(title: title, tabIndex: 0) }
}



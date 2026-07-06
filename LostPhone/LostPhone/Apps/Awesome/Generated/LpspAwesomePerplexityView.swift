import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/perplexity
// Meliwat/awesome-ios-design-md/misc/perplexity/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePerplexityView: View {
    var body: some View {
        LpspPerplexityShowroomRoot(store: LpspPerplexityStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspPerplexityFonts {
    static let pplxDisplay     = Font.system(size: 30, weight: .regular)
    static let pplxQuestion    = Font.system(size: 22, weight: .regular)
    static let pplxSection     = Font.system(size: 18, weight: .regular)
    static let pplxSubsection  = Font.system(size: 16, weight: .regular)
    static let pplxBody        = Font.system(size: 16, weight: .regular)
    static let pplxBodyBold    = Font.system(size: 16, weight: .regular)
    static let pplxList        = Font.system(size: 16, weight: .regular)
    static let pplxBodySmall   = Font.system(size: 14, weight: .regular)
    static let pplxMeta        = Font.system(size: 12, weight: .regular)
    static let pplxCaption     = Font.system(size: 11, weight: .regular)
    static let pplxSourceTitle  = Font.system(size: 13, weight: .regular)
    static let pplxSourceDomain = Font.system(size: 11, weight: .regular)
    static let pplxCitation     = Font.system(size: 11, weight: .regular)
    static let pplxButton       = Font.system(size: 15, weight: .regular)
    static let pplxProBadge     = Font.system(size: 11, weight: .regular)
    static let pplxChip         = Font.system(size: 13, weight: .regular)
    static let pplxTab          = Font.system(size: 10, weight: .regular)
    static let pplxSenderLabel  = Font.system(size: 13, weight: .regular)
    static let pplxGroupHeader  = Font.system(size: 11, weight: .regular)
    static let pplxCodeBlock    = Font.system(size: 14, weight: .regular)
    static let pplxCodeInline   = Font.system(size: 14, weight: .regular)
    static let pplxCodeLang     = Font.system(size: 11, weight: .regular)
    static let pplxSearch       = Font.system(size: 16, weight: .regular)
    static func pplx(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspPerplexityTokens {
    // MARK: - Canvas (dark-first)
    static let pplxCanvas    = Color(red: 0.039, green: 0.039, blue: 0.039) // #0A0A0A
    static let pplxSurface1  = Color(red: 0.090, green: 0.090, blue: 0.090) // #171717
    static let pplxSurface2  = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
    static let pplxSurface3  = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
    static let pplxDivider   = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A

    // MARK: - Text
    static let pplxTextPrimary   = Color(red: 0.980, green: 0.980, blue: 0.980) // #FAFAFA off-white
    static let pplxTextSecondary = Color(red: 0.631, green: 0.631, blue: 0.631) // #A1A1A1
    static let pplxTextTertiary  = Color(red: 0.431, green: 0.431, blue: 0.431) // #6E6E6E
    static let pplxTextMuted     = Color(red: 0.290, green: 0.290, blue: 0.290) // #4A4A4A

    // MARK: - Perplexity Teal (signature accent)
    static let pplxTeal       = Color(red: 0.125, green: 0.722, blue: 0.804) // #20B8CD
    static let pplxTealBright = Color(red: 0.239, green: 0.839, blue: 0.925) // #3DD6EC streaming cursor
    static let pplxTealDeep   = Color(red: 0.082, green: 0.569, blue: 0.639) // #1591A3 pressed
    static let pplxTealSoft   = Color(red: 0.059, green: 0.227, blue: 0.259) // #0F3A42 Pro Steps fill

    // MARK: - Code & syntax
    static let pplxCodeBg     = Color(red: 0.055, green: 0.055, blue: 0.055) // #0E0E0E
    static let pplxCodeFg     = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
    static let pplxSyntaxStr  = Color(red: 0.659, green: 0.878, blue: 0.388) // #A8E063 lime
    static let pplxSyntaxNum  = Color(red: 0.949, green: 0.651, blue: 0.353) // #F2A65A orange
    static let pplxSyntaxFunc = Color(red: 0.725, green: 0.533, blue: 0.949) // #B988F2 purple

    // MARK: - Semantic
    static let pplxSuccess = Color(red: 0.133, green: 0.773, blue: 0.369) // #22C55E
    static let pplxWarning = Color(red: 0.961, green: 0.620, blue: 0.043) // #F59E0B
    static let pplxError   = Color(red: 0.937, green: 0.267, blue: 0.267) // #EF4444
    static let pplxProGold = Color(red: 0.878, green: 0.702, blue: 0.255) // #E0B341

    // MARK: - Light mode (Perplexity supports light but defaults dark)
    static let pplxLightCanvas    = Color(red: 1.000, green: 1.000, blue: 1.000) // #FFFFFF
    static let pplxLightSurface1  = Color(red: 0.969, green: 0.969, blue: 0.969) // #F7F7F7
    static let pplxLightSurface2  = Color(red: 0.937, green: 0.937, blue: 0.937) // #EFEFEF
    static let pplxLightDivider   = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
    static let pplxLightTextPri   = Color(red: 0.067, green: 0.067, blue: 0.067) // #111111
    static let pplxLightTextSec   = Color(red: 0.333, green: 0.333, blue: 0.333) // #555555
    static let pplxTealLight      = Color(red: 0.082, green: 0.569, blue: 0.639) // #1591A3 (WCAG)
}



// Fallback when fonts aren't bundled — SF Pro is the closest geometric humanist substitute


fileprivate struct LpspPerplexityPerplexityMark: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let c = CGPoint(x: rect.midX, y: rect.midY)
        let r = min(rect.width, rect.height) * 0.32
        let d = r * 0.65

        // Three overlapping circles in a triangular formation
        let angles: [CGFloat] = [-CGFloat.pi / 2, CGFloat.pi / 6, 5 * CGFloat.pi / 6]
        for a in angles {
            let center = CGPoint(x: c.x + d * cos(a), y: c.y + d * sin(a))
            path.addEllipse(in: CGRect(x: center.x - r, y: center.y - r, width: r * 2, height: r * 2))
        }
        return path
    }
}

fileprivate struct LpspPerplexityPerplexityAvatar: View {
    var size: CGFloat = 20
    var color: Color = LpspPerplexityTokens.pplxTeal

    var body: some View {
        LpspPerplexityPerplexityMark()
            .fill(color)
            .frame(width: size, height: size)
    }
}

fileprivate struct LpspPerplexitySearchInput: View {
    @Binding var text: String
    @FocusState private var focused: Bool
    var onSubmit: () -> Void
    var onAttach: () -> Void

    var canSend: Bool { !text.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            TextField("Ask anything…", text: $text, axis: .vertical)
                .focused($focused)
                .font(LpspPerplexityFonts.pplxSearch)
                .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                .padding(.vertical, 14)
                .lineLimit(1...8)

            Button(action: onAttach) {
                Image(systemName: "paperclip")
                    .font(.system(size: 18))
                    .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
            }
            .padding(.bottom, 14)

            Button(action: {
                if canSend { onSubmit() }
            }) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 14, weight: .heavy))
                    .foregroundStyle(canSend ? LpspPerplexityTokens.pplxCanvas : LpspPerplexityTokens.pplxTextTertiary)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(canSend ? LpspPerplexityTokens.pplxTeal : LpspPerplexityTokens.pplxSurface3))
            }
            .disabled(!canSend)
            .padding(.bottom, 10)
            .sensoryFeedback(.impact(weight: .medium), trigger: canSend)
        }
        .padding(.horizontal, 18)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(LpspPerplexityTokens.pplxSurface1)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(focused ? LpspPerplexityTokens.pplxTeal : LpspPerplexityTokens.pplxSurface3, lineWidth: focused ? 1.5 : 1)
                )
                .shadow(color: focused ? LpspPerplexityTokens.pplxTeal.opacity(0.25) : .clear, radius: 0, x: 0, y: 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(LpspPerplexityTokens.pplxTeal.opacity(focused ? 0.25 : 0), lineWidth: 4)
                        .blur(radius: focused ? 4 : 0)
                )
        )
    }
}

fileprivate struct LpspPerplexitySourceCard: View {
    let number: Int
    let faviconURL: URL?
    let domain: String
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                AsyncImage(url: faviconURL) { phase in
                    if let img = phase.image { img.resizable() }
                    else { LpspPerplexityTokens.pplxSurface3 }
                }
                .frame(width: 16, height: 16)
                .clipShape(RoundedRectangle(cornerRadius: 3))

                Text(domain)
                    .font(LpspPerplexityFonts.pplxSourceDomain)
                    .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                    .lineLimit(1)

                Spacer()

                // Number badge
                Text("\(number)")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                    .padding(.horizontal, 5).padding(.vertical, 1)
                    .background(RoundedRectangle(cornerRadius: 3).fill(LpspPerplexityTokens.pplxSurface2))
            }

            Text(title)
                .font(LpspPerplexityFonts.pplxSourceTitle)
                .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .padding(12)
        .frame(width: 200, height: 80, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LpspPerplexityTokens.pplxSurface1)
                .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(LpspPerplexityTokens.pplxSurface3, lineWidth: 1))
        )
    }
}

fileprivate struct LpspPerplexityCitationChip: View {
    let number: Int
    @State private var focused = false
    var onTap: () -> Void

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                focused = true
            }
            onTap()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation { focused = false }
            }
        }) {
            Text("\(number)")
                .font(LpspPerplexityFonts.pplxCitation)
                .foregroundStyle(focused ? LpspPerplexityTokens.pplxTeal : LpspPerplexityTokens.pplxTextSecondary)
                .padding(.horizontal, 5)
                .frame(height: 18)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(focused ? LpspPerplexityTokens.pplxTealSoft : LpspPerplexityTokens.pplxSurface2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4).strokeBorder(
                                focused ? LpspPerplexityTokens.pplxTeal : LpspPerplexityTokens.pplxSurface3,
                                lineWidth: 1
                            )
                        )
                )
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle().inset(by: -8)) // 32pt tap target
        .sensoryFeedback(.impact(weight: .light), trigger: focused)
    }
}

fileprivate struct LpspPerplexityAnswerBlock: View {
    let content: AttributedString  // pre-rendered markdown with citation references
    let isStreaming: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                LpspPerplexityPerplexityAvatar(size: 18)
                Text("Answer")
                    .font(LpspPerplexityFonts.pplxSenderLabel)
                    .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
            }

            Text(content)
                .font(LpspPerplexityFonts.pplxBody)
                .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                .lineSpacing(6) // ~1.5x line-height

            if isStreaming { LpspPerplexityStreamingCursor() }

            // Action row
            HStack(spacing: 12) {
                LpspPerplexityActionPill(icon: "doc.on.doc", label: "Copy")
                LpspPerplexityActionPill(icon: "square.and.arrow.up", label: "Share")
                LpspPerplexityActionPill(icon: "bookmark", label: "Save")
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate struct LpspPerplexityActionPill: View {
    let icon: String
    let label: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon).font(.system(size: 13)).foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
            Text(label).font(LpspPerplexityFonts.pplxChip).foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 14)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(LpspPerplexityTokens.pplxSurface2)
                .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(LpspPerplexityTokens.pplxSurface3, lineWidth: 1))
        )
    }
}

fileprivate struct LpspPerplexityStreamingCursor: View {
    @State private var visible = true

    var body: some View {
        Rectangle()
            .fill(LpspPerplexityTokens.pplxTealBright)
            .frame(width: 6, height: 16)
            .cornerRadius(1)
            .opacity(visible ? 1 : 0)
            .onAppear {
                withAnimation(.linear(duration: 0.25).repeatForever()) { visible = false }
            }
            .accessibilityLabel("Generating answer")
    }
}

fileprivate struct LpspPerplexityProSearchToggle: View {
    @Binding var isOn: Bool

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                isOn.toggle()
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(isOn ? LpspPerplexityTokens.pplxCanvas : LpspPerplexityTokens.pplxTextSecondary)
                Text("Pro")
                    .font(LpspPerplexityFonts.pplxProBadge)
                    .foregroundStyle(isOn ? LpspPerplexityTokens.pplxCanvas : LpspPerplexityTokens.pplxTextSecondary)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 14)
            .background(
                Capsule().fill(isOn ? LpspPerplexityTokens.pplxTeal : LpspPerplexityTokens.pplxSurface2)
                    .overlay(Capsule().stroke(isOn ? Color.clear : LpspPerplexityTokens.pplxSurface3, lineWidth: 1))
            )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: isOn)
    }
}

fileprivate struct LpspPerplexitySearchingIndicator: View {
    @State private var phase = 0

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 6) {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .fill(LpspPerplexityTokens.pplxTeal)
                        .frame(width: 6, height: 6)
                        .scaleEffect(phase == i ? 1.3 : 1.0)
                        .animation(.easeInOut(duration: 0.4).delay(Double(i) * 0.15), value: phase)
                }
            }
            Text("Searching the web…")
                .font(LpspPerplexityFonts.pplxSenderLabel)
                .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                phase = (phase + 1) % 3
            }
        }
    }
}

fileprivate struct LpspPerplexityProStepsCard: View {
    let steps: [String]
    @State private var expanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.easeOut(duration: 0.3)) { expanded.toggle() }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "sparkles").font(.system(size: 14)).foregroundStyle(LpspPerplexityTokens.pplxTeal)
                    Text("Steps").font(LpspPerplexityFonts.pplxSenderLabel).foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                    Text("(\(steps.count))").font(LpspPerplexityFonts.pplxMeta).foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                    Spacer()
                    Image(systemName: expanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12))
                        .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                }
            }

            if expanded {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(steps.enumerated()), id: \.offset) { idx, step in
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(LpspPerplexityTokens.pplxTeal)
                            Text(step).font(LpspPerplexityFonts.pplxBodySmall).foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                            Spacer()
                        }
                    }
                }
                .padding(.top, 12)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 12).fill(LpspPerplexityTokens.pplxTealSoft))
    }
}

fileprivate struct LpspPerplexityRelatedQuestionsCard: View {
    let questions: [String]
    var onSelect: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Related")
                .font(LpspPerplexityFonts.pplxSenderLabel)
                .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                .padding(.bottom, 8)

            ForEach(Array(questions.enumerated()), id: \.offset) { idx, q in
                Button { onSelect(q) } label: {
                    HStack {
                        Text(q).font(LpspPerplexityFonts.pplxBodySmall).foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                            .lineLimit(1)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14))
                            .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                }
                .buttonStyle(.plain)
                .sensoryFeedback(.selection, trigger: idx)

                if idx < questions.count - 1 {
                    Rectangle().fill(LpspPerplexityTokens.pplxSurface3).frame(height: 1).padding(.horizontal, 16)
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 4)
    }
}



// MARK: - Données & état (showroom Spectr)

fileprivate struct LpspPerplexitySource: Identifiable, Hashable {
    let id: Int
    let domain: String
    let title: String
}

fileprivate enum LpspPerplexityAnswerState {
    case complete
    case searching
    case streaming
}

fileprivate struct LpspPerplexityThread: Identifiable {
    let id: String
    var title: String
    var question: String
    var sources: [LpspPerplexitySource]
    var answer: String
    var answerState: LpspPerplexityAnswerState
    var relatedQuestions: [String]
    var proSteps: [String]?
}

private enum LpspPerplexityTab: CaseIterable {
    case home, discover, library, spaces

    var label: String {
        switch self {
        case .home: "Home"
        case .discover: "Discover"
        case .library: "Library"
        case .spaces: "Spaces"
        }
    }

    var icon: String {
        switch self {
        case .home: "magnifyingglass"
        case .discover: "safari"
        case .library: "books.vertical"
        case .spaces: "square.stack.3d.down.right"
        }
    }
}

@MainActor
fileprivate final class LpspPerplexityStore: ObservableObject {
    @Published var selectedTab: LpspPerplexityTab = .home
    @Published var threads: [LpspPerplexityThread]
    @Published var activeThreadID: String
    @Published var composeText = ""
    @Published var isProMode = false
    @Published var isGenerating = false

    let discoverTopics = [
        "Latest in quantum computing",
        "Best budget espresso machines",
        "Explain transformer attention",
        "Mediterranean diet benefits",
    ]

    let spaces = [
        ("Research", "12 threads"),
        ("Travel", "4 threads"),
        ("Code", "8 threads"),
    ]

    init() {
        self.threads = LpspPerplexityShowroomData.threads
        self.activeThreadID = LpspPerplexityShowroomData.defaultThreadID
    }

    var activeThread: LpspPerplexityThread {
        threads.first { $0.id == activeThreadID } ?? threads[0]
    }

    func selectThread(_ id: String) {
        activeThreadID = id
        selectedTab = .home
    }

    func newThread() {
        let id = "new-\(UUID().uuidString.prefix(6))"
        threads.insert(
            LpspPerplexityThread(
                id: id,
                title: "New thread",
                question: "",
                sources: [],
                answer: "",
                answerState: .complete,
                relatedQuestions: [],
                proSteps: nil
            ),
            at: 0
        )
        activeThreadID = id
        composeText = ""
        selectedTab = .home
    }

    func ask(_ prompt: String) {
        let trimmed = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !isGenerating else { return }

        mutateActive { thread in
            thread.question = trimmed
            thread.title = String(trimmed.prefix(36))
            thread.sources = []
            thread.answer = ""
            thread.answerState = .searching
        }
        composeText = ""
        isGenerating = true

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 1_100_000_000)
            let bundle = LpspPerplexityShowroomData.reply(for: trimmed, pro: isProMode)
            mutateActive { thread in
                thread.sources = bundle.sources
                thread.answer = bundle.answer
                thread.answerState = .streaming
                thread.relatedQuestions = bundle.related
                thread.proSteps = bundle.steps
            }
            try? await Task.sleep(nanoseconds: 1_400_000_000)
            mutateActive { $0.answerState = .complete }
            isGenerating = false
        }
    }

    func sendMessage() {
        ask(composeText)
    }

    func selectRelated(_ question: String) {
        composeText = question
        ask(question)
    }

    private func mutateActive(_ update: (inout LpspPerplexityThread) -> Void) {
        guard let index = threads.firstIndex(where: { $0.id == activeThreadID }) else { return }
        var thread = threads[index]
        update(&thread)
        threads[index] = thread
    }
}

private enum LpspPerplexityShowroomData {
    static let defaultThreadID = "bayesian-inference"

    static let spectrSources: [LpspPerplexitySource] = [
        .init(id: 1, domain: "wikipedia.org", title: "Bayesian inference — Wikipedia"),
        .init(id: 2, domain: "arxiv.org", title: "A gentle introduction to probabilistic reasoning"),
    ]

    static let threads: [LpspPerplexityThread] = [
        .init(
            id: "bayesian-inference",
            title: "Bayesian inference",
            question: "What is Bayesian inference?",
            sources: spectrSources,
            answer: "Bayesian inference is a method of statistical inference that updates the probability of a hypothesis as more evidence becomes available. It applies **Bayes' theorem** to combine prior beliefs with new data to form a posterior distribution [1].\n\nUnlike frequentist approaches, Bayesian methods treat parameters as random variables and quantify uncertainty explicitly — which makes them especially useful in machine learning and scientific modeling [2].",
            answerState: .complete,
            relatedQuestions: [
                "What is a prior distribution?",
                "How is Bayesian inference used in ML?",
                "Bayesian vs frequentist statistics",
            ],
            proSteps: nil
        ),
        .init(
            id: "mechanical-keyboards",
            title: "Best mechanical keyboards 2024",
            question: "What are the best mechanical keyboards in 2024?",
            sources: [
                .init(id: 1, domain: "theverge.com", title: "The best keyboards of 2024"),
                .init(id: 2, domain: "rtings.com", title: "Mechanical keyboard rankings"),
            ],
            answer: "Top picks balance switch feel, build quality, and wireless reliability. Enthusiast favorites include Keychron Q-series and NuPhy Air75 V2 for portability.",
            answerState: .complete,
            relatedQuestions: ["Linear vs tactile switches?", "Best keyboard under $100?"],
            proSteps: nil
        ),
        .init(
            id: "crispr",
            title: "How does CRISPR work?",
            question: "How does CRISPR gene editing work?",
            sources: [
                .init(id: 1, domain: "nature.com", title: "CRISPR-Cas9 explained"),
            ],
            answer: "CRISPR uses a guide RNA to direct the Cas9 enzyme to a specific DNA sequence, where it creates a targeted cut. The cell's repair machinery then edits the gene.",
            answerState: .complete,
            relatedQuestions: ["CRISPR ethics debate", "CRISPR vs base editing"],
            proSteps: nil
        ),
    ]

    struct ReplyBundle {
        let sources: [LpspPerplexitySource]
        let answer: String
        let related: [String]
        let steps: [String]?
    }

    static func reply(for prompt: String, pro: Bool) -> ReplyBundle {
        let lower = prompt.lowercased()
        if lower.contains("bayesian") || lower.contains("prior") {
            return .init(
                sources: spectrSources,
                answer: "Bayesian inference updates beliefs using evidence via Bayes' theorem: posterior ∝ likelihood × prior [1]. It's foundational in probabilistic ML and scientific modeling [2].",
                related: ["What is a prior distribution?", "Bayesian vs frequentist statistics"],
                steps: pro ? ["Searching academic sources", "Synthesizing definitions", "Cross-checking examples"] : nil
            )
        }
        if lower.contains("keyboard") {
            return .init(
                sources: [
                    .init(id: 1, domain: "theverge.com", title: "The best keyboards of 2024"),
                ],
                answer: "Leading 2024 picks emphasize hot-swap PCBs, gasket mounts, and reliable wireless — Keychron and NuPhy dominate the mid-range.",
                related: ["Best keyboard under $100?", "Linear vs tactile switches?"],
                steps: pro ? ["Reviewing expert roundups", "Comparing switch types"] : nil
            )
        }
        return .init(
            sources: [
                .init(id: 1, domain: "wikipedia.org", title: "Overview — Wikipedia"),
            ],
            answer: "Here's a concise summary based on current sources [1]. Ask a follow-up to go deeper.",
            related: ["Tell me more", "What are the key sources?"],
            steps: pro ? ["Searching the web", "Reading top results"] : nil
        )
    }
}

// MARK: - Écrans showroom

private struct LpspPerplexityShowroomRoot: View {
    @ObservedObject var store: LpspPerplexityStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspPerplexityHomeScreen(store: store)
                case .discover:
                    LpspPerplexityDiscoverScreen(store: store)
                case .library:
                    LpspPerplexityLibraryScreen(store: store)
                case .spaces:
                    LpspPerplexitySpacesScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspPerplexityTabBar(store: store)
        }
        .background(LpspPerplexityTokens.pplxCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspPerplexityTabBar: View {
    @ObservedObject var store: LpspPerplexityStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspPerplexityTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.label)
                            .font(LpspPerplexityFonts.pplxTab)
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspPerplexityTokens.pplxTeal : LpspPerplexityTokens.pplxTextSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
                .sensoryFeedback(.selection, trigger: store.selectedTab)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspPerplexityTokens.pplxCanvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspPerplexityTokens.pplxDivider).frame(height: 0.5)
        }
    }
}

private struct LpspPerplexityHomeScreen: View {
    @ObservedObject var store: LpspPerplexityStore

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button { store.newThread() } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                }
                Spacer()
                Text(store.activeThread.title)
                    .font(LpspPerplexityFonts.pplxSubsection.weight(.semibold))
                    .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                    .lineLimit(1)
                Spacer()
                LpspPerplexityProSearchToggle(isOn: $store.isProMode)
            }
            .padding(.horizontal, 16)
            .frame(height: 48)

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        if !store.activeThread.question.isEmpty {
                            Text(store.activeThread.question)
                                .font(LpspPerplexityFonts.pplxQuestion)
                                .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                                .padding(.horizontal, 16)
                                .id("question")
                        }

                        if store.activeThread.answerState == .searching {
                            LpspPerplexitySearchingIndicator()
                                .padding(.horizontal, 16)
                        }

                        if !store.activeThread.sources.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Sources")
                                    .font(LpspPerplexityFonts.pplxSenderLabel)
                                    .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                                    .padding(.horizontal, 16)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(store.activeThread.sources) { source in
                                            LpspPerplexitySourceCard(
                                                number: source.id,
                                                faviconURL: nil,
                                                domain: source.domain,
                                                title: source.title
                                            )
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                        }

                        if let steps = store.activeThread.proSteps, store.isProMode {
                            LpspPerplexityProStepsCard(steps: steps)
                                .padding(.horizontal, 16)
                        }

                        if !store.activeThread.answer.isEmpty {
                            LpspPerplexityAnswerBlock(
                                content: (try? AttributedString(markdown: store.activeThread.answer)) ?? AttributedString(store.activeThread.answer),
                                isStreaming: store.activeThread.answerState == .streaming
                            )
                            .padding(.horizontal, 16)
                        }

                        if !store.activeThread.relatedQuestions.isEmpty, store.activeThread.answerState == .complete {
                            LpspPerplexityRelatedQuestionsCard(questions: store.activeThread.relatedQuestions) { q in
                                store.selectRelated(q)
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                    .padding(.vertical, 16)
                }
                .onChange(of: store.activeThread.answerState) { _, _ in
                    withAnimation { proxy.scrollTo("question", anchor: .bottom) }
                }
            }

            LpspPerplexitySearchInput(
                text: $store.composeText,
                onSubmit: { store.sendMessage() },
                onAttach: {}
            )
            .padding(.bottom, 8)
            .disabled(store.isGenerating)
        }
    }
}

private struct LpspPerplexityDiscoverScreen: View {
    @ObservedObject var store: LpspPerplexityStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Trending topics")
                        .font(LpspPerplexityFonts.pplxSection)
                        .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                    ForEach(store.discoverTopics, id: \.self) { topic in
                        Button {
                            store.selectThread(LpspPerplexityShowroomData.defaultThreadID)
                            store.composeText = topic
                            store.selectedTab = .home
                        } label: {
                            HStack {
                                Text(topic)
                                    .font(LpspPerplexityFonts.pplxBody)
                                    .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                                Spacer()
                                Image(systemName: "arrow.up.left")
                                    .foregroundStyle(LpspPerplexityTokens.pplxTeal)
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(LpspPerplexityTokens.pplxSurface1)
                            )
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 16)
                    }
                }
            }
            .background(LpspPerplexityTokens.pplxCanvas)
            .navigationTitle("Discover")
        }
    }
}

private struct LpspPerplexityLibraryScreen: View {
    @ObservedObject var store: LpspPerplexityStore

    var body: some View {
        NavigationStack {
            List(store.threads) { thread in
                Button {
                    store.selectThread(thread.id)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(thread.title)
                            .font(LpspPerplexityFonts.pplxBody.weight(.semibold))
                            .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                        if !thread.question.isEmpty {
                            Text(thread.question)
                                .font(LpspPerplexityFonts.pplxMeta)
                                .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                                .lineLimit(1)
                        }
                    }
                }
                .listRowBackground(LpspPerplexityTokens.pplxSurface1)
            }
            .scrollContentBackground(.hidden)
            .background(LpspPerplexityTokens.pplxCanvas)
            .navigationTitle("Library")
        }
    }
}

private struct LpspPerplexitySpacesScreen: View {
    @ObservedObject var store: LpspPerplexityStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.spaces, id: \.0) { space in
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LpspPerplexityTokens.pplxTealSoft)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "square.stack.3d.down.right")
                                    .foregroundStyle(LpspPerplexityTokens.pplxTeal)
                            )
                        VStack(alignment: .leading, spacing: 2) {
                            Text(space.0)
                                .font(LpspPerplexityFonts.pplxBody.weight(.semibold))
                                .foregroundStyle(LpspPerplexityTokens.pplxTextPrimary)
                            Text(space.1)
                                .font(LpspPerplexityFonts.pplxMeta)
                                .foregroundStyle(LpspPerplexityTokens.pplxTextSecondary)
                        }
                    }
                    .listRowBackground(LpspPerplexityTokens.pplxSurface1)
                }
            }
            .scrollContentBackground(.hidden)
            .background(LpspPerplexityTokens.pplxCanvas)
            .navigationTitle("Spaces")
        }
    }
}

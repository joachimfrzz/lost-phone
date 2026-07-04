import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/misc/perplexity/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/perplexity
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePerplexityView: View {
    var body: some View {
        LpspPerplexityShowroomRoot()
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
                if canSend { onSubmit(); text = "" }
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



// MARK: - Écrans showroom

private struct LpspPerplexityShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspPerplexityGenericTabScreen(title: "Home", tabIndex: 0)
                .tabItem { Label("Home", systemImage: "magnifyingglass") }
                .tag(0)
            LpspPerplexityGenericTabScreen(title: "Discover", tabIndex: 1)
                .tabItem { Label("Discover", systemImage: "safari") }
                .tag(1)
            LpspPerplexityGenericTabScreen(title: "Library", tabIndex: 2)
                .tabItem { Label("Library", systemImage: "books.vertical") }
                .tag(2)
            LpspPerplexityGenericTabScreen(title: "Spaces", tabIndex: 3)
                .tabItem { Label("Spaces", systemImage: "square.stack.3d.down.right") }
                .tag(3)
        }
        .tint(LpspPerplexityTokens.pplxTextPrimary)
        
    }
}


private struct LpspPerplexityGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspPerplexityTokens.pplxTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspPerplexityTokens.pplxTextPrimary))
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


private struct LpspPerplexityMessagingTabScreen: View {
    let title: String
    var body: some View { LpspPerplexityGenericTabScreen(title: title, tabIndex: 0) }
}



import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/messaging/messenger/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/messenger
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeMessengerView: View {
    var body: some View {
        LpspMessengerShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspMessengerFonts {
    static let msgLargeTitle   = Font.system(size: 28, weight: .regular)
    static let msgConvoName    = Font.system(size: 17, weight: .regular)
    static let msgConvoUnread  = Font.system(size: 17, weight: .regular)
    static let msgThreadTitle  = Font.system(size: 16, weight: .regular)
    static let msgMessageBody  = Font.system(size: 16, weight: .regular)
    static let msgPreview      = Font.system(size: 15, weight: .regular)
    static let msgSection      = Font.system(size: 13, weight: .regular)
    static let msgTimestamp    = Font.system(size: 13, weight: .regular)
    static let msgBubbleMeta   = Font.system(size: 12, weight: .regular)
    static let msgReactCount   = Font.system(size: 12, weight: .regular)
    static let msgButton       = Font.system(size: 16, weight: .regular)
    static let msgTab          = Font.system(size: 10, weight: .regular)
    static let msgActiveNow    = Font.system(size: 12, weight: .regular)
    static let msgSystem       = Font.system(size: 13, weight: .regular)
    static func messenger(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspMessengerTokens {
    // MARK: - Gradient stops (outgoing bubble only)
    static let msgGradBlue   = Color(red: 0.039, green: 0.486, blue: 1.000) // #0A7CFF
    static let msgGradViolet = Color(red: 0.616, green: 0.306, blue: 0.867) // #9D4EDD
    static let msgGradPink   = Color(red: 1.000, green: 0.361, blue: 0.627) // #FF5CA0

    // MARK: - UI blue
    static let msgBlue        = Color(red: 0.039, green: 0.486, blue: 1.000) // #0A7CFF
    static let msgBluePressed = Color(red: 0.031, green: 0.400, blue: 0.839) // #0866D6

    // MARK: - Canvas & Surfaces
    static let msgCanvas       = Color(red: 1, green: 1, blue: 1)             // #FFFFFF
    static let msgCanvasDark   = Color.black                                  // #000000 (true black)
    static let msgSurface      = Color(red: 0.945, green: 0.945, blue: 0.949) // #F1F1F2
    static let msgSurfaceDark  = Color(red: 0.110, green: 0.110, blue: 0.114) // #1C1C1D
    static let msgIncoming     = Color(red: 0.945, green: 0.945, blue: 0.949) // #F1F1F2
    static let msgIncomingDark = Color(red: 0.188, green: 0.188, blue: 0.188) // #303030
    static let msgDivider      = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
    static let msgDividerDark  = Color(red: 0.227, green: 0.231, blue: 0.235) // #3A3B3C

    // MARK: - Text
    static let msgTextPrimary   = Color(red: 0.020, green: 0.020, blue: 0.020) // #050505
    static let msgTextPrimaryD  = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
    static let msgTextSecondary = Color(red: 0.396, green: 0.404, blue: 0.420) // #65676B
    static let msgTextTertiary  = Color(red: 0.541, green: 0.553, blue: 0.569) // #8A8D91

    // MARK: - Semantic
    static let msgActiveGreen = Color(red: 0.192, green: 0.820, blue: 0.345)  // #31D158
    static let msgError       = Color(red: 0.980, green: 0.220, blue: 0.243)  // #FA383E
    static let msgSuccess     = Color(red: 0.192, green: 0.635, blue: 0.298)  // #31A24C
}

private enum LpspMessengerGradients {
    // The signature outgoing-bubble ribbon (≈135°)
    static let msgBubble = LinearGradient(
        colors: [LpspMessengerTokens.msgGradBlue, LpspMessengerTokens.msgGradViolet, LpspMessengerTokens.msgGradPink],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}





fileprivate struct LpspMessengerOutgoingBubble: View {
    let text: String
    let isLastInRun: Bool
    let threadHeight: CGFloat   // total visible thread height
    let bubbleOriginY: CGFloat  // this bubble's y within the thread

    var body: some View {
        HStack {
            Spacer(minLength: 0)
            Text(text)
                .font(LpspMessengerFonts.msgMessageBody)
                .foregroundStyle(.white)
                .padding(.vertical, 9)
                .padding(.horizontal, 14)
                .background(
                    // Gradient anchored to the conversation, not the bubble:
                    LinearGradient(colors: [LpspMessengerTokens.msgGradBlue, LpspMessengerTokens.msgGradViolet, LpspMessengerTokens.msgGradPink],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(height: threadHeight)
                        .offset(y: -bubbleOriginY)
                        .frame(height: 0, alignment: .top) // clip to bubble via mask below
                )
                .clipShape(LpspMessengerBubbleShape(radius: 18,
                                       tightCorner: .bottomRight,
                                       tight: isLastInRun ? 6 : 18))
                .frame(maxWidth: 270, alignment: .trailing)
        }
        .padding(.horizontal, 10)
    }
}

fileprivate struct LpspMessengerBubbleShape: Shape {
    var radius: CGFloat
    var tightCorner: UIRectCorner
    var tight: CGFloat
    func path(in rect: CGRect) -> Path {
        let normal: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        let p = UIBezierPath(roundedRect: rect, byRoundingCorners: normal.subtracting(tightCorner),
                             cornerRadii: CGSize(width: radius, height: radius))
        let tp = UIBezierPath(roundedRect: rect, byRoundingCorners: tightCorner,
                              cornerRadii: CGSize(width: tight, height: tight))
        p.append(tp)
        return Path(p.cgPath)
    }
}

fileprivate struct LpspMessengerReactionsPopover: View {
    let onPick: (String) -> Void
    @State private var shown = false
    private let emoji = ["👍", "❤️", "😆", "😮", "😢", "😡"]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(Array(emoji.enumerated()), id: \.offset) { i, e in
                Text(e)
                    .font(.system(size: 30))
                    .scaleEffect(shown ? 1 : 0.4)
                    .animation(.spring(response: 0.3, dampingFraction: 0.55)
                        .delay(Double(i) * 0.02), value: shown)
                    .onTapGesture { onPick(e) }
            }
            Image(systemName: "plus")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(LpspMessengerTokens.msgTextSecondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            Capsule().fill(LpspMessengerTokens.msgCanvas)
                .shadow(color: .black.opacity(0.18), radius: 14, y: 8)
        )
        .scaleEffect(shown ? 1 : 0.7)
        .animation(.spring(response: 0.32, dampingFraction: 0.6), value: shown)
        .onAppear { shown = true }
    }
}

// Corner reaction badge that lands with a bounce
fileprivate struct LpspMessengerReactionBadge: View {
    let emoji: String
    let count: Int
    @State private var landed = false
    var body: some View {
        HStack(spacing: 3) {
            Text(emoji).font(.system(size: 14))
            if count > 1 { Text("\(count)").font(LpspMessengerFonts.msgReactCount).foregroundStyle(LpspMessengerTokens.msgTextSecondary) }
        }
        .padding(.horizontal, 6).padding(.vertical, 3)
        .background(Capsule().fill(LpspMessengerTokens.msgCanvas)
            .overlay(Capsule().stroke(LpspMessengerTokens.msgDivider, lineWidth: 1)))
        .scaleEffect(landed ? 1 : 1.25)
        .animation(.spring(response: 0.25, dampingFraction: 0.5), value: landed)
        .onAppear { landed = true }
    }
}

fileprivate struct LpspMessengerComposerBar: View {
    @State private var text = ""
    private var hasText: Bool { !text.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        HStack(spacing: 10) {
            if !hasText {
                HStack(spacing: 16) {
                    ForEach(["camera", "photo", "mic", "face.smiling"], id: \.self) {
                        Image(systemName: $0).font(.system(size: 22))
                            .foregroundStyle(LpspMessengerTokens.msgBlue)
                    }
                }
                .transition(.opacity.combined(with: .scale))
            }
            HStack {
                TextField("Aa", text: $text, axis: .vertical)
                    .font(LpspMessengerFonts.msgMessageBody).lineLimit(1...5)
                Image(systemName: "face.smiling").font(.system(size: 20))
                    .foregroundStyle(LpspMessengerTokens.msgTextSecondary)
            }
            .padding(.horizontal, 12).frame(minHeight: 36)
            .background(Capsule().fill(LpspMessengerTokens.msgSurface))

            // Big-thumb: 👍 when empty (one-tap like), filled send when text exists
            Button { text = "" } label: {
                if hasText {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16, weight: .bold)).foregroundStyle(.white)
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(LpspMessengerTokens.msgBlue))
                } else {
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 22)).foregroundStyle(LpspMessengerTokens.msgBlue)
                        .frame(width: 32, height: 32)
                }
            }
            .sensoryFeedback(.impact(weight: .light), trigger: hasText)
        }
        .padding(.horizontal, 10).padding(.vertical, 8)
        .animation(.spring(response: 0.18, dampingFraction: 0.7), value: hasText)
    }
}

fileprivate struct LpspMessengerConversationRow: View {
    let name: String
    let preview: String
    let time: String
    let unread: Bool
    let activeNow: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                Circle().fill(LpspMessengerTokens.msgSurface).frame(width: 56, height: 56)
                if activeNow {
                    Circle().fill(LpspMessengerTokens.msgActiveGreen)
                        .frame(width: 14, height: 14)
                        .overlay(Circle().stroke(LpspMessengerTokens.msgCanvas, lineWidth: 2))
                }
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(unread ? LpspMessengerFonts.msgConvoUnread : LpspMessengerFonts.msgConvoName)
                    .foregroundStyle(LpspMessengerTokens.msgTextPrimary)
                Text(preview).font(LpspMessengerFonts.msgPreview)
                    .foregroundStyle(LpspMessengerTokens.msgTextSecondary).lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Text(time).font(LpspMessengerFonts.msgTimestamp).foregroundStyle(LpspMessengerTokens.msgTextSecondary)
                if unread { Circle().fill(LpspMessengerTokens.msgBlue).frame(width: 8, height: 8) }
            }
        }
        .padding(.vertical, 12).padding(.horizontal, 16)
        .frame(height: 72).contentShape(Rectangle())
    }
}

fileprivate struct LpspMessengerTypingBubble: View {
    @State private var phase = 0.0
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { i in
                Circle().fill(LpspMessengerTokens.msgTextSecondary).frame(width: 7, height: 7)
                    .offset(y: sin(phase + Double(i) * 0.6) * 3)
            }
        }
        .padding(.vertical, 12).padding(.horizontal, 14)
        .background(Capsule().fill(LpspMessengerTokens.msgIncoming))
        .onAppear {
            withAnimation(.linear(duration: 0.9).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
        }
    }
}



// MARK: - Écrans showroom

private struct LpspMessengerShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspMessengerChatsTabScreen()
                .tabItem { Label("Chats", systemImage: "message.fill") }
                .tag(0)
            LpspMessengerMessagingTabScreen(title: "Marketplace")
                .tabItem { Label("Marketplace", systemImage: "storefront.fill") }
                .tag(1)
            LpspMessengerMessagingTabScreen(title: "Stories")
                .tabItem { Label("Stories", systemImage: "play.circle.fill") }
                .tag(2)
        }
        .tint(LpspMessengerTokens.msgActiveGreen)
        
    }
}


private struct LpspMessengerGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspMessengerTokens.msgActiveGreen.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspMessengerTokens.msgActiveGreen))
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


private struct LpspMessengerPlaceholderChatRow: View {
    let name: String
    let preview: String
    let time: String
    var body: some View {
        HStack(spacing: 12) {
            Circle().fill(LpspMessengerTokens.msgActiveGreen.opacity(0.2)).frame(width: 48, height: 48)
                .overlay(Text(String(name.prefix(1))).font(.headline).foregroundStyle(LpspMessengerTokens.msgActiveGreen))
            VStack(alignment: .leading) {
                Text(name).font(.system(size: 17, weight: .semibold))
                Text(preview).font(.system(size: 15)).foregroundStyle(.secondary).lineLimit(1)
            }
            Spacer()
            Text(time).font(.system(size: 12)).foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
    }
}

private struct LpspMessengerDemoChat: Identifiable {
    let id = UUID()
    let name: String
    let preview: String
    let time: String
    let unread: Int
    let hasRing: Bool
}

private enum LpspMessengerDemoChats {
    static let chats: [LpspMessengerDemoChat] = [
        .init(name: "Alex Martin", preview: "On se voit ce soir ?", time: "10:24", unread: 2, hasRing: true),
        .init(name: "Léa Dupont", preview: "Merci pour hier", time: "Hier", unread: 0, hasRing: false),
        .init(name: "Famille", preview: "Photo: vacances", time: "Lun.", unread: 5, hasRing: true),
    ]
}

private struct LpspMessengerChatsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {

                ForEach(LpspMessengerDemoChats.chats) { chat in
                    NavigationLink {
                        LpspMessengerChatDetailScreen(chat: chat)
                    } label: {
                        LpspMessengerPlaceholderChatRow(name: chat.name, preview: chat.preview, time: chat.time)
                    }
                }

            }
            .listStyle(.plain)
            .navigationTitle("Chats")
        }
    }
}

private struct LpspMessengerChatDetailScreen: View {
    let chat: LpspMessengerDemoChat
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 8) {

                    LpspMessengerDemoBubble(text: "Salut, tu es dispo ?", outgoing: true)
                    LpspMessengerDemoBubble(text: "Oui, j'arrive !", outgoing: false)

                }
                .padding(.vertical, 8)
            }
            .background(LpspMessengerTokens.msgCanvas.ignoresSafeArea())
            LpspMessengerDemoComposeBar()
        }
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct LpspMessengerCallsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(LpspMessengerDemoChats.chats) { chat in
                HStack {
                    Circle().fill(LpspMessengerTokens.msgActiveGreen.opacity(0.15)).frame(width: 40, height: 40)
                        .overlay(Image(systemName: "phone.fill").foregroundStyle(LpspMessengerTokens.msgActiveGreen))
                    VStack(alignment: .leading) {
                        Text(chat.name).font(.system(size: 17, weight: .semibold))
                        Text("Appel vocal · Hier").font(.subheadline).foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: "info.circle").foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Appels")
        }
    }
}

private struct LpspMessengerMessagingTabScreen: View {
    let title: String
    var body: some View { LpspMessengerGenericTabScreen(title: title, tabIndex: 0) }
}

private struct LpspMessengerDemoBubble: View {
    let text: String
    var outgoing: Bool = true
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 60) }
            Text(text)
                .font(.system(size: 17))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspMessengerTokens.msgActiveGreen.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 8)
    }
}

private struct LpspMessengerDemoComposeBar: View {
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Message", text: $text)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill")
                .foregroundStyle(LpspMessengerTokens.msgActiveGreen)
                .font(.title2)
        }
        .padding(8)
        .background(.ultraThinMaterial)
    }
}



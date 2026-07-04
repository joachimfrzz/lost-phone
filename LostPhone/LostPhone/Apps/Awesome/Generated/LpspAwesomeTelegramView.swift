import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/telegram
// Meliwat/awesome-ios-design-md/messaging/telegram/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTelegramView: View {
    var body: some View {
        LpspTelegramShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTelegramTokens {
    // MARK: - Default Accent (user-themeable)
    static let tgAccent        = Color(red: 0.000, green: 0.533, blue: 0.800) // #0088CC
    static let tgAccentLight   = Color(red: 0.251, green: 0.655, blue: 0.890) // #40A7E3
    static let tgAccentPressed = Color(red: 0.000, green: 0.443, blue: 0.690) // #0071B0

    // MARK: - Bubble (default blue theme)
    static let tgBubbleOutgoing     = Color(red: 0.169, green: 0.525, blue: 0.992) // #2B86FD
    static let tgBubbleOutgoingTop  = Color(red: 0.169, green: 0.525, blue: 0.992) // #2B86FD (gradient top)
    static let tgBubbleOutgoingBot  = Color(red: 0.380, green: 0.702, blue: 1.000) // #61B3FF (gradient bottom)
    static let tgBubbleIncomingLight = Color.white
    static let tgBubbleIncomingDark  = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A

    // MARK: - Canvas
    static let tgCanvasLight   = Color.white                                    // #FFFFFF
    static let tgCanvasDark    = Color(red: 0.129, green: 0.129, blue: 0.129)   // #212121
    static let tgCanvasOLED    = Color.black                                     // #000000
    static let tgChatBGBlue    = Color(red: 0.859, green: 0.906, blue: 0.957)   // #DBE7F4 (default blue wallpaper)
    static let tgSurface1Light = Color(red: 0.969, green: 0.969, blue: 0.969)   // #F7F7F7
    static let tgSurface1Dark  = Color(red: 0.110, green: 0.110, blue: 0.110)   // #1C1C1C
    static let tgSurface2Dark  = Color(red: 0.173, green: 0.173, blue: 0.180)   // #2C2C2E
    static let tgDividerLight  = Color(red: 0.780, green: 0.780, blue: 0.800)   // #C7C7CC
    static let tgDividerDark   = Color(red: 0.220, green: 0.220, blue: 0.220)   // #383838

    // MARK: - Text
    static let tgTextPrimary       = Color.black
    static let tgTextSecondary     = Color(red: 0.439, green: 0.459, blue: 0.475) // #707579
    static let tgTextTertiary      = Color(red: 0.627, green: 0.651, blue: 0.678) // #A0A6AD
    static let tgTextPrimaryDark   = Color.white
    static let tgTextSecondaryDark = Color(red: 0.553, green: 0.557, blue: 0.576) // #8D8E93

    // MARK: - Semantic
    static let tgOnlineGreen   = Color(red: 0.302, green: 0.827, blue: 0.392) // #4DD364
    static let tgErrorRed      = Color(red: 0.898, green: 0.224, blue: 0.208) // #E53935
    static let tgDestructive   = Color(red: 0.890, green: 0.333, blue: 0.380) // #E35561
    static let tgPremiumA      = Color(red: 0.682, green: 0.435, blue: 0.992) // #AE6FFD
    static let tgPremiumB      = Color(red: 0.808, green: 0.420, blue: 1.000) // #CE6BFF
}

// Sender color palette (for group chats)
fileprivate enum LpspTelegramTgSenderColor: Int, CaseIterable {
    case red, orange, purple, green, teal, blue, pink
    var color: Color {
        switch self {
        case .red:    return Color(red: 0.988, green: 0.361, blue: 0.318)
        case .orange: return Color(red: 0.980, green: 0.475, blue: 0.059)
        case .purple: return Color(red: 0.537, green: 0.365, blue: 0.835)
        case .green:  return Color(red: 0.059, green: 0.698, blue: 0.592)
        case .teal:   return Color(red: 0.000, green: 0.757, blue: 0.651)
        case .blue:   return Color(red: 0.235, green: 0.647, blue: 0.925)
        case .pink:   return Color(red: 1.000, green: 0.322, blue: 0.455)
        }
    }
    static func forSender(_ id: Int) -> Color {
        return allCases[abs(id) % allCases.count].color
    }
}

fileprivate struct LpspTelegramTelegramTheme {
    var accent: Color = LpspTelegramTokens.tgAccent
    var outgoingBubble: Color = LpspTelegramTokens.tgBubbleOutgoing
    var useGradientBubbles: Bool = false
    var isDark: Bool = false
    var isOLED: Bool = false
}

private struct LpspTelegramThemeKey: EnvironmentKey {
    static let defaultValue = LpspTelegramTelegramTheme()
}

fileprivate extension EnvironmentValues {
    var telegramTheme: LpspTelegramTelegramTheme {
        get { self[LpspTelegramThemeKey.self] }
        set { self[LpspTelegramThemeKey.self] = newValue }
    }
}

private enum LpspTelegramFonts {
    static let tgLargeTitle     = Font.system(size: 34, weight: .bold)
    static let tgNavTitle       = Font.system(size: 17, weight: .semibold)
    static let tgContactName    = Font.system(size: 17, weight: .semibold)
    static let tgBubbleBody     = Font.system(size: 17, weight: .regular)
    static let tgGroupSender    = Font.system(size: 14, weight: .semibold)
    static let tgMessagePreview = Font.system(size: 15, weight: .regular)
    static let tgTimestampList  = Font.system(size: 13, weight: .regular)
    static let tgTimestampBubble = Font.system(size: 11, weight: .regular)
    static let tgCaption        = Font.system(size: 12, weight: .regular)
    static let tgTabLabel       = Font.system(size: 10, weight: .medium)
    static let tgButton         = Font.system(size: 17, weight: .semibold)
    static let tgCode           = Font.system(size: 15, weight: .regular)
}

fileprivate struct LpspTelegramTgComposeBar: View {
    @State private var text: String = ""
    @State private var showSilentMenu = false
    @Environment(\.telegramTheme) private var theme

    var body: some View {
        HStack(spacing: 16) {
            Button { /* attach */ } label: {
                Image(systemName: "paperclip")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    .rotationEffect(.degrees(45))
            }

            TextField("Message", text: $text, axis: .vertical)
                .font(.system(size: 16))
                .lineLimit(1...5)

            Button { /* emoji */ } label: {
                Image(systemName: "face.smiling")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
            }

            if text.isEmpty {
                Button { } label: {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(theme.accent)
                }
            } else {
                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(theme.accent)
                }
                .sensoryFeedback(.impact(flexibility: .soft), trigger: text)
                .contextMenu {
                    Button("Send Without Sound", systemImage: "speaker.slash") { sendSilent() }
                    Button("Schedule Message", systemImage: "calendar") { scheduleSend() }
                    Button("Send When Online", systemImage: "person.wave.2") { sendWhenOnline() }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(LpspTelegramTokens.tgSurface1Light)
        .overlay(Divider(), alignment: .top)
    }

    private func sendMessage() { text = "" }
    private func sendSilent() { text = "" }
    private func scheduleSend() { }
    private func sendWhenOnline() { }
}

fileprivate struct LpspTelegramTgOutgoingBubble: View {
    let text: String
    let timestamp: String
    let isRead: Bool
    @Environment(\.telegramTheme) private var theme

    var body: some View {
        HStack {
            Spacer(minLength: UIScreen.main.bounds.width * 0.2)
            VStack(alignment: .trailing, spacing: 4) {
                Text(text)
                    .font(LpspTelegramFonts.tgBubbleBody)
                    .foregroundStyle(.white)
                HStack(spacing: 2) {
                    Text(timestamp)
                        .font(LpspTelegramFonts.tgTimestampBubble)
                        .foregroundStyle(.white.opacity(0.8))
                    Image(systemName: isRead ? "checkmark.circle.fill" : "checkmark")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(bubbleBackground)
        }
        .padding(.trailing, 8)
    }

    @ViewBuilder
    private var bubbleBackground: some View {
        let shape = UnevenRoundedRectangle(
            topLeadingRadius: 17,
            bottomLeadingRadius: 17,
            bottomTrailingRadius: 6, // the "notch" tail corner
            topTrailingRadius: 17
        )
        if theme.useGradientBubbles {
            shape.fill(LinearGradient(colors: [LpspTelegramTokens.tgBubbleOutgoingTop, LpspTelegramTokens.tgBubbleOutgoingBot], startPoint: .top, endPoint: .bottom))
        } else {
            shape.fill(theme.outgoingBubble)
        }
    }
}

fileprivate struct LpspTelegramTgIncomingBubble: View {
    let text: String
    let senderName: String?
    let senderId: Int?

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                if let senderName, let senderId {
                    Text(senderName)
                        .font(LpspTelegramFonts.tgGroupSender)
                        .foregroundStyle(LpspTelegramTgSenderColor.forSender(senderId))
                }
                Text(text).font(LpspTelegramFonts.tgBubbleBody).foregroundStyle(LpspTelegramTokens.tgTextPrimary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 17,
                    bottomLeadingRadius: 6, // tail notch
                    bottomTrailingRadius: 17,
                    topTrailingRadius: 17
                )
                .fill(Color.white)
            )
            Spacer(minLength: UIScreen.main.bounds.width * 0.2)
        }
        .padding(.leading, 8)
    }
}

fileprivate struct LpspTelegramTgVoiceMiniPlayer: View {
    let title: String
    let progress: Double
    var onClose: () -> Void = {}

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "pause.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(LpspTelegramTokens.tgAccent)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(LpspTelegramTokens.tgDividerLight).frame(height: 2)
                        Capsule().fill(LpspTelegramTokens.tgAccent).frame(width: geo.size.width * progress, height: 2)
                    }
                }
                .frame(height: 2)
            }
            Button(action: onClose) {
                Image(systemName: "xmark").font(.system(size: 13, weight: .bold)).foregroundStyle(LpspTelegramTokens.tgTextSecondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .frame(height: 40)
        .background(
            Capsule()
                .fill(Color.white)
                .shadow(color: .black.opacity(0.16), radius: 16, y: 4)
        )
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspTelegramTgSwipeToReply<Content: View>: View {
    @ViewBuilder let content: Content
    @State private var offset: CGFloat = 0
    @State private var hasTicked = false
    let threshold: CGFloat = 60

    var body: some View {
        content
            .offset(x: offset)
            .overlay(alignment: .leading) {
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .foregroundStyle(LpspTelegramTokens.tgAccent)
                    .opacity(min(1, offset / threshold))
                    .padding(.leading, -32 + offset * 0.3)
            }
            .gesture(
                DragGesture()
                    .onChanged { g in
                        offset = max(0, min(g.translation.width, threshold + 20))
                        if offset >= threshold && !hasTicked {
                            hasTicked = true
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        }
                    }
                    .onEnded { _ in
                        if offset >= threshold { /* trigger reply */ }
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) { offset = 0 }
                        hasTicked = false
                    }
            )
    }
}

fileprivate struct LpspTelegramTgChatListRow: View {
    let avatar: Image
    let name: String
    let preview: String
    let timestamp: String
    let unreadCount: Int
    let isPinned: Bool
    let isMuted: Bool

    var body: some View {
        HStack(spacing: 12) {
            avatar
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 54, height: 54)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text(name)
                        .font(LpspTelegramFonts.tgContactName)
                        .foregroundStyle(LpspTelegramTokens.tgTextPrimary)
                        .lineLimit(1)
                    if isMuted {
                        Image(systemName: "speaker.slash.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    }
                }
                Text(preview)
                    .font(LpspTelegramFonts.tgMessagePreview)
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(timestamp)
                    .font(LpspTelegramFonts.tgTimestampList)
                    .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                HStack(spacing: 4) {
                    if isPinned {
                        Image(systemName: "pin.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(LpspTelegramTokens.tgTextSecondary)
                    }
                    if unreadCount > 0 {
                        Text("\(unreadCount)")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(RoundedRectangle(cornerRadius: 10).fill(isMuted ? LpspTelegramTokens.tgTextTertiary : LpspTelegramTokens.tgAccent))
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 76)
        .background(isPinned ? LpspTelegramTokens.tgSurface1Light : Color.clear)
        .contentShape(Rectangle())
    }
}



// MARK: - Écrans showroom

private struct LpspTelegramShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspTelegramSpectrHomeTabScreen()
                .tabItem { Label("Contacts", systemImage: "person.2.fill") }
                .tag(0)
            LpspTelegramCallsTabScreen()
                .tabItem { Label("Calls", systemImage: "phone.fill") }
                .tag(1)
            LpspTelegramChatsTabScreen()
                .tabItem { Label("Chats", systemImage: "bubble.left.and.bubble.right.fill") }
                .tag(2)
            LpspTelegramSettingsTabScreen()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
                .tag(3)
        }
        .tint(LpspTelegramTokens.tgAccent)
        
    }
}


private struct LpspTelegramGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTelegramTokens.tgAccent.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspTelegramTokens.tgAccent))
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


private struct LpspTelegramDemoChat: Identifiable {
    let id = UUID()
    let name: String
    let preview: String
    let time: String
    let unread: Int
    let hasRing: Bool
}

private enum LpspTelegramDemoChats {
    static let chats: [LpspTelegramDemoChat] = [
        .init(name: "Alex Martin", preview: "On se voit ce soir ?", time: "10:24", unread: 2, hasRing: true),
        .init(name: "Léa Dupont", preview: "Merci pour hier", time: "Hier", unread: 0, hasRing: false),
        .init(name: "Famille", preview: "Photo: vacances", time: "Lun.", unread: 5, hasRing: true),
    ]
}

private struct LpspTelegramChatsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {

                ForEach(LpspTelegramDemoChats.chats) { chat in
                    NavigationLink {
                        LpspTelegramChatDetailScreen(chat: chat)
                    } label: {
                        LpspTelegramTgChatListRow(avatar: Image(systemName: "person.circle.fill"), name: chat.name, preview: chat.preview, timestamp: chat.time, unreadCount: chat.unread, isPinned: false, isMuted: !chat.hasRing)
                    }
                }

            }
            .listStyle(.plain)
            .navigationTitle("Chats")
        }
    }
}


private struct LpspTelegramChatDetailScreen: View {
    let chat: LpspTelegramDemoChat
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 8) {

                    LpspTelegramTgOutgoingBubble(text: "Salut, tu es dispo ?", timestamp: "10:24", isRead: true)
                    LpspTelegramTgIncomingBubble(text: "Oui, j'arrive !", senderName: nil, senderId: nil)

                }
                .padding(.vertical, 8)
            }
            .background(LpspTelegramTokens.tgCanvasLight.ignoresSafeArea())
            LpspTelegramTgComposeBar()
        }
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


private struct LpspTelegramCallsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(LpspTelegramDemoChats.chats) { chat in
                HStack {
                    Circle().fill(LpspTelegramTokens.tgAccent.opacity(0.15)).frame(width: 40, height: 40)
                        .overlay(Image(systemName: "phone.fill").foregroundStyle(LpspTelegramTokens.tgAccent))
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

private struct LpspTelegramMessagingTabScreen: View {
    let title: String
    var body: some View {
        let low = title.lowercased()
        if low.contains("update") { LpspTelegramUpdatesTabScreen() }
        else if low.contains("setting") || low.contains("réglage") { LpspTelegramSettingsTabScreen() }
        else if low.contains("communit") { LpspTelegramCommunitiesTabScreen() }
        else if low.contains("contact") { LpspTelegramContactsTabScreen() }
        else { LpspTelegramChatsTabScreen() }
    }
}

private struct LpspTelegramUpdatesTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(LpspTelegramDemoStories.items) { s in
                        VStack(spacing: 4) {
                            Circle().strokeBorder(LpspTelegramTokens.tgAccent, lineWidth: 2).frame(width: 66, height: 66)
                            Text(s.name).font(.caption).lineLimit(1).frame(width: 72)
                        }
                    }
                }
                .padding(.horizontal, 12).padding(.vertical, 10)
            }
            .navigationTitle("Updates")
        }
    }
}

private struct LpspTelegramDemoStoryItem: Identifiable { let id = UUID(); let name: String }
private enum LpspTelegramDemoStories {
    static let items: [LpspTelegramDemoStoryItem] = [
        .init(name: "Votre statut"), .init(name: "Alex"), .init(name: "Léa"),
    ]
}

private struct LpspTelegramSettingsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Compte") { Label("Profil", systemImage: "person.circle"); Label("Confidentialité", systemImage: "lock") }
                Section("App") { Label("Notifications", systemImage: "bell"); Label("Stockage", systemImage: "internaldrive") }
            }
            .navigationTitle("Settings")
        }
    }
}

private struct LpspTelegramCommunitiesTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Famille", "Équipe projet"], id: \.self) { Label($0, systemImage: "person.3") }
            .navigationTitle("Communities")
        }
    }
}

private struct LpspTelegramContactsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Alex Martin", "Léa Dupont"], id: \.self) { Label($0, systemImage: "person.circle") }
            .navigationTitle("Contacts")
        }
    }
}

private struct LpspTelegramDemoBubble: View {
    let text: String
    var outgoing: Bool = true
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 60) }
            Text(text)
                .font(.system(size: 17))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspTelegramTokens.tgAccent.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 8)
    }
}

private struct LpspTelegramDemoComposeBar: View {
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Message", text: $text)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill")
                .foregroundStyle(LpspTelegramTokens.tgAccent)
                .font(.title2)
        }
        .padding(8)
        .background(.ultraThinMaterial)
    }
}


private struct LpspTelegramSpectrHomeTabScreen: View {
    var body: some View {

        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "chevron.left").font(.system(size: 17, weight: .semibold))
                Circle().fill(LpspTelegramTokens.tgAccent.opacity(0.25)).frame(width: 36, height: 36)
                    .overlay(Text("AL").font(.caption.bold()))
                VStack(alignment: .leading, spacing: 0) {
                    Text("Alex Martin").font(.system(size: 16, weight: .semibold))
                    Text("last seen recently").font(.system(size: 12)).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "video").font(.system(size: 20))
                Image(systemName: "phone").font(.system(size: 20))
            }
            .padding(.horizontal, 12).padding(.vertical, 8)
            ScrollView {
                VStack(spacing: 8) {
                    Text("Messages and calls are end-to-end encrypted.")
                        .font(.system(size: 12)).foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 8)

                        LpspTelegramTgOutgoingBubble(text: "Morning! Did the mockups get sent over last night?", timestamp: "9:41", isRead: true)
                        LpspTelegramTgIncomingBubble(text: "Yes — check the shared folder")

                }
                .padding(.vertical, 8)
            }
            LpspTelegramTgComposeBar()
        }
        .background(LpspTelegramTokens.tgCanvasLight.ignoresSafeArea())

    }
}



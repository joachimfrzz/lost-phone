import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/messaging/discord/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/discord
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDiscordView: View {
    var body: some View {
        LpspDiscordShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
import UIKit
private enum LpspDiscordTokens {
    // MARK: - Brand
    static let dcBlurple        = Color(red: 0.345, green: 0.396, blue: 0.949) // #5865F2
    static let dcBlurplePressed = Color(red: 0.278, green: 0.322, blue: 0.769) // #4752C4
    static let dcBlurpleLegacy  = Color(red: 0.447, green: 0.537, blue: 0.855) // #7289DA

    // MARK: - Three-Gray Surface System (Dark)
    static let dcServerRail   = Color(red: 0.118, green: 0.122, blue: 0.133) // #1E1F22
    static let dcChannelList  = Color(red: 0.169, green: 0.176, blue: 0.192) // #2B2D31
    static let dcChatCanvas   = Color(red: 0.192, green: 0.200, blue: 0.220) // #313338
    static let dcSurface2     = Color(red: 0.220, green: 0.227, blue: 0.251) // #383A40
    static let dcDivider      = Color(red: 0.247, green: 0.255, blue: 0.278) // #3F4147
    static let dcRowHover     = Color(red: 0.180, green: 0.188, blue: 0.208) // #2E3035
    static let dcActiveChannelBg = Color(red: 0.251, green: 0.259, blue: 0.286) // #404249

    // MARK: - Text
    static let dcTextPrimary    = Color(red: 0.949, green: 0.953, blue: 0.961) // #F2F3F5
    static let dcTextSecondary  = Color(red: 0.710, green: 0.729, blue: 0.757) // #B5BAC1
    static let dcTextMuted      = Color(red: 0.580, green: 0.608, blue: 0.643) // #949BA4
    static let dcTextLink       = Color(red: 0.000, green: 0.659, blue: 0.988) // #00A8FC
    static let dcTextDisabled   = Color(red: 0.365, green: 0.376, blue: 0.412) // #5D6069

    // MARK: - Status
    static let dcOnlineGreen    = Color(red: 0.137, green: 0.647, blue: 0.353) // #23A55A
    static let dcIdleYellow     = Color(red: 0.941, green: 0.698, blue: 0.196) // #F0B232
    static let dcDNDRed         = Color(red: 0.949, green: 0.247, blue: 0.263) // #F23F43
    static let dcOfflineGray    = Color(red: 0.502, green: 0.518, blue: 0.557) // #80848E
    static let dcStreamingPurple = Color(red: 0.349, green: 0.212, blue: 0.584) // #593695

    // MARK: - Destructive / Brand Variants
    static let dcDestructiveRed = Color(red: 0.855, green: 0.216, blue: 0.235) // #DA373C
    static let dcBoostPink      = Color(red: 0.922, green: 0.271, blue: 0.620) // #EB459E
}

// Nitro gradient
private enum LpspDiscordGradients {
    static let dcNitroGradient = LinearGradient(
        colors: [LpspDiscordTokens.dcBlurple, LpspDiscordTokens.dcBoostPink],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

private enum LpspDiscordFonts {
    // Use gg sans if bundled; fall back to .system
    private static func gg(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        if let _ = UIFont(name: "ggSans-Regular", size: size) {
            let suffix: String = {
                switch weight {
                case .bold:     return "Bold"
                case .semibold: return "Semibold"
                case .medium:   return "Medium"
                default:        return "Regular"
                }
            }()
            return .custom("ggSans-\(suffix)", size: size)
        }
        return .system(size: size, weight: weight)
    }

    static let dcScreenTitle    = Font.system(size: 17, weight: .bold)
    static let dcChannelActive  = Font.system(size: 17, weight: .semibold)
    static let dcChannelInactive = Font.system(size: 17, weight: .medium)
    static let dcUsername       = Font.system(size: 17, weight: .semibold)
    static let dcMessageBody    = Font.system(size: 17, weight: .regular)
    static let dcTimestamp      = Font.system(size: 17, weight: .medium)
    static let dcReplyContext   = Font.system(size: 17, weight: .regular)
    static let dcSystemMessage  = Font.system(size: 17, weight: .medium)
    static let dcSectionLabel   = Font.system(size: 17, weight: .bold)
    static let dcMemberName     = Font.system(size: 17, weight: .medium)
    static let dcButton         = Font.system(size: 17, weight: .medium)
    static let dcTabLabel       = Font.system(size: 17, weight: .semibold)
    static let dcCode           = Font.system(size: 14, weight: .regular)
}

fileprivate struct LpspDiscordDCServerRail: View {
    let servers: [LpspDiscordServer]
    @Binding var activeServerId: String?

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                LpspDiscordDCHomeButton()
                Rectangle()
                    .fill(LpspDiscordTokens.dcDivider)
                    .frame(width: 32, height: 2)
                    .padding(.vertical, 4)

                ForEach(servers) { server in
                    LpspDiscordDCServerIcon(
                        server: server,
                        isActive: server.id == activeServerId
                    ) {
                        activeServerId = server.id
                    }
                }

                Spacer(minLength: 16)
                LpspDiscordDCAddServerButton()
                LpspDiscordDCExploreButton()
            }
            .padding(.vertical, 8)
        }
        .frame(width: 72)
        .background(LpspDiscordTokens.dcServerRail)
    }
}

fileprivate struct LpspDiscordServer: Identifiable {
    let id: String
    let name: String
    let imageUri: String?
    let initials: String
    let unreadCount: Int
    let mentionCount: Int
}

fileprivate struct LpspDiscordDCServerIcon: View {
    let server: LpspDiscordServer
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            // Leading active indicator
            Rectangle()
                .fill(LpspDiscordTokens.dcTextPrimary)
                .frame(width: 4, height: isActive ? 40 : (server.unreadCount > 0 ? 8 : 0))
                .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isActive)

            Button(action: action) {
                ZStack(alignment: .bottomTrailing) {
                    Group {
                        if let uri = server.imageUri, let url = URL(string: uri) {
                            AsyncImage(url: url) { $0.resizable() } placeholder: {
                                Text(server.initials)
                                    .font(LpspDiscordFonts.dcButton)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(LpspDiscordTokens.dcBlurple)
                            }
                        } else {
                            Text(server.initials)
                                .font(LpspDiscordFonts.dcButton)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(LpspDiscordTokens.dcBlurple)
                        }
                    }
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: isActive ? 12 : 16))
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isActive)

                    if server.mentionCount > 0 {
                        Text("\(min(server.mentionCount, 99))")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .frame(minWidth: 18, minHeight: 18)
                            .background(Circle().fill(LpspDiscordTokens.dcDNDRed))
                            .overlay(Circle().stroke(LpspDiscordTokens.dcServerRail, lineWidth: 3))
                            .offset(x: 6, y: 6)
                    }
                }
            }
            .buttonStyle(.plain)
            .padding(.leading, 8)
            .padding(.trailing, 12)
        }
    }
}

fileprivate struct LpspDiscordDCHomeButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(LpspDiscordGradients.dcNitroGradient)
            .frame(width: 48, height: 48)
            .overlay(
                Image(systemName: "house.fill")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
            )
    }
}

fileprivate struct LpspDiscordDCAddServerButton: View {
    var body: some View {
        Circle()
            .fill(LpspDiscordTokens.dcChannelList)
            .frame(width: 48, height: 48)
            .overlay(
                Image(systemName: "plus")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(LpspDiscordTokens.dcOnlineGreen)
            )
    }
}

fileprivate struct LpspDiscordDCExploreButton: View {
    var body: some View {
        Circle()
            .fill(LpspDiscordTokens.dcChannelList)
            .frame(width: 48, height: 48)
            .overlay(
                Image(systemName: "safari.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspDiscordTokens.dcOnlineGreen)
            )
    }
}

fileprivate struct LpspDiscordDCMessageRow: View {
    let avatar: Image
    let username: String
    let roleColor: Color
    let timestamp: String
    let message: String
    let presenceStatus: LpspDiscordPresenceStatus
    let isGroupedWithPrevious: Bool

    enum LpspDiscordPresenceStatus { case online, idle, dnd, offline, streaming }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if isGroupedWithPrevious {
                Text(timestamp)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                    .frame(width: 40, alignment: .center)
                    .opacity(0) // reserve space; shows on hover in desktop
            } else {
                ZStack(alignment: .bottomTrailing) {
                    avatar
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    presenceDot
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                if !isGroupedWithPrevious {
                    HStack(spacing: 6) {
                        Text(username)
                            .font(LpspDiscordFonts.dcUsername)
                            .foregroundStyle(roleColor)
                        Text(timestamp)
                            .font(LpspDiscordFonts.dcTimestamp)
                            .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                    }
                }
                Text(message)
                    .font(LpspDiscordFonts.dcMessageBody)
                    .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
                    .lineSpacing(4)
                    .textSelection(.enabled)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, isGroupedWithPrevious ? 2 : 8)
    }

    @ViewBuilder
    private var presenceDot: some View {
        let color: Color = {
            switch presenceStatus {
            case .online:    return LpspDiscordTokens.dcOnlineGreen
            case .idle:      return LpspDiscordTokens.dcIdleYellow
            case .dnd:       return LpspDiscordTokens.dcDNDRed
            case .offline:   return LpspDiscordTokens.dcOfflineGray
            case .streaming: return LpspDiscordTokens.dcStreamingPurple
            }
        }()
        Circle()
            .fill(color)
            .frame(width: 12, height: 12)
            .overlay(Circle().stroke(LpspDiscordTokens.dcChatCanvas, lineWidth: 2.5))
    }
}

fileprivate struct LpspDiscordDCComposeBar: View {
    let channelName: String
    @State private var text: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 10) {
            Button { } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(LpspDiscordTokens.dcTextSecondary)
            }

            TextField("Message \(channelName)", text: $text, axis: .vertical)
                .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
                .tint(LpspDiscordTokens.dcBlurple)
                .focused($isFocused)
                .lineLimit(1...6)
                .padding(.horizontal, 2)

            HStack(spacing: 12) {
                Button { } label: { Image(systemName: "gift") }
                Button { } label: { Image(systemName: "photo.stack") }
                Button { } label: { Image(systemName: "face.smiling") }
            }
            .font(.system(size: 20))
            .foregroundStyle(LpspDiscordTokens.dcTextSecondary)

            if !text.isEmpty {
                Button { text = "" } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(LpspDiscordTokens.dcBlurple))
                }
                .sensoryFeedback(.impact(flexibility: .soft), trigger: text)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(LpspDiscordTokens.dcSurface2)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(LpspDiscordTokens.dcBlurple.opacity(isFocused ? 1 : 0), lineWidth: 2)
                )
        )
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
    }
}

fileprivate struct LpspDiscordDCChannelRow: View {
    let name: String
    let type: LpspDiscordChannelType
    let isActive: Bool
    let unreadCount: Int
    let mentionCount: Int

    enum LpspDiscordChannelType { case text, voice, announcement }

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: iconForType)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                .frame(width: 20)

            Text(name)
                .font(isActive ? LpspDiscordFonts.dcChannelActive : LpspDiscordFonts.dcChannelInactive)
                .foregroundStyle(textColor)

            Spacer()

            if mentionCount > 0 {
                Text("\(mentionCount)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 6)
                    .frame(minWidth: 18, minHeight: 16)
                    .background(Capsule().fill(LpspDiscordTokens.dcDNDRed))
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .frame(height: 36)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(isActive ? LpspDiscordTokens.dcActiveChannelBg : .clear)
        )
        .overlay(alignment: .leading) {
            if isActive {
                Rectangle()
                    .fill(LpspDiscordTokens.dcBlurple)
                    .frame(width: 3)
                    .padding(.leading, -4)
            }
        }
    }

    private var iconForType: String {
        switch type {
        case .text:         return "number"
        case .voice:        return "speaker.wave.2.fill"
        case .announcement: return "megaphone.fill"
        }
    }

    private var textColor: Color {
        if isActive || unreadCount > 0 || mentionCount > 0 { return LpspDiscordTokens.dcTextPrimary }
        return LpspDiscordTokens.dcTextMuted
    }
}

fileprivate struct LpspDiscordDCSpeakingRing<Avatar: View>: View {
    let isActiveSpeaker: Bool
    @ViewBuilder let avatar: Avatar
    @State private var pulseScale: CGFloat = 1.0

    var body: some View {
        avatar
            .overlay(
                Circle()
                    .stroke(LpspDiscordTokens.dcOnlineGreen, lineWidth: isActiveSpeaker ? 2.5 : 0)
                    .scaleEffect(pulseScale)
                    .opacity(isActiveSpeaker ? 1 : 0)
            )
            .onChange(of: isActiveSpeaker) { _, active in
                if active {
                    withAnimation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true)) {
                        pulseScale = 1.12
                    }
                } else {
                    withAnimation(.easeOut(duration: 0.2)) { pulseScale = 1.0 }
                }
            }
    }
}

fileprivate struct LpspDiscordDCReactionChip: View {
    let emoji: String
    let count: Int
    let didYouReact: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 4) {
                Text(emoji).font(.system(size: 16))
                Text("\(count)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(didYouReact ? LpspDiscordTokens.dcBlurple.opacity(0.3) : LpspDiscordTokens.dcChannelList)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(didYouReact ? LpspDiscordTokens.dcBlurple : LpspDiscordTokens.dcDivider, lineWidth: 1)
            )
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: didYouReact)
    }
}




// MARK: - Écrans showroom

private struct LpspDiscordShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspDiscordDiscordServersTabScreen()
                .tabItem { Label("Servers", systemImage: "square.grid.2x2.fill") }
                .tag(0)
            LpspDiscordDiscordMessagesTabScreen()
                .tabItem { Label("Messages", systemImage: "bubble.left.and.bubble.right.fill") }
                .tag(1)
            LpspDiscordDiscordNotificationsTabScreen()
                .tabItem { Label("Notifications", systemImage: "bell.fill") }
                .tag(2)
            LpspDiscordDiscordYouTabScreen()
                .tabItem { Label("You", systemImage: "person.crop.circle.fill") }
                .tag(3)
        }
        .tint(LpspDiscordTokens.dcIdleYellow)
        .preferredColorScheme(.dark)
    }
}


private struct LpspDiscordGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspDiscordTokens.dcIdleYellow.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspDiscordTokens.dcIdleYellow))
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


private struct LpspDiscordDiscordDemoServer: Identifiable {
    let id: String
    let name: String
    let initials: String
    let unreadCount: Int
    let mentionCount: Int
}

private enum LpspDiscordDiscordDemoData {
    static let servers: [LpspDiscordDiscordDemoServer] = [
        .init(id: "s1", name: "Lost Phone", initials: "LP", unreadCount: 0, mentionCount: 2),
        .init(id: "s2", name: "SwiftUI", initials: "SW", unreadCount: 3, mentionCount: 0),
        .init(id: "s3", name: "Paris", initials: "PA", unreadCount: 0, mentionCount: 0),
    ]
    static let channels = ["general", "showroom", "design-review"]
}

private struct LpspDiscordDiscordServersTabScreen: View {
    @State private var activeServerId: String? = "s1"
    var body: some View {
        HStack(spacing: 0) {
            LpspDiscordDCServerRail(servers: LpspDiscordDiscordDemoData.servers.map {
                LpspDiscordServer(id: $0.id, name: $0.name, imageUri: nil, initials: $0.initials, unreadCount: $0.unreadCount, mentionCount: $0.mentionCount)
            }, activeServerId: $activeServerId)
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        Text("TEXT CHANNELS").font(.caption.bold()).foregroundStyle(.secondary).padding(.horizontal, 12).padding(.top, 8)
                        ForEach(Array(LpspDiscordDiscordDemoData.channels.enumerated()), id: \.offset) { idx, name in
                            LpspDiscordDCChannelRow(name: name, type: .text, isActive: idx == 0, unreadCount: idx == 1 ? 2 : 0, mentionCount: idx == 0 ? 1 : 0)
                        }
                        ForEach(0..<4, id: \.self) { i in
                            LpspDiscordDCMessageRow(
                                avatar: Image(systemName: "person.circle.fill"),
                                username: i == 0 ? "Alex" : "Léa",
                                roleColor: LpspDiscordTokens.dcIdleYellow,
                                timestamp: "10:2\(i)",
                                message: i == 0 ? "Showroom Spectr prêt !" : "Super rendu 👍",
                                presenceStatus: .online,
                                isGroupedWithPrevious: i > 0
                            )
                        }
                    }
                }
                .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
                LpspDiscordDCComposeBar(channelName: "general")
            }
        }
        .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
    }
}

private struct LpspDiscordDiscordMessagesTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(LpspDiscordDemoChats.chats) { chat in
                    NavigationLink {
                        LpspDiscordDiscordDMDetailScreen(chat: chat)
                    } label: {
                        HStack(spacing: 12) {
                            Circle().fill(LpspDiscordTokens.dcIdleYellow.opacity(0.2)).frame(width: 48, height: 48)
                            VStack(alignment: .leading) {
                                Text(chat.name).font(.headline)
                                Text(chat.preview).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                            }
                            Spacer()
                            Text(chat.time).font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
            .navigationTitle("Messages")
        }
    }
}

private struct LpspDiscordDiscordDMDetailScreen: View {
    let chat: LpspDiscordDemoChat
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 8) {
                    LpspDiscordDCMessageRow(
                        avatar: Image(systemName: "person.circle.fill"),
                        username: chat.name,
                        roleColor: LpspDiscordTokens.dcIdleYellow,
                        timestamp: "10:24",
                        message: "On se voit ce soir ?",
                        presenceStatus: .online,
                        isGroupedWithPrevious: false
                    )
                    LpspDiscordDCMessageRow(
                        avatar: Image(systemName: "person.circle.fill"),
                        username: "Vous",
                        roleColor: .white,
                        timestamp: "10:25",
                        message: "Oui, j'arrive !",
                        presenceStatus: .online,
                        isGroupedWithPrevious: false
                    )
                }
                .padding(.vertical, 8)
            }
            .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
            LpspDiscordDCComposeBar(channelName: "general")
        }
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct LpspDiscordDiscordNotificationsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Mention in #general", "Nouveau message de Alex", "Invitation serveur"], id: \.self) { item in
                Label(item, systemImage: "bell.fill")
            }
            .scrollContentBackground(.hidden)
            .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
            .navigationTitle("Notifications")
        }
    }
}

private struct LpspDiscordDiscordYouTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Circle().fill(LpspDiscordTokens.dcIdleYellow.gradient).frame(width: 80, height: 80)
                Text("lost.phone").font(.title2.bold())
                Text("En ligne").foregroundStyle(.green)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
            .navigationTitle("You")
        }
    }
}

private struct LpspDiscordDemoChat: Identifiable {
    let id = UUID()
    let name: String
    let preview: String
    let time: String
}

private enum LpspDiscordDemoChats {
    static let chats: [LpspDiscordDemoChat] = [
        .init(name: "Alex Martin", preview: "On se voit ce soir ?", time: "10:24"),
        .init(name: "Léa Dupont", preview: "Merci pour hier", time: "Hier"),
    ]
}



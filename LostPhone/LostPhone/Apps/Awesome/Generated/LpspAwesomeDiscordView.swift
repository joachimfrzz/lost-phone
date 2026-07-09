import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/discord
// Meliwat/awesome-ios-design-md/messaging/discord/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDiscordView: View {
    var body: some View {
        LpspDiscordShowroomRoot(store: LpspDiscordStore())
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
    var onSend: ((String) -> Void)? = nil
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
                Button {
                    let outgoing = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !outgoing.isEmpty else { return }
                    onSend?(outgoing)
                    text = ""
                } label: {
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




// MARK: - Données & état

fileprivate struct LpspDiscordShowroomChannel: Identifiable, Hashable {
    let id: String
    let name: String
    let type: LpspDiscordDCChannelRow.LpspDiscordChannelType
    let unreadCount: Int
    let mentionCount: Int
}

fileprivate struct LpspDiscordShowroomServer: Identifiable, Hashable {
    let id: String
    let name: String
    let initials: String
    let unreadCount: Int
    let mentionCount: Int
    let channels: [LpspDiscordShowroomChannel]
}

fileprivate struct LpspDiscordShowroomReaction: Hashable {
    let emoji: String
    let count: Int
}

fileprivate struct LpspDiscordShowroomMessage: Identifiable, Hashable {
    let id: String
    let username: String
    let roleColor: Color
    let timestamp: String
    let body: String
    let presence: LpspDiscordDCMessageRow.LpspDiscordPresenceStatus
    let isGroupedWithPrevious: Bool
    let reactions: [LpspDiscordShowroomReaction]
}

fileprivate struct LpspDiscordShowroomDM: Identifiable, Hashable {
    let id: String
    let name: String
    let preview: String
    let time: String
    let presence: LpspDiscordDCMessageRow.LpspDiscordPresenceStatus
    var messages: [LpspDiscordShowroomMessage]
}

fileprivate struct LpspDiscordShowroomNotification: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let time: String
    let isUnread: Bool
}

private enum LpspDiscordMobileTab: CaseIterable {
    case servers, messages, notifications, you

    var label: String {
        switch self {
        case .servers: "Serveurs"
        case .messages: "Messages"
        case .notifications: "Notifs"
        case .you: "Profil"
        }
    }

    var icon: String {
        switch self {
        case .servers: "square.grid.2x2.fill"
        case .messages: "bubble.left.and.bubble.right.fill"
        case .notifications: "bell.fill"
        case .you: "person.crop.circle.fill"
        }
    }
}

@MainActor
fileprivate final class LpspDiscordStore: ObservableObject {
    @Published var selectedTab: LpspDiscordMobileTab = .servers
    @Published var activeServerId: String?
    @Published var activeChannelId: String?
    @Published var messagesByChannel: [String: [LpspDiscordShowroomMessage]]
    @Published var directMessages: [LpspDiscordShowroomDM]
    @Published var activeDMId: String?
    @Published var notifications: [LpspDiscordShowroomNotification]

    let servers: [LpspDiscordShowroomServer]

    init() {
        self.servers = LpspDiscordShowroomData.servers
        self.messagesByChannel = LpspDiscordShowroomData.messagesByChannel
        self.directMessages = LpspDiscordShowroomData.directMessages
        self.notifications = LpspDiscordShowroomData.notifications
        self.activeServerId = "eventscult"
        self.activeChannelId = "general"
    }

    var activeServer: LpspDiscordShowroomServer? {
        servers.first { $0.id == activeServerId }
    }

    var activeChannel: LpspDiscordShowroomChannel? {
        activeServer?.channels.first { $0.id == activeChannelId }
    }

    var channelKey: String? {
        guard let activeServerId, let activeChannelId else { return nil }
        return "\(activeServerId)/\(activeChannelId)"
    }

    var activeMessages: [LpspDiscordShowroomMessage] {
        guard let key = channelKey else { return [] }
        return messagesByChannel[key] ?? []
    }

    var activeDM: LpspDiscordShowroomDM? {
        directMessages.first { $0.id == activeDMId }
    }

    var railServers: [LpspDiscordServer] {
        servers.map {
            LpspDiscordServer(
                id: $0.id,
                name: $0.name,
                imageUri: nil,
                initials: $0.initials,
                unreadCount: $0.unreadCount,
                mentionCount: $0.mentionCount
            )
        }
    }

    func selectServer(_ id: String) {
        activeServerId = id
        activeChannelId = servers.first { $0.id == id }?.channels.first?.id
        selectedTab = .servers
    }

    func selectChannel(_ id: String) {
        activeChannelId = id
    }

    func sendChannelMessage(_ text: String) {
        guard let key = channelKey else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let time = formatter.string(from: Date())
        let message = LpspDiscordShowroomMessage(
            id: "sent-\(UUID().uuidString)",
            username: "mathieu_g",
            roleColor: LpspDiscordTokens.dcBlurple,
            timestamp: "Aujourd'hui à \(time)",
            body: text,
            presence: .online,
            isGroupedWithPrevious: false,
            reactions: []
        )
        messagesByChannel[key, default: []].append(message)
    }

    func sendDMMessage(_ text: String) {
        guard let dmId = activeDMId,
              let index = directMessages.firstIndex(where: { $0.id == dmId }) else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let time = formatter.string(from: Date())
        directMessages[index].messages.append(
            LpspDiscordShowroomMessage(
                id: "dm-\(UUID().uuidString)",
                username: "mathieu_g",
                roleColor: .white,
                timestamp: time,
                body: text,
                presence: .online,
                isGroupedWithPrevious: false,
                reactions: []
            )
        )
        directMessages[index] = LpspDiscordShowroomDM(
            id: directMessages[index].id,
            name: directMessages[index].name,
            preview: text,
            time: time,
            presence: directMessages[index].presence,
            messages: directMessages[index].messages
        )
    }

    func toggleReaction(channelKey: String, messageId: String, emoji: String) {
        guard var messages = messagesByChannel[channelKey],
              let index = messages.firstIndex(where: { $0.id == messageId }) else { return }
        var message = messages[index]
        if let reactionIndex = message.reactions.firstIndex(where: { $0.emoji == emoji }) {
            var reactions = message.reactions
            let current = reactions[reactionIndex]
            reactions[reactionIndex] = LpspDiscordShowroomReaction(emoji: emoji, count: max(0, current.count - 1))
            if reactions[reactionIndex].count == 0 {
                reactions.remove(at: reactionIndex)
            }
            message = LpspDiscordShowroomMessage(
                id: message.id,
                username: message.username,
                roleColor: message.roleColor,
                timestamp: message.timestamp,
                body: message.body,
                presence: message.presence,
                isGroupedWithPrevious: message.isGroupedWithPrevious,
                reactions: reactions
            )
        } else {
            message = LpspDiscordShowroomMessage(
                id: message.id,
                username: message.username,
                roleColor: message.roleColor,
                timestamp: message.timestamp,
                body: message.body,
                presence: message.presence,
                isGroupedWithPrevious: message.isGroupedWithPrevious,
                reactions: message.reactions + [LpspDiscordShowroomReaction(emoji: emoji, count: 1)]
            )
        }
        messages[index] = message
        messagesByChannel[channelKey] = messages
    }
}

private enum LpspDiscordShowroomData {
    static let servers: [LpspDiscordShowroomServer] = [
        .init(
            id: "eventscult",
            name: "EventsCult — Projet Dame",
            initials: "EC",
            unreadCount: 2,
            mentionCount: 1,
            channels: [
                .init(id: "annonces", name: "annonces", type: .announcement, unreadCount: 0, mentionCount: 0),
                .init(id: "general", name: "général", type: .text, unreadCount: 0, mentionCount: 1),
                .init(id: "planning", name: "planning-s7", type: .text, unreadCount: 3, mentionCount: 0),
                .init(id: "logistique", name: "logistique", type: .text, unreadCount: 1, mentionCount: 0),
                .init(id: "voice", name: "Briefing vocal", type: .voice, unreadCount: 0, mentionCount: 0),
            ]
        ),
        .init(
            id: "freelance",
            name: "Freelance Paris",
            initials: "FP",
            unreadCount: 1,
            mentionCount: 0,
            channels: [
                .init(id: "jobs", name: "missions", type: .text, unreadCount: 1, mentionCount: 0),
                .init(id: "feedback", name: "retours-clients", type: .text, unreadCount: 0, mentionCount: 0),
            ]
        ),
        .init(
            id: "bastille",
            name: "Studio Bastille",
            initials: "SB",
            unreadCount: 0,
            mentionCount: 0,
            channels: [
                .init(id: "wip", name: "work-in-progress", type: .text, unreadCount: 0, mentionCount: 0),
            ]
        ),
    ]

    static let messagesByChannel: [String: [LpspDiscordShowroomMessage]] = [
        "eventscult/general": [
            msg("g1", "nadia_k", LpspDiscordTokens.dcDNDRed, "11 juin · 18:02", "Réunion vendredi 18h — tout le monde présent. Pas de retard.", .dnd, false, [LpspDiscordShowroomReaction(emoji: "✅", count: 3)]),
            msg("g2", "vincent_m", .orange, "11 juin · 18:05", "Je confirme pour la vitrine. 4 min si l'équipe est réduite.", .idle, false, []),
            msg("g3", "sam_r", LpspDiscordTokens.dcOnlineGreen, "11 juin · 18:11", "Gennevilliers validé côté accès camionnette.", .online, false, [LpspDiscordShowroomReaction(emoji: "👍", count: 2)]),
            msg("g4", "mathieu_g", LpspDiscordTokens.dcBlurple, "11 juin · 18:24", "OK je passe les relevés ce soir. Dernière visite demain matin.", .online, false, []),
            msg("g5", "nadia_k", LpspDiscordTokens.dcDNDRed, "12 juin · 09:15", "@mathieu_g plus de photos avec ton tel dans les salles. On arrête les repérages.", .dnd, false, [LpspDiscordShowroomReaction(emoji: "⚠️", count: 1)]),
        ],
        "eventscult/planning": [
            msg("p1", "nadia_k", LpspDiscordTokens.dcDNDRed, "7 juin · 21:40", "Les horaires maintenance sont dans le brief v3 — relis avant envoi.", .dnd, false, []),
            msg("p2", "vincent_m", .orange, "7 juin · 21:52", "Ronde PM : 19h15 passage S7, pas 19h. Fenêtre 12 min confirmée.", .idle, false, [LpspDiscordShowroomReaction(emoji: "🕐", count: 4)]),
            msg("p3", "mathieu_g", LpspDiscordTokens.dcBlurple, "8 juin · 08:30", "Maintenance 18/06 notée. Effectif réduit = opportunité.", .online, false, []),
            msg("p4", "vincent_m", .orange, "10 juin · 14:02", "Angle mort caméra confirmé entre pilier et porte — 3 sec.", .idle, true, []),
        ],
        "eventscult/logistique": [
            msg("l1", "sam_r", LpspDiscordTokens.dcOnlineGreen, "2 juin · 14:18", "Zone indus rue des Caboeufs. Propre, discret.", .online, false, []),
            msg("l2", "nadia_k", LpspDiscordTokens.dcDNDRed, "2 juin · 14:25", "Point C = quai Rivoli, pas côté pyramide.", .dnd, false, []),
            msg("l3", "sam_r", LpspDiscordTokens.dcOnlineGreen, "6 juin · 19:45", "Transfert G. avant 23h max — accès OK.", .online, false, [LpspDiscordShowroomReaction(emoji: "🚐", count: 2)]),
        ],
        "eventscult/annonces": [
            msg("a1", "nadia_k", LpspDiscordTokens.dcDNDRed, "12 juin · 08:00", "⚠️ Dernier jour de repérage terrain. Ensuite radio silence jusqu'à J.", .dnd, false, []),
        ],
        "freelance/jobs": [
            msg("f1", "sophie_compta", LpspDiscordTokens.dcTextLink, "3 avr. · 10:14", "Devis menu Maillot validé — facture à envoyer.", .online, false, []),
            msg("f2", "atelier_soma", .pink, "14 mai · 08:03", "On reporte le projet identité à la rentrée, désolée.", .offline, false, []),
        ],
        "bastille/wip": [
            msg("b1", "mathieu_g", LpspDiscordTokens.dcBlurple, "28 mai · 22:10", "Planche logo Sōma v3 — palette terre cuite.", .online, false, []),
        ],
    ]

    static let directMessages: [LpspDiscordShowroomDM] = [
        .init(
            id: "dm-nadia",
            name: "Nadia K.",
            preview: "Plus de photos dans les salles",
            time: "09:15",
            presence: .dnd,
            messages: [
                msg("dn1", "Nadia K.", LpspDiscordTokens.dcDNDRed, "09:14", "Mathieu. Plus de photos avec ton tel dans les salles chaudes.", .dnd, false, []),
                msg("dn2", "Nadia K.", LpspDiscordTokens.dcDNDRed, "09:15", "On arrête les repérages à partir d'aujourd'hui.", .dnd, false, []),
            ]
        ),
        .init(
            id: "dm-vincent",
            name: "Vincent Morel",
            preview: "Badge périmé mais je connais les couloirs",
            time: "Hier",
            presence: .idle,
            messages: [
                msg("dv1", "Vincent Morel", .orange, "Hier 21:02", "J'ai bossé sur pire à la Fondation Vuitton. La vitrine c'est jouable.", .idle, false, []),
                msg("dv2", "Vincent Morel", .orange, "Hier 21:05", "Badge périmé mais je connais les couloirs Denon.", .idle, false, []),
            ]
        ),
        .init(
            id: "dm-sam",
            name: "Sam R.",
            preview: "C'est bon pour le local Gennevilliers",
            time: "2 juin",
            presence: .online,
            messages: [
                msg("ds1", "Sam R.", LpspDiscordTokens.dcOnlineGreen, "2 juin", "C'est bon pour le local. Propre, discret, accès camionnette facile.", .online, false, []),
            ]
        ),
    ]

    static let notifications: [LpspDiscordShowroomNotification] = [
        .init(id: "n1", title: "Mention dans #général", subtitle: "Nadia K. : @mathieu_g plus de photos…", time: "09:15", isUnread: true),
        .init(id: "n2", title: "Nouveau message", subtitle: "Vincent Morel t'a envoyé un message", time: "Hier", isUnread: true),
        .init(id: "n3", title: "EventsCult — Projet Dame", subtitle: "3 messages non lus dans #planning-s7", time: "8 juin", isUnread: false),
        .init(id: "n4", title: "Réaction", subtitle: "Sam a réagi 🚐 à ton message", time: "6 juin", isUnread: false),
    ]

    private static func msg(
        _ id: String,
        _ user: String,
        _ color: Color,
        _ time: String,
        _ body: String,
        _ presence: LpspDiscordDCMessageRow.LpspDiscordPresenceStatus,
        _ grouped: Bool,
        _ reactions: [LpspDiscordShowroomReaction]
    ) -> LpspDiscordShowroomMessage {
        LpspDiscordShowroomMessage(
            id: id,
            username: user,
            roleColor: color,
            timestamp: time,
            body: body,
            presence: presence,
            isGroupedWithPrevious: grouped,
            reactions: reactions
        )
    }
}

// MARK: - Écrans showroom

private struct LpspDiscordShowroomRoot: View {
    @ObservedObject var store: LpspDiscordStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .servers:
                    LpspDiscordServersScreen(store: store)
                case .messages:
                    LpspDiscordMessagesHubScreen(store: store)
                case .notifications:
                    LpspDiscordNotificationsScreen(store: store)
                case .you:
                    LpspDiscordProfileScreen(store: store)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspDiscordMobileTabBar(store: store)
        }
        .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspDiscordMobileTabBar: View {
    @ObservedObject var store: LpspDiscordStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspDiscordMobileTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        store.selectedTab = tab
                        if tab != .messages { store.activeDMId = nil }
                    }
                } label: {
                    VStack(spacing: 2) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                            if tab == .notifications, store.notifications.contains(where: \.isUnread) {
                                Circle()
                                    .fill(LpspDiscordTokens.dcDNDRed)
                                    .frame(width: 8, height: 8)
                                    .offset(x: 6, y: -2)
                            }
                        }
                        Text(tab.label)
                            .font(.system(size: 10))
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspDiscordTokens.dcTextPrimary : LpspDiscordTokens.dcTextMuted)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspDiscordTokens.dcServerRail)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspDiscordTokens.dcDivider).frame(height: 0.5)
        }
    }
}

private struct LpspDiscordServersScreen: View {
    @ObservedObject var store: LpspDiscordStore

    var body: some View {
        HStack(spacing: 0) {
            LpspDiscordDCServerRail(
                servers: store.railServers,
                activeServerId: Binding(
                    get: { store.activeServerId },
                    set: { if let id = $0 { store.selectServer(id) } }
                )
            )

            if let server = store.activeServer {
                LpspDiscordChannelSidebar(store: store, server: server)
                    .frame(width: 128)

                LpspDiscordChannelChatScreen(store: store, server: server)
            } else {
                ContentUnavailableView("Sélectionnez un serveur", systemImage: "server.rack")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LpspDiscordTokens.dcChatCanvas)
            }
        }
    }
}

private struct LpspDiscordChannelSidebar: View {
    @ObservedObject var store: LpspDiscordStore
    let server: LpspDiscordShowroomServer

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(server.initials)
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .frame(width: 28, height: 28)
                    .background(RoundedRectangle(cornerRadius: 6).fill(LpspDiscordTokens.dcBlurple))
                Text(server.name)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
                    .lineLimit(2)
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(LpspDiscordTokens.dcChannelList)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Text("TEXTUEL")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .padding(.bottom, 4)

                    ForEach(server.channels.filter { $0.type != .voice }) { channel in
                        Button {
                            store.selectChannel(channel.id)
                        } label: {
                            LpspDiscordDCChannelRow(
                                name: channel.name,
                                type: channel.type,
                                isActive: store.activeChannelId == channel.id,
                                unreadCount: channel.unreadCount,
                                mentionCount: channel.mentionCount
                            )
                        }
                        .buttonStyle(.plain)
                    }

                    Text("VOCAL")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                        .padding(.horizontal, 10)
                        .padding(.top, 14)
                        .padding(.bottom, 4)

                    ForEach(server.channels.filter { $0.type == .voice }) { channel in
                        LpspDiscordDCChannelRow(
                            name: channel.name,
                            type: channel.type,
                            isActive: false,
                            unreadCount: 0,
                            mentionCount: 0
                        )
                        .opacity(0.75)
                    }
                }
            }
            .background(LpspDiscordTokens.dcChannelList)
        }
        .background(LpspDiscordTokens.dcChannelList)
    }
}

private struct LpspDiscordChannelChatScreen: View {
    @ObservedObject var store: LpspDiscordStore
    let server: LpspDiscordShowroomServer

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "number")
                    .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                Text(store.activeChannel?.name ?? "général")
                    .font(LpspDiscordFonts.dcChannelActive)
                    .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
                Spacer()
                Image(systemName: "bell")
                    .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                Image(systemName: "person.2")
                    .foregroundStyle(LpspDiscordTokens.dcTextMuted)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(LpspDiscordTokens.dcChatCanvas)
            .overlay(alignment: .bottom) {
                Rectangle().fill(LpspDiscordTokens.dcDivider).frame(height: 0.5)
            }

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(store.activeMessages) { message in
                        VStack(alignment: .leading, spacing: 4) {
                            LpspDiscordDCMessageRow(
                                avatar: avatar(for: message.username),
                                username: message.username,
                                roleColor: message.roleColor,
                                timestamp: message.timestamp,
                                message: message.body,
                                presenceStatus: message.presence,
                                isGroupedWithPrevious: message.isGroupedWithPrevious
                            )
                            if !message.reactions.isEmpty {
                                HStack(spacing: 6) {
                                    ForEach(message.reactions, id: \.emoji) { reaction in
                                        LpspDiscordDCReactionChip(
                                            emoji: reaction.emoji,
                                            count: reaction.count,
                                            didYouReact: false
                                        ) {
                                            if let key = store.channelKey {
                                                store.toggleReaction(channelKey: key, messageId: message.id, emoji: reaction.emoji)
                                            }
                                        }
                                    }
                                }
                                .padding(.leading, 68)
                                .padding(.bottom, 4)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .background(LpspDiscordTokens.dcChatCanvas)

            LpspDiscordDCComposeBar(channelName: "#\(store.activeChannel?.name ?? "général")") { text in
                store.sendChannelMessage(text)
            }
        }
        .background(LpspDiscordTokens.dcChatCanvas)
    }

    private func avatar(for username: String) -> Image {
        Image(systemName: "person.circle.fill")
    }
}

private struct LpspDiscordMessagesHubScreen: View {
    @ObservedObject var store: LpspDiscordStore

    var body: some View {
        NavigationStack {
            Group {
                if let dm = store.activeDM {
                    LpspDiscordDMChatScreen(store: store, dm: dm)
                } else {
                    List {
                        ForEach(store.directMessages) { chat in
                            Button {
                                store.activeDMId = chat.id
                            } label: {
                                HStack(spacing: 12) {
                                    ZStack(alignment: .bottomTrailing) {
                                        Circle()
                                            .fill(LpspDiscordTokens.dcBlurple.opacity(0.35))
                                            .frame(width: 48, height: 48)
                                            .overlay(
                                                Text(String(chat.name.prefix(1)))
                                                    .font(.headline)
                                                    .foregroundStyle(.white)
                                            )
                                        Circle()
                                            .fill(presenceColor(chat.presence))
                                            .frame(width: 12, height: 12)
                                            .overlay(Circle().stroke(LpspDiscordTokens.dcChatCanvas, lineWidth: 2))
                                    }
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(chat.name)
                                            .font(.headline)
                                            .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
                                        Text(chat.preview)
                                            .font(.subheadline)
                                            .foregroundStyle(LpspDiscordTokens.dcTextSecondary)
                                            .lineLimit(1)
                                    }
                                    Spacer()
                                    Text(chat.time)
                                        .font(.caption)
                                        .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .navigationTitle("Messages")
                }
            }
            .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
        }
    }

    private func presenceColor(_ status: LpspDiscordDCMessageRow.LpspDiscordPresenceStatus) -> Color {
        switch status {
        case .online: return LpspDiscordTokens.dcOnlineGreen
        case .idle: return LpspDiscordTokens.dcIdleYellow
        case .dnd: return LpspDiscordTokens.dcDNDRed
        case .offline: return LpspDiscordTokens.dcOfflineGray
        case .streaming: return LpspDiscordTokens.dcStreamingPurple
        }
    }
}

private struct LpspDiscordDMChatScreen: View {
    @ObservedObject var store: LpspDiscordStore
    let dm: LpspDiscordShowroomDM

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Retour") { store.activeDMId = nil }
                    .font(.subheadline)
                    .foregroundStyle(LpspDiscordTokens.dcTextLink)
                Spacer()
                Text(dm.name)
                    .font(.headline)
                    .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
                Spacer()
                Circle()
                    .fill(LpspDiscordTokens.dcOnlineGreen)
                    .frame(width: 8, height: 8)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(LpspDiscordTokens.dcChannelList)

            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(dm.messages) { message in
                        LpspDiscordDCMessageRow(
                            avatar: Image(systemName: "person.circle.fill"),
                            username: message.username,
                            roleColor: message.roleColor,
                            timestamp: message.timestamp,
                            message: message.body,
                            presenceStatus: message.presence,
                            isGroupedWithPrevious: message.isGroupedWithPrevious
                        )
                    }
                }
                .padding(.vertical, 8)
            }
            .background(LpspDiscordTokens.dcChatCanvas)

            LpspDiscordDCComposeBar(channelName: dm.name) { text in
                store.sendDMMessage(text)
            }
        }
    }
}

private struct LpspDiscordNotificationsScreen: View {
    @ObservedObject var store: LpspDiscordStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.notifications) { notification in
                    HStack(alignment: .top, spacing: 12) {
                        Circle()
                            .fill(notification.isUnread ? LpspDiscordTokens.dcDNDRed : LpspDiscordTokens.dcTextMuted)
                            .frame(width: 8, height: 8)
                            .padding(.top, 6)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(notification.title)
                                .font(.headline)
                                .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
                            Text(notification.subtitle)
                                .font(.subheadline)
                                .foregroundStyle(LpspDiscordTokens.dcTextSecondary)
                            Text(notification.time)
                                .font(.caption)
                                .foregroundStyle(LpspDiscordTokens.dcTextMuted)
                        }
                    }
                    .listRowBackground(LpspDiscordTokens.dcChannelList)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Notifications")
            .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
        }
    }
}

private struct LpspDiscordProfileScreen: View {
    @ObservedObject var store: LpspDiscordStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Circle()
                    .fill(LpspDiscordGradients.dcNitroGradient)
                    .frame(width: 88, height: 88)
                    .overlay(Text("MG").font(.title.bold()).foregroundStyle(.white))

                VStack(spacing: 6) {
                    Text("mathieu_g")
                        .font(.title2.bold())
                        .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
                    Text("Mathieu Garnier")
                        .foregroundStyle(LpspDiscordTokens.dcTextSecondary)
                    HStack(spacing: 6) {
                        Circle().fill(LpspDiscordTokens.dcOnlineGreen).frame(width: 8, height: 8)
                        Text("En ligne")
                            .foregroundStyle(LpspDiscordTokens.dcOnlineGreen)
                    }
                    .font(.subheadline)
                }

                VStack(alignment: .leading, spacing: 10) {
                    profileRow("Serveurs", "\(store.servers.count)")
                    profileRow("Messages directs", "\(store.directMessages.count)")
                    profileRow("Rôle actif", "EventsCult · repérage")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12).fill(LpspDiscordTokens.dcChannelList))
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LpspDiscordTokens.dcChatCanvas.ignoresSafeArea())
            .navigationTitle("Profil")
        }
    }

    private func profileRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(LpspDiscordTokens.dcTextSecondary)
            Spacer()
            Text(value)
                .foregroundStyle(LpspDiscordTokens.dcTextPrimary)
        }
        .font(.subheadline)
    }
}


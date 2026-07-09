import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/microsoft-teams
// Meliwat/awesome-ios-design-md/productivity/microsoft-teams/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTeamsView: View {
    var body: some View {
        LpspTeamsShowroomRoot(store: LpspTeamsStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTeamsFonts {
    static let teamsTitleLarge = Font.system(size: 28, weight: .regular)
    static let teamsSection    = Font.system(size: 20, weight: .regular)
    static let teamsTeamName   = Font.system(size: 16, weight: .bold)
    static let teamsListTitle  = Font.system(size: 16, weight: .semibold)
    static let teamsAuthor     = Font.system(size: 15, weight: .semibold)
    static let teamsBody       = Font.system(size: 15, weight: .regular)
    static let teamsButton     = Font.system(size: 16, weight: .regular)
    static let teamsMetadata   = Font.system(size: 13, weight: .regular)
    static let teamsReaction   = Font.system(size: 12, weight: .regular)
    static let teamsTab        = Font.system(size: 10, weight: .regular)
    static let teamsTinyUpper  = Font.system(size: 11, weight: .regular)
    static func teamsSys(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspTeamsTokens {
    // Resolve light/dark at the call site
    static func teams(_ light: Color, _ dark: Color, _ scheme: ColorScheme) -> Color {
        scheme == .dark ? dark : light
    }

    // MARK: - Canvas & Surfaces (light)
    static let teamsLightCanvas   = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let teamsLightSurface1 = Color.white                                  // #FFFFFF
    static let teamsLightSurface2 = Color(red: 0.941, green: 0.941, blue: 0.941) // #F0F0F0
    static let teamsLightDivider  = Color(red: 0.882, green: 0.882, blue: 0.882) // #E1E1E1
    static let teamsLightText1    = Color(red: 0.145, green: 0.141, blue: 0.137) // #252423
    static let teamsLightText2    = Color(red: 0.380, green: 0.380, blue: 0.380) // #616161

    // MARK: - Canvas & Surfaces (dark)
    static let teamsDarkCanvas   = Color(red: 0.122, green: 0.122, blue: 0.122)  // #1F1F1F
    static let teamsDarkSurface1 = Color(red: 0.176, green: 0.173, blue: 0.173)  // #2D2C2C
    static let teamsDarkSurface2 = Color(red: 0.239, green: 0.235, blue: 0.235)  // #3D3C3C
    static let teamsDarkDivider  = Color(red: 0.239, green: 0.235, blue: 0.235)  // #3D3C3C
    static let teamsDarkText1    = Color.white                                   // #FFFFFF
    static let teamsDarkText2    = Color(red: 0.678, green: 0.678, blue: 0.678)  // #ADADAD

    // MARK: - Brand
    static let teamsPurpleLight = Color(red: 0.384, green: 0.392, blue: 0.655)   // #6264A7
    static let teamsPurpleDark  = Color(red: 0.357, green: 0.373, blue: 0.780)   // #5B5FC7
    static let teamsPurplePress = Color(red: 0.310, green: 0.322, blue: 0.698)   // #4F52B2

    // MARK: - LpspTeamsPresence (loaded semantic color)
    static let teamsAvailable = Color(red: 0.420, green: 0.718, blue: 0.0)       // #6BB700
    static let teamsBusy      = Color(red: 0.769, green: 0.192, blue: 0.294)     // #C4314B
    static let teamsAway      = Color(red: 1.0,   green: 0.667, blue: 0.267)     // #FFAA44
    static let teamsOffline   = Color(red: 0.541, green: 0.533, blue: 0.525)     // #8A8886
}





fileprivate enum LpspTeamsPresence { case available, busy, dnd, away, offline }

fileprivate struct LpspTeamsPresenceDot: View {
    let presence: LpspTeamsPresence
    var size: CGFloat = 10

    var body: some View {
        ZStack {
            switch presence {
            case .available: Circle().fill(LpspTeamsTokens.teamsAvailable)
            case .busy:      Circle().fill(LpspTeamsTokens.teamsBusy)
            case .dnd:
                Circle().fill(LpspTeamsTokens.teamsBusy)
                Capsule().fill(.white).frame(width: size * 0.5, height: size * 0.18)
            case .away:      Circle().fill(LpspTeamsTokens.teamsAway)
            case .offline:   Circle().strokeBorder(LpspTeamsTokens.teamsOffline, lineWidth: 1.5)
            }
        }
        .frame(width: size, height: size)
        .overlay(Circle().strokeBorder(Color(.systemBackground), lineWidth: 2))
        .animation(.easeInOut(duration: 0.25), value: presence)
    }
}

fileprivate struct LpspTeamsAvatarWithPresence: View {
    let initials: String
    let presence: LpspTeamsPresence
    var size: CGFloat = 32
    var body: some View {
        Circle()
            .fill(LpspTeamsTokens.teamsPurpleLight.opacity(0.25))
            .frame(width: size, height: size)
            .overlay(Text(initials).font(LpspTeamsFonts.teamsSys(size * 0.4, weight: .semibold)))
            .overlay(alignment: .bottomTrailing) {
                LpspTeamsPresenceDot(presence: presence, size: size * 0.32)
            }
    }
}

fileprivate struct LpspTeamsTeam: Identifiable {
    let id: String
    let name: String
    let initials: String
    var channels: [LpspTeamsChannel]
}

fileprivate struct LpspTeamsChannel: Identifiable {
    let id: String
    let name: String
    var unread: Bool
}

fileprivate struct LpspTeamsTeamTreeRow: View {
    let team: LpspTeamsTeam
    let isExpanded: Bool
    let activeChannelID: String?
    let onToggle: () -> Void
    let onSelectChannel: (String) -> Void
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        VStack(spacing: 0) {
            Button(action: onToggle) {
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTeamsTokens.teamsPurpleLight.opacity(0.3))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text(team.initials)
                                .font(LpspTeamsFonts.teamsSys(13, weight: .bold))
                                .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText1, LpspTeamsTokens.teamsDarkText1, scheme))
                        )
                    Text(team.name)
                        .font(LpspTeamsFonts.teamsTeamName)
                        .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText1, LpspTeamsTokens.teamsDarkText1, scheme))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText2, LpspTeamsTokens.teamsDarkText2, scheme))
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
            }
            .buttonStyle(.plain)

            if isExpanded {
                ForEach(team.channels) { channel in
                    LpspTeamsChannelRow(channel: channel, isActive: activeChannelID == channel.id)
                        .contentShape(Rectangle())
                        .onTapGesture { onSelectChannel(channel.id) }
                }
            }
        }
    }
}

fileprivate struct LpspTeamsChannelRow: View {
    let channel: LpspTeamsChannel
    let isActive: Bool
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        HStack(spacing: 8) {
            Text("#")
                .font(LpspTeamsFonts.teamsSys(16, weight: .semibold))
                .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText2, LpspTeamsTokens.teamsDarkText2, scheme))
            Text(channel.name)
                .font(LpspTeamsFonts.teamsListTitle)
                .fontWeight(channel.unread ? .bold : .semibold)
                .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText1, LpspTeamsTokens.teamsDarkText1, scheme))
            Spacer()
            if channel.unread {
                Circle()
                    .fill(LpspTeamsTokens.teams(LpspTeamsTokens.teamsPurpleLight, LpspTeamsTokens.teamsPurpleDark, scheme))
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.leading, 44)
        .padding(.trailing, 16)
        .frame(height: 44)
        .background(
            isActive
                ? LpspTeamsTokens.teams(LpspTeamsTokens.teamsPurpleLight, LpspTeamsTokens.teamsPurpleDark, scheme).opacity(0.12)
                : .clear
        )
        .overlay(alignment: .leading) {
            if isActive {
                Rectangle()
                    .fill(LpspTeamsTokens.teams(LpspTeamsTokens.teamsPurpleLight, LpspTeamsTokens.teamsPurpleDark, scheme))
                    .frame(width: 3)
            }
        }
    }
}

fileprivate struct LpspTeamsShowroomReaction: Hashable {
    let emoji: String
    var count: Int
    var mine: Bool
}

fileprivate struct LpspTeamsMessageCard: View {
    let author: String
    let initials: String
    let presence: LpspTeamsPresence
    let timestamp: String
    let postText: String
    let reactions: [LpspTeamsShowroomReaction]
    let replyCount: Int
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            LpspTeamsAvatarWithPresence(initials: initials, presence: presence)
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(author).font(LpspTeamsFonts.teamsAuthor)
                        .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText1, LpspTeamsTokens.teamsDarkText1, scheme))
                    Text(timestamp).font(LpspTeamsFonts.teamsMetadata)
                        .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText2, LpspTeamsTokens.teamsDarkText2, scheme))
                }
                Text(postText).font(LpspTeamsFonts.teamsBody)
                    .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText1, LpspTeamsTokens.teamsDarkText1, scheme))

                if !reactions.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(reactions, id: \.self) { reaction in
                            LpspTeamsReactionChip(emoji: reaction.emoji, count: reaction.count, mine: reaction.mine)
                        }
                    }
                }
                if replyCount > 0 {
                    Text("💬 \(replyCount) replies · Last reply 2h ago")
                        .font(LpspTeamsFonts.teamsMetadata)
                        .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText2, LpspTeamsTokens.teamsDarkText2, scheme))
                }
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightSurface1, LpspTeamsTokens.teamsDarkSurface1, scheme)))
    }
}

fileprivate struct LpspTeamsReactionChip: View {
    let emoji: String; let count: Int; let mine: Bool
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        HStack(spacing: 4) {
            Text(emoji).font(.system(size: 12))
            Text("\(count)").font(LpspTeamsFonts.teamsReaction)
                .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText2, LpspTeamsTokens.teamsDarkText2, scheme))
        }
        .padding(.horizontal, 8).padding(.vertical, 4)
        .background(Capsule().fill(mine
            ? LpspTeamsTokens.teamsPurpleLight.opacity(0.12)
            : LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightSurface2, LpspTeamsTokens.teamsDarkSurface2, scheme)))
    }
}

fileprivate struct LpspTeamsMeetingJoinBar: View {
    let title: String
    let onJoin: () -> Void
    @Environment(\.colorScheme) private var scheme
    @State private var pulse = false

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "video.fill").foregroundStyle(.white).font(.system(size: 18))
            Text(title).font(LpspTeamsFonts.teamsSys(15, weight: .semibold)).foregroundStyle(.white)
            Spacer()
            Button(action: onJoin) {
                Text("Join")
                    .font(LpspTeamsFonts.teamsSys(14, weight: .semibold))
                    .foregroundStyle(scheme == .dark ? LpspTeamsTokens.teamsPurpleDark : LpspTeamsTokens.teamsPurpleLight)
                    .padding(.horizontal, 18).frame(height: 30)
                    .background(Capsule().fill(.white))
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(scheme == .dark ? LpspTeamsTokens.teamsPurpleDark : LpspTeamsTokens.teamsPurpleLight))
        .shadow(color: LpspTeamsTokens.teamsPurpleLight.opacity(0.35), radius: 16, y: 4)
        .opacity(pulse ? 0.85 : 1.0)
        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: pulse)
        .padding(.horizontal, 12)
        .onAppear { pulse = true }
    }
}

fileprivate struct LpspTeamsTeamsPrimaryButton: View {
    let title: String
    let action: () -> Void
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspTeamsFonts.teamsButton)
                .foregroundStyle(.white)
                .padding(.vertical, 12).padding(.horizontal, 24)
                .frame(height: 44)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(scheme == .dark ? LpspTeamsTokens.teamsPurpleDark : LpspTeamsTokens.teamsPurpleLight))
        }
        .buttonStyle(LpspTeamsTeamsPressable())
        .sensoryFeedback(.impact(weight: .light), trigger: title)
    }
}

fileprivate struct LpspTeamsTeamsPressable: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .overlay(configuration.isPressed
                ? RoundedRectangle(cornerRadius: 8).fill(LpspTeamsTokens.teamsPurplePress).blendMode(.multiply) : nil)
            .animation(.spring(response: 0.25, dampingFraction: 0.85), value: configuration.isPressed)
    }
}



// MARK: - Données & état (showroom Lost Phone)

fileprivate struct LpspTeamsShowroomPost: Identifiable {
    let id: String
    let author: String
    let initials: String
    let presence: LpspTeamsPresence
    let timestamp: String
    let text: String
    var reactions: [LpspTeamsShowroomReaction]
    let replyCount: Int
}

fileprivate struct LpspTeamsShowroomChat: Identifiable {
    let id: String
    let name: String
    let preview: String
    let time: String
    let presence: LpspTeamsPresence
    var unread: Bool
}

fileprivate struct LpspTeamsShowroomMeeting: Identifiable {
    let id: String
    let title: String
    let time: String
    let dateLabel: String
    var isLive: Bool
}

fileprivate struct LpspTeamsShowroomCall: Identifiable {
    let id: String
    let name: String
    let detail: String
    let time: String
    let missed: Bool
}

fileprivate struct LpspTeamsShowroomActivity: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let time: String
    var isUnread: Bool
}

private enum LpspTeamsMobileTab: CaseIterable {
    case activity, chat, teams, calendar, calls

    var label: String {
        switch self {
        case .activity: "Activity"
        case .chat: "Chat"
        case .teams: "Teams"
        case .calendar: "Calendar"
        case .calls: "Calls"
        }
    }

    var icon: String {
        switch self {
        case .activity: "bell.fill"
        case .chat: "bubble.left.and.bubble.right.fill"
        case .teams: "person.3.fill"
        case .calendar: "calendar"
        case .calls: "phone.fill"
        }
    }
}

@MainActor
fileprivate final class LpspTeamsStore: ObservableObject {
    @Published var selectedTab: LpspTeamsMobileTab = .activity
    @Published var teams: [LpspTeamsTeam]
    @Published var expandedTeamIDs: Set<String>
    @Published var activeChannelID: String
    @Published var postsByChannel: [String: [LpspTeamsShowroomPost]]
    @Published var composeText = ""
    @Published var joinedMeeting = false
    @Published var chats: [LpspTeamsShowroomChat]
    @Published var meetings: [LpspTeamsShowroomMeeting]
    @Published var calls: [LpspTeamsShowroomCall]
    @Published var activities: [LpspTeamsShowroomActivity]

    let liveMeetingTitle = "Weekly Sync · in progress"
    let userInitials = "MG"
    let userPresence: LpspTeamsPresence = .available

    init() {
        self.teams = LpspTeamsShowroomData.teams
        self.expandedTeamIDs = ["design-guild", "engineering"]
        self.activeChannelID = LpspTeamsShowroomData.defaultChannelID
        self.postsByChannel = LpspTeamsShowroomData.postsByChannel
        self.chats = LpspTeamsShowroomData.chats
        self.meetings = LpspTeamsShowroomData.meetings
        self.calls = LpspTeamsShowroomData.calls
        self.activities = LpspTeamsShowroomData.activities
    }

    var activityBadge: Int {
        activities.filter(\.isUnread).count
    }

    var activePosts: [LpspTeamsShowroomPost] {
        postsByChannel[activeChannelID] ?? []
    }

    var activeChannelName: String {
        teams.flatMap(\.channels).first { $0.id == activeChannelID }?.name ?? "general"
    }

    func toggleTeam(_ teamID: String) {
        withAnimation(.easeInOut(duration: 0.2)) {
            if expandedTeamIDs.contains(teamID) {
                expandedTeamIDs.remove(teamID)
            } else {
                expandedTeamIDs.insert(teamID)
            }
        }
    }

    func selectChannel(_ channelID: String) {
        activeChannelID = channelID
        markChannelRead(channelID)
        if selectedTab != .activity && selectedTab != .teams {
            selectedTab = .teams
        }
    }

    func markChannelRead(_ channelID: String) {
        guard let teamIndex = teams.firstIndex(where: { $0.channels.contains { $0.id == channelID } }) else { return }
        var team = teams[teamIndex]
        if let channelIndex = team.channels.firstIndex(where: { $0.id == channelID }) {
            team.channels[channelIndex].unread = false
            teams[teamIndex] = team
        }
    }

    func joinMeeting() {
        joinedMeeting = true
    }

    func leaveMeeting() {
        joinedMeeting = false
    }

    func sendPost() {
        let trimmed = composeText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        var posts = postsByChannel[activeChannelID, default: []]
        posts.append(
            LpspTeamsShowroomPost(
                id: UUID().uuidString,
                author: "Mathieu G.",
                initials: "MG",
                presence: .available,
                timestamp: "Now",
                text: trimmed,
                reactions: [],
                replyCount: 0
            )
        )
        postsByChannel[activeChannelID] = posts
        composeText = ""
    }

    func toggleReaction(postID: String, emoji: String) {
        guard var posts = postsByChannel[activeChannelID],
              let index = posts.firstIndex(where: { $0.id == postID }) else { return }
        var post = posts[index]
        if let reactionIndex = post.reactions.firstIndex(where: { $0.emoji == emoji }) {
            var reaction = post.reactions[reactionIndex]
            if reaction.mine {
                reaction.count = max(0, reaction.count - 1)
                reaction.mine = false
                if reaction.count == 0 {
                    post.reactions.remove(at: reactionIndex)
                } else {
                    post.reactions[reactionIndex] = reaction
                }
            } else {
                reaction.count += 1
                reaction.mine = true
                post.reactions[reactionIndex] = reaction
            }
        } else {
            post.reactions.append(.init(emoji: emoji, count: 1, mine: true))
        }
        posts[index] = post
        postsByChannel[activeChannelID] = posts
    }
}

private enum LpspTeamsShowroomData {
    static let defaultChannelID = "design-guild/general"

    static let teams: [LpspTeamsTeam] = [
        .init(
            id: "design-guild",
            name: "Design Guild",
            initials: "DG",
            channels: [
                .init(id: "design-guild/general", name: "general", unread: false),
                .init(id: "design-guild/design-crit", name: "design-crit", unread: true),
                .init(id: "design-guild/handoff", name: "handoff", unread: false),
            ]
        ),
        .init(
            id: "engineering",
            name: "Engineering",
            initials: "EN",
            channels: [
                .init(id: "engineering/releases", name: "releases", unread: true),
                .init(id: "engineering/incidents", name: "incidents", unread: false),
            ]
        ),
        .init(
            id: "eventscult",
            name: "EventsCult — Projet Dame",
            initials: "EC",
            channels: [
                .init(id: "eventscult/annonces", name: "annonces", unread: false),
                .init(id: "eventscult/general", name: "général", unread: true),
                .init(id: "eventscult/planning-s7", name: "planning-s7", unread: true),
                .init(id: "eventscult/logistique", name: "logistique", unread: false),
            ]
        ),
    ]

    static let postsByChannel: [String: [LpspTeamsShowroomPost]] = [
        defaultChannelID: [
            .init(
                id: "p1",
                author: "Priya Anand",
                initials: "PA",
                presence: .busy,
                timestamp: "10:42 AM",
                text: "Pushed the build — can someone review the redirect fix?",
                reactions: [
                    .init(emoji: "👍", count: 3, mine: true),
                    .init(emoji: "❤️", count: 1, mine: false),
                ],
                replyCount: 3
            ),
        ],
        "eventscult/general": [
            .init(
                id: "eg1",
                author: "Nadia K.",
                initials: "NK",
                presence: .dnd,
                timestamp: "12 juin · 09:15",
                text: "@Mathieu G. plus de photos avec ton tel dans les salles chaudes. On arrête les repérages.",
                reactions: [.init(emoji: "⚠️", count: 2, mine: false)],
                replyCount: 1
            ),
            .init(
                id: "eg2",
                author: "Vincent Morel",
                initials: "VM",
                presence: .away,
                timestamp: "12 juin · 09:22",
                text: "Badge périmé mais je connais les couloirs Denon — vitrine faisable en 4 min.",
                reactions: [.init(emoji: "👍", count: 1, mine: false)],
                replyCount: 0
            ),
        ],
        "eventscult/planning-s7": [
            .init(
                id: "ep1",
                author: "Nadia K.",
                initials: "NK",
                presence: .dnd,
                timestamp: "7 juin · 21:40",
                text: "Maintenance 18/06 — ronde PM 19h15, effectif réduit. Fenêtre 12 min confirmée.",
                reactions: [.init(emoji: "🕐", count: 4, mine: true)],
                replyCount: 2
            ),
            .init(
                id: "ep2",
                author: "Sam R.",
                initials: "SR",
                presence: .available,
                timestamp: "8 juin · 08:30",
                text: "Gennevilliers validé côté accès camionnette. Transfert avant 23h max.",
                reactions: [.init(emoji: "🚐", count: 2, mine: false)],
                replyCount: 0
            ),
        ],
        "eventscult/logistique": [
            .init(
                id: "el1",
                author: "Sam R.",
                initials: "SR",
                presence: .available,
                timestamp: "2 juin · 14:18",
                text: "Zone indus rue des Caboeufs. Propre, discret.",
                reactions: [],
                replyCount: 0
            ),
        ],
        "engineering/releases": [
            .init(
                id: "er1",
                author: "Alex Martin",
                initials: "AM",
                presence: .available,
                timestamp: "Hier · 16:10",
                text: "Build 412 en prod — rollback plan prêt si besoin.",
                reactions: [.init(emoji: "✅", count: 2, mine: false)],
                replyCount: 0
            ),
        ],
    ]

    static let chats: [LpspTeamsShowroomChat] = [
        .init(id: "dm-nadia", name: "Nadia K.", preview: "Plus de photos dans les salles", time: "09:15", presence: .dnd, unread: true),
        .init(id: "dm-vincent", name: "Vincent Morel", preview: "Badge périmé mais couloirs connus", time: "Hier", presence: .away, unread: true),
        .init(id: "dm-sam", name: "Sam R.", preview: "Gennevilliers OK pour camionnette", time: "2 juin", presence: .available, unread: false),
        .init(id: "dm-priya", name: "Priya Anand", preview: "Redirect fix merged", time: "10:42", presence: .busy, unread: false),
    ]

    static let meetings: [LpspTeamsShowroomMeeting] = [
        .init(id: "m-live", title: "Weekly Sync", time: "En cours", dateLabel: "Aujourd'hui", isLive: true),
        .init(id: "m1", title: "Brief vitrine S7", time: "18:00", dateLabel: "Mer 18 juin", isLive: false),
        .init(id: "m2", title: "Point logistique Gennevilliers", time: "21:30", dateLabel: "Jeu 19 juin", isLive: false),
        .init(id: "m3", title: "Revue accès maintenance", time: "19:15", dateLabel: "Mer 18 juin", isLive: false),
    ]

    static let calls: [LpspTeamsShowroomCall] = [
        .init(id: "c1", name: "Nadia K.", detail: "Audio · 4 min", time: "09:02", missed: false),
        .init(id: "c2", name: "Vincent Morel", detail: "Appel manqué", time: "Hier", missed: true),
        .init(id: "c3", name: "Sam R.", detail: "Vidéo · 12 min", time: "6 juin", missed: false),
    ]

    static let activities: [LpspTeamsShowroomActivity] = [
        .init(id: "a1", title: "Nadia K. vous a mentionné", subtitle: "#général · plus de photos…", time: "09:15", isUnread: true),
        .init(id: "a2", title: "Weekly Sync en cours", subtitle: "Rejoindre la réunion maintenant", time: "Maintenant", isUnread: true),
        .init(id: "a3", title: "3 réponses dans #planning-s7", subtitle: "Sam R. · Gennevilliers validé", time: "8 juin", isUnread: true),
        .init(id: "a4", title: "Priya Anand a réagi 👍", subtitle: "Votre message dans #general", time: "10:45", isUnread: false),
    ]
}

// MARK: - Écrans showroom

private struct LpspTeamsShowroomRoot: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .activity:
                        LpspTeamsActivityScreen(store: store)
                    case .chat:
                        LpspTeamsChatHubScreen(store: store)
                    case .teams:
                        LpspTeamsChannelHubScreen(store: store)
                    case .calendar:
                        LpspTeamsCalendarScreen(store: store)
                    case .calls:
                        LpspTeamsCallsScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspTeamsMobileTabBar(store: store)
            }

            if store.joinedMeeting {
                LpspTeamsMeetingOverlay(store: store)
                    .zIndex(2)
            }
        }
        .preferredColorScheme(store.selectedTab == .activity || store.selectedTab == .teams ? .dark : nil)
    }
}

private struct LpspTeamsMobileTabBar: View {
    @ObservedObject var store: LpspTeamsStore
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspTeamsMobileTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                            if tab == .activity, store.activityBadge > 0 {
                                Text("\(store.activityBadge)")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 1)
                                    .background(Capsule().fill(LpspTeamsTokens.teamsPurpleDark))
                                    .offset(x: 8, y: -4)
                            }
                        }
                        Text(tab.label)
                            .font(LpspTeamsFonts.teamsTab)
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspTeamsTokens.teams(LpspTeamsTokens.teamsPurpleLight, LpspTeamsTokens.teamsPurpleDark, scheme)
                            : LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText2, LpspTeamsTokens.teamsDarkText2, scheme)
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightSurface1, LpspTeamsTokens.teamsDarkSurface1, scheme))
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightDivider, LpspTeamsTokens.teamsDarkDivider, scheme))
                .frame(height: 0.5)
        }
    }
}

private struct LpspTeamsTopBar: View {
    @ObservedObject var store: LpspTeamsStore
    let title: String

    var body: some View {
        HStack(spacing: 12) {
            LpspTeamsAvatarWithPresence(initials: store.userInitials, presence: store.userPresence, size: 32)
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(LpspTeamsTokens.teamsDarkText1)
            Spacer()
            Button {} label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(LpspTeamsTokens.teamsDarkText1)
                    .frame(width: 40, height: 40)
            }
            Button { store.selectedTab = .teams } label: {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(LpspTeamsTokens.teamsDarkText1)
                    .frame(width: 40, height: 40)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(LpspTeamsTokens.teamsDarkCanvas)
    }
}

private struct LpspTeamsActivityScreen: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        VStack(spacing: 0) {
            LpspTeamsTopBar(store: store, title: "Teams")

            ScrollView {
                VStack(spacing: 0) {
                    LpspTeamsMeetingJoinBar(title: store.liveMeetingTitle, onJoin: { store.joinMeeting() })
                        .padding(.top, 8)

                    LpspTeamsTeamTreeSection(store: store)

                    LazyVStack(spacing: 8) {
                        ForEach(store.activePosts) { post in
                            LpspTeamsPostCard(post: post, store: store)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 8)
                }
            }
        }
        .background(LpspTeamsTokens.teamsDarkCanvas.ignoresSafeArea())
    }
}

private struct LpspTeamsChannelHubScreen: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        VStack(spacing: 0) {
            LpspTeamsChannelHeader(store: store)

            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(store.activePosts) { post in
                        LpspTeamsPostCard(post: post, store: store)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }

            LpspTeamsComposeBar(store: store)
        }
        .background(LpspTeamsTokens.teamsDarkCanvas.ignoresSafeArea())
    }
}

private struct LpspTeamsChannelHeader: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("# \(store.activeChannelName)")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(LpspTeamsTokens.teamsDarkText1)
                Spacer()
                Button {} label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(LpspTeamsTokens.teamsDarkText2)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            .background(LpspTeamsTokens.teamsDarkSurface1)

            LpspTeamsMeetingJoinBar(title: store.liveMeetingTitle, onJoin: { store.joinMeeting() })
                .padding(.vertical, 8)

            LpspTeamsTeamTreeSection(store: store)
        }
    }
}

private struct LpspTeamsTeamTreeSection: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        VStack(spacing: 0) {
            ForEach(store.teams) { team in
                LpspTeamsTeamTreeRow(
                    team: team,
                    isExpanded: store.expandedTeamIDs.contains(team.id),
                    activeChannelID: store.activeChannelID,
                    onToggle: { store.toggleTeam(team.id) },
                    onSelectChannel: { store.selectChannel($0) }
                )
            }
        }
    }
}

private struct LpspTeamsPostCard: View {
    let post: LpspTeamsShowroomPost
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        LpspTeamsMessageCard(
            author: post.author,
            initials: post.initials,
            presence: post.presence,
            timestamp: post.timestamp,
            postText: post.text,
            reactions: post.reactions,
            replyCount: post.replyCount
        )
        .onTapGesture {
            store.toggleReaction(postID: post.id, emoji: "👍")
        }
    }
}

private struct LpspTeamsComposeBar: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        HStack(spacing: 8) {
            TextField("Message in #\(store.activeChannelName)", text: $store.composeText, axis: .vertical)
                .font(LpspTeamsFonts.teamsBody)
                .foregroundStyle(LpspTeamsTokens.teamsDarkText1)
                .lineLimit(1...4)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTeamsTokens.teamsDarkSurface2)
                )

            Button { store.sendPost() } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(LpspTeamsTokens.teamsPurpleDark)
                    .frame(width: 40, height: 40)
            }
            .disabled(store.composeText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(LpspTeamsTokens.teamsDarkSurface1)
    }
}

private struct LpspTeamsChatHubScreen: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        NavigationStack {
            List(store.chats) { chat in
                Button {
                    if let channel = store.teams.flatMap(\.channels).first(where: { $0.name == "général" && $0.id.hasPrefix("eventscult") }) {
                        store.selectChannel(channel.id)
                    }
                } label: {
                    HStack(spacing: 12) {
                        LpspTeamsAvatarWithPresence(initials: String(chat.name.prefix(2).uppercased()), presence: chat.presence)
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(chat.name)
                                    .font(LpspTeamsFonts.teamsAuthor)
                                    .foregroundStyle(LpspTeamsTokens.teamsLightText1)
                                Spacer()
                                Text(chat.time)
                                    .font(LpspTeamsFonts.teamsMetadata)
                                    .foregroundStyle(LpspTeamsTokens.teamsLightText2)
                            }
                            Text(chat.preview)
                                .font(LpspTeamsFonts.teamsBody)
                                .foregroundStyle(LpspTeamsTokens.teamsLightText2)
                                .lineLimit(1)
                        }
                        if chat.unread {
                            Circle()
                                .fill(LpspTeamsTokens.teamsPurpleLight)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Chat")
            .background(LpspTeamsTokens.teamsLightCanvas)
        }
    }
}

private struct LpspTeamsCalendarScreen: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        NavigationStack {
            List(store.meetings) { meeting in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(meeting.isLive ? LpspTeamsTokens.teamsPurpleLight : LpspTeamsTokens.teamsLightSurface2)
                        .frame(width: 4)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(meeting.title)
                            .font(LpspTeamsFonts.teamsAuthor)
                            .foregroundStyle(LpspTeamsTokens.teamsLightText1)
                        Text("\(meeting.dateLabel) · \(meeting.time)")
                            .font(LpspTeamsFonts.teamsMetadata)
                            .foregroundStyle(LpspTeamsTokens.teamsLightText2)
                    }
                    Spacer()
                    if meeting.isLive {
                        Button("Join") { store.joinMeeting() }
                            .font(LpspTeamsFonts.teamsSys(14, weight: .semibold))
                            .foregroundStyle(LpspTeamsTokens.teamsPurpleLight)
                    }
                }
                .padding(.vertical, 4)
            }
            .listStyle(.plain)
            .navigationTitle("Calendar")
            .background(LpspTeamsTokens.teamsLightCanvas)
        }
    }
}

private struct LpspTeamsCallsScreen: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        NavigationStack {
            List(store.calls) { call in
                HStack(spacing: 12) {
                    LpspTeamsAvatarWithPresence(initials: String(call.name.prefix(2).uppercased()), presence: call.missed ? .offline : .available)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(call.name)
                            .font(LpspTeamsFonts.teamsAuthor)
                            .foregroundStyle(call.missed ? LpspTeamsTokens.teamsBusy : LpspTeamsTokens.teamsLightText1)
                        Text(call.detail)
                            .font(LpspTeamsFonts.teamsMetadata)
                            .foregroundStyle(LpspTeamsTokens.teamsLightText2)
                    }
                    Spacer()
                    Text(call.time)
                        .font(LpspTeamsFonts.teamsMetadata)
                        .foregroundStyle(LpspTeamsTokens.teamsLightText2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Calls")
            .background(LpspTeamsTokens.teamsLightCanvas)
        }
    }
}

private struct LpspTeamsMeetingOverlay: View {
    @ObservedObject var store: LpspTeamsStore

    var body: some View {
        ZStack {
            Color.black.opacity(0.92).ignoresSafeArea()

            VStack(spacing: 24) {
                Text(store.liveMeetingTitle)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    meetingTile("Nadia K.", "NK", .dnd)
                    meetingTile("Vincent M.", "VM", .away)
                    meetingTile("Sam R.", "SR", .available)
                    meetingTile("Vous", store.userInitials, .available)
                }
                .padding(.horizontal, 24)

                HStack(spacing: 32) {
                    Button {} label: {
                        Image(systemName: "mic.slash.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                            .frame(width: 52, height: 52)
                            .background(Circle().fill(.white.opacity(0.15)))
                    }
                    Button { store.leaveMeeting() } label: {
                        Image(systemName: "phone.down.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                            .frame(width: 56, height: 56)
                            .background(Circle().fill(LpspTeamsTokens.teamsBusy))
                    }
                    Button {} label: {
                        Image(systemName: "video.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                            .frame(width: 52, height: 52)
                            .background(Circle().fill(.white.opacity(0.15)))
                    }
                }
                .padding(.top, 16)
            }
        }
    }

    private func meetingTile(_ name: String, _ initials: String, _ presence: LpspTeamsPresence) -> some View {
        VStack(spacing: 8) {
            LpspTeamsAvatarWithPresence(initials: initials, presence: presence, size: 64)
            Text(name)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(RoundedRectangle(cornerRadius: 12).fill(LpspTeamsTokens.teamsDarkSurface1))
    }
}


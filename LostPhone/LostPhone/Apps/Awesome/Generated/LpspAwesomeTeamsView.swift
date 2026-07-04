import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/microsoft-teams
// Meliwat/awesome-ios-design-md/productivity/microsoft-teams/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTeamsView: View {
    var body: some View {
        LpspTeamsShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTeamsFonts {
    static let teamsTitleLarge = Font.system(size: 28, weight: .regular)
    static let teamsSection    = Font.system(size: 20, weight: .regular)
    static let teamsTeamName   = Font.system(size: 16, weight: .regular)
    static let teamsListTitle  = Font.system(size: 16, weight: .regular)
    static let teamsAuthor     = Font.system(size: 15, weight: .regular)
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

fileprivate struct LpspTeamsTeam: Identifiable { let id = UUID(); let name: String; let channels: [LpspTeamsChannel] }
fileprivate struct LpspTeamsChannel: Identifiable { let id = UUID(); let name: String; var unread: Bool }

fileprivate struct LpspTeamsTeamTreeRow: View {
    let team: LpspTeamsTeam
    @State private var expanded = true
    @Binding var activeChannel: UUID?
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        VStack(spacing: 0) {
            Button { withAnimation(.easeInOut(duration: 0.2)) { expanded.toggle() } } label: {
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTeamsTokens.teamsPurpleLight.opacity(0.3))
                        .frame(width: 32, height: 32)
                        .overlay(Text(String(team.name.prefix(1))).font(LpspTeamsFonts.teamsSys(14, weight: .bold)))
                    Text(team.name).font(LpspTeamsFonts.teamsTeamName)
                        .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText1, LpspTeamsTokens.teamsDarkText1, scheme))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(LpspTeamsTokens.teams(LpspTeamsTokens.teamsLightText2, LpspTeamsTokens.teamsDarkText2, scheme))
                        .rotationEffect(.degrees(expanded ? 90 : 0))
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
            }

            if expanded {
                ForEach(team.channels) { ch in
                    LpspTeamsChannelRow(channel: ch, isActive: activeChannel == ch.id)
                        .onTapGesture { activeChannel = ch.id }
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
                Circle().fill(LpspTeamsTokens.teamsPurpleLight).frame(width: 8, height: 8)
            }
        }
        .padding(.leading, 44)
        .padding(.trailing, 16)
        .frame(height: 44)
        .background(isActive ? LpspTeamsTokens.teamsPurpleLight.opacity(0.12) : .clear)
        .overlay(alignment: .leading) {
            if isActive { Rectangle().fill(LpspTeamsTokens.teamsPurpleLight).frame(width: 3) }
        }
    }
}

fileprivate struct LpspTeamsMessageCard: View {
    let author: String
    let initials: String
    let presence: LpspTeamsPresence
    let timestamp: String
    let postText: String
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

                HStack(spacing: 6) {
                    LpspTeamsReactionChip(emoji: "👍", count: 3, mine: true)
                    LpspTeamsReactionChip(emoji: "❤️", count: 1, mine: false)
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



// MARK: - Écrans showroom

private struct LpspTeamsShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspTeamsSpectrHomeTabScreen()
                .tabItem { Label("Activity", systemImage: "bell.fill") }
                .tag(0)
            LpspTeamsMeetingsTabScreen(title: "Chat", tabIndex: 1)
                .tabItem { Label("Chat", systemImage: "bubble.left.and.bubble.right.fill") }
                .tag(1)
            LpspTeamsMeetingsTabScreen(title: "Teams", tabIndex: 2)
                .tabItem { Label("Teams", systemImage: "person.3.fill") }
                .tag(2)
            LpspTeamsMeetingsTabScreen(title: "Calendar", tabIndex: 3)
                .tabItem { Label("Calendar", systemImage: "calendar") }
                .tag(3)
            LpspTeamsMeetingsTabScreen(title: "Calls", tabIndex: 4)
                .tabItem { Label("Calls", systemImage: "phone.fill") }
                .tag(4)
        }
        .tint(LpspTeamsTokens.teamsPurpleLight)
        
    }
}


private struct LpspTeamsGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTeamsTokens.teamsPurpleLight.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspTeamsTokens.teamsPurpleLight))
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



private enum LpspTeamsDemoChannel {
    static let general = LpspTeamsChannel(name: "general", unread: false)
}

private struct LpspTeamsDemoParticipant { let name: String; let isMuted: Bool; let isSpeaking: Bool }
private enum LpspTeamsDemoParticipants {
    static let items: [LpspTeamsDemoParticipant] = [
        .init(name: "Alex", isMuted: false, isSpeaking: true),
        .init(name: "Léa", isMuted: true, isSpeaking: false),
    ]
}

private struct LpspTeamsMeetingsListTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView { VStack(spacing: 8) { 
                    ForEach(0..<3, id: \.self) { i in HStack { Text("10:00"); Text("Réunion \(i+1)") }.padding(.horizontal) }
 } }
            .background(LpspTeamsTokens.teamsLightCanvas.ignoresSafeArea())
            .navigationTitle("Meetings")
        }
    }
}

private struct LpspTeamsMeetingsChatTabScreen: View {
    var body: some View {
        NavigationStack {
            
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        LpspTeamsChannelRow(channel: LpspTeamsDemoChannel.general, isActive: true)
                        LpspTeamsMessageCard(author: "Alex", initials: "AM", presence: .available, timestamp: "10:24", postText: "Showroom prêt !", replyCount: 3)
                    }
                }

            .navigationTitle("Chat")
        }
    }
}

private struct LpspTeamsMeetingsMailTabScreen: View {
    var body: some View { NavigationStack { List(["Inbox", "Sent"], id: \.self) { Label($0, systemImage: "envelope") } .navigationTitle("Mail") } }
}

private struct LpspTeamsMeetingsPhoneTabScreen: View {
    var body: some View { NavigationStack { List(["Alex Martin", "Léa Dupont"], id: \.self) { Label($0, systemImage: "phone") } .navigationTitle("Phone") } }
}

private struct LpspTeamsMeetingsMoreTabScreen: View {
    var body: some View { NavigationStack { List(["Settings", "Help"], id: \.self) { Label($0, systemImage: "gearshape") } .navigationTitle("More") } }
}

private struct LpspTeamsMeetingsTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if low.contains("meeting") || low.contains("video") || tabIndex == 0 { LpspTeamsMeetingsListTabScreen() }
        else if low.contains("chat") || low.contains("team") { LpspTeamsMeetingsChatTabScreen() }
        else if low.contains("mail") { LpspTeamsMeetingsMailTabScreen() }
        else if low.contains("phone") { LpspTeamsMeetingsPhoneTabScreen() }
        else { LpspTeamsMeetingsMoreTabScreen() }
    }
}


private struct LpspTeamsSpectrHomeTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
        HStack {
                Text("YA").font(.system(size: 14))
                Text("Teams").font(.system(size: 20.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        } .padding(.horizontal, 16).frame(height: 48)
            Text("Weekly Sync · in progress").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Join").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("DG").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Design Guild").font(.system(size: 16.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("#").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("general").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("#").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("design-crit").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("#").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("handoff").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("EN").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Engineering").font(.system(size: 16.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("#").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("releases").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("#").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("incidents").font(.system(size: 16.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("PA").font(.system(size: 14))
                        Text("Priya Anand").font(.system(size: 15.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("10:42 AM").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("Pushed the build — can someone review the redirect fix?").font(.system(size: 15.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("👍 3").font(.system(size: 12.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                        Text("❤️ 1").font(.system(size: 12.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("💬 3 replies · Last reply 2h ago").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        }
        .background(Color(red: 0.122, green: 0.122, blue: 0.122).ignoresSafeArea())
    }
}



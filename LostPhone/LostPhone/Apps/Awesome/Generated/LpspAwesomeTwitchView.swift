import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/twitch
// Meliwat/awesome-ios-design-md/video/twitch/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTwitchView: View {
    var body: some View {
        LpspTwitchShowroomRoot(store: LpspTwitchStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTwitchFonts {
    static let twitchTitleLarge   = Font.system(size: 28, weight: .regular)
    static let twitchChannelName  = Font.system(size: 22, weight: .regular)
    static let twitchSectionHeader = Font.system(size: 20, weight: .regular)
    static let twitchStreamTitle  = Font.system(size: 16, weight: .regular)
    static let twitchChannelLabel = Font.system(size: 15, weight: .regular)
    static let twitchBody         = Font.system(size: 15, weight: .regular)
    static let twitchChatMessage  = Font.system(size: 14, weight: .regular)
    static let twitchChatUsername = Font.system(size: 14, weight: .regular)
    static let twitchMeta         = Font.system(size: 13, weight: .regular)
    static let twitchCardSubtitle = Font.system(size: 12, weight: .regular)
    static let twitchLabelUpper   = Font.system(size: 11, weight: .regular)
    static let twitchButton       = Font.system(size: 15, weight: .regular)
    static let twitchButtonSecondary = Font.system(size: 14, weight: .regular)
    static let twitchTab          = Font.system(size: 10, weight: .regular)
    static let twitchBadge        = Font.system(size: 11, weight: .regular)
    static func twitch(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspTwitchTokens {
    // MARK: - Canvas & Surfaces
    static let twitchCanvas    = Color(red: 0.055, green: 0.055, blue: 0.063) // #0E0E10
    static let twitchDeepBlack = Color.black                                  // #000000
    static let twitchSurface1  = Color(red: 0.094, green: 0.094, blue: 0.106) // #18181B
    static let twitchSurface2  = Color(red: 0.122, green: 0.122, blue: 0.137) // #1F1F23
    static let twitchSurface3  = Color(red: 0.165, green: 0.165, blue: 0.176) // #2A2A2D
    static let twitchDivider   = Color(red: 0.165, green: 0.165, blue: 0.176) // #2A2A2D

    // MARK: - Text
    static let twitchTextPrimary   = Color(red: 0.937, green: 0.937, blue: 0.945) // #EFEFF1
    static let twitchTextSecondary = Color(red: 0.678, green: 0.678, blue: 0.722) // #ADADB8
    static let twitchTextTertiary  = Color(red: 0.435, green: 0.435, blue: 0.482) // #6F6F7B

    // MARK: - Brand & Liveness
    static let twitchPurple        = Color(red: 0.569, green: 0.275, blue: 1.000) // #9146FF
    static let twitchPurplePressed = Color(red: 0.467, green: 0.173, blue: 0.910) // #772CE8
    static let twitchLiveRed       = Color(red: 0.922, green: 0.016, blue: 0.000) // #EB0400
    static let twitchLiveRedPressed = Color(red: 0.761, green: 0.012, blue: 0.000) // #C20300
    static let twitchOnlineGreen   = Color(red: 0.000, green: 0.757, blue: 0.431) // #00C16E
}





fileprivate struct LpspTwitchTwitchFollowButton: View {
    @Binding var isFollowing: Bool
    var subscribe: Bool = false   // true = Subscribe styling

    var body: some View {
        Button {
            isFollowing.toggle()
        } label: {
            HStack(spacing: 6) {
                Image(systemName: isFollowing ? "checkmark" : (subscribe ? "star.fill" : "heart.fill"))
                    .font(.system(size: 14, weight: .bold))
                Text(isFollowing ? (subscribe ? "Subscribed" : "Following")
                                  : (subscribe ? "Subscribe" : "Follow"))
                    .font(isFollowing ? LpspTwitchFonts.twitchButtonSecondary : LpspTwitchFonts.twitchButton)
                    .tracking(isFollowing ? 0 : 0.2)
            }
            .foregroundStyle(isFollowing ? LpspTwitchTokens.twitchTextPrimary : .white)
            .padding(.horizontal, 16)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(isFollowing ? LpspTwitchTokens.twitchSurface2 : LpspTwitchTokens.twitchPurple)
            )
            .shadow(color: isFollowing ? .clear : LpspTwitchTokens.twitchPurple.opacity(0.35), radius: 18, y: 6)
        }
        .sensoryFeedback(.impact(weight: .light), trigger: isFollowing)
        .buttonStyle(LpspTwitchTwitchPressableStyle(pressedScale: 0.97))
    }
}

fileprivate struct LpspTwitchTwitchPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspTwitchTwitchLivePill: View {
    @State private var pulse = false
    var body: some View {
        HStack(spacing: 5) {
            Circle().fill(.white).frame(width: 6, height: 6)
                .scaleEffect(pulse ? 0.6 : 1)
                .opacity(pulse ? 0.5 : 1)
                .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: pulse)
            Text("LIVE").font(LpspTwitchFonts.twitchBadge).tracking(0.4)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .frame(height: 22)
        .background(RoundedRectangle(cornerRadius: 4).fill(LpspTwitchTokens.twitchLiveRed))
        .onAppear { pulse = true }
    }
}

fileprivate struct LpspTwitchTwitchViewerPill: View {
    let count: String   // e.g. "12.4K"
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "person.fill").font(.system(size: 9, weight: .bold))
            Text(count).font(LpspTwitchFonts.twitchBadge)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .frame(height: 22)
        .background(RoundedRectangle(cornerRadius: 4).fill(.black.opacity(0.6)))
    }
}

fileprivate struct LpspTwitchTwitchLiveCard: View {
    let title: String
    let channel: String
    let game: String
    let viewers: String
    let accent: Color
    let width: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [accent.opacity(0.8), accent.opacity(0.35)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .aspectRatio(16/9, contentMode: .fill)
                    .frame(width: width, height: width * 9/16)
                    .overlay(Image(systemName: "play.fill").font(.system(size: 28)).foregroundStyle(.white.opacity(0.5)))
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                LpspTwitchTwitchLivePill().padding(8)

                VStack {
                    Spacer()
                    HStack {
                        LpspTwitchTwitchViewerPill(count: viewers)
                        Spacer()
                    }
                }
                .padding(8)
            }
            HStack(alignment: .top, spacing: 8) {
                Circle()
                    .fill(accent.opacity(0.6))
                    .frame(width: 32, height: 32)
                    .overlay(Text(String(channel.prefix(1)).uppercased()).font(.system(size: 12, weight: .bold)).foregroundStyle(.white))
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(LpspTwitchFonts.twitchStreamTitle.weight(.semibold))
                        .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                        .lineLimit(2)
                    Text(channel)
                        .font(LpspTwitchFonts.twitchMeta)
                        .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                    Text(game)
                        .font(LpspTwitchFonts.twitchCardSubtitle)
                        .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                }
            }
        }
        .frame(width: width)
    }
}

fileprivate struct LpspTwitchTwitchChatRow: View {
    let username: String
    let userColor: Color
    let message: String
    var mentioned: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            (Text(username + " ").font(LpspTwitchFonts.twitchChatUsername).foregroundColor(userColor)
             + Text(message).font(LpspTwitchFonts.twitchChatMessage).foregroundColor(LpspTwitchTokens.twitchTextPrimary))
            .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 12)
        .background(
            mentioned
            ? LpspTwitchTokens.twitchPurple.opacity(0.20)
                .overlay(Rectangle().fill(LpspTwitchTokens.twitchPurple).frame(width: 2), alignment: .leading)
            : nil
        )
    }
}

fileprivate struct LpspTwitchTwitchAvatarRing: View {
    let avatar: Image
    let isLive: Bool
    var size: CGFloat = 44
    var body: some View {
        avatar
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(isLive ? LpspTwitchTokens.twitchLiveRed : LpspTwitchTokens.twitchPurple, lineWidth: 2))
            .padding(2)
    }
}

fileprivate struct LpspTwitchTwitchTheaterChatOverlay: View {
    let messages: [LpspTwitchChatLine]
    @Binding var chatHidden: Bool
    @Binding var composeText: String
    let onSend: () -> Void

    var body: some View {
        if !chatHidden {
            VStack(spacing: 0) {
                Text("STREAM CHAT")
                    .font(LpspTwitchFonts.twitchLabelUpper.weight(.bold))
                    .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.top, 10)

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(messages) { m in
                            LpspTwitchTwitchChatRow(
                                username: m.user,
                                userColor: m.color,
                                message: m.text,
                                mentioned: m.mentionsMe
                            )
                        }
                    }
                }

                HStack(spacing: 8) {
                    TextField("Send a message", text: $composeText)
                        .font(LpspTwitchFonts.twitchChatMessage)
                        .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                        .onSubmit(onSend)
                    Button(action: onSend) {
                        Image(systemName: "paperplane.fill")
                            .foregroundStyle(LpspTwitchTokens.twitchPurple)
                    }
                }
                .padding(12)
                .background(LpspTwitchTokens.twitchSurface2)
            }
            .frame(width: min(320, UIScreen.main.bounds.width * 0.42))
            .background(.ultraThinMaterial)
            .background(LpspTwitchTokens.twitchCanvas.opacity(0.72))
            .transition(.move(edge: .trailing).combined(with: .opacity))
        }
    }
}

fileprivate struct LpspTwitchChatLine: Identifiable {
    let id: String
    let user: String
    let text: String
    let color: Color
    var mentionsMe: Bool = false
}


// MARK: - Données & état (showroom Spectr)

private enum LpspTwitchShowroomTab: String, CaseIterable, Identifiable {
    case following
    case browse
    case search
    case notifications
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .following: return "Following"
        case .browse: return "Browse"
        case .search: return "Search"
        case .notifications: return "Notifications"
        case .profile: return "Profile"
        }
    }

    var systemImage: String {
        switch self {
        case .following: return "heart.fill"
        case .browse: return "square.grid.2x2.fill"
        case .search: return "magnifyingglass"
        case .notifications: return "bell.fill"
        case .profile: return "person.fill"
        }
    }
}

fileprivate struct LpspTwitchStream: Identifiable, Equatable {
    let id: String
    let channel: String
    let title: String
    let category: String
    let viewers: String
    let isLive: Bool
    let accent: Color
}

fileprivate struct LpspTwitchChatMessage: Identifiable, Equatable {
    let id: String
    let username: String
    let body: String
    let color: Color
    var mentionsMe: Bool = false
}

private enum LpspTwitchShowroomData {
    static let featuredStreamID = "novaplays"

    static let streams: [LpspTwitchStream] = [
        .init(
            id: "novaplays",
            channel: "novaplays",
            title: "Late-night hangout — ask me anything",
            category: "Just Chatting",
            viewers: "12.4K",
            isLive: true,
            accent: LpspTwitchTokens.twitchPurple
        ),
        .init(
            id: "pixelgremlin",
            channel: "pixelgremlin",
            title: "Indie roguelike marathon",
            category: "Roguelike",
            viewers: "3.2K",
            isLive: true,
            accent: Color(red: 0.35, green: 0.72, blue: 0.55)
        ),
        .init(
            id: "harborwave",
            channel: "harborwave",
            title: "Synthwave production stream",
            category: "Music",
            viewers: "1.8K",
            isLive: true,
            accent: Color(red: 0.22, green: 0.48, blue: 0.92)
        ),
        .init(
            id: "kellen_v",
            channel: "kellen_v",
            title: "Ranked ladder grind",
            category: "League of Legends",
            viewers: "8.7K",
            isLive: true,
            accent: Color(red: 0.88, green: 0.42, blue: 0.18)
        ),
        .init(
            id: "hana.r",
            channel: "hana.r",
            title: "Watercolor + chill",
            category: "Art",
            viewers: "942",
            isLive: true,
            accent: Color(red: 0.92, green: 0.45, blue: 0.62)
        ),
        .init(
            id: "drift_",
            channel: "drift_",
            title: "IRL city walk",
            category: "IRL",
            viewers: "2.1K",
            isLive: true,
            accent: Color(red: 0.55, green: 0.62, blue: 0.78)
        ),
    ]

    static let initialChat: [LpspTwitchChatMessage] = [
        .init(id: "c1", username: "pixelgremlin", body: "yo novaplays you still awake??", color: Color(red: 0.35, green: 0.72, blue: 0.55)),
        .init(id: "c2", username: "harborwave", body: "the vibes tonight are immaculate", color: Color(red: 0.22, green: 0.48, blue: 0.92)),
        .init(id: "c3", username: "modbot", body: "Be kind in chat — mods are watching.", color: LpspTwitchTokens.twitchOnlineGreen),
        .init(id: "c4", username: "kellen_v", body: "subbed with prime, worth it", color: Color(red: 0.88, green: 0.42, blue: 0.18)),
        .init(id: "c5", username: "hana.r", body: "painting while listening, love this", color: Color(red: 0.92, green: 0.45, blue: 0.62)),
        .init(id: "c6", username: "drift_", body: "walking home, tuned in on mobile", color: Color(red: 0.55, green: 0.62, blue: 0.78)),
    ]

    static let searchSuggestions = [
        "Just Chatting",
        "League of Legends",
        "Music",
        "Art",
        "IRL",
        "Roguelike",
    ]

    static let notifications: [(title: String, detail: String, time: String)] = [
        ("novaplays is live", "Late-night hangout — ask me anything", "2m"),
        ("kellen_v is live", "Ranked ladder grind", "18m"),
        ("New follower", "pixelgremlin followed you", "1h"),
    ]
}

@MainActor
fileprivate final class LpspTwitchStore: ObservableObject {
    @Published var selectedTab: LpspTwitchShowroomTab = .following
    @Published var activeStreamID: String
    @Published var chatMessages: [LpspTwitchChatMessage]
    @Published var composeText = ""
    @Published var isFollowingFeatured = false
    @Published var chatHidden = false
    @Published var searchQuery = ""

    let streams = LpspTwitchShowroomData.streams

    init() {
        activeStreamID = LpspTwitchShowroomData.featuredStreamID
        chatMessages = LpspTwitchShowroomData.initialChat
    }

    var activeStream: LpspTwitchStream {
        streams.first { $0.id == activeStreamID } ?? streams[0]
    }

    var liveStreams: [LpspTwitchStream] {
        streams.filter(\.isLive)
    }

    var chatLines: [LpspTwitchChatLine] {
        chatMessages.map {
            LpspTwitchChatLine(
                id: $0.id,
                user: $0.username,
                text: $0.body,
                color: $0.color,
                mentionsMe: $0.mentionsMe
            )
        }
    }

    func selectStream(_ stream: LpspTwitchStream) {
        activeStreamID = stream.id
        selectedTab = .following
    }

    func sendChat() {
        let trimmed = composeText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        chatMessages.append(
            LpspTwitchChatMessage(
                id: "user-\(chatMessages.count + 1)",
                username: "you",
                body: trimmed,
                color: LpspTwitchTokens.twitchPurple
            )
        )
        composeText = ""
    }
}

// MARK: - Écrans showroom

private struct LpspTwitchShowroomRoot: View {
    @ObservedObject var store: LpspTwitchStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspTwitchShowroomTab.allCases) { tab in
                LpspTwitchShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .tint(LpspTwitchTokens.twitchPurple)
        .preferredColorScheme(.dark)
    }
}

private struct LpspTwitchShowroomTabScreen: View {
    @ObservedObject var store: LpspTwitchStore
    let tab: LpspTwitchShowroomTab

    var body: some View {
        NavigationStack {
            Group {
                switch tab {
                case .following:
                    LpspTwitchFollowingTabScreen(store: store)
                case .browse:
                    LpspTwitchBrowseTabScreen(store: store)
                case .search:
                    LpspTwitchSearchTabScreen(store: store)
                case .notifications:
                    LpspTwitchNotificationsTabScreen()
                case .profile:
                    LpspTwitchProfileTabScreen()
                }
            }
            .navigationTitle(tab == .following ? "" : tab.title)
            .navigationBarTitleDisplayMode(tab == .following ? .inline : .large)
            .background(LpspTwitchTokens.twitchCanvas.ignoresSafeArea())
        }
    }
}

private struct LpspTwitchFollowingTabScreen: View {
    @ObservedObject var store: LpspTwitchStore

    var body: some View {
        LpspTwitchPlayerScreen(store: store)
    }
}

private struct LpspTwitchPlayerScreen: View {
    @ObservedObject var store: LpspTwitchStore

    private var stream: LpspTwitchStream { store.activeStream }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .trailing) {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    stream.accent.opacity(0.45),
                                    LpspTwitchTokens.twitchCanvas,
                                    LpspTwitchTokens.twitchDeepBlack,
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                        .overlay {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 52))
                                .foregroundStyle(LpspTwitchTokens.twitchTextPrimary.opacity(0.45))
                        }

                    if stream.isLive {
                        LpspTwitchTwitchLivePill()
                            .padding(12)
                    }

                    VStack {
                        Spacer()
                        HStack {
                            LpspTwitchTwitchViewerPill(count: stream.viewers)
                            Spacer()
                        }
                    }
                    .padding(12)
                }

                LpspTwitchTwitchTheaterChatOverlay(
                    messages: store.chatLines,
                    chatHidden: $store.chatHidden,
                    composeText: $store.composeText,
                    onSend: { store.sendChat() }
                )
                .padding(.trailing, 8)
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 12) {
                    Circle()
                        .fill(stream.accent.opacity(0.55))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text(String(stream.channel.prefix(1)).uppercased())
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .overlay(
                            Circle()
                                .stroke(
                                    stream.isLive ? LpspTwitchTokens.twitchLiveRed : LpspTwitchTokens.twitchPurple,
                                    lineWidth: 2
                                )
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text(stream.channel)
                            .font(LpspTwitchFonts.twitchChannelName.weight(.bold))
                            .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                        Text(stream.title)
                            .font(LpspTwitchFonts.twitchStreamTitle)
                            .foregroundStyle(LpspTwitchTokens.twitchTextPrimary.opacity(0.9))
                            .lineLimit(2)
                        Text("\(stream.category) · \(stream.viewers) viewers")
                            .font(LpspTwitchFonts.twitchMeta)
                            .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                    }

                    Spacer(minLength: 8)

                    LpspTwitchTwitchFollowButton(isFollowing: $store.isFollowingFeatured)
                }
                .padding(.horizontal, 16)
                .padding(.top, 14)
            }

            Spacer(minLength: 0)
        }
    }
}

private struct LpspTwitchBrowseTabScreen: View {
    @ObservedObject var store: LpspTwitchStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Live channels")
                    .font(LpspTwitchFonts.twitchSectionHeader.weight(.semibold))
                    .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(store.liveStreams) { stream in
                            Button {
                                store.selectStream(stream)
                            } label: {
                                LpspTwitchTwitchLiveCard(
                                    title: stream.title,
                                    channel: stream.channel,
                                    game: stream.category,
                                    viewers: stream.viewers,
                                    accent: stream.accent,
                                    width: 220
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Recommended for you")
                        .font(LpspTwitchFonts.twitchSectionHeader.weight(.semibold))
                        .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)

                    ForEach(store.liveStreams) { stream in
                        Button {
                            store.selectStream(stream)
                        } label: {
                            HStack(spacing: 12) {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [stream.accent.opacity(0.75), stream.accent.opacity(0.3)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 96, height: 54)
                                    .overlay(alignment: .topLeading) {
                                        if stream.isLive {
                                            LpspTwitchTwitchLivePill()
                                                .scaleEffect(0.85)
                                                .padding(6)
                                        }
                                    }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(stream.channel)
                                        .font(LpspTwitchFonts.twitchChannelLabel.weight(.semibold))
                                        .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                                    Text(stream.title)
                                        .font(LpspTwitchFonts.twitchCardSubtitle)
                                        .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                                        .lineLimit(1)
                                    Text("\(stream.category) · \(stream.viewers) viewers")
                                        .font(LpspTwitchFonts.twitchCardSubtitle)
                                        .foregroundStyle(LpspTwitchTokens.twitchTextTertiary)
                                }
                                Spacer()
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 24)
        }
    }
}

private struct LpspTwitchSearchTabScreen: View {
    @ObservedObject var store: LpspTwitchStore

    var body: some View {
        List {
            Section {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                    TextField("Search channels, games, tags", text: $store.searchQuery)
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                }
            }

            Section("Popular categories") {
                ForEach(LpspTwitchShowroomData.searchSuggestions, id: \.self) { item in
                    Button {
                        store.searchQuery = item
                    } label: {
                        HStack {
                            Text(item)
                                .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(LpspTwitchTokens.twitchTextTertiary)
                        }
                    }
                }
            }

            if !store.searchQuery.isEmpty {
                Section("Channels") {
                    ForEach(store.liveStreams.filter {
                        $0.channel.localizedCaseInsensitiveContains(store.searchQuery)
                            || $0.category.localizedCaseInsensitiveContains(store.searchQuery)
                    }) { stream in
                        Button {
                            store.selectStream(stream)
                        } label: {
                            Text(stream.channel)
                                .foregroundStyle(LpspTwitchTokens.twitchPurple)
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspTwitchTokens.twitchCanvas.ignoresSafeArea())
    }
}

private struct LpspTwitchNotificationsTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspTwitchShowroomData.notifications, id: \.title) { note in
                HStack(alignment: .top, spacing: 12) {
                    Circle()
                        .fill(LpspTwitchTokens.twitchPurple.opacity(0.28))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "bell.fill")
                                .font(.caption)
                                .foregroundStyle(LpspTwitchTokens.twitchPurple)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(note.title)
                            .font(LpspTwitchFonts.twitchChannelLabel.weight(.semibold))
                            .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                        Text(note.detail)
                            .font(LpspTwitchFonts.twitchCardSubtitle)
                            .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                    }

                    Spacer()

                    Text(note.time)
                        .font(LpspTwitchFonts.twitchCardSubtitle)
                        .foregroundStyle(LpspTwitchTokens.twitchTextTertiary)
                }
                .listRowBackground(LpspTwitchTokens.twitchSurface1)
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspTwitchTokens.twitchCanvas.ignoresSafeArea())
    }
}

private struct LpspTwitchProfileTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Circle()
                    .fill(LpspTwitchTokens.twitchPurple.opacity(0.28))
                    .frame(width: 84, height: 84)
                    .overlay {
                        Text("Y")
                            .font(.title.weight(.bold))
                            .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
                    }
                    .overlay(
                        Circle()
                            .stroke(LpspTwitchTokens.twitchPurple, lineWidth: 2)
                    )

                Text("your_channel")
                    .font(LpspTwitchFonts.twitchTitleLarge.weight(.bold))
                    .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)

                Text("Viewer · not streaming")
                    .font(LpspTwitchFonts.twitchMeta)
                    .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)

                HStack(spacing: 22) {
                    LpspTwitchProfileStat(value: "0", label: "Followers")
                    LpspTwitchProfileStat(value: "6", label: "Following")
                    LpspTwitchProfileStat(value: "12", label: "Subs")
                }

                Button("Channel Home") {}
                    .buttonStyle(.borderedProminent)
                    .tint(LpspTwitchTokens.twitchPurple)
            }
            .padding(20)
        }
    }
}

private struct LpspTwitchProfileStat: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(LpspTwitchFonts.twitchChannelLabel.weight(.semibold))
                .foregroundStyle(LpspTwitchTokens.twitchTextPrimary)
            Text(label)
                .font(LpspTwitchFonts.twitchCardSubtitle)
                .foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
        }
    }
}



import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/video/twitch/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/twitch
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTwitchView: View {
    var body: some View {
        LpspTwitchShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
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
}

private enum LpspTwitchFonts {
    static func twitch(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private struct LpspTwitchTwitchFollowButton: View {
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
                    .font(isFollowing ? LpspTwitchTokens.twitchButtonSecondary : LpspTwitchTokens.twitchButton)
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

private struct LpspTwitchTwitchPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

private struct LpspTwitchTwitchLivePill: View {
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

private struct LpspTwitchTwitchViewerPill: View {
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

private struct LpspTwitchTwitchLiveCard: View {
    let title: String
    let channel: String
    let game: String
    let viewers: String
    let thumbnail: Image
    let avatar: Image
    let width: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                thumbnail
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fill)
                    .frame(width: width, height: width * 9/16)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                LpspTwitchTwitchLivePill().padding(8)
                VStack { Spacer()
                    HStack { LpspTwitchTwitchViewerPill(count: viewers); Spacer() }
                }.padding(8)
            }
            HStack(alignment: .top, spacing: 8) {
                avatar.resizable().frame(width: 32, height: 32).clipShape(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(LpspTwitchFonts.twitchStreamTitle).foregroundStyle(LpspTwitchTokens.twitchTextPrimary).lineLimit(2)
                    Text(channel).font(LpspTwitchFonts.twitchMeta).foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                    Text(game).font(LpspTwitchFonts.twitchCardSubtitle).foregroundStyle(LpspTwitchTokens.twitchTextSecondary)
                }
            }
        }
        .frame(width: width)
    }
}

private struct LpspTwitchTwitchChatRow: View {
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

private struct LpspTwitchTwitchAvatarRing: View {
    let avatar: Image
    let isLive: Bool
    var size: CGFloat = 44
    var body: some View {
        avatar
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().strokeBorder(isLive ? LpspTwitchTokens.twitchLiveRed : LpspTwitchTokens.twitchPurple, lineWidth: 2))
            .padding(2)
    }
}

private struct LpspTwitchTwitchTheaterChatOverlay: View {
    let messages: [ChatLine]
    @Binding var chatHidden: Bool

    var body: some View {
        if !chatHidden {
            VStack(spacing: 0) {
                ScrollView { LazyVStack(spacing: 0) {
                    ForEach(messages) { m in
                        LpspTwitchTwitchChatRow(username: m.user, userColor: m.color,
                                      message: m.text, mentioned: m.mentionsMe)
                    }
                }}
                TextField("Send a message", text: .constant(""))
                    .padding(12)
                    .background(LpspTwitchTokens.twitchSurface2)
            }
            .frame(width: 320)
            .background(.ultraThinMaterial)
            .background(LpspTwitchTokens.twitchCanvas.opacity(0.72))
            .transition(.move(edge: .trailing).combined(with: .opacity))
        }
    }
}

private struct LpspTwitchRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterialDark)
        appearance.backgroundColor = UIColor(LpspTwitchTokens.twitchCanvas).withAlphaComponent(0.94)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            FollowingView().tabItem     { Label("Following",     systemImage: "heart.fill") }
            BrowseView().tabItem        { Label("Browse",        systemImage: "play.square.stack.fill") }
            SearchView().tabItem        { Label("Search",        systemImage: "magnifyingglass") }
            NotificationsView().tabItem { Label("Notifications", systemImage: "bell.fill") }
            ProfileView().tabItem       { Label("Profile",       systemImage: "person.crop.circle.fill") }
        }
        .tint(LpspTwitchTokens.twitchPurple) // active = purple, purple is the indicator
    }
}

// MARK: - Écrans showroom

private struct LpspTwitchShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspTwitchVideoHomeTabScreen()
                .tabItem { Label("Notifications", systemImage: "bell.fill") }
                .tag(0)
        }
        .tint(LpspTwitchTokens.twitchOnlineGreen)
        .preferredColorScheme(.dark)
    }
}


private struct LpspTwitchGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTwitchTokens.twitchOnlineGreen.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspTwitchTokens.twitchOnlineGreen))
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


private struct LpspTwitchDemoProfile: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let isKids: Bool
}

private enum LpspTwitchDemoProfiles {
    static let items: [LpspTwitchDemoProfile] = [
        .init(name: "Lost Phone", color: .red, isKids: false),
        .init(name: "Enfants", color: .orange, isKids: true),
    ]
}

private struct LpspTwitchVideoHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.08, green: 0.08, blue: 0.08), Color.black],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 220)
                            .overlay(alignment: .center) {
                                Image(systemName: "play.circle.fill").font(.system(size: 56)).foregroundStyle(.white.opacity(0.9))
                            }
                        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                            .frame(height: 80)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding(.horizontal, 12)
                    Button("Lecture") {}.buttonStyle(.borderedProminent).tint(.red)
                        .padding(.horizontal, 12)
                    Text("Tendances").font(.system(size: 17, weight: .bold)).foregroundStyle(.white).padding(.horizontal, 12)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(0..<6, id: \.self) { i in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                                    .frame(width: 110, height: 165)
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .padding(.vertical, 8)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("")
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

private struct LpspTwitchProfilePickerTabScreen: View {
    var body: some View {
        LpspTwitchDemoProfilePicker()
    }
}

private struct LpspTwitchDemoProfilePicker: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Qui regarde ?").font(.system(size: 32, weight: .bold)).foregroundStyle(.white)
                ForEach(LpspTwitchDemoProfiles.items) { p in
                    VStack(spacing: 8) {
                        Circle().fill(p.color).frame(width: 72, height: 72)
                        Text(p.name).foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}



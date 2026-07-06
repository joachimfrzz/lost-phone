import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/instagram
// Meliwat/awesome-ios-design-md/social/instagram/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeInstagramView: View {
    var profile: LpspInstagramProfile?
    var dmThreads: [LpspConversation]?

    var body: some View {
        let storyProfile = profile
        let storyDMs = dmThreads?.isEmpty == false ? dmThreads : nil
        LpspInstagramShowroomRoot(
            profile: storyProfile ?? LpspInstagramShowroomData.profile,
            dmThreads: storyDMs ?? LpspInstagramShowroomData.dmThreads,
            isStoryMode: storyProfile != nil
        )
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspInstagramTokens {
    // Canvas & surfaces
    static let igCanvasLight   = Color.white
    static let igCanvasDark    = Color.black  // true #000000 for OLED
    static let igElevatedDark  = Color(red: 0.071, green: 0.071, blue: 0.071)  // #121212
    static let igSurfaceInputL = Color(red: 0.937, green: 0.937, blue: 0.937)  // #EFEFEF
    static let igSurfaceInputD = Color(red: 0.149, green: 0.149, blue: 0.149)  // #262626
    static let igDividerLight  = Color(red: 0.859, green: 0.859, blue: 0.859)  // #DBDBDB
    static let igDividerDark   = Color(red: 0.149, green: 0.149, blue: 0.149)  // #262626

    // Text
    static let igTextSecondaryL = Color(red: 0.557, green: 0.557, blue: 0.557) // #8E8E8E
    static let igTextSecondaryD = Color(red: 0.659, green: 0.659, blue: 0.659) // #A8A8A8

    // Brand
    static let igActionBlue    = Color(red: 0.000, green: 0.584, blue: 0.965) // #0095F6
    static let igActionPressed = Color(red: 0.094, green: 0.467, blue: 0.949) // #1877F2
    static let igDestructive   = Color(red: 0.929, green: 0.286, blue: 0.337) // #ED4956
    static let igLinkLight     = Color(red: 0.000, green: 0.216, blue: 0.420) // #00376B
    static let igLinkDark      = Color(red: 0.878, green: 0.945, blue: 1.0)   // #E0F1FF

    // Gradient stops (10 total — from official brand)
    static let igGradBlue       = Color(red: 0.251, green: 0.365, blue: 0.902) // #405DE6
    static let igGradPurpleBlue = Color(red: 0.345, green: 0.318, blue: 0.859) // #5851DB
    static let igGradPurple     = Color(red: 0.514, green: 0.227, blue: 0.706) // #833AB4
    static let igGradPurpleRed  = Color(red: 0.757, green: 0.208, blue: 0.518) // #C13584
    static let igGradRose       = Color(red: 0.882, green: 0.188, blue: 0.424) // #E1306C
    static let igGradRed        = Color(red: 0.992, green: 0.114, blue: 0.114) // #FD1D1D
    static let igGradRedOrange  = Color(red: 0.961, green: 0.376, blue: 0.251) // #F56040
    static let igGradOrange     = Color(red: 0.969, green: 0.467, blue: 0.216) // #F77737
    static let igGradOrangeYellow = Color(red: 0.988, green: 0.686, blue: 0.271) // #FCAF45
    static let igGradYellow     = Color(red: 1.0,   green: 0.863, blue: 0.502) // #FFDC80

    // Online / Close Friends
    static let igOnlineGreen      = Color(red: 0.471, green: 0.871, blue: 0.271) // #78DE45
    static let igCloseFriends     = Color(red: 0.184, green: 0.722, blue: 0.145) // #2FB825
}

private enum LpspInstagramGradients {
    /// The official Instagram story-ring gradient (10-stop sweep)
    static let instagramBrand = LinearGradient(
        gradient: Gradient(colors: [
            LpspInstagramTokens.igGradYellow, LpspInstagramTokens.igGradOrangeYellow, LpspInstagramTokens.igGradOrange, LpspInstagramTokens.igGradRedOrange,
            LpspInstagramTokens.igGradRed, LpspInstagramTokens.igGradRose, LpspInstagramTokens.igGradPurpleRed, LpspInstagramTokens.igGradPurple,
            LpspInstagramTokens.igGradPurpleBlue, LpspInstagramTokens.igGradBlue,
        ]),
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )

    /// Short 3-stop version often used in marketing
    static let instagramBrandShort = LinearGradient(
        colors: [LpspInstagramTokens.igGradPurple, LpspInstagramTokens.igGradRed, LpspInstagramTokens.igGradOrangeYellow],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
}

private enum LpspInstagramFonts {
    // SF Pro UI
    static let igScreenTitle    = Font.system(size: 16, weight: .semibold)
    static let igUsernameLarge  = Font.system(size: 20, weight: .bold)
    static let igUsername       = Font.system(size: 14, weight: .semibold)
    static let igBio            = Font.system(size: 14, weight: .regular)
    static let igCaption        = Font.system(size: 14, weight: .regular)
    static let igComment        = Font.system(size: 14, weight: .regular)
    static let igSecondaryMeta  = Font.system(size: 12, weight: .regular)
    static let igButtonPrimary  = Font.system(size: 14, weight: .semibold)
    static let igButtonSmall    = Font.system(size: 12, weight: .semibold)
    static let igCounterLarge   = Font.system(size: 16, weight: .bold)
    static let igDMBubble       = Font.system(size: 16, weight: .regular)
    static let igBadge          = Font.system(size: 11, weight: .bold)
    static let igTimestamp      = Font.system(size: 11, weight: .regular)

    /// Logotype — register Billabong or similar script font
    static let igLogotype = Font.system(size: 28, weight: .regular)
}

fileprivate struct LpspInstagramStoryRing: View {
    let avatar: Image
    let isUnread: Bool
    var size: CGFloat = 66

    var body: some View {
        ZStack {
            if isUnread {
                Circle()
                    .strokeBorder(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                LpspInstagramTokens.igGradYellow, LpspInstagramTokens.igGradOrangeYellow, LpspInstagramTokens.igGradOrange,
                                LpspInstagramTokens.igGradRed, LpspInstagramTokens.igGradRose, LpspInstagramTokens.igGradPurple, LpspInstagramTokens.igGradYellow,
                            ]),
                            center: .center
                        ),
                        lineWidth: 2.5
                    )
            } else {
                Circle()
                    .strokeBorder(LpspInstagramTokens.igDividerLight, lineWidth: 1)
            }
            avatar
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size - 8, height: size - 8)
                .clipShape(Circle())
                .overlay(Circle().stroke(LpspInstagramTokens.igCanvasLight, lineWidth: 2))
        }
        .frame(width: size, height: size)
    }
}

fileprivate struct LpspInstagramIGPrimaryButton: View {
    let title: String
    var variant: Variant = .primary
    let action: () -> Void

    enum Variant { case primary, secondary, destructive }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspInstagramFonts.igButtonPrimary)
                .foregroundStyle(fg)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 7)
                .background(RoundedRectangle(cornerRadius: 8).fill(bg))
        }
        .buttonStyle(LpspInstagramIGPressableStyle())
    }

    private var bg: Color {
        switch variant {
        case .primary:     return LpspInstagramTokens.igActionBlue
        case .secondary:   return LpspInstagramTokens.igSurfaceInputL
        case .destructive: return .clear
        }
    }
    private var fg: Color {
        switch variant {
        case .primary:     return .white
        case .secondary:   return .black
        case .destructive: return LpspInstagramTokens.igDestructive
        }
    }
}

fileprivate struct LpspInstagramIGPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspInstagramFeedPost: View {
    let username: String
    let avatar: Image
    let photo: Image
    let likes: Int
    let caption: String
    let timestamp: String
    var darkMode = false
    @State private var isLiked = false
    @State private var showHeart = false

    private var primaryText: Color { darkMode ? .white : .primary }
    private var secondaryText: Color {
        darkMode ? LpspInstagramTokens.igTextSecondaryD : LpspInstagramTokens.igTextSecondaryL
    }
    private var storyRingStroke: Color {
        darkMode ? LpspInstagramTokens.igDividerDark : LpspInstagramTokens.igDividerLight
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack(spacing: 10) {
                LpspInstagramStoryRing(avatar: avatar, isUnread: false, size: 32)
                Text(username)
                    .font(LpspInstagramFonts.igUsername)
                    .foregroundStyle(primaryText)
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundStyle(primaryText)
            }
            .frame(height: 48)
            .padding(.horizontal, 14)

            // Photo (double-tap to like)
            ZStack {
                photo
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .foregroundStyle(darkMode ? LpspInstagramTokens.igSurfaceInputD : LpspInstagramTokens.igSurfaceInputL)
                    .onTapGesture(count: 2) {
                        if !isLiked { isLiked = true }
                        showHeart = true
                        Task { try? await Task.sleep(for: .milliseconds(600)); showHeart = false }
                    }

                if showHeart {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 120))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 8)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .sensoryFeedback(.impact(weight: .light), trigger: showHeart)

            // Action bar
            HStack(spacing: 16) {
                Button { isLiked.toggle() } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundStyle(isLiked ? LpspInstagramTokens.igDestructive : primaryText)
                }
                Image(systemName: "message")
                    .foregroundStyle(primaryText)
                Image(systemName: "paperplane")
                    .foregroundStyle(primaryText)
                Spacer()
                Image(systemName: "bookmark")
                    .foregroundStyle(primaryText)
            }
            .font(.system(size: 24))
            .padding(.horizontal, 14)
            .frame(height: 48)

            // Likes + caption
            Text("\(likes) likes")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(primaryText)
                .padding(.horizontal, 14)

            (Text(username).fontWeight(.semibold) + Text(" ") + Text(caption))
                .font(LpspInstagramFonts.igCaption)
                .foregroundStyle(primaryText)
                .lineLimit(3)
                .padding(.horizontal, 14)
                .padding(.top, 4)

            Text(timestamp.uppercased())
                .font(LpspInstagramFonts.igTimestamp)
                .foregroundStyle(secondaryText)
                .tracking(0.5)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
        }
    }
}



// MARK: - Données showroom

private enum LpspInstagramShowroomData {
    static let profile = LpspInstagramProfile(
        username: "maya_c",
        bio: "Paris · golden hour walks",
        posts: [
            LpspInstagramPost(
                id: "showroom-0",
                author: "maya_c",
                caption: "golden hour on the walk home",
                date: "",
                dateParsed: nil,
                likes: 1247
            )
        ]
    )

    static let dmThreads: [LpspConversation] = []
}

// MARK: - Écrans showroom

private enum LpspInstagramTab: CaseIterable {
    case home, explore, reels, create, profile

    var label: String {
        switch self {
        case .home: "Home"
        case .explore: "Search"
        case .reels: "Reels"
        case .create: "Create"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .explore: "magnifyingglass"
        case .reels: "play.rectangle"
        case .create: "plus.app"
        case .profile: "person.circle"
        }
    }
}

private enum LpspInstagramRoute: Hashable {
    case dmInbox
    case dmThread(String)
}

private struct LpspInstagramShowroomRoot: View {
    let profile: LpspInstagramProfile
    let dmThreads: [LpspConversation]
    var isStoryMode = false
    @State private var selectedTab: LpspInstagramTab = .home
    @State private var homePath = NavigationPath()

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home:
                    LpspInstagramHomeTabScreen(
                        profile: profile,
                        dmThreads: dmThreads,
                        path: $homePath,
                        isStoryMode: isStoryMode
                    )
                case .explore:
                    LpspInstagramExploreTabScreen(isStoryMode: isStoryMode)
                case .reels:
                    LpspInstagramReelsTabScreen()
                case .create:
                    LpspInstagramCreateTabScreen(isStoryMode: isStoryMode)
                case .profile:
                    LpspInstagramProfileTabScreen(profile: profile, isStoryMode: isStoryMode)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspInstagramSpectrTabBar(selectedTab: $selectedTab)
        }
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

private struct LpspInstagramSpectrTabBar: View {
    @Binding var selectedTab: LpspInstagramTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspInstagramTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22))
                        Text(tab.label)
                            .font(.system(size: 10, weight: .regular))
                    }
                    .foregroundStyle(selectedTab == tab ? .white : LpspInstagramTokens.igTextSecondaryD)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(LpspInstagramIGPressableStyle())
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 2)
        .background(LpspInstagramTokens.igElevatedDark)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspInstagramTokens.igDividerDark)
                .frame(height: 0.5)
        }
    }
}

private struct LpspInstagramHomeTabScreen: View {
    let profile: LpspInstagramProfile
    let dmThreads: [LpspConversation]
    @Binding var path: NavigationPath
    var isStoryMode = false

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                HStack {
                    Text("Instagram")
                        .font(.custom("Snell Roundhand", size: 28))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "heart")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                    Button {
                        path.append(LpspInstagramRoute.dmInbox)
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(LpspInstagramIGPressableStyle())
                }
                .padding(.horizontal, 14)
                .padding(.top, 8)
                .padding(.bottom, 6)

                ScrollView {
                    VStack(spacing: 0) {
                        if !isStoryMode {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(LpspInstagramSpectrStoryData.items) { s in
                                        VStack(spacing: 4) {
                                            LpspInstagramStoryRing(
                                                avatar: Image(systemName: "person.circle.fill"),
                                                isUnread: s.unread,
                                                size: 56
                                            )
                                            Text(s.name)
                                                .font(.system(size: 11))
                                                .foregroundStyle(.white)
                                                .lineLimit(1)
                                                .frame(width: 56)
                                        }
                                    }
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                            }
                            .overlay(alignment: .bottom) {
                                Divider().background(LpspInstagramTokens.igDividerDark)
                            }
                        }

                        ForEach(profile.posts) { post in
                            LpspInstagramFeedPost(
                                username: post.author,
                                avatar: Image(systemName: "person.circle.fill"),
                                photo: Image(systemName: "photo"),
                                likes: post.likes,
                                caption: post.caption,
                                timestamp: LpspAdapters.formatInstagramPostTime(post),
                                darkMode: true
                            )
                        }
                    }
                }
            }
            .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
            .navigationDestination(for: LpspInstagramRoute.self) { route in
                switch route {
                case .dmInbox:
                    LpspInstagramDMInboxScreen(
                        threads: dmThreads,
                        path: $path,
                        isStoryMode: isStoryMode
                    )
                case .dmThread(let id):
                    LpspInstagramDMThreadScreen(
                        threads: dmThreads,
                        threadId: id,
                        onBack: { path.removeLast() },
                        isStoryMode: isStoryMode
                    )
                }
            }
        }
    }
}

private struct LpspInstagramDMInboxScreen: View {
    let threads: [LpspConversation]
    @Binding var path: NavigationPath
    var isStoryMode = false

    var body: some View {
        List {
            if threads.isEmpty {
                ContentUnavailableView(
                    "No messages",
                    systemImage: "paperplane",
                    description: Text("Messages you send or receive will appear here.")
                )
                .listRowBackground(Color.clear)
            } else {
                ForEach(threads) { thread in
                    Button {
                        path.append(LpspInstagramRoute.dmThread(thread.id))
                    } label: {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(LpspInstagramTokens.igActionBlue.opacity(0.25))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Text(String(thread.contactName.prefix(1)).uppercased())
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.white)
                                )
                            VStack(alignment: .leading, spacing: 4) {
                                Text(thread.contactName)
                                    .font(LpspInstagramFonts.igUsername)
                                    .foregroundStyle(.white)
                                Text(thread.preview)
                                    .font(LpspInstagramFonts.igSecondaryMeta)
                                    .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                                    .lineLimit(1)
                            }
                            Spacer()
                            if thread.isUnread {
                                Circle()
                                    .fill(LpspInstagramTokens.igActionBlue)
                                    .frame(width: 8, height: 8)
                            }
                        }
                    }
                    .listRowBackground(LpspInstagramTokens.igElevatedDark)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
        .navigationTitle("Messages")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

private struct LpspInstagramDMThreadScreen: View {
    let threads: [LpspConversation]
    let threadId: String
    let onBack: () -> Void
    var isStoryMode = false

    private var thread: LpspConversation? {
        threads.first { $0.id == threadId }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .buttonStyle(LpspInstagramIGPressableStyle())

                Circle()
                    .fill(LpspInstagramTokens.igActionBlue.opacity(0.25))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Text(String((thread?.contactName ?? "?").prefix(1)).uppercased())
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                    )

                Text(thread?.contactName ?? "")
                    .font(LpspInstagramFonts.igUsername)
                    .foregroundStyle(.white)

                Spacer()

                Image(systemName: "info.circle")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 12)
            .frame(height: 56)
            .background(LpspInstagramTokens.igElevatedDark)

            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(thread?.messages ?? []) { message in
                        HStack {
                            if message.isUser { Spacer(minLength: 48) }
                            Text(message.text)
                                .font(LpspInstagramFonts.igDMBubble)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(message.isUser
                                              ? LpspInstagramTokens.igActionBlue
                                              : LpspInstagramTokens.igSurfaceInputD)
                                )
                            if !message.isUser { Spacer(minLength: 48) }
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .padding(.vertical, 12)
            }

            if !isStoryMode {
                HStack(spacing: 10) {
                    Image(systemName: "camera")
                        .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                    Text("Message...")
                        .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                    Spacer()
                    Image(systemName: "photo")
                        .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                }
                .font(.system(size: 16))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(LpspInstagramTokens.igElevatedDark)
            }
        }
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}


private struct LpspInstagramGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspInstagramTokens.igActionBlue.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspInstagramTokens.igActionBlue))
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


private struct LpspInstagramDemoPostItem: Identifiable {
    let id = UUID()
    let user: String
    let likes: Int
    let caption: String
    let time: String
}

private enum LpspInstagramDemoPosts {
    static let items: [LpspInstagramDemoPostItem] = [
        .init(user: "lost.phone", likes: 128, caption: "Showroom Lost Phone — Paris", time: "2 H"),
        .init(user: "alex.m", likes: 42, caption: "Week-end en Bretagne", time: "5 H"),
    ]
}

private struct LpspInstagramDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspInstagramDemoStories {
    static let items: [LpspInstagramDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspInstagramFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspInstagramDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    LpspInstagramStoryRing(avatar: Image(systemName: "person.circle.fill"), isUnread: s.unread)
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(LpspInstagramDemoPosts.items) { post in
                        LpspInstagramFeedPost(
                            username: post.user,
                            avatar: Image(systemName: "person.circle.fill"),
                            photo: Image(systemName: "photo"),
                            likes: post.likes,
                            caption: post.caption,
                            timestamp: post.time
                        )
                    }

                }
            }
            .background(LpspInstagramTokens.igCanvasLight.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspInstagramExploreTabScreen: View {
    var isStoryMode = false
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            Group {
                if isStoryMode {
                    ContentUnavailableView(
                        "No posts to explore",
                        systemImage: "magnifyingglass",
                        description: Text("Suggested posts will appear here.")
                    )
                } else {
                    ScrollView {
                        LazyVGrid(columns: cols, spacing: 2) {
                            ForEach(0..<15, id: \.self) { i in
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(LpspInstagramTokens.igActionBlue.opacity(0.08 + Double(i) * 0.04))
                                    .aspectRatio(1, contentMode: .fit)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
    }
}

private struct LpspInstagramReelsTabScreen: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "play.rectangle.fill").font(.system(size: 64)).foregroundStyle(.white.opacity(0.85))
                Text("Reels").font(.title2.bold()).foregroundStyle(.white)
                Spacer()
            }
        }
    }
}

private struct LpspInstagramProfileTabScreen: View {
    let profile: LpspInstagramProfile
    var isStoryMode = false

    private var initials: String {
        String(profile.username.prefix(2)).uppercased()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle()
                        .fill(LpspInstagramGradients.instagramBrandShort)
                        .frame(width: 88, height: 88)
                        .overlay(Text(initials).font(.title.bold()).foregroundStyle(.white))
                    Text(profile.username)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                    Text(profile.bio)
                        .font(.subheadline)
                        .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    HStack(spacing: 32) {
                        VStack {
                            Text("\(profile.posts.count)").font(.headline).foregroundStyle(.white)
                            Text("posts").font(.caption).foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                        }
                        if !isStoryMode {
                            VStack {
                                Text("1.2K").font(.headline).foregroundStyle(.white)
                                Text("followers").font(.caption).foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                            }
                            VStack {
                                Text("340").font(.headline).foregroundStyle(.white)
                                Text("following").font(.caption).foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                            }
                        }
                    }
                    if !profile.posts.isEmpty {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 2) {
                            ForEach(profile.posts) { _ in
                                Rectangle()
                                    .fill(LpspInstagramTokens.igSurfaceInputD)
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay(Image(systemName: "photo").foregroundStyle(LpspInstagramTokens.igTextSecondaryD))
                            }
                        }
                        .padding(.top, 8)
                    }
                }
                .padding()
            }
            .navigationTitle("Profile")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
    }
}

private struct LpspInstagramCommunitiesTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["r/swiftui", "r/paris", "r/design"], id: \.self) { Label($0, systemImage: "person.3") }
            .navigationTitle("Communities")
        }
    }
}

private struct LpspInstagramCreateTabScreen: View {
    var isStoryMode = false
    var body: some View {
        Group {
            if isStoryMode {
                ContentUnavailableView(
                    "Create",
                    systemImage: "plus.app.fill",
                    description: Text("Share photos, reels, or stories from here.")
                )
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "plus.app.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(LpspInstagramTokens.igActionBlue)
                    Text("New post").font(.title2.bold()).foregroundStyle(.white)
                    Text("Photo, reel or story").foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
    }
}

private struct LpspInstagramSocialTabScreen: View {
    let title: String
    var body: some View {
        let low = title.lowercased()
        if low.contains("créer") || low.contains("create") { LpspInstagramCreateTabScreen() }
        else if low.contains("explor") || low.contains("search") { LpspInstagramExploreTabScreen() }
        else if low.contains("reel") { LpspInstagramReelsTabScreen() }
        else if low.contains("profil") || low.contains("profile") {
            LpspInstagramProfileTabScreen(profile: LpspInstagramShowroomData.profile)
        }
        else { LpspInstagramFeedTabScreen() }
    }
}

private struct LpspInstagramGenericFeedCard: View {
    let index: Int
    let accent: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle().fill(accent.opacity(0.2)).frame(width: 32, height: 32)
                Text("utilisateur_\(index)").font(.system(size: 14, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal, 12)
            RoundedRectangle(cornerRadius: 0).fill(accent.opacity(0.12)).frame(height: 280)
            HStack(spacing: 16) {
                Image(systemName: "heart"); Image(systemName: "bubble.right"); Spacer(); Image(systemName: "bookmark")
            }
            .font(.system(size: 22)).padding(.horizontal, 12).padding(.bottom, 12)
        }
    }
}


private struct LpspInstagramSpectrStoryItem: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspInstagramSpectrStoryData {
    static let items: [LpspInstagramSpectrStoryItem] = [
        .init(name: "Your story", unread: true),
        .init(name: "maya_c", unread: true),
        .init(name: "jordanp", unread: true),
        .init(name: "_alex", unread: false),
    ]
}

private struct LpspInstagramSpectrHomeTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Instagram").font(.custom("Snell Roundhand", size: 28)).fontWeight(.bold)
                Spacer()
                Image(systemName: "heart").font(.system(size: 22))
                Image(systemName: "paperplane").font(.system(size: 22))
            }
            .padding(.horizontal, 14).padding(.top, 8).padding(.bottom, 6)
            ScrollView {
                VStack(spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(LpspInstagramSpectrStoryData.items) { s in
                                VStack(spacing: 4) {
                                    LpspInstagramStoryRing(avatar: Image(systemName: "person.circle.fill"), isUnread: s.unread, size: 56)
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 56)
                                }
                            }
                        }
                        .padding(.horizontal, 14).padding(.vertical, 10)
                    }
                    .overlay(alignment: .bottom) { Divider().background(Color(red: 0.15, green: 0.15, blue: 0.15)) }
                    LpspInstagramFeedPost(
                        username: "maya_c",
                        avatar: Image(systemName: "person.circle.fill"),
                        photo: Image(systemName: "photo"),
                        likes: 1247,
                        caption: "golden hour on the walk home",
                        timestamp: "2 HOURS AGO"
                    )
                }
            }
        }
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}



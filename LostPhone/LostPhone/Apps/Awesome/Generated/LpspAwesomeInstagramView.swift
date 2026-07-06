import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/instagram
// Meliwat/awesome-ios-design-md/social/instagram/DESIGN-swiftui.md
struct LpspAwesomeInstagramView: View {
    var conversations: [LpspConversation]?

    var body: some View {
        let storyThreads = conversations?.isEmpty == false ? conversations : nil
        let threads = storyThreads ?? LpspInstagramShowroomData.dmThreads
        LpspInstagramShowroomRoot(
            store: LpspInstagramStore(threads: threads),
            isStoryMode: storyThreads != nil
        )
    }
}

// MARK: - Composants spec (préfixés)

private enum LpspInstagramTokens {
    static let igCanvasLight   = Color.white
    static let igCanvasDark    = Color.black
    static let igElevatedDark  = Color(red: 0.071, green: 0.071, blue: 0.071)
    static let igSurfaceInputL = Color(red: 0.937, green: 0.937, blue: 0.937)
    static let igSurfaceInputD = Color(red: 0.149, green: 0.149, blue: 0.149)
    static let igDividerLight  = Color(red: 0.859, green: 0.859, blue: 0.859)
    static let igDividerDark   = Color(red: 0.149, green: 0.149, blue: 0.149)
    static let igTextSecondaryL = Color(red: 0.557, green: 0.557, blue: 0.557)
    static let igTextSecondaryD = Color(red: 0.659, green: 0.659, blue: 0.659)
    static let igActionBlue    = Color(red: 0.000, green: 0.584, blue: 0.965)
    static let igDestructive   = Color(red: 0.929, green: 0.286, blue: 0.337)
    static let igGradYellow       = Color(red: 1.0, green: 0.863, blue: 0.502)
    static let igGradOrangeYellow = Color(red: 0.988, green: 0.686, blue: 0.271)
    static let igGradOrange       = Color(red: 0.969, green: 0.467, blue: 0.216)
    static let igGradRed          = Color(red: 0.992, green: 0.114, blue: 0.114)
    static let igGradRose         = Color(red: 0.882, green: 0.188, blue: 0.424)
    static let igGradPurple       = Color(red: 0.514, green: 0.227, blue: 0.706)
}

private enum LpspInstagramGradients {
    static let instagramBrandShort = LinearGradient(
        colors: [LpspInstagramTokens.igGradPurple, LpspInstagramTokens.igGradRed, LpspInstagramTokens.igGradOrangeYellow],
        startPoint: .bottomLeading,
        endPoint: .topTrailing
    )
}

private enum LpspInstagramFonts {
    static let igUsername       = Font.system(size: 14, weight: .semibold)
    static let igCaption        = Font.system(size: 14, weight: .regular)
    static let igSecondaryMeta  = Font.system(size: 12, weight: .regular)
    static let igDMBubble       = Font.system(size: 16, weight: .regular)
    static let igTimestamp      = Font.system(size: 11, weight: .regular)
    static let igTab            = Font.system(size: 10, weight: .regular)
}

fileprivate struct LpspInstagramStoryRing: View {
    let initials: String
    let gradient: [Color]
    let isUnread: Bool
    var size: CGFloat = 66
    var darkMode = true

    var body: some View {
        ZStack {
            if isUnread {
                Circle()
                    .strokeBorder(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                LpspInstagramTokens.igGradYellow, LpspInstagramTokens.igGradOrangeYellow,
                                LpspInstagramTokens.igGradOrange, LpspInstagramTokens.igGradRed,
                                LpspInstagramTokens.igGradRose, LpspInstagramTokens.igGradPurple,
                                LpspInstagramTokens.igGradYellow,
                            ]),
                            center: .center
                        ),
                        lineWidth: 2.5
                    )
            } else {
                Circle()
                    .strokeBorder(
                        darkMode ? LpspInstagramTokens.igDividerDark : LpspInstagramTokens.igDividerLight,
                        lineWidth: 1
                    )
            }
            Circle()
                .fill(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size - 8, height: size - 8)
                .overlay(
                    Text(initials)
                        .font(.system(size: size * 0.22, weight: .semibold))
                        .foregroundStyle(.white)
                )
                .overlay(
                    Circle().stroke(darkMode ? LpspInstagramTokens.igCanvasDark : LpspInstagramTokens.igCanvasLight, lineWidth: 2)
                )
        }
        .frame(width: size, height: size)
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
    let post: LpspInstagramShowroomPost
    @State private var isLiked: Bool
    @State private var showHeart = false

    init(post: LpspInstagramShowroomPost) {
        self.post = post
        _isLiked = State(initialValue: post.likedByDefault)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 10) {
                LpspInstagramStoryRing(
                    initials: LpspInstagramContactStyle.initials(for: post.username),
                    gradient: LpspInstagramContactStyle.gradient(for: post.username),
                    isUnread: false,
                    size: 32
                )
                Text(post.username)
                    .font(LpspInstagramFonts.igUsername)
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
            }
            .frame(height: 48)
            .padding(.horizontal, 14)

            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(
                        LinearGradient(
                            colors: [post.accent.opacity(0.55), post.accent.opacity(0.18)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .aspectRatio(1, contentMode: .fill)
                    .overlay(
                        Image(systemName: post.icon)
                            .font(.system(size: 56, weight: .light))
                            .foregroundStyle(.white.opacity(0.35))
                    )
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

            HStack(spacing: 16) {
                Button { isLiked.toggle() } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundStyle(isLiked ? LpspInstagramTokens.igDestructive : .white)
                }
                Image(systemName: "message").foregroundStyle(.white)
                Image(systemName: "paperplane").foregroundStyle(.white)
                Spacer()
                Image(systemName: "bookmark").foregroundStyle(.white)
            }
            .font(.system(size: 24))
            .padding(.horizontal, 14)
            .frame(height: 48)

            Text("\(post.likes + (isLiked && !post.likedByDefault ? 1 : 0)) likes")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)

            (Text(post.username).fontWeight(.semibold) + Text(" ") + Text(post.caption))
                .font(LpspInstagramFonts.igCaption)
                .foregroundStyle(.white)
                .lineLimit(3)
                .padding(.horizontal, 14)
                .padding(.top, 4)

            Text(post.timestamp.uppercased())
                .font(LpspInstagramFonts.igTimestamp)
                .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                .tracking(0.5)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
        }
    }
}

// MARK: - Données & état (showroom + histoire LPSP optionnelle)

fileprivate struct LpspInstagramShowroomPost: Identifiable, Hashable {
    let id: String
    let username: String
    let caption: String
    let timestamp: String
    let likes: Int
    let accent: Color
    let icon: String
    var likedByDefault = false
}

@MainActor
fileprivate final class LpspInstagramStore: ObservableObject {
    @Published private(set) var threads: [LpspConversation]
    @Published var messagesByThread: [String: [LpspMessage]]

    init(threads: [LpspConversation]) {
        self.threads = threads
        self.messagesByThread = Dictionary(
            uniqueKeysWithValues: threads.map { ($0.id, $0.messages) }
        )
    }

    func thread(id: String) -> LpspConversation? {
        threads.first { $0.id == id }
    }

    func markAsRead(threadId: String) {
        guard let index = threads.firstIndex(where: { $0.id == threadId }),
              threads[index].isUnread else { return }
        let old = threads[index]
        threads[index] = LpspConversation(
            id: old.id,
            contactName: old.contactName,
            messages: old.messages,
            isUnread: false
        )
    }

    func send(text: String, threadId: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeRaw = formatter.string(from: now)
        let message = LpspMessage(
            id: "ig-sent-\(UUID().uuidString)",
            text: trimmed,
            isUser: true,
            date: now,
            dateRaw: timeRaw
        )
        messagesByThread[threadId, default: []].append(message)

        if let index = threads.firstIndex(where: { $0.id == threadId }) {
            let old = threads[index]
            threads[index] = LpspConversation(
                id: old.id,
                contactName: old.contactName,
                messages: old.messages + [message],
                isUnread: false
            )
        }
    }
}

private enum LpspInstagramShowroomData {
    static let jordanThreadId = "ig-jordan-p"

    static let profile = LpspInstagramShowroomProfile(
        username: "maya_c",
        bio: "Paris · golden hour walks\nphotographer · lost phone demo",
        posts: 128,
        followers: "1.2K",
        following: "340"
    )

    static let stories: [LpspInstagramShowroomStory] = [
        .init(id: "story-you", name: "Your story", username: "you", unread: true, hasAddBadge: true),
        .init(id: "story-maya", name: "maya_c", username: "maya_c", unread: true),
        .init(id: "story-jordan", name: "jordanp", username: "jordanp", unread: true),
        .init(id: "story-alex", name: "_alex", username: "_alex", unread: false),
    ]

    static let feedPosts: [LpspInstagramShowroomPost] = [
        .init(
            id: "post-1",
            username: "maya_c",
            caption: "golden hour on the walk home",
            timestamp: "2 hours ago",
            likes: 1247,
            accent: Color(red: 0.95, green: 0.62, blue: 0.28),
            icon: "sun.max.fill",
            likedByDefault: false
        ),
        .init(
            id: "post-2",
            username: "jordanp",
            caption: "new pour-over spot in le marais ☕️",
            timestamp: "5 hours ago",
            likes: 318,
            accent: Color(red: 0.42, green: 0.28, blue: 0.18),
            icon: "cup.and.saucer.fill"
        ),
        .init(
            id: "post-3",
            username: "_alex",
            caption: "late night edits, early morning regrets",
            timestamp: "1 day ago",
            likes: 89,
            accent: Color(red: 0.18, green: 0.22, blue: 0.42),
            icon: "moon.stars.fill"
        ),
    ]

    static var dmThreads: [LpspConversation] {
        [
            LpspConversation(
                id: jordanThreadId,
                contactName: "Jordan P.",
                messages: jordanMessages,
                isUnread: true
            ),
            LpspConversation(
                id: "ig-alex",
                contactName: "Alex",
                messages: [
                    LpspMessage(id: "a1", text: "that reel was insane 🔥", isUser: false, date: nil, dateRaw: "Yesterday"),
                    LpspMessage(id: "a2", text: "haha thanks, shot it on the bridge", isUser: true, date: nil, dateRaw: "Yesterday"),
                    LpspMessage(id: "a3", text: "send me the LUT when you can", isUser: false, date: nil, dateRaw: "11:02 AM"),
                ],
                isUnread: false
            ),
            LpspConversation(
                id: "ig-design",
                contactName: "Design Guild",
                messages: [
                    LpspMessage(id: "d1", text: "Maya shared the IG spec thread — thoughts?", isUser: false, date: nil, dateRaw: "Mon"),
                ],
                isUnread: false
            ),
        ]
    }

    private static let jordanMessages: [LpspMessage] = [
        LpspMessage(id: "j1", text: "still down for coffee tomorrow?", isUser: false, date: nil, dateRaw: "9:14 AM"),
        LpspMessage(id: "j2", text: "yes! that place near république?", isUser: true, date: nil, dateRaw: "9:18 AM"),
        LpspMessage(id: "j3", text: "perfect. 10am work?", isUser: false, date: nil, dateRaw: "9:19 AM"),
        LpspMessage(id: "j4", text: "see you there ☕️", isUser: true, date: nil, dateRaw: "9:20 AM"),
    ]

    static let exploreTiles: [Color] = [
        Color(red: 0.25, green: 0.45, blue: 0.82),
        Color(red: 0.82, green: 0.35, blue: 0.42),
        Color(red: 0.35, green: 0.72, blue: 0.55),
        Color(red: 0.55, green: 0.38, blue: 0.78),
        Color(red: 0.92, green: 0.58, blue: 0.22),
        Color(red: 0.28, green: 0.32, blue: 0.38),
    ]

    static let reels: [LpspInstagramShowroomReel] = [
        .init(id: "reel-1", username: "maya_c", caption: "golden hour loop", accent: Color(red: 0.95, green: 0.62, blue: 0.28)),
        .init(id: "reel-2", username: "jordanp", caption: "espresso ritual", accent: Color(red: 0.42, green: 0.28, blue: 0.18)),
    ]
}

fileprivate struct LpspInstagramShowroomProfile {
    let username: String
    let bio: String
    let posts: Int
    let followers: String
    let following: String
}

fileprivate struct LpspInstagramShowroomStory: Identifiable {
    let id: String
    let name: String
    let username: String
    let unread: Bool
    var hasAddBadge = false
}

fileprivate struct LpspInstagramShowroomReel: Identifiable {
    let id: String
    let username: String
    let caption: String
    let accent: Color
}

private enum LpspInstagramContactStyle {
    static func initials(for name: String) -> String {
        let cleaned = name.filter { $0.isLetter || $0.isWhitespace || $0 == "_" }
        let parts = cleaned.replacingOccurrences(of: "_", with: " ").split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        }
        return String(cleaned.filter { $0.isLetter }.prefix(2)).uppercased()
    }

    static func gradient(for username: String) -> [Color] {
        switch username.lowercased() {
        case "maya_c":
            return [Color(red: 0.95, green: 0.55, blue: 0.35), Color(red: 0.82, green: 0.28, blue: 0.48)]
        case "jordanp":
            return [Color(red: 0.35, green: 0.55, blue: 0.95), Color(red: 0.22, green: 0.35, blue: 0.78)]
        case "_alex", "alex":
            return [Color(red: 0.45, green: 0.75, blue: 0.55), Color(red: 0.22, green: 0.52, blue: 0.42)]
        default:
            return [Color(red: 0.35, green: 0.38, blue: 0.45), Color(red: 0.22, green: 0.24, blue: 0.30)]
        }
    }

    static func listTimestamp(for thread: LpspConversation) -> String {
        thread.lastDateRaw ?? thread.messages.last?.dateRaw ?? ""
    }
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
    @ObservedObject var store: LpspInstagramStore
    var isStoryMode = false
    @State private var selectedTab: LpspInstagramTab = .home
    @State private var homePath = NavigationPath()

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home:
                    LpspInstagramHomeTabScreen(store: store, path: $homePath)
                case .explore:
                    LpspInstagramExploreTabScreen()
                case .reels:
                    LpspInstagramReelsTabScreen()
                case .create:
                    LpspInstagramCreateTabScreen()
                case .profile:
                    LpspInstagramProfileTabScreen()
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
                            .font(LpspInstagramFonts.igTab)
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
    @ObservedObject var store: LpspInstagramStore
    @Binding var path: NavigationPath

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
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "paperplane")
                                .font(.system(size: 22))
                                .foregroundStyle(.white)
                            if store.threads.contains(where: \.isUnread) {
                                Circle()
                                    .fill(LpspInstagramTokens.igDestructive)
                                    .frame(width: 8, height: 8)
                                    .offset(x: 4, y: -4)
                            }
                        }
                    }
                    .buttonStyle(LpspInstagramIGPressableStyle())
                }
                .padding(.horizontal, 14)
                .padding(.top, 8)
                .padding(.bottom, 6)

                ScrollView {
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(LpspInstagramShowroomData.stories) { story in
                                    VStack(spacing: 4) {
                                        ZStack(alignment: .bottomTrailing) {
                                            LpspInstagramStoryRing(
                                                initials: story.hasAddBadge
                                                    ? "+"
                                                    : LpspInstagramContactStyle.initials(for: story.username),
                                                gradient: story.hasAddBadge
                                                    ? [LpspInstagramTokens.igSurfaceInputD, LpspInstagramTokens.igElevatedDark]
                                                    : LpspInstagramContactStyle.gradient(for: story.username),
                                                isUnread: story.unread,
                                                size: 56
                                            )
                                            if story.hasAddBadge {
                                                Image(systemName: "plus.circle.fill")
                                                    .font(.system(size: 16))
                                                    .foregroundStyle(LpspInstagramTokens.igActionBlue)
                                                    .background(Circle().fill(LpspInstagramTokens.igCanvasDark).padding(2))
                                                    .offset(x: 2, y: 2)
                                            }
                                        }
                                        Text(story.name)
                                            .font(.system(size: 11))
                                            .foregroundStyle(.white)
                                            .lineLimit(1)
                                            .frame(width: 64)
                                    }
                                }
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                        }
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(LpspInstagramTokens.igDividerDark)
                                .frame(height: 0.5)
                        }

                        ForEach(LpspInstagramShowroomData.feedPosts) { post in
                            LpspInstagramFeedPost(post: post)
                        }
                    }
                }
            }
            .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
            .navigationDestination(for: LpspInstagramRoute.self) { route in
                switch route {
                case .dmInbox:
                    LpspInstagramDMInboxScreen(store: store, path: $path)
                case .dmThread(let id):
                    LpspInstagramDMThreadScreen(store: store, threadId: id, onBack: { path.removeLast() })
                }
            }
        }
    }
}

private struct LpspInstagramDMInboxScreen: View {
    @ObservedObject var store: LpspInstagramStore
    @Binding var path: NavigationPath

    var body: some View {
        List {
            ForEach(store.threads) { thread in
                Button {
                    path.append(LpspInstagramRoute.dmThread(thread.id))
                } label: {
                    HStack(spacing: 12) {
                        LpspInstagramStoryRing(
                            initials: LpspInstagramContactStyle.initials(for: thread.contactName),
                            gradient: LpspInstagramContactStyle.gradient(for: thread.contactName),
                            isUnread: false,
                            size: 48
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
                        VStack(alignment: .trailing, spacing: 6) {
                            Text(LpspInstagramContactStyle.listTimestamp(for: thread))
                                .font(.system(size: 11))
                                .foregroundStyle(thread.isUnread ? LpspInstagramTokens.igActionBlue : LpspInstagramTokens.igTextSecondaryD)
                            if thread.isUnread {
                                Circle()
                                    .fill(LpspInstagramTokens.igActionBlue)
                                    .frame(width: 8, height: 8)
                            }
                        }
                    }
                }
                .listRowBackground(LpspInstagramTokens.igElevatedDark)
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
    @ObservedObject var store: LpspInstagramStore
    let threadId: String
    let onBack: () -> Void

    @State private var draft = ""
    @FocusState private var inputFocused: Bool

    private var thread: LpspConversation? { store.thread(id: threadId) }
    private var messages: [LpspMessage] { store.messagesByThread[threadId] ?? [] }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .buttonStyle(LpspInstagramIGPressableStyle())

                if let thread {
                    LpspInstagramStoryRing(
                        initials: LpspInstagramContactStyle.initials(for: thread.contactName),
                        gradient: LpspInstagramContactStyle.gradient(for: thread.contactName),
                        isUnread: false,
                        size: 32
                    )
                    Text(thread.contactName)
                        .font(LpspInstagramFonts.igUsername)
                        .foregroundStyle(.white)
                }

                Spacer()

                Image(systemName: "info.circle")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 12)
            .frame(height: 56)
            .background(LpspInstagramTokens.igElevatedDark)

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(messages) { message in
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
                                    .id(message.id)
                                if !message.isUser { Spacer(minLength: 48) }
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                    .padding(.vertical, 12)
                }
                .onChange(of: messages.count) { _, _ in
                    if let last = messages.last {
                        withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    }
                }
            }

            HStack(spacing: 10) {
                Image(systemName: "camera")
                    .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                TextField("Message...", text: $draft)
                    .foregroundStyle(.white)
                    .focused($inputFocused)
                if draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Image(systemName: "photo")
                        .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                    Image(systemName: "mic")
                        .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                } else {
                    Button {
                        store.send(text: draft, threadId: threadId)
                        draft = ""
                    } label: {
                        Text("Send")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(LpspInstagramTokens.igActionBlue)
                    }
                    .buttonStyle(LpspInstagramIGPressableStyle())
                }
            }
            .font(.system(size: 16))
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(LpspInstagramTokens.igElevatedDark)
        }
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
        .navigationBarHidden(true)
        .onAppear { store.markAsRead(threadId: threadId) }
    }
}

private struct LpspInstagramExploreTabScreen: View {
    let cols = [GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<18, id: \.self) { i in
                        let color = LpspInstagramShowroomData.exploreTiles[i % LpspInstagramShowroomData.exploreTiles.count]
                        RoundedRectangle(cornerRadius: 2)
                            .fill(color.opacity(0.35 + Double(i % 3) * 0.12))
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(
                                Image(systemName: i % 4 == 0 ? "play.fill" : "photo")
                                    .font(.system(size: 18))
                                    .foregroundStyle(.white.opacity(0.5))
                            )
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
    @State private var index = 0

    var body: some View {
        let reels = LpspInstagramShowroomData.reels
        ZStack {
            LinearGradient(
                colors: [reels[index].accent.opacity(0.7), LpspInstagramTokens.igCanvasDark],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.25), value: index)

            VStack {
                HStack {
                    Text("Reels")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "camera").foregroundStyle(.white)
                }
                .padding()

                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    Text(reels[index].username)
                        .font(LpspInstagramFonts.igUsername)
                        .foregroundStyle(.white)
                    Text(reels[index].caption)
                        .font(LpspInstagramFonts.igCaption)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

                HStack(spacing: 28) {
                    Button { if index > 0 { index -= 1 } } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(.white.opacity(index > 0 ? 1 : 0.3))
                    }
                    .disabled(index == 0)
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 52))
                        .foregroundStyle(.white)
                    Button { if index < reels.count - 1 { index += 1 } } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(.white.opacity(index < reels.count - 1 ? 1 : 0.3))
                    }
                    .disabled(index == reels.count - 1)
                }
                .padding(.bottom, 24)
            }
        }
    }
}

private struct LpspInstagramCreateTabScreen: View {
    @State private var mode = 0

    var body: some View {
        VStack(spacing: 20) {
            Picker("Mode", selection: $mode) {
                Text("Post").tag(0)
                Text("Story").tag(1)
                Text("Reel").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 24)
            .padding(.top, 16)

            RoundedRectangle(cornerRadius: 16)
                .fill(LpspInstagramTokens.igSurfaceInputD)
                .frame(height: 280)
                .overlay(
                    VStack(spacing: 12) {
                        Image(systemName: mode == 2 ? "play.rectangle.fill" : "camera.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
                        Text(mode == 0 ? "New post" : mode == 1 ? "New story" : "New reel")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                    }
                )
                .padding(.horizontal, 24)

            HStack(spacing: 12) {
                Image(systemName: "photo.on.rectangle")
                Text("Choose from library")
            }
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(LpspInstagramTokens.igActionBlue)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
    }
}

private struct LpspInstagramProfileTabScreen: View {
    private let profile = LpspInstagramShowroomData.profile

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HStack(spacing: 28) {
                        LpspInstagramStoryRing(
                            initials: LpspInstagramContactStyle.initials(for: profile.username),
                            gradient: LpspInstagramContactStyle.gradient(for: profile.username),
                            isUnread: false,
                            size: 88
                        )
                        HStack(spacing: 24) {
                            profileStat(value: "\(profile.posts)", label: "posts")
                            profileStat(value: profile.followers, label: "followers")
                            profileStat(value: profile.following, label: "following")
                        }
                    }
                    .padding(.horizontal, 16)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(profile.username)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        Text(profile.bio)
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                    HStack(spacing: 8) {
                        profileButton("Edit profile", filled: false)
                        profileButton("Share profile", filled: false)
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 36, height: 32)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(LpspInstagramTokens.igDividerDark))
                    }
                    .padding(.horizontal, 16)

                    LazyVGrid(
                        columns: [GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2)],
                        spacing: 2
                    ) {
                        ForEach(LpspInstagramShowroomData.feedPosts) { post in
                            Rectangle()
                                .fill(post.accent.opacity(0.45))
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(Image(systemName: post.icon).foregroundStyle(.white.opacity(0.45)))
                        }
                    }
                }
                .padding(.vertical, 12)
            }
            .navigationTitle(profile.username)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .background(LpspInstagramTokens.igCanvasDark.ignoresSafeArea())
    }

    private func profileStat(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value).font(.system(size: 16, weight: .semibold)).foregroundStyle(.white)
            Text(label).font(.caption).foregroundStyle(LpspInstagramTokens.igTextSecondaryD)
        }
    }

    private func profileButton(_ title: String, filled: Bool) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(filled ? LpspInstagramTokens.igActionBlue : .clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(LpspInstagramTokens.igDividerDark, lineWidth: filled ? 0 : 1)
                    )
            )
    }
}

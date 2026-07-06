import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/threads
// Meliwat/awesome-ios-design-md/social/threads/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeThreadsView: View {
    var body: some View {
        LpspThreadsShowroomRoot(store: LpspThreadsStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspThreadsFonts {
    static let threadsScreenTitle    = Font.system(size: 17, weight: .regular)
    static let threadsDisplayName    = Font.system(size: 15, weight: .regular)
    static let threadsPostBody       = Font.system(size: 15, weight: .regular)
    static let threadsQuotedBody     = Font.system(size: 14, weight: .regular)
    static let threadsHandle         = Font.system(size: 14, weight: .regular)
    static let threadsActionCount    = Font.system(size: 13, weight: .regular)
    static let threadsProfileBio     = Font.system(size: 15, weight: .regular)
    static let threadsButton         = Font.system(size: 15, weight: .regular)
    static let threadsSecondaryBtn   = Font.system(size: 14, weight: .regular)
    static let threadsComposePH      = Font.system(size: 17, weight: .regular)
    static let threadsDMBody         = Font.system(size: 15, weight: .regular)
    static let threadsFilterChip     = Font.system(size: 14, weight: .regular)
    static func threadsFallback(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspThreadsTokens {
    // MARK: - Canvas & Surfaces (Dark / Default)
    static let threadsCanvas          = Color.black                                   // #000000
    static let threadsSurface1        = Color(red: 0.063, green: 0.063, blue: 0.063) // #101010
    static let threadsSurface2        = Color(red: 0.094, green: 0.094, blue: 0.094) // #181818
    static let threadsDivider         = Color(red: 0.133, green: 0.133, blue: 0.133) // #222222
    static let threadsLine            = Color(red: 0.200, green: 0.200, blue: 0.200) // #333333

    // MARK: - Canvas & Surfaces (Light)
    static let threadsLightCanvas     = Color.white                                   // #FFFFFF
    static let threadsLightSurface1   = Color(red: 0.980, green: 0.980, blue: 0.980) // #FAFAFA
    static let threadsLightSurface2   = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let threadsLightDivider    = Color(red: 0.859, green: 0.859, blue: 0.859) // #DBDBDB
    static let threadsLightLine       = Color(red: 0.851, green: 0.851, blue: 0.851) // #D9D9D9

    // MARK: - Text
    static let threadsTextPrimaryDark  = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let threadsTextPrimaryLight = Color.black                                   // #000000
    static let threadsTextSecondary    = Color(red: 0.467, green: 0.467, blue: 0.467) // #777777
    static let threadsTextTertiaryDark = Color(red: 0.302, green: 0.302, blue: 0.302) // #4D4D4D
    static let threadsTextTertiaryLight = Color(red: 0.600, green: 0.600, blue: 0.600) // #999999

    // MARK: - Brand / Action
    static let threadsLinkBlue        = Color(red: 0.176, green: 0.498, blue: 0.976) // #2D7FF9
    static let threadsLikeCoral       = Color(red: 0.996, green: 0.173, blue: 0.333) // #FE2C55
    static let threadsErrorRed        = Color(red: 0.929, green: 0.286, blue: 0.337) // #ED4956
    static let threadsSuccessGreen    = Color(red: 0.345, green: 0.765, blue: 0.133) // #58C322
    static let threadsIGVerified      = Color(red: 0.000, green: 0.584, blue: 0.965) // #0095F6
}



// System fallback if Instagram Sans isn't bundled:


fileprivate struct LpspThreadsThreadPostRow: View {
    let displayName: String
    let handle: String
    let timestamp: String
    let avatar: Image
    let postText: String
    let hasReplies: Bool  // if true, render the thread line
    var likeCount: Int = 0
    var commentCount: Int = 0
    @State private var isLiked = false
    @State private var isReposted = false

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                // Avatar + thread line column
                VStack(spacing: 0) {
                    avatar
                        .resizable()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                    if hasReplies {
                        Rectangle()
                            .fill(LpspThreadsTokens.threadsLine)
                            .frame(width: 1)
                            .padding(.top, 4)
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    // Header: name + handle + time + overflow
                    HStack(spacing: 4) {
                        Text(displayName)
                            .font(LpspThreadsFonts.threadsDisplayName)
                            .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                            .lineLimit(1)
                        Text("@\(handle)")
                            .font(LpspThreadsFonts.threadsHandle)
                            .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                            .lineLimit(1)
                        Text("·")
                            .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                        Text(timestamp)
                            .font(LpspThreadsFonts.threadsHandle)
                            .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                        Spacer()
                        Button { /* overflow */ } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 18))
                                .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                        }
                    }

                    // Body
                    Text(postText)
                        .font(LpspThreadsFonts.threadsPostBody)
                        .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                        .lineSpacing(6)  // approximates 1.4 line-height at 15pt
                        .fixedSize(horizontal: false, vertical: true)

                    // Action row: heart, comment, repost, share
                    HStack(spacing: 20) {
                        LpspThreadsActionBtn(icon: isLiked ? "heart.fill" : "heart",
                                  count: likeCount,
                                  tint: isLiked ? LpspThreadsTokens.threadsLikeCoral : LpspThreadsTokens.threadsTextSecondary) {
                            withAnimation(.spring(response: 0.3)) { isLiked.toggle() }
                        }
                        LpspThreadsActionBtn(icon: "bubble.left", count: commentCount, tint: LpspThreadsTokens.threadsTextSecondary) {}
                        LpspThreadsActionBtn(icon: isReposted ? "arrow.2.squarepath.circle.fill" : "arrow.2.squarepath",
                                  count: nil,
                                  tint: LpspThreadsTokens.threadsTextSecondary) {
                            isReposted.toggle()
                        }
                        LpspThreadsActionBtn(icon: "paperplane", count: nil, tint: LpspThreadsTokens.threadsTextSecondary) {}
                        Spacer()
                    }
                    .padding(.top, 4)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)

            Divider().background(LpspThreadsTokens.threadsDivider)
        }
        .background(LpspThreadsTokens.threadsCanvas)
    }
}

fileprivate struct LpspThreadsActionBtn: View {
    let icon: String
    let count: Int?
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(tint)
                if let c = count, c > 0 {
                    Text("\(c)")
                        .font(LpspThreadsFonts.threadsActionCount)
                        .foregroundStyle(tint)
                }
            }
            .frame(minWidth: 44, minHeight: 44, alignment: .leading)
        }
    }
}

fileprivate struct LpspThreadsThreadsPostPill: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspThreadsFonts.threadsButton)
                .foregroundStyle(.black)
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(Capsule().fill(LpspThreadsTokens.threadsTextPrimaryDark))
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.3)
        .buttonStyle(LpspThreadsThreadsPressableStyle())
    }
}

fileprivate struct LpspThreadsThreadsPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

fileprivate struct LpspThreadsThreadsFollowPill: View {
    @Binding var isFollowing: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(isFollowing ? "Following" : "Follow")
                .font(LpspThreadsFonts.threadsSecondaryBtn)
                .foregroundStyle(isFollowing ? LpspThreadsTokens.threadsTextPrimaryDark : .black)
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .frame(minWidth: 92)
                .background(
                    Capsule().fill(isFollowing ? Color.clear : LpspThreadsTokens.threadsTextPrimaryDark)
                )
                .overlay(
                    Capsule().strokeBorder(isFollowing ? LpspThreadsTokens.threadsTextSecondary : .clear, lineWidth: 1)
                )
        }
        .buttonStyle(LpspThreadsThreadsPressableStyle())
    }
}

fileprivate struct LpspThreadsActivityFilterRow: View {
    @Binding var selected: String
    private let chips = ["All", "Follows", "Replies", "Mentions", "Quotes", "Reposts", "Verified"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(chips, id: \.self) { label in
                    let isOn = selected == label
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) { selected = label }
                    } label: {
                        Text(label)
                            .font(LpspThreadsFonts.threadsFilterChip)
                            .foregroundStyle(isOn ? .black : LpspThreadsTokens.threadsTextPrimaryDark)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .frame(minHeight: 36)
                            .background(
                                Capsule().fill(isOn ? LpspThreadsTokens.threadsTextPrimaryDark : .clear)
                            )
                            .overlay(
                                Capsule().strokeBorder(isOn ? Color.clear : LpspThreadsTokens.threadsLine, lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

fileprivate struct LpspThreadsThreadsComposer: View {
    @State private var drafts: [String] = [""]
    @State private var currentIndex: Int = 0
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(drafts.indices, id: \.self) { i in
                        HStack(alignment: .top, spacing: 12) {
                            VStack(spacing: 0) {
                                Circle().fill(LpspThreadsTokens.threadsSurface2).frame(width: 36, height: 36)
                                if i < drafts.count - 1 || drafts[i].isEmpty == false {
                                    Rectangle()
                                        .fill(LpspThreadsTokens.threadsLine)
                                        .frame(width: 1)
                                        .frame(maxHeight: .infinity)
                                        .padding(.top, 4)
                                }
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("you").font(LpspThreadsFonts.threadsDisplayName).foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                                TextField("Start a thread...", text: $drafts[i], axis: .vertical)
                                    .font(LpspThreadsFonts.threadsComposePH)
                                    .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                                    .tint(LpspThreadsTokens.threadsTextPrimaryDark)
                                    .lineLimit(1...20)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }

                    // Add-to-thread dot
                    HStack(alignment: .center, spacing: 12) {
                        Circle()
                            .strokeBorder(LpspThreadsTokens.threadsLine, lineWidth: 1)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Image(systemName: "plus")
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                            )
                            .padding(.leading, 24)
                        Button("Add to thread") { drafts.append("") }
                            .font(LpspThreadsFonts.threadsHandle)
                            .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                    }
                    .padding(.top, 8)
                }
            }
            .background(LpspThreadsTokens.threadsCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                }
                ToolbarItem(placement: .confirmationAction) {
                    LpspThreadsThreadsPostPill(title: "Post",
                                    isEnabled: drafts.contains(where: { !$0.isEmpty }),
                                    action: { /* submit */ dismiss() })
                }
            }
            .toolbarBackground(LpspThreadsTokens.threadsCanvas, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}



// MARK: - Showroom data & store

private enum LpspThreadsShowroomTab: String, CaseIterable, Identifiable {
    case home, search, compose, activity, profile

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .search: "magnifyingglass"
        case .compose: "plus.square"
        case .activity: "heart"
        case .profile: "person"
        }
    }
}

private struct LpspThreadsPost: Identifiable, Equatable {
    let id: String
    let displayName: String
    let handle: String
    let timestamp: String
    let isVerified: Bool
    let postText: String
    let hasMedia: Bool
    let avatarGradient: [Color]
    var likeCount: Int
    var commentCount: Int
    var repostCount: Int
    var isLiked: Bool
    var isReposted: Bool
    var isReply: Bool
}

private struct LpspThreadsThread: Identifiable, Equatable {
    let id: String
    var main: LpspThreadsPost
    var replies: [LpspThreadsPost]
}

private enum LpspThreadsShowroomData {
    static let mayaGradient: [Color] = [
        Color(red: 1.0, green: 0.55, blue: 0.2),
        Color(red: 0.95, green: 0.35, blue: 0.55),
    ]

    static let jordanGradient: [Color] = [
        Color(red: 0.25, green: 0.55, blue: 0.95),
        Color(red: 0.15, green: 0.35, blue: 0.75),
    ]

    static let featuredThread = LpspThreadsThread(
        id: "maya-run",
        main: LpspThreadsPost(
            id: "maya",
            displayName: "maya_c",
            handle: "maya_c",
            timestamp: "2h",
            isVerified: true,
            postText: "Ran 5 miles before sunrise. The city felt like a secret.",
            hasMedia: true,
            avatarGradient: mayaGradient,
            likeCount: 247,
            commentCount: 18,
            repostCount: 12,
            isLiked: true,
            isReposted: false,
            isReply: false
        ),
        replies: [
            LpspThreadsPost(
                id: "jordan",
                displayName: "jordanp",
                handle: "jordanp",
                timestamp: "1h",
                isVerified: false,
                postText: "Same trail? I've been running that loop all month — it's unreal at 5am.",
                hasMedia: false,
                avatarGradient: jordanGradient,
                likeCount: 42,
                commentCount: 3,
                repostCount: 0,
                isLiked: false,
                isReposted: false,
                isReply: true
            ),
        ]
    )

    static let searchSuggestions = ["morning runs", "city trails", "sunrise photos", "maya_c"]

    static let activityItems: [(title: String, detail: String, time: String)] = [
        ("jordanp replied to your thread", "Same trail? I've been running…", "1h"),
        ("maya_c liked your post", "Golden hour walk thread", "3h"),
        ("alex_r started following you", "", "5h"),
    ]
}

@MainActor
fileprivate final class LpspThreadsStore: ObservableObject {
    @Published var selectedTab: LpspThreadsShowroomTab = .home
    @Published var threads: [LpspThreadsThread] = [LpspThreadsShowroomData.featuredThread]
    @Published var showComposeSheet = false
    @Published var activityFilter = "All"
    @Published var isFollowingProfile = false
    @Published var searchQuery = ""

    func toggleLike(postID: String) {
        threads = threads.map { thread in
            var copy = thread
            if copy.main.id == postID {
                copy.main = mutateLike(copy.main)
                return copy
            }
            copy.replies = copy.replies.map { reply in
                guard reply.id == postID else { return reply }
                return mutateLike(reply)
            }
            return copy
        }
    }

    func toggleRepost(postID: String) {
        threads = threads.map { thread in
            var copy = thread
            if copy.main.id == postID {
                copy.main = mutateRepost(copy.main)
                return copy
            }
            copy.replies = copy.replies.map { reply in
                guard reply.id == postID else { return reply }
                return mutateRepost(reply)
            }
            return copy
        }
    }

    func incrementComment(postID: String) {
        threads = threads.map { thread in
            var copy = thread
            if copy.main.id == postID {
                copy.main.commentCount += 1
                return copy
            }
            copy.replies = copy.replies.map { reply in
                guard reply.id == postID else { return reply }
                var r = reply
                r.commentCount += 1
                return r
            }
            return copy
        }
    }

    func openCompose() {
        showComposeSheet = true
    }

    func toggleFollowProfile() {
        isFollowingProfile.toggle()
    }

    private func mutateLike(_ post: LpspThreadsPost) -> LpspThreadsPost {
        var copy = post
        copy.isLiked.toggle()
        copy.likeCount += copy.isLiked ? 1 : -1
        return copy
    }

    private func mutateRepost(_ post: LpspThreadsPost) -> LpspThreadsPost {
        var copy = post
        copy.isReposted.toggle()
        copy.repostCount += copy.isReposted ? 1 : -1
        return copy
    }
}

// MARK: - Écrans showroom

private struct LpspThreadsShowroomRoot: View {
    @ObservedObject var store: LpspThreadsStore

    var body: some View {
        ZStack {
            LpspThreadsTokens.threadsCanvas.ignoresSafeArea()

            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .home:
                        LpspThreadsHomeTabScreen(store: store)
                    case .search:
                        LpspThreadsSearchTabScreen(store: store)
                    case .compose:
                        LpspThreadsHomeTabScreen(store: store)
                    case .activity:
                        LpspThreadsActivityTabScreen(store: store)
                    case .profile:
                        LpspThreadsProfileTabScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspThreadsIconTabBar(store: store)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $store.showComposeSheet) {
            LpspThreadsThreadsComposer()
        }
    }
}

private struct LpspThreadsIconTabBar: View {
    @ObservedObject var store: LpspThreadsStore

    var body: some View {
        HStack {
            ForEach(LpspThreadsShowroomTab.allCases) { tab in
                Button {
                    if tab == .compose {
                        store.openCompose()
                    } else {
                        store.selectedTab = tab
                    }
                } label: {
                    Image(systemName: tab.icon)
                        .font(.system(size: 26, weight: .regular))
                        .foregroundStyle(
                            store.selectedTab == tab && tab != .compose
                                ? LpspThreadsTokens.threadsTextPrimaryDark
                                : LpspThreadsTokens.threadsTextSecondary
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                }
                .buttonStyle(.plain)
            }
        }
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspThreadsTokens.threadsDivider)
                .frame(height: 1)
        }
        .background(LpspThreadsTokens.threadsCanvas)
    }
}

private struct LpspThreadsHomeTabScreen: View {
    @ObservedObject var store: LpspThreadsStore

    var body: some View {
        VStack(spacing: 0) {
            LpspThreadsSpectrTopNav()

            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(store.threads) { thread in
                        LpspThreadsShowroomThreadBlock(
                            thread: thread,
                            onLike: { store.toggleLike(postID: $0) },
                            onRepost: { store.toggleRepost(postID: $0) },
                            onComment: { store.incrementComment(postID: $0) }
                        )
                    }
                }
            }
        }
    }
}

private struct LpspThreadsSpectrTopNav: View {
    var body: some View {
        HStack {
            Text("@")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(LpspThreadsTokens.threadsDivider)
                .frame(height: 1)
        }
    }
}

private struct LpspThreadsShowroomThreadBlock: View {
    let thread: LpspThreadsThread
    let onLike: (String) -> Void
    let onRepost: (String) -> Void
    let onComment: (String) -> Void

    var body: some View {
        VStack(spacing: 0) {
            LpspThreadsShowroomPostRow(
                post: thread.main,
                showThreadLine: !thread.replies.isEmpty,
                threadPreviewGradient: thread.replies.first?.avatarGradient,
                onLike: { onLike(thread.main.id) },
                onRepost: { onRepost(thread.main.id) },
                onComment: { onComment(thread.main.id) }
            )

            ForEach(thread.replies) { reply in
                LpspThreadsShowroomPostRow(
                    post: reply,
                    showThreadLine: false,
                    threadPreviewGradient: nil,
                    onLike: { onLike(reply.id) },
                    onRepost: { onRepost(reply.id) },
                    onComment: { onComment(reply.id) }
                )
            }

            Divider().background(LpspThreadsTokens.threadsDivider)
        }
    }
}

private struct LpspThreadsShowroomPostRow: View {
    let post: LpspThreadsPost
    let showThreadLine: Bool
    let threadPreviewGradient: [Color]?
    let onLike: () -> Void
    let onRepost: () -> Void
    let onComment: () -> Void

    private var avatarSize: CGFloat { post.isReply ? 28 : 36 }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(spacing: 0) {
                LpspThreadsAvatarView(gradient: post.avatarGradient, size: avatarSize)

                if showThreadLine {
                    Rectangle()
                        .fill(LpspThreadsTokens.threadsLine)
                        .frame(width: 1)
                        .frame(minHeight: 24)
                        .padding(.top, 4)

                    if let preview = threadPreviewGradient {
                        LpspThreadsAvatarView(gradient: preview, size: 28)
                            .padding(.top, 4)
                    }
                }
            }
            .frame(width: 36, alignment: .leading)

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Text(post.displayName)
                        .font(post.isReply ? LpspThreadsFonts.threadsHandle : LpspThreadsFonts.threadsDisplayName)
                        .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                        .lineLimit(1)

                    if post.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(LpspThreadsTokens.threadsIGVerified)
                    }

                    if !post.isReply {
                        Text("@\(post.handle)")
                            .font(LpspThreadsFonts.threadsHandle)
                            .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                            .lineLimit(1)
                    }

                    Text("·")
                        .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)

                    Text(post.timestamp)
                        .font(LpspThreadsFonts.threadsHandle)
                        .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)

                    Spacer()

                    Button { } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                    }
                }

                Text(post.postText)
                    .font(post.isReply ? LpspThreadsFonts.threadsQuotedBody : LpspThreadsFonts.threadsPostBody)
                    .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                    .lineSpacing(6)
                    .fixedSize(horizontal: false, vertical: true)

                if post.hasMedia {
                    LinearGradient(
                        colors: [
                            Color(red: 0.18, green: 0.22, blue: 0.32),
                            Color(red: 0.35, green: 0.28, blue: 0.42),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 4)
                }

                HStack(spacing: post.isReply ? 18 : 20) {
                    LpspThreadsActionBtn(
                        icon: post.isLiked ? "heart.fill" : "heart",
                        count: post.likeCount,
                        tint: post.isLiked ? LpspThreadsTokens.threadsLikeCoral : LpspThreadsTokens.threadsTextSecondary,
                        action: onLike
                    )
                    LpspThreadsActionBtn(
                        icon: "bubble.left",
                        count: post.commentCount,
                        tint: LpspThreadsTokens.threadsTextSecondary,
                        action: onComment
                    )
                    LpspThreadsActionBtn(
                        icon: post.isReposted ? "arrow.2.squarepath.circle.fill" : "arrow.2.squarepath",
                        count: post.repostCount > 0 ? post.repostCount : nil,
                        tint: LpspThreadsTokens.threadsTextSecondary,
                        action: onRepost
                    )
                    LpspThreadsActionBtn(
                        icon: "paperplane",
                        count: nil,
                        tint: LpspThreadsTokens.threadsTextSecondary,
                        action: {}
                    )
                    Spacer()
                }
                .padding(.top, post.isReply ? 8 : 4)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, post.isReply ? 0 : 16)
        .padding(.bottom, 12)
    }
}

private struct LpspThreadsAvatarView: View {
    let gradient: [Color]
    let size: CGFloat

    var body: some View {
        Circle()
            .fill(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: size, height: size)
    }
}

private struct LpspThreadsSearchTabScreen: View {
    @ObservedObject var store: LpspThreadsStore

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                TextField("Search", text: $store.searchQuery)
                    .font(LpspThreadsFonts.threadsPostBody)
                    .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                    .tint(LpspThreadsTokens.threadsTextPrimaryDark)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(LpspThreadsTokens.threadsSurface2)
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            List {
                Section("Trending") {
                    ForEach(LpspThreadsShowroomData.searchSuggestions, id: \.self) { term in
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                            Text(term)
                                .font(LpspThreadsFonts.threadsPostBody)
                                .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                        }
                        .listRowBackground(LpspThreadsTokens.threadsCanvas)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(LpspThreadsTokens.threadsCanvas)
        }
    }
}

private struct LpspThreadsActivityTabScreen: View {
    @ObservedObject var store: LpspThreadsStore

    var body: some View {
        VStack(spacing: 12) {
            LpspThreadsActivityFilterRow(selected: $store.activityFilter)

            List {
                ForEach(LpspThreadsShowroomData.activityItems.indices, id: \.self) { index in
                    let item = LpspThreadsShowroomData.activityItems[index]
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(LpspThreadsFonts.threadsDisplayName)
                            .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
                        if !item.detail.isEmpty {
                            Text(item.detail)
                                .font(LpspThreadsFonts.threadsHandle)
                                .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
                        }
                        Text(item.time)
                            .font(LpspThreadsFonts.threadsHandle)
                            .foregroundStyle(LpspThreadsTokens.threadsTextTertiaryDark)
                    }
                    .padding(.vertical, 4)
                    .listRowBackground(LpspThreadsTokens.threadsCanvas)
                }
            }
            .scrollContentBackground(.hidden)
            .background(LpspThreadsTokens.threadsCanvas)
        }
    }
}

private struct LpspThreadsProfileTabScreen: View {
    @ObservedObject var store: LpspThreadsStore

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                LpspThreadsAvatarView(
                    gradient: [
                        Color(red: 0.55, green: 0.35, blue: 0.95),
                        Color(red: 0.25, green: 0.55, blue: 0.95),
                    ],
                    size: 88
                )

                Text("you")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)

                Text("Product designer · Brooklyn")
                    .font(LpspThreadsFonts.threadsProfileBio)
                    .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)

                LpspThreadsThreadsFollowPill(isFollowing: $store.isFollowingProfile) {
                    store.toggleFollowProfile()
                }

                HStack(spacing: 32) {
                    profileStat("24", "threads")
                    profileStat("1.8K", "followers")
                    profileStat("412", "following")
                }
                .padding(.top, 8)
            }
            .padding()
        }
    }

    private func profileStat(_ value: String, _ label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(LpspThreadsTokens.threadsTextPrimaryDark)
            Text(label)
                .font(LpspThreadsFonts.threadsHandle)
                .foregroundStyle(LpspThreadsTokens.threadsTextSecondary)
        }
    }
}



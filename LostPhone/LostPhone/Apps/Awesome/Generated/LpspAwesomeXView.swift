import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/x-twitter
// Meliwat/awesome-ios-design-md/social/x-twitter/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeXView: View {
    var body: some View {
        LpspXShowroomRoot(store: LpspXStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspXFonts {
    static let xScreenTitle   = Font.system(size: 20, weight: .regular)
    static let xSectionHeader = Font.system(size: 17, weight: .regular)
    static let xDisplayName   = Font.system(size: 15, weight: .regular)
    static let xPostBody      = Font.system(size: 15, weight: .regular)
    static let xQuotedBody    = Font.system(size: 14, weight: .regular)
    static let xHandle        = Font.system(size: 15, weight: .regular)
    static let xActionCount   = Font.system(size: 13, weight: .regular)
    static let xTrendingTopic = Font.system(size: 15, weight: .regular)
    static let xTrendingMeta  = Font.system(size: 13, weight: .regular)
    static let xButton        = Font.system(size: 15, weight: .regular)
    static let xDMBody        = Font.system(size: 15, weight: .regular)
    static let xDMTimestamp   = Font.system(size: 11, weight: .regular)
    static func xFallback(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspXTokens {
    // MARK: - Canvas & Surfaces (Dark / Default)
    static let xCanvas           = Color.black                                   // #000000
    static let xSurface1          = Color(red: 0.086, green: 0.094, blue: 0.110) // #16181C
    static let xSurface2          = Color(red: 0.118, green: 0.125, blue: 0.141) // #1E2024
    static let xDivider           = Color(red: 0.184, green: 0.200, blue: 0.212) // #2F3336
    static let xDimCanvas         = Color(red: 0.082, green: 0.125, blue: 0.173) // #15202B
    static let xDimSurface1       = Color(red: 0.098, green: 0.153, blue: 0.204) // #192734
    static let xDimDivider        = Color(red: 0.220, green: 0.267, blue: 0.302) // #38444D

    // MARK: - Canvas & Surfaces (Light)
    static let xLightCanvas       = Color.white                                  // #FFFFFF
    static let xLightSurface1     = Color(red: 0.969, green: 0.976, blue: 0.976) // #F7F9F9
    static let xLightSurface2     = Color(red: 0.937, green: 0.953, blue: 0.957) // #EFF3F4

    // MARK: - Text
    static let xTextPrimaryDark   = Color(red: 0.906, green: 0.914, blue: 0.918) // #E7E9EA
    static let xTextPrimaryLight  = Color(red: 0.059, green: 0.078, blue: 0.098) // #0F1419
    static let xTextSecondaryDark = Color(red: 0.443, green: 0.463, blue: 0.482) // #71767B
    static let xTextSecondaryLight = Color(red: 0.325, green: 0.392, blue: 0.443) // #536471

    // MARK: - Brand / Action
    static let xBlue              = Color(red: 0.114, green: 0.608, blue: 0.941) // #1D9BF0
    static let xBluePressed       = Color(red: 0.102, green: 0.549, blue: 0.847) // #1A8CD8
    static let xRepostGreen       = Color(red: 0.000, green: 0.729, blue: 0.486) // #00BA7C
    static let xLikePink          = Color(red: 0.976, green: 0.094, blue: 0.502) // #F91880
    static let xVerifiedGold      = Color(red: 0.918, green: 0.702, blue: 0.031) // #EAB308
    static let xVerifiedGray      = Color(red: 0.510, green: 0.604, blue: 0.671) // #829AAB
    static let xErrorRed          = Color(red: 0.957, green: 0.129, blue: 0.180) // #F4212E
}



// System fallback if Chirp isn't bundled:


fileprivate struct LpspXXPostRow: View {
    let displayName: String
    let handle: String
    let timestamp: String
    let isVerified: Bool
    let avatar: Image
    let postText: String
    var replyCount: Int = 0
    var repostCount: Int = 0
    var likeCount: Int = 0
    var viewCount: Int = 0
    @State private var isLiked = false
    @State private var isReposted = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                avatar
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    // Header row: name + verified + handle + time + overflow
                    HStack(spacing: 4) {
                        Text(displayName)
                            .font(LpspXFonts.xDisplayName)
                            .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                            .lineLimit(1)
                        if isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(LpspXTokens.xBlue)
                        }
                        Text("@\(handle)")
                            .font(LpspXFonts.xHandle)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                            .lineLimit(1)
                        Text("·")
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                        Text(timestamp)
                            .font(LpspXFonts.xHandle)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                        Spacer()
                        Button { /* overflow */ } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 18))
                                .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                        }
                    }

                    // Body
                    Text(postText)
                        .font(LpspXFonts.xPostBody)
                        .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)

                    // Action row
                    HStack(spacing: 0) {
                        LpspXXActionIcon(systemName: "bubble.left",        count: replyCount,  color: LpspXTokens.xTextSecondaryDark, active: false)
                        Spacer()
                        LpspXXActionIcon(systemName: isReposted ? "arrow.2.squarepath" : "arrow.2.squarepath",
                                    count: repostCount, color: isReposted ? LpspXTokens.xRepostGreen : LpspXTokens.xTextSecondaryDark, active: isReposted)
                            .onTapGesture { withAnimation(.spring(response: 0.35)) { isReposted.toggle() } }
                        Spacer()
                        LpspXXActionIcon(systemName: isLiked ? "heart.fill" : "heart",
                                    count: likeCount, color: isLiked ? LpspXTokens.xLikePink : LpspXTokens.xTextSecondaryDark, active: isLiked)
                            .onTapGesture { withAnimation(.spring(response: 0.35)) { isLiked.toggle() } }
                        Spacer()
                        LpspXXActionIcon(systemName: "chart.bar",          count: viewCount,   color: LpspXTokens.xTextSecondaryDark, active: false)
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider().background(LpspXTokens.xDivider)
        }
        .background(LpspXTokens.xCanvas)
    }
}

fileprivate struct LpspXXActionIcon: View {
    let systemName: String
    let count: Int
    let color: Color
    let active: Bool

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: systemName)
                .font(.system(size: 18.75, weight: active ? .semibold : .regular))
                .foregroundStyle(color)
                .scaleEffect(active ? 1.0 : 1.0)
            if count > 0 {
                Text(formatted(count))
                    .font(LpspXFonts.xActionCount)
                    .foregroundStyle(color)
            }
        }
        .frame(minWidth: 44, minHeight: 44, alignment: .leading)
    }

    private func formatted(_ n: Int) -> String {
        switch n {
        case 1_000_000...: return String(format: "%.1fM", Double(n)/1_000_000)
        case 1_000...:     return String(format: "%.1fK", Double(n)/1_000)
        default:           return "\(n)"
        }
    }
}

fileprivate struct LpspXXPostFAB: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "pencil.and.outline")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.black)
                .frame(width: 56, height: 56)
                .background(Circle().fill(Color.white))
                .shadow(color: .black.opacity(0.4), radius: 12, y: 4)
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: UUID())
        .buttonStyle(LpspXXPressableStyle(pressedScale: 0.95))
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
}

fileprivate struct LpspXXPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspXXFollowPill: View {
    @Binding var isFollowing: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(isFollowing ? "Following" : "Follow")
                .font(LpspXFonts.xButton)
                .foregroundStyle(isFollowing ? LpspXTokens.xTextPrimaryDark : .black)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .frame(minWidth: 80)
                .background(
                    Capsule().fill(isFollowing ? Color.clear : LpspXTokens.xTextPrimaryDark)
                )
                .overlay(
                    Capsule().strokeBorder(isFollowing ? LpspXTokens.xTextSecondaryDark : .clear, lineWidth: 1)
                )
        }
        .buttonStyle(LpspXXPressableStyle())
    }
}

fileprivate struct LpspXXFeedFilter: View {
    @Binding var selection: Int // 0 = For you, 1 = Following
    private let titles = ["For you", "Following"]
    @Namespace private var indicator

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<2) { i in
                VStack(spacing: 12) {
                    Text(titles[i])
                        .font(LpspXFonts.xButton)
                        .foregroundStyle(selection == i ? LpspXTokens.xTextPrimaryDark : LpspXTokens.xTextSecondaryDark)
                    if selection == i {
                        Capsule()
                            .fill(LpspXTokens.xBlue)
                            .frame(width: 40, height: 4)
                            .matchedGeometryEffect(id: "indicator", in: indicator)
                    } else {
                        Color.clear.frame(height: 4)
                    }
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        selection = i
                    }
                }
            }
        }
        .frame(height: 48)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspXTokens.xDivider).frame(height: 1)
        }
    }
}

fileprivate struct LpspXLikeBurstModifier: ViewModifier {
    @Binding var isLiked: Bool
    @State private var particles: [CGPoint] = []

    func body(content: Content) -> some View {
        content
            .scaleEffect(isLiked ? 1.0 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.55), value: isLiked)
            .overlay {
                ForEach(Array(particles.enumerated()), id: \.offset) { _, p in
                    Circle()
                        .fill(LpspXTokens.xLikePink)
                        .frame(width: 4, height: 4)
                        .offset(x: p.x, y: p.y)
                        .opacity(0)
                        .animation(.easeOut(duration: 0.4), value: particles.count)
                }
            }
            .onChange(of: isLiked) { _, newValue in
                guard newValue else { return }
                // Hexagonal burst of 6 particles
                let radius: CGFloat = 18
                particles = (0..<6).map { i in
                    let angle = Double(i) * .pi / 3
                    return CGPoint(x: cos(angle) * radius, y: sin(angle) * radius)
                }
            }
    }
}

fileprivate extension View {
    func xLikeBurst(isLiked: Binding<Bool>) -> some View {
        modifier(LpspXLikeBurstModifier(isLiked: isLiked))
    }
}



// MARK: - Données & état (showroom Spectr)

private enum LpspXShowroomTab: String, CaseIterable, Identifiable {
    case home
    case search
    case communities
    case notifications
    case messages

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .search: return "magnifyingglass"
        case .communities: return "person.3.fill"
        case .notifications: return "bell.fill"
        case .messages: return "envelope.fill"
        }
    }
}

fileprivate struct LpspXPost: Identifiable, Equatable {
    let id: String
    let displayName: String
    let handle: String
    let timestamp: String
    let isVerified: Bool
    let avatarGradient: [Color]
    let postText: String
    let hashtag: String?
    let hasMedia: Bool
    var replyCount: Int
    var repostCount: Int
    var likeCount: Int
    var viewCount: Int
    var isLiked: Bool
    var isReposted: Bool
}

private enum LpspXShowroomData {
    static let featuredID = "nova-shipit"

    static let posts: [LpspXPost] = [
        .init(
            id: featuredID,
            displayName: "Nova Palmer",
            handle: "novapalmer",
            timestamp: "2h",
            isVerified: true,
            avatarGradient: [
                Color(red: 1.0, green: 0.84, blue: 0.6),
                Color(red: 1.0, green: 0.89, blue: 0.58),
            ],
            postText: "Just shipped a new feature. Feedback welcome.",
            hashtag: "#shipit",
            hasMedia: true,
            replyCount: 24,
            repostCount: 148,
            likeCount: 1_200,
            viewCount: 24_000,
            isLiked: true,
            isReposted: true
        ),
        .init(
            id: "harborwave-synth",
            displayName: "harborwave",
            handle: "harborwave",
            timestamp: "4h",
            isVerified: false,
            avatarGradient: [
                Color(red: 0.22, green: 0.48, blue: 0.92),
                Color(red: 0.10, green: 0.22, blue: 0.55),
            ],
            postText: "New synth loop dropping tonight. Who wants the stems?",
            hashtag: "#music",
            hasMedia: false,
            replyCount: 8,
            repostCount: 31,
            likeCount: 412,
            viewCount: 6_200,
            isLiked: false,
            isReposted: false
        ),
        .init(
            id: "kellen-ranked",
            displayName: "kellen_v",
            handle: "kellen_v",
            timestamp: "6h",
            isVerified: false,
            avatarGradient: [
                Color(red: 0.88, green: 0.42, blue: 0.18),
                Color(red: 0.55, green: 0.18, blue: 0.12),
            ],
            postText: "Ranked grind continues. Patch notes look spicy.",
            hashtag: nil,
            hasMedia: false,
            replyCount: 15,
            repostCount: 22,
            likeCount: 890,
            viewCount: 11_400,
            isLiked: false,
            isReposted: false
        ),
    ]

    static let trending = [
        ("Technology", "#shipit", "12.4K posts"),
        ("Music", "harborwave live", "3.1K posts"),
        ("Sports", "Opening night", "28K posts"),
    ]

    static let communities = ["Design Systems", "Indie Dev", "SwiftUI", "Film Photo"]

    static let notifications: [(title: String, detail: String, time: String)] = [
        ("Nova Palmer liked your post", "Just shipped a new feature…", "1h"),
        ("harborwave reposted you", "New synth loop dropping tonight", "3h"),
        ("kellen_v followed you", "", "5h"),
    ]

    static let messages: [(name: String, preview: String, time: String, unread: Bool)] = [
        ("Nova Palmer", "Feedback welcome on the ship", "2h", true),
        ("pixelgremlin", "sent a GIF", "1d", false),
    ]
}

@MainActor
fileprivate final class LpspXStore: ObservableObject {
    @Published var selectedTab: LpspXShowroomTab = .home
    @Published var feedFilter = 0
    @Published var posts: [LpspXPost]
    @Published var showComposeSheet = false
    @Published var composeText = ""

    init() {
        posts = LpspXShowroomData.posts
    }

    var filteredPosts: [LpspXPost] {
        guard feedFilter == 1 else { return posts }
        return posts.filter { ["novapalmer", "harborwave"].contains($0.handle) }
    }

    func toggleLike(postID: String) {
        guard let index = posts.firstIndex(where: { $0.id == postID }) else { return }
        var post = posts[index]
        post.isLiked.toggle()
        post.likeCount += post.isLiked ? 1 : -1
        posts[index] = post
    }

    func toggleRepost(postID: String) {
        guard let index = posts.firstIndex(where: { $0.id == postID }) else { return }
        var post = posts[index]
        post.isReposted.toggle()
        post.repostCount += post.isReposted ? 1 : -1
        posts[index] = post
    }

    func openCompose() {
        showComposeSheet = true
    }

    func publishPost() {
        let trimmed = composeText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        posts.insert(
            LpspXPost(
                id: "user-\(posts.count + 1)",
                displayName: "you",
                handle: "you",
                timestamp: "now",
                isVerified: false,
                avatarGradient: [LpspXTokens.xBlue, LpspXTokens.xBluePressed],
                postText: trimmed,
                hashtag: nil,
                hasMedia: false,
                replyCount: 0,
                repostCount: 0,
                likeCount: 0,
                viewCount: 0,
                isLiked: false,
                isReposted: false
            ),
            at: 0
        )
        composeText = ""
        showComposeSheet = false
        selectedTab = .home
    }
}

// MARK: - Écrans showroom

private struct LpspXShowroomRoot: View {
    @ObservedObject var store: LpspXStore

    var body: some View {
        ZStack {
            LpspXTokens.xCanvas.ignoresSafeArea()

            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .home:
                        LpspXHomeFeedScreen(store: store)
                    case .search:
                        LpspXSearchTabScreen()
                    case .communities:
                        LpspXCommunitiesTabScreen()
                    case .notifications:
                        LpspXNotificationsTabScreen()
                    case .messages:
                        LpspXMessagesTabScreen()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspXIconTabBar(store: store)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $store.showComposeSheet) {
            LpspXComposeSheet(store: store)
        }
    }
}

private struct LpspXIconTabBar: View {
    @ObservedObject var store: LpspXStore

    var body: some View {
        HStack {
            ForEach(LpspXShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    Image(systemName: tab.icon)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(
                            store.selectedTab == tab
                                ? LpspXTokens.xTextPrimaryDark
                                : LpspXTokens.xTextSecondaryDark
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                }
                .buttonStyle(.plain)
            }
        }
        .overlay(alignment: .top) {
            Rectangle()
                .fill(LpspXTokens.xDivider)
                .frame(height: 1)
        }
        .background(LpspXTokens.xCanvas)
    }
}

private struct LpspXHomeFeedScreen: View {
    @ObservedObject var store: LpspXStore

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                LpspXTopNavBar()
                LpspXXFeedFilter(selection: $store.feedFilter)

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(store.filteredPosts) { post in
                            LpspXShowroomPostRow(
                                post: post,
                                onLike: { store.toggleLike(postID: post.id) },
                                onRepost: { store.toggleRepost(postID: post.id) }
                            )
                        }
                    }
                }
            }

            LpspXXPostFAB {
                store.openCompose()
            }
        }
    }
}

private struct LpspXTopNavBar: View {
    var body: some View {
        HStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [LpspXTokens.xBlue, LpspXTokens.xBluePressed],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 30, height: 30)

            Spacer()

            Text("𝕏")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(LpspXTokens.xTextPrimaryDark)

            Spacer()

            Text("✦")
                .font(.system(size: 18))
                .foregroundStyle(LpspXTokens.xTextPrimaryDark)
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(LpspXTokens.xDivider)
                .frame(height: 1)
        }
    }
}

private struct LpspXShowroomPostRow: View {
    let post: LpspXPost
    let onLike: () -> Void
    let onRepost: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: post.avatarGradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 32, height: 32)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Text(post.displayName)
                            .font(LpspXFonts.xDisplayName.weight(.semibold))
                            .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                            .lineLimit(1)

                        if post.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(LpspXTokens.xBlue)
                        }

                        Text("@\(post.handle)")
                            .font(LpspXFonts.xHandle)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                            .lineLimit(1)

                        Text("·")
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)

                        Text(post.timestamp)
                            .font(LpspXFonts.xHandle)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)

                        Spacer()

                        Image(systemName: "ellipsis")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                    }

                    postBodyText

                    if post.hasMedia {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        LpspXTokens.xSurface2,
                                        LpspXTokens.xSurface1,
                                        LpspXTokens.xCanvas,
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .padding(.top, 8)
                    }

                    HStack(spacing: 0) {
                        LpspXInteractiveActionIcon(
                            systemName: "bubble.left",
                            count: post.replyCount,
                            color: LpspXTokens.xTextSecondaryDark,
                            action: {}
                        )
                        Spacer()
                        LpspXInteractiveActionIcon(
                            systemName: "arrow.2.squarepath",
                            count: post.repostCount,
                            color: post.isReposted ? LpspXTokens.xRepostGreen : LpspXTokens.xTextSecondaryDark,
                            action: onRepost
                        )
                        Spacer()
                        LpspXInteractiveActionIcon(
                            systemName: post.isLiked ? "heart.fill" : "heart",
                            count: post.likeCount,
                            color: post.isLiked ? LpspXTokens.xLikePink : LpspXTokens.xTextSecondaryDark,
                            action: onLike
                        )
                        Spacer()
                        LpspXInteractiveActionIcon(
                            systemName: "chart.bar",
                            count: post.viewCount,
                            color: LpspXTokens.xTextSecondaryDark,
                            action: {}
                        )
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                            .frame(minWidth: 44, minHeight: 44)
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Rectangle()
                .fill(LpspXTokens.xDivider)
                .frame(height: 1)
        }
        .background(LpspXTokens.xCanvas)
    }

    private var postBodyText: some View {
        Group {
            if let hashtag = post.hashtag {
                (Text(post.postText + " ")
                    .font(LpspXFonts.xPostBody)
                    .foregroundColor(LpspXTokens.xTextPrimaryDark)
                 + Text(hashtag)
                    .font(LpspXFonts.xPostBody.weight(.semibold))
                    .foregroundColor(LpspXTokens.xBlue))
            } else {
                Text(post.postText)
                    .font(LpspXFonts.xPostBody)
                    .foregroundStyle(LpspXTokens.xTextPrimaryDark)
            }
        }
        .lineSpacing(4)
        .fixedSize(horizontal: false, vertical: true)
    }
}

private struct LpspXInteractiveActionIcon: View {
    let systemName: String
    let count: Int
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: systemName)
                    .font(.system(size: 18.75, weight: .regular))
                    .foregroundStyle(color)
                if count > 0 {
                    Text(formatted(count))
                        .font(LpspXFonts.xActionCount)
                        .foregroundStyle(color)
                }
            }
            .frame(minWidth: 44, minHeight: 44, alignment: .leading)
        }
        .buttonStyle(LpspXXPressableStyle(pressedScale: 0.92))
        .sensoryFeedback(.impact(weight: .light), trigger: count)
    }

    private func formatted(_ n: Int) -> String {
        switch n {
        case 1_000_000...:
            return String(format: "%.1fM", Double(n) / 1_000_000).replacingOccurrences(of: ".0", with: "")
        case 1_000...:
            return String(format: "%.1fK", Double(n) / 1_000).replacingOccurrences(of: ".0", with: "")
        default:
            return "\(n)"
        }
    }
}

private struct LpspXSearchTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(LpspXShowroomData.trending, id: \.1) { category, topic, meta in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(category)
                            .font(LpspXFonts.xTrendingMeta)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                        Text(topic)
                            .font(LpspXFonts.xTrendingTopic.weight(.semibold))
                            .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                        Text(meta)
                            .font(LpspXFonts.xTrendingMeta)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)

                    Rectangle()
                        .fill(LpspXTokens.xDivider)
                        .frame(height: 1)
                }
            }
        }
    }
}

private struct LpspXCommunitiesTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspXShowroomData.communities, id: \.self) { name in
                HStack(spacing: 12) {
                    Circle()
                        .fill(LpspXTokens.xSurface2)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "person.3.fill")
                                .foregroundStyle(LpspXTokens.xBlue)
                        }
                    Text(name)
                        .font(LpspXFonts.xSectionHeader.weight(.semibold))
                        .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                }
                .listRowBackground(LpspXTokens.xCanvas)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

private struct LpspXNotificationsTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspXShowroomData.notifications, id: \.title) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(LpspXFonts.xDisplayName.weight(.semibold))
                        .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                    if !item.detail.isEmpty {
                        Text(item.detail)
                            .font(LpspXFonts.xPostBody)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                    }
                    Text(item.time)
                        .font(LpspXFonts.xTrendingMeta)
                        .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                }
                .listRowBackground(LpspXTokens.xCanvas)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

private struct LpspXMessagesTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspXShowroomData.messages, id: \.name) { message in
                HStack(spacing: 12) {
                    Circle()
                        .fill(LpspXTokens.xSurface2)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text(String(message.name.prefix(1)))
                                .font(LpspXFonts.xButton.weight(.bold))
                                .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.name)
                            .font(LpspXFonts.xDisplayName.weight(.semibold))
                            .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                        Text(message.preview)
                            .font(LpspXFonts.xDMBody)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                            .lineLimit(1)
                    }

                    Spacer()

                    if message.unread {
                        Circle()
                            .fill(LpspXTokens.xBlue)
                            .frame(width: 8, height: 8)
                    }

                    Text(message.time)
                        .font(LpspXFonts.xDMTimestamp)
                        .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                }
                .listRowBackground(LpspXTokens.xCanvas)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

private struct LpspXComposeSheet: View {
    @ObservedObject var store: LpspXStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                TextField("What's happening?", text: $store.composeText, axis: .vertical)
                    .font(LpspXFonts.xPostBody)
                    .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                    .lineLimit(4...8)

                Spacer()
            }
            .padding(16)
            .background(LpspXTokens.xCanvas.ignoresSafeArea())
            .navigationTitle("Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") { store.publishPost() }
                        .font(LpspXFonts.xButton.weight(.semibold))
                        .foregroundStyle(LpspXTokens.xBlue)
                        .disabled(store.composeText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}



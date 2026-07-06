import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/linkedin
// Meliwat/awesome-ios-design-md/social/linkedin/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeLinkedInView: View {
    var body: some View {
        LpspLinkedInShowroomRoot(store: LpspLinkedInStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspLinkedInTokens {
    // MARK: - Canvas & Surfaces
    static let liCanvas         = Color(red: 0.953, green: 0.949, blue: 0.937)  // #F3F2EF
    static let liCardSurface    = Color.white                                    // #FFFFFF
    static let liElevated       = Color(red: 0.976, green: 0.976, blue: 0.976)  // #F9F9F9
    static let liDivider        = Color(red: 0.878, green: 0.875, blue: 0.863)  // #E0DFDC
    static let liDividerSubtle  = Color(red: 0.929, green: 0.929, blue: 0.929)  // #EDEDED

    // MARK: - Text
    static let liTextPrimary    = Color.black.opacity(0.9)                      // #000000E6
    static let liTextSecondary  = Color.black.opacity(0.6)                      // #00000099
    static let liTextTertiary   = Color.black.opacity(0.4)                      // #00000066

    // MARK: - Brand
    static let liBlue           = Color(red: 0.039, green: 0.400, blue: 0.761)  // #0A66C2
    static let liBluePressed    = Color(red: 0.000, green: 0.255, blue: 0.510)  // #004182
    static let liBlueSubtle     = Color(red: 0.906, green: 0.953, blue: 1.000)  // #E7F3FF

    // MARK: - Status
    static let liOpenToWork     = Color(red: 0.020, green: 0.463, blue: 0.259)  // #057642
    static let liPremiumGold    = Color(red: 0.569, green: 0.349, blue: 0.027)  // #915907
    static let liPremiumGoldHi  = Color(red: 0.765, green: 0.490, blue: 0.086)  // #C37D16

    // MARK: - Reactions
    static let liReactLike      = Color(red: 0.039, green: 0.400, blue: 0.761)  // #0A66C2
    static let liReactCelebrate = Color(red: 0.961, green: 0.733, blue: 0.000)  // #F5BB00
    static let liReactSupport   = Color(red: 0.698, green: 0.251, blue: 0.125)  // #B24020
    static let liReactLove      = Color(red: 0.875, green: 0.439, blue: 0.302)  // #DF704D
    static let liReactInsightful = Color(red: 0.906, green: 0.639, blue: 0.243) // #E7A33E
    static let liReactFunny     = Color(red: 0.000, green: 0.627, blue: 0.863)  // #00A0DC

    // MARK: - Dark Mode
    static let liDarkCanvas     = Color(red: 0.106, green: 0.122, blue: 0.137)  // #1B1F23
    static let liDarkCard       = Color(red: 0.114, green: 0.133, blue: 0.149)  // #1D2226
    static let liDarkBlue       = Color(red: 0.439, green: 0.710, blue: 0.976)  // #70B5F9
}

private enum LpspLinkedInFonts {
    // Display
    static let liProfileName   = Font.system(size: 24, weight: .bold)
    static let liScreenTitle   = Font.system(size: 20, weight: .bold)
    static let liSectionHeader = Font.system(size: 16, weight: .bold)

    // Feed
    static let liPostAuthor    = Font.system(size: 14, weight: .semibold)
    static let liHeadline      = Font.system(size: 12, weight: .regular)
    static let liPostBody      = Font.system(size: 14, weight: .regular)
    static let liMeta          = Font.system(size: 12, weight: .regular)

    // Interactive
    static let liButtonPrimary   = Font.system(size: 16, weight: .semibold)
    static let liButtonSecondary = Font.system(size: 14, weight: .semibold)
    static let liActionBar       = Font.system(size: 13, weight: .semibold)
    static let liTab             = Font.system(size: 11, weight: .medium)
    static let liBadge           = Font.system(size: 11, weight: .bold)
}

fileprivate struct LpspLinkedInLinkedInPillButton: View {
    enum Variant { case filled, outline }
    let title: String
    let systemImage: String?
    var variant: Variant = .filled
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 16, weight: .semibold))
                }
                Text(title)
                    .font(variant == .filled ? LpspLinkedInFonts.liButtonPrimary : LpspLinkedInFonts.liButtonSecondary)
            }
            .foregroundStyle(variant == .filled ? Color.white : LpspLinkedInTokens.liBlue)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                Capsule().fill(variant == .filled ? LpspLinkedInTokens.liBlue : Color.clear)
            )
            .overlay(
                Capsule().strokeBorder(variant == .outline ? LpspLinkedInTokens.liBlue : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(LpspLinkedInLinkedInPressableStyle())
        .sensoryFeedback(.impact(flexibility: .soft), trigger: UUID())
    }
}

fileprivate struct LpspLinkedInLinkedInPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

fileprivate struct LpspLinkedInFeedPostCard: View {
    let authorName: String
    let connectionDegree: String           // "1st", "2nd", "3rd+"
    let headline: String                   // job title + company
    let timeAgo: String                    // "3d •"
    let postText: String
    let mediaImage: Image?
    let isPremium: Bool
    let isOpenToWork: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                LpspLinkedInAvatarView(size: 56, isPremium: isPremium, isOpenToWork: isOpenToWork)

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(authorName).font(LpspLinkedInFonts.liPostAuthor).foregroundStyle(LpspLinkedInTokens.liTextPrimary)
                        Text("• \(connectionDegree)").font(LpspLinkedInFonts.liMeta).foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                    }
                    Text(headline)
                        .font(LpspLinkedInFonts.liHeadline)
                        .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                        .lineLimit(2)
                    HStack(spacing: 4) {
                        Text(timeAgo).font(LpspLinkedInFonts.liMeta).foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                        Image(systemName: "globe.americas.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                    }
                }

                Spacer()

                Image(systemName: "ellipsis")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)

            Text(postText)
                .font(LpspLinkedInFonts.liPostBody)
                .foregroundStyle(LpspLinkedInTokens.liTextPrimary)
                .lineSpacing(4)
                .padding(.horizontal, 16)
                .padding(.top, 12)

            if let mediaImage {
                mediaImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .clipped()
                    .padding(.top, 12)
            }

            LpspLinkedInReactionFooterRow(reactionCount: 127, commentCount: 14)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

            Divider().background(LpspLinkedInTokens.liDividerSubtle)

            LpspLinkedInActionBar()
                .frame(height: 44)
        }
        .background(LpspLinkedInTokens.liCardSurface)
    }
}

fileprivate struct LpspLinkedInAvatarView: View {
    let size: CGFloat
    let isPremium: Bool
    let isOpenToWork: Bool
    var imageName: String = "person.crop.circle.fill"

    var body: some View {
        ZStack {
            // Premium gold gradient frame
            if isPremium {
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: [LpspLinkedInTokens.liPremiumGold, LpspLinkedInTokens.liPremiumGoldHi],
                            startPoint: .bottom,
                            endPoint: .top
                        ),
                        lineWidth: 4
                    )
                    .frame(width: size + 4, height: size + 4)
            }

            // Open to Work ring (can layer over premium)
            if isOpenToWork {
                Circle()
                    .strokeBorder(LpspLinkedInTokens.liOpenToWork, lineWidth: 4)
                    .frame(width: size + 4, height: size + 4)
            }

            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }
}

fileprivate struct LpspLinkedInReactionPicker: View {
    @Binding var isShown: Bool
    let onSelect: (LpspLinkedInReaction) -> Void

    enum LpspLinkedInReaction: String, CaseIterable {
        case like = "hand.thumbsup.fill"
        case celebrate = "hands.clap.fill"
        case support = "heart.circle.fill"
        case love = "heart.fill"
        case insightful = "lightbulb.fill"
        case funny = "face.smiling.fill"

        var color: Color {
            switch self {
            case .like:       return LpspLinkedInTokens.liReactLike
            case .celebrate:  return LpspLinkedInTokens.liReactCelebrate
            case .support:    return LpspLinkedInTokens.liReactSupport
            case .love:       return LpspLinkedInTokens.liReactLove
            case .insightful: return LpspLinkedInTokens.liReactInsightful
            case .funny:      return LpspLinkedInTokens.liReactFunny
            }
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            ForEach(Array(LpspLinkedInReaction.allCases.enumerated()), id: \.offset) { index, reaction in
                Button {
                    onSelect(reaction)
                    isShown = false
                } label: {
                    Image(systemName: reaction.rawValue)
                        .font(.system(size: 22))
                        .foregroundStyle(reaction.color)
                        .frame(width: 40, height: 40)
                }
                .transition(.scale.combined(with: .opacity))
                .sensoryFeedback(.impact(flexibility: .soft), trigger: isShown)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule().fill(LpspLinkedInTokens.liCardSurface)
                .shadow(color: .black.opacity(0.12), radius: 16, y: 4)
        )
    }
}

fileprivate struct LpspLinkedInReactionFooterRow: View {
    let reactionCount: Int
    let commentCount: Int

    var body: some View {
        HStack {
            HStack(spacing: -8) {
                reactionBubble(LpspLinkedInTokens.liReactLike, icon: "hand.thumbsup.fill")
                reactionBubble(LpspLinkedInTokens.liReactCelebrate, icon: "hands.clap.fill")
                reactionBubble(LpspLinkedInTokens.liReactLove, icon: "heart.fill")
            }
            Text("\(reactionCount)")
                .font(LpspLinkedInFonts.liMeta)
                .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                .padding(.leading, 4)

            Spacer()

            Text("\(commentCount) comments")
                .font(LpspLinkedInFonts.liMeta)
                .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
        }
    }

    func reactionBubble(_ color: Color, icon: String) -> some View {
        ZStack {
            Circle().fill(color).frame(width: 20, height: 20)
            Image(systemName: icon)
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.white)
        }
        .overlay(Circle().stroke(LpspLinkedInTokens.liCardSurface, lineWidth: 2))
    }
}

fileprivate struct LpspLinkedInActionBar: View {
    @State private var isLiked = false

    var body: some View {
        HStack(spacing: 0) {
            actionButton(icon: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup",
                         label: "Like",
                         tint: isLiked ? LpspLinkedInTokens.liBlue : LpspLinkedInTokens.liTextSecondary) {
                isLiked.toggle()
            }
            actionButton(icon: "bubble.left", label: "Comment", tint: LpspLinkedInTokens.liTextSecondary) {}
            actionButton(icon: "arrow.2.squarepath", label: "Repost", tint: LpspLinkedInTokens.liTextSecondary) {}
            actionButton(icon: "paperplane", label: "Send", tint: LpspLinkedInTokens.liTextSecondary) {}
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isLiked)
    }

    func actionButton(icon: String, label: String, tint: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon).font(.system(size: 20))
                Text(label).font(LpspLinkedInFonts.liActionBar)
            }
            .foregroundStyle(tint)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


fileprivate struct LpspLinkedInLinkedInTopNav: View {
    @Binding var searchQuery: String

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(LpspLinkedInTokens.liBlue)
                .frame(width: 28, height: 28)
                .overlay {
                    Text("MR")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                }

            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                TextField("Search", text: $searchQuery)
                    .font(.system(size: 14))
            }
            .padding(.horizontal, 12)
            .frame(height: 40)
            .background(Capsule().fill(LpspLinkedInTokens.liDividerSubtle))

            Image(systemName: "message")
                .font(.system(size: 22))
                .foregroundStyle(LpspLinkedInTokens.liTextPrimary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(LpspLinkedInTokens.liCardSurface)
    }
}

fileprivate struct LpspLinkedInActionBarControlled: View {
    let isLiked: Bool
    let onLike: () -> Void
    var onComment: () -> Void = {}
    var onRepost: () -> Void = {}

    var body: some View {
        HStack(spacing: 0) {
            actionButton(
                icon: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup",
                label: "Like",
                tint: isLiked ? LpspLinkedInTokens.liBlue : LpspLinkedInTokens.liTextSecondary,
                action: onLike
            )
            actionButton(icon: "bubble.left", label: "Comment", tint: LpspLinkedInTokens.liTextSecondary, action: onComment)
            actionButton(icon: "arrow.2.squarepath", label: "Repost", tint: LpspLinkedInTokens.liTextSecondary, action: onRepost)
            actionButton(icon: "paperplane", label: "Send", tint: LpspLinkedInTokens.liTextSecondary) {}
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isLiked)
    }

    private func actionButton(icon: String, label: String, tint: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {

// MARK: - Showroom data & store

private enum LpspLinkedInShowroomTab: String, CaseIterable, Identifiable {
    case home, network, post, notifications, jobs

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .network: "Network"
        case .post: "Post"
        case .notifications: "Notifs"
        case .jobs: "Jobs"
        }
    }

    var systemImage: String {
        switch self {
        case .home: "house.fill"
        case .network: "person.2.fill"
        case .post: "plus.square.fill"
        case .notifications: "bell.fill"
        case .jobs: "briefcase.fill"
        }
    }
}

private struct LpspLinkedInFeedPost: Identifiable, Equatable {
    let id: String
    let authorName: String
    let connectionDegree: String
    let headline: String
    let timeAgo: String
    let postText: String
    let hasMedia: Bool
    let reactionCount: Int
    var commentCount: Int
    let isPremium: Bool
    let isOpenToWork: Bool
    var isLiked: Bool = false
    var reposted: Bool = false
}

private enum LpspLinkedInShowroomData {
    static let featuredPost = LpspLinkedInFeedPost(
        id: "lena",
        authorName: "Lena Parker",
        connectionDegree: "1st",
        headline: "Senior Product Designer at Stripe\nDesign Systems · Fintech",
        timeAgo: "2h •",
        postText: "Big milestone: shipped our design system v2.0 today. 18 months, 140+ components, one team.",
        hasMedia: true,
        reactionCount: 127,
        commentCount: 23,
        isPremium: true,
        isOpenToWork: false
    )

    static let networkSuggestions = [
        ("Jamie Cole", "Product Designer · Linear"),
        ("Kira Tan", "Engineering Manager · Notion"),
    ]

    static let notifications = [
        ("Lena Parker liked your comment", "2m"),
        ("New job match: Senior iOS Engineer", "1h"),
    ]

    static let jobs = [
        ("Senior iOS Engineer", "Stripe · San Francisco", "Promoted"),
        ("Design Systems Lead", "Figma · Remote", "Easy Apply"),
    ]
}

@MainActor
fileprivate final class LpspLinkedInStore: ObservableObject {
    @Published var selectedTab: LpspLinkedInShowroomTab = .home
    @Published var searchQuery = ""
    @Published var posts: [LpspLinkedInFeedPost] = [LpspLinkedInShowroomData.featuredPost]
    @Published var showCreateSheet = false
    @Published var newPostText = ""
    @Published var connectedIds: Set<String> = []

    func toggleLike(_ postId: String) {
        posts = posts.map { post in
            guard post.id == postId else { return post }
            var copy = post
            copy.isLiked.toggle()
            return copy
        }
    }

    func toggleRepost(_ postId: String) {
        posts = posts.map { post in
            guard post.id == postId else { return post }
            var copy = post
            copy.reposted.toggle()
            return copy
        }
    }

    func incrementComments(_ postId: String) {
        posts = posts.map { post in
            guard post.id == postId else { return post }
            var copy = post
            copy.commentCount += 1
            return copy
        }
    }

    func connect(_ id: String) {
        connectedIds.insert(id)
    }

    func publishPost() {
        let text = newPostText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        let post = LpspLinkedInFeedPost(
            id: "new-\(posts.count + 1)",
            authorName: "Alex Mercer",
            connectionDegree: "You",
            headline: "Product Designer · Showroom",
            timeAgo: "now •",
            postText: text,
            hasMedia: false,
            reactionCount: 0,
            commentCount: 0,
            isPremium: false,
            isOpenToWork: false
        )
        posts.insert(post, at: 0)
        newPostText = ""
        showCreateSheet = false
        selectedTab = .home
    }
}

// MARK: - Écrans showroom

private struct LpspLinkedInShowroomRoot: View {
    @ObservedObject var store: LpspLinkedInStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspLinkedInShowroomTab.allCases) { tab in
                LpspLinkedInShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .tint(LpspLinkedInTokens.liBlue)
        .preferredColorScheme(.light)
        .sheet(isPresented: $store.showCreateSheet) {
            LpspLinkedInCreateSheet(store: store)
        }
        .onChange(of: store.selectedTab) { _, tab in
            if tab == .post {
                store.showCreateSheet = true
                store.selectedTab = .home
            }
        }
    }
}

private struct LpspLinkedInShowroomTabScreen: View {
    @ObservedObject var store: LpspLinkedInStore
    let tab: LpspLinkedInShowroomTab

    var body: some View {
        Group {
            switch tab {
            case .home, .post:
                LpspLinkedInHomeTabScreen(store: store)
            case .network:
                LpspLinkedInNetworkTabScreen(store: store)
            case .notifications:
                LpspLinkedInNotificationsTabScreen()
            case .jobs:
                LpspLinkedInJobsTabScreen()
            }
        }
    }
}

private struct LpspLinkedInHomeTabScreen: View {
    @ObservedObject var store: LpspLinkedInStore

    var body: some View {
        VStack(spacing: 0) {
            LpspLinkedInLinkedInTopNav(searchQuery: $store.searchQuery)

            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(store.posts) { post in
                        LpspLinkedInShowroomPostCard(
                            post: post,
                            isLiked: store.posts.first(where: { $0.id == post.id })?.isLiked ?? false,
                            onLike: { store.toggleLike(post.id) },
                            onComment: { store.incrementComments(post.id) },
                            onRepost: { store.toggleRepost(post.id) }
                        )
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .background(LpspLinkedInTokens.liCanvas.ignoresSafeArea())
    }
}

private struct LpspLinkedInShowroomPostCard: View {
    let post: LpspLinkedInFeedPost
    let isLiked: Bool
    let onLike: () -> Void
    let onComment: () -> Void
    let onRepost: () -> Void

    private var reactionCount: Int {
        post.reactionCount + (isLiked ? 1 : 0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                LpspLinkedInAvatarView(size: 56, isPremium: post.isPremium, isOpenToWork: post.isOpenToWork)

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(post.authorName)
                            .font(LpspLinkedInFonts.liPostAuthor)
                            .foregroundStyle(LpspLinkedInTokens.liTextPrimary)
                        Text("· \(post.connectionDegree)")
                            .font(LpspLinkedInFonts.liMeta)
                            .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                    }
                    Text(post.headline)
                        .font(LpspLinkedInFonts.liHeadline)
                        .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                        .lineLimit(2)
                    HStack(spacing: 4) {
                        Text(post.timeAgo)
                            .font(LpspLinkedInFonts.liMeta)
                            .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                        Image(systemName: "globe.americas.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                    }
                }

                Spacer()

                Image(systemName: "ellipsis")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)

            Text(post.postText)
                .font(LpspLinkedInFonts.liPostBody)
                .foregroundStyle(LpspLinkedInTokens.liTextPrimary)
                .lineSpacing(4)
                .padding(.horizontal, 16)
                .padding(.top, 12)

            if post.hasMedia {
                LinearGradient(
                    colors: [
                        Color(red: 0.20, green: 0.12, blue: 0.30),
                        Color(red: 0.82, green: 0.29, blue: 0.45),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .padding(.top, 12)
            }

            LpspLinkedInReactionFooterRow(
                reactionCount: reactionCount,
                commentCount: post.commentCount
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

            Divider().background(LpspLinkedInTokens.liDividerSubtle)

            LpspLinkedInActionBarControlled(
                isLiked: isLiked,
                onLike: onLike,
                onComment: onComment,
                onRepost: onRepost
            )
            .frame(height: 44)
        }
        .background(LpspLinkedInTokens.liCardSurface)
    }
}

private struct LpspLinkedInNetworkTabScreen: View {
    @ObservedObject var store: LpspLinkedInStore

    var body: some View {
        NavigationStack {
            List {
                Section("People you may know") {
                    ForEach(LpspLinkedInShowroomData.networkSuggestions, id: \.0) { name, headline in
                        HStack(spacing: 12) {
                            LpspLinkedInAvatarView(size: 48, isPremium: false, isOpenToWork: false)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(name)
                                    .font(LpspLinkedInFonts.liPostAuthor)
                                Text(headline)
                                    .font(LpspLinkedInFonts.liHeadline)
                                    .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                            }
                            Spacer()
                            if store.connectedIds.contains(name) {
                                Text("Pending")
                                    .font(LpspLinkedInFonts.liButtonSecondary)
                                    .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                            } else {
                                LpspLinkedInLinkedInPillButton(title: "Connect", systemImage: "plus", variant: .outline) {
                                    store.connect(name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Network")
        }
    }
}

private struct LpspLinkedInNotificationsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(LpspLinkedInShowroomData.notifications, id: \.0) { title, time in
                    HStack(alignment: .top, spacing: 12) {
                        Circle()
                            .fill(LpspLinkedInTokens.liBlue)
                            .frame(width: 10, height: 10)
                            .padding(.top, 6)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(LpspLinkedInFonts.liPostAuthor)
                            Text(time)
                                .font(LpspLinkedInFonts.liMeta)
                                .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                        }
                    }
                }
            }
            .navigationTitle("Notifications")
        }
    }
}

private struct LpspLinkedInJobsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(LpspLinkedInShowroomData.jobs, id: \.0) { title, company, badge in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title)
                            .font(LpspLinkedInFonts.liPostAuthor)
                        Text(company)
                            .font(LpspLinkedInFonts.liHeadline)
                            .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                        Text(badge)
                            .font(LpspLinkedInFonts.liBadge)
                            .foregroundStyle(LpspLinkedInTokens.liBlue)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Jobs")
        }
    }
}

private struct LpspLinkedInCreateSheet: View {
    @ObservedObject var store: LpspLinkedInStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                TextField("What do you want to talk about?", text: $store.newPostText, axis: .vertical)
                    .font(LpspLinkedInFonts.liPostBody)
                    .lineLimit(4...8)

                LpspLinkedInLinkedInPillButton(title: "Post", systemImage: nil, variant: .filled) {
                    store.publishPost()
                    dismiss()
                }
                .disabled(store.newPostText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                Spacer()
            }
            .padding(20)
            .background(LpspLinkedInTokens.liCanvas.ignoresSafeArea())
            .navigationTitle("Create a post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        store.showCreateSheet = false
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}


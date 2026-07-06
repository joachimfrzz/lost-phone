import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/reddit
// Meliwat/awesome-ios-design-md/social/reddit/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeRedditView: View {
    var body: some View {
        LpspRedditShowroomRoot(store: LpspRedditStore())
    }
}

// MARK: - Composants spec (préfixés)
import UIKit
private enum LpspRedditTokens {
    // MARK: - Brand
    static let rdBrandRed        = Color(red: 1.000, green: 0.271, blue: 0.000) // #FF4500
    static let rdAlertRed        = Color(red: 1.000, green: 0.345, blue: 0.357) // #FF585B
    static let rdBrandRedPressed = Color(red: 0.800, green: 0.216, blue: 0.000) // #CC3700

    // MARK: - Vote Semantic Pair
    static let rdUpvote      = Color(red: 1.000, green: 0.529, blue: 0.090) // #FF8717
    static let rdUpvoteDark  = Color(red: 1.000, green: 0.667, blue: 0.400) // #FFAA66
    static let rdDownvote    = Color(red: 0.443, green: 0.576, blue: 1.000) // #7193FF
    static let rdDownvoteDark = Color(red: 0.580, green: 0.580, blue: 1.000) // #9494FF
    static let rdVoteInactive     = Color(red: 0.529, green: 0.541, blue: 0.549) // #878A8C
    static let rdVoteInactiveDark = Color(red: 0.506, green: 0.514, blue: 0.518) // #818384

    // MARK: - Canvas & Surface (Light)
    static let rdCanvasLight        = Color(red: 0.965, green: 0.969, blue: 0.973) // #F6F7F8
    static let rdCanvasClassicLight = Color(red: 0.855, green: 0.878, blue: 0.902) // #DAE0E6
    static let rdCardLight          = Color.white                                    // #FFFFFF
    static let rdSurface2Light      = Color(red: 0.949, green: 0.953, blue: 0.961)  // #F2F3F5
    static let rdDividerLight       = Color(red: 0.929, green: 0.937, blue: 0.945)  // #EDEFF1

    // MARK: - Canvas & Surface (Dark)
    static let rdCanvasDark    = Color(red: 0.102, green: 0.102, blue: 0.106) // #1A1A1B
    static let rdCardDark      = Color(red: 0.153, green: 0.153, blue: 0.161) // #272729
    static let rdSurface2Dark  = Color(red: 0.204, green: 0.208, blue: 0.212) // #343536
    static let rdDividerDark   = Color(red: 0.204, green: 0.208, blue: 0.212) // #343536

    // MARK: - Text
    static let rdTextPrimary       = Color(red: 0.102, green: 0.102, blue: 0.106) // #1A1A1B
    static let rdTextSecondary     = Color(red: 0.486, green: 0.486, blue: 0.486) // #7C7C7C
    static let rdTextTertiary      = Color(red: 0.686, green: 0.686, blue: 0.686) // #AFAFAF
    static let rdTextPrimaryDark   = Color(red: 0.843, green: 0.855, blue: 0.863) // #D7DADC
    static let rdTextSecondaryDark = Color(red: 0.506, green: 0.514, blue: 0.518) // #818384
    static let rdTextLink          = Color(red: 0.000, green: 0.475, blue: 0.827) // #0079D3

    // MARK: - Semantic
    static let rdSuccessGreen = Color(red: 0.275, green: 0.820, blue: 0.376) // #46D160
    static let rdWarningYellow = Color(red: 1.000, green: 0.690, blue: 0.000) // #FFB000
    static let rdNSFWYellow   = Color(red: 0.953, green: 0.698, blue: 0.000) // #F3B200
    static let rdGold         = Color(red: 1.000, green: 0.690, blue: 0.000) // #FFB000
    static let rdPremiumGold  = Color(red: 1.000, green: 0.839, blue: 0.208) // #FFD635
    static let rdSubredditDefault = Color(red: 0.000, green: 0.475, blue: 0.827) // #0079D3
}

private enum LpspRedditFonts {
    private static func rd(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        if UIFont(name: "RedditSans-Regular", size: size) != nil {
            let suffix: String = {
                switch weight {
                case .bold:     return "Bold"
                case .semibold: return "SemiBold"
                case .medium:   return "Medium"
                default:        return "Regular"
                }
            }()
            return .custom("RedditSans-\(suffix)", size: size)
        }
        return .system(size: size, weight: weight)
    }

    static let rdLargeTitle   = Font.system(size: 17, weight: .bold)
    static let rdPostTitle    = Font.system(size: 17, weight: .semibold)
    static let rdBody         = Font.system(size: 17, weight: .regular)
    static let rdMetadata     = Font.system(size: 17, weight: .regular)
    static let rdKarma        = Font.system(size: 17, weight: .bold)
    static let rdSubredditPill = Font.system(size: 17, weight: .semibold)
    static let rdFlairPill    = Font.system(size: 17, weight: .semibold)
    static let rdUsername     = Font.system(size: 17, weight: .medium)
    static let rdButton       = Font.system(size: 17, weight: .semibold)
    static let rdTabLabel     = Font.system(size: 17, weight: .medium)
    static let rdNavTitle     = Font.system(size: 17, weight: .semibold)
    static let rdSectionHeader = Font.system(size: 17, weight: .bold)
    static let rdCode         = Font.system(size: 13, weight: .regular)
}

fileprivate struct LpspRedditRDVoteColumn: View {
    enum VoteState { case none, up, down }

    @Binding var state: VoteState
    let baseKarma: Int

    @State private var upScale: CGFloat = 1.0
    @State private var downScale: CGFloat = 1.0

    private var displayedKarma: Int {
        switch state {
        case .up:   return baseKarma + 1
        case .down: return baseKarma - 1
        case .none: return baseKarma
        }
    }

    private var karmaColor: Color {
        switch state {
        case .up:   return LpspRedditTokens.rdUpvote
        case .down: return LpspRedditTokens.rdDownvote
        case .none: return LpspRedditTokens.rdVoteInactive
        }
    }

    var body: some View {
        VStack(spacing: 4) {
            Button {
                state = (state == .up) ? .none : .up
                bounce(&upScale)
            } label: {
                Image(systemName: state == .up ? "arrow.up.square.fill" : "arrow.up")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(state == .up ? LpspRedditTokens.rdUpvote : LpspRedditTokens.rdVoteInactive)
                    .scaleEffect(upScale)
            }
            .sensoryFeedback(.selection, trigger: state == .up)

            Text("\(displayedKarma)")
                .font(LpspRedditFonts.rdKarma)
                .foregroundStyle(karmaColor)
                .contentTransition(.numericText())
                .animation(.spring(response: 0.2, dampingFraction: 0.6), value: displayedKarma)

            Button {
                state = (state == .down) ? .none : .down
                bounce(&downScale)
            } label: {
                Image(systemName: state == .down ? "arrow.down.square.fill" : "arrow.down")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(state == .down ? LpspRedditTokens.rdDownvote : LpspRedditTokens.rdVoteInactive)
                    .scaleEffect(downScale)
            }
            .sensoryFeedback(.selection, trigger: state == .down)
        }
        .frame(width: 44)
    }

    private func bounce(_ value: inout CGFloat) {
        withAnimation(.spring(response: 0.18, dampingFraction: 0.55)) { value = 1.25 }
        withAnimation(.spring(response: 0.2, dampingFraction: 0.7).delay(0.18)) { value = 1.0 }
    }
}

fileprivate struct LpspRedditRDPostCard: View {
    let subredditName: String
    let subredditAvatar: Image?
    let subredditAccent: Color
    let timestamp: String
    let commentCount: Int
    let title: String
    let postText: String?
    let flairs: [LpspRedditRDFlair]
    let mediaUri: String?
    @State private var voteState: LpspRedditRDVoteColumn.VoteState = .none
    let baseKarma: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerRow
            Text(title).font(LpspRedditFonts.rdPostTitle).foregroundStyle(LpspRedditTokens.rdTextPrimary).lineLimit(3)
            if !flairs.isEmpty { flairRow }
            if let mediaUri, let url = URL(string: mediaUri) {
                AsyncImage(url: url) { $0.resizable().aspectRatio(16/9, contentMode: .fill) } placeholder: {
                    LpspRedditTokens.rdSurface2Light.frame(height: 200)
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            actionRow
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspRedditTokens.rdCardLight)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }

    private var headerRow: some View {
        HStack(spacing: 6) {
            (subredditAvatar ?? Image(systemName: "circle.fill"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .clipShape(Circle())
            Text("r/\(subredditName)").font(LpspRedditFonts.rdSubredditPill).foregroundStyle(LpspRedditTokens.rdTextPrimary)
            Text("•").font(LpspRedditFonts.rdMetadata).foregroundStyle(LpspRedditTokens.rdTextSecondary)
            Text(timestamp).font(LpspRedditFonts.rdMetadata).foregroundStyle(LpspRedditTokens.rdTextSecondary)
            Spacer()
            Button { } label: {
                Text("Join").font(LpspRedditFonts.rdButton).foregroundStyle(.white)
                    .padding(.horizontal, 12).padding(.vertical, 4)
                    .background(Capsule().fill(subredditAccent))
            }
        }
    }

    private var flairRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(flairs) { flair in LpspRedditRDFlairPillView(flair: flair) }
            }
        }
    }

    private var actionRow: some View {
        HStack(spacing: 16) {
            LpspRedditRDVoteColumn(state: $voteState, baseKarma: baseKarma)
            Spacer()
            HStack(spacing: 16) {
                actionIcon("text.bubble", "\(commentCount)")
                actionIcon("square.and.arrow.up", nil)
                actionIcon("bookmark", nil)
                actionIcon("ellipsis", nil)
            }
        }
    }

    private func actionIcon(_ systemName: String, _ text: String?) -> some View {
        HStack(spacing: 4) {
            Image(systemName: systemName).font(.system(size: 18))
            if let text {
                Text(text).font(LpspRedditFonts.rdMetadata)
            }
        }
        .foregroundStyle(LpspRedditTokens.rdTextSecondary)
    }
}

fileprivate struct LpspRedditRDFlair: Identifiable {
    let id = UUID()
    let text: String
    let background: Color
    let foreground: Color
    let emoji: String?
}

fileprivate struct LpspRedditRDFlairPillView: View {
    let flair: LpspRedditRDFlair
    var body: some View {
        HStack(spacing: 4) {
            if let emoji = flair.emoji {
                Text(emoji).font(.system(size: 11))
            }
            Text(flair.text).font(LpspRedditFonts.rdFlairPill)
        }
        .foregroundStyle(flair.foreground)
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        .background(RoundedRectangle(cornerRadius: 4).fill(flair.background))
    }
}

// Common system flairs
extension LpspRedditRDFlair {
    static let nsfw    = LpspRedditRDFlair(text: "NSFW",    background: LpspRedditTokens.rdNSFWYellow, foreground: .black, emoji: nil)
    static let spoiler = LpspRedditRDFlair(text: "SPOILER", background: .black,              foreground: .white, emoji: nil)
    static let oc      = LpspRedditRDFlair(text: "OC",      background: LpspRedditTokens.rdSuccessGreen, foreground: .white, emoji: nil)
}

fileprivate struct LpspRedditRDComment: Identifiable {
    let id = UUID()
    let username: String
    let karma: Int
    let timestamp: String
    let body: String
    let depth: Int
    let replies: [LpspRedditRDComment]
}

fileprivate struct LpspRedditRDCommentRow: View {
    let comment: LpspRedditRDComment
    @State private var isCollapsed = false

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(0..<comment.depth, id: \.self) { _ in
                Rectangle()
                    .fill(LpspRedditTokens.rdDividerLight)
                    .frame(width: 2)
                    .padding(.leading, 10)
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Button { isCollapsed.toggle() } label: {
                        Image(systemName: isCollapsed ? "plus.square" : "minus.square")
                            .font(.system(size: 12))
                            .foregroundStyle(LpspRedditTokens.rdTextSecondary)
                    }
                    Text("u/\(comment.username)").font(LpspRedditFonts.rdUsername).foregroundStyle(LpspRedditTokens.rdTextPrimary)
                    Text("•").font(LpspRedditFonts.rdMetadata).foregroundStyle(LpspRedditTokens.rdTextSecondary)
                    Text(comment.timestamp).font(LpspRedditFonts.rdMetadata).foregroundStyle(LpspRedditTokens.rdTextSecondary)
                    Text("•").font(LpspRedditFonts.rdMetadata).foregroundStyle(LpspRedditTokens.rdTextSecondary)
                    Text("\(comment.karma)").font(LpspRedditFonts.rdMetadata.weight(.medium)).foregroundStyle(LpspRedditTokens.rdTextSecondary)
                }

                if !isCollapsed {
                    Text(comment.body).font(LpspRedditFonts.rdBody).foregroundStyle(LpspRedditTokens.rdTextPrimary).lineSpacing(4)
                    actionRow
                }
            }
            .padding(.leading, 8)
            .padding(.vertical, 10)
        }
    }

    private var actionRow: some View {
        HStack(spacing: 16) {
            Image(systemName: "arrow.up").font(.system(size: 14))
            Image(systemName: "arrow.down").font(.system(size: 14))
            Image(systemName: "arrowshape.turn.up.left").font(.system(size: 14))
            Image(systemName: "square.and.arrow.up").font(.system(size: 14))
            Image(systemName: "ellipsis").font(.system(size: 14))
        }
        .foregroundStyle(LpspRedditTokens.rdTextSecondary)
    }
}

fileprivate struct LpspRedditRDSubredditBanner: View {
    let subredditName: String
    let memberCount: String
    let bannerUri: String?
    let avatarUri: String?
    let accentColor: Color
    @State private var joined = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                Group {
                    if let bannerUri, let url = URL(string: bannerUri) {
                        AsyncImage(url: url) { $0.resizable().aspectRatio(contentMode: .fill) } placeholder: {
                            accentColor
                        }
                    } else {
                        accentColor
                    }
                }
                .frame(height: 160)
                .clipped()

                AsyncImage(url: URL(string: avatarUri ?? "")) { $0.resizable() } placeholder: {
                    Circle().fill(accentColor)
                }
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                .offset(x: 16, y: 36)
            }
            .frame(height: 160)
            .overlay(alignment: .topTrailing) {
                Button { joined.toggle() } label: {
                    Label(joined ? "Joined" : "Join", systemImage: joined ? "checkmark" : "plus")
                        .font(LpspRedditFonts.rdButton)
                        .foregroundStyle(joined ? accentColor : .white)
                        .padding(.horizontal, 16).padding(.vertical, 6)
                        .background(Capsule().fill(joined ? Color.white : accentColor))
                        .overlay(Capsule().stroke(accentColor, lineWidth: joined ? 1.5 : 0))
                }
                .padding(16)
                .sensoryFeedback(.success, trigger: joined)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("r/\(subredditName)").font(LpspRedditFonts.rdLargeTitle).foregroundStyle(LpspRedditTokens.rdTextPrimary)
                Text(memberCount).font(LpspRedditFonts.rdMetadata).foregroundStyle(LpspRedditTokens.rdTextSecondary)
            }
            .padding(.top, 48)
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}


fileprivate struct LpspRedditRDSubredditContext {
    var accentColor: Color = LpspRedditTokens.rdSubredditDefault // #0079D3
    var displayName: String
    var isDark: Bool = false
}

// Pass via .environment or as an init parameter to LpspRedditRDPostCard / LpspRedditRDSubredditBanner


// MARK: - Showroom data & store

private enum LpspRedditShowroomTab: String, CaseIterable, Identifiable {
    case home, popular, create, chat, inbox

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .popular: "Popular"
        case .create: "Create"
        case .chat: "Chat"
        case .inbox: "Inbox"
        }
    }

    var systemImage: String {
        switch self {
        case .home: "house.fill"
        case .popular: "globe"
        case .create: "plus"
        case .chat: "bubble.left.and.bubble.right.fill"
        case .inbox: "bell.fill"
        }
    }
}

private struct LpspRedditFeedPost: Identifiable, Equatable {
    let id: String
    let subreddit: String
    let subredditInitial: String
    let subredditAccent: Color
    let timestamp: String
    let title: String
    let flairs: [LpspRedditRDFlair]
    let baseKarma: Int
    let karmaLabel: String
    let commentCount: Int
    let commentLabel: String
    let hasMedia: Bool
    var voteState: LpspRedditRDVoteColumn.VoteState = .none
    var saved = false
    var joined = false
}

private enum LpspRedditShowroomData {
    static let profileInitials = ("MS", "AV")

    static var feedPosts: [LpspRedditFeedPost] {
        [
            .init(
                id: "crow",
                subreddit: "dataisbeautiful",
                subredditInitial: "d",
                subredditAccent: LpspRedditTokens.rdSubredditDefault,
                timestamp: "3h",
                title: "Why crow populations dropped in North American cities over the last 30 years",
                flairs: [.oc],
                baseKarma: 4200,
                karmaLabel: "4.2k",
                commentCount: 342,
                commentLabel: "342",
                hasMedia: true,
                voteState: .up
            ),
            .init(
                id: "skill",
                subreddit: "AskReddit",
                subredditInitial: "a",
                subredditAccent: Color(red: 0.961, green: 0.541, blue: 0.259),
                timestamp: "5h",
                title: "What's a skill you picked up that you thought would be useless, but completely changed your life?",
                flairs: [],
                baseKarma: 892,
                karmaLabel: "892",
                commentCount: 1200,
                commentLabel: "1.2k",
                hasMedia: false
            ),
        ]
    }

    static let popularSubs = ["r/technology", "r/worldnews", "r/gaming", "r/design"]
    static let inboxItems = [
        ("Comment reply", "u/kellenvoss replied to your comment", "2m"),
        ("Trending post", "r/dataisbeautiful is trending near you", "1h"),
    ]
    static let chatThreads = [
        ("Jamie Cole", "Did you see the crow chart?", "now"),
        ("Design Daily", "Weekly roundup is live", "3h"),
    ]
}

@MainActor
fileprivate final class LpspRedditStore: ObservableObject {
    @Published var selectedTab: LpspRedditShowroomTab = .home
    @Published var searchQuery = ""
    @Published var posts = LpspRedditShowroomData.feedPosts
    @Published var showCreateSheet = false
    @Published var newPostTitle = ""

    func setVote(_ postId: String, state: LpspRedditRDVoteColumn.VoteState) {
        posts = posts.map { post in
            guard post.id == postId else { return post }
            var copy = post
            copy.voteState = state
            return copy
        }
    }

    func toggleSave(_ postId: String) {
        posts = posts.map { post in
            guard post.id == postId else { return post }
            var copy = post
            copy.saved.toggle()
            return copy
        }
    }

    func toggleJoin(_ postId: String) {
        posts = posts.map { post in
            guard post.id == postId else { return post }
            var copy = post
            copy.joined.toggle()
            return copy
        }
    }

    func publishPost() {
        let title = newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return }
        let post = LpspRedditFeedPost(
            id: "new-\(posts.count + 1)",
            subreddit: "showroom",
            subredditInitial: "s",
            subredditAccent: LpspRedditTokens.rdBrandRed,
            timestamp: "now",
            title: title,
            flairs: [],
            baseKarma: 1,
            karmaLabel: "1",
            commentCount: 0,
            commentLabel: "0",
            hasMedia: false
        )
        posts.insert(post, at: 0)
        newPostTitle = ""
        showCreateSheet = false
        selectedTab = .home
    }
}

// MARK: - Écrans showroom

private struct LpspRedditShowroomRoot: View {
    @ObservedObject var store: LpspRedditStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspRedditShowroomTab.allCases) { tab in
                LpspRedditShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        if tab == .create {
                            Label(tab.title, systemImage: "plus.circle.fill")
                        } else {
                            Label(tab.title, systemImage: tab.systemImage)
                        }
                    }
                    .tag(tab)
            }
        }
        .tint(LpspRedditTokens.rdBrandRed)
        .preferredColorScheme(.light)
        .sheet(isPresented: $store.showCreateSheet) {
            LpspRedditCreateSheet(store: store)
        }
        .onChange(of: store.selectedTab) { _, tab in
            if tab == .create {
                store.showCreateSheet = true
                store.selectedTab = .home
            }
        }
    }
}

private struct LpspRedditShowroomTabScreen: View {
    @ObservedObject var store: LpspRedditStore
    let tab: LpspRedditShowroomTab

    var body: some View {
        Group {
            switch tab {
            case .home, .popular:
                LpspRedditHomeTabScreen(store: store, title: tab == .popular ? "Popular" : "Home")
            case .create:
                LpspRedditHomeTabScreen(store: store, title: "Home")
            case .chat:
                LpspRedditChatTabScreen()
            case .inbox:
                LpspRedditInboxTabScreen()
            }
        }
    }
}

private struct LpspRedditHomeTabScreen: View {
    @ObservedObject var store: LpspRedditStore
    let title: String

    var body: some View {
        VStack(spacing: 0) {
            LpspRedditTopNav(searchQuery: $store.searchQuery)

            ScrollView {
                LazyVStack(spacing: 10) {
                    if title == "Popular" {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(LpspRedditShowroomData.popularSubs, id: \.self) { sub in
                                    Text(sub)
                                        .font(LpspRedditFonts.rdFlairPill)
                                        .foregroundStyle(LpspRedditTokens.rdTextPrimary)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Capsule().fill(LpspRedditTokens.rdSurface2Light))
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.bottom, 4)
                    }

                    ForEach(store.posts) { post in
                        LpspRedditSpectrPostCard(
                            post: post,
                            voteState: Binding(
                                get: {
                                    store.posts.first(where: { $0.id == post.id })?.voteState ?? .none
                                },
                                set: { store.setVote(post.id, state: $0) }
                            ),
                            saved: store.posts.first(where: { $0.id == post.id })?.saved ?? false,
                            joined: store.posts.first(where: { $0.id == post.id })?.joined ?? false,
                            onSave: { store.toggleSave(post.id) },
                            onJoin: { store.toggleJoin(post.id) }
                        )
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .background(LpspRedditTokens.rdCanvasLight.ignoresSafeArea())
    }
}

private struct LpspRedditTopNav: View {
    @Binding var searchQuery: String

    var body: some View {
        HStack(spacing: 12) {
            LpspRedditAvatar(initials: LpspRedditShowroomData.profileInitials.0)

            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(LpspRedditTokens.rdTextSecondary)
                TextField("Search Reddit", text: $searchQuery)
                    .font(LpspRedditFonts.rdBody)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(LpspRedditTokens.rdCardLight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .strokeBorder(LpspRedditTokens.rdDividerLight, lineWidth: 1)
                    )
            )

            LpspRedditAvatar(initials: LpspRedditShowroomData.profileInitials.1)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(LpspRedditTokens.rdCanvasLight)
    }
}

private struct LpspRedditAvatar: View {
    let initials: String

    var body: some View {
        Circle()
            .fill(LpspRedditTokens.rdSurface2Light)
            .frame(width: 32, height: 32)
            .overlay {
                Text(initials)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(LpspRedditTokens.rdTextPrimary)
            }
    }
}

private struct LpspRedditSpectrPostCard: View {
    let post: LpspRedditFeedPost
    @Binding var voteState: LpspRedditRDVoteColumn.VoteState
    let saved: Bool
    let joined: Bool
    let onSave: () -> Void
    let onJoin: () -> Void

    private var displayedKarmaLabel: String {
        switch voteState {
        case .up:
            return post.baseKarma >= 1000 ? String(format: "%.1fk", Double(post.baseKarma + 1) / 1000.0) : "\(post.baseKarma + 1)"
        case .down:
            return post.baseKarma >= 1000 ? String(format: "%.1fk", Double(post.baseKarma - 1) / 1000.0) : "\(post.baseKarma - 1)"
        case .none:
            return post.karmaLabel
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 4) {
                Button {
                    voteState = voteState == .up ? .none : .up
                } label: {
                    Image(systemName: voteState == .up ? "arrow.up.square.fill" : "arrow.up")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(voteState == .up ? LpspRedditTokens.rdUpvote : LpspRedditTokens.rdVoteInactive)
                }

                Text(displayedKarmaLabel)
                    .font(LpspRedditFonts.rdKarma)
                    .foregroundStyle(voteState == .up ? LpspRedditTokens.rdUpvote : LpspRedditTokens.rdTextPrimary)

                Button {
                    voteState = voteState == .down ? .none : .down
                } label: {
                    Image(systemName: voteState == .down ? "arrow.down.square.fill" : "arrow.down")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(voteState == .down ? LpspRedditTokens.rdDownvote : LpspRedditTokens.rdVoteInactive)
                }
            }
            .frame(width: 44)
            .padding(.top, 12)
            .padding(.leading, 4)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Circle()
                        .fill(post.subredditAccent)
                        .frame(width: 20, height: 20)
                        .overlay {
                            Text(post.subredditInitial)
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    Text("r/\(post.subreddit)")
                        .font(LpspRedditFonts.rdSubredditPill)
                        .foregroundStyle(LpspRedditTokens.rdTextPrimary)
                    Text("•")
                        .foregroundStyle(LpspRedditTokens.rdTextSecondary)
                    Text(post.timestamp)
                        .font(LpspRedditFonts.rdMetadata)
                        .foregroundStyle(LpspRedditTokens.rdTextSecondary)
                    Spacer()
                    if joined {
                        Text("Joined")
                            .font(LpspRedditFonts.rdButton)
                            .foregroundStyle(post.subredditAccent)
                    } else {
                        Button("Join", action: onJoin)
                            .font(LpspRedditFonts.rdButton)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(post.subredditAccent))
                    }
                }

                if !post.flairs.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(post.flairs) { flair in
                            LpspRedditRDFlairPillView(flair: flair)
                        }
                    }
                }

                Text(post.title)
                    .font(LpspRedditFonts.rdPostTitle)
                    .foregroundStyle(LpspRedditTokens.rdTextPrimary)
                    .lineLimit(4)

                if post.hasMedia {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.18, green: 0.22, blue: 0.28),
                                    Color(red: 0.32, green: 0.36, blue: 0.42),
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 180)
                        .overlay {
                            Text("🐦‍⬛")
                                .font(.system(size: 56))
                        }
                }

                HStack(spacing: 18) {
                    Label(post.commentLabel, systemImage: "text.bubble")
                    Label("Share", systemImage: "square.and.arrow.up")
                    Button(action: onSave) {
                        Label(saved ? "Saved" : "Save", systemImage: saved ? "bookmark.fill" : "bookmark")
                    }
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .font(LpspRedditFonts.rdMetadata)
                .foregroundStyle(LpspRedditTokens.rdTextSecondary)
            }
            .padding(12)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LpspRedditTokens.rdCardLight)
        )
        .padding(.horizontal, 12)
    }
}

private struct LpspRedditChatTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(LpspRedditShowroomData.chatThreads, id: \.0) { name, preview, time in
                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspRedditTokens.rdBrandRed.opacity(0.15))
                            .frame(width: 44, height: 44)
                            .overlay {
                                Image(systemName: "bubble.left.and.bubble.right.fill")
                                    .foregroundStyle(LpspRedditTokens.rdBrandRed)
                            }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(name)
                                .font(LpspRedditFonts.rdUsername)
                            Text(preview)
                                .font(LpspRedditFonts.rdMetadata)
                                .foregroundStyle(LpspRedditTokens.rdTextSecondary)
                                .lineLimit(1)
                        }
                        Spacer()
                        Text(time)
                            .font(LpspRedditFonts.rdMetadata)
                            .foregroundStyle(LpspRedditTokens.rdTextSecondary)
                    }
                }
            }
            .navigationTitle("Chat")
        }
    }
}

private struct LpspRedditInboxTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(LpspRedditShowroomData.inboxItems, id: \.0) { title, body, time in
                    HStack(alignment: .top, spacing: 12) {
                        Circle()
                            .fill(LpspRedditTokens.rdBrandRed)
                            .frame(width: 10, height: 10)
                            .padding(.top, 6)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(LpspRedditFonts.rdUsername)
                            Text(body)
                                .font(LpspRedditFonts.rdMetadata)
                                .foregroundStyle(LpspRedditTokens.rdTextSecondary)
                        }
                        Spacer()
                        Text(time)
                            .font(LpspRedditFonts.rdMetadata)
                            .foregroundStyle(LpspRedditTokens.rdTextSecondary)
                    }
                }
            }
            .navigationTitle("Inbox")
        }
    }
}

private struct LpspRedditCreateSheet: View {
    @ObservedObject var store: LpspRedditStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                TextField("Title", text: $store.newPostTitle, axis: .vertical)
                    .font(LpspRedditFonts.rdPostTitle)
                    .lineLimit(3...6)

                Text("r/showroom")
                    .font(LpspRedditFonts.rdSubredditPill)
                    .foregroundStyle(LpspRedditTokens.rdTextSecondary)

                Button {
                    store.publishPost()
                    dismiss()
                } label: {
                    Text("Post")
                        .font(LpspRedditFonts.rdButton)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(RoundedRectangle(cornerRadius: 24).fill(LpspRedditTokens.rdBrandRed))
                }
                .disabled(store.newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                Spacer()
            }
            .padding(20)
            .background(LpspRedditTokens.rdCanvasLight.ignoresSafeArea())
            .navigationTitle("Create post")
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
        .presentationDetents([.medium])
    }
}


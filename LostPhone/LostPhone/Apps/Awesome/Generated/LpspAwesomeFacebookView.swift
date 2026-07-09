import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/facebook
// Meliwat/awesome-ios-design-md/social/facebook/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeFacebookView: View {
    var body: some View {
        LpspFacebookShowroomRoot(store: LpspFacebookStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspFacebookTokens {
    // MARK: - Canvas & Surfaces (Light)
    static let fbCanvas           = Color(red: 0.941, green: 0.949, blue: 0.961) // #F0F2F5
    static let fbCard             = Color.white                                   // #FFFFFF
    static let fbSurfaceTint      = Color(red: 0.969, green: 0.973, blue: 0.980) // #F7F8FA
    static let fbDivider          = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
    static let fbSeparator        = Color(red: 0.808, green: 0.816, blue: 0.831) // #CED0D4

    // MARK: - Canvas & Surfaces (Dark)
    static let fbDarkCanvas       = Color(red: 0.094, green: 0.098, blue: 0.102) // #18191A
    static let fbDarkCard         = Color(red: 0.141, green: 0.145, blue: 0.149) // #242526
    static let fbDarkSurfaceTint  = Color(red: 0.227, green: 0.231, blue: 0.235) // #3A3B3C
    static let fbDarkDivider      = Color(red: 0.243, green: 0.251, blue: 0.259) // #3E4042

    // MARK: - Text
    static let fbTextPrimaryLight   = Color(red: 0.020, green: 0.020, blue: 0.020) // #050505
    static let fbTextPrimaryDark    = Color(red: 0.894, green: 0.902, blue: 0.922) // #E4E6EB
    static let fbTextSecondaryLight = Color(red: 0.396, green: 0.404, blue: 0.420) // #65676B
    static let fbTextSecondaryDark  = Color(red: 0.690, green: 0.702, blue: 0.722) // #B0B3B8
    static let fbTextTertiary       = Color(red: 0.541, green: 0.553, blue: 0.569) // #8A8D91

    // MARK: - Brand
    static let fbBlue             = Color(red: 0.094, green: 0.467, blue: 0.949) // #1877F2
    static let fbBluePressed      = Color(red: 0.039, green: 0.373, blue: 0.784) // #0A5FC8
    static let fbBlueLight        = Color(red: 0.906, green: 0.953, blue: 1.000) // #E7F3FF

    // MARK: - Reactions
    static let fbLikeBlue         = Color(red: 0.094, green: 0.467, blue: 0.949) // #1877F2 (same as Blue)
    static let fbLovePink         = Color(red: 0.953, green: 0.259, blue: 0.373) // #F3425F
    static let fbCareYellow       = Color(red: 0.969, green: 0.725, blue: 0.157) // #F7B928
    static let fbHahaYellow       = Color(red: 0.969, green: 0.725, blue: 0.157) // #F7B928
    static let fbWowYellow        = Color(red: 0.969, green: 0.725, blue: 0.157) // #F7B928
    static let fbSadYellow        = Color(red: 0.969, green: 0.725, blue: 0.157) // #F7B928
    static let fbAngryOrange      = Color(red: 0.914, green: 0.443, blue: 0.059) // #E9710F

    // MARK: - Semantic
    static let fbLiveRed          = Color(red: 0.980, green: 0.243, blue: 0.243) // #FA3E3E
    static let fbErrorRed         = Color(red: 0.980, green: 0.220, blue: 0.243) // #FA383E
    static let fbSuccessGreen     = Color(red: 0.259, green: 0.718, blue: 0.165) // #42B72A
}

private enum LpspFacebookFonts {
    // Display (20pt+) — SF Pro Display automatic
    static let fbFLogo         = Font.system(size: 22, weight: .black)
    static let fbScreenTitle   = Font.system(size: 24, weight: .bold)
    static let fbSectionHeader = Font.system(size: 20, weight: .bold)

    // Text (<20pt) — SF Pro Text automatic
    static let fbDisplayName   = Font.system(size: 15, weight: .semibold)
    static let fbPostBody      = Font.system(size: 15, weight: .regular)
    static let fbPostBodyLarge = Font.system(size: 24, weight: .semibold)
    static let fbCommentBody   = Font.system(size: 14, weight: .regular)
    static let fbCommentName   = Font.system(size: 13, weight: .semibold)
    static let fbTimestamp     = Font.system(size: 13, weight: .regular)
    static let fbReactionCount = Font.system(size: 13, weight: .regular)
    static let fbActionLabel   = Font.system(size: 15, weight: .semibold)
    static let fbCTA           = Font.system(size: 17, weight: .semibold)
    static let fbTabLabel      = Font.system(size: 11, weight: .medium)
    static let fbSponsored     = Font.system(size: 13, weight: .regular)
    static let fbLiveBadge     = Font.system(size: 10, weight: .bold)
}

fileprivate struct LpspFacebookFBPostCard: View {
    let displayName: String
    let timestamp: String
    let audience: String // "Public", "Friends"
    let avatar: Image
    let postText: String
    let media: Image?
    @State private var userReaction: LpspFacebookFBReaction? = nil
    @State private var showReactions = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack(spacing: 8) {
                avatar.resizable().frame(width: 40, height: 40).clipShape(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text(displayName)
                        .font(LpspFacebookFonts.fbDisplayName)
                        .foregroundStyle(LpspFacebookTokens.fbTextPrimaryLight)
                    HStack(spacing: 4) {
                        Text(timestamp).font(LpspFacebookFonts.fbTimestamp).foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                        Text("·").foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                        Image(systemName: "globe.americas.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                        Text(audience).font(LpspFacebookFonts.fbTimestamp).foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                    }
                }
                Spacer()
                Button { } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                }
            }
            .padding(12)

            // Body
            Text(postText)
                .font(LpspFacebookFonts.fbPostBody)
                .foregroundStyle(LpspFacebookTokens.fbTextPrimaryLight)
                .padding(.horizontal, 12)
                .padding(.bottom, 12)

            // Media
            if let media {
                media.resizable().aspectRatio(contentMode: .fit)
            }

            // Reaction summary
            HStack(spacing: 6) {
                HStack(spacing: -4) {
                    Circle().fill(LpspFacebookTokens.fbLikeBlue).frame(width: 18, height: 18).overlay(Image(systemName: "hand.thumbsup.fill").font(.system(size: 9)).foregroundStyle(.white))
                    Circle().fill(LpspFacebookTokens.fbLovePink).frame(width: 18, height: 18).overlay(Image(systemName: "heart.fill").font(.system(size: 9)).foregroundStyle(.white))
                }
                Text("You, Sarah, and 45 others").font(LpspFacebookFonts.fbReactionCount).foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                Spacer()
                Text("12 comments · 3 shares").font(LpspFacebookFonts.fbReactionCount).foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)

            Divider().background(LpspFacebookTokens.fbDivider)

            // Action row
            HStack(spacing: 0) {
                LpspFacebookFBActionButton(icon: userReaction?.symbol ?? "hand.thumbsup",
                               label: userReaction?.label ?? "Like",
                               color: userReaction?.color ?? LpspFacebookTokens.fbTextSecondaryLight,
                               onTap: {
                                   userReaction = userReaction == nil ? .like : nil
                               },
                               onLongPress: { showReactions = true })
                LpspFacebookFBActionButton(icon: "bubble.left", label: "Comment", color: LpspFacebookTokens.fbTextSecondaryLight, onTap: {}, onLongPress: {})
                LpspFacebookFBActionButton(icon: "arrowshape.turn.up.right", label: "Share", color: LpspFacebookTokens.fbTextSecondaryLight, onTap: {}, onLongPress: {})
            }
            .padding(.vertical, 4)

            if showReactions {
                LpspFacebookReactionsPopover(selected: $userReaction, isShown: $showReactions)
            }
        }
        .background(LpspFacebookTokens.fbCard)
        .cornerRadius(8)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
}

fileprivate struct LpspFacebookFBActionButton: View {
    let icon: String
    let label: String
    let color: Color
    let onTap: () -> Void
    let onLongPress: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(color)
                Text(label)
                    .font(LpspFacebookFonts.fbActionLabel)
                    .foregroundStyle(color)
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .contentShape(Rectangle())
        }
        .onLongPressGesture(minimumDuration: 0.4, perform: onLongPress)
        .sensoryFeedback(.impact(flexibility: .soft), trigger: label)
    }
}

fileprivate enum LpspFacebookFBReaction: String, CaseIterable, Identifiable {
    case like, love, care, haha, wow, sad, angry
    var id: String { rawValue }
    var label: String {
        switch self {
        case .like: "Like"; case .love: "Love"; case .care: "Care"
        case .haha: "Haha"; case .wow: "Wow";   case .sad: "Sad";    case .angry: "Angry"
        }
    }
    var symbol: String {  // SF Symbol approximation
        switch self {
        case .like:  "hand.thumbsup.fill"
        case .love:  "heart.fill"
        case .care:  "hands.sparkles.fill"
        case .haha:  "face.smiling.fill"
        case .wow:   "mouth.fill"
        case .sad:   "face.dashed.fill"
        case .angry: "flame.fill"
        }
    }
    var color: Color {
        switch self {
        case .like:  LpspFacebookTokens.fbLikeBlue
        case .love:  LpspFacebookTokens.fbLovePink
        case .care, .haha, .wow, .sad: LpspFacebookTokens.fbHahaYellow
        case .angry: LpspFacebookTokens.fbAngryOrange
        }
    }
}

fileprivate struct LpspFacebookReactionsPopover: View {
    @Binding var selected: LpspFacebookFBReaction?
    @Binding var isShown: Bool
    @State private var hoveredIndex: Int? = nil

    var body: some View {
        HStack(spacing: 4) {
            ForEach(Array(LpspFacebookFBReaction.allCases.enumerated()), id: \.offset) { i, reaction in
                Image(systemName: reaction.symbol)
                    .font(.system(size: 28))
                    .foregroundStyle(reaction.color)
                    .frame(width: 48, height: 48)
                    .scaleEffect(hoveredIndex == i ? 1.3 : 1.0)
                    .animation(.spring(response: 0.25), value: hoveredIndex)
                    .onTapGesture {
                        selected = reaction
                        isShown = false
                    }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            Capsule().fill(LpspFacebookTokens.fbCard)
                .shadow(color: .black.opacity(0.2), radius: 16, y: 4)
        )
        .sensoryFeedback(.selection, trigger: hoveredIndex)
        .transition(.scale.combined(with: .opacity))
    }
}

fileprivate struct LpspFacebookFBTopNav: View {
    var body: some View {
        HStack {
            // Blue "f" logo in rounded square
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LpspFacebookTokens.fbBlue)
                    .frame(width: 36, height: 36)
                Text("f")
                    .font(LpspFacebookFonts.fbFLogo)
                    .foregroundStyle(.white)
                    .offset(y: -1)
            }

            Spacer()

            HStack(spacing: 8) {
                LpspFacebookFBCircleIconButton(system: "magnifyingglass")
                LpspFacebookFBCircleIconButton(system: "ellipsis.message.fill")
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(LpspFacebookTokens.fbCard)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspFacebookTokens.fbDivider).frame(height: 1)
        }
    }
}

fileprivate struct LpspFacebookFBCircleIconButton: View {
    let system: String
    var body: some View {
        Button { } label: {
            Image(systemName: system)
                .font(.system(size: 18))
                .foregroundStyle(LpspFacebookTokens.fbTextPrimaryLight)
                .frame(width: 36, height: 36)
                .background(Circle().fill(LpspFacebookTokens.fbDivider))
        }
    }
}

fileprivate struct LpspFacebookReactionsLongPressModifier: ViewModifier {
    @Binding var selection: LpspFacebookFBReaction?
    @State private var showPopover = false
    @State private var dragIndex: Int? = nil

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.4)
                    .onEnded { _ in
                        showPopover = true
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        guard showPopover else { return }
                        let x = value.location.x
                        let idx = min(max(Int(x / 48), 0), LpspFacebookFBReaction.allCases.count - 1)
                        if idx != dragIndex {
                            dragIndex = idx
                            UISelectionFeedbackGenerator().selectionChanged()
                        }
                    }
                    .onEnded { _ in
                        if let i = dragIndex, showPopover {
                            selection = LpspFacebookFBReaction.allCases[i]
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                        showPopover = false
                        dragIndex = nil
                    }
            )
            .overlay(alignment: .top) {
                if showPopover {
                    LpspFacebookReactionsPopover(selected: $selection, isShown: $showPopover)
                        .offset(y: -56)
                }
            }
    }
}

fileprivate extension View {
    func fbReactions(selection: Binding<LpspFacebookFBReaction?>) -> some View {
        modifier(LpspFacebookReactionsLongPressModifier(selection: selection))
    }
}



// MARK: - Showroom data & store

private enum LpspFacebookShowroomTab: String, CaseIterable, Identifiable {
    case home, video, marketplace, alerts, menu

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: "Home"
        case .video: "Video"
        case .marketplace: "Market"
        case .alerts: "Alerts"
        case .menu: "Menu"
        }
    }

    var systemImage: String {
        switch self {
        case .home: "house.fill"
        case .video: "play.rectangle.fill"
        case .marketplace: "cart.fill"
        case .alerts: "bell.fill"
        case .menu: "line.3.horizontal"
        }
    }
}

private struct LpspFacebookFeedPost: Identifiable, Equatable {
    let id: String
    let displayName: String
    let timestamp: String
    let postText: String
    let hasMedia: Bool
    let reactionSummary: String
    var commentCount: Int
    var userReaction: LpspFacebookFBReaction?
}

private enum LpspFacebookShowroomData {
    static let featuredPost = LpspFacebookFeedPost(
        id: "sarah",
        displayName: "Sarah Johnson",
        timestamp: "2h ·",
        postText: "Golden hour on the walk home. Can't believe we almost didn't go outside today.",
        hasMedia: true,
        reactionSummary: "You, Maya and 1.2K others",
        commentCount: 84,
        userReaction: .like
    )

    static let marketplaceItems = [
        ("Vintage camera", "$120 · 2 mi"),
        ("Standing desk", "$180 · 5 mi"),
    ]

    static let menuItems = ["Groups", "Events", "Saved", "Settings"]
}

@MainActor
fileprivate final class LpspFacebookStore: ObservableObject {
    @Published var selectedTab: LpspFacebookShowroomTab = .home
    @Published var posts: [LpspFacebookFeedPost] = [LpspFacebookShowroomData.featuredPost]
    @Published var showReactionsForPostId: String?
    @Published var alertCount = 9

    func setReaction(_ postId: String, reaction: LpspFacebookFBReaction?) {
        posts = posts.map { post in
            guard post.id == postId else { return post }
            var copy = post
            copy.userReaction = reaction
            return copy
        }
        showReactionsForPostId = nil
    }

    func toggleLike(_ postId: String) {
        posts = posts.map { post in
            guard post.id == postId else { return post }
            var copy = post
            copy.userReaction = copy.userReaction == nil ? .like : nil
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

    func openReactions(_ postId: String) {
        showReactionsForPostId = postId
    }

    func dismissReactions() {
        showReactionsForPostId = nil
    }
}

// MARK: - Écrans showroom

private struct LpspFacebookShowroomRoot: View {
    @ObservedObject var store: LpspFacebookStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspFacebookShowroomTab.allCases) { tab in
                LpspFacebookShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
                    .badge(tab == .alerts ? store.alertCount : 0)
            }
        }
        .tint(LpspFacebookTokens.fbBlue)
        .preferredColorScheme(.light)
    }
}

private struct LpspFacebookShowroomTabScreen: View {
    @ObservedObject var store: LpspFacebookStore
    let tab: LpspFacebookShowroomTab

    var body: some View {
        Group {
            switch tab {
            case .home:
                LpspFacebookHomeTabScreen(store: store)
            case .video:
                LpspFacebookVideoTabScreen()
            case .marketplace:
                LpspFacebookMarketplaceTabScreen()
            case .alerts:
                LpspFacebookAlertsTabScreen()
            case .menu:
                LpspFacebookMenuTabScreen()
            }
        }
    }
}

private struct LpspFacebookHomeTabScreen: View {
    @ObservedObject var store: LpspFacebookStore

    var body: some View {
        VStack(spacing: 0) {
            LpspFacebookSpectrTopNav()

            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(store.posts) { post in
                        LpspFacebookShowroomPostCard(
                            post: post,
                            showReactions: store.showReactionsForPostId == post.id,
                            onLike: { store.toggleLike(post.id) },
                            onLongPressLike: { store.openReactions(post.id) },
                            onSelectReaction: { store.setReaction(post.id, reaction: $0) },
                            onDismissReactions: { store.dismissReactions() },
                            onComment: { store.incrementComments(post.id) }
                        )
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .background(LpspFacebookTokens.fbCanvas.ignoresSafeArea())
    }
}

private struct LpspFacebookSpectrTopNav: View {
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LpspFacebookTokens.fbBlue)
                    .frame(width: 36, height: 36)
                Text("f")
                    .font(LpspFacebookFonts.fbFLogo)
                    .foregroundStyle(.white)
                    .offset(y: -1)
            }

            Text("facebook")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(LpspFacebookTokens.fbTextPrimaryLight)

            Spacer()

            LpspFacebookFBCircleIconButton(system: "magnifyingglass")
            LpspFacebookFBCircleIconButton(system: "ellipsis.message.fill")
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(LpspFacebookTokens.fbCard)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspFacebookTokens.fbDivider).frame(height: 1)
        }
    }
}

private struct LpspFacebookShowroomPostCard: View {
    let post: LpspFacebookFeedPost
    let showReactions: Bool
    let onLike: () -> Void
    let onLongPressLike: () -> Void
    let onSelectReaction: (LpspFacebookFBReaction) -> Void
    let onDismissReactions: () -> Void
    let onComment: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 1, green: 0.84, blue: 0.6), Color(red: 1, green: 0.89, blue: 0.58)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)

                VStack(alignment: .leading, spacing: 2) {
                    Text(post.displayName)
                        .font(LpspFacebookFonts.fbDisplayName)
                        .foregroundStyle(LpspFacebookTokens.fbTextPrimaryLight)
                    HStack(spacing: 4) {
                        Text(post.timestamp)
                            .font(LpspFacebookFonts.fbTimestamp)
                            .foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                        Text("🌍")
                            .font(.system(size: 12))
                    }
                }

                Spacer()

                Text("⋯")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
            }
            .padding(12)

            Text(post.postText)
                .font(LpspFacebookFonts.fbPostBody)
                .foregroundStyle(LpspFacebookTokens.fbTextPrimaryLight)
                .padding(.horizontal, 12)
                .padding(.bottom, 12)

            if post.hasMedia {
                LinearGradient(
                    colors: [
                        Color(red: 0.95, green: 0.72, blue: 0.38),
                        Color(red: 0.88, green: 0.45, blue: 0.22),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(maxWidth: .infinity)
                .frame(height: 220)
            }

            HStack(spacing: 6) {
                HStack(spacing: -4) {
                    reactionBubble("👍", color: LpspFacebookTokens.fbLikeBlue)
                    reactionBubble("❤", color: LpspFacebookTokens.fbLovePink)
                    reactionBubble("😂", color: LpspFacebookTokens.fbHahaYellow)
                }
                Text(post.reactionSummary)
                    .font(LpspFacebookFonts.fbReactionCount)
                    .foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                Spacer()
                Text("\(post.commentCount) comments")
                    .font(LpspFacebookFonts.fbReactionCount)
                    .foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)

            Divider().background(LpspFacebookTokens.fbDivider)

            HStack(spacing: 0) {
                LpspFacebookFBActionButton(
                    icon: post.userReaction?.symbol ?? "hand.thumbsup",
                    label: post.userReaction?.label ?? "Like",
                    color: post.userReaction?.color ?? LpspFacebookTokens.fbTextSecondaryLight,
                    onTap: onLike,
                    onLongPress: onLongPressLike
                )
                LpspFacebookFBActionButton(
                    icon: "bubble.left",
                    label: "Comment",
                    color: LpspFacebookTokens.fbTextSecondaryLight,
                    onTap: onComment,
                    onLongPress: {}
                )
                LpspFacebookFBActionButton(
                    icon: "arrowshape.turn.up.right",
                    label: "Share",
                    color: LpspFacebookTokens.fbTextSecondaryLight,
                    onTap: {},
                    onLongPress: {}
                )
            }
            .padding(.vertical, 4)

            if showReactions {
                LpspFacebookShowroomReactionsBar(onSelect: onSelectReaction, onDismiss: onDismissReactions)
                    .padding(.bottom, 8)
            }
        }
        .background(LpspFacebookTokens.fbCard)
        .cornerRadius(8)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }

    private func reactionBubble(_ emoji: String, color: Color) -> some View {
        ZStack {
            Circle().fill(color).frame(width: 18, height: 18)
            Text(emoji).font(.system(size: 9))
        }
    }
}

private struct LpspFacebookShowroomReactionsBar: View {
    let onSelect: (LpspFacebookFBReaction) -> Void
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            ForEach(LpspFacebookFBReaction.allCases) { reaction in
                Button {
                    onSelect(reaction)
                } label: {
                    Image(systemName: reaction.symbol)
                        .font(.system(size: 28))
                        .foregroundStyle(reaction.color)
                        .frame(width: 48, height: 48)
                }
            }
            Button("Close", action: onDismiss)
                .font(LpspFacebookFonts.fbTimestamp)
                .foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            Capsule().fill(LpspFacebookTokens.fbCard)
                .shadow(color: .black.opacity(0.2), radius: 16, y: 4)
        )
        .padding(.horizontal, 12)
    }
}

private struct LpspFacebookVideoTabScreen: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "play.rectangle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.white.opacity(0.9))
                Text("Video")
                    .font(LpspFacebookFonts.fbScreenTitle)
                    .foregroundStyle(.white)
            }
        }
    }
}

private struct LpspFacebookMarketplaceTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(LpspFacebookShowroomData.marketplaceItems, id: \.0) { title, price in
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(LpspFacebookTokens.fbBlueLight)
                            .frame(width: 56, height: 56)
                            .overlay {
                                Image(systemName: "cart.fill")
                                    .foregroundStyle(LpspFacebookTokens.fbBlue)
                            }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(LpspFacebookFonts.fbDisplayName)
                            Text(price)
                                .font(LpspFacebookFonts.fbTimestamp)
                                .foregroundStyle(LpspFacebookTokens.fbTextSecondaryLight)
                        }
                    }
                }
            }
            .navigationTitle("Marketplace")
        }
    }
}

private struct LpspFacebookAlertsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                Label("Sarah Johnson reacted to your photo", systemImage: "hand.thumbsup.fill")
                Label("3 new friend requests", systemImage: "person.2.fill")
                Label("Marketplace item saved", systemImage: "bookmark.fill")
            }
            .navigationTitle("Alerts")
        }
    }
}

private struct LpspFacebookMenuTabScreen: View {
    var body: some View {
        NavigationStack {
            List(LpspFacebookShowroomData.menuItems, id: \.self) { item in
                Text(item)
                    .font(LpspFacebookFonts.fbPostBody)
            }
            .navigationTitle("Menu")
        }
    }
}


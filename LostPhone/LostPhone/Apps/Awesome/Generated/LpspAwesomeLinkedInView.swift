import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/social/linkedin/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/linkedin
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeLinkedInView: View {
    var body: some View {
        LpspLinkedInShowroomRoot()
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

private struct LpspLinkedInLinkedInPillButton: View {
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
                    .font(variant == .filled ? LpspLinkedInTokens.liButtonPrimary : LpspLinkedInTokens.liButtonSecondary)
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

private struct LpspLinkedInLinkedInPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

private struct LpspLinkedInFeedPostCard: View {
    let authorName: String
    let connectionDegree: String           // "1st", "2nd", "3rd+"
    let headline: String                   // job title + company
    let timeAgo: String                    // "3d •"
    let body: String
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

            Text(body)
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

private struct LpspLinkedInAvatarView: View {
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

private struct LpspLinkedInReactionPicker: View {
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

private struct LpspLinkedInReactionFooterRow: View {
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

private struct LpspLinkedInActionBar: View {
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

private struct LpspLinkedInRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = UIColor(LpspLinkedInTokens.liDivider)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            NetworkView().tabItem { Label("My Network", systemImage: "person.2.fill") }
            PostView().tabItem { Label("Post", systemImage: "plus.app.fill") }
            NotificationsView().tabItem { Label("Notifications", systemImage: "bell.fill") }
            JobsView().tabItem { Label("Jobs", systemImage: "briefcase.fill") }
        }
        .tint(LpspLinkedInTokens.liTextPrimary)  // active is near-black, not blue
    }
}

private struct LpspLinkedInLinkedInTopNav: View {
    @State private var searchText = ""

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 28, height: 28)
                .clipShape(Circle())

            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundStyle(LpspLinkedInTokens.liTextSecondary)
                TextField("Search", text: $searchText)
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

// MARK: - Écrans showroom

private struct LpspLinkedInShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspLinkedInFeedTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspLinkedInSocialTabScreen(title: "My Network")
                .tabItem { Label("My Network", systemImage: "person.2.fill") }
                .tag(1)
            LpspLinkedInSocialTabScreen(title: "Post")
                .tabItem { Label("Post", systemImage: "plus.app.fill") }
                .tag(2)
            LpspLinkedInSocialTabScreen(title: "Notifications")
                .tabItem { Label("Notifications", systemImage: "bell.fill") }
                .tag(3)
            LpspLinkedInSocialTabScreen(title: "Jobs")
                .tabItem { Label("Jobs", systemImage: "briefcase.fill") }
                .tag(4)
        }
        .tint(LpspLinkedInTokens.liActionBar)
        
    }
}


private struct LpspLinkedInGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspLinkedInTokens.liActionBar.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspLinkedInTokens.liActionBar))
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


private struct LpspLinkedInDemoPostItem: Identifiable {
    let id = UUID()
    let user: String
    let likes: Int
    let caption: String
    let time: String
}

private enum LpspLinkedInDemoPosts {
    static let items: [LpspLinkedInDemoPostItem] = [
        .init(user: "lost.phone", likes: 128, caption: "Showroom Lost Phone — Paris", time: "2 H"),
        .init(user: "alex.m", likes: 42, caption: "Week-end en Bretagne", time: "5 H"),
    ]
}

private struct LpspLinkedInDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspLinkedInDemoStories {
    static let items: [LpspLinkedInDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspLinkedInFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspLinkedInDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    Circle().strokeBorder(LpspLinkedInTokens.liActionBar, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill(LpspLinkedInTokens.liActionBar.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(LpspLinkedInDemoPosts.items.indices, id: \.self) { i in
                        let post = LpspLinkedInDemoPosts.items[i]
                        LpspLinkedInFeedPostCard(
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
            .background(LpspLinkedInTokens.liCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspLinkedInExploreTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LpspLinkedInTokens.liActionBar.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .navigationTitle("Explorer")
        }
    }
}

private struct LpspLinkedInReelsTabScreen: View {
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

private struct LpspLinkedInProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspLinkedInTokens.liActionBar.gradient).frame(width: 88, height: 88)
                        .overlay(Text("LP").font(.title.bold()).foregroundStyle(.white))
                    Text("lost.phone").font(.system(size: 20, weight: .bold))
                    Text("Paris · Showroom").font(.subheadline).foregroundStyle(.secondary)
                    HStack(spacing: 32) {
                        VStack { Text("128").font(.headline); Text("Publications").font(.caption) }
                        VStack { Text("1,2 k").font(.headline); Text("Abonnés").font(.caption) }
                        VStack { Text("340").font(.headline); Text("Abonnements").font(.caption) }
                    }
                }
                .padding()
            }
            .navigationTitle("Profil")
        }
    }
}

private struct LpspLinkedInSocialTabScreen: View {
    let title: String
    var body: some View { LpspLinkedInGenericTabScreen(title: title, tabIndex: 0) }
}

private struct LpspLinkedInGenericFeedCard: View {
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



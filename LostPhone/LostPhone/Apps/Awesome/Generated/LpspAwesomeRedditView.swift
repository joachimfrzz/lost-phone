import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/social/reddit/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/reddit
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeRedditView: View {
    var body: some View {
        LpspRedditShowroomRoot()
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

// MARK: - Écrans showroom

private struct LpspRedditShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspRedditFeedTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspRedditSocialTabScreen(title: "Communities")
                .tabItem { Label("Communities", systemImage: "person.3.fill") }
                .tag(1)
            LpspRedditSocialTabScreen(title: "Create")
                .tabItem { Label("Create", systemImage: "plus.circle.fill") }
                .tag(2)
            LpspRedditSocialTabScreen(title: "Chat")
                .tabItem { Label("Chat", systemImage: "bubble.left.and.bubble.right.fill") }
                .tag(3)
            LpspRedditSocialTabScreen(title: "Inbox")
                .tabItem { Label("Inbox", systemImage: "bell.fill") }
                .tag(4)
        }
        .tint(LpspRedditTokens.rdBrandRed)
        
    }
}


private struct LpspRedditGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspRedditTokens.rdBrandRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspRedditTokens.rdBrandRed))
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


private struct LpspRedditDemoPostItem: Identifiable {
    let id = UUID()
    let sub: String
    let title: String
    let body: String?
    let time: String
    let comments: Int
    let karma: Int
}

private enum LpspRedditDemoPosts {
    static let items: [LpspRedditDemoPostItem] = [
        .init(sub: "paris", title: "Meilleur café du 11e ?", body: "Je cherche vos recommandations…", time: "2 h", comments: 48, karma: 128),
        .init(sub: "swiftui", title: "Spectr + SwiftUI", body: nil, time: "5 h", comments: 22, karma: 89),
    ]
}

private struct LpspRedditDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspRedditDemoStories {
    static let items: [LpspRedditDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspRedditFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspRedditDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    Circle().strokeBorder(LpspRedditTokens.rdBrandRed, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill(LpspRedditTokens.rdBrandRed.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(LpspRedditDemoPosts.items) { post in
                        LpspRedditRDPostCard(
                            subredditName: post.sub,
                            subredditAvatar: nil,
                            subredditAccent: LpspRedditTokens.rdBrandRed,
                            timestamp: post.time,
                            commentCount: post.comments,
                            title: post.title,
                            postText: post.body,
                            flairs: [],
                            mediaUri: nil,
                            baseKarma: post.karma
                        )
                    }

                }
            }
            .background(LpspRedditTokens.rdCanvasLight.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspRedditExploreTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LpspRedditTokens.rdBrandRed.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .navigationTitle("Explorer")
        }
    }
}

private struct LpspRedditReelsTabScreen: View {
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

private struct LpspRedditProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspRedditTokens.rdBrandRed.gradient).frame(width: 88, height: 88)
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

private struct LpspRedditSocialTabScreen: View {
    let title: String
    var body: some View { LpspRedditGenericTabScreen(title: title, tabIndex: 0) }
}

private struct LpspRedditGenericFeedCard: View {
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



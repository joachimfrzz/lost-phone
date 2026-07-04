import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/social/threads/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/threads
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeThreadsView: View {
    var body: some View {
        LpspThreadsShowroomRoot()
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



// MARK: - Écrans showroom

private struct LpspThreadsShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspThreadsFeedTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspThreadsExploreTabScreen()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
            LpspThreadsSocialTabScreen(title: "Compose")
                .tabItem { Label("Compose", systemImage: "plus.square") }
                .tag(2)
            LpspThreadsSocialTabScreen(title: "Activity")
                .tabItem { Label("Activity", systemImage: "heart.fill") }
                .tag(3)
            LpspThreadsProfileTabScreen()
                .tabItem { Label("Profil", systemImage: "person.circle") }
                .tag(4)
        }
        .tint(LpspThreadsTokens.threadsLikeCoral)
        
    }
}


private struct LpspThreadsGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspThreadsTokens.threadsLikeCoral.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspThreadsTokens.threadsLikeCoral))
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


private struct LpspThreadsDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspThreadsDemoStories {
    static let items: [LpspThreadsDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspThreadsFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspThreadsDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    Circle().strokeBorder(LpspThreadsTokens.threadsLikeCoral, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill(LpspThreadsTokens.threadsLikeCoral.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(0..<3, id: \.self) { i in
                        LpspThreadsGenericFeedCard(index: i, accent: LpspThreadsTokens.threadsLikeCoral)
                    }

                }
            }
            .background(LpspThreadsTokens.threadsCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspThreadsExploreTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LpspThreadsTokens.threadsLikeCoral.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .navigationTitle("Explorer")
        }
    }
}

private struct LpspThreadsReelsTabScreen: View {
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

private struct LpspThreadsProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspThreadsTokens.threadsLikeCoral.gradient).frame(width: 88, height: 88)
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

private struct LpspThreadsCommunitiesTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["r/swiftui", "r/paris", "r/design"], id: \.self) { Label($0, systemImage: "person.3") }
            .navigationTitle("Communities")
        }
    }
}

private struct LpspThreadsCreateTabScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "plus.app.fill").font(.system(size: 56)).foregroundStyle(LpspThreadsTokens.threadsLikeCoral)
            Text("Nouvelle publication").font(.title2.bold())
            Text("Photo, reel ou story").foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LpspThreadsTokens.threadsCanvas.ignoresSafeArea())
    }
}

private struct LpspThreadsSocialTabScreen: View {
    let title: String
    var body: some View {
        let low = title.lowercased()
        if low.contains("créer") || low.contains("create") { LpspThreadsCreateTabScreen() }
        else if low.contains("explor") || low.contains("search") { LpspThreadsExploreTabScreen() }
        else if low.contains("reel") { LpspThreadsReelsTabScreen() }
        else if low.contains("profil") || low.contains("profile") { LpspThreadsProfileTabScreen() }
        else { LpspThreadsFeedTabScreen() }
    }
}

private struct LpspThreadsGenericFeedCard: View {
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



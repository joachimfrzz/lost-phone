import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/social/facebook/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/facebook
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeFacebookView: View {
    var body: some View {
        LpspFacebookShowroomRoot()
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



// MARK: - Écrans showroom

private struct LpspFacebookShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspFacebookFeedTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspFacebookSocialTabScreen(title: "Video")
                .tabItem { Label("Video", systemImage: "play.rectangle.fill") }
                .tag(1)
            LpspFacebookSocialTabScreen(title: "Marketplace")
                .tabItem { Label("Marketplace", systemImage: "cart.fill") }
                .tag(2)
            LpspFacebookSocialTabScreen(title: "Notifications")
                .tabItem { Label("Notifications", systemImage: "bell.fill") }
                .tag(3)
            LpspFacebookSocialTabScreen(title: "Menu")
                .tabItem { Label("Menu", systemImage: "line.3.horizontal") }
                .tag(4)
        }
        .tint(LpspFacebookTokens.fbCareYellow)
        
    }
}


private struct LpspFacebookGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspFacebookTokens.fbCareYellow.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspFacebookTokens.fbCareYellow))
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


private struct LpspFacebookDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspFacebookDemoStories {
    static let items: [LpspFacebookDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspFacebookFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspFacebookDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    Circle().strokeBorder(LpspFacebookTokens.fbCareYellow, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill(LpspFacebookTokens.fbCareYellow.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(0..<3, id: \.self) { i in
                        LpspFacebookGenericFeedCard(index: i, accent: LpspFacebookTokens.fbCareYellow)
                    }

                }
            }
            .background(LpspFacebookTokens.fbCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspFacebookExploreTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LpspFacebookTokens.fbCareYellow.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .navigationTitle("Explorer")
        }
    }
}

private struct LpspFacebookReelsTabScreen: View {
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

private struct LpspFacebookProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspFacebookTokens.fbCareYellow.gradient).frame(width: 88, height: 88)
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

private struct LpspFacebookCommunitiesTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["r/swiftui", "r/paris", "r/design"], id: \.self) { Label($0, systemImage: "person.3") }
            .navigationTitle("Communities")
        }
    }
}

private struct LpspFacebookCreateTabScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "plus.app.fill").font(.system(size: 56)).foregroundStyle(LpspFacebookTokens.fbCareYellow)
            Text("Nouvelle publication").font(.title2.bold())
            Text("Photo, reel ou story").foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LpspFacebookTokens.fbCanvas.ignoresSafeArea())
    }
}

private struct LpspFacebookSocialTabScreen: View {
    let title: String
    var body: some View {
        let low = title.lowercased()
        if low.contains("créer") || low.contains("create") { LpspFacebookCreateTabScreen() }
        else if low.contains("explor") || low.contains("search") { LpspFacebookExploreTabScreen() }
        else if low.contains("reel") { LpspFacebookReelsTabScreen() }
        else if low.contains("profil") || low.contains("profile") { LpspFacebookProfileTabScreen() }
        else { LpspFacebookFeedTabScreen() }
    }
}

private struct LpspFacebookGenericFeedCard: View {
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



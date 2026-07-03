import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/social/tiktok/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/tiktok
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTikTokView: View {
    var body: some View {
        LpspTikTokShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTikTokFonts {
    static let tiktokDisplayName = Font.system(size: 24, weight: .regular)
    static let tiktokSheetTitle  = Font.system(size: 17, weight: .regular)
    static let tiktokUsername    = Font.system(size: 16, weight: .regular)
    static let tiktokCaption     = Font.system(size: 15, weight: .regular)
    static let tiktokHashtag     = Font.system(size: 15, weight: .regular)
    static let tiktokActionCount = Font.system(size: 13, weight: .regular)
    static let tiktokMusic       = Font.system(size: 13, weight: .regular)
    static let tiktokUsernameList = Font.system(size: 15, weight: .regular)
    static let tiktokBody         = Font.system(size: 14, weight: .regular)
    static let tiktokMeta         = Font.system(size: 12, weight: .regular)
    static let tiktokButtonPrimary   = Font.system(size: 16, weight: .regular)
    static let tiktokButtonSecondary = Font.system(size: 14, weight: .regular)
    static let tiktokFollow          = Font.system(size: 14, weight: .regular)
    static let tiktokTab             = Font.system(size: 10, weight: .regular)
    static let tiktokChip            = Font.system(size: 13, weight: .regular)
    static func tiktok(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspTikTokTokens {
    // MARK: - Canvas & Surfaces
    static let tiktokCanvas      = Color(red: 0.004, green: 0.004, blue: 0.004) // #010101
    static let tiktokSurface     = Color(red: 0.086, green: 0.094, blue: 0.137) // #161823 — DMs, sheets
    static let tiktokInputField  = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F — comment compose

    // MARK: - Brand
    static let tiktokRose        = Color(red: 0.996, green: 0.173, blue: 0.333) // #FE2C55
    static let tiktokCyan        = Color(red: 0.145, green: 0.957, blue: 0.933) // #25F4EE

    // MARK: - Text
    static let tiktokTextPrimary   = Color.white                                  // #FFFFFF
    static let tiktokTextSecondary = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5 — hashtag counts
    static let tiktokTextTertiary  = Color.white.opacity(0.6)                     // placeholder, meta
    static let tiktokTextDisabled  = Color.white.opacity(0.3)

    // MARK: - Overlays
    static let tiktokFollowerGray  = Color.white.opacity(0.15)                    // "Following" pill bg
    static let tiktokScrimLight    = Color.black.opacity(0.25)                    // icon shadow
    static let tiktokScrimMedium   = Color.black.opacity(0.4)                     // text shadow
    static let tiktokScrimHeavy    = Color.black.opacity(0.6)                     // sheet dim
    static let tiktokScrubberTrack = Color.white.opacity(0.3)
}



// Fallback if Proxima Nova isn't bundled:


private struct LpspTikTokTikTokTextShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: .tiktokScrimMedium, radius: 4, x: 0, y: 1)
    }
}

extension View {
    func tiktokTextOnVideo() -> some View { modifier(LpspTikTokTikTokTextShadow()) }
}

private struct LpspTikTokChromaticAberration: ViewModifier {
    var offset: CGFloat = 3

    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundStyle(Color.tiktokCyan)
                .offset(x: -offset)
            content
                .foregroundStyle(Color.tiktokRose)
                .offset(x: offset)
            content
                .foregroundStyle(.white)
        }
    }
}

extension View {
    func chromaticAberration(offset: CGFloat = 3) -> some View {
        modifier(LpspTikTokChromaticAberration(offset: offset))
    }
}

// Usage:
// Text("d").font(.system(size: 96, weight: .bold)).chromaticAberration(offset: 6)

private struct LpspTikTokTikTokFollowButton: View {
    @Binding var isFollowing: Bool

    var body: some View {
        Button {
            isFollowing.toggle()
        } label: {
            Text(isFollowing ? "Following" : "Follow")
                .font(isFollowing ? .tiktokButtonSecondary : .tiktokFollow)
                .foregroundStyle(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 16)
                .frame(minHeight: 28)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(isFollowing ? Color.tiktokFollowerGray : Color.tiktokRose)
                )
        }
        .sensoryFeedback(.success, trigger: isFollowing) { old, new in !old && new }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isFollowing) { old, new in old && !new }
        .buttonStyle(LpspTikTokTikTokPressableStyle(pressedScale: 0.95))
    }
}

private struct LpspTikTokTikTokPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

private struct LpspTikTokTikTokCreateButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.tiktokCyan)
                    .offset(x: -3)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.tiktokRose)
                    .offset(x: 3)
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.tiktokCanvas)
            }
            .frame(width: 44, height: 30)
            .compositingGroup()
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .sensoryFeedback(.impact(weight: .heavy), trigger: UUID())
        .buttonStyle(LpspTikTokTikTokPressableStyle(pressedScale: 0.94))
    }
}

private struct LpspTikTokActionRail: View {
    let avatarURL: URL?
    @Binding var isFollowed: Bool
    @Binding var likeCount: Int
    @Binding var isLiked: Bool
    let commentCount: Int
    let bookmarkCount: Int
    let shareCount: Int
    let musicArtwork: URL?

    var body: some View {
        VStack(spacing: 24) {
            avatarBadge
            LpspTikTokActionIcon(systemName: isLiked ? "heart.fill" : "heart",
                       count: likeCount,
                       tint: isLiked ? .tiktokRose : .white) {
                isLiked.toggle()
                likeCount += isLiked ? 1 : -1
            }
            LpspTikTokActionIcon(systemName: "ellipsis.bubble.fill", count: commentCount, tint: .white) { }
            LpspTikTokActionIcon(systemName: "bookmark.fill", count: bookmarkCount, tint: .white) { }
            LpspTikTokActionIcon(systemName: "arrowshape.turn.up.right.fill", count: shareCount, tint: .white) { }
            LpspTikTokSpinningMusicDisc(artwork: musicArtwork)
        }
        .padding(.trailing, 12)
    }

    private var avatarBadge: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: avatarURL) { $0.resizable() } placeholder: { Color.tiktokSurface }
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 2))
            if !isFollowed {
                Button { isFollowed = true } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 18, height: 18)
                        .background(Circle().fill(Color.tiktokRose))
                }
                .offset(y: 9)
                .sensoryFeedback(.success, trigger: isFollowed)
            }
        }
    }
}

private struct LpspTikTokActionIcon: View {
    let systemName: String
    let count: Int
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: systemName)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(tint)
                    .shadow(color: .tiktokScrimLight, radius: 3, x: 0, y: 1)
                Text(LpspTikTokTikTokCount.format(count))
                    .font(LpspTikTokFonts.tiktokActionCount)
                    .foregroundStyle(.white)
                    .tiktokTextOnVideo()
            }
        }
        .frame(minWidth: 48, minHeight: 48)
    }
}

private enum LpspTikTokTikTokCount {
    static func format(_ n: Int) -> String {
        switch n {
        case ..<1_000: return "\(n)"
        case ..<1_000_000: return String(format: "%.1fK", Double(n) / 1_000).replacingOccurrences(of: ".0", with: "")
        default: return String(format: "%.1fM", Double(n) / 1_000_000).replacingOccurrences(of: ".0", with: "")
        }
    }
}

private struct LpspTikTokSpinningMusicDisc: View {
    let artwork: URL?
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            Circle().fill(Color.tiktokCanvas)
            AsyncImage(url: artwork) { $0.resizable() } placeholder: { Color.tiktokSurface }
                .frame(width: 28, height: 28)
                .clipShape(Circle())
            Circle().stroke(.white.opacity(0.4), lineWidth: 1)
        }
        .frame(width: 44, height: 44)
        .rotationEffect(.degrees(rotation))
        .onAppear {
            withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

private struct LpspTikTokCaptionOverlay: View {
    let username: String
    let caption: String       // "Check out #fyp #dance at sunset"
    let musicTitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("@\(username)")
                .font(LpspTikTokFonts.tiktokUsername)
                .foregroundStyle(.white)
                .tiktokTextOnVideo()

            captionText
                .font(LpspTikTokFonts.tiktokCaption)
                .foregroundStyle(.white)
                .lineLimit(2)
                .tiktokTextOnVideo()

            HStack(spacing: 6) {
                Image(systemName: "music.note")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white)
                Text(musicTitle)
                    .font(LpspTikTokFonts.tiktokMusic)
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }
            .tiktokTextOnVideo()
        }
        .padding(.leading, 16)
        .padding(.trailing, 80) // leave room for the action rail
    }

    // Parse the caption and render hashtags bold inline
    private var captionText: Text {
        caption.split(separator: " ").reduce(Text("")) { acc, token in
            if token.hasPrefix("#") {
                return acc + Text(" \(token)").font(LpspTikTokFonts.tiktokHashtag)
            }
            return acc + Text(" \(token)")
        }
    }
}

private struct LpspTikTokDoubleTapLike: ViewModifier {
    @State private var hearts: [LpspTikTokHeartBurst] = []

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    ZStack {
                        ForEach(hearts) { heart in
                            Image(systemName: "heart.fill")
                                .font(.system(size: 120, weight: .bold))
                                .foregroundStyle(Color.tiktokRose)
                                .scaleEffect(heart.scale)
                                .opacity(heart.opacity)
                                .position(heart.position)
                        }
                    }
                }
            )
            .onTapGesture(count: 2) { loc in
                spawnHeart(at: loc)
            }
    }

    private func spawnHeart(at location: CGPoint) {
        let id = UUID()
        hearts.append(LpspTikTokHeartBurst(id: id, position: location, scale: 0, opacity: 1))
        withAnimation(.spring(response: 0.4, dampingFraction: 0.55)) {
            if let i = hearts.firstIndex(where: { $0.id == id }) { hearts[i].scale = 1.4 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeOut(duration: 0.2)) {
                if let i = hearts.firstIndex(where: { $0.id == id }) {
                    hearts[i].scale = 1.0
                    hearts[i].opacity = 0
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            hearts.removeAll { $0.id == id }
        }
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
}

private struct LpspTikTokHeartBurst: Identifiable {
    let id: UUID
    var position: CGPoint
    var scale: CGFloat
    var opacity: Double
}

private struct LpspTikTokVideoScrubber: View {
    let progress: Double     // 0.0 ... 1.0
    @State private var isScrubbing = false

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.tiktokScrubberTrack)
                Capsule().fill(Color.tiktokRose).frame(width: proxy.size.width * progress)
            }
        }
        .frame(height: isScrubbing ? 4 : 2)
        .animation(.easeInOut(duration: 0.15), value: isScrubbing)
    }
}

private struct LpspTikTokTikTokLoadingSpinner: View {
    @State private var rotation: Double = 0
    var body: some View {
        ZStack {
            Circle().trim(from: 0, to: 0.75).stroke(Color.tiktokCyan, lineWidth: 3).offset(x: -3)
            Circle().trim(from: 0, to: 0.75).stroke(Color.tiktokRose, lineWidth: 3).offset(x: 3)
            Circle().trim(from: 0, to: 0.75).stroke(.white, lineWidth: 3)
        }
        .frame(width: 32, height: 32)
        .rotationEffect(.degrees(rotation))
        .onAppear {
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

private struct LpspTikTokRootTabBar: View {
    @Binding var selected: LpspTikTokTab
    let onCreateTapped: () -> Void
    var isOnFeed: Bool = true

    enum LpspTikTokTab: Hashable { case home, discover, inbox, profile }

    var body: some View {
        HStack(alignment: .center) {
            tab(.home,     icon: "house.fill",           label: "Home")
            tab(.discover, icon: "magnifyingglass",      label: "Discover")
            Spacer().frame(width: 56)   // space for Create button
            tab(.inbox,    icon: "tray.fill",            label: "Inbox")
            tab(.profile,  icon: "person.fill",          label: "Profile")
        }
        .frame(height: 48)
        .padding(.horizontal, 8)
        .background(
            Group {
                if isOnFeed {
                    Color.clear
                } else {
                    Color.tiktokCanvas.opacity(0.92)
                        .background(.regularMaterial)
                }
            }
        )
        .overlay(alignment: .top) {
            if !isOnFeed { Rectangle().fill(.white.opacity(0.08)).frame(height: 0.5) }
        }
        .overlay {
            LpspTikTokTikTokCreateButton(action: onCreateTapped)
        }
        .safeAreaPadding(.bottom)
    }

    private func tab(_ tab: LpspTikTokTab, icon: String, label: String) -> some View {
        Button { selected = tab } label: {
            VStack(spacing: 3) {
                Image(systemName: icon).font(.system(size: 24, weight: .semibold))
                Text(label).font(LpspTikTokFonts.tiktokTab)
            }
            .foregroundStyle(selected == tab ? .white : .white.opacity(0.5))
            .frame(maxWidth: .infinity)
            .shadow(color: isOnFeed ? .tiktokScrimLight : .clear, radius: 3, x: 0, y: 1)
        }
    }
}

// MARK: - Écrans showroom

private struct LpspTikTokShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspTikTokFeedTabScreen()
                .tabItem { Label("Accueil", systemImage: "house.fill") }
                .tag(0)
            LpspTikTokExploreTabScreen()
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
                .tag(1)
            LpspTikTokProfileTabScreen()
                .tabItem { Label("Profil", systemImage: "person.circle") }
                .tag(2)
        }
        .tint(LpspTikTokTokens.tiktokActionCount)
        
    }
}


private struct LpspTikTokGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTikTokTokens.tiktokActionCount.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspTikTokTokens.tiktokActionCount))
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


private struct LpspTikTokDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspTikTokDemoStories {
    static let items: [LpspTikTokDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspTikTokFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspTikTokDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    Circle().strokeBorder(LpspTikTokTokens.tiktokActionCount, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill(LpspTikTokTokens.tiktokActionCount.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(0..<3, id: \.self) { i in
                        LpspTikTokGenericFeedCard(index: i, accent: LpspTikTokTokens.tiktokActionCount)
                    }

                }
            }
            .background(LpspTikTokTokens.tiktokCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspTikTokExploreTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LpspTikTokTokens.tiktokActionCount.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .navigationTitle("Explorer")
        }
    }
}

private struct LpspTikTokReelsTabScreen: View {
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

private struct LpspTikTokProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspTikTokTokens.tiktokActionCount.gradient).frame(width: 88, height: 88)
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

private struct LpspTikTokSocialTabScreen: View {
    let title: String
    var body: some View { LpspTikTokGenericTabScreen(title: title, tabIndex: 0) }
}

private struct LpspTikTokGenericFeedCard: View {
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



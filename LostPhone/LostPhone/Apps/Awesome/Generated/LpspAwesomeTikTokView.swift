import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/tiktok
// Meliwat/awesome-ios-design-md/social/tiktok/DESIGN-swiftui.md
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


fileprivate struct LpspTikTokTikTokTextShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: LpspTikTokTokens.tiktokScrimMedium, radius: 4, x: 0, y: 1)
    }
}

fileprivate extension View {
    func tiktokTextOnVideo() -> some View { modifier(LpspTikTokTikTokTextShadow()) }
}

fileprivate struct LpspTikTokChromaticAberration: ViewModifier {
    var offset: CGFloat = 3

    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundStyle(LpspTikTokTokens.tiktokCyan)
                .offset(x: -offset)
            content
                .foregroundStyle(LpspTikTokTokens.tiktokRose)
                .offset(x: offset)
            content
                .foregroundStyle(.white)
        }
    }
}

fileprivate extension View {
    func chromaticAberration(offset: CGFloat = 3) -> some View {
        modifier(LpspTikTokChromaticAberration(offset: offset))
    }
}

// Usage:
// Text("d").font(.system(size: 96, weight: .bold)).chromaticAberration(offset: 6)

fileprivate struct LpspTikTokTikTokFollowButton: View {
    @Binding var isFollowing: Bool

    var body: some View {
        Button {
            isFollowing.toggle()
        } label: {
            Text(isFollowing ? "Following" : "Follow")
                .font(isFollowing ? LpspTikTokFonts.tiktokButtonSecondary : LpspTikTokFonts.tiktokFollow)
                .foregroundStyle(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 16)
                .frame(minHeight: 28)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(isFollowing ? LpspTikTokTokens.tiktokFollowerGray : LpspTikTokTokens.tiktokRose)
                )
        }
        .sensoryFeedback(.success, trigger: isFollowing) { old, new in !old && new }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isFollowing) { old, new in old && !new }
        .buttonStyle(LpspTikTokTikTokPressableStyle(pressedScale: 0.95))
    }
}

fileprivate struct LpspTikTokTikTokPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspTikTokTikTokCreateButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LpspTikTokTokens.tiktokCyan)
                    .offset(x: -3)
                RoundedRectangle(cornerRadius: 8)
                    .fill(LpspTikTokTokens.tiktokRose)
                    .offset(x: 3)
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(LpspTikTokTokens.tiktokCanvas)
            }
            .frame(width: 44, height: 30)
            .compositingGroup()
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .sensoryFeedback(.impact(weight: .heavy), trigger: UUID())
        .buttonStyle(LpspTikTokTikTokPressableStyle(pressedScale: 0.94))
    }
}

fileprivate struct LpspTikTokActionRail: View {
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
                       tint: isLiked ? LpspTikTokTokens.tiktokRose : .white) {
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
            AsyncImage(url: avatarURL) { $0.resizable() } placeholder: { LpspTikTokTokens.tiktokSurface }
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 2))
            if !isFollowed {
                Button { isFollowed = true } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 18, height: 18)
                        .background(Circle().fill(LpspTikTokTokens.tiktokRose))
                }
                .offset(y: 9)
                .sensoryFeedback(.success, trigger: isFollowed)
            }
        }
    }
}

fileprivate struct LpspTikTokActionIcon: View {
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
                    .shadow(color: LpspTikTokTokens.tiktokScrimLight, radius: 3, x: 0, y: 1)
                Text(LpspTikTokTikTokCount.format(count))
                    .font(LpspTikTokFonts.tiktokActionCount)
                    .foregroundStyle(.white)
                    .tiktokTextOnVideo()
            }
        }
        .frame(minWidth: 48, minHeight: 48)
    }
}

fileprivate enum LpspTikTokTikTokCount {
    static func format(_ n: Int) -> String {
        switch n {
        case ..<1_000: return "\(n)"
        case ..<1_000_000: return String(format: "%.1fK", Double(n) / 1_000).replacingOccurrences(of: ".0", with: "")
        default: return String(format: "%.1fM", Double(n) / 1_000_000).replacingOccurrences(of: ".0", with: "")
        }
    }
}

fileprivate struct LpspTikTokSpinningMusicDisc: View {
    let artwork: URL?
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            Circle().fill(LpspTikTokTokens.tiktokCanvas)
            AsyncImage(url: artwork) { $0.resizable() } placeholder: { LpspTikTokTokens.tiktokSurface }
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

fileprivate struct LpspTikTokCaptionOverlay: View {
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

fileprivate struct LpspTikTokDoubleTapLike: ViewModifier {
    @State private var hearts: [LpspTikTokHeartBurst] = []

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    ZStack {
                        ForEach(hearts) { heart in
                            Image(systemName: "heart.fill")
                                .font(.system(size: 120, weight: .bold))
                                .foregroundStyle(LpspTikTokTokens.tiktokRose)
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

fileprivate struct LpspTikTokHeartBurst: Identifiable {
    let id: UUID
    var position: CGPoint
    var scale: CGFloat
    var opacity: Double
}

fileprivate struct LpspTikTokVideoScrubber: View {
    let progress: Double     // 0.0 ... 1.0
    @State private var isScrubbing = false

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule().fill(LpspTikTokTokens.tiktokScrubberTrack)
                Capsule().fill(LpspTikTokTokens.tiktokRose).frame(width: proxy.size.width * progress)
            }
        }
        .frame(height: isScrubbing ? 4 : 2)
        .animation(.easeInOut(duration: 0.15), value: isScrubbing)
    }
}

fileprivate struct LpspTikTokTikTokLoadingSpinner: View {
    @State private var rotation: Double = 0
    var body: some View {
        ZStack {
            Circle().trim(from: 0, to: 0.75).stroke(LpspTikTokTokens.tiktokCyan, lineWidth: 3).offset(x: -3)
            Circle().trim(from: 0, to: 0.75).stroke(LpspTikTokTokens.tiktokRose, lineWidth: 3).offset(x: 3)
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

fileprivate struct LpspTikTokRootTabBar: View {
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
                    LpspTikTokTokens.tiktokCanvas.opacity(0.92)
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
            .shadow(color: isOnFeed ? LpspTikTokTokens.tiktokScrimLight : .clear, radius: 3, x: 0, y: 1)
        }
    }
}

// MARK: - Écrans showroom

private struct LpspTikTokShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspTikTokSpectrHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspTikTokShortVideoDiscoverTabScreen()
                .tabItem { Label("Discover", systemImage: "magnifyingglass") }
                .tag(1)
            LpspTikTokShortVideoInboxTabScreen()
                .tabItem { Label("Inbox", systemImage: "tray.fill") }
                .tag(2)
            LpspTikTokShortVideoProfileTabScreen()
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .tag(3)
        }
        .tint(LpspTikTokTokens.tiktokTextPrimary)
        .preferredColorScheme(.dark)
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
                        .fill(LpspTikTokTokens.tiktokTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspTikTokTokens.tiktokTextPrimary))
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


private struct LpspTikTokShortVideoFeedTabScreen: View {
    @State private var isFollowed = false
    @State private var isLiked = true
    @State private var likeCount = 12800
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.1, green: 0.05, blue: 0.15), LpspTikTokTokens.tiktokCanvas, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    LpspTikTokCaptionOverlay(username: "lost.phone", caption: "Showroom Lost Phone #fyp #swiftui", musicTitle: "Original Sound - lost.phone")
                    LpspTikTokActionRail(
                        avatarURL: nil,
                        isFollowed: $isFollowed,
                        likeCount: $likeCount,
                        isLiked: $isLiked,
                        commentCount: 420,
                        bookmarkCount: 89,
                        shareCount: 156,
                        musicArtwork: nil
                    )
                }
                LpspTikTokVideoScrubber(progress: 0.42)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
            }
        }
    }
}

private struct LpspTikTokShortVideoDiscoverTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 4) {
                    ForEach(0..<12, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LpspTikTokTokens.tiktokTextPrimary.opacity(0.12 + Double(i) * 0.04))
                            .aspectRatio(9/16, contentMode: .fit)
                            .overlay(alignment: .bottomLeading) {
                                Text("#trend \(i + 1)").font(.caption.bold()).foregroundStyle(.white).padding(6)
                            }
                    }
                }
                .padding(8)
            }
            .background(LpspTikTokTokens.tiktokCanvas.ignoresSafeArea())
            .navigationTitle("Discover")
        }
    }
}

private struct LpspTikTokShortVideoInboxTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Alex t'a mentionné", "Nouveau follower", "Live maintenant"], id: \.self) { item in
                HStack {
                    Circle().fill(LpspTikTokTokens.tiktokTextPrimary.opacity(0.2)).frame(width: 40, height: 40)
                    Text(item)
                }
            }
            .scrollContentBackground(.hidden)
            .background(LpspTikTokTokens.tiktokCanvas.ignoresSafeArea())
            .navigationTitle("Inbox")
        }
    }
}

private struct LpspTikTokShortVideoProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspTikTokTokens.tiktokTextPrimary.gradient).frame(width: 88, height: 88)
                        .overlay(Text("LP").font(.title.bold()).foregroundStyle(.white))
                    Text("@lost.phone").font(.title3.bold()).foregroundStyle(.white)
                    HStack(spacing: 24) {
                        VStack { Text("128").bold(); Text("Following").font(.caption) }
                        VStack { Text("12.4K").bold(); Text("Followers").font(.caption) }
                        VStack { Text("89K").bold(); Text("Likes").font(.caption) }
                    }
                    .foregroundStyle(.white)
                }
                .padding()
            }
            .background(LpspTikTokTokens.tiktokCanvas.ignoresSafeArea())
            .navigationTitle("Profile")
        }
    }
}


private struct LpspTikTokSpectrHomeTabScreen: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [Color(red:0.08,green:0.05,blue:0.12), Color(red: 0.004, green: 0.004, blue: 0.004)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        LinearGradient(colors: [Color(red:0.08,green:0.05,blue:0.12), Color.primary], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        HStack(spacing: 20) {
            Text("Following").font(.system(size: 17.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("For You").font(.system(size: 17.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        } .padding(.top, 52)
        Image(systemName: "magnifyingglass").font(.system(size: 20)).foregroundStyle(.white).padding(.trailing, 16)
        VStack(spacing: 20) {
            ZStack(alignment: .bottom) {
                Circle().fill(LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 48, height: 48)
            }
            VStack(spacing: 4) {
                Text("812.1K").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            }
            VStack(spacing: 4) {
                Text("4,567").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            }
            VStack(spacing: 4) {
                Text("42.8K").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            }
            VStack(spacing: 4) {
                Text("Share").font(.system(size: 13.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            }
            Circle().fill(.black).frame(width: 44, height: 44).overlay(Circle().fill(Color.red.opacity(0.8)).frame(width: 26, height: 26))
        } .padding(.trailing, 12)
        VStack(alignment: .leading, spacing: 6) {
            Text("@kellenvoss").font(.system(size: 16.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("tokyo station on a rainy tuesday #tokyo #rainy #streetfilm").font(.system(size: 15)).foregroundStyle(.white)
            HStack(spacing: 8) {
                Text("neon ritual - slow amber trio · neon ritual - slow amber trio · neon ritual").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            } .foregroundStyle(.white.opacity(0.9))
        } .padding(.horizontal, 14).padding(.bottom, 8)
        Capsule().fill(.white.opacity(0.25)).frame(height: 4).padding(.horizontal, 24)
        }
        .background(Color(red: 0.004, green: 0.004, blue: 0.004).ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}



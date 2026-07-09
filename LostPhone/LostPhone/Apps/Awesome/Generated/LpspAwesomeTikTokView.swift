import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/tiktok
// Meliwat/awesome-ios-design-md/social/tiktok/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTikTokView: View {
    var body: some View {
        LpspTikTokShowroomRoot(store: LpspTikTokStore())
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
            Group {
                if let avatarURL {
                    AsyncImage(url: avatarURL) { $0.resizable() } placeholder: { avatarPlaceholder }
                } else {
                    avatarPlaceholder
                }
            }
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

    private var avatarPlaceholder: some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [Color.orange, Color.pink],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}

fileprivate struct LpspTikTokActionIcon: View {
    let systemName: String
    let count: Int
    var countLabel: String? = nil
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: systemName)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(tint)
                    .shadow(color: LpspTikTokTokens.tiktokScrimLight, radius: 3, x: 0, y: 1)
                Text(countLabel ?? LpspTikTokTikTokCount.format(count))
                    .font(LpspTikTokFonts.tiktokActionCount.weight(.bold))
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
                return acc + Text(" \(token)").font(LpspTikTokFonts.tiktokHashtag.weight(.bold))
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

// MARK: - Données & état (showroom Spectr)

fileprivate enum LpspTikTokFeedMode: String, CaseIterable {
    case following
    case forYou

    var title: String {
        switch self {
        case .following: return "Following"
        case .forYou: return "For You"
        }
    }
}

fileprivate struct LpspTikTokVideo: Identifiable, Equatable {
    let id: String
    let username: String
    let caption: String
    let musicTitle: String
    let gradient: [Color]
    var likeCount: Int
    var isLiked: Bool
    var isFollowed: Bool
    var commentCount: Int
    var bookmarkCount: Int
    var progress: Double
}

private enum LpspTikTokShowroomData {
    static let featuredID = "kellenvoss-tokyo"

    static let featured = LpspTikTokVideo(
        id: featuredID,
        username: "kellenvoss",
        caption: "tokyo station on a rainy tuesday #tokyo #rainy #streetfilm",
        musicTitle: "neon ritual - slow amber trio · neon ritual - slow amber trio · neon ritual",
        gradient: [
            Color(red: 0.08, green: 0.05, blue: 0.12),
            Color(red: 0.12, green: 0.14, blue: 0.22),
            LpspTikTokTokens.tiktokCanvas,
        ],
        likeCount: 812_100,
        isLiked: true,
        isFollowed: false,
        commentCount: 4_567,
        bookmarkCount: 42_800,
        progress: 0.38
    )

    static let feed: [LpspTikTokVideo] = [
        featured,
        .init(
            id: "harborwave-synth",
            username: "harborwave",
            caption: "late night synth loop #music #fyp #producer",
            musicTitle: "original sound - harborwave",
            gradient: [
                Color(red: 0.15, green: 0.05, blue: 0.22),
                Color(red: 0.05, green: 0.10, blue: 0.18),
                LpspTikTokTokens.tiktokCanvas,
            ],
            likeCount: 128_400,
            isLiked: false,
            isFollowed: true,
            commentCount: 892,
            bookmarkCount: 12_300,
            progress: 0.62
        ),
        .init(
            id: "hana-watercolor",
            username: "hana.r",
            caption: "watercolor timelapse #art #calm #process",
            musicTitle: "soft brush - hana.r",
            gradient: [
                Color(red: 0.22, green: 0.12, blue: 0.18),
                Color(red: 0.10, green: 0.08, blue: 0.14),
                LpspTikTokTokens.tiktokCanvas,
            ],
            likeCount: 54_200,
            isLiked: false,
            isFollowed: false,
            commentCount: 341,
            bookmarkCount: 6_700,
            progress: 0.18
        ),
    ]

    static let discoverTags = ["#tokyo", "#rainy", "#streetfilm", "#fyp", "#music", "#art"]

    static let inbox: [(title: String, detail: String, time: String)] = [
        ("kellenvoss mentioned you", "tokyo station on a rainy tuesday", "2m"),
        ("New follower", "pixelgremlin started following you", "18m"),
        ("harborwave is live", "late night synth loop", "1h"),
    ]
}

@MainActor
fileprivate final class LpspTikTokStore: ObservableObject {
    @Published var selectedTab: LpspTikTokRootTabBar.LpspTikTokTab = .home
    @Published var feedMode: LpspTikTokFeedMode = .forYou
    @Published var videos: [LpspTikTokVideo]
    @Published var currentVideoIndex = 0
    @Published var showCreateSheet = false
    @Published var showSearch = false

    init() {
        videos = LpspTikTokShowroomData.feed
    }

    var currentVideo: LpspTikTokVideo {
        videos[currentVideoIndex]
    }

    func selectFeedMode(_ mode: LpspTikTokFeedMode) {
        feedMode = mode
    }

    func toggleLike() {
        guard videos.indices.contains(currentVideoIndex) else { return }
        var video = videos[currentVideoIndex]
        video.isLiked.toggle()
        video.likeCount += video.isLiked ? 1 : -1
        videos[currentVideoIndex] = video
    }

    func doubleTapLike() {
        guard videos.indices.contains(currentVideoIndex) else { return }
        var video = videos[currentVideoIndex]
        guard !video.isLiked else { return }
        video.isLiked = true
        video.likeCount += 1
        videos[currentVideoIndex] = video
    }

    func toggleFollow() {
        guard videos.indices.contains(currentVideoIndex) else { return }
        var video = videos[currentVideoIndex]
        video.isFollowed.toggle()
        videos[currentVideoIndex] = video
    }

    func advanceVideo() {
        guard !videos.isEmpty else { return }
        currentVideoIndex = (currentVideoIndex + 1) % videos.count
    }

    func openCreate() {
        showCreateSheet = true
    }
}

// MARK: - Écrans showroom

private struct LpspTikTokShowroomRoot: View {
    @ObservedObject var store: LpspTikTokStore

    var body: some View {
        ZStack {
            LpspTikTokTokens.tiktokCanvas.ignoresSafeArea()

            switch store.selectedTab {
            case .home:
                LpspTikTokHomeFeedScreen(store: store)
            case .discover:
                LpspTikTokDiscoverTabScreen(store: store)
            case .inbox:
                LpspTikTokInboxTabScreen(store: store)
            case .profile:
                LpspTikTokProfileTabScreen(store: store)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $store.showCreateSheet) {
            LpspTikTokCreateSheet()
        }
    }
}

private struct LpspTikTokHomeFeedScreen: View {
    @ObservedObject var store: LpspTikTokStore
    @State private var burstHearts: [LpspTikTokHeartBurst] = []

    private var video: LpspTikTokVideo { store.currentVideo }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: video.gradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ForEach(burstHearts) { heart in
                Image(systemName: "heart.fill")
                    .font(.system(size: 120, weight: .bold))
                    .foregroundStyle(LpspTikTokTokens.tiktokRose)
                    .scaleEffect(heart.scale)
                    .opacity(heart.opacity)
                    .position(heart.position)
            }

            VStack(spacing: 0) {
                LpspTikTokFeedTopBar(store: store)

                Spacer()

                HStack(alignment: .bottom, spacing: 0) {
                    LpspTikTokCaptionOverlay(
                        username: video.username,
                        caption: video.caption,
                        musicTitle: video.musicTitle
                    )
                    LpspTikTokSpectrActionRail(store: store)
                }

                LpspTikTokVideoScrubber(progress: video.progress)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)

                LpspTikTokRootTabBar(
                    selected: $store.selectedTab,
                    onCreateTapped: { store.openCreate() },
                    isOnFeed: true
                )
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(count: 2) {
            store.doubleTapLike()
            spawnHeart()
        }
        .gesture(
            DragGesture(minimumDistance: 40)
                .onEnded { value in
                    if value.translation.height < -40 {
                        store.advanceVideo()
                    }
                }
        )
    }

    private func spawnHeart() {
        let id = UUID()
        let position = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.45)
        burstHearts.append(LpspTikTokHeartBurst(id: id, position: position, scale: 0, opacity: 1))
        withAnimation(.spring(response: 0.4, dampingFraction: 0.55)) {
            if let index = burstHearts.firstIndex(where: { $0.id == id }) {
                burstHearts[index].scale = 1.4
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            burstHearts.removeAll { $0.id == id }
        }
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
}

private struct LpspTikTokFeedTopBar: View {
    @ObservedObject var store: LpspTikTokStore

    var body: some View {
        HStack {
            Spacer()
            HStack(spacing: 20) {
                ForEach(LpspTikTokFeedMode.allCases, id: \.self) { mode in
                    Button {
                        store.selectFeedMode(mode)
                    } label: {
                        VStack(spacing: 4) {
                            Text(mode.title)
                                .font(.system(size: 17, weight: store.feedMode == mode ? .semibold : .regular))
                                .foregroundStyle(
                                    store.feedMode == mode
                                        ? LpspTikTokTokens.tiktokTextPrimary
                                        : LpspTikTokTokens.tiktokTextPrimary.opacity(0.55)
                                )
                                .tiktokTextOnVideo()
                            if store.feedMode == mode {
                                Capsule()
                                    .fill(LpspTikTokTokens.tiktokTextPrimary)
                                    .frame(width: 24, height: 2)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            Spacer()
            Button {
                store.showSearch = true
                store.selectedTab = .discover
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .shadow(color: LpspTikTokTokens.tiktokScrimLight, radius: 3, x: 0, y: 1)
            }
            .padding(.trailing, 16)
        }
        .padding(.top, 52)
    }
}

private struct LpspTikTokSpectrActionRail: View {
    @ObservedObject var store: LpspTikTokStore

    private var video: LpspTikTokVideo { store.currentVideo }

    var body: some View {
        VStack(spacing: 24) {
            ZStack(alignment: .bottom) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.orange, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 48, height: 48)
                    .overlay(Circle().stroke(.white, lineWidth: 2))

                if !video.isFollowed {
                    Button { store.toggleFollow() } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 18, height: 18)
                            .background(Circle().fill(LpspTikTokTokens.tiktokRose))
                    }
                    .offset(y: 9)
                    .sensoryFeedback(.success, trigger: video.isFollowed)
                }
            }

            LpspTikTokActionIcon(
                systemName: video.isLiked ? "heart.fill" : "heart",
                count: video.likeCount,
                tint: video.isLiked ? LpspTikTokTokens.tiktokRose : .white
            ) {
                store.toggleLike()
            }

            LpspTikTokActionIcon(
                systemName: "ellipsis.bubble.fill",
                count: video.commentCount,
                tint: .white
            ) {}

            LpspTikTokActionIcon(
                systemName: "bookmark.fill",
                count: video.bookmarkCount,
                tint: .white
            ) {}

            LpspTikTokActionIcon(
                systemName: "arrowshape.turn.up.right.fill",
                count: 0,
                countLabel: "Share",
                tint: .white
            ) {}

            LpspTikTokSpinningMusicDisc(artwork: nil)
        }
        .padding(.trailing, 12)
    }
}

private struct LpspTikTokDiscoverTabScreen: View {
    @ObservedObject var store: LpspTikTokStore

    private let cols = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 4) {
                    ForEach(Array(LpspTikTokShowroomData.discoverTags.enumerated()), id: \.offset) { index, tag in
                        Button {
                            store.currentVideoIndex = 0
                            store.selectedTab = .home
                        } label: {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            LpspTikTokTokens.tiktokRose.opacity(0.25 + Double(index) * 0.05),
                                            LpspTikTokTokens.tiktokCanvas,
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .aspectRatio(9/16, contentMode: .fit)
                                .overlay(alignment: .bottomLeading) {
                                    Text(tag)
                                        .font(LpspTikTokFonts.tiktokChip.weight(.bold))
                                        .foregroundStyle(.white)
                                        .tiktokTextOnVideo()
                                        .padding(8)
                                }
                        }
                        .buttonStyle(.plain)
                    }

                    ForEach(store.videos) { video in
                        Button {
                            if let index = store.videos.firstIndex(where: { $0.id == video.id }) {
                                store.currentVideoIndex = index
                                store.selectedTab = .home
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: video.gradient,
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .aspectRatio(9/16, contentMode: .fit)
                                .overlay(alignment: .bottomLeading) {
                                    Text("@\(video.username)")
                                        .font(LpspTikTokFonts.tiktokMeta.weight(.semibold))
                                        .foregroundStyle(.white)
                                        .tiktokTextOnVideo()
                                        .padding(8)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(8)
            }

            LpspTikTokRootTabBar(
                selected: $store.selectedTab,
                onCreateTapped: { store.openCreate() },
                isOnFeed: false
            )
        }
        .background(LpspTikTokTokens.tiktokCanvas.ignoresSafeArea())
    }
}

private struct LpspTikTokInboxTabScreen: View {
    @ObservedObject var store: LpspTikTokStore

    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(LpspTikTokShowroomData.inbox, id: \.title) { item in
                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspTikTokTokens.tiktokSurface)
                            .frame(width: 44, height: 44)
                            .overlay {
                                Image(systemName: "bell.fill")
                                    .foregroundStyle(LpspTikTokTokens.tiktokRose)
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(LpspTikTokFonts.tiktokUsernameList.weight(.semibold))
                                .foregroundStyle(LpspTikTokTokens.tiktokTextPrimary)
                            Text(item.detail)
                                .font(LpspTikTokFonts.tiktokBody)
                                .foregroundStyle(LpspTikTokTokens.tiktokTextSecondary)
                        }

                        Spacer()

                        Text(item.time)
                            .font(LpspTikTokFonts.tiktokMeta)
                            .foregroundStyle(LpspTikTokTokens.tiktokTextTertiary)
                    }
                    .listRowBackground(LpspTikTokTokens.tiktokSurface.opacity(0.55))
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Inbox")

            LpspTikTokRootTabBar(
                selected: $store.selectedTab,
                onCreateTapped: { store.openCreate() },
                isOnFeed: false
            )
        }
        .background(LpspTikTokTokens.tiktokCanvas.ignoresSafeArea())
    }
}

private struct LpspTikTokProfileTabScreen: View {
    @ObservedObject var store: LpspTikTokStore
    @State private var isFollowingProfile = false

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [LpspTikTokTokens.tiktokCyan, LpspTikTokTokens.tiktokRose],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 88, height: 88)
                        .overlay {
                            Text("Y")
                                .font(.title.weight(.bold))
                                .foregroundStyle(.white)
                        }

                    Text("@you")
                        .font(LpspTikTokFonts.tiktokDisplayName.weight(.bold))
                        .foregroundStyle(LpspTikTokTokens.tiktokTextPrimary)

                    HStack(spacing: 24) {
                        LpspTikTokProfileStat(value: "128", label: "Following")
                        LpspTikTokProfileStat(value: "12.4K", label: "Followers")
                        LpspTikTokProfileStat(value: "89K", label: "Likes")
                    }

                    LpspTikTokTikTokFollowButton(isFollowing: $isFollowingProfile)
                        .frame(width: 160)
                }
                .padding(.vertical, 24)
            }

            LpspTikTokRootTabBar(
                selected: $store.selectedTab,
                onCreateTapped: { store.openCreate() },
                isOnFeed: false
            )
        }
        .background(LpspTikTokTokens.tiktokCanvas.ignoresSafeArea())
    }
}

private struct LpspTikTokProfileStat: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(LpspTikTokFonts.tiktokUsername.weight(.bold))
                .foregroundStyle(LpspTikTokTokens.tiktokTextPrimary)
            Text(label)
                .font(LpspTikTokFonts.tiktokMeta)
                .foregroundStyle(LpspTikTokTokens.tiktokTextSecondary)
        }
    }
}

private struct LpspTikTokCreateSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LpspTikTokTokens.tiktokCanvas.ignoresSafeArea()
            VStack(spacing: 20) {
                Text("+")
                    .font(.system(size: 72, weight: .bold))
                    .chromaticAberration(offset: 6)

                Text("Create")
                    .font(LpspTikTokFonts.tiktokSheetTitle.weight(.semibold))
                    .foregroundStyle(LpspTikTokTokens.tiktokTextPrimary)

                LpspTikTokTikTokCreateButton {
                    dismiss()
                }

                Button("Close") { dismiss() }
                    .font(LpspTikTokFonts.tiktokButtonSecondary)
                    .foregroundStyle(LpspTikTokTokens.tiktokTextSecondary)
            }
        }
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
    }
}



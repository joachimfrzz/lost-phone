import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/youtube
// Meliwat/awesome-ios-design-md/video/youtube/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeYouTubeView: View {
    var body: some View {
        LpspYouTubeShowroomRoot(store: LpspYouTubeStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspYouTubeTokens {
    // MARK: - Brand
    static let ytRed        = Color(red: 1.0,   green: 0.0,   blue: 0.0)   // #FF0000
    static let ytRedPressed = Color(red: 0.8,   green: 0.0,   blue: 0.0)   // #CC0000
    static let ytRedHover   = Color(red: 0.902, green: 0.0,   blue: 0.0)   // #E60000

    // MARK: - Light Canvas
    static let ytCanvasLight   = Color.white                                  // #FFFFFF
    static let ytSurface1Light = Color(red: 0.976, green: 0.976, blue: 0.976) // #F9F9F9
    static let ytSurface2Light = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
    static let ytDividerLight  = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5

    // MARK: - Dark Canvas
    static let ytCanvasDark   = Color(red: 0.059, green: 0.059, blue: 0.059) // #0F0F0F
    static let ytSurface1Dark = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
    static let ytSurface2Dark = Color(red: 0.153, green: 0.153, blue: 0.153) // #272727
    static let ytSurface3Dark = Color(red: 0.247, green: 0.247, blue: 0.247) // #3F3F3F
    static let ytDividerDark  = Color(red: 0.188, green: 0.188, blue: 0.188) // #303030

    // MARK: - Text (Light)
    static let ytTextPrimaryLight   = Color(red: 0.059, green: 0.059, blue: 0.059) // #0F0F0F
    static let ytTextSecondaryLight = Color(red: 0.376, green: 0.376, blue: 0.376) // #606060
    static let ytTextTertiaryLight  = Color(red: 0.565, green: 0.565, blue: 0.565) // #909090

    // MARK: - Text (Dark)
    static let ytTextPrimaryDark   = Color.white
    static let ytTextSecondaryDark = Color(red: 0.667, green: 0.667, blue: 0.667) // #AAAAAA
    static let ytTextTertiaryDark  = Color(red: 0.443, green: 0.443, blue: 0.443) // #717171

    // MARK: - Semantic
    static let ytInfoBlue = Color(red: 0.243, green: 0.651, blue: 1.0) // #3EA6FF
}

private enum LpspYouTubeFonts {
    // Display (YouTube Sans)
    static let ytScreenTitle     = Font.system(size: 20, weight: .regular)
    static let ytShortsCaption   = Font.system(size: 15, weight: .regular)

    // Body (Roboto)
    static let ytVideoDetailTitle = Font.system(size: 18, weight: .regular)
    static let ytVideoTitle       = Font.system(size: 16, weight: .regular)
    static let ytChannelName      = Font.system(size: 14, weight: .regular)
    static let ytMetadata         = Font.system(size: 13, weight: .regular)
    static let ytCommentBody      = Font.system(size: 14, weight: .regular)
    static let ytCommentAuthor    = Font.system(size: 13, weight: .regular)
    static let ytBody             = Font.system(size: 14, weight: .regular)
    static let ytButton           = Font.system(size: 14, weight: .regular)
    static let ytChip             = Font.system(size: 14, weight: .regular)
    static let ytTabLabel         = Font.system(size: 10, weight: .regular)
    static let ytDurationTag      = Font.system(size: 11, weight: .regular)
    static let ytTimestamp        = Font.system(size: 12, weight: .regular)

    static func yt(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

fileprivate struct LpspYouTubeSubscribeButton: View {
    @Binding var isSubscribed: Bool
    @State private var bellOn = false

    var body: some View {
        HStack(spacing: 0) {
            Button {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                    isSubscribed.toggle()
                }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Text(isSubscribed ? "Subscribed" : "Subscribe")
                    .font(LpspYouTubeFonts.ytButton)
                    .foregroundStyle(isSubscribed ? LpspYouTubeTokens.ytTextPrimaryLight : .white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(isSubscribed ? LpspYouTubeTokens.ytSurface2Light : LpspYouTubeTokens.ytRed)
                    )
            }
            .buttonStyle(.plain)

            if isSubscribed {
                Button {
                    bellOn.toggle()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } label: {
                    Image(systemName: bellOn ? "bell.fill" : "bell")
                        .font(.system(size: 16))
                        .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(LpspYouTubeTokens.ytSurface2Light)
                        )
                }
                .buttonStyle(.plain)
                .padding(.leading, 4)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
    }
}

fileprivate struct LpspYouTubeVideoCard: View {
    let thumbnailURL: URL?
    let duration: String
    let isLive: Bool
    let title: String
    let channelName: String
    let channelAvatarURL: URL?
    let viewCount: String
    let uploadedAgo: String
    var thumbnailSymbol: String = "play.rectangle.fill"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if let thumbnailURL {
                        AsyncImage(url: thumbnailURL) { img in
                            img.resizable().scaledToFill()
                        } placeholder: { thumbnailPlaceholder }
                    } else {
                        thumbnailPlaceholder
                    }
                }
                .aspectRatio(16/9, contentMode: .fit)
                .clipped()

                if isLive {
                    HStack(spacing: 4) {
                        Circle().fill(Color.white).frame(width: 6, height: 6)
                        Text("LIVE")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 6).padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 4).fill(LpspYouTubeTokens.ytRed))
                    .padding(6)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                } else {
                    Text(duration)
                        .font(LpspYouTubeFonts.ytDurationTag.weight(.medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6).padding(.vertical, 4)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.black.opacity(0.75)))
                        .padding(6)
                }
            }

            HStack(alignment: .top, spacing: 12) {
                Group {
                    if let channelAvatarURL {
                        AsyncImage(url: channelAvatarURL) { img in
                            img.resizable().scaledToFill()
                        } placeholder: { avatarPlaceholder }
                    } else {
                        avatarPlaceholder
                    }
                }
                .frame(width: 28, height: 28)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(LpspYouTubeFonts.ytVideoTitle.weight(.medium))
                        .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                        .lineLimit(2)
                    Text("\(channelName) · \(viewCount) · \(uploadedAgo)")
                        .font(LpspYouTubeFonts.ytMetadata)
                        .foregroundStyle(LpspYouTubeTokens.ytTextSecondaryLight)
                        .lineLimit(1)
                }

                Spacer(minLength: 8)

                Button { } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 16)
        }
    }

    private var thumbnailPlaceholder: some View {
        Rectangle()
            .fill(LpspYouTubeTokens.ytSurface2Light)
            .overlay(
                Image(systemName: thumbnailSymbol)
                    .font(.system(size: 40))
                    .foregroundStyle(LpspYouTubeTokens.ytTextTertiaryLight)
            )
    }

    private var avatarPlaceholder: some View {
        Circle()
            .fill(LpspYouTubeTokens.ytSurface2Light)
            .overlay(
                Text(String(channelName.prefix(1)))
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(LpspYouTubeTokens.ytTextSecondaryLight)
            )
    }
}

fileprivate struct LpspYouTubeActionPill: View {
    let systemIcon: String
    let label: String?
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: systemIcon)
                    .font(.system(size: 20))
                if let label {
                    Text(label)
                        .font(LpspYouTubeFonts.ytMetadata)
                        .fontWeight(.medium)
                }
            }
            .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 18).fill(LpspYouTubeTokens.ytSurface2Light))
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isActive)
    }
}

fileprivate struct LpspYouTubeMiniPlayer: View {
    let thumbnailURL: URL?
    let title: String
    let channelName: String
    @Binding var isPlaying: Bool
    let onExpand: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Group {
                if let thumbnailURL {
                    AsyncImage(url: thumbnailURL) { img in
                        img.resizable().scaledToFill()
                    } placeholder: { placeholder }
                } else {
                    placeholder
                }
            }
            .frame(width: 128, height: 72)
            .clipped()

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(LpspYouTubeFonts.ytChannelName)
                    .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                    .lineLimit(1)
                Text(channelName)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(LpspYouTubeTokens.ytTextSecondaryLight)
                    .lineLimit(1)
            }
            Spacer()

            Button {
                isPlaying.toggle()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
            }
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
            }
            .padding(.trailing, 8)
        }
        .frame(height: 72)
        .background(LpspYouTubeTokens.ytCanvasLight)
        .contentShape(Rectangle())
        .onTapGesture { onExpand() }
    }

    private var placeholder: some View {
        Rectangle().fill(LpspYouTubeTokens.ytSurface2Light)
    }
}

fileprivate struct LpspYouTubeFilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspYouTubeFonts.ytChip)
                .foregroundStyle(isSelected ? LpspYouTubeTokens.ytCanvasLight : LpspYouTubeTokens.ytTextPrimaryLight)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    Capsule().fill(isSelected ? LpspYouTubeTokens.ytTextPrimaryLight : LpspYouTubeTokens.ytSurface2Light)
                )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: isSelected)
    }
}

fileprivate struct LpspYouTubeFilterChipRow: View {
    let chips: [String]
    @Binding var selected: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(chips, id: \.self) { chip in
                    LpspYouTubeFilterChip(label: chip, isSelected: selected == chip) {
                        withAnimation(.easeInOut(duration: 0.2)) { selected = chip }
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
    }
}

fileprivate struct LpspYouTubeShortsActionRail: View {
    let creatorAvatarURL: URL
    let likeCount: String
    let commentCount: String
    @Binding var isLiked: Bool

    var body: some View {
        VStack(spacing: 20) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: creatorAvatarURL) { img in
                    img.resizable().scaledToFill()
                } placeholder: { Color.gray }
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white, lineWidth: 2))
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspYouTubeTokens.ytRed, .white)
                    .offset(x: 4, y: 4)
            }

            VStack(spacing: 4) {
                Button {
                    isLiked.toggle()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } label: {
                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
                }
                Text(likeCount)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
            }

            VStack(spacing: 4) {
                Image(systemName: "hand.thumbsdown")
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
            }

            VStack(spacing: 4) {
                Image(systemName: "bubble.right")
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
                Text(commentCount)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
            }

            Image(systemName: "arrowshape.turn.up.right")
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
        }
    }
}



// MARK: - Données & état (showroom Spectr)

fileprivate struct LpspYouTubeVideo: Identifiable, Hashable {
    let id: String
    let title: String
    let channelName: String
    let duration: String
    let viewCount: String
    let uploadedAgo: String
    let category: String
    let isLive: Bool
    let thumbnailSymbol: String
    var likeCount: String
    var isLiked: Bool
}

fileprivate struct LpspYouTubeShort: Identifiable, Hashable {
    let id: String
    let title: String
    let channelName: String
    var likeCount: String
    var isLiked: Bool
}

fileprivate struct LpspYouTubeChannel: Identifiable, Hashable {
    let id: String
    let name: String
    let hasNew: Bool
}

private enum LpspYouTubeTab: CaseIterable {
    case home, shorts, subscriptions, you

    var label: String {
        switch self {
        case .home: "Home"
        case .shorts: "Shorts"
        case .subscriptions: "Subscriptions"
        case .you: "You"
        }
    }

    var icon: String {
        switch self {
        case .home: "house.fill"
        case .shorts: "play.rectangle.fill"
        case .subscriptions: "play.square.stack.fill"
        case .you: "person.crop.circle.fill"
        }
    }
}

@MainActor
fileprivate final class LpspYouTubeStore: ObservableObject {
    @Published var selectedTab: LpspYouTubeTab = .home
    @Published var selectedFilter = "All"
    @Published var videos: [LpspYouTubeVideo]
    @Published var shorts: [LpspYouTubeShort]
    @Published var subscriptions: [LpspYouTubeChannel]
    @Published var selectedVideoID: String?
    @Published var showVideoDetail = false
    @Published var isSubscribed = false
    @Published var miniPlayerPlaying = true
    @Published var showMiniPlayer = false

    let filterChips = ["All", "Music", "Gaming", "Podcasts"]

    init() {
        self.videos = LpspYouTubeShowroomData.videos
        self.shorts = LpspYouTubeShowroomData.shorts
        self.subscriptions = LpspYouTubeShowroomData.subscriptions
    }

    var filteredVideos: [LpspYouTubeVideo] {
        guard selectedFilter != "All" else { return videos }
        return videos.filter { $0.category == selectedFilter }
    }

    var selectedVideo: LpspYouTubeVideo? {
        guard let selectedVideoID else { return nil }
        return videos.first { $0.id == selectedVideoID }
    }

    func openVideo(_ id: String) {
        selectedVideoID = id
        showVideoDetail = true
        miniPlayerPlaying = true
    }

    func closeVideoDetail() {
        showVideoDetail = false
        if selectedVideoID != nil {
            showMiniPlayer = true
            miniPlayerPlaying = true
        }
    }

    func dismissMiniPlayer() {
        showMiniPlayer = false
        selectedVideoID = nil
        miniPlayerPlaying = false
    }

    func toggleLike(videoID: String) {
        guard let index = videos.firstIndex(where: { $0.id == videoID }) else { return }
        videos[index].isLiked.toggle()
    }

    func toggleShortLike(shortID: String) {
        guard let index = shorts.firstIndex(where: { $0.id == shortID }) else { return }
        shorts[index].isLiked.toggle()
    }
}

private enum LpspYouTubeShowroomData {
    static let videos: [LpspYouTubeVideo] = [
        .init(
            id: "golden-hour",
            title: "Golden hour film workflow — shooting on a 40-year-old lens",
            channelName: "Amber Leaf",
            duration: "12:34",
            viewCount: "142K views",
            uploadedAgo: "2 hours ago",
            category: "All",
            isLive: false,
            thumbnailSymbol: "camera.aperture",
            likeCount: "8.4K",
            isLiked: false
        ),
        .init(
            id: "tiny-cli",
            title: "Building a tiny CLI that actually ships",
            channelName: "PlantNook Dev",
            duration: "8:02",
            viewCount: "1.2M views",
            uploadedAgo: "3 days ago",
            category: "Gaming",
            isLive: false,
            thumbnailSymbol: "terminal.fill",
            likeCount: "42K",
            isLiked: true
        ),
        .init(
            id: "jazz-live",
            title: "Late night jazz session — upright bass & brushes",
            channelName: "Blue Room Sessions",
            duration: "LIVE",
            viewCount: "3.1K watching",
            uploadedAgo: "now",
            category: "Music",
            isLive: true,
            thumbnailSymbol: "music.note.list",
            likeCount: "210",
            isLiked: false
        ),
        .init(
            id: "podcast-clip",
            title: "Why everyone is wrong about productivity",
            channelName: "The Long Form",
            duration: "24:18",
            viewCount: "890K views",
            uploadedAgo: "1 week ago",
            category: "Podcasts",
            isLive: false,
            thumbnailSymbol: "mic.fill",
            likeCount: "31K",
            isLiked: false
        ),
    ]

    static let shorts: [LpspYouTubeShort] = [
        .init(id: "s1", title: "60-sec soup", channelName: "Kitchen Quick", likeCount: "12K", isLiked: false),
        .init(id: "s2", title: "Lens test", channelName: "Amber Leaf", likeCount: "4.2K", isLiked: true),
        .init(id: "s3", title: "Cabin vlog", channelName: "North Woods", likeCount: "8.9K", isLiked: false),
        .init(id: "s4", title: "Garden", channelName: "PlantNook Dev", likeCount: "2.1K", isLiked: false),
    ]

    static let subscriptions: [LpspYouTubeChannel] = [
        .init(id: "amber", name: "Amber Leaf", hasNew: true),
        .init(id: "plantnook", name: "PlantNook Dev", hasNew: true),
        .init(id: "blueroom", name: "Blue Room Sessions", hasNew: false),
        .init(id: "longform", name: "The Long Form", hasNew: false),
    ]
}

// MARK: - Écrans showroom

private struct LpspYouTubeShowroomRoot: View {
    @ObservedObject var store: LpspYouTubeStore

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .home:
                        LpspYouTubeHomeScreen(store: store)
                    case .shorts:
                        LpspYouTubeShortsScreen(store: store)
                    case .subscriptions:
                        LpspYouTubeSubscriptionsScreen(store: store)
                    case .you:
                        LpspYouTubeYouScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                if store.showMiniPlayer, let video = store.selectedVideo {
                    LpspYouTubeMiniPlayer(
                        thumbnailURL: nil,
                        title: video.title,
                        channelName: video.channelName,
                        isPlaying: $store.miniPlayerPlaying,
                        onExpand: {
                            store.showVideoDetail = true
                        },
                        onDismiss: { store.dismissMiniPlayer() }
                    )
                }

                LpspYouTubeTabBar(store: store)
            }
        }
        .sheet(isPresented: $store.showVideoDetail) {
            if let video = store.selectedVideo {
                LpspYouTubeVideoDetailSheet(store: store, video: video)
            }
        }
    }
}

private struct LpspYouTubeTabBar: View {
    @ObservedObject var store: LpspYouTubeStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspYouTubeTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.label)
                            .font(LpspYouTubeFonts.ytTabLabel)
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspYouTubeTokens.ytRed : LpspYouTubeTokens.ytTextSecondaryLight)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
                .sensoryFeedback(.selection, trigger: store.selectedTab)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspYouTubeTokens.ytCanvasLight)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspYouTubeTokens.ytDividerLight).frame(height: 0.5)
        }
    }
}

private struct LpspYouTubeHomeScreen: View {
    @ObservedObject var store: LpspYouTubeStore

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LpspYouTubeTokens.ytRed)
                        .frame(width: 28, height: 20)
                        .overlay(
                            Image(systemName: "play.fill")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(.white)
                        )
                    Text("YouTube")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                }
                Spacer()
                Image(systemName: "magnifyingglass")
                Image(systemName: "bell")
                Circle()
                    .fill(LpspYouTubeTokens.ytInfoBlue)
                    .frame(width: 28, height: 28)
                    .overlay(Text("M").font(.system(size: 12, weight: .bold)).foregroundStyle(.white))
            }
            .font(.system(size: 20))
            .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
            .padding(.horizontal, 16)
            .frame(height: 44)

            LpspYouTubeFilterChipRow(chips: store.filterChips, selected: $store.selectedFilter)

            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(store.filteredVideos) { video in
                        Button { store.openVideo(video.id) } label: {
                            LpspYouTubeVideoCard(
                                thumbnailURL: nil,
                                duration: video.isLive ? "" : video.duration,
                                isLive: video.isLive,
                                title: video.title,
                                channelName: video.channelName,
                                channelAvatarURL: nil,
                                viewCount: video.viewCount,
                                uploadedAgo: video.uploadedAgo,
                                thumbnailSymbol: video.thumbnailSymbol
                            )
                        }
                        .buttonStyle(.plain)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Shorts")
                            .font(LpspYouTubeFonts.ytVideoTitle.weight(.bold))
                            .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                            .padding(.horizontal, 16)
                            .padding(.top, 8)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(store.shorts) { short in
                                    Button {
                                        store.selectedTab = .shorts
                                    } label: {
                                        VStack(alignment: .leading, spacing: 6) {
                                            Rectangle()
                                                .fill(LpspYouTubeTokens.ytSurface2Light)
                                                .frame(width: 120, height: 200)
                                                .overlay(
                                                    Image(systemName: "play.fill")
                                                        .foregroundStyle(LpspYouTubeTokens.ytTextTertiaryLight)
                                                )
                                            Text(short.title)
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                                                .lineLimit(1)
                                        }
                                        .frame(width: 120)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.bottom, 16)
                }
            }
        }
        .background(LpspYouTubeTokens.ytCanvasLight.ignoresSafeArea())
    }
}

private struct LpspYouTubeShortsScreen: View {
    @ObservedObject var store: LpspYouTubeStore
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if store.shorts.indices.contains(currentIndex) {
                let short = store.shorts[currentIndex]
                VStack {
                    Spacer()
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("@\(short.channelName.replacingOccurrences(of: " ", with: ""))")
                                .font(LpspYouTubeFonts.ytChannelName.weight(.semibold))
                                .foregroundStyle(.white)
                            Text(short.title)
                                .font(LpspYouTubeFonts.ytShortsCaption)
                                .foregroundStyle(.white)
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 24)

                        Spacer()

                        LpspYouTubeShortsActionRail(
                            creatorAvatarURL: URL(string: "https://example.com")!,
                            likeCount: short.likeCount,
                            commentCount: "120",
                            isLiked: Binding(
                                get: { store.shorts[currentIndex].isLiked },
                                set: { _ in store.toggleShortLike(shortID: short.id) }
                            )
                        )
                        .padding(.trailing, 12)
                        .padding(.bottom, 24)
                    }
                }
            }

            VStack {
                HStack {
                    Spacer()
                    Text("Shorts")
                        .font(LpspYouTubeFonts.ytScreenTitle.weight(.bold))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.top, 8)
                Spacer()
            }
        }
        .gesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    if value.translation.height < 0, currentIndex < store.shorts.count - 1 {
                        currentIndex += 1
                    } else if value.translation.height > 0, currentIndex > 0 {
                        currentIndex -= 1
                    }
                }
        )
    }
}

private struct LpspYouTubeSubscriptionsScreen: View {
    @ObservedObject var store: LpspYouTubeStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(store.subscriptions) { channel in
                            VStack(spacing: 8) {
                                ZStack(alignment: .topTrailing) {
                                    Circle()
                                        .fill(LpspYouTubeTokens.ytSurface2Light)
                                        .frame(width: 56, height: 56)
                                        .overlay(
                                            Text(String(channel.name.prefix(1)))
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundStyle(LpspYouTubeTokens.ytTextSecondaryLight)
                                        )
                                    if channel.hasNew {
                                        Circle()
                                            .fill(LpspYouTubeTokens.ytRed)
                                            .frame(width: 10, height: 10)
                                            .offset(x: 2, y: -2)
                                    }
                                }
                                Text(channel.name)
                                    .font(.system(size: 12))
                                    .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                                    .lineLimit(1)
                                    .frame(width: 72)
                            }
                        }
                    }
                    .padding(16)
                }

                List {
                    ForEach(store.videos.filter { video in
                        store.subscriptions.contains { $0.name == video.channelName }
                    }) { video in
                        Button { store.openVideo(video.id) } label: {
                            HStack(spacing: 12) {
                                Rectangle()
                                    .fill(LpspYouTubeTokens.ytSurface2Light)
                                    .frame(width: 120, height: 68)
                                    .overlay(Image(systemName: video.thumbnailSymbol).foregroundStyle(LpspYouTubeTokens.ytTextTertiaryLight))
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(video.title)
                                        .font(LpspYouTubeFonts.ytVideoTitle.weight(.medium))
                                        .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                                        .lineLimit(2)
                                    Text("\(video.channelName) · \(video.uploadedAgo)")
                                        .font(LpspYouTubeFonts.ytMetadata)
                                        .foregroundStyle(LpspYouTubeTokens.ytTextSecondaryLight)
                                }
                            }
                        }
                        .listRowBackground(LpspYouTubeTokens.ytCanvasLight)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Subscriptions")
        }
        .background(LpspYouTubeTokens.ytCanvasLight.ignoresSafeArea())
    }
}

private struct LpspYouTubeYouScreen: View {
    @ObservedObject var store: LpspYouTubeStore

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspYouTubeTokens.ytInfoBlue)
                            .frame(width: 48, height: 48)
                            .overlay(Text("M").font(.system(size: 18, weight: .bold)).foregroundStyle(.white))
                        VStack(alignment: .leading) {
                            Text("Mathieu")
                                .font(LpspYouTubeFonts.ytVideoDetailTitle.weight(.semibold))
                            Text("View channel")
                                .font(LpspYouTubeFonts.ytMetadata)
                                .foregroundStyle(LpspYouTubeTokens.ytTextSecondaryLight)
                        }
                    }
                }
                Section {
                    Label("History", systemImage: "clock")
                    Label("Your videos", systemImage: "play.rectangle")
                    Label("Playlists", systemImage: "list.bullet")
                    Label("Watch later", systemImage: "clock.badge.checkmark")
                    Label("Liked videos", systemImage: "hand.thumbsup")
                }
            }
            .navigationTitle("You")
        }
    }
}

private struct LpspYouTubeVideoDetailSheet: View {
    @ObservedObject var store: LpspYouTubeStore
    let video: LpspYouTubeVideo
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Rectangle()
                        .fill(LpspYouTubeTokens.ytSurface2Light)
                        .aspectRatio(16/9, contentMode: .fit)
                        .overlay(
                            Image(systemName: video.thumbnailSymbol)
                                .font(.system(size: 48))
                                .foregroundStyle(LpspYouTubeTokens.ytTextTertiaryLight)
                        )

                    Text(video.title)
                        .font(LpspYouTubeFonts.ytVideoDetailTitle.weight(.semibold))
                        .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                        .padding(.horizontal, 16)

                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspYouTubeTokens.ytSurface2Light)
                            .frame(width: 36, height: 36)
                            .overlay(Text(String(video.channelName.prefix(1))).font(.system(size: 14, weight: .bold)))
                        Text(video.channelName)
                            .font(LpspYouTubeFonts.ytChannelName.weight(.semibold))
                        Spacer()
                        LpspYouTubeSubscribeButton(isSubscribed: $store.isSubscribed)
                    }
                    .padding(.horizontal, 16)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            LpspYouTubeActionPill(
                                systemIcon: video.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup",
                                label: video.likeCount,
                                isActive: video.isLiked
                            ) { store.toggleLike(videoID: video.id) }
                            LpspYouTubeActionPill(systemIcon: "hand.thumbsdown", label: nil, isActive: false) {}
                            LpspYouTubeActionPill(systemIcon: "arrowshape.turn.up.right", label: "Share", isActive: false) {}
                            LpspYouTubeActionPill(systemIcon: "arrow.down.to.line", label: "Download", isActive: false) {}
                        }
                        .padding(.horizontal, 16)
                    }

                    Text("\(video.viewCount) · \(video.uploadedAgo)")
                        .font(LpspYouTubeFonts.ytMetadata)
                        .foregroundStyle(LpspYouTubeTokens.ytTextSecondaryLight)
                        .padding(.horizontal, 16)
                }
            }
            .background(LpspYouTubeTokens.ytCanvasLight)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        store.closeVideoDetail()
                        dismiss()
                    }
                }
            }
        }
    }
}

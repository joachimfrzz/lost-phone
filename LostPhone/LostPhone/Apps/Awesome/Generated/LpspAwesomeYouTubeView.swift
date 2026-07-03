import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/video/youtube/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/youtube
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeYouTubeView: View {
    var body: some View {
        LpspYouTubeShowroomRoot()
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
    let thumbnailURL: URL
    let duration: String         // "12:34"
    let isLive: Bool
    let title: String
    let channelName: String
    let channelAvatarURL: URL
    let viewCount: String        // "1.2M views"
    let uploadedAgo: String      // "3 days ago"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Thumbnail with duration tag
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: thumbnailURL) { img in
                    img.resizable().scaledToFill()
                } placeholder: { LpspYouTubeTokens.ytSurface2Light }
                    .aspectRatio(16/9, contentMode: .fit)
                    .clipped()

                if isLive {
                    HStack(spacing: 4) {
                        Circle().fill(Color.white).frame(width: 6, height: 6)
                        Text("LIVE")
                            .font(.custom("Roboto-Bold", size: 11))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 6).padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 4).fill(LpspYouTubeTokens.ytRed))
                    .padding(6)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                } else {
                    Text(duration)
                        .font(LpspYouTubeFonts.ytDurationTag)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6).padding(.vertical, 4)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.black.opacity(0.75)))
                        .padding(6)
                }
            }

            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: channelAvatarURL) { img in
                    img.resizable().scaledToFill()
                } placeholder: { LpspYouTubeTokens.ytSurface2Light }
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(LpspYouTubeFonts.ytVideoTitle)
                        .foregroundStyle(LpspYouTubeTokens.ytTextPrimaryLight)
                        .lineLimit(2)
                    Text("\(channelName) · \(viewCount) · \(uploadedAgo)")
                        .font(LpspYouTubeFonts.ytMetadata)
                        .foregroundStyle(LpspYouTubeTokens.ytTextSecondaryLight)
                        .lineLimit(1)
                }

                Spacer(minLength: 8)

                Button { /* overflow */ } label: {
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
    let thumbnailURL: URL
    let title: String
    let channelName: String
    @Binding var isPlaying: Bool
    let onExpand: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: thumbnailURL) { img in
                img.resizable().scaledToFill()
            } placeholder: { LpspYouTubeTokens.ytSurface2Light }
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
    @State private var selected: String = "All"

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



// MARK: - Écrans showroom

private struct LpspYouTubeShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspYouTubeVideoHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspYouTubeVideoHomeTabScreen()
                .tabItem { Label("Shorts", systemImage: "play.rectangle.fill") }
                .tag(1)
            LpspYouTubeVideoHomeTabScreen()
                .tabItem { Label("Subscriptions", systemImage: "play.square.stack.fill") }
                .tag(2)
            LpspYouTubeVideoHomeTabScreen()
                .tabItem { Label("You", systemImage: "person.crop.circle.fill") }
                .tag(3)
        }
        .tint(LpspYouTubeTokens.ytRed)
        .preferredColorScheme(.dark)
    }
}


private struct LpspYouTubeGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspYouTubeTokens.ytRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspYouTubeTokens.ytRed))
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


private struct LpspYouTubeDemoProfile: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let isKids: Bool
}

private enum LpspYouTubeDemoProfiles {
    static let items: [LpspYouTubeDemoProfile] = [
        .init(name: "Lost Phone", color: .red, isKids: false),
        .init(name: "Enfants", color: .orange, isKids: true),
    ]
}

private struct LpspYouTubeVideoHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.08, green: 0.08, blue: 0.08), Color.black],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 220)
                            .overlay(alignment: .center) {
                                Image(systemName: "play.circle.fill").font(.system(size: 56)).foregroundStyle(.white.opacity(0.9))
                            }
                        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                            .frame(height: 80)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding(.horizontal, 12)
                    Button("Lecture") {}.buttonStyle(.borderedProminent).tint(.red)
                        .padding(.horizontal, 12)
                    Text("Tendances").font(.system(size: 17, weight: .bold)).foregroundStyle(.white).padding(.horizontal, 12)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(0..<6, id: \.self) { i in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                                    .frame(width: 110, height: 165)
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .padding(.vertical, 8)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("")
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

private struct LpspYouTubeProfilePickerTabScreen: View {
    var body: some View {
        LpspYouTubeDemoProfilePicker()
    }
}

private struct LpspYouTubeDemoProfilePicker: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Qui regarde ?").font(.system(size: 32, weight: .bold)).foregroundStyle(.white)
                ForEach(LpspYouTubeDemoProfiles.items) { p in
                    VStack(spacing: 8) {
                        Circle().fill(p.color).frame(width: 72, height: 72)
                        Text(p.name).foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}



import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/snapchat
// Meliwat/awesome-ios-design-md/social/snapchat/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeSnapchatView: View {
    var body: some View {
        LpspSnapchatShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspSnapchatTokens {
    // MARK: - Canvas & Surfaces
    static let snapCanvas          = Color.black                                   // #000000
    static let snapSurface1        = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let snapSurface2        = Color(red: 0.173, green: 0.173, blue: 0.173) // #2C2C2C
    static let snapDivider         = Color(red: 0.200, green: 0.200, blue: 0.200) // #333333

    // MARK: - Canvas (Light, limited use)
    static let snapLightCanvas     = Color.white                                   // #FFFFFF
    static let snapLightSurface1   = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2

    // MARK: - Text
    static let snapTextPrimary     = Color.white                                   // #FFFFFF
    static let snapTextPrimaryLight = Color.black                                  // #000000
    static let snapTextSecondary   = Color(red: 0.541, green: 0.541, blue: 0.561) // #8A8A8F
    static let snapTextTertiary    = Color(red: 0.333, green: 0.333, blue: 0.333) // #555555

    // MARK: - Brand
    static let snapYellow          = Color(red: 1.000, green: 0.988, blue: 0.000) // #FFFC00
    static let snapYellowPressed   = Color(red: 0.902, green: 0.890, blue: 0.000) // #E6E300

    // MARK: - Snap Type Colors
    static let snapPhotoRed        = Color(red: 1.000, green: 0.180, blue: 0.239) // #FF2E3D
    static let snapVideoPurple     = Color(red: 0.608, green: 0.318, blue: 1.000) // #9B51FF
    static let snapChatBlue        = Color(red: 0.302, green: 0.655, blue: 1.000) // #4DA7FF
    static let snapAudioGreen      = Color(red: 0.298, green: 0.851, blue: 0.392) // #4CD964

    // MARK: - Semantic
    static let snapErrorRed        = Color(red: 1.000, green: 0.231, blue: 0.188) // #FF3B30
    static let snapSuccessGreen    = Color(red: 0.000, green: 0.847, blue: 0.451) // #00D873
    static let snapLiveRed         = Color(red: 1.000, green: 0.180, blue: 0.239) // #FF2E3D
}

private enum LpspSnapchatFonts {
    static let snapSplashTitle    = Font.system(size: 48, weight: .regular)
    static let snapScreenTitle    = Font.system(size: 24, weight: .regular)
    static let snapSectionHeader  = Font.system(size: 20, weight: .regular)
    static let snapChatRowName    = Font.system(size: 16, weight: .regular)
    static let snapChatMessage    = Font.system(size: 16, weight: .regular)
    static let snapChatStatus     = Font.system(size: 13, weight: .regular)
    static let snapStoryName      = Font.system(size: 14, weight: .regular)
    static let snapTimestamp      = Font.system(size: 12, weight: .regular)
    static let snapStreakCount    = Font.system(size: 18, weight: .regular)
    static let snapHudLabel       = Font.system(size: 13, weight: .regular)
    static let snapButton         = Font.system(size: 16, weight: .regular)
    static let snapLensLabel      = Font.system(size: 13, weight: .regular)
    static let snapBitmojiCallout = Font.system(size: 14, weight: .regular)
    static let snapSpotlightCap   = Font.system(size: 14, weight: .regular)
    static let snapDiscoverTitle  = Font.system(size: 16, weight: .regular)
}

fileprivate struct LpspSnapchatSnapCaptureButton: View {
    @Binding var isRecording: Bool
    @Binding var recordProgress: Double  // 0...1 over 60s
    let onPhoto: () -> Void
    let onVideoStart: () -> Void
    let onVideoStop: () -> Void
    let onFlip: () -> Void

    @State private var innerScale: CGFloat = 1.0
    @State private var lastTapTime: Date = .distantPast

    var body: some View {
        ZStack {
            // Outer yellow ring
            Circle()
                .stroke(LpspSnapchatTokens.snapYellow, lineWidth: 6)
                .frame(width: 82, height: 82)
                .overlay {
                    if isRecording {
                        Circle()
                            .trim(from: 0, to: recordProgress)
                            .stroke(LpspSnapchatTokens.snapYellow, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                            .frame(width: 82, height: 82)
                            .rotationEffect(.degrees(-90))
                    }
                }

            // Inner white (or yellow when recording) circle
            Circle()
                .fill(isRecording ? LpspSnapchatTokens.snapYellow : Color.white)
                .frame(width: 64, height: 64)
                .scaleEffect(innerScale)
        }
        .frame(width: 82, height: 82)
        .gesture(
            // Tap = photo
            TapGesture(count: 1)
                .onEnded { _ in
                    let now = Date()
                    if now.timeIntervalSince(lastTapTime) < 0.3 {
                        // double tap = flip
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        onFlip()
                    } else {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        withAnimation(.spring(response: 0.25)) {
                            innerScale = 0.92
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                            withAnimation(.spring(response: 0.25)) { innerScale = 1.0 }
                        }
                        onPhoto()
                    }
                    lastTapTime = now
                }
        )
        .simultaneousGesture(
            // Long press = video
            LongPressGesture(minimumDuration: 0.35)
                .onChanged { _ in
                    if !isRecording {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        onVideoStart()
                    }
                }
                .onEnded { _ in
                    if isRecording {
                        onVideoStop()
                    }
                }
        )
        .padding(.bottom, 20)
    }
}

fileprivate struct LpspSnapchatSnapChatRow: View {
    enum LpspSnapchatSnapType { case photo, video, chat, audio, none }
    enum LpspSnapchatDirection { case incoming, outgoing }

    let name: String
    let bitmoji: Image
    let status: String           // "Received · 2m ago"
    let timestamp: String        // "2m"
    let snapType: LpspSnapchatSnapType
    let direction: LpspSnapchatDirection
    let isUnread: Bool
    let streakDays: Int?

    var body: some View {
        HStack(spacing: 12) {
            bitmoji
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(LpspSnapchatFonts.snapChatRowName)
                    .foregroundStyle(LpspSnapchatTokens.snapTextPrimary)
                HStack(spacing: 6) {
                    if snapType != .none {
                        LpspSnapchatSnapTypeIndicator(type: snapType, direction: direction, isUnread: isUnread)
                    }
                    Text(status)
                        .font(LpspSnapchatFonts.snapChatStatus)
                        .foregroundStyle(LpspSnapchatTokens.snapTextSecondary)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(timestamp)
                    .font(LpspSnapchatFonts.snapTimestamp)
                    .foregroundStyle(LpspSnapchatTokens.snapTextSecondary)
                if let days = streakDays {
                    HStack(spacing: 2) {
                        Text("🔥")
                        Text("\(days)")
                            .font(LpspSnapchatFonts.snapStreakCount)
                            .foregroundStyle(LpspSnapchatTokens.snapTextPrimary)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .background(LpspSnapchatTokens.snapCanvas)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspSnapchatTokens.snapDivider).frame(height: 1)
        }
    }
}

fileprivate struct LpspSnapchatSnapTypeIndicator: View {
    let type: LpspSnapchatSnapChatRow.LpspSnapchatSnapType
    let direction: LpspSnapchatSnapChatRow.LpspSnapchatDirection
    let isUnread: Bool

    var color: Color {
        switch type {
        case .photo: LpspSnapchatTokens.snapPhotoRed
        case .video: LpspSnapchatTokens.snapVideoPurple
        case .chat:  LpspSnapchatTokens.snapChatBlue
        case .audio: LpspSnapchatTokens.snapAudioGreen
        case .none:  LpspSnapchatTokens.snapTextSecondary
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(isUnread ? color : .clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(color, lineWidth: 1.5)
                )
                .frame(width: 16, height: 16)
            Image(systemName: direction == .incoming ? "arrow.down" : "arrow.up")
                .font(.system(size: 8, weight: .bold))
                .foregroundStyle(isUnread ? .white : color)
        }
    }
}

fileprivate struct LpspSnapchatSnapStoryThumb: View {
    enum ReadState { case unread, read, live }

    let creatorName: String
    let bitmoji: Image
    let preview: Image
    let state: ReadState
    @State private var ringOpacity: Double = 1.0

    var body: some View {
        ZStack(alignment: .topLeading) {
            preview
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(ringColor, lineWidth: 3)
                        .opacity(ringOpacity)
                )

            bitmoji
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .padding(8)

            VStack {
                Spacer()
                Text(creatorName)
                    .font(LpspSnapchatFonts.snapStoryName)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
                    .padding(10)
            }
            .frame(width: 120, height: 200, alignment: .bottomLeading)
        }
        .onAppear {
            if state == .unread {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    ringOpacity = 0.7
                }
            }
        }
    }

    private var ringColor: Color {
        switch state {
        case .unread: LpspSnapchatTokens.snapYellow
        case .read:   LpspSnapchatTokens.snapTextTertiary
        case .live:   LpspSnapchatTokens.snapLiveRed
        }
    }
}

fileprivate struct LpspSnapchatSnapChatBubble: View {
    enum LpspSnapchatSender { case me, them }
    let text: String
    let sender: LpspSnapchatSender

    var body: some View {
        HStack {
            if sender == .me { Spacer(minLength: 60) }
            Text(text)
                .font(LpspSnapchatFonts.snapChatMessage)
                .foregroundStyle(LpspSnapchatTokens.snapTextPrimary)
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(sender == .me ? LpspSnapchatTokens.snapSurface2 : LpspSnapchatTokens.snapSurface1)
                )
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: .leading)
            if sender == .them { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspSnapchatSnapCameraHUD: View {
    @State private var isRecording = false
    @State private var recordProgress: Double = 0
    @State private var selectedLens: Int = 2  // center of carousel
    @State private var flashOn = false

    private let lenses = ["😎", "🎭", "🐶", "😂", "✨"]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Live camera feed placeholder
                Color.black
                    .overlay(
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 80))
                            .foregroundStyle(.white.opacity(0.2))
                    )
                    .ignoresSafeArea()

                // Top HUD
                VStack {
                    HStack {
                        LpspSnapchatHUDIcon(system: "person.crop.circle.fill")
                        Spacer()
                        LpspSnapchatHUDIcon(system: flashOn ? "bolt.fill" : "bolt.slash.fill",
                                tint: flashOn ? LpspSnapchatTokens.snapYellow : .white) {
                            flashOn.toggle()
                        }
                        LpspSnapchatHUDIcon(system: "arrow.triangle.2.circlepath.camera.fill")
                        LpspSnapchatHUDIcon(system: "magnifyingglass")
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                    Spacer()

                    // Lens carousel
                    LpspSnapchatLensCarousel(lenses: lenses, selected: $selectedLens)
                        .padding(.bottom, 16)

                    // Bottom row: memories, capture, chat
                    HStack {
                        LpspSnapchatHUDIcon(system: "photo.stack.fill", size: 32)
                        Spacer()
                        LpspSnapchatSnapCaptureButton(isRecording: $isRecording, recordProgress: $recordProgress,
                                          onPhoto: {}, onVideoStart: { isRecording = true }, onVideoStop: { isRecording = false }, onFlip: {})
                        Spacer()
                        LpspSnapchatHUDIcon(system: "bubble.left.fill", size: 32)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 16)
                }
            }
        }
    }
}

fileprivate struct LpspSnapchatHUDIcon: View {
    let system: String
    var size: CGFloat = 28
    var tint: Color = .white
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: system)
                .font(.system(size: size, weight: .medium))
                .foregroundStyle(tint)
                .shadow(color: .black.opacity(0.4), radius: 2, y: 1)
                .frame(width: 44, height: 44)
        }
    }
}

fileprivate struct LpspSnapchatLensCarousel: View {
    let lenses: [String]
    @Binding var selected: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(lenses.enumerated()), id: \.offset) { i, lens in
                    let isActive = i == selected
                    Button {
                        withAnimation(.spring(response: 0.3)) { selected = i }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(LpspSnapchatTokens.snapSurface2)
                                .frame(width: isActive ? 72 : 60, height: isActive ? 72 : 60)
                                .overlay(
                                    Circle().stroke(LpspSnapchatTokens.snapYellow, lineWidth: isActive ? 3 : 0)
                                )
                            Text(lens)
                                .font(.system(size: isActive ? 32 : 28))
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}


fileprivate struct LpspSnapchatSnapNavIndicator: View {
    let selected: Int
    private let icons = ["map.fill", "bubble.left.fill", "camera.fill", "play.rectangle.fill", "diamond.fill"]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(icons.enumerated()), id: \.offset) { i, icon in
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundStyle(i == selected ? Color.white : LpspSnapchatTokens.snapTextTertiary)
                    .frame(maxWidth: .infinity, minHeight: 56)
            }
        }
        .background(.black.opacity(0.5))
    }
}

// MARK: - Écrans showroom

private struct LpspSnapchatShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspSnapchatSpectrHomeTabScreen()
                .tabItem { Label("Accueil", systemImage: "house.fill") }
                .tag(0)
            LpspSnapchatExploreTabScreen()
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
                .tag(1)
            LpspSnapchatProfileTabScreen()
                .tabItem { Label("Profil", systemImage: "person.circle") }
                .tag(2)
        }
        .tint(LpspSnapchatTokens.snapYellow)
        
    }
}


private struct LpspSnapchatGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspSnapchatTokens.snapYellow.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspSnapchatTokens.snapYellow))
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


private struct LpspSnapchatDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspSnapchatDemoStories {
    static let items: [LpspSnapchatDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspSnapchatFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspSnapchatDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    Circle().strokeBorder(LpspSnapchatTokens.snapYellow, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill(LpspSnapchatTokens.snapYellow.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(0..<3, id: \.self) { i in
                        LpspSnapchatGenericFeedCard(index: i, accent: LpspSnapchatTokens.snapYellow)
                    }

                }
            }
            .background(LpspSnapchatTokens.snapCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspSnapchatExploreTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LpspSnapchatTokens.snapYellow.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .navigationTitle("Explorer")
        }
    }
}

private struct LpspSnapchatReelsTabScreen: View {
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

private struct LpspSnapchatProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspSnapchatTokens.snapYellow.gradient).frame(width: 88, height: 88)
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

private struct LpspSnapchatCommunitiesTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["r/swiftui", "r/paris", "r/design"], id: \.self) { Label($0, systemImage: "person.3") }
            .navigationTitle("Communities")
        }
    }
}

private struct LpspSnapchatCreateTabScreen: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "plus.app.fill").font(.system(size: 56)).foregroundStyle(LpspSnapchatTokens.snapYellow)
            Text("Nouvelle publication").font(.title2.bold())
            Text("Photo, reel ou story").foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LpspSnapchatTokens.snapCanvas.ignoresSafeArea())
    }
}

private struct LpspSnapchatSocialTabScreen: View {
    let title: String
    var body: some View {
        let low = title.lowercased()
        if low.contains("créer") || low.contains("create") { LpspSnapchatCreateTabScreen() }
        else if low.contains("explor") || low.contains("search") { LpspSnapchatExploreTabScreen() }
        else if low.contains("reel") { LpspSnapchatReelsTabScreen() }
        else if low.contains("profil") || low.contains("profile") { LpspSnapchatProfileTabScreen() }
        else { LpspSnapchatFeedTabScreen() }
    }
}

private struct LpspSnapchatGenericFeedCard: View {
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


private struct LpspSnapchatSpectrHomeTabScreen: View {
    var body: some View {
        ZStack {
        Color.black.ignoresSafeArea()
        VStack {
                    Text("Search").font(.system(size: 14, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Sunset Beach").font(.system(size: 11.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("🌸").font(.system(size: 18.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("🦋").font(.system(size: 18.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("✨").font(.system(size: 18.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("🔥").font(.system(size: 18.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("🎭").font(.system(size: 18.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        }
        }
        .background(Color(red: 0.000, green: 0.000, blue: 0.000).ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}



import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/snapchat
// Meliwat/awesome-ios-design-md/social/snapchat/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeSnapchatView: View {
    var body: some View {
        LpspSnapchatShowroomRoot(store: LpspSnapchatStore())
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

fileprivate struct LpspSnapchatSnapChatRow<Bitmoji: View>: View {
    enum LpspSnapchatSnapType { case photo, video, chat, audio, none }
    enum LpspSnapchatDirection { case incoming, outgoing }

    let name: String
    let bitmoji: Bitmoji
    let status: String           // "Received · 2m ago"
    let timestamp: String        // "2m"
    let snapType: LpspSnapchatSnapType
    let direction: LpspSnapchatDirection
    let isUnread: Bool
    let streakDays: Int?

    var body: some View {
        HStack(spacing: 12) {
            bitmoji
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

fileprivate struct LpspSnapchatSnapStoryThumb<Bitmoji: View, Preview: View>: View {
    enum ReadState { case unread, read, live }

    let creatorName: String
    let bitmoji: Bitmoji
    let preview: Preview
    let state: ReadState
    @State private var ringOpacity: Double = 1.0

    var body: some View {
        ZStack(alignment: .topLeading) {
            preview
                .frame(width: 120, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(ringColor, lineWidth: 3)
                        .opacity(ringOpacity)
                )

            bitmoji
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
    @Binding var selected: LpspSnapchatShowroomTab

    private let tabs: [LpspSnapchatShowroomTab] = [.map, .chat, .camera, .stories, .spotlight]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                Button {
                    selected = tab
                } label: {
                    if tab == .camera {
                        Circle()
                            .fill(selected == tab ? LpspSnapchatTokens.snapYellow : LpspSnapchatTokens.snapTextTertiary)
                            .frame(width: 8, height: 8)
                            .frame(maxWidth: .infinity, minHeight: 40)
                    } else {
                        Circle()
                            .fill(selected == tab ? Color.white : LpspSnapchatTokens.snapTextTertiary)
                            .frame(width: 6, height: 6)
                            .frame(maxWidth: .infinity, minHeight: 40)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 8)
        .background(.black.opacity(0.35))
    }
}

// MARK: - Showroom data & store

private enum LpspSnapchatShowroomTab: String, CaseIterable, Identifiable {
    case map, chat, camera, stories, spotlight

    var id: String { rawValue }

    var navIcon: String {
        switch self {
        case .map: "map.fill"
        case .chat: "bubble.left.fill"
        case .camera: "camera.fill"
        case .stories: "play.rectangle.fill"
        case .spotlight: "diamond.fill"
        }
    }
}

private struct LpspSnapchatConversation: Identifiable, Equatable {
    let id: String
    let name: String
    let emoji: String
    let status: String
    let timestamp: String
    let snapType: LpspSnapchatSnapChatRow<LpspSnapchatBitmoji>.LpspSnapchatSnapType
    let direction: LpspSnapchatSnapChatRow<LpspSnapchatBitmoji>.LpspSnapchatDirection
    let isUnread: Bool
    let streakDays: Int?
}

private struct LpspSnapchatStoryItem: Identifiable, Equatable {
    let id: String
    let creatorName: String
    let emoji: String
    let state: LpspSnapchatSnapStoryThumb<LpspSnapchatBitmoji, LpspSnapchatStoryPreview>.ReadState
}

private enum LpspSnapchatShowroomData {
    static let lenses = ["🌸", "🦋", "✨", "🔥", "🎭"]
    static let lensNames = ["Cherry Bloom", "Butterfly", "Sunset Beach", "Fire Lens", "Theater"]

    static let conversations: [LpspSnapchatConversation] = [
        .init(id: "jamie", name: "Jamie Cole", emoji: "🦊", status: "Received · 2m ago", timestamp: "2m", snapType: .photo, direction: .incoming, isUnread: true, streakDays: 142),
        .init(id: "kira", name: "Kira Tan", emoji: "🐯", status: "New Chat · 8m ago", timestamp: "8m", snapType: .chat, direction: .incoming, isUnread: true, streakDays: nil),
        .init(id: "alex", name: "Alex Mercer", emoji: "🐻", status: "Opened · 1h ago", timestamp: "1h", snapType: .video, direction: .outgoing, isUnread: false, streakDays: 28),
    ]

    static let stories: [LpspSnapchatStoryItem] = [
        .init(id: "jamie", creatorName: "Jamie", emoji: "🦊", state: .unread),
        .init(id: "kira", creatorName: "Kira", emoji: "🐯", state: .unread),
        .init(id: "team", creatorName: "Team Snap", emoji: "👻", state: .read),
    ]

    static let mapFriends = [
        ("Jamie", 0.28, 0.42),
        ("Kira", 0.62, 0.55),
        ("Alex", 0.44, 0.68),
    ]
}

@MainActor
fileprivate final class LpspSnapchatStore: ObservableObject {
    @Published var selectedTab: LpspSnapchatShowroomTab = .camera
    @Published var selectedLensIndex = 2
    @Published var isRecording = false
    @Published var recordProgress = 0.0
    @Published var flashOn = false
    @Published var frontCamera = true
    @Published var snapCount = 0
    @Published var conversations = LpspSnapchatShowroomData.conversations
    @Published var stories = LpspSnapchatShowroomData.stories
    @Published var selectedChatId: String?
    @Published var showChatSheet = false
    @Published var chatDraft = ""
    @Published var chatMessages: [String: [String]] = [
        "kira": ["Want to try the Sunset Beach lens?", "Meet at the pier?"],
    ]

    var activeLensName: String {
        LpspSnapchatShowroomData.lensNames[selectedLensIndex]
    }

    func selectLens(_ index: Int) {
        selectedLensIndex = index
    }

    func toggleFlash() {
        flashOn.toggle()
    }

    func flipCamera() {
        frontCamera.toggle()
    }

    func capturePhoto() {
        snapCount += 1
    }

    func startRecording() {
        isRecording = true
        recordProgress = 0.15
    }

    func stopRecording() {
        isRecording = false
        recordProgress = 0
        snapCount += 1
    }

    func openChat(_ id: String) {
        selectedChatId = id
        showChatSheet = true
        conversations = conversations.map { chat in
            guard chat.id == id else { return chat }
            return LpspSnapchatConversation(
                id: chat.id,
                name: chat.name,
                emoji: chat.emoji,
                status: "Opened · just now",
                timestamp: "now",
                snapType: chat.snapType,
                direction: chat.direction,
                isUnread: false,
                streakDays: chat.streakDays
            )
        }
    }

    func sendChatMessage() {
        let text = chatDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, let id = selectedChatId else { return }
        var thread = chatMessages[id] ?? []
        thread.append(text)
        chatMessages[id] = thread
        chatDraft = ""
    }

    func markStoryRead(_ id: String) {
        stories = stories.map { story in
            guard story.id == id else { return story }
            return LpspSnapchatStoryItem(
                id: story.id,
                creatorName: story.creatorName,
                emoji: story.emoji,
                state: .read
            )
        }
    }
}

// MARK: - Écrans showroom

private struct LpspSnapchatShowroomRoot: View {
    @ObservedObject var store: LpspSnapchatStore

    var body: some View {
        ZStack {
            LpspSnapchatTokens.snapCanvas.ignoresSafeArea()

            switch store.selectedTab {
            case .map:
                LpspSnapchatMapTabScreen(store: store)
            case .chat:
                LpspSnapchatChatTabScreen(store: store)
            case .camera:
                LpspSnapchatCameraTabScreen(store: store)
            case .stories:
                LpspSnapchatStoriesTabScreen(store: store)
            case .spotlight:
                LpspSnapchatSpotlightTabScreen(store: store)
            }
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $store.showChatSheet) {
            if let id = store.selectedChatId,
               let chat = store.conversations.first(where: { $0.id == id }) {
                LpspSnapchatChatSheet(store: store, chat: chat)
            }
        }
    }
}

private struct LpspSnapchatCameraTabScreen: View {
    @ObservedObject var store: LpspSnapchatStore

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.15, green: 0.08, blue: 0.22),
                    Color(red: 0.05, green: 0.12, blue: 0.18),
                    Color.black,
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Circle()
                        .fill(LpspSnapchatTokens.snapYellow)
                        .frame(width: 36, height: 36)
                        .overlay {
                            Text("👻")
                                .font(.system(size: 18))
                        }

                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Search")
                            .font(LpspSnapchatFonts.snapHudLabel)
                    }
                    .foregroundStyle(LpspSnapchatTokens.snapTextPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(LpspSnapchatTokens.snapSurface2.opacity(0.85)))

                    Spacer()

                    Button { store.toggleFlash() } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                Spacer()

                Text(store.activeLensName)
                    .font(LpspSnapchatFonts.snapLensLabel.weight(.semibold))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.5), radius: 4, y: 2)

                LpspSnapchatLensCarousel(
                    lenses: LpspSnapchatShowroomData.lenses,
                    selected: Binding(
                        get: { store.selectedLensIndex },
                        set: { store.selectLens($0) }
                    )
                )
                .padding(.vertical, 12)

                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspSnapchatTokens.snapSurface2)
                        .frame(width: 36, height: 48)
                        .overlay {
                            Image(systemName: "photo.stack.fill")
                                .foregroundStyle(.white)
                        }

                    Spacer()

                    LpspSnapchatSnapCaptureButton(
                        isRecording: $store.isRecording,
                        recordProgress: $store.recordProgress,
                        onPhoto: { store.capturePhoto() },
                        onVideoStart: { store.startRecording() },
                        onVideoStop: { store.stopRecording() },
                        onFlip: { store.flipCamera() }
                    )

                    Spacer()

                    Button { store.flipCamera() } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                    }
                }
                .padding(.horizontal, 32)

                LpspSnapchatSnapNavIndicator(selected: $store.selectedTab)
            }
        }
    }
}

private struct LpspSnapchatChatTabScreen: View {
    @ObservedObject var store: LpspSnapchatStore

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Chat")
                    .font(LpspSnapchatFonts.snapScreenTitle.weight(.semibold))
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "person.badge.plus")
                    .foregroundStyle(LpspSnapchatTokens.snapYellow)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(store.conversations) { chat in
                        Button {
                            store.openChat(chat.id)
                        } label: {
                            LpspSnapchatSnapChatRow(
                                name: chat.name,
                                bitmoji: LpspSnapchatBitmoji(emoji: chat.emoji),
                                status: chat.status,
                                timestamp: chat.timestamp,
                                snapType: chat.snapType,
                                direction: chat.direction,
                                isUnread: chat.isUnread,
                                streakDays: chat.streakDays
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            LpspSnapchatSnapNavIndicator(selected: $store.selectedTab)
        }
        .background(LpspSnapchatTokens.snapCanvas.ignoresSafeArea())
    }
}

private struct LpspSnapchatStoriesTabScreen: View {
    @ObservedObject var store: LpspSnapchatStore

    var body: some View {
        VStack(spacing: 0) {
            Text("Stories")
                .font(LpspSnapchatFonts.snapScreenTitle.weight(.semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(store.stories) { story in
                        Button {
                            store.markStoryRead(story.id)
                        } label: {
                            LpspSnapchatSnapStoryThumb(
                                creatorName: story.creatorName,
                                bitmoji: LpspSnapchatBitmoji(emoji: story.emoji),
                                preview: LpspSnapchatStoryPreview(emoji: story.emoji),
                                state: story.state
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }

            Spacer()

            LpspSnapchatSnapNavIndicator(selected: $store.selectedTab)
        }
        .background(LpspSnapchatTokens.snapCanvas.ignoresSafeArea())
    }
}

private struct LpspSnapchatMapTabScreen: View {
    @ObservedObject var store: LpspSnapchatStore

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.08, green: 0.16, blue: 0.28), Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            GeometryReader { geo in
                ForEach(LpspSnapchatShowroomData.mapFriends, id: \.0) { name, x, y in
                    VStack(spacing: 4) {
                        Circle()
                            .fill(LpspSnapchatTokens.snapYellow)
                            .frame(width: 44, height: 44)
                            .overlay { Text("👻").font(.system(size: 20)) }
                        Text(name)
                            .font(LpspSnapchatFonts.snapStoryName)
                            .foregroundStyle(.white)
                    }
                    .position(x: geo.size.width * x, y: geo.size.height * y)
                }
            }

            VStack {
                Spacer()
                LpspSnapchatSnapNavIndicator(selected: $store.selectedTab)
            }
        }
    }
}

private struct LpspSnapchatSpotlightTabScreen: View {
    @ObservedObject var store: LpspSnapchatStore

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "play.rectangle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(LpspSnapchatTokens.snapYellow)
                Text("Spotlight")
                    .font(LpspSnapchatFonts.snapScreenTitle.weight(.semibold))
                    .foregroundStyle(.white)
                Text("Trending snaps from creators")
                    .font(LpspSnapchatFonts.snapSpotlightCap)
                    .foregroundStyle(LpspSnapchatTokens.snapTextSecondary)
                Spacer()
                LpspSnapchatSnapNavIndicator(selected: $store.selectedTab)
            }
        }
    }
}

private struct LpspSnapchatChatSheet: View {
    @ObservedObject var store: LpspSnapchatStore
    let chat: LpspSnapchatConversation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(store.chatMessages[chat.id] ?? [], id: \.self) { message in
                            LpspSnapchatSnapChatBubble(text: message, sender: .them)
                        }
                    }
                    .padding(.vertical, 16)
                }

                HStack(spacing: 12) {
                    TextField("Send a chat", text: $store.chatDraft)
                        .font(LpspSnapchatFonts.snapChatMessage)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 20).fill(LpspSnapchatTokens.snapSurface2))

                    Button {
                        store.sendChatMessage()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundStyle(LpspSnapchatTokens.snapYellow)
                    }
                }
                .padding(16)
            }
            .background(LpspSnapchatTokens.snapCanvas.ignoresSafeArea())
            .navigationTitle(chat.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        store.showChatSheet = false
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
        .preferredColorScheme(.dark)
    }
}

private struct LpspSnapchatBitmoji: View {
    let emoji: String

    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [LpspSnapchatTokens.snapSurface2, LpspSnapchatTokens.snapSurface1],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                Text(emoji)
                    .font(.system(size: 22))
            }
    }
}

private struct LpspSnapchatStoryPreview: View {
    let emoji: String

    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.25, green: 0.12, blue: 0.45),
                Color(red: 0.08, green: 0.18, blue: 0.32),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay {
            Text(emoji)
                .font(.system(size: 48))
        }
    }
}


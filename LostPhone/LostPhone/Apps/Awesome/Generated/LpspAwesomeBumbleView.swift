import SwiftUI
import UIKit

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/bumble
// Meliwat/awesome-ios-design-md/dating/bumble/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeBumbleView: View {
    var body: some View {
        LpspBumbleShowroomRoot(store: LpspBumbleStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspBumbleTokens {
    // MARK: - Brand
    static let bumbleYellow      = Color(red: 1.000, green: 0.776, blue: 0.161) // #FFC629
    static let bumbleHoneyDeep   = Color(red: 0.961, green: 0.714, blue: 0.086) // #F5B616 pressed
    static let bumbleYellowLight = Color(red: 1.000, green: 0.914, blue: 0.631) // #FFE9A1 soft chip

    // MARK: - Mode colors (Date/BFF/Bizz)
    static let bumbleBFFTeal     = Color(red: 0.067, green: 0.667, blue: 0.659) // #11AAA8
    static let bumbleBizzOrange  = Color(red: 1.000, green: 0.502, blue: 0.000) // #FF8000

    // MARK: - Canvas & Surfaces
    static let bumbleCanvas      = Color(red: 1.000, green: 1.000, blue: 1.000) // #FFFFFF
    static let bumbleBFFCream    = Color(red: 1.000, green: 0.988, blue: 0.949) // #FFFCF2
    static let bumbleSurface1    = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let bumbleSurface2    = Color(red: 0.929, green: 0.929, blue: 0.929) // #EDEDED
    static let bumbleDivider     = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5

    // MARK: - Text
    static let bumbleBlack       = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F primary
    static let bumbleSlate       = Color(red: 0.353, green: 0.353, blue: 0.353) // #5A5A5A secondary
    static let bumbleMist        = Color(red: 0.612, green: 0.612, blue: 0.612) // #9C9C9C tertiary

    // MARK: - Semantic
    static let bumbleMatchPink   = Color(red: 0.914, green: 0.294, blue: 0.482) // #E94B7B
    static let bumbleVerified    = Color(red: 0.000, green: 0.400, blue: 1.000) // #0066FF
    static let bumbleError       = Color(red: 0.843, green: 0.149, blue: 0.220) // #D72638
    static let bumbleSuccess     = Color(red: 0.000, green: 0.659, blue: 0.420) // #00A86B
    static let bumbleWarning     = Color(red: 1.000, green: 0.584, blue: 0.000) // #FF9500

    // MARK: - Dark mode
    static let bumbleDarkCanvas  = Color(red: 0.059, green: 0.059, blue: 0.059) // #0F0F0F
    static let bumbleDarkSurface = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let bumbleDarkSurface2 = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
    static let bumbleDarkDivider = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F
    static let bumbleDarkText    = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
}



// Fallback when Brando isn't bundled — SF Pro is the warmest system substitute


fileprivate struct LpspBumbleBumblePrimaryButton: View {
    let label: String
    var hasGlow: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspBumbleFonts.bumbleButton)
                .foregroundStyle(Color.black) // Pure black on yellow — WCAG AA requires it
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Capsule().fill(LpspBumbleTokens.bumbleYellow))
                .shadow(
                    color: hasGlow ? LpspBumbleTokens.bumbleYellow.opacity(0.4) : .clear,
                    radius: 24, y: 8
                )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .medium), trigger: UUID())
    }
}

fileprivate struct LpspBumbleSwipeActionRow: View {
    var onRewind: () -> Void
    var onPass:   () -> Void
    var onLike:   () -> Void
    var onSuper:  () -> Void
    var onCompliment: () -> Void

    var body: some View {
        HStack(spacing: 24) {
            // Rewind — small
            LpspBumbleActionCircle(diameter: 48, fill: LpspBumbleTokens.bumbleSurface1, stroke: nil) {
                Image(systemName: "arrow.uturn.backward").font(.system(size: 20)).foregroundStyle(LpspBumbleTokens.bumbleMist)
            } action: { onRewind() }

            // X Pass — medium
            LpspBumbleActionCircle(diameter: 56, fill: LpspBumbleTokens.bumbleCanvas, stroke: LpspBumbleTokens.bumbleBlack) {
                Image(systemName: "xmark").font(.system(size: 22, weight: .heavy)).foregroundStyle(LpspBumbleTokens.bumbleBlack)
            } action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                onPass()
            }

            // Heart Yes — large with yellow glow
            ZStack {
                Circle()
                    .fill(LpspBumbleTokens.bumbleYellow)
                    .frame(width: 64, height: 64)
                    .shadow(color: LpspBumbleTokens.bumbleYellow.opacity(0.5), radius: 16, y: 6)
                Image(systemName: "heart.fill")
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundStyle(Color.black)
            }
            .onTapGesture {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                onLike()
            }

            // Star SuperSwipe — medium yellow
            LpspBumbleActionCircle(diameter: 56, fill: LpspBumbleTokens.bumbleYellow, stroke: nil) {
                Image(systemName: "star.fill").font(.system(size: 22, weight: .heavy)).foregroundStyle(Color.black)
            } action: {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                onSuper()
            }

            // Bee Compliment — small
            LpspBumbleActionCircle(diameter: 56, fill: LpspBumbleTokens.bumbleCanvas, stroke: LpspBumbleTokens.bumbleYellow) {
                Image(systemName: "ant.fill") // bee placeholder
                    .font(.system(size: 22))
                    .foregroundStyle(LpspBumbleTokens.bumbleYellow)
            } action: { onCompliment() }
        }
    }
}

private enum LpspBumbleFonts {
    static let bumbleMatchHero    = Font.system(size: 44, weight: .regular)
    static let bumbleDisplay      = Font.system(size: 32, weight: .regular)
    static let bumbleScreenTitle  = Font.system(size: 24, weight: .regular)
    static let bumbleCardName     = Font.system(size: 28, weight: .regular)
    static let bumbleSection      = Font.system(size: 18, weight: .regular)
    static let bumbleBody         = Font.system(size: 16, weight: .regular)
    static let bumbleBodyBold     = Font.system(size: 16, weight: .regular)
    static let bumbleBodySmall    = Font.system(size: 14, weight: .regular)
    static let bumbleButton       = Font.system(size: 16, weight: .regular)
    static let bumbleButtonLarge  = Font.system(size: 18, weight: .regular)
    static let bumbleTab          = Font.system(size: 10, weight: .regular)
    static let bumbleChip         = Font.system(size: 13, weight: .regular)
    static let bumbleMeta         = Font.system(size: 13, weight: .regular)
    static let bumbleCounter      = Font.system(size: 11, weight: .regular)
    static let bumbleCompliment   = Font.system(size: 22, weight: .regular)
    static func bumble(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private struct LpspBumbleActionCircle<Content: View>: View {
    let diameter: CGFloat
    let fill: Color
    let stroke: Color?
    @ViewBuilder var content: Content
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(fill)
                    .overlay(stroke.map { Circle().strokeBorder($0, lineWidth: 1.5) })
                content
            }
            .frame(width: diameter, height: diameter)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspBumbleSwipeCard: View {
    let photos: [Image]
    let name: String
    let age: Int
    let bio: String
    let isVerified: Bool
    @State private var currentPhoto = 0

    var body: some View {
        ZStack {
            // Photo
            photos[currentPhoto]
                .resizable()
                .aspectRatio(3/4, contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            // Photo progress bar (4 segments)
            VStack {
                HStack(spacing: 4) {
                    ForEach(0..<photos.count, id: \.self) { idx in
                        Capsule()
                            .fill(idx == currentPhoto ? Color.white : Color.white.opacity(0.4))
                            .frame(height: 3)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
                Spacer()
            }

            // Bottom gradient overlay
            VStack {
                Spacer()
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .top, endPoint: .bottom
                )
                .frame(height: 200)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Name+age + bio
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("\(name), \(age)")
                        .font(LpspBumbleFonts.bumbleCardName)
                        .foregroundStyle(.white)
                    if isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspBumbleTokens.bumbleVerified)
                    }
                }
                Text(bio).font(LpspBumbleFonts.bumbleBody).foregroundStyle(.white).lineLimit(1)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(3/4, contentMode: .fit)
        .shadow(color: .black.opacity(0.12), radius: 16, y: 4)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in /* track drag */ }
                .onEnded { value in
                    if abs(value.translation.width) > 100 {
                        // commit swipe
                    }
                }
        )
    }
}

fileprivate struct LpspBumbleCountdownChip: View {
    let remaining: TimeInterval        // seconds
    @State private var pulse = false

    var formatted: String {
        let h = Int(remaining) / 3600
        let m = (Int(remaining) % 3600) / 60
        if remaining <= 0 { return "Time's up — extend?" }
        return "Your turn: \(h)h \(m)m"
    }

    var isExpired: Bool { remaining <= 0 }

    var body: some View {
        Text(formatted)
            .font(LpspBumbleFonts.bumbleMeta)
            .fontWeight(.bold)
            .foregroundStyle(Color.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .frame(height: 32)
            .background(
                Capsule()
                    .fill(isExpired ? LpspBumbleTokens.bumbleError : LpspBumbleTokens.bumbleYellow)
                    .overlay(Capsule().stroke(LpspBumbleTokens.bumbleHoneyDeep, lineWidth: 1))
            )
            .opacity(pulse ? 1.0 : 0.95)
            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulse)
            .onAppear { pulse = true }
    }
}

fileprivate struct LpspBumbleMatchCelebration: View {
    let myAvatar: Image
    let theirAvatar: Image
    let theirName: String
    var onSendMessage: () -> Void
    var onKeepSwiping: () -> Void

    @State private var heartScale: CGFloat = 0.2

    var body: some View {
        ZStack {
            LpspBumbleTokens.bumbleYellow.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                ZStack {
                    HStack(spacing: 32) {
                        LpspBumbleHexAvatar(image: myAvatar)
                        LpspBumbleHexAvatar(image: theirAvatar)
                    }
                    Image(systemName: "heart.fill")
                        .font(.system(size: 48, weight: .heavy))
                        .foregroundStyle(LpspBumbleTokens.bumbleMatchPink)
                        .scaleEffect(heartScale)
                        .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                }

                VStack(spacing: 12) {
                    Text("It's a Match!")
                        .font(LpspBumbleFonts.bumbleMatchHero)
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                        .tracking(-0.8)
                    Text("You and \(theirName) want to chat")
                        .font(LpspBumbleFonts.bumbleBody)
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                }

                Text("She has 24 hours to make the first move")
                    .font(LpspBumbleFonts.bumbleMeta)
                    .foregroundStyle(LpspBumbleTokens.bumbleBlack.opacity(0.8))

                Spacer()

                VStack(spacing: 16) {
                    Button(action: onSendMessage) {
                        Text("Send a Message")
                            .font(LpspBumbleFonts.bumbleButtonLarge)
                            .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Capsule().fill(Color.white))
                    }
                    .buttonStyle(.plain)

                    Button("Keep Swiping", action: onKeepSwiping)
                        .font(LpspBumbleFonts.bumbleButton)
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.55)) {
                heartScale = 1.0
            }
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
}

fileprivate struct LpspBumbleHexAvatar: View {
    let image: Image
    var size: CGFloat = 120
    var stroke: Color = .white

    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(LpspBumbleHexagon())
            .overlay(LpspBumbleHexagon().stroke(stroke, lineWidth: 4))
    }
}

fileprivate struct LpspBumbleHexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        for i in 0..<6 {
            let angle = CGFloat.pi / 3 * CGFloat(i) - CGFloat.pi / 2
            let point = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
            if i == 0 { path.move(to: point) } else { path.addLine(to: point) }
        }
        path.closeSubpath()
        return path
    }
}

fileprivate struct LpspBumbleBumbleChatInput: View {
    @Binding var text: String
    var onSend: () -> Void

    var canSend: Bool { !text.isEmpty }

    var body: some View {
        HStack(spacing: 10) {
            TextField("Type your message…", text: $text, axis: .vertical)
                .font(LpspBumbleFonts.bumbleBody)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .background(Capsule().fill(LpspBumbleTokens.bumbleSurface1))
                .lineLimit(1...4)

            Button {
                onSend()
            } label: {
                Image(systemName: "arrow.up")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(canSend ? Color.black : LpspBumbleTokens.bumbleMist)
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(canSend ? LpspBumbleTokens.bumbleYellow : LpspBumbleTokens.bumbleSurface1))
            }
            .disabled(!canSend)
            .sensoryFeedback(.impact(weight: .medium), trigger: canSend == false)
        }
        .padding(.horizontal, 16)
    }
}



// MARK: - Showroom data & store

private enum LpspBumbleShowroomTab: String, CaseIterable, Identifiable {
    case people, hives, matches, chats, profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .people: "People"
        case .hives: "Hives"
        case .matches: "Matches"
        case .chats: "Chats"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .people: "person.2.fill"
        case .hives: "hexagon.fill"
        case .matches: "heart.fill"
        case .chats: "bubble.left.fill"
        case .profile: "person.crop.circle.fill"
        }
    }
}

private struct LpspBumbleProfile: Identifiable, Equatable {
    let id: String
    let name: String
    let age: Int
    let bio: String
    let isVerified: Bool
    let gradient: [Color]
    let photoCount: Int
    let triggersMatch: Bool
}

private enum LpspBumbleShowroomData {
    static let sigrun = LpspBumbleProfile(
        id: "sigrun",
        name: "Sigrún",
        age: 28,
        bio: "2 mi away · Engineer at a coffee co-op",
        isVerified: true,
        gradient: [
            Color(red: 0.62, green: 0.42, blue: 0.48),
            Color(red: 0.32, green: 0.22, blue: 0.38),
        ],
        photoCount: 4,
        triggersMatch: true
    )

    static let deck: [LpspBumbleProfile] = [
        sigrun,
        LpspBumbleProfile(
            id: "mara",
            name: "Mara",
            age: 27,
            bio: "4 mi away · Ceramic artist",
            isVerified: false,
            gradient: [
                Color(red: 0.45, green: 0.58, blue: 0.72),
                Color(red: 0.22, green: 0.35, blue: 0.52),
            ],
            photoCount: 3,
            triggersMatch: false
        ),
        LpspBumbleProfile(
            id: "kellen",
            name: "Kellen",
            age: 30,
            bio: "1 mi away · Trail runner & baker",
            isVerified: true,
            gradient: [
                Color(red: 0.78, green: 0.55, blue: 0.35),
                Color(red: 0.48, green: 0.32, blue: 0.22),
            ],
            photoCount: 4,
            triggersMatch: false
        ),
    ]

    static let hives = ["Weekend hikers", "Coffee lovers", "Design book club"]

    static let matchList = [
        ("Sigrún", "23h left to message"),
        ("Jordan", "Matched yesterday"),
    ]

    static let chats = [
        ("Sigrún", "Want to grab coffee Saturday?", "2h"),
        ("Mara", "Loved your hive post", "1d"),
    ]
}

@MainActor
fileprivate final class LpspBumbleStore: ObservableObject {
    @Published var selectedTab: LpspBumbleShowroomTab = .people
    @Published var deck: [LpspBumbleProfile] = LpspBumbleShowroomData.deck
    @Published var history: [LpspBumbleProfile] = []
    @Published var cardOffset = CGSize.zero
    @Published var currentPhotoIndex = 0
    @Published var showMatch = false
    @Published var matchedProfile: LpspBumbleProfile?
    @Published var countdownRemaining: TimeInterval = 23 * 3600 + 14 * 60
    @Published var showComplimentSheet = false
    @Published var complimentText = ""
    @Published var chatText = ""

    var currentProfile: LpspBumbleProfile? { deck.first }

    func advanceDeck(removing current: LpspBumbleProfile) {
        history.append(current)
        deck = Array(deck.dropFirst())
        cardOffset = .zero
        currentPhotoIndex = 0
    }

    func rewind() {
        guard let last = history.popLast() else { return }
        deck.insert(last, at: 0)
        cardOffset = .zero
        currentPhotoIndex = 0
    }

    func pass() {
        guard let current = currentProfile else { return }
        animateSwipe(x: -500) { self.advanceDeck(removing: current) }
    }

    func like() {
        guard let current = currentProfile else { return }
        animateSwipe(x: 500) {
            if current.triggersMatch {
                self.matchedProfile = current
                self.showMatch = true
            }
            self.advanceDeck(removing: current)
        }
    }

    func superSwipe() {
        guard let current = currentProfile else { return }
        animateSwipe(x: 0, y: -600) { self.advanceDeck(removing: current) }
    }

    func openCompliment() {
        showComplimentSheet = true
    }

    func sendCompliment() {
        complimentText = ""
        showComplimentSheet = false
    }

    func dismissMatch() {
        showMatch = false
        matchedProfile = nil
    }

    func updateDrag(_ translation: CGSize) {
        cardOffset = translation
    }

    func endDrag(_ translation: CGSize) {
        let threshold: CGFloat = 120
        if translation.width > threshold {
            like()
        } else if translation.width < -threshold {
            pass()
        } else {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                cardOffset = .zero
            }
        }
    }

    func nextPhoto() {
        guard let profile = currentProfile else { return }
        currentPhotoIndex = min(currentPhotoIndex + 1, profile.photoCount - 1)
    }

    func previousPhoto() {
        currentPhotoIndex = max(currentPhotoIndex - 1, 0)
    }

    private func animateSwipe(x: CGFloat, y: CGFloat = 0, completion: @escaping () -> Void) {
        withAnimation(.easeOut(duration: 0.35)) {
            cardOffset = CGSize(width: x, height: y)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: completion)
    }
}

// MARK: - Écrans showroom

private struct LpspBumbleShowroomRoot: View {
    @ObservedObject var store: LpspBumbleStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .people:
                    LpspBumblePeopleTabScreen(store: store)
                case .hives:
                    LpspBumbleHivesTabScreen()
                case .matches:
                    LpspBumbleMatchesTabScreen()
                case .chats:
                    LpspBumbleChatsTabScreen(store: store)
                case .profile:
                    LpspBumbleShowroomProfileTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspBumbleLabeledTabBar(store: store)
        }
        .background(LpspBumbleTokens.bumbleCanvas.ignoresSafeArea())
        .preferredColorScheme(.light)
        .fullScreenCover(isPresented: $store.showMatch) {
            if let match = store.matchedProfile {
                LpspBumbleShowroomMatchScreen(name: match.name, onDismiss: { store.dismissMatch() })
            }
        }
        .sheet(isPresented: $store.showComplimentSheet) {
            LpspBumbleComplimentSheet(store: store)
        }
    }
}

private struct LpspBumbleLabeledTabBar: View {
    @ObservedObject var store: LpspBumbleStore

    var body: some View {
        HStack {
            ForEach(LpspBumbleShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspBumbleFonts.bumbleTab.weight(store.selectedTab == tab ? .semibold : .regular))
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspBumbleTokens.bumbleBlack
                            : LpspBumbleTokens.bumbleMist
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspBumbleTokens.bumbleCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspBumbleTokens.bumbleDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspBumblePeopleTabScreen: View {
    @ObservedObject var store: LpspBumbleStore

    var body: some View {
        VStack(spacing: 0) {
            LpspBumbleSpectrHeader()

            if let profile = store.currentProfile {
                VStack(spacing: 12) {
                    LpspBumbleShowroomSwipeCard(
                        profile: profile,
                        photoIndex: store.currentPhotoIndex,
                        offset: store.cardOffset,
                        onDragChanged: { store.updateDrag($0) },
                        onDragEnded: { store.endDrag($0) },
                        onTapLeft: { store.previousPhoto() },
                        onTapRight: { store.nextPhoto() }
                    )
                    .padding(.horizontal, 12)

                    LpspBumbleSwipeActionRow(
                        onRewind: { store.rewind() },
                        onPass: { store.pass() },
                        onLike: { store.like() },
                        onSuper: { store.superSwipe() },
                        onCompliment: { store.openCompliment() }
                    )

                    LpspBumbleCountdownChip(remaining: store.countdownRemaining)
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 8)
            } else {
                VStack(spacing: 16) {
                    Text("No more people nearby")
                        .font(LpspBumbleFonts.bumbleBody)
                        .foregroundStyle(LpspBumbleTokens.bumbleSlate)
                    LpspBumbleBumblePrimaryButton(label: "Rewind", action: { store.rewind() })
                        .padding(.horizontal, 32)
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}

private struct LpspBumbleSpectrHeader: View {
    var body: some View {
        HStack {
            Text("People")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(LpspBumbleTokens.bumbleBlack)

            Spacer()

            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 22))
                .foregroundStyle(LpspBumbleTokens.bumbleBlack)
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
    }
}

private struct LpspBumbleShowroomSwipeCard: View {
    let profile: LpspBumbleProfile
    let photoIndex: Int
    let offset: CGSize
    let onDragChanged: (CGSize) -> Void
    let onDragEnded: (CGSize) -> Void
    let onTapLeft: () -> Void
    let onTapRight: () -> Void

    private var rotation: Double { Double(offset.width) / 14 }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: profile.gradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack {
                HStack(spacing: 4) {
                    ForEach(0..<profile.photoCount, id: \.self) { index in
                        Capsule()
                            .fill(index == photoIndex ? Color.white : Color.white.opacity(0.4))
                            .frame(height: 3)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
                Spacer()
            }

            VStack {
                Spacer()
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
            }

            VStack(alignment: .leading, spacing: 4) {
                Spacer()

                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)

                    if profile.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspBumbleTokens.bumbleVerified)
                    }
                }

                Text(profile.bio)
                    .font(LpspBumbleFonts.bumbleBody)
                    .foregroundStyle(.white)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)

            HStack {
                Spacer()
                Text("i")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 28, height: 28)
                    .background(Circle().fill(Color.white.opacity(0.25)))
            }
            .padding(16)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 480)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.12), radius: 16, y: 4)
        .rotationEffect(.degrees(rotation))
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { onDragChanged($0.translation) }
                .onEnded { onDragEnded($0.translation) }
        )
        .overlay(
            HStack(spacing: 0) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { onTapLeft() }
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { onTapRight() }
            }
        )
    }
}

private struct LpspBumbleShowroomMatchScreen: View {
    let name: String
    let onDismiss: () -> Void
    @State private var heartScale: CGFloat = 0.2

    var body: some View {
        ZStack {
            LpspBumbleTokens.bumbleYellow.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                ZStack {
                    HStack(spacing: 32) {
                        showroomHexAvatar(colors: [LpspBumbleTokens.bumbleBFFTeal, LpspBumbleTokens.bumbleVerified])
                        showroomHexAvatar(colors: [Color(red: 0.62, green: 0.42, blue: 0.48), Color(red: 0.32, green: 0.22, blue: 0.38)])
                    }

                    Image(systemName: "heart.fill")
                        .font(.system(size: 48, weight: .heavy))
                        .foregroundStyle(LpspBumbleTokens.bumbleMatchPink)
                        .scaleEffect(heartScale)
                }

                VStack(spacing: 12) {
                    Text("It's a Match!")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                    Text("You and \(name) want to chat")
                        .font(LpspBumbleFonts.bumbleBody)
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                }

                Text("She has 24 hours to make the first move")
                    .font(LpspBumbleFonts.bumbleMeta)
                    .foregroundStyle(LpspBumbleTokens.bumbleBlack.opacity(0.8))

                Spacer()

                VStack(spacing: 16) {
                    Button(action: onDismiss) {
                        Text("Send a Message")
                            .font(LpspBumbleFonts.bumbleButtonLarge.weight(.semibold))
                            .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Capsule().fill(Color.white))
                    }
                    .buttonStyle(.plain)

                    Button("Keep Swiping", action: onDismiss)
                        .font(LpspBumbleFonts.bumbleButton.weight(.semibold))
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.55)) {
                heartScale = 1.0
            }
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }

    private func showroomHexAvatar(colors: [Color]) -> some View {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 120, height: 120)
            .clipShape(LpspBumbleHexagon())
            .overlay(LpspBumbleHexagon().stroke(.white, lineWidth: 4))
    }
}

private struct LpspBumbleComplimentSheet: View {
    @ObservedObject var store: LpspBumbleStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Send a Compliment")
                    .font(LpspBumbleFonts.bumbleSection.weight(.semibold))
                    .foregroundStyle(LpspBumbleTokens.bumbleBlack)

                TextField("Say something kind…", text: $store.complimentText, axis: .vertical)
                    .font(LpspBumbleFonts.bumbleCompliment)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LpspBumbleTokens.bumbleSurface1)
                    )
                    .lineLimit(2...5)

                LpspBumbleBumblePrimaryButton(label: "Send Compliment", hasGlow: true) {
                    store.sendCompliment()
                    dismiss()
                }

                Spacer()
            }
            .padding(16)
            .background(LpspBumbleTokens.bumbleCanvas)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

private struct LpspBumbleHivesTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspBumbleShowroomData.hives, id: \.self) { hive in
                HStack(spacing: 12) {
                    Image(systemName: "hexagon.fill")
                        .foregroundStyle(LpspBumbleTokens.bumbleYellow)
                    Text(hive)
                        .font(LpspBumbleFonts.bumbleBody)
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspBumbleTokens.bumbleCanvas)
    }
}

private struct LpspBumbleMatchesTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspBumbleShowroomData.matchList.indices, id: \.self) { index in
                let match = LpspBumbleShowroomData.matchList[index]
                HStack(spacing: 12) {
                    Circle()
                        .fill(LpspBumbleTokens.bumbleYellow)
                        .frame(width: 52, height: 52)
                        .overlay {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                        }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(match.0)
                            .font(LpspBumbleFonts.bumbleBodyBold.weight(.semibold))
                            .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                        Text(match.1)
                            .font(LpspBumbleFonts.bumbleMeta)
                            .foregroundStyle(LpspBumbleTokens.bumbleSlate)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspBumbleTokens.bumbleCanvas)
    }
}

private struct LpspBumbleChatsTabScreen: View {
    @ObservedObject var store: LpspBumbleStore

    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(LpspBumbleShowroomData.chats.indices, id: \.self) { index in
                    let chat = LpspBumbleShowroomData.chats[index]
                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspBumbleTokens.bumbleYellowLight)
                            .frame(width: 48, height: 48)
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(chat.0)
                                    .font(LpspBumbleFonts.bumbleBodyBold.weight(.semibold))
                                    .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                                Spacer()
                                Text(chat.2)
                                    .font(LpspBumbleFonts.bumbleMeta)
                                    .foregroundStyle(LpspBumbleTokens.bumbleMist)
                            }
                            Text(chat.1)
                                .font(LpspBumbleFonts.bumbleBodySmall)
                                .foregroundStyle(LpspBumbleTokens.bumbleSlate)
                                .lineLimit(1)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(LpspBumbleTokens.bumbleCanvas)

            LpspBumbleBumbleChatInput(text: $store.chatText, onSend: { store.chatText = "" })
                .padding(.vertical, 8)
                .background(LpspBumbleTokens.bumbleSurface1)
        }
    }
}

private struct LpspBumbleShowroomProfileTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Circle()
                    .fill(LpspBumbleTokens.bumbleYellow)
                    .frame(width: 96, height: 96)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                    }

                Text("Complete your profile")
                    .font(LpspBumbleFonts.bumbleScreenTitle.weight(.bold))
                    .foregroundStyle(LpspBumbleTokens.bumbleBlack)

                Text("Add photos and prompts so people know the real you")
                    .font(LpspBumbleFonts.bumbleBody)
                    .foregroundStyle(LpspBumbleTokens.bumbleSlate)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                LpspBumbleBumblePrimaryButton(label: "Edit Profile", hasGlow: true, action: {})
                    .padding(.horizontal, 32)
            }
            .padding(.vertical, 32)
        }
    }
}



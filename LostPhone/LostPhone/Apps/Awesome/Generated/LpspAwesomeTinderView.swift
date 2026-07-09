import SwiftUI
import UIKit

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/tinder
// Meliwat/awesome-ios-design-md/dating/tinder/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTinderView: View {
    var body: some View {
        LpspTinderShowroomRoot(store: LpspTinderStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTinderTokens {
    // MARK: - Canvas (Light)
    static let tdrCanvas        = Color.white                                    // #FFFFFF
    static let tdrSurfaceMuted  = Color(red: 0.961, green: 0.961, blue: 0.961)  // #F5F5F5
    static let tdrSurfaceTint   = Color(red: 0.980, green: 0.980, blue: 0.980)  // #FAFAFA
    static let tdrDivider       = Color(red: 0.898, green: 0.898, blue: 0.898)  // #E5E5E5

    // MARK: - Text
    static let tdrTextPrimary   = Color(red: 0.259, green: 0.259, blue: 0.259)  // #424242
    static let tdrTextSecondary = Color(red: 0.451, green: 0.451, blue: 0.451)  // #737373
    static let tdrTextTertiary  = Color(red: 0.620, green: 0.620, blue: 0.620)  // #9E9E9E

    // MARK: - Brand
    static let tdrPink          = Color(red: 0.992, green: 0.149, blue: 0.478)  // #FD267A
    static let tdrOrange        = Color(red: 1.000, green: 0.376, blue: 0.212)  // #FF6036

    // MARK: - Action Colors (the 5 verbs)
    static let tdrNopeRed       = Color(red: 1.000, green: 0.267, blue: 0.345)  // #FF4458
    static let tdrSuperLikeBlue = Color(red: 0.365, green: 0.553, blue: 0.945)  // #5D8DF1
    static let tdrBoostPurple   = Color(red: 0.663, green: 0.322, blue: 1.000)  // #A952FF
    static let tdrRewindGold    = Color(red: 1.000, green: 0.741, blue: 0.231)  // #FFBD3B
    static let tdrLikeStampGreen = Color(red: 0.000, green: 0.839, blue: 0.561) // #00D68F

    // MARK: - Semantic
    static let tdrVerifiedBlue  = Color(red: 0.161, green: 0.690, blue: 1.000)  // #29B0FF
    static let tdrMatchGlow     = Color(red: 0.000, green: 0.839, blue: 0.561)  // #00D68F

    // MARK: - Dark
    static let tdrDarkCanvas    = Color(red: 0.071, green: 0.071, blue: 0.071)  // #121212
    static let tdrDarkSurface1  = Color(red: 0.114, green: 0.114, blue: 0.114)  // #1D1D1D
    static let tdrDarkSurface2  = Color(red: 0.165, green: 0.165, blue: 0.165)  // #2A2A2A
}

// Brand Gradient helper
private enum LpspTinderGradients {
    static let tdrBrand = LinearGradient(
        colors: [LpspTinderTokens.tdrPink, LpspTinderTokens.tdrOrange],
        startPoint: .leading, endPoint: .trailing
    )
}

private enum LpspTinderFonts {
    // Display (match screen only)
    static let tdrMatchHero     = Font.system(size: 48, weight: .regular)

    // Titles
    static let tdrScreenTitle   = Font.system(size: 28, weight: .regular)
    static let tdrProfileName   = Font.system(size: 28, weight: .regular)
    static let tdrProfileAge    = Font.system(size: 24, weight: .regular)
    static let tdrSection       = Font.system(size: 20, weight: .regular)

    // Buttons
    static let tdrButton        = Font.system(size: 16, weight: .regular)
    static let tdrButtonSmall   = Font.system(size: 15, weight: .regular)

    // Body
    static let tdrBody          = Font.system(size: 15, weight: .regular)
    static let tdrCardMeta      = Font.system(size: 14, weight: .regular)
    static let tdrChat          = Font.system(size: 15, weight: .regular)
    static let tdrChatTimestamp = Font.system(size: 11, weight: .regular)

    // Stamps
    static let tdrStamp         = Font.system(size: 36, weight: .regular)
    static let tdrSuperStamp    = Font.system(size: 32, weight: .regular)
}

fileprivate struct LpspTinderTinderSwipeCard: View {
    let name: String
    let age: Int
    let distance: String
    let occupation: String
    let photoURLs: [URL]
    var onSwipe: (LpspTinderSwipeDirection) -> Void = { _ in }

    @State private var offset = CGSize.zero
    @State private var currentPhoto = 0

    var rotation: Double { Double(offset.width) / 12 }  // -15° to 15° range in practice
    var likeOpacity: Double   { min(1.0, max(0, Double(offset.width) / 160)) }
    var nopeOpacity: Double   { min(1.0, max(0, Double(-offset.width) / 160)) }
    var superOpacity: Double  { min(1.0, max(0, Double(-offset.height) / 160)) }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Photo
            AsyncImage(url: photoURLs[currentPhoto]) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                LpspTinderTokens.tdrSurfaceMuted
            }

            // Bottom gradient for legibility
            LinearGradient(
                colors: [.clear, Color.black.opacity(0.7)],
                startPoint: UnitPoint(x: 0.5, y: 0.5),
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(name).font(LpspTinderFonts.tdrProfileName).foregroundStyle(.white)
                    Text(", ").font(LpspTinderFonts.tdrProfileAge).foregroundStyle(.white)
                    Text("\(age)").font(LpspTinderFonts.tdrProfileAge).foregroundStyle(.white)
                }
                Text("\(distance) · \(occupation)")
                    .font(LpspTinderFonts.tdrCardMeta).foregroundStyle(.white.opacity(0.9))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)

            // Photo paginator
            VStack {
                HStack(spacing: 3) {
                    ForEach(0..<photoURLs.count, id: \.self) { idx in
                        RoundedRectangle(cornerRadius: 1.5)
                            .fill(idx == currentPhoto
                                ? Color.white
                                : Color.white.opacity(0.4))
                            .frame(height: 3)
                    }
                }
                .padding(.horizontal, 16).padding(.top, 8)
                Spacer()
            }

            // Stamps
            LpspTinderTinderStamp(text: "LIKE", color: LpspTinderTokens.tdrLikeStampGreen, rotation: -15)
                .opacity(likeOpacity)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(32)
            LpspTinderTinderStamp(text: "NOPE", color: LpspTinderTokens.tdrNopeRed, rotation: 15)
                .opacity(nopeOpacity)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(32)
            LpspTinderTinderStamp(text: "SUPER LIKE", color: LpspTinderTokens.tdrSuperLikeBlue, rotation: 0)
                .opacity(superOpacity)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 64)
        }
        .aspectRatio(3/4, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.15), radius: 16, y: 4)
        .rotationEffect(.degrees(rotation))
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { offset = $0.translation }
                .onEnded { val in
                    let threshold: CGFloat = 150
                    if val.translation.width > threshold {
                        onSwipe(.right); commitSwipe(x: 600, y: 0)
                    } else if val.translation.width < -threshold {
                        onSwipe(.left); commitSwipe(x: -600, y: 0)
                    } else if val.translation.height < -threshold {
                        onSwipe(.up); commitSwipe(x: 0, y: -800)
                    } else {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            offset = .zero
                        }
                    }
                }
        )
        .onTapGesture { location in
            if location.x < 100 { currentPhoto = max(0, currentPhoto - 1) }
            else                 { currentPhoto = min(photoURLs.count - 1, currentPhoto + 1) }
        }
    }

    private func commitSwipe(x: CGFloat, y: CGFloat) {
        withAnimation(.easeOut(duration: 0.4)) { offset = CGSize(width: x, height: y) }
    }
}

fileprivate enum LpspTinderSwipeDirection { case left, right, up }

fileprivate struct LpspTinderTinderStamp: View {
    let text: String
    let color: Color
    let rotation: Double

    var body: some View {
        Text(text)
            .font(LpspTinderFonts.tdrStamp)
            .foregroundStyle(color)
            .padding(.horizontal, 12).padding(.vertical, 6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(color, lineWidth: 4)
            )
            .rotationEffect(.degrees(rotation))
    }
}

fileprivate struct LpspTinderTinderActionBar: View {
    let onRewind: () -> Void
    let onNope:   () -> Void
    let onSuper:  () -> Void
    let onLike:   () -> Void
    let onBoost:  () -> Void

    var body: some View {
        HStack(spacing: 12) {
            LpspTinderTinderActionButton(size: 48, color: LpspTinderTokens.tdrRewindGold,     symbol: "arrow.counterclockwise", action: onRewind)
            LpspTinderTinderActionButton(size: 56, color: LpspTinderTokens.tdrNopeRed,        symbol: "xmark",                  action: onNope)
            LpspTinderTinderActionButton(size: 40, color: LpspTinderTokens.tdrSuperLikeBlue,  symbol: "star.fill",              action: onSuper)
            LpspTinderTinderActionButton(size: 56, color: LpspTinderTokens.tdrLikeStampGreen, symbol: "heart.fill",             action: onLike)
            LpspTinderTinderActionButton(size: 48, color: LpspTinderTokens.tdrBoostPurple,    symbol: "bolt.fill",              action: onBoost)
        }
    }
}

fileprivate struct LpspTinderTinderActionButton: View {
    let size: CGFloat
    let color: Color
    let symbol: String
    let action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: size * 0.42, weight: .bold))
                .foregroundStyle(color)
                .frame(width: size, height: size)
                .background(
                    Circle().fill(Color.white)
                        .overlay(Circle().stroke(color, lineWidth: 2))
                        .shadow(color: .black.opacity(0.1), radius: 8, y: 2)
                )
        }
        .scaleEffect(pressed ? 0.92 : 1)
        .animation(.spring(response: 0.25, dampingFraction: 0.5), value: pressed)
        .sensoryFeedback(.impact(weight: .medium), trigger: pressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressed = true }
                .onEnded   { _ in pressed = false }
        )
    }
}

fileprivate struct LpspTinderTinderBrandPillButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspTinderFonts.tdrButton)
                .foregroundStyle(.white)
                .tracking(0.2)
                .padding(.vertical, 14)
                .padding(.horizontal, 32)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(Capsule().fill(LpspTinderGradients.tdrBrand))
                .shadow(color: LpspTinderTokens.tdrPink.opacity(0.3), radius: 16, y: 4)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspTinderTinderMatchScreen: View {
    let yourPhotoURL: URL
    let theirPhotoURL: URL
    let theirName: String

    var body: some View {
        ZStack {
            LpspTinderGradients.tdrBrand.ignoresSafeArea()

            VStack(spacing: 24) {
                Text("It's a Match!")
                    .font(LpspTinderFonts.tdrMatchHero)
                    .foregroundStyle(.white)

                Text("You and \(theirName) liked each other")
                    .font(LpspTinderFonts.tdrBody)
                    .foregroundStyle(.white.opacity(0.8))

                HStack(spacing: 20) {
                    LpspTinderMatchAvatar(url: yourPhotoURL)
                    LpspTinderMatchAvatar(url: theirPhotoURL)
                }

                VStack(spacing: 12) {
                    Button {
                        // send message
                    } label: {
                        Text("Send Message")
                            .font(LpspTinderFonts.tdrButton)
                            .foregroundStyle(LpspTinderGradients.tdrBrand)
                            .padding(.vertical, 14).padding(.horizontal, 32)
                            .frame(maxWidth: .infinity)
                            .background(Capsule().fill(Color.white))
                    }
                    Button {
                        // keep playing
                    } label: {
                        Text("Keep Playing")
                            .font(LpspTinderFonts.tdrButton)
                            .foregroundStyle(.white)
                            .padding(.vertical, 14).padding(.horizontal, 32)
                            .frame(maxWidth: .infinity)
                            .overlay(Capsule().stroke(.white, lineWidth: 2))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
            }
        }
        .sensoryFeedback(.success, trigger: true)
    }
}

fileprivate struct LpspTinderMatchAvatar: View {
    let url: URL
    var body: some View {
        AsyncImage(url: url) { img in
            img.resizable().scaledToFill()
        } placeholder: {
            Circle().fill(.white.opacity(0.3))
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .overlay(Circle().stroke(.white, lineWidth: 3))
    }
}

fileprivate struct LpspTinderTinderChatBubble: View {
    enum LpspTinderSender { case me, them }
    let text: String
    let sender: LpspTinderSender

    var body: some View {
        HStack {
            if sender == .me { Spacer(minLength: 80) }
            Text(text)
                .font(LpspTinderFonts.tdrChat)
                .foregroundStyle(sender == .me ? LpspTinderTokens.tdrTextPrimary : .white)
                .padding(.horizontal, 14).padding(.vertical, 10)
                .background(
                    Group {
                        if sender == .them {
                            LpspTinderGradients.tdrBrand
                        } else {
                            LpspTinderTokens.tdrSurfaceMuted
                        }
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
            if sender == .them { Spacer(minLength: 80) }
        }
        .padding(.horizontal, 16)
    }
}



// MARK: - Showroom data & store

private enum LpspTinderShowroomTab: String, CaseIterable, Identifiable {
    case discover, topPicks, messages, profile

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .discover: "flame.fill"
        case .topPicks: "star.fill"
        case .messages: "bubble.left.fill"
        case .profile: "person.fill"
        }
    }
}

private struct LpspTinderProfile: Identifiable, Equatable {
    let id: String
    let name: String
    let age: Int
    let distance: String
    let occupation: String
    let gradient: [Color]
    let triggersMatch: Bool
}

private enum LpspTinderShowroomData {
    static let maya = LpspTinderProfile(
        id: "maya",
        name: "Maya",
        age: 27,
        distance: "3 mi away",
        occupation: "Designer",
        gradient: [
            Color(red: 0.55, green: 0.35, blue: 0.45),
            Color(red: 0.25, green: 0.18, blue: 0.35),
        ],
        triggersMatch: true
    )

    static let deck: [LpspTinderProfile] = [
        maya,
        LpspTinderProfile(
            id: "jordan",
            name: "Jordan",
            age: 29,
            distance: "5 mi away",
            occupation: "Photographer",
            gradient: [
                Color(red: 0.22, green: 0.42, blue: 0.62),
                Color(red: 0.12, green: 0.22, blue: 0.38),
            ],
            triggersMatch: false
        ),
        LpspTinderProfile(
            id: "lena",
            name: "Lena",
            age: 26,
            distance: "2 mi away",
            occupation: "Architect",
            gradient: [
                Color(red: 0.72, green: 0.48, blue: 0.32),
                Color(red: 0.42, green: 0.28, blue: 0.22),
            ],
            triggersMatch: false
        ),
    ]

    static let topPicks = ["Sofia", "Noah", "Emma"]

    static let messages: [(name: String, preview: String, time: String)] = [
        ("Maya", "Hey! Coffee this week?", "2h"),
        ("Jordan", "Loved your travel pics", "1d"),
    ]

    static let chatThread: [(text: String, outgoing: Bool)] = [
        ("Hey! Coffee this week?", false),
        ("Absolutely — Thursday works for me", true),
    ]
}

@MainActor
fileprivate final class LpspTinderStore: ObservableObject {
    @Published var selectedTab: LpspTinderShowroomTab = .discover
    @Published var deck: [LpspTinderProfile] = LpspTinderShowroomData.deck
    @Published var history: [LpspTinderProfile] = []
    @Published var showMatch = false
    @Published var matchedProfile: LpspTinderProfile?
    @Published var cardOffset = CGSize.zero
    @Published var messageText = ""

    var currentProfile: LpspTinderProfile? { deck.first }

    func advanceDeck(removing current: LpspTinderProfile) {
        history.append(current)
        deck = Array(deck.dropFirst())
        cardOffset = .zero
    }

    func rewind() {
        guard let last = history.popLast() else { return }
        deck.insert(last, at: 0)
        cardOffset = .zero
    }

    func nope() {
        guard let current = currentProfile else { return }
        withAnimation(.easeOut(duration: 0.35)) {
            cardOffset = CGSize(width: -500, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.advanceDeck(removing: current)
        }
    }

    func like() {
        guard let current = currentProfile else { return }
        withAnimation(.easeOut(duration: 0.35)) {
            cardOffset = CGSize(width: 500, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            if current.triggersMatch {
                self.matchedProfile = current
                self.showMatch = true
            }
            self.advanceDeck(removing: current)
        }
    }

    func superLike() {
        guard let current = currentProfile else { return }
        withAnimation(.easeOut(duration: 0.35)) {
            cardOffset = CGSize(width: 0, height: -600)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.advanceDeck(removing: current)
        }
    }

    func boost() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
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
            nope()
        } else if translation.height < -threshold {
            superLike()
        } else {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                cardOffset = .zero
            }
        }
    }
}

// MARK: - Écrans showroom

private struct LpspTinderShowroomRoot: View {
    @ObservedObject var store: LpspTinderStore

    var body: some View {
        ZStack {
            LpspTinderTokens.tdrDarkCanvas.ignoresSafeArea()

            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .discover:
                        LpspTinderDiscoverTabScreen(store: store)
                    case .topPicks:
                        LpspTinderTopPicksTabScreen()
                    case .messages:
                        LpspTinderMessagesTabScreen(store: store)
                    case .profile:
                        LpspTinderProfileTabScreen()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspTinderIconTabBar(store: store)
            }
        }
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $store.showMatch) {
            if let match = store.matchedProfile {
                LpspTinderShowroomMatchScreen(name: match.name, onDismiss: { store.dismissMatch() })
            }
        }
    }
}

private struct LpspTinderIconTabBar: View {
    @ObservedObject var store: LpspTinderStore

    var body: some View {
        HStack {
            ForEach(LpspTinderShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    Group {
                        if tab == .discover && store.selectedTab == tab {
                            Image(systemName: tab.icon)
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundStyle(LpspTinderGradients.tdrBrand)
                        } else {
                            Image(systemName: tab.icon)
                                .font(.system(size: 28, weight: .regular))
                                .foregroundStyle(
                                    store.selectedTab == tab
                                        ? Color.white
                                        : LpspTinderTokens.tdrTextTertiary
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                }
                .buttonStyle(.plain)
            }
        }
        .background(LpspTinderTokens.tdrDarkCanvas)
    }
}

private struct LpspTinderDiscoverTabScreen: View {
    @ObservedObject var store: LpspTinderStore

    var body: some View {
        VStack(spacing: 0) {
            LpspTinderSpectrTopNav()

            ZStack {
                if let profile = store.currentProfile {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LpspTinderTokens.tdrDarkSurface2)
                        .padding(.horizontal, 8)
                        .padding(.top, 8)
                        .padding(.bottom, 72)

                    VStack(spacing: 0) {
                        LpspTinderShowroomSwipeCard(
                            profile: profile,
                            offset: store.cardOffset,
                            onDragChanged: { store.updateDrag($0) },
                            onDragEnded: { store.endDrag($0) }
                        )
                        .padding(.horizontal, 12)
                        .padding(.top, 4)

                        LpspTinderTinderActionBar(
                            onRewind: { store.rewind() },
                            onNope: { store.nope() },
                            onSuper: { store.superLike() },
                            onLike: { store.like() },
                            onBoost: { store.boost() }
                        )
                        .padding(.top, 8)
                        .padding(.bottom, 12)
                    }
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(LpspTinderGradients.tdrBrand)
                        Text("No more profiles nearby")
                            .font(LpspTinderFonts.tdrBody)
                            .foregroundStyle(LpspTinderTokens.tdrTextSecondary)
                        Button("Rewind") { store.rewind() }
                            .font(LpspTinderFonts.tdrButton)
                            .foregroundStyle(LpspTinderTokens.tdrRewindGold)
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

private struct LpspTinderSpectrTopNav: View {
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(LpspTinderGradients.tdrBrand)

            Spacer()

            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 22))
                .foregroundStyle(Color.white)
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
    }
}

private struct LpspTinderShowroomSwipeCard: View {
    let profile: LpspTinderProfile
    let offset: CGSize
    let onDragChanged: (CGSize) -> Void
    let onDragEnded: (CGSize) -> Void

    private var rotation: Double { Double(offset.width) / 12 }
    private var likeOpacity: Double { min(1.0, max(0, Double(offset.width) / 160)) }
    private var nopeOpacity: Double {
        let drag = min(1.0, max(0, Double(-offset.width) / 160))
        return drag > 0 ? drag : (profile.id == "maya" ? 0.35 : 0)
    }
    private var superOpacity: Double { min(1.0, max(0, Double(-offset.height) / 160)) }

    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: profile.gradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            LinearGradient(
                colors: [.clear, Color.black.opacity(0.75)],
                startPoint: .center,
                endPoint: .bottom
            )

            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("\(profile.name),")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.white)
                        Text(" \(profile.age)")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundStyle(.white)
                    }

                    Text("📍 \(profile.distance) · \(profile.occupation)")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.white.opacity(0.95))
                }

                Spacer()

                Text("i")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 28, height: 28)
                    .background(Circle().fill(Color.white.opacity(0.2)))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)

            LpspTinderTinderStamp(text: "LIKE", color: LpspTinderTokens.tdrLikeStampGreen, rotation: -15)
                .opacity(likeOpacity)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(32)

            LpspTinderTinderStamp(text: "NOPE", color: LpspTinderTokens.tdrNopeRed, rotation: 15)
                .opacity(nopeOpacity)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(32)

            LpspTinderTinderStamp(text: "SUPER LIKE", color: LpspTinderTokens.tdrSuperLikeBlue, rotation: 0)
                .opacity(superOpacity)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 64)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 480)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.25), radius: 16, y: 4)
        .rotationEffect(.degrees(rotation))
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { onDragChanged($0.translation) }
                .onEnded { onDragEnded($0.translation) }
        )
    }
}

private struct LpspTinderShowroomMatchScreen: View {
    let name: String
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            LpspTinderGradients.tdrBrand.ignoresSafeArea()

            VStack(spacing: 24) {
                Text("It's a Match!")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(.white)

                Text("You and \(name) liked each other")
                    .font(LpspTinderFonts.tdrBody)
                    .foregroundStyle(.white.opacity(0.85))

                HStack(spacing: 20) {
                    matchAvatar(colors: [LpspTinderTokens.tdrSuperLikeBlue, LpspTinderTokens.tdrBoostPurple])
                    matchAvatar(colors: [Color(red: 0.55, green: 0.35, blue: 0.45), Color(red: 0.25, green: 0.18, blue: 0.35)])
                }

                VStack(spacing: 12) {
                    Button(action: onDismiss) {
                        Text("Send Message")
                            .font(LpspTinderFonts.tdrButton.weight(.semibold))
                            .foregroundStyle(LpspTinderTokens.tdrPink)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity)
                            .background(Capsule().fill(Color.white))
                    }
                    Button(action: onDismiss) {
                        Text("Keep Playing")
                            .font(LpspTinderFonts.tdrButton.weight(.semibold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity)
                            .overlay(Capsule().stroke(.white, lineWidth: 2))
                    }
                }
                .padding(.horizontal, 24)
            }
            .padding()
        }
        .sensoryFeedback(.success, trigger: true)
    }

    private func matchAvatar(colors: [Color]) -> some View {
        Circle()
            .fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 120, height: 120)
            .overlay(Circle().stroke(.white, lineWidth: 3))
    }
}

private struct LpspTinderTopPicksTabScreen: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(LpspTinderShowroomData.topPicks, id: \.self) { name in
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(
                            colors: [
                                LpspTinderTokens.tdrPink.opacity(0.5),
                                LpspTinderTokens.tdrOrange.opacity(0.8),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        Text(name)
                            .font(LpspTinderFonts.tdrProfileName.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(12)
                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(alignment: .topTrailing) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(LpspTinderTokens.tdrSuperLikeBlue)
                            .padding(10)
                    }
                }
            }
            .padding(16)
        }
    }
}

private struct LpspTinderMessagesTabScreen: View {
    @ObservedObject var store: LpspTinderStore

    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    ForEach(LpspTinderShowroomData.messages.indices, id: \.self) { index in
                        let item = LpspTinderShowroomData.messages[index]
                        HStack(spacing: 12) {
                            Circle()
                                .fill(LpspTinderGradients.tdrBrand)
                                .frame(width: 48, height: 48)
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(item.name)
                                        .font(LpspTinderFonts.tdrBody.weight(.semibold))
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Text(item.time)
                                        .font(LpspTinderFonts.tdrChatTimestamp)
                                        .foregroundStyle(LpspTinderTokens.tdrTextTertiary)
                                }
                                Text(item.preview)
                                    .font(LpspTinderFonts.tdrChat)
                                    .foregroundStyle(LpspTinderTokens.tdrTextSecondary)
                                    .lineLimit(1)
                            }
                        }
                        .listRowBackground(LpspTinderTokens.tdrDarkSurface1)
                    }
                }

                Section("Maya") {
                    ForEach(LpspTinderShowroomData.chatThread.indices, id: \.self) { index in
                        let bubble = LpspTinderShowroomData.chatThread[index]
                        LpspTinderTinderChatBubble(
                            text: bubble.text,
                            sender: bubble.outgoing ? .me : .them
                        )
                        .listRowBackground(LpspTinderTokens.tdrDarkCanvas)
                        .listRowInsets(EdgeInsets())
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(LpspTinderTokens.tdrDarkCanvas)

            HStack {
                TextField("Message", text: $store.messageText)
                    .font(LpspTinderFonts.tdrChat)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LpspTinderTokens.tdrDarkSurface2)
                    )
            }
            .padding(8)
            .background(LpspTinderTokens.tdrDarkSurface1)
        }
    }
}

private struct LpspTinderProfileTabScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .fill(LpspTinderGradients.tdrBrand)
                .frame(width: 96, height: 96)
                .overlay {
                    Text("You")
                        .font(LpspTinderFonts.tdrProfileName.weight(.bold))
                        .foregroundStyle(.white)
                }

            Text("Complete your profile")
                .font(LpspTinderFonts.tdrSection.weight(.semibold))
                .foregroundStyle(.white)

            Text("Add photos and prompts to get more matches")
                .font(LpspTinderFonts.tdrBody)
                .foregroundStyle(LpspTinderTokens.tdrTextSecondary)
                .multilineTextAlignment(.center)

            LpspTinderTinderBrandPillButton(title: "Edit Profile", action: {})
                .padding(.horizontal, 32)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



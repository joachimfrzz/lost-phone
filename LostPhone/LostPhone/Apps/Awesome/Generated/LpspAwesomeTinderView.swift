import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/dating/tinder/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/tinder
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTinderView: View {
    var body: some View {
        LpspTinderShowroomRoot()
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

private struct LpspTinderTinderSwipeCard: View {
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

private enum LpspTinderSwipeDirection { case left, right, up }

private struct LpspTinderTinderStamp: View {
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

private struct LpspTinderTinderActionBar: View {
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

private struct LpspTinderTinderActionButton: View {
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
                        .overlay(Circle().strokeBorder(color, lineWidth: 2))
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

private struct LpspTinderTinderBrandPillButton: View {
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
                .background(Capsule().fill(LinearGradient.tdrBrand))
                .shadow(color: LpspTinderTokens.tdrPink.opacity(0.3), radius: 16, y: 4)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspTinderTinderMatchScreen: View {
    let yourPhotoURL: URL
    let theirPhotoURL: URL
    let theirName: String

    var body: some View {
        ZStack {
            LinearGradient.tdrBrand.ignoresSafeArea()

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
                            .foregroundStyle(LinearGradient.tdrBrand)
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
                            .overlay(Capsule().strokeBorder(.white, lineWidth: 2))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
            }
        }
        .sensoryFeedback(.success, trigger: true)
    }
}

private struct LpspTinderMatchAvatar: View {
    let url: URL
    var body: some View {
        AsyncImage(url: url) { img in
            img.resizable().scaledToFill()
        } placeholder: {
            Circle().fill(.white.opacity(0.3))
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .overlay(Circle().strokeBorder(.white, lineWidth: 3))
    }
}

private struct LpspTinderTinderChatBubble: View {
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
                            LinearGradient.tdrBrand
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

private struct LpspTinderTinderRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        // Hide labels
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 1000)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 1000)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            SwipeView().tabItem    { Image(systemName: "flame.fill") }
            TopPicksView().tabItem { Image(systemName: "star.fill") }
            ChatsView().tabItem    { Image(systemName: "bubble.left.fill") }
            ProfileView().tabItem  { Image(systemName: "person.fill") }
        }
        .tint(LpspTinderTokens.tdrPink) // Active = pink (gradient fill requires custom tab icons via AnyView)
    }
}

// MARK: - Écrans showroom

private struct LpspTinderShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspTinderDatingDiscoverTabScreen()
                .tabItem { Label("Découvrir", systemImage: "flame.fill") }
                .tag(0)
            LpspTinderGenericTabScreen(title: "Messages", tabIndex: 1)
                .tabItem { Label("Messages", systemImage: "bubble.left") }
                .tag(1)
            LpspTinderGenericTabScreen(title: "Profil", tabIndex: 2)
                .tabItem { Label("Profil", systemImage: "person.fill") }
                .tag(2)
        }
        .tint(LpspTinderTokens.tdrBrand)
        
    }
}


private struct LpspTinderGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTinderTokens.tdrBrand.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspTinderTokens.tdrBrand))
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


private struct LpspTinderDemoDatingProfile {
    let name: String
    let age: Int
    let bio: String
    static let sample = LpspTinderDemoDatingProfile(name: "Alex", age: 28, bio: "Paris · Photo · Voyage")
}

private struct LpspTinderDatingDiscoverTabScreen: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            LpspTinderTinderSwipeCard(profile: LpspTinderDemoDatingProfile.sample)
        }
    }
}

private struct LpspTinderDemoSwipeCard: View {
    let accent: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(LinearGradient(colors: [accent.opacity(0.3), .black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
            .frame(width: 320, height: 480)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text("Alex, 28").font(.title.bold()).foregroundStyle(.white)
                    Text("Paris · Photo · Voyage").foregroundStyle(.white.opacity(0.9))
                }
                .padding(20)
            }
    }
}



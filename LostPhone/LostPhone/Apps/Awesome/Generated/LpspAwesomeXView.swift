import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/social/x-twitter/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/x-twitter
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeXView: View {
    var body: some View {
        LpspXShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspXFonts {
    static let xScreenTitle   = Font.system(size: 20, weight: .regular)
    static let xSectionHeader = Font.system(size: 17, weight: .regular)
    static let xDisplayName   = Font.system(size: 15, weight: .regular)
    static let xPostBody      = Font.system(size: 15, weight: .regular)
    static let xQuotedBody    = Font.system(size: 14, weight: .regular)
    static let xHandle        = Font.system(size: 15, weight: .regular)
    static let xActionCount   = Font.system(size: 13, weight: .regular)
    static let xTrendingTopic = Font.system(size: 15, weight: .regular)
    static let xTrendingMeta  = Font.system(size: 13, weight: .regular)
    static let xButton        = Font.system(size: 15, weight: .regular)
    static let xDMBody        = Font.system(size: 15, weight: .regular)
    static let xDMTimestamp   = Font.system(size: 11, weight: .regular)
    static func xFallback(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspXTokens {
    // MARK: - Canvas & Surfaces (Dark / Default)
    static let xCanvas           = Color.black                                   // #000000
    static let xSurface1          = Color(red: 0.086, green: 0.094, blue: 0.110) // #16181C
    static let xSurface2          = Color(red: 0.118, green: 0.125, blue: 0.141) // #1E2024
    static let xDivider           = Color(red: 0.184, green: 0.200, blue: 0.212) // #2F3336
    static let xDimCanvas         = Color(red: 0.082, green: 0.125, blue: 0.173) // #15202B
    static let xDimSurface1       = Color(red: 0.098, green: 0.153, blue: 0.204) // #192734
    static let xDimDivider        = Color(red: 0.220, green: 0.267, blue: 0.302) // #38444D

    // MARK: - Canvas & Surfaces (Light)
    static let xLightCanvas       = Color.white                                  // #FFFFFF
    static let xLightSurface1     = Color(red: 0.969, green: 0.976, blue: 0.976) // #F7F9F9
    static let xLightSurface2     = Color(red: 0.937, green: 0.953, blue: 0.957) // #EFF3F4

    // MARK: - Text
    static let xTextPrimaryDark   = Color(red: 0.906, green: 0.914, blue: 0.918) // #E7E9EA
    static let xTextPrimaryLight  = Color(red: 0.059, green: 0.078, blue: 0.098) // #0F1419
    static let xTextSecondaryDark = Color(red: 0.443, green: 0.463, blue: 0.482) // #71767B
    static let xTextSecondaryLight = Color(red: 0.325, green: 0.392, blue: 0.443) // #536471

    // MARK: - Brand / Action
    static let xBlue              = Color(red: 0.114, green: 0.608, blue: 0.941) // #1D9BF0
    static let xBluePressed       = Color(red: 0.102, green: 0.549, blue: 0.847) // #1A8CD8
    static let xRepostGreen       = Color(red: 0.000, green: 0.729, blue: 0.486) // #00BA7C
    static let xLikePink          = Color(red: 0.976, green: 0.094, blue: 0.502) // #F91880
    static let xVerifiedGold      = Color(red: 0.918, green: 0.702, blue: 0.031) // #EAB308
    static let xVerifiedGray      = Color(red: 0.510, green: 0.604, blue: 0.671) // #829AAB
    static let xErrorRed          = Color(red: 0.957, green: 0.129, blue: 0.180) // #F4212E
}



// System fallback if Chirp isn't bundled:


fileprivate struct LpspXXPostRow: View {
    let displayName: String
    let handle: String
    let timestamp: String
    let isVerified: Bool
    let avatar: Image
    let postText: String
    var replyCount: Int = 0
    var repostCount: Int = 0
    var likeCount: Int = 0
    var viewCount: Int = 0
    @State private var isLiked = false
    @State private var isReposted = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                avatar
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    // Header row: name + verified + handle + time + overflow
                    HStack(spacing: 4) {
                        Text(displayName)
                            .font(LpspXFonts.xDisplayName)
                            .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                            .lineLimit(1)
                        if isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(LpspXTokens.xBlue)
                        }
                        Text("@\(handle)")
                            .font(LpspXFonts.xHandle)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                            .lineLimit(1)
                        Text("·")
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                        Text(timestamp)
                            .font(LpspXFonts.xHandle)
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                        Spacer()
                        Button { /* overflow */ } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 18))
                                .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                        }
                    }

                    // Body
                    Text(postText)
                        .font(LpspXFonts.xPostBody)
                        .foregroundStyle(LpspXTokens.xTextPrimaryDark)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)

                    // Action row
                    HStack(spacing: 0) {
                        LpspXXActionIcon(systemName: "bubble.left",        count: replyCount,  color: LpspXTokens.xTextSecondaryDark, active: false)
                        Spacer()
                        LpspXXActionIcon(systemName: isReposted ? "arrow.2.squarepath" : "arrow.2.squarepath",
                                    count: repostCount, color: isReposted ? LpspXTokens.xRepostGreen : LpspXTokens.xTextSecondaryDark, active: isReposted)
                            .onTapGesture { withAnimation(.spring(response: 0.35)) { isReposted.toggle() } }
                        Spacer()
                        LpspXXActionIcon(systemName: isLiked ? "heart.fill" : "heart",
                                    count: likeCount, color: isLiked ? LpspXTokens.xLikePink : LpspXTokens.xTextSecondaryDark, active: isLiked)
                            .onTapGesture { withAnimation(.spring(response: 0.35)) { isLiked.toggle() } }
                        Spacer()
                        LpspXXActionIcon(systemName: "chart.bar",          count: viewCount,   color: LpspXTokens.xTextSecondaryDark, active: false)
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspXTokens.xTextSecondaryDark)
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            Divider().background(LpspXTokens.xDivider)
        }
        .background(LpspXTokens.xCanvas)
    }
}

fileprivate struct LpspXXActionIcon: View {
    let systemName: String
    let count: Int
    let color: Color
    let active: Bool

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: systemName)
                .font(.system(size: 18.75, weight: active ? .semibold : .regular))
                .foregroundStyle(color)
                .scaleEffect(active ? 1.0 : 1.0)
            if count > 0 {
                Text(formatted(count))
                    .font(LpspXFonts.xActionCount)
                    .foregroundStyle(color)
            }
        }
        .frame(minWidth: 44, minHeight: 44, alignment: .leading)
    }

    private func formatted(_ n: Int) -> String {
        switch n {
        case 1_000_000...: return String(format: "%.1fM", Double(n)/1_000_000)
        case 1_000...:     return String(format: "%.1fK", Double(n)/1_000)
        default:           return "\(n)"
        }
    }
}

fileprivate struct LpspXXPostFAB: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "pencil.and.outline")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.black)
                .frame(width: 56, height: 56)
                .background(Circle().fill(Color.white))
                .shadow(color: .black.opacity(0.4), radius: 12, y: 4)
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: UUID())
        .buttonStyle(LpspXXPressableStyle(pressedScale: 0.95))
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
}

fileprivate struct LpspXXPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspXXFollowPill: View {
    @Binding var isFollowing: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(isFollowing ? "Following" : "Follow")
                .font(LpspXFonts.xButton)
                .foregroundStyle(isFollowing ? LpspXTokens.xTextPrimaryDark : .black)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .frame(minWidth: 80)
                .background(
                    Capsule().fill(isFollowing ? Color.clear : LpspXTokens.xTextPrimaryDark)
                )
                .overlay(
                    Capsule().strokeBorder(isFollowing ? LpspXTokens.xTextSecondaryDark : .clear, lineWidth: 1)
                )
        }
        .buttonStyle(LpspXXPressableStyle())
    }
}

fileprivate struct LpspXXFeedFilter: View {
    @Binding var selection: Int // 0 = For you, 1 = Following
    private let titles = ["For you", "Following"]
    @Namespace private var indicator

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<2) { i in
                VStack(spacing: 12) {
                    Text(titles[i])
                        .font(LpspXFonts.xButton)
                        .foregroundStyle(selection == i ? LpspXTokens.xTextPrimaryDark : LpspXTokens.xTextSecondaryDark)
                    if selection == i {
                        Capsule()
                            .fill(LpspXTokens.xBlue)
                            .frame(width: 40, height: 4)
                            .matchedGeometryEffect(id: "indicator", in: indicator)
                    } else {
                        Color.clear.frame(height: 4)
                    }
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        selection = i
                    }
                }
            }
        }
        .frame(height: 48)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspXTokens.xDivider).frame(height: 1)
        }
    }
}

fileprivate struct LpspXLikeBurstModifier: ViewModifier {
    @Binding var isLiked: Bool
    @State private var particles: [CGPoint] = []

    func body(content: Content) -> some View {
        content
            .scaleEffect(isLiked ? 1.0 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.55), value: isLiked)
            .overlay {
                ForEach(Array(particles.enumerated()), id: \.offset) { _, p in
                    Circle()
                        .fill(LpspXTokens.xLikePink)
                        .frame(width: 4, height: 4)
                        .offset(x: p.x, y: p.y)
                        .opacity(0)
                        .animation(.easeOut(duration: 0.4), value: particles.count)
                }
            }
            .onChange(of: isLiked) { _, newValue in
                guard newValue else { return }
                // Hexagonal burst of 6 particles
                let radius: CGFloat = 18
                particles = (0..<6).map { i in
                    let angle = Double(i) * .pi / 3
                    return CGPoint(x: cos(angle) * radius, y: sin(angle) * radius)
                }
            }
    }
}

fileprivate extension View {
    func xLikeBurst(isLiked: Binding<Bool>) -> some View {
        modifier(LpspXLikeBurstModifier(isLiked: isLiked))
    }
}



// MARK: - Écrans showroom

private struct LpspXShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspXFeedTabScreen()
                .tabItem { Label("Accueil", systemImage: "house.fill") }
                .tag(0)
            LpspXExploreTabScreen()
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
                .tag(1)
            LpspXSocialTabScreen(title: "Person 3 Fill")
                .tabItem { Label("Person 3 Fill", systemImage: "person.3.fill") }
                .tag(2)
            LpspXSocialTabScreen(title: "Bell Fill")
                .tabItem { Label("Bell Fill", systemImage: "bell.fill") }
                .tag(3)
            LpspXSocialTabScreen(title: "Envelope Fill")
                .tabItem { Label("Envelope Fill", systemImage: "envelope.fill") }
                .tag(4)
        }
        .tint(LpspXTokens.xErrorRed)
        
    }
}


private struct LpspXGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspXTokens.xErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspXTokens.xErrorRed))
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


private struct LpspXDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspXDemoStories {
    static let items: [LpspXDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspXFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspXDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    Circle().strokeBorder(LpspXTokens.xErrorRed, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill(LpspXTokens.xErrorRed.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(0..<3, id: \.self) { i in
                        LpspXGenericFeedCard(index: i, accent: LpspXTokens.xErrorRed)
                    }

                }
            }
            .background(LpspXTokens.xCanvas.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspXExploreTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LpspXTokens.xErrorRed.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .navigationTitle("Explorer")
        }
    }
}

private struct LpspXReelsTabScreen: View {
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

private struct LpspXProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspXTokens.xErrorRed.gradient).frame(width: 88, height: 88)
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

private struct LpspXSocialTabScreen: View {
    let title: String
    var body: some View { LpspXGenericTabScreen(title: title, tabIndex: 0) }
}

private struct LpspXGenericFeedCard: View {
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



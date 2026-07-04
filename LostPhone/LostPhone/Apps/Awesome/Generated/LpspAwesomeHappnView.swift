import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/dating/happn/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/happn
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeHappnView: View {
    var body: some View {
        LpspHappnShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspHappnTokens {
    // MARK: - Canvas & Surfaces (Dark)
    static let happnCanvas   = Color(red: 0.055, green: 0.055, blue: 0.071) // #0E0E12
    static let happnSurface1 = Color(red: 0.094, green: 0.094, blue: 0.122) // #18181F
    static let happnSurface2 = Color(red: 0.129, green: 0.129, blue: 0.169) // #21212B
    static let happnSurface3 = Color(red: 0.173, green: 0.173, blue: 0.220) // #2C2C38
    static let happnDivider  = Color(red: 0.165, green: 0.165, blue: 0.200) // #2A2A33  (also timeline spine)

    // MARK: - Canvas & Surfaces (Light)
    static let happnCanvasLight  = Color.white                                   // #FFFFFF
    static let happnSurface1Light = Color(red: 0.965, green: 0.965, blue: 0.973) // #F6F6F8

    // MARK: - Brand
    static let happnPink      = Color(red: 1.000, green: 0.282, blue: 0.396) // #FF4865
    static let happnPinkPress = Color(red: 0.898, green: 0.208, blue: 0.310) // #E5354F
    static let happnMagenta   = Color(red: 0.914, green: 0.118, blue: 0.388) // #E91E63
    static let happnRose      = Color(red: 1.000, green: 0.482, blue: 0.576) // #FF7B93
    static let happnGold      = Color(red: 1.000, green: 0.761, blue: 0.294) // #FFC24B  (Crush/premium only)

    // MARK: - Text
    static let happnTextPrimary   = Color(red: 0.957, green: 0.957, blue: 0.965) // #F4F4F6
    static let happnTextSecondary = Color(red: 0.627, green: 0.627, blue: 0.682) // #A0A0AE
    static let happnTextTertiary  = Color(red: 0.424, green: 0.424, blue: 0.478) // #6C6C7A
    static let happnOnPink        = Color.white                                  // #FFFFFF
    static let happnOnGold        = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A

    // MARK: - Semantic
    static let happnSuccess = Color(red: 0.306, green: 0.851, blue: 0.643) // #4ED9A4
    static let happnError   = Color(red: 1.000, green: 0.361, blue: 0.361) // #FF5C5C
}

// Hero gradient — primary "Say hi" / Crush star / splash
private enum LpspHappnGradients {
    static let happnHero = LinearGradient(
        colors: [LpspHappnTokens.happnPink, LpspHappnTokens.happnMagenta],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}

private enum LpspHappnFonts {
    // Poppins — warmth/identity
    static let happnDisplay  = Font.system(size: 32, weight: .regular)
    static let happnName     = Font.system(size: 26, weight: .regular)
    static let happnSection  = Font.system(size: 22, weight: .regular)
    static let happnSubsection = Font.system(size: 18, weight: .regular)
    static let happnCardName = Font.system(size: 15, weight: .regular)
    static let happnButton   = Font.system(size: 16, weight: .regular)
    static let happnCount    = Font.system(size: 12, weight: .regular)
    static let happnTab      = Font.system(size: 10, weight: .regular)

    // Inter — legibility
    static let happnBody     = Font.system(size: 16, weight: .regular)
    static let happnBodyMeta = Font.system(size: 14, weight: .regular)
    static let happnLocation = Font.system(size: 12, weight: .regular)
    static let happnCaption  = Font.system(size: 12, weight: .regular)
}

fileprivate struct LpspHappnCrossing: Identifiable {
    let id = UUID()
    let avatar: LinearGradient
    let name: String          // "Camille, 27"
    let place: String         // "Le Marais"
    let timeAgo: String       // "11 min ago"
    let crossCount: Int       // 3
    var charmed: Bool
}

fileprivate struct LpspHappnCrossingsTimeline: View {
    @State var crossings: [LpspHappnCrossing]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach($crossings) { $c in
                    LpspHappnCrossingRow(crossing: $c)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 4)
        }
        .background(LpspHappnTokens.happnCanvas)
    }
}

fileprivate struct LpspHappnCrossingRow: View {
    @Binding var crossing: LpspHappnCrossing

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // Connector spine + dot
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LpspHappnTokens.happnDivider)
                    .frame(width: 2)
                    .padding(.top, 6)
                Circle()
                    .fill(LpspHappnTokens.happnPink)
                    .frame(width: 12, height: 12)
                    .overlay(Circle().stroke(LpspHappnTokens.happnPink.opacity(0.18), lineWidth: 4))
                    .padding(.top, 6)
            }
            .frame(width: 18)

            // Card
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 16).fill(crossing.avatar)
                    .frame(width: 56, height: 56)

                VStack(alignment: .leading, spacing: 3) {
                    Text(crossing.name)
                        .font(LpspHappnFonts.happnCardName).foregroundStyle(LpspHappnTokens.happnTextPrimary)
                    HStack(spacing: 5) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 11)).foregroundStyle(LpspHappnTokens.happnTextTertiary)
                        Text("\(crossing.place) · \(crossing.timeAgo)")
                            .font(LpspHappnFonts.happnLocation).foregroundStyle(LpspHappnTokens.happnTextSecondary)
                    }
                    Text("You crossed paths \(crossing.crossCount == 1 ? "once" : "\(crossing.crossCount) times")")
                        .font(LpspHappnFonts.happnCount).foregroundStyle(LpspHappnTokens.happnPink)
                }
                Spacer(minLength: 8)

                LpspHappnCharmButton(charmed: $crossing.charmed, size: 40)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(LpspHappnTokens.happnSurface1)
                    .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(LpspHappnTokens.happnDivider, lineWidth: 1))
            )
            .padding(.leading, 8)   // 26pt total left clearance with the 18pt spine column
        }
    }
}

fileprivate struct LpspHappnCharmButton: View {
    @Binding var charmed: Bool
    var size: CGFloat = 40
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Button {
            charmed = true
            scale = 1.25
            withAnimation(.spring(response: 0.28, dampingFraction: 0.55)) { scale = 1.0 }
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } label: {
            Image(systemName: charmed ? "heart.fill" : "heart")
                .font(.system(size: size * 0.45, weight: .semibold))
                .foregroundStyle(charmed ? LpspHappnTokens.happnOnPink : LpspHappnTokens.happnTextSecondary)
                .frame(width: size, height: size)
                .background(
                    Circle().fill(charmed ? LpspHappnTokens.happnPink : LpspHappnTokens.happnSurface2)
                )
                .overlay(
                    Circle().strokeBorder(charmed ? Color.clear : LpspHappnTokens.happnDivider, lineWidth: 1)
                )
                .shadow(color: charmed ? LpspHappnTokens.happnPink.opacity(0.5) : .clear, radius: 8, x: 0, y: 6)
                .scaleEffect(scale)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspHappnCrushCelebration: View {
    let leftAvatar: LinearGradient
    let rightAvatar: LinearGradient
    let onStartChat: () -> Void
    @State private var together = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.92).ignoresSafeArea()
            VStack(spacing: 28) {
                ZStack {
                    Circle().fill(leftAvatar).frame(width: 96, height: 96)
                        .offset(x: together ? -28 : -160)
                    Circle().fill(rightAvatar).frame(width: 96, height: 96)
                        .offset(x: together ? 28 : 160)
                }
                Text("It's a Crush!")
                    .font(LpspHappnFonts.happnDisplay).foregroundStyle(LpspHappnTokens.happnTextPrimary)
                Button(action: onStartChat) {
                    Text("Start chatting")
                        .font(LpspHappnFonts.happnButton).foregroundStyle(LpspHappnTokens.happnOnPink)
                        .padding(.vertical, 15).padding(.horizontal, 30)
                        .background(Capsule().fill(LpspHappnGradients.happnHero))
                }
            }
            // Gold sparkle layer — the only place gold appears (besides premium)
            LpspHappnSparkleBurst(color: LpspHappnTokens.happnGold)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.36)) { together = true }
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
}

fileprivate struct LpspHappnCrossingPin: View {
    enum LpspHappnKind { case standard, mutual, ghost }
    let kind: LpspHappnKind

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(fill)
                .frame(width: 44, height: 44)
                .clipShape(LpspHappnTeardropShape())
            Circle()
                .fill(kind == .ghost ? LpspHappnTokens.happnTextTertiary : Color.white)
                .frame(width: 30, height: 30)
        }
        .overlay(kind == .ghost ? AnyView(LpspHappnTeardropShape().stroke(LpspHappnTokens.happnDivider, lineWidth: 1)) : AnyView(EmptyView()))
    }

    private var fill: AnyShapeStyle {
        switch kind {
        case .standard: return AnyShapeStyle(LpspHappnTokens.happnPink)
        case .mutual:   return AnyShapeStyle(LpspHappnGradients.happnHero)
        case .ghost:    return AnyShapeStyle(LpspHappnTokens.happnSurface2)
        }
    }
}

fileprivate struct LpspHappnTeardropShape: Shape {
    func path(in r: CGRect) -> Path {
        // 50% 50% 50% 6px rotated 45° — classic map teardrop
        var p = Path(roundedRect: r, cornerRadii: .init(topLeading: r.width/2, bottomLeading: 6, bottomTrailing: r.width/2, topTrailing: r.width/2))
        p = p.applying(CGAffineTransform(rotationAngle: .pi/4).concatenating(.init(translationX: r.midX, y: r.midY)))
        return p
    }
}

fileprivate struct LpspHappnHappnPrimaryButton: View {
    let title: String; let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title).font(LpspHappnFonts.happnButton).foregroundStyle(LpspHappnTokens.happnOnPink)
                .padding(.vertical, 15).padding(.horizontal, 30).frame(maxWidth: .infinity)
                .background(Capsule().fill(LpspHappnTokens.happnPink))
        }
        .buttonStyle(LpspHappnPressScale())
    }
}

fileprivate struct LpspHappnHappnGradientButton: View {
    let title: String; let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title).font(LpspHappnFonts.happnButton).foregroundStyle(LpspHappnTokens.happnOnPink)
                .padding(.vertical, 15).padding(.horizontal, 30).frame(maxWidth: .infinity)
                .background(Capsule().fill(LpspHappnGradients.happnHero))
        }
        .buttonStyle(LpspHappnPressScale())
    }
}

fileprivate struct LpspHappnPressScale: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.08), value: configuration.isPressed)
    }
}


fileprivate struct LpspHappnHappnTheme: ViewModifier {
    @Environment(\.colorScheme) var scheme
    func body(content: Content) -> some View {
        content
            .background(scheme == .dark ? LpspHappnTokens.happnCanvas : LpspHappnTokens.happnCanvasLight)
            .foregroundStyle(scheme == .dark ? LpspHappnTokens.happnTextPrimary : Color(red: 0.082, green: 0.082, blue: 0.106))
            .tint(LpspHappnTokens.happnPink)
    }
}

fileprivate extension View { func happnTheme() -> some View { modifier(LpspHappnHappnTheme()) } }

fileprivate struct LpspHappnSparkleBurst: View {
    let color: Color
    var body: some View {
        ZStack {
            ForEach(0..<8, id: \.self) { i in
                Circle().fill(color).frame(width: 4, height: 4)
                    .offset(x: cos(Double(i) * .pi / 4) * 24, y: sin(Double(i) * .pi / 4) * 24)
            }
        }
    }
}


// MARK: - Écrans showroom

private struct LpspHappnShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspHappnGenericTabScreen(title: "Timeline", tabIndex: 0)
                .tabItem { Label("Timeline", systemImage: "heart.text.square") }
                .tag(0)
            LpspHappnGenericTabScreen(title: "Map", tabIndex: 1)
                .tabItem { Label("Map", systemImage: "map") }
                .tag(1)
            LpspHappnGenericTabScreen(title: "Chats", tabIndex: 2)
                .tabItem { Label("Chats", systemImage: "bubble.left.and.bubble.right") }
                .tag(2)
            LpspHappnGenericTabScreen(title: "Profile", tabIndex: 3)
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(3)
        }
        .tint(LpspHappnTokens.happnTextPrimary)
        
    }
}


private struct LpspHappnGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspHappnTokens.happnTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspHappnTokens.happnTextPrimary))
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


private struct LpspHappnDemoDatingProfile {
    let name: String
    let age: Int
    let bio: String
    static let sample = LpspHappnDemoDatingProfile(name: "Alex", age: 28, bio: "Paris · Photo · Voyage")
}

private struct LpspHappnDatingDiscoverTabScreen: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            LpspHappnDemoSwipeCard(accent: LpspHappnTokens.happnTextPrimary)
        }
    }
}

private struct LpspHappnDemoSwipeCard: View {
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



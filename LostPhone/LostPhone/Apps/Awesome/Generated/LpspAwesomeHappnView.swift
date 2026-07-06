import SwiftUI
import UIKit

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/happn
// Meliwat/awesome-ios-design-md/dating/happn/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeHappnView: View {
    var body: some View {
        LpspHappnShowroomRoot(store: LpspHappnStore())
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


// MARK: - Showroom data & store

private enum LpspHappnShowroomTab: String, CaseIterable, Identifiable {
    case timeline, map, chats, profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .timeline: "Timeline"
        case .map: "Map"
        case .chats: "Chats"
        case .profile: "Profile"
        }
    }

    var icon: String {
        switch self {
        case .timeline: "heart.fill"
        case .map: "map.fill"
        case .chats: "bubble.left.and.bubble.right.fill"
        case .profile: "person.fill"
        }
    }
}

private struct LpspHappnShowroomCrossing: Identifiable, Equatable {
    let id: String
    let name: String
    let place: String
    let timeAgo: String
    let crossCount: Int
    let gradient: [Color]
    var charmed: Bool
    let triggersCrush: Bool
}

private enum LpspHappnShowroomData {
    static let crossings: [LpspHappnShowroomCrossing] = [
        LpspHappnShowroomCrossing(
            id: "camille",
            name: "Camille, 27",
            place: "Le Marais",
            timeAgo: "11 min ago",
            crossCount: 3,
            gradient: [
                Color(red: 0.72, green: 0.42, blue: 0.52),
                Color(red: 0.42, green: 0.22, blue: 0.38),
            ],
            charmed: true,
            triggersCrush: false
        ),
        LpspHappnShowroomCrossing(
            id: "lea",
            name: "Léa, 24",
            place: "Canal Saint-Martin",
            timeAgo: "1 h ago",
            crossCount: 1,
            gradient: [
                Color(red: 0.35, green: 0.55, blue: 0.78),
                Color(red: 0.18, green: 0.32, blue: 0.52),
            ],
            charmed: false,
            triggersCrush: true
        ),
        LpspHappnShowroomCrossing(
            id: "manon",
            name: "Manon, 29",
            place: "République",
            timeAgo: "2 h ago",
            crossCount: 5,
            gradient: [
                Color(red: 0.82, green: 0.58, blue: 0.35),
                Color(red: 0.52, green: 0.32, blue: 0.22),
            ],
            charmed: false,
            triggersCrush: false
        ),
    ]

    static let chats = [
        ("Camille", "Still thinking about Le Marais?", "2h"),
        ("Léa", "Maybe coffee by the canal?", "1d"),
    ]

    static let mapPins: [(x: CGFloat, y: CGFloat, kind: LpspHappnCrossingPin.LpspHappnKind)] = [
        (0.28, 0.32, .standard),
        (0.62, 0.48, .mutual),
        (0.45, 0.68, .ghost),
    ]
}

@MainActor
fileprivate final class LpspHappnStore: ObservableObject {
    @Published var selectedTab: LpspHappnShowroomTab = .timeline
    @Published var crossings: [LpspHappnShowroomCrossing] = LpspHappnShowroomData.crossings
    @Published var showCrush = false
    @Published var crushPartnerName = ""
    @Published var chatText = ""

    func charm(_ crossingID: String) {
        var shouldCrush = false
        var partner = ""

        crossings = crossings.map { crossing in
            guard crossing.id == crossingID, !crossing.charmed else { return crossing }
            var copy = crossing
            copy.charmed = true
            if copy.triggersCrush {
                shouldCrush = true
                partner = copy.name
            }
            return copy
        }

        if shouldCrush {
            crushPartnerName = partner
            showCrush = true
        }
    }

    func setCharmed(_ crossingID: String, charmed: Bool) {
        crossings = crossings.map { crossing in
            guard crossing.id == crossingID else { return crossing }
            var copy = crossing
            copy.charmed = charmed
            return copy
        }
    }

    func dismissCrush() {
        showCrush = false
        crushPartnerName = ""
    }
}

// MARK: - Écrans showroom

private struct LpspHappnShowroomRoot: View {
    @ObservedObject var store: LpspHappnStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .timeline:
                    LpspHappnTimelineTabScreen(store: store)
                case .map:
                    LpspHappnMapTabScreen()
                case .chats:
                    LpspHappnChatsTabScreen(store: store)
                case .profile:
                    LpspHappnShowroomProfileTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspHappnLabeledTabBar(store: store)
        }
        .background(LpspHappnTokens.happnCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $store.showCrush) {
            LpspHappnShowroomCrushScreen(
                partnerName: store.crushPartnerName,
                onStartChat: { store.dismissCrush() }
            )
        }
    }
}

private struct LpspHappnLabeledTabBar: View {
    @ObservedObject var store: LpspHappnStore

    var body: some View {
        HStack {
            ForEach(LpspHappnShowroomTab.allCases) { tab in
                Button {
                    store.selectedTab = tab
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.title)
                            .font(LpspHappnFonts.happnTab.weight(store.selectedTab == tab ? .semibold : .regular))
                    }
                    .foregroundStyle(
                        store.selectedTab == tab
                            ? LpspHappnTokens.happnPink
                            : LpspHappnTokens.happnTextTertiary
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(
            LpspHappnTokens.happnCanvas
                .overlay(
                    Rectangle()
                        .fill(LpspHappnTokens.happnDivider)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}

private struct LpspHappnTimelineTabScreen: View {
    @ObservedObject var store: LpspHappnStore

    var body: some View {
        VStack(spacing: 0) {
            LpspHappnSpectrTopBar()

            LpspHappnTimelineHeader()

            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(store.crossings) { crossing in
                        LpspHappnShowroomCrossingRow(
                            crossing: crossing,
                            onCharm: { store.charm(crossing.id) }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 16)
            }
        }
    }
}

private struct LpspHappnSpectrTopBar: View {
    var body: some View {
        HStack {
            HStack(spacing: 0) {
                Text("happ")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(LpspHappnTokens.happnTextPrimary)
                Text("n")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(LpspHappnTokens.happnPink)
            }

            Spacer()

            Image(systemName: "magnifyingglass")
                .font(.system(size: 22))
                .foregroundStyle(LpspHappnTokens.happnTextPrimary)
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
    }
}

private struct LpspHappnTimelineHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(LpspHappnTokens.happnPink)
                Text("Crossed paths today")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(LpspHappnTokens.happnTextPrimary)
            }

            Text("12 people near you · sorted by latest")
                .font(LpspHappnFonts.happnLocation)
                .foregroundStyle(LpspHappnTokens.happnTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
    }
}

private struct LpspHappnShowroomCrossingRow: View {
    let crossing: LpspHappnShowroomCrossing
    let onCharm: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LpspHappnTokens.happnDivider)
                    .frame(width: 2)
                    .padding(.top, 6)

                Circle()
                    .fill(LpspHappnTokens.happnPink)
                    .frame(width: 12, height: 12)
                    .overlay(
                        Circle()
                            .stroke(LpspHappnTokens.happnPink.opacity(0.18), lineWidth: 4)
                    )
                    .padding(.top, 6)
            }
            .frame(width: 18)

            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: crossing.gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)

                VStack(alignment: .leading, spacing: 3) {
                    Text(crossing.name)
                        .font(LpspHappnFonts.happnCardName.weight(.semibold))
                        .foregroundStyle(LpspHappnTokens.happnTextPrimary)

                    HStack(spacing: 5) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 11))
                            .foregroundStyle(LpspHappnTokens.happnTextTertiary)
                        Text("\(crossing.place) · \(crossing.timeAgo)")
                            .font(LpspHappnFonts.happnLocation)
                            .foregroundStyle(LpspHappnTokens.happnTextSecondary)
                    }

                    Text(crossCountLabel(crossing.crossCount))
                        .font(LpspHappnFonts.happnCount.weight(.semibold))
                        .foregroundStyle(LpspHappnTokens.happnPink)
                }

                Spacer(minLength: 8)

                LpspHappnShowroomCharmButton(charmed: crossing.charmed, onCharm: onCharm)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(LpspHappnTokens.happnSurface1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .strokeBorder(LpspHappnTokens.happnDivider, lineWidth: 1)
                    )
            )
            .padding(.leading, 8)
        }
    }

    private func crossCountLabel(_ count: Int) -> String {
        count == 1 ? "You crossed paths once" : "You crossed paths \(count) times"
    }
}

private struct LpspHappnShowroomCharmButton: View {
    let charmed: Bool
    let onCharm: () -> Void
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Button {
            guard !charmed else { return }
            onCharm()
            scale = 1.25
            withAnimation(.spring(response: 0.28, dampingFraction: 0.55)) { scale = 1.0 }
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } label: {
            Image(systemName: charmed ? "heart.fill" : "heart")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(charmed ? LpspHappnTokens.happnOnPink : LpspHappnTokens.happnTextSecondary)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(charmed ? LpspHappnTokens.happnPink : LpspHappnTokens.happnSurface2)
                )
                .overlay(
                    Circle()
                        .strokeBorder(charmed ? Color.clear : LpspHappnTokens.happnDivider, lineWidth: 1)
                )
                .shadow(
                    color: charmed ? LpspHappnTokens.happnPink.opacity(0.5) : .clear,
                    radius: 8,
                    y: 6
                )
                .scaleEffect(scale)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspHappnShowroomCrushScreen: View {
    let partnerName: String
    let onStartChat: () -> Void
    @State private var together = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.92).ignoresSafeArea()

            VStack(spacing: 28) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [LpspHappnTokens.happnPink, LpspHappnTokens.happnMagenta],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 96, height: 96)
                        .offset(x: together ? -28 : -160)

                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.35, green: 0.55, blue: 0.78),
                                    Color(red: 0.18, green: 0.32, blue: 0.52),
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 96, height: 96)
                        .offset(x: together ? 28 : 160)
                }

                Text("It's a Crush!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(LpspHappnTokens.happnTextPrimary)

                Text("You and \(partnerName) liked each other")
                    .font(LpspHappnFonts.happnBodyMeta)
                    .foregroundStyle(LpspHappnTokens.happnTextSecondary)

                Button(action: onStartChat) {
                    Text("Start chatting")
                        .font(LpspHappnFonts.happnButton.weight(.semibold))
                        .foregroundStyle(LpspHappnTokens.happnOnPink)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 30)
                        .background(Capsule().fill(LpspHappnGradients.happnHero))
                }
                .buttonStyle(.plain)
            }

            LpspHappnSparkleBurst(color: LpspHappnTokens.happnGold)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.36)) { together = true }
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
}

private struct LpspHappnMapTabScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    LpspHappnTokens.happnSurface2,
                    LpspHappnTokens.happnCanvas,
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            GeometryReader { geo in
                ForEach(LpspHappnShowroomData.mapPins.indices, id: \.self) { index in
                    let pin = LpspHappnShowroomData.mapPins[index]
                    LpspHappnCrossingPin(kind: pin.kind)
                        .position(
                            x: geo.size.width * pin.x,
                            y: geo.size.height * pin.y
                        )
                }
            }

            VStack {
                Spacer()
                Text("Crossings near you")
                    .font(LpspHappnFonts.happnBodyMeta)
                    .foregroundStyle(LpspHappnTokens.happnTextSecondary)
                    .padding(.bottom, 16)
            }
        }
    }
}

private struct LpspHappnChatsTabScreen: View {
    @ObservedObject var store: LpspHappnStore

    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(LpspHappnShowroomData.chats.indices, id: \.self) { index in
                    let chat = LpspHappnShowroomData.chats[index]
                    HStack(spacing: 12) {
                        Circle()
                            .fill(LpspHappnGradients.happnHero)
                            .frame(width: 48, height: 48)
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(chat.0)
                                    .font(LpspHappnFonts.happnBody.weight(.semibold))
                                    .foregroundStyle(LpspHappnTokens.happnTextPrimary)
                                Spacer()
                                Text(chat.2)
                                    .font(LpspHappnFonts.happnCaption)
                                    .foregroundStyle(LpspHappnTokens.happnTextTertiary)
                            }
                            Text(chat.1)
                                .font(LpspHappnFonts.happnBodyMeta)
                                .foregroundStyle(LpspHappnTokens.happnTextSecondary)
                                .lineLimit(1)
                        }
                    }
                    .listRowBackground(LpspHappnTokens.happnSurface1)
                }
            }
            .scrollContentBackground(.hidden)
            .background(LpspHappnTokens.happnCanvas)

            HStack {
                TextField("Message", text: $store.chatText)
                    .font(LpspHappnFonts.happnBody)
                    .foregroundStyle(LpspHappnTokens.happnTextPrimary)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LpspHappnTokens.happnSurface2)
                    )
                Button {
                    store.chatText = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundStyle(
                            store.chatText.isEmpty
                                ? LpspHappnTokens.happnTextTertiary
                                : LpspHappnTokens.happnPink
                        )
                }
                .disabled(store.chatText.isEmpty)
            }
            .padding(8)
            .background(LpspHappnTokens.happnSurface1)
        }
    }
}

private struct LpspHappnShowroomProfileTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Circle()
                    .fill(LpspHappnGradients.happnHero)
                    .frame(width: 96, height: 96)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                    }

                Text("Your profile")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(LpspHappnTokens.happnTextPrimary)

                Text("Add photos and let people know when you cross paths")
                    .font(LpspHappnFonts.happnBodyMeta)
                    .foregroundStyle(LpspHappnTokens.happnTextSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                LpspHappnHappnGradientButton(title: "Edit profile", action: {})
                    .padding(.horizontal, 32)
            }
            .padding(.vertical, 32)
        }
    }
}



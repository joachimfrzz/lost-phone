import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/travel/waze/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/waze
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeWazeView: View {
    var body: some View {
        LpspWazeShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspWazeTokens {
    // MARK: - Brand
    static let wazePurple       = Color(red: 0.494, green: 0.333, blue: 0.745)  // #7E55BE
    static let wazePurpleDeep   = Color(red: 0.357, green: 0.235, blue: 0.604)  // #5B3C9A
    static let wazePurpleTint   = Color(red: 0.910, green: 0.871, blue: 0.961)  // #E8DEF5
    static let wazeCyan         = Color(red: 0.200, green: 0.800, blue: 1.000)  // #33CCFF
    static let wazeCyanDeep     = Color(red: 0.000, green: 0.600, blue: 0.898)  // #0099E5

    // MARK: - Hazard Colors
    static let wazePoliceRed    = Color(red: 0.937, green: 0.416, blue: 0.396)  // #EF6A65
    static let wazeTrafficOrng  = Color(red: 0.965, green: 0.596, blue: 0.200)  // #F69833
    static let wazeClosureYel   = Color(red: 0.976, green: 0.769, blue: 0.180)  // #F9C42E
    static let wazeClearedGrn   = Color(red: 0.459, green: 0.780, blue: 0.243)  // #75C73E
    static let wazeHazardBrown  = Color(red: 0.545, green: 0.435, blue: 0.278)  // #8B6F47
    static let wazeCameraGray   = Color(red: 0.420, green: 0.420, blue: 0.420)  // #6B6B6B

    // MARK: - Map Cartography
    static let wazeMapCream     = Color(red: 1.000, green: 0.988, blue: 0.949)  // #FFFCF2
    static let wazeMapWater     = Color(red: 0.608, green: 0.871, blue: 0.937)  // #9BDEEF
    static let wazeMapPark      = Color(red: 0.773, green: 0.910, blue: 0.608)  // #C5E89B
    static let wazeMapRoadMajor = Color(red: 1.000, green: 1.000, blue: 1.000)  // #FFFFFF
    static let wazeMapRoadMinor = Color(red: 0.961, green: 0.941, blue: 0.898)  // #F5F0E5
    static let wazeMapHighway   = Color(red: 1.000, green: 0.851, blue: 0.439)  // #FFD970
    static let wazeMapBuilding  = Color(red: 0.910, green: 0.886, blue: 0.820)  // #E8E2D1

    // MARK: - UI Chrome
    static let wazeCardCanvas   = Color(red: 1.000, green: 1.000, blue: 1.000)  // #FFFFFF
    static let wazeSurfaceGray  = Color(red: 0.961, green: 0.961, blue: 0.969)  // #F5F5F7
    static let wazeSurfaceGray2 = Color(red: 0.918, green: 0.918, blue: 0.925)  // #EAEAEC
    static let wazeDivider      = Color(red: 0.839, green: 0.839, blue: 0.851)  // #D6D6D9

    // MARK: - Text
    static let wazeInk          = Color(red: 0.102, green: 0.102, blue: 0.102)  // #1A1A1A
    static let wazeSecondary    = Color(red: 0.420, green: 0.420, blue: 0.420)  // #6B6B6B
    static let wazeTertiary     = Color(red: 0.627, green: 0.627, blue: 0.627)  // #A0A0A0

    // MARK: - Semantic
    static let wazeSuccess      = Color(red: 0.204, green: 0.780, blue: 0.349)  // #34C759
    static let wazeWarning      = Color(red: 0.976, green: 0.769, blue: 0.180)  // #F9C42E
    static let wazeError        = Color(red: 0.937, green: 0.416, blue: 0.396)  // #EF6A65

    // MARK: - Dark Mode (Night driving)
    static let wazeDarkMapLand  = Color(red: 0.118, green: 0.125, blue: 0.149)  // #1E2026
    static let wazeDarkMapWater = Color(red: 0.059, green: 0.239, blue: 0.369)  // #0F3D5E
    static let wazeDarkMapPark  = Color(red: 0.122, green: 0.227, blue: 0.122)  // #1F3A1F
    static let wazeDarkCardSurf = Color(red: 0.149, green: 0.161, blue: 0.196)  // #262932
    static let wazeDarkSurface2 = Color(red: 0.227, green: 0.239, blue: 0.278)  // #3A3D47
    static let wazeDarkDivider  = Color(red: 0.290, green: 0.302, blue: 0.345)  // #4A4D58
    static let wazePurpleDark   = Color(red: 0.624, green: 0.463, blue: 0.855)  // #9F76DA
    static let wazeCyanDark     = Color(red: 0.365, green: 0.851, blue: 1.000)  // #5DD9FF
}

private enum LpspWazeFonts {
    // Helper for Boing with rounded SF Pro fallback
    static func boing(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        // If Boing is bundled:
        // .custom("Boing-\(weight.boingName)", size: size)
        // Otherwise:
        return .system(size: size, weight: weight, design: .rounded)
    }

    static func boingMono(_ size: CGFloat, weight: Font.Weight = .bold) -> Font {
        .system(size: size, weight: weight, design: .rounded).monospacedDigit()
    }

    // Hero next-turn
    static let wazeHeroStreet     = Font.system(size: 32, weight: .black)
    static let wazeNextTurnDist   = Font.system(size: 28, weight: .bold)
    static let wazeStepTitle      = Font.system(size: 22, weight: .bold)
    static let wazeStepSubtitle   = Font.system(size: 17, weight: .regular)

    // ETA
    static let wazeETATime        = Font.system(size: 24, weight: .bold)
    static let wazeETADistance    = Font.system(size: 17, weight: .medium)

    // Place card
    static let wazePlaceTitle     = Font.system(size: 26, weight: .bold)
    static let wazePlaceSubtitle  = Font.system(size: 15, weight: .regular)

    // Search
    static let wazeSearchPlaceholder = Font.system(size: 17, weight: .regular)
    static let wazeSection        = Font.system(size: 13, weight: .bold)

    // Lists
    static let wazeListTitle      = Font.system(size: 17, weight: .medium)
    static let wazeListSubtitle   = Font.system(size: 13, weight: .regular)

    // Speed
    static let wazeSpeedLimitNum  = Font.system(size: 22, weight: .black)
    static let wazeCurrentSpeed   = Font.system(size: 32, weight: .bold)
    static let wazeSpeedLimitLbl  = Font.system(size: 9, weight: .bold)
    static let wazeMphLabel       = Font.system(size: 11, weight: .regular)

    // Hazard speech bubble
    static let wazeHazardTitle    = Font.system(size: 14, weight: .bold)
    static let wazeHazardTime     = Font.system(size: 11, weight: .regular)

    // Buttons
    static let wazeButton         = Font.system(size: 17, weight: .bold)

    // Misc
    static let wazeCaption        = Font.system(size: 12, weight: .regular)
    static let wazeTab            = Font.system(size: 10, weight: .medium)
}

fileprivate enum LpspWazeHazardType {
    case police, traffic, closure, cleared, pothole, camera

    var color: Color {
        switch self {
        case .police:   return LpspWazeTokens.wazePoliceRed
        case .traffic:  return LpspWazeTokens.wazeTrafficOrng
        case .closure:  return LpspWazeTokens.wazeClosureYel
        case .cleared:  return LpspWazeTokens.wazeClearedGrn
        case .pothole:  return LpspWazeTokens.wazeHazardBrown
        case .camera:   return LpspWazeTokens.wazeCameraGray
        }
    }

    var icon: String {
        switch self {
        case .police:   return "shield.fill"
        case .traffic:  return "cone.fill"
        case .closure:  return "xmark.octagon.fill"
        case .cleared:  return "checkmark.circle.fill"
        case .pothole:  return "exclamationmark.triangle.fill"
        case .camera:   return "camera.fill"
        }
    }

    var title: String {
        switch self {
        case .police:   return "Police"
        case .traffic:  return "Traffic"
        case .closure:  return "Closure"
        case .cleared:  return "Cleared"
        case .pothole:  return "Pothole"
        case .camera:   return "Camera"
        }
    }
}

fileprivate struct LpspWazeHazardSpeechBubble: View {
    let type: LpspWazeHazardType
    let timeAgo: String?
    @State private var appearScale: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: type.icon)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 2) {
                    Text(type.title)
                        .font(LpspWazeFonts.wazeHazardTitle)
                        .foregroundStyle(.white)
                    if let timeAgo = timeAgo {
                        Text(timeAgo)
                            .font(LpspWazeFonts.wazeHazardTime)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous).fill(type.color)
            )

            // Tail (downward triangle)
            LpspWazeHazardTail()
                .fill(type.color)
                .frame(width: 12, height: 8)
        }
        .shadow(color: .black.opacity(0.20), radius: 12, y: 4)
        .scaleEffect(appearScale)
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.55)) {
                appearScale = 1
            }
        }
    }
}

fileprivate struct LpspWazeHazardTail: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

fileprivate struct LpspWazeWazeFAB: View {
    var action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "exclamationmark.bubble.fill")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(
                    Circle().fill(pressed ? LpspWazeTokens.wazePurpleDeep : LpspWazeTokens.wazePurple)
                )
                .shadow(color: LpspWazeTokens.wazePurple.opacity(0.40), radius: 16, y: 6)
                .scaleEffect(pressed ? 0.94 : 1)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .medium), trigger: pressed)
        .pressEvents(onPress: { pressed = true }, onRelease: { pressed = false })
    }
}

fileprivate extension View {
    func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in onPress() }
                .onEnded   { _ in onRelease() }
        )
    }
}

fileprivate struct LpspWazeWazeLocationPuck: View {
    let heading: Double
    @State private var pulse = false

    var body: some View {
        ZStack {
            // Outer pulse
            Circle()
                .fill(LpspWazeTokens.wazeCyan.opacity(pulse ? 0 : 0.15))
                .frame(width: 60, height: 60)
                .scaleEffect(pulse ? 1.5 : 1.0)
                .animation(.easeOut(duration: 2.0).repeatForever(autoreverses: false), value: pulse)

            // Arrow body
            LpspWazeWazeArrowShape()
                .fill(LpspWazeTokens.wazeCyan)
                .frame(width: 32, height: 36)
                .overlay(
                    LpspWazeWazeArrowShape().stroke(Color.white, lineWidth: 3)
                )
                .shadow(color: .black.opacity(0.30), radius: 8, y: 3)
                .rotationEffect(.degrees(heading))
        }
        .onAppear { pulse = true }
    }
}

fileprivate struct LpspWazeWazeArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        // A chunky arrow shape: tip at top, base wider at bottom
        p.move(to: CGPoint(x: w * 0.5, y: 0))               // tip
        p.addLine(to: CGPoint(x: w, y: h * 0.85))           // bottom right
        p.addLine(to: CGPoint(x: w * 0.5, y: h * 0.70))     // V indent
        p.addLine(to: CGPoint(x: 0, y: h * 0.85))           // bottom left
        p.closeSubpath()
        return p
    }
}

fileprivate struct LpspWazeNextTurnCard: View {
    let arrowSymbol: String          // e.g., "arrow.turn.up.right"
    let arrowRotation: Double
    let distance: String             // "0.4 mi"
    let streetName: String           // "Market Street"
    let subInstruction: String?      // "then turn left in 0.6 mi"

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Direction arrow
            Image(systemName: arrowSymbol)
                .font(.system(size: 44, weight: .heavy))
                .foregroundStyle(.white)
                .rotationEffect(.degrees(arrowRotation))
                .frame(width: 64, height: 64)

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(distance)
                    .font(LpspWazeFonts.wazeNextTurnDist)
                    .foregroundStyle(.white)
                Text(streetName)
                    .font(LpspWazeFonts.wazeStepTitle)
                    .foregroundStyle(.white)
                    .lineLimit(2)
                if let sub = subInstruction {
                    Text(sub)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.80))
                }
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(
            UnevenRoundedRectangle(
                cornerRadii: .init(topLeading: 0, bottomLeading: 16, bottomTrailing: 16, topTrailing: 0)
            )
            .fill(LpspWazeTokens.wazePurple)
        )
    }
}

fileprivate struct LpspWazeWazeETABar: View {
    let duration: String       // "12 min"
    let distance: String       // "5.2 mi"
    let arrival: String        // "6:14 PM"
    let alternativeRouteSaves: String?  // "Save 3 min"
    var onEnd: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(duration)
                    .font(LpspWazeFonts.wazeETATime)
                    .foregroundStyle(LpspWazeTokens.wazeInk)
                Text("\(distance) · \(arrival)")
                    .font(LpspWazeFonts.wazeETADistance)
                    .foregroundStyle(LpspWazeTokens.wazeSecondary)
            }

            Spacer()

            if let saves = alternativeRouteSaves {
                Text(saves)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.vertical, 8).padding(.horizontal, 14)
                    .background(Capsule().fill(LpspWazeTokens.wazeClearedGrn))
            }

            Button(action: onEnd) {
                Text("End")
                    .font(LpspWazeFonts.wazeButton)
                    .foregroundStyle(LpspWazeTokens.wazeError)
                    .padding(.vertical, 12).padding(.horizontal, 20)
                    .background(
                        Capsule().fill(LpspWazeTokens.wazeCardCanvas)
                            .overlay(Capsule().stroke(LpspWazeTokens.wazeError, lineWidth: 1.5))
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .frame(height: 80)
        .background(LpspWazeTokens.wazeCardCanvas)
    }
}

fileprivate struct LpspWazeSpeedTile: View {
    let limit: Int             // 35
    let current: Int           // 42
    var isSpeeding: Bool { current > limit }

    var body: some View {
        VStack(spacing: 6) {
            // Speed limit section
            VStack(spacing: 2) {
                Text("SPEED LIMIT")
                    .font(LpspWazeFonts.wazeSpeedLimitLbl)
                    .foregroundStyle(LpspWazeTokens.wazeInk)
                ZStack {
                    Circle()
                        .strokeBorder(LpspWazeTokens.wazeInk, lineWidth: 2)
                        .background(Circle().fill(Color.white))
                        .frame(width: 40, height: 40)
                    Text("\(limit)")
                        .font(LpspWazeFonts.wazeSpeedLimitNum)
                        .foregroundStyle(LpspWazeTokens.wazeInk)
                }
            }

            Divider().padding(.horizontal, 8)

            // Current speed section
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(current)")
                    .font(LpspWazeFonts.wazeCurrentSpeed)
                    .foregroundStyle(isSpeeding ? LpspWazeTokens.wazeError : LpspWazeTokens.wazeInk)
                Text("mph")
                    .font(LpspWazeFonts.wazeMphLabel)
                    .foregroundStyle(LpspWazeTokens.wazeSecondary)
            }
        }
        .padding(.vertical, 8).padding(.horizontal, 8)
        .frame(width: 80)
        .background(
            RoundedRectangle(cornerRadius: 12).fill(LpspWazeTokens.wazeCardCanvas)
        )
        .shadow(color: .black.opacity(0.10), radius: 8, y: 4)
    }
}

fileprivate struct LpspWazeWazeGoButton: View {
    var action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button {
            action()
        } label: {
            Text("Go")
                .font(LpspWazeFonts.wazeButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    Capsule().fill(pressed ? LpspWazeTokens.wazePurpleDeep : LpspWazeTokens.wazePurple)
                )
                .shadow(color: LpspWazeTokens.wazePurple.opacity(0.30), radius: 12, y: 4)
                .scaleEffect(pressed ? 0.97 : 1)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .heavy), trigger: pressed)
        .pressEvents(onPress: { pressed = true }, onRelease: { pressed = false })
    }
}

fileprivate struct LpspWazeAnimatedRoute: Shape {
    var phase: CGFloat = 0
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        // Provide the actual route path here
        Path()
    }
}


fileprivate struct LpspWazeWazerAvatar: View {
    let emoji: String   // 🙂 / 😴 / 🤩 etc.
    @State private var pop: CGFloat = 1

    var body: some View {
        Text(emoji)
            .font(.system(size: 20))
            .frame(width: 24, height: 24)
            .background(Circle().fill(Color.white))
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .scaleEffect(pop)
            .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
            .onTapGesture {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                    pop = 1.2
                }
                withAnimation(.spring(response: 0.4).delay(0.15)) {
                    pop = 1.0
                }
            }
    }
}

// MARK: - Écrans showroom

private struct LpspWazeShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspWazeGenericTabScreen(title: "Carte", tabIndex: 0)
                .tabItem { Label("Carte", systemImage: "map.fill") }
                .tag(0)
            LpspWazeGenericTabScreen(title: "Itinéraire", tabIndex: 1)
                .tabItem { Label("Itinéraire", systemImage: "arrow.triangle.turn.up.right.diamond") }
                .tag(1)
            LpspWazeGenericTabScreen(title: "Profil", tabIndex: 2)
                .tabItem { Label("Profil", systemImage: "person") }
                .tag(2)
        }
        .tint(LpspWazeTokens.wazePoliceRed)
        
    }
}


private struct LpspWazeGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspWazeTokens.wazePoliceRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspWazeTokens.wazePoliceRed))
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


private struct LpspWazeMessagingTabScreen: View {
    let title: String
    var body: some View { LpspWazeGenericTabScreen(title: title, tabIndex: 0) }
}



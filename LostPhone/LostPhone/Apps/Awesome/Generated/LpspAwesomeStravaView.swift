import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/fitness/strava/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/strava
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeStravaView: View {
    var body: some View {
        LpspStravaShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspStravaTokens {
    // MARK: - Strava Orange — the only accent
    static let stravaOrange        = Color(red: 0.988, green: 0.298, blue: 0.008)  // #FC4C02
    static let stravaOrangePressed = Color(red: 0.831, green: 0.251, blue: 0.008)  // #D44002
    static let stravaOrangeHalo    = Color(red: 0.988, green: 0.298, blue: 0.008).opacity(0.3)

    // MARK: - Canvas, Surface, Divider (Light)
    static let stravaCanvas       = Color(red: 1.00, green: 1.00, blue: 1.00)     // #FFFFFF
    static let stravaSurfaceWarm  = Color(red: 0.961, green: 0.957, blue: 0.949)  // #F5F4F2
    static let stravaSurfaceCool  = Color(red: 0.941, green: 0.941, blue: 0.941)  // #F0F0F0
    static let stravaDivider      = Color(red: 0.898, green: 0.898, blue: 0.898)  // #E5E5E5
    static let stravaMapTile      = Color(red: 0.910, green: 0.898, blue: 0.867)  // #E8E5DD

    // MARK: - Text (Light)
    static let stravaInkPrimary   = Color(red: 0.055, green: 0.055, blue: 0.055)  // #0E0E0E
    static let stravaInkSecondary = Color(red: 0.400, green: 0.400, blue: 0.400)  // #666666
    static let stravaInkTertiary  = Color(red: 0.604, green: 0.604, blue: 0.604)  // #9A9A9A

    // MARK: - Dark mode
    static let stravaDarkCanvas   = Color(red: 0.059, green: 0.059, blue: 0.059)  // #0F0F0F coal
    static let stravaDarkSurface  = Color(red: 0.102, green: 0.102, blue: 0.102)  // #1A1A1A
    static let stravaDarkSurface2 = Color(red: 0.149, green: 0.149, blue: 0.149)  // #262626
    static let stravaDarkDivider  = Color(red: 0.165, green: 0.165, blue: 0.165)  // #2A2A2A
    static let stravaDarkText     = Color(red: 0.949, green: 0.949, blue: 0.949)  // #F2F2F2
    static let stravaDarkTextSec  = Color(red: 0.627, green: 0.627, blue: 0.627)  // #A0A0A0
    static let stravaDarkMapTile  = Color(red: 0.106, green: 0.106, blue: 0.106)  // #1B1B1B

    // MARK: - Achievement
    static let stravaPRGold       = Color(red: 0.961, green: 0.761, blue: 0.290)  // #F5C24A
    static let stravaSilver       = Color(red: 0.776, green: 0.776, blue: 0.776)  // #C6C6C6
    static let stravaBronze       = Color(red: 0.804, green: 0.498, blue: 0.196)  // #CD7F32
    static let stravaKOMCrown     = Color(red: 1.00, green: 0.843, blue: 0.00)    // #FFD700

    // MARK: - Chart & Semantic
    static let stravaSuccess      = Color(red: 0.133, green: 0.773, blue: 0.369)  // #22C55E
    static let stravaHeartRed     = Color(red: 0.906, green: 0.298, blue: 0.235)  // #E74C3C
    static let stravaPaceBlue     = Color(red: 0.231, green: 0.510, blue: 0.965)  // #3B82F6
    static let stravaElevBrown    = Color(red: 0.545, green: 0.435, blue: 0.278)  // #8B6F47
}

private enum LpspStravaFonts {
    // Hero stats (activity detail) — SF Pro Display Black
    static let stravaHeroStat   = Font.system(size: 44, weight: .black)
    static let stravaHeroUnit   = Font.system(size: 13, weight: .semibold)

    // Large nav title
    static let stravaLargeNav   = Font.system(size: 28, weight: .bold)

    // Activity card titles & athlete names
    static let stravaActivityTitle = Font.system(size: 17, weight: .semibold)
    static let stravaAthlete    = Font.system(size: 15, weight: .semibold)

    // Section / stat label — UPPERCASE 11pt Semibold
    static let stravaStatLabel  = Font.system(size: 11, weight: .semibold)
    static let stravaSectionHdr = Font.system(size: 13, weight: .bold)

    // Stat values (the 3-up grid)
    static let stravaStatValue  = Font.system(size: 17, weight: .bold)

    // Body
    static let stravaBody       = Font.system(size: 15, weight: .regular)
    static let stravaBodySmall  = Font.system(size: 13, weight: .regular)

    // Kudos / counts / metadata
    static let stravaKudosCount = Font.system(size: 13, weight: .semibold)
    static let stravaMeta       = Font.system(size: 13, weight: .regular)

    // Buttons
    static let stravaButton     = Font.system(size: 17, weight: .semibold)
    static let stravaButtonSm   = Font.system(size: 15, weight: .semibold)

    // Tab & rank
    static let stravaTab        = Font.system(size: 10, weight: .semibold)
    static let stravaRank       = Font.system(size: 13, weight: .black)
}

fileprivate struct LpspStravaStatCell: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(label.uppercased())
                .font(LpspStravaFonts.stravaStatLabel)
                .tracking(0.6)
                .foregroundStyle(LpspStravaTokens.stravaInkSecondary)
            Text(value)
                .font(LpspStravaFonts.stravaStatValue)
                .foregroundStyle(LpspStravaTokens.stravaInkPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
    }
}

fileprivate struct LpspStravaStatGrid: View {
    let stats: [(String, String)]   // up to 3
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(stats.enumerated()), id: \.offset) { idx, s in
                LpspStravaStatCell(label: s.0, value: s.1)
                if idx < stats.count - 1 {
                    Rectangle().fill(LpspStravaTokens.stravaSurfaceCool).frame(width: 1).padding(.vertical, 12)
                }
            }
        }
    }
}

import MapKit

fileprivate struct LpspStravaRouteMapSnapshot: View {
    let coordinates: [CLLocationCoordinate2D]

    var body: some View {
        ZStack {
            Map {
                // Halo polyline drawn first
                MapPolyline(coordinates: coordinates)
                    .stroke(LpspStravaTokens.stravaOrangeHalo, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                // Main polyline drawn on top
                MapPolyline(coordinates: coordinates)
                    .stroke(LpspStravaTokens.stravaOrange, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))

                // Start / end markers
                if let start = coordinates.first {
                    Annotation("", coordinate: start) {
                        Circle().fill(.white).overlay(Circle().strokeBorder(LpspStravaTokens.stravaOrange, lineWidth: 2)).frame(width: 12, height: 12)
                    }
                }
                if let end = coordinates.last {
                    Annotation("", coordinate: end) {
                        Circle().fill(LpspStravaTokens.stravaOrange).overlay(Circle().strokeBorder(.white, lineWidth: 2)).frame(width: 12, height: 12)
                    }
                }
            }
            .mapStyle(.standard(elevation: .flat))
        }
        .aspectRatio(16/9, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

fileprivate struct LpspStravaKudosButton: View {
    @Binding var kudosCount: Int
    @State private var hasGivenKudos = false
    @State private var emitConfetti = false

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                hasGivenKudos.toggle()
                kudosCount += hasGivenKudos ? 1 : -1
            }
            emitConfetti = hasGivenKudos
        } label: {
            HStack(spacing: 6) {
                Image(systemName: hasGivenKudos ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(hasGivenKudos ? LpspStravaTokens.stravaOrange : LpspStravaTokens.stravaInkSecondary)
                    .scaleEffect(hasGivenKudos ? 1.0 : 1.0)
                Text("\(kudosCount)")
                    .font(LpspStravaFonts.stravaKudosCount)
                    .foregroundStyle(LpspStravaTokens.stravaInkPrimary)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 8)
            .contentShape(Rectangle())
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: hasGivenKudos)
        .overlay {
            if emitConfetti { LpspStravaConfettiBurst().allowsHitTesting(false) }
        }
    }
}

fileprivate struct LpspStravaConfettiBurst: View {
    @State private var rise = false
    var body: some View {
        ZStack {
            ForEach(0..<8) { i in
                Circle().fill(LpspStravaTokens.stravaOrange)
                    .frame(width: 4, height: 4)
                    .offset(x: cos(Double(i) * .pi / 4) * (rise ? 30 : 0),
                            y: sin(Double(i) * .pi / 4) * (rise ? -30 : 0))
                    .opacity(rise ? 0 : 1)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) { rise = true }
        }
    }
}

fileprivate struct LpspStravaActivityCard: View {
    let athleteAvatar: Image
    let athleteName: String
    let timestamp: String
    let activityTitle: String
    let routeCoords: [CLLocationCoordinate2D]
    let distance: String
    let elapsed: String
    let pace: String
    @State private var kudosCount: Int

    init(athleteAvatar: Image, athleteName: String, timestamp: String, activityTitle: String,
         routeCoords: [CLLocationCoordinate2D], distance: String, elapsed: String, pace: String,
         kudosCount: Int) {
        self.athleteAvatar = athleteAvatar
        self.athleteName = athleteName
        self.timestamp = timestamp
        self.activityTitle = activityTitle
        self.routeCoords = routeCoords
        self.distance = distance
        self.elapsed = elapsed
        self.pace = pace
        self._kudosCount = State(initialValue: kudosCount)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 12) {
                athleteAvatar.resizable().scaledToFill()
                    .frame(width: 40, height: 40).clipShape(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text(athleteName).font(LpspStravaFonts.stravaAthlete).foregroundStyle(LpspStravaTokens.stravaInkPrimary)
                    Text(timestamp).font(LpspStravaFonts.stravaMeta).foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                }
                Spacer()
                Image(systemName: "figure.run").font(.system(size: 18)).foregroundStyle(LpspStravaTokens.stravaOrange)
            }

            // Title
            Text(activityTitle).font(LpspStravaFonts.stravaActivityTitle).foregroundStyle(LpspStravaTokens.stravaInkPrimary)

            // Map snapshot
            LpspStravaRouteMapSnapshot(coordinates: routeCoords)

            // 3-up stat grid
            LpspStravaStatGrid(stats: [("Distance", distance), ("Time", elapsed), ("Pace", pace)])

            Divider().background(LpspStravaTokens.stravaDivider)

            // Kudos + comments + view
            HStack(spacing: 16) {
                LpspStravaKudosButton(kudosCount: $kudosCount)
                HStack(spacing: 6) {
                    Image(systemName: "bubble.left").font(.system(size: 16)).foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                    Text("12").font(LpspStravaFonts.stravaKudosCount).foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                }
                Spacer()
                Text("View Activity").font(LpspStravaFonts.stravaButtonSm).foregroundStyle(LpspStravaTokens.stravaOrange)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(LpspStravaTokens.stravaCanvas)
    }
}

fileprivate struct LpspStravaRecordButton: View {
    var onRecord: () -> Void
    var body: some View {
        Button {
            onRecord()
        } label: {
            Image(systemName: "record.circle")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(LpspStravaTokens.stravaOrange))
                .shadow(color: LpspStravaTokens.stravaOrange.opacity(0.4), radius: 8, y: 8)
        }
        .sensoryFeedback(.impact(weight: .heavy), trigger: UUID())
        .offset(y: -8)  // protrudes 8pt above the tab bar
    }
}

fileprivate struct LpspStravaLeaderboardRow: View {
    let rank: Int
    let avatar: Image
    let name: String
    let date: String
    let time: String
    let gap: String

    var rankBg: Color {
        switch rank {
        case 1: return LpspStravaTokens.stravaPRGold
        case 2: return LpspStravaTokens.stravaSilver
        case 3: return LpspStravaTokens.stravaBronze
        default: return LpspStravaTokens.stravaSurfaceCool
        }
    }
    var rankFg: Color {
        rank <= 3 ? .white : LpspStravaTokens.stravaInkPrimary
    }

    var body: some View {
        HStack(spacing: 12) {
            Text("\(rank)")
                .font(LpspStravaFonts.stravaRank)
                .foregroundStyle(rankFg)
                .frame(width: 32, height: 32)
                .background(Circle().fill(rankBg))
            avatar.resizable().scaledToFill().frame(width: 36, height: 36).clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text(name).font(LpspStravaFonts.stravaAthlete).foregroundStyle(LpspStravaTokens.stravaInkPrimary)
                Text(date).font(LpspStravaFonts.stravaMeta).foregroundStyle(LpspStravaTokens.stravaInkSecondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(time).font(LpspStravaFonts.stravaStatValue).foregroundStyle(LpspStravaTokens.stravaInkPrimary)
                Text(gap).font(LpspStravaFonts.stravaMeta).foregroundStyle(LpspStravaTokens.stravaInkSecondary)
            }
        }
        .padding(.horizontal, 16).frame(height: 56)
        .overlay(alignment: .bottom) {
            Rectangle().fill(LpspStravaTokens.stravaDivider).frame(height: 0.5)
        }
    }
}

fileprivate struct LpspStravaAchievementBadge: View {
    let icon: String     // e.g. "trophy.fill" / "figure.run.circle.fill"
    let text: String     // e.g. "1 PR"
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon).font(.system(size: 14)).foregroundStyle(LpspStravaTokens.stravaOrange)
            Text(text).font(LpspStravaFonts.stravaKudosCount).foregroundStyle(LpspStravaTokens.stravaInkPrimary)
        }
        .padding(.vertical, 4).padding(.horizontal, 10)
        .background(Capsule().fill(LpspStravaTokens.stravaOrange.opacity(0.08)))
    }
}



// MARK: - Écrans showroom

private struct LpspStravaShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspStravaGenericTabScreen(title: "Home", tabIndex: 0)
                .tabItem { Label("Home", systemImage: "house") }
                .tag(0)
            LpspStravaGenericTabScreen(title: "Maps", tabIndex: 1)
                .tabItem { Label("Maps", systemImage: "map") }
                .tag(1)
            LpspStravaGenericTabScreen(title: "Groups", tabIndex: 2)
                .tabItem { Label("Groups", systemImage: "person.3") }
                .tag(2)
        }
        .tint(LpspStravaTokens.stravaHeartRed)
        .preferredColorScheme(.dark)
    }
}


private struct LpspStravaGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspStravaTokens.stravaHeartRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspStravaTokens.stravaHeartRed))
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


private struct LpspStravaMessagingTabScreen: View {
    let title: String
    var body: some View { LpspStravaGenericTabScreen(title: title, tabIndex: 0) }
}



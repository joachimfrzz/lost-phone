import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/strava
// Meliwat/awesome-ios-design-md/fitness/strava/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeStravaView: View {
    var body: some View {
        LpspStravaShowroomRoot(store: LpspStravaStore())
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
                .monospacedDigit()
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
                        Circle().fill(.white).overlay(Circle().stroke(LpspStravaTokens.stravaOrange, lineWidth: 2)).frame(width: 12, height: 12)
                    }
                }
                if let end = coordinates.last {
                    Annotation("", coordinate: end) {
                        Circle().fill(LpspStravaTokens.stravaOrange).overlay(Circle().stroke(.white, lineWidth: 2)).frame(width: 12, height: 12)
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
                    .monospacedDigit()
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
    let athleteInitials: String
    let athleteName: String
    let timestamp: String
    let activityTitle: String
    let routeCoords: [CLLocationCoordinate2D]
    let distance: String
    let elapsed: String
    let pace: String
    let commentCount: Int
    let badges: [(icon: String, text: String)]
    @Binding var kudosCount: Int
    var onViewActivity: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Circle()
                    .fill(LpspStravaTokens.stravaSurfaceCool)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(athleteInitials)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(LpspStravaTokens.stravaInkPrimary)
                    )
                VStack(alignment: .leading, spacing: 2) {
                    Text(athleteName).font(LpspStravaFonts.stravaAthlete).foregroundStyle(LpspStravaTokens.stravaInkPrimary)
                    Text(timestamp).font(LpspStravaFonts.stravaMeta).foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                }
                Spacer()
                Image(systemName: "figure.run").font(.system(size: 18)).foregroundStyle(LpspStravaTokens.stravaOrange)
            }

            Text(activityTitle).font(LpspStravaFonts.stravaActivityTitle).foregroundStyle(LpspStravaTokens.stravaInkPrimary)

            if !badges.isEmpty {
                HStack(spacing: 8) {
                    ForEach(badges, id: \.text) { badge in
                        LpspStravaAchievementBadge(icon: badge.icon, text: badge.text)
                    }
                }
            }

            LpspStravaRouteMapSnapshot(coordinates: routeCoords)

            LpspStravaStatGrid(stats: [("Distance", distance), ("Time", elapsed), ("Pace", pace)])

            Divider().background(LpspStravaTokens.stravaDivider)

            HStack(spacing: 16) {
                LpspStravaKudosButton(kudosCount: $kudosCount)
                HStack(spacing: 6) {
                    Image(systemName: "bubble.left").font(.system(size: 16)).foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                    Text("\(commentCount)")
                        .font(LpspStravaFonts.stravaKudosCount)
                        .foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                        .monospacedDigit()
                }
                Spacer()
                Button(action: onViewActivity) {
                    Text("View Activity")
                        .font(LpspStravaFonts.stravaButtonSm)
                        .foregroundStyle(LpspStravaTokens.stravaOrange)
                }
                .buttonStyle(.plain)
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



// MARK: - Données & état (showroom Lost Phone)

fileprivate struct LpspStravaBadge: Hashable {
    let icon: String
    let text: String
}

fileprivate struct LpspStravaActivity: Identifiable {
    let id: String
    let athleteInitials: String
    let athleteName: String
    let timestamp: String
    let title: String
    let sportIcon: String
    let routeCoords: [CLLocationCoordinate2D]
    let distance: String
    let elapsed: String
    let pace: String
    var kudosCount: Int
    let commentCount: Int
    let badges: [LpspStravaBadge]
    let heroDistance: String
    let heroElapsed: String
    let heroPace: String
}

fileprivate struct LpspStravaClub: Identifiable {
    let id: String
    let name: String
    let members: Int
    let subtitle: String
}

private enum LpspStravaTab: CaseIterable {
    case home, maps, groups, you

    var label: String {
        switch self {
        case .home: "Home"
        case .maps: "Maps"
        case .groups: "Groups"
        case .you: "You"
        }
    }

    var icon: String {
        switch self {
        case .home: "house"
        case .maps: "map"
        case .groups: "person.3"
        case .you: "person.crop.circle"
        }
    }
}

@MainActor
fileprivate final class LpspStravaStore: ObservableObject {
    @Published var selectedTab: LpspStravaTab = .home
    @Published var activities: [LpspStravaActivity]
    @Published var selectedActivityID: String?
    @Published var showRecording = false
    @Published var recordingElapsed = 0

    let clubs: [LpspStravaClub] = LpspStravaShowroomData.clubs
    let userName = "Mathieu G."
    let weeklyDistance = "12.4 km"
    let weeklyTime = "1h 05m"

    private var recordingTask: Task<Void, Never>?

    init() {
        self.activities = LpspStravaShowroomData.activities
    }

    var selectedActivity: LpspStravaActivity? {
        guard let selectedActivityID else { return nil }
        return activities.first { $0.id == selectedActivityID }
    }

    func kudosBinding(for activityID: String) -> Binding<Int> {
        Binding(
            get: { self.activities.first { $0.id == activityID }?.kudosCount ?? 0 },
            set: { newValue in
                guard let index = self.activities.firstIndex(where: { $0.id == activityID }) else { return }
                self.activities[index].kudosCount = newValue
            }
        )
    }

    func openActivity(_ id: String) {
        selectedActivityID = id
    }

    func startRecording() {
        showRecording = true
        recordingElapsed = 0
        recordingTask?.cancel()
        recordingTask = Task { @MainActor in
            while !Task.isCancelled, showRecording {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                recordingElapsed += 1
            }
        }
    }

    func stopRecording() {
        showRecording = false
        recordingTask?.cancel()
        selectedTab = .home
    }

    static func formatRecordingTime(_ seconds: Int) -> String {
        String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}

private enum LpspStravaShowroomData {
    static let defaultActivityID = "casey-boston-run"

    static let bostonRoute: [CLLocationCoordinate2D] = [
        .init(latitude: 42.3601, longitude: -71.0589),
        .init(latitude: 42.3625, longitude: -71.0550),
        .init(latitude: 42.3650, longitude: -71.0510),
        .init(latitude: 42.3675, longitude: -71.0470),
        .init(latitude: 42.3700, longitude: -71.0430),
    ]

    static let seineRoute: [CLLocationCoordinate2D] = [
        .init(latitude: 48.8530, longitude: 2.3499),
        .init(latitude: 48.8550, longitude: 2.3520),
        .init(latitude: 48.8570, longitude: 2.3545),
        .init(latitude: 48.8590, longitude: 2.3570),
    ]

    static let gennevilliersRoute: [CLLocationCoordinate2D] = [
        .init(latitude: 48.9330, longitude: 2.2950),
        .init(latitude: 48.9310, longitude: 2.3000),
        .init(latitude: 48.9290, longitude: 2.3050),
        .init(latitude: 48.9270, longitude: 2.3100),
    ]

    static let activities: [LpspStravaActivity] = [
        .init(
            id: "casey-boston-run",
            athleteInitials: "CR",
            athleteName: "Casey Reardon",
            timestamp: "2 hours ago · Boston, MA",
            title: "Tuesday Morning Run",
            sportIcon: "figure.run",
            routeCoords: bostonRoute,
            distance: "8.2 mi",
            elapsed: "1:14:23",
            pace: "9:03 /mi",
            kudosCount: 27,
            commentCount: 12,
            badges: [
                .init(icon: "trophy.fill", text: "1 PR"),
                .init(icon: "figure.run.circle.fill", text: "3 Best Efforts"),
            ],
            heroDistance: "8.2",
            heroElapsed: "1:14:23",
            heroPace: "9:03"
        ),
        .init(
            id: "mathieu-seine",
            athleteInitials: "MG",
            athleteName: "Mathieu G.",
            timestamp: "Yesterday · Paris 11e",
            title: "Evening Run – Seine loop",
            sportIcon: "figure.run",
            routeCoords: seineRoute,
            distance: "6.4 km",
            elapsed: "32:18",
            pace: "5:02 /km",
            kudosCount: 8,
            commentCount: 2,
            badges: [],
            heroDistance: "6.4",
            heroElapsed: "32:18",
            heroPace: "5:02"
        ),
        .init(
            id: "sam-gennevilliers",
            athleteInitials: "SV",
            athleteName: "Sam V.",
            timestamp: "Monday · Gennevilliers",
            title: "Ride to transfer point",
            sportIcon: "figure.outdoor.cycle",
            routeCoords: gennevilliersRoute,
            distance: "14.2 km",
            elapsed: "41:05",
            pace: "22.1 km/h",
            kudosCount: 15,
            commentCount: 4,
            badges: [.init(icon: "bolt.fill", text: "Fastest Time")],
            heroDistance: "14.2",
            heroElapsed: "41:05",
            heroPace: "22.1"
        ),
        .init(
            id: "nadia-louvre-jog",
            athleteInitials: "NB",
            athleteName: "Nadia B.",
            timestamp: "Sunday · Paris 1er",
            title: "Morning jog – Palais Royal",
            sportIcon: "figure.run",
            routeCoords: [
                .init(latitude: 48.8630, longitude: 2.3360),
                .init(latitude: 48.8610, longitude: 2.3380),
                .init(latitude: 48.8590, longitude: 2.3400),
            ],
            distance: "4.1 km",
            elapsed: "24:52",
            pace: "6:04 /km",
            kudosCount: 19,
            commentCount: 6,
            badges: [],
            heroDistance: "4.1",
            heroElapsed: "24:52",
            heroPace: "6:04"
        ),
    ]

    static let clubs: [LpspStravaClub] = [
        .init(id: "eventscult", name: "EventsCult Running", members: 12, subtitle: "Private · brief S7 prep"),
        .init(id: "night-owls", name: "Paris Night Owls", members: 847, subtitle: "Evening routes · Seine"),
        .init(id: "louvre-loop", name: "Louvre Loop Crew", members: 203, subtitle: "Segment hunters"),
    ]
}

// MARK: - Écrans showroom

private struct LpspStravaShowroomRoot: View {
    @ObservedObject var store: LpspStravaStore

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Group {
                    switch store.selectedTab {
                    case .home:
                        LpspStravaHomeScreen(store: store)
                    case .maps:
                        LpspStravaMapsScreen(store: store)
                    case .groups:
                        LpspStravaGroupsScreen(store: store)
                    case .you:
                        LpspStravaYouScreen(store: store)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                LpspStravaTabBar(store: store)
            }

            if store.showRecording {
                LpspStravaRecordingOverlay(store: store)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.85), value: store.showRecording)
        .sheet(item: Binding(
            get: { store.selectedActivity.map { LpspStravaActivitySheetID(id: $0.id) } },
            set: { store.selectedActivityID = $0?.id }
        )) { wrapper in
            if let activity = store.activities.first(where: { $0.id == wrapper.id }) {
                LpspStravaActivityDetailSheet(activity: activity)
            }
        }
    }
}

private struct LpspStravaActivitySheetID: Identifiable {
    let id: String
}

private struct LpspStravaTabBar: View {
    @ObservedObject var store: LpspStravaStore

    var body: some View {
        HStack(spacing: 0) {
            tabButton(.home)
            tabButton(.maps)

            LpspStravaRecordButton {
                store.startRecording()
            }
            .frame(maxWidth: .infinity)

            tabButton(.groups)
            tabButton(.you)
        }
        .padding(.top, 4)
        .padding(.bottom, 4)
        .background(LpspStravaTokens.stravaCanvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspStravaTokens.stravaDivider).frame(height: 0.5)
        }
    }

    private func tabButton(_ tab: LpspStravaTab) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
        } label: {
            VStack(spacing: 2) {
                Image(systemName: tab.icon)
                    .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                Text(tab.label)
                    .font(LpspStravaFonts.stravaTab)
            }
            .foregroundStyle(store.selectedTab == tab ? LpspStravaTokens.stravaOrange : LpspStravaTokens.stravaInkSecondary)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: store.selectedTab)
    }
}

private struct LpspStravaHomeScreen: View {
    @ObservedObject var store: LpspStravaStore

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 1) {
                    ForEach(store.activities) { activity in
                        LpspStravaActivityCard(
                            athleteInitials: activity.athleteInitials,
                            athleteName: activity.athleteName,
                            timestamp: activity.timestamp,
                            activityTitle: activity.title,
                            routeCoords: activity.routeCoords,
                            distance: activity.distance,
                            elapsed: activity.elapsed,
                            pace: activity.pace,
                            commentCount: activity.commentCount,
                            badges: activity.badges.map { (icon: $0.icon, text: $0.text) },
                            kudosCount: store.kudosBinding(for: activity.id),
                            onViewActivity: { store.openActivity(activity.id) }
                        )
                        Divider().background(LpspStravaTokens.stravaDivider)
                    }
                }
            }
            .background(LpspStravaTokens.stravaSurfaceWarm.ignoresSafeArea())
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

private struct LpspStravaMapsScreen: View {
    @ObservedObject var store: LpspStravaStore

    var body: some View {
        ZStack {
            LpspStravaTokens.stravaDarkCanvas.ignoresSafeArea()
            Map {
                if let activity = store.activities.first(where: { $0.id == LpspStravaShowroomData.defaultActivityID }) {
                    MapPolyline(coordinates: activity.routeCoords)
                        .stroke(LpspStravaTokens.stravaOrangeHalo, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    MapPolyline(coordinates: activity.routeCoords)
                        .stroke(LpspStravaTokens.stravaOrange, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                }
            }
            .mapStyle(.standard(elevation: .flat))

            VStack {
                Text("Explore routes near you")
                    .font(LpspStravaFonts.stravaSectionHdr)
                    .foregroundStyle(LpspStravaTokens.stravaDarkText)
                    .padding(.top, 60)
                Spacer()
            }
        }
    }
}

private struct LpspStravaGroupsScreen: View {
    @ObservedObject var store: LpspStravaStore

    var body: some View {
        NavigationStack {
            List(store.clubs) { club in
                VStack(alignment: .leading, spacing: 4) {
                    Text(club.name)
                        .font(LpspStravaFonts.stravaActivityTitle)
                    Text("\(club.members.formatted()) members · \(club.subtitle)")
                        .font(LpspStravaFonts.stravaMeta)
                        .foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Groups")
        }
    }
}

private struct LpspStravaYouScreen: View {
    @ObservedObject var store: LpspStravaStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Circle()
                        .fill(LpspStravaTokens.stravaOrange.opacity(0.15))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Text("MG")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(LpspStravaTokens.stravaOrange)
                        )

                    Text(store.userName)
                        .font(LpspStravaFonts.stravaLargeNav)

                    VStack(spacing: 0) {
                        Text("THIS WEEK")
                            .font(LpspStravaFonts.stravaStatLabel)
                            .tracking(0.6)
                            .foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.top, 12)

                        LpspStravaStatGrid(stats: [
                            ("Distance", store.weeklyDistance),
                            ("Time", store.weeklyTime),
                            ("Activities", "3"),
                        ])
                    }
                    .background(LpspStravaTokens.stravaCanvas)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text("Recent Activities")
                        .font(LpspStravaFonts.stravaSectionHdr)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(store.activities.filter { $0.athleteInitials == "MG" }) { activity in
                        Button { store.openActivity(activity.id) } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(activity.title)
                                        .font(LpspStravaFonts.stravaActivityTitle)
                                        .foregroundStyle(LpspStravaTokens.stravaInkPrimary)
                                    Text(activity.timestamp)
                                        .font(LpspStravaFonts.stravaMeta)
                                        .foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                                }
                                Spacer()
                                Text(activity.distance)
                                    .font(LpspStravaFonts.stravaStatValue)
                                    .foregroundStyle(LpspStravaTokens.stravaOrange)
                                    .monospacedDigit()
                            }
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(16)
            }
            .background(LpspStravaTokens.stravaSurfaceWarm.ignoresSafeArea())
            .navigationTitle("You")
        }
    }
}

private struct LpspStravaActivityDetailSheet: View {
    let activity: LpspStravaActivity
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(activity.title)
                        .font(LpspStravaFonts.stravaActivityTitle)

                    LpspStravaRouteMapSnapshot(coordinates: activity.routeCoords)

                    HStack(spacing: 24) {
                        heroStat(value: activity.heroDistance, unit: activity.distance.contains("mi") ? "mi" : "km", label: "Distance")
                        heroStat(value: activity.heroElapsed, unit: "", label: "Time")
                        heroStat(value: activity.heroPace, unit: activity.pace.contains("/mi") ? "/mi" : activity.pace.contains("km/h") ? "km/h" : "/km", label: "Pace")
                    }
                    .frame(maxWidth: .infinity)

                    if !activity.badges.isEmpty {
                        HStack(spacing: 8) {
                            ForEach(activity.badges, id: \.text) { badge in
                                LpspStravaAchievementBadge(icon: badge.icon, text: badge.text)
                            }
                        }
                    }
                }
                .padding(16)
            }
            .background(LpspStravaTokens.stravaCanvas)
            .navigationTitle(activity.athleteName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(LpspStravaTokens.stravaOrange)
                }
            }
        }
    }

    private func heroStat(value: String, unit: String, label: String) -> some View {
        VStack(spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(LpspStravaFonts.stravaHeroStat)
                    .foregroundStyle(LpspStravaTokens.stravaInkPrimary)
                    .monospacedDigit()
                if !unit.isEmpty {
                    Text(unit)
                        .font(LpspStravaFonts.stravaHeroUnit)
                        .foregroundStyle(LpspStravaTokens.stravaInkSecondary)
                }
            }
            Text(label.uppercased())
                .font(LpspStravaFonts.stravaStatLabel)
                .tracking(0.6)
                .foregroundStyle(LpspStravaTokens.stravaInkSecondary)
        }
    }
}

private struct LpspStravaRecordingOverlay: View {
    @ObservedObject var store: LpspStravaStore

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text(LpspStravaStore.formatRecordingTime(store.recordingElapsed))
                .font(LpspStravaFonts.stravaHeroStat)
                .foregroundStyle(.white)
                .monospacedDigit()

            Text("Recording Run")
                .font(LpspStravaFonts.stravaBody)
                .foregroundStyle(LpspStravaTokens.stravaDarkTextSec)

            Button {
                store.stopRecording()
            } label: {
                Text("Finish")
                    .font(LpspStravaFonts.stravaButton)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(RoundedRectangle(cornerRadius: 8).fill(LpspStravaTokens.stravaOrange))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LpspStravaTokens.stravaDarkCanvas.opacity(0.96).ignoresSafeArea())
    }
}

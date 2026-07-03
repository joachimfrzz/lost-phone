import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/video/disney-plus/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/disney-plus
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeDisneyView: View {
    var body: some View {
        LpspDisneyShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspDisneyFonts {
    static let dpBillboard  = Font.system(size: 30, weight: .regular)
    static let dpDetailTitle = Font.system(size: 26, weight: .regular)
    static let dpSection    = Font.system(size: 20, weight: .regular)
    static let dpRowHeader  = Font.system(size: 18, weight: .regular)
    static let dpCardTitle  = Font.system(size: 14, weight: .regular)
    static let dpSynopsis   = Font.system(size: 15, weight: .regular)
    static let dpMetaStrip  = Font.system(size: 13, weight: .regular)
    static let dpSubtitle   = Font.system(size: 14, weight: .regular)
    static let dpMeta       = Font.system(size: 12, weight: .regular)
    static let dpBadge      = Font.system(size: 10, weight: .regular)
    static let dpButton     = Font.system(size: 16, weight: .regular)
    static let dpButtonSec  = Font.system(size: 14, weight: .regular)
    static let dpTab        = Font.system(size: 10, weight: .regular)
    static func dp(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspDisneyTokens {
    // MARK: - Canvas & Surfaces
    static let dpCanvas   = Color(red: 0.039, green: 0.055, blue: 0.165) // #0A0E2A
    static let dpSurface1 = Color(red: 0.071, green: 0.082, blue: 0.180) // #12152E
    static let dpSurface2 = Color(red: 0.102, green: 0.122, blue: 0.239) // #1A1F3D
    static let dpDivider  = Color(red: 0.165, green: 0.188, blue: 0.314) // #2A3050

    // MARK: - Text
    static let dpTextPrimary   = Color.white                                 // #FFFFFF
    static let dpTextSecondary = Color(red: 0.627, green: 0.651, blue: 0.753) // #A0A6C0
    static let dpTextTertiary  = Color(red: 0.353, green: 0.376, blue: 0.502) // #5A6080

    // MARK: - Brand
    static let dpBlue        = Color(red: 0.0,   green: 0.388, blue: 0.898) // #0063E5
    static let dpGlowBlue    = Color(red: 0.102, green: 0.459, blue: 1.0)   // #1A75FF
    static let dpBluePressed = Color(red: 0.0,   green: 0.322, blue: 0.741) // #0052BD
    static let dpLiveRed     = Color(red: 0.898, green: 0.282, blue: 0.302) // #E5484D
}

extension ShapeStyle where Self == Color {
    static var dpFocusGlow: Color { Color(red: 0.102, green: 0.459, blue: 1.0).opacity(0.30) }
}





private struct LpspDisneyDPPlayButton: View {
    let label: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill")
                Text(label).font(LpspDisneyFonts.dpButton).tracking(0.3)
            }
            .foregroundStyle(Color.dpCanvas) // dark glyph on white
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: label)
        .buttonStyle(LpspDisneyDPPressable())
    }
}

private struct LpspDisneyDPSecondaryButton: View {
    let icon: String
    let label: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(label).font(LpspDisneyFonts.dpButtonSec)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.12)))
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.white.opacity(0.24), lineWidth: 1))
        }
        .buttonStyle(LpspDisneyDPPressable())
    }
}

private struct LpspDisneyDPPressable: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

private struct LpspDisneyBrandPortalTile: View {
    let logo: Image
    let gradient: [Color]          // brand-tinted
    @State private var focused = false

    var body: some View {
        logo
            .resizable().scaledToFit()
            .padding(20)
            .frame(width: 160, height: 96)
            .background(
                LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(focused ? Color.dpGlowBlue : Color.dpDivider,
                                  lineWidth: focused ? 2 : 1)
            )
            .scaleEffect(focused ? 1.04 : 1)
            .shadow(color: focused ? Color.dpGlowBlue.opacity(0.35) : .clear, radius: 24)
            .animation(.easeOut(duration: 0.18), value: focused)
            .onTapGesture { /* open universe hub */ }
            .onLongPressGesture(minimumDuration: 0, pressing: { focused = $0 }, perform: {})
    }
}

// Reusable focus modifier — the unified Disney+ selection language
private struct LpspDisneyDPFocusable: ViewModifier {
    @State private var focused = false
    func body(content: Content) -> some View {
        content
            .scaleEffect(focused ? 1.04 : 1)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(focused ? Color.dpGlowBlue : .clear, lineWidth: 2)
            )
            .shadow(color: focused ? Color.dpFocusGlow : .clear, radius: 24)
            .animation(.easeOut(duration: 0.18), value: focused)
            .onLongPressGesture(minimumDuration: 0, pressing: { focused = $0 }, perform: {})
    }
}
extension View { func dpFocusable() -> some View { modifier(LpspDisneyDPFocusable()) } }

private struct LpspDisneyContentCard16x9: View {
    let keyArt: Image
    var progress: Double? = nil    // continue-watching

    var body: some View {
        ZStack(alignment: .bottom) {
            keyArt
                .resizable().aspectRatio(16/9, contentMode: .fill)
                .frame(width: 220, height: 124)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            if let p = progress {
                VStack {
                    Spacer()
                    GeometryReader { g in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.white.opacity(0.25))
                            Rectangle().fill(Color.dpBlue).frame(width: g.size.width * p)
                        }
                    }
                    .frame(height: 3)
                }
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .frame(width: 220, height: 124)
        .dpFocusable()
    }
}

private struct LpspDisneyEpisodeRow: View {
    let thumb: Image
    let title: String              // "E4 · The Siege"
    let synopsis: String
    let runtime: String
    var progress: Double? = nil

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .bottom) {
                thumb.resizable().aspectRatio(16/9, contentMode: .fill)
                    .frame(width: 160, height: 90).clipShape(RoundedRectangle(cornerRadius: 6))
                Image(systemName: "play.circle.fill").font(.system(size: 28)).foregroundStyle(.white.opacity(0.9))
                if let p = progress {
                    VStack { Spacer()
                        GeometryReader { g in
                            ZStack(alignment: .leading) {
                                Rectangle().fill(Color.white.opacity(0.25))
                                Rectangle().fill(Color.dpBlue).frame(width: g.size.width * p)
                            }
                        }.frame(height: 3)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(LpspDisneyFonts.dpCardTitle).foregroundStyle(.white)
                Text(synopsis).font(.custom("AvenirNext-Regular", size: 13)).foregroundStyle(.dpTextSecondary).lineLimit(2)
                Text(runtime).font(LpspDisneyFonts.dpMeta).foregroundStyle(.dpTextSecondary).monospacedDigit()
            }
            Spacer(minLength: 4)
            Image(systemName: "arrow.down.circle").font(.system(size: 22)).foregroundStyle(.dpTextSecondary)
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color.dpSurface1))
    }
}

private struct LpspDisneyRootTabView: View {
    init() {
        let a = UITabBarAppearance()
        a.configureWithTransparentBackground()
        a.backgroundEffect = UIBlurEffect(style: .systemMaterialDark)
        a.backgroundColor = UIColor(Color.dpCanvas).withAlphaComponent(0.96)
        UITabBar.appearance().standardAppearance = a
        UITabBar.appearance().scrollEdgeAppearance = a
    }
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            SearchView().tabItem { Label("Search", systemImage: "magnifyingglass") }
            WatchlistView().tabItem { Label("Watchlist", systemImage: "plus.rectangle.on.rectangle") }
            DownloadsView().tabItem { Label("Downloads", systemImage: "arrow.down.circle") }
            ProfileView().tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
        .tint(.white) // active = white; #0063E5 used as a dot indicator overlay
        .preferredColorScheme(.dark)
    }
}

// MARK: - Écrans showroom

private struct LpspDisneyShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspDisneyVideoHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspDisneyVideoHomeTabScreen()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
            LpspDisneyProfilePickerTabScreen()
                .tabItem { Label("Watchlist", systemImage: "plus.rectangle.on.rectangle") }
                .tag(2)
            LpspDisneyVideoHomeTabScreen()
                .tabItem { Label("Downloads", systemImage: "arrow.down.circle") }
                .tag(3)
            LpspDisneyProfilePickerTabScreen()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(4)
        }
        .tint(LpspDisneyTokens.dpLiveRed)
        .preferredColorScheme(.dark)
    }
}


private struct LpspDisneyGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspDisneyTokens.dpLiveRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspDisneyTokens.dpLiveRed))
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


private struct LpspDisneyDemoProfile: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let isKids: Bool
}

private enum LpspDisneyDemoProfiles {
    static let items: [LpspDisneyDemoProfile] = [
        .init(name: "Lost Phone", color: .red, isKids: false),
        .init(name: "Enfants", color: .orange, isKids: true),
    ]
}

private struct LpspDisneyVideoHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.08, green: 0.08, blue: 0.08), Color.black],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 220)
                            .overlay(alignment: .center) {
                                Image(systemName: "play.circle.fill").font(.system(size: 56)).foregroundStyle(.white.opacity(0.9))
                            }
                        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                            .frame(height: 80)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding(.horizontal, 12)
                    LpspDisneyDPPlayButton(title: "Lecture", action: {})
                        .padding(.horizontal, 12)
                    Text("Tendances").font(.system(size: 17, weight: .bold)).foregroundStyle(.white).padding(.horizontal, 12)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(0..<6, id: \.self) { i in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                                    .frame(width: 110, height: 165)
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .padding(.vertical, 8)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("")
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

private struct LpspDisneyProfilePickerTabScreen: View {
    var body: some View {
        LpspDisneyDemoProfilePicker()
    }
}

private struct LpspDisneyDemoProfilePicker: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Qui regarde ?").font(.system(size: 32, weight: .bold)).foregroundStyle(.white)
                ForEach(LpspDisneyDemoProfiles.items) { p in
                    VStack(spacing: 8) {
                        Circle().fill(p.color).frame(width: 72, height: 72)
                        Text(p.name).foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}



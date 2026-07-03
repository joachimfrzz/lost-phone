import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/video/apple-tv/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/apple-tv
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAppleTVView: View {
    var body: some View {
        LpspAppleTVShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspAppleTVTokens {
    static let atvCanvas    = Color.black                                     // #000000
    static let atvSurface1  = Color(red: 0.110, green: 0.110, blue: 0.118)   // #1C1C1E
    static let atvSurface2  = Color(red: 0.173, green: 0.173, blue: 0.180)   // #2C2C2E
    static let atvDivider   = Color(red: 0.220, green: 0.220, blue: 0.227)   // #38383A
    static let atvTextPrimary   = Color.white                                 // #FFFFFF
    static let atvTextSecondary = Color(red: 0.596, green: 0.596, blue: 0.624) // #98989F
    static let atvTextTertiary  = Color(red: 0.388, green: 0.388, blue: 0.400) // #636366
    static let atvCTA        = Color.white                                    // #FFFFFF
    static let atvCTAPressed = Color(red: 0.898, green: 0.898, blue: 0.918)   // #E5E5EA
    static let atvCTALabel   = Color.black                                    // #000000
    static let atvBlue        = Color(red: 0.039, green: 0.518, blue: 1.000)  // #0A84FF
    static let atvBluePressed = Color(red: 0.000, green: 0.376, blue: 0.875)  // #0060DF
    static let atvMLS     = Color(red: 0.929, green: 0.102, blue: 0.435)      // #ED1A6F (MLS only)
    static let atvLive    = Color(red: 1.000, green: 0.271, blue: 0.227)      // #FF453A
    static let atvSuccess = Color(red: 0.188, green: 0.820, blue: 0.345)      // #30D158
    static let atvGold    = Color(red: 1.000, green: 0.839, blue: 0.039)      // #FFD60A
    static let atvGlassFill = Color(red: 0.471, green: 0.471, blue: 0.502).opacity(0.36)
}





private enum LpspAppleTVGradients {
    /// Hero card bottom scrim.
    static let atvHeroScrim = LinearGradient(
        stops: [
            .init(color: .clear,                location: 0.40),
            .init(color: .black.opacity(0.65),  location: 0.72),
            .init(color: .black.opacity(0.92),  location: 1.0),
        ],
        startPoint: .top, endPoint: .bottom
    )
}

private enum LpspAppleTVFonts {
    // Prefer system styles on iOS — they ARE SF Pro with optical sizing + Dynamic Type
    static let atvLargeTitle = Font.system(size: 34, weight: .heavy)
    static let atvHeroTitle  = Font.system(size: 28, weight: .heavy)
    static let atvRowHeader  = Font.system(size: 22, weight: .bold)
    static let atvTitle3     = Font.system(size: 20, weight: .semibold)
    static let atvBody       = Font.system(size: 17, weight: .regular)
    static let atvHeadline   = Font.system(size: 15, weight: .semibold)
    static let atvSubhead    = Font.system(size: 13, weight: .regular)
    static let atvCaption    = Font.system(size: 12, weight: .medium)
    static let atvEyebrow    = Font.system(size: 11, weight: .bold)
    static let atvButton     = Font.system(size: 15, weight: .semibold)
    static let atvChannelTag = Font.system(size: 9, weight: .bold)

    // Non-Apple build (Inter substitute):
    // static let atvLargeTitle = Font.custom("Inter-ExtraBold", size: 34)
}

// Eyebrow modifier — 11pt uppercase tracked, secondary
private struct LpspAppleTVATVEyebrow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(LpspAppleTVFonts.atvEyebrow)
            .tracking(1.2)
            .textCase(.uppercase)
            .foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
    }
}
extension View { func atvEyebrow() -> some View { modifier(LpspAppleTVATVEyebrow()) } }

private struct LpspAppleTVHeroCard: View {
    let artURL: URL?
    let eyebrow: String        // "Apple TV+ · New Episode"
    let title: String
    let meta: String
    let onPlay: () -> Void
    let onAdd: () -> Void

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: artURL) { img in
                img.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle().fill(LpspAppleTVTokens.atvSurface1)
            }
            .frame(height: 380)
            .clipped()

            LpspAppleTVGradients.atvHeroScrim

            VStack(alignment: .leading, spacing: 7) {
                Text(eyebrow).atvEyebrow()
                Text(title).font(LpspAppleTVFonts.atvHeroTitle).foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
                Text(meta).font(LpspAppleTVFonts.atvCaption).foregroundStyle(LpspAppleTVTokens.atvTextSecondary)
                HStack(spacing: 10) {
                    Button(action: onPlay) {
                        Label("Play", systemImage: "play.fill")
                            .font(LpspAppleTVFonts.atvButton)
                            .foregroundStyle(LpspAppleTVTokens.atvCTALabel)
                            .padding(.vertical, 13).padding(.horizontal, 30)
                            .background(LpspAppleTVTokens.atvCTA, in: RoundedRectangle(cornerRadius: 12))
                    }
                    Button(action: onAdd) {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                }
                .padding(.top, 7)
            }
            .padding(18)
        }
        .frame(height: 380)
        .clipShape(RoundedRectangle(cornerRadius: 16))   // inset + rounded = floating gallery
        .padding(.horizontal, 14)
    }
}

private struct LpspAppleTVUpNextThumb: View {
    let artURL: URL?
    let title: String
    let subhead: String       // "S3 E8 · 24 min left"
    var progress: Double = 0  // 0...1; 0 hides the bar
    var channelTag: String? = "Apple TV+"
    @State private var pressed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: artURL) { $0.resizable().aspectRatio(contentMode: .fill) }
                    placeholder: { Rectangle().fill(LpspAppleTVTokens.atvSurface1) }
                    .frame(width: 196, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                if let channelTag {
                    Text(channelTag)
                        .font(LpspAppleTVFonts.atvChannelTag).tracking(0.4)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6).padding(.vertical, 3)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
                        .padding(8)
                }
                if progress > 0 {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.white.opacity(0.28))
                            Rectangle().fill(Color.white).frame(width: geo.size.width * progress)
                        }
                        .frame(height: 4)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                    .frame(width: 196, height: 110)
                }
            }
            Text(title).font(LpspAppleTVFonts.atvHeadline).foregroundStyle(LpspAppleTVTokens.atvTextPrimary).lineLimit(1)
            Text(subhead).font(LpspAppleTVFonts.atvSubhead).foregroundStyle(LpspAppleTVTokens.atvTextSecondary).lineLimit(1)
        }
        .frame(width: 196)
        .scaleEffect(pressed ? 0.97 : 1)
        .animation(.easeOut(duration: 0.12), value: pressed)
        ._onButtonGesture { pressed = $0 } perform: {}
    }
}

private struct LpspAppleTVLiveBadge: View {
    @State private var dim = false
    var body: some View {
        HStack(spacing: 6) {
            Circle().fill(.white).frame(width: 7, height: 7)
                .opacity(dim ? 0.4 : 1)
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: dim)
            Text("LIVE").font(LpspAppleTVFonts.atvEyebrow).tracking(0.6).foregroundStyle(.white)
        }
        .padding(.horizontal, 10).padding(.vertical, 5)
        .background(LpspAppleTVTokens.atvLive, in: RoundedRectangle(cornerRadius: 6))
        .onAppear { dim = true }
    }
}

private struct LpspAppleTVMLSChip: View {
    let title: String   // "MLS Season Pass"
    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(.white)
            .padding(.horizontal, 14).padding(.vertical, 7)
            .background(LpspAppleTVTokens.atvMLS, in: RoundedRectangle(cornerRadius: 10)) // the ONLY non-system color
    }
}

private struct LpspAppleTVShelfHeader: View {
    let title: String
    var accessory: AnyView? = nil
    var body: some View {
        HStack(spacing: 8) {
            Text(title).font(LpspAppleTVFonts.atvRowHeader).foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
            if let accessory { accessory }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(LpspAppleTVTokens.atvTextTertiary)
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 10)
    }
}

private struct LpspAppleTVAppleTVTabView: View {
    init() {
        let a = UITabBarAppearance()
        a.configureWithDefaultBackground()             // translucent blur material
        a.backgroundColor = UIColor.black.withAlphaComponent(0.92)
        a.shadowColor = UIColor(LpspAppleTVTokens.atvDivider)
        UITabBar.appearance().standardAppearance = a
        UITabBar.appearance().scrollEdgeAppearance = a
    }

    var body: some View {
        TabView {
            WatchNowView().tabItem { Label("Watch Now", systemImage: "play.tv") }
            TVPlusView().tabItem { Label("TV+", systemImage: "play.rectangle.on.rectangle") }
            StoreView().tabItem { Label("Store", systemImage: "bag") }
            SearchView().tabItem { Label("Search", systemImage: "magnifyingglass") }
        }
        .tint(LpspAppleTVTokens.atvBlue)   // active = system blue; standard iOS color+fill swap, no pill
    }
}

private struct LpspAppleTVAppleTVTheme: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LpspAppleTVTokens.atvCanvas)            // pure #000000
            .foregroundStyle(LpspAppleTVTokens.atvTextPrimary)
            .preferredColorScheme(.dark)            // browse is always true-black
    }
}
extension View { func appleTVTheme() -> some View { modifier(LpspAppleTVAppleTVTheme()) } }

// MARK: - Écrans showroom

private struct LpspAppleTVShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspAppleTVProfilePickerTabScreen()
                .tabItem { Label("Watch Now", systemImage: "play.tv") }
                .tag(0)
            LpspAppleTVVideoHomeTabScreen()
                .tabItem { Label("TV+", systemImage: "play.rectangle.on.rectangle") }
                .tag(1)
            LpspAppleTVVideoHomeTabScreen()
                .tabItem { Label("Store", systemImage: "bag") }
                .tag(2)
            LpspAppleTVVideoHomeTabScreen()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(3)
        }
        .tint(LpspAppleTVTokens.atvTextPrimary)
        .preferredColorScheme(.dark)
    }
}


private struct LpspAppleTVGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspAppleTVTokens.atvTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspAppleTVTokens.atvTextPrimary))
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


private struct LpspAppleTVDemoProfile: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let isKids: Bool
}

private enum LpspAppleTVDemoProfiles {
    static let items: [LpspAppleTVDemoProfile] = [
        .init(name: "Lost Phone", color: .red, isKids: false),
        .init(name: "Enfants", color: .orange, isKids: true),
    ]
}

private struct LpspAppleTVVideoHomeTabScreen: View {
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
                    Button("Lecture") {}.buttonStyle(.borderedProminent).tint(.red)
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

private struct LpspAppleTVProfilePickerTabScreen: View {
    var body: some View {
        LpspAppleTVDemoProfilePicker()
    }
}

private struct LpspAppleTVDemoProfilePicker: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Qui regarde ?").font(.system(size: 32, weight: .bold)).foregroundStyle(.white)
                ForEach(LpspAppleTVDemoProfiles.items) { p in
                    VStack(spacing: 8) {
                        Circle().fill(p.color).frame(width: 72, height: 72)
                        Text(p.name).foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}



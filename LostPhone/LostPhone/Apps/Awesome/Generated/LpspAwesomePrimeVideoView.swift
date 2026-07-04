import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/prime-video
// Meliwat/awesome-ios-design-md/video/prime-video/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePrimeVideoView: View {
    var body: some View {
        LpspPrimeVideoShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspPrimeVideoFonts {
    static let primeDetailsTitle = Font.system(size: 30, weight: .regular)
    static let primeTitleLarge   = Font.system(size: 28, weight: .regular)
    static let primeRowHeader    = Font.system(size: 22, weight: .regular)
    static let primeSectionHeader = Font.system(size: 20, weight: .regular)
    static let primeEpisodeTitle = Font.system(size: 16, weight: .regular)
    static let primeTileTitle    = Font.system(size: 15, weight: .regular)
    static let primeBody         = Font.system(size: 15, weight: .regular)
    static let primeMeta         = Font.system(size: 13, weight: .regular)
    static let primeTileSubtitle = Font.system(size: 12, weight: .regular)
    static let primeLabelUpper   = Font.system(size: 11, weight: .regular)
    static let primeButton       = Font.system(size: 16, weight: .regular)
    static let primeButtonSecondary = Font.system(size: 15, weight: .regular)
    static let primeTab          = Font.system(size: 10, weight: .regular)
    static let primeBadge        = Font.system(size: 11, weight: .regular)
    static func prime(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspPrimeVideoTokens {
    // MARK: - Canvas & Surfaces
    static let primeCanvas    = Color(red: 0.059, green: 0.090, blue: 0.118) // #0F171E
    static let primeDeepBlack = Color.black                                  // #000000
    static let primeSurface1  = Color(red: 0.102, green: 0.141, blue: 0.184) // #1A242F
    static let primeSurface2  = Color(red: 0.137, green: 0.184, blue: 0.243) // #232F3E
    static let primeSurface3  = Color(red: 0.180, green: 0.231, blue: 0.278) // #2E3B47
    static let primeDivider   = Color(red: 0.180, green: 0.231, blue: 0.278) // #2E3B47

    // MARK: - Text
    static let primeTextPrimary   = Color.white                                // #FFFFFF
    static let primeTextSecondary = Color(red: 0.667, green: 0.718, blue: 0.769) // #AAB7C4
    static let primeTextTertiary  = Color(red: 0.431, green: 0.482, blue: 0.537) // #6E7B89

    // MARK: - Brand
    static let primeBlue        = Color(red: 0.000, green: 0.659, blue: 0.882) // #00A8E1
    static let primeBluePressed = Color(red: 0.000, green: 0.549, blue: 0.741) // #008CBD
    static let primeImdbYellow  = Color(red: 0.961, green: 0.773, blue: 0.094) // #F5C518
    static let primeLiveRed     = Color(red: 0.898, green: 0.035, blue: 0.078) // #E50914
}





fileprivate struct LpspPrimeVideoPrimePlayButton: View {
    var title: String = "Play"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill").font(.system(size: 18, weight: .bold))
                Text(title).font(LpspPrimeVideoFonts.primeButton).tracking(0.2)
            }
            .foregroundStyle(LpspPrimeVideoTokens.primeCanvas) // intentional: dark-navy on bright blue
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(RoundedRectangle(cornerRadius: 8).fill(LpspPrimeVideoTokens.primeBlue))
            .shadow(color: LpspPrimeVideoTokens.primeBlue.opacity(0.32), radius: 24, y: 8)
        }
        .sensoryFeedback(.impact(weight: .light), trigger: title)
        .buttonStyle(LpspPrimeVideoPrimePressableStyle(pressedScale: 0.97))
    }
}

fileprivate struct LpspPrimeVideoPrimePressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspPrimeVideoPrimeWatchlistButton: View {
    @Binding var added: Bool
    @State private var bump = false

    var body: some View {
        Button {
            added.toggle()
            bump = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: added ? "checkmark" : "plus")
                    .font(.system(size: 16, weight: .bold))
                Text(added ? "Watchlisted" : "Watchlist").font(LpspPrimeVideoFonts.primeButtonSecondary)
            }
            .foregroundStyle(added ? LpspPrimeVideoTokens.primeBlue : .white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.14)))
            .scaleEffect(bump ? 1.15 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: bump)
        }
        .sensoryFeedback(.success, trigger: added)
        .onChange(of: bump) { _, v in if v { DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { bump = false } } }
        .buttonStyle(LpspPrimeVideoPrimePressableStyle())
    }
}

fileprivate struct LpspPrimeVideoPrimeContentTile: View {
    let title: String
    let artwork: Image
    var includedWithPrime: Bool = false
    var progress: Double? = nil
    let width: CGFloat
    var aspect: CGFloat = 2/3

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .bottom) {
                artwork
                    .resizable()
                    .aspectRatio(aspect, contentMode: .fill)
                    .frame(width: width, height: width / aspect)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                if let progress {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.white.opacity(0.25))
                            Rectangle().fill(LpspPrimeVideoTokens.primeBlue).frame(width: geo.size.width * progress)
                        }
                    }
                    .frame(height: 3)
                }
            }
            Text(title).font(LpspPrimeVideoFonts.primeTileTitle).foregroundStyle(.white).lineLimit(1)
            if includedWithPrime {
                Text("Included with Prime")
                    .font(LpspPrimeVideoFonts.primeTileSubtitle)
                    .foregroundStyle(LpspPrimeVideoTokens.primeBlue)
            }
        }
        .frame(width: width)
    }
}

fileprivate struct LpspPrimeVideoPrimeBillboard: View {
    let title: String
    let metaLeading: String   // "2024 · 16+ · 1 Season · "
    let imdb: String          // "★ 8.4 IMDb"
    let still: Image
    let onPlay: () -> Void
    @Binding var watchlisted: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            still
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 440)
                .clipped()
            LinearGradient(colors: [.clear, LpspPrimeVideoTokens.primeCanvas], startPoint: .center, endPoint: .bottom)

            VStack(alignment: .leading, spacing: 12) {
                Text(title).font(LpspPrimeVideoFonts.primeDetailsTitle).foregroundStyle(.white)
                (Text(metaLeading).foregroundColor(LpspPrimeVideoTokens.primeTextSecondary)
                 + Text(imdb).foregroundColor(LpspPrimeVideoTokens.primeImdbYellow))
                .font(LpspPrimeVideoFonts.primeMeta)
                HStack(spacing: 12) {
                    LpspPrimeVideoPrimePlayButton(action: onPlay).frame(width: 130)
                    LpspPrimeVideoPrimeWatchlistButton(added: $watchlisted).frame(width: 150)
                }
            }
            .padding(16)
        }
        .frame(height: 440)
        .background(LpspPrimeVideoTokens.primeCanvas)
    }
}

fileprivate struct LpspPrimeVideoPrimeXRayOverlay: View {
    let cast: [LpspPrimeVideoCastMember]   // headshot + name + role
    let nowPlaying: String?
    @Binding var shown: Bool

    var body: some View {
        VStack {
            Spacer()
            if shown {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("IN THIS SCENE").font(LpspPrimeVideoFonts.primeLabelUpper)
                            .foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary).tracking(0.6)
                        Spacer()
                        Button { withAnimation(.easeOut(duration: 0.28)) { shown = false } } label: {
                            Image(systemName: "chevron.down").foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary)
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(cast) { m in
                                VStack(spacing: 6) {
                                    m.headshot.resizable().frame(width: 56, height: 56).clipShape(Circle())
                                    Text(m.name).font(LpspPrimeVideoFonts.primeTileSubtitle).foregroundStyle(.white)
                                    Text(m.role).font(LpspPrimeVideoFonts.primeTileSubtitle).foregroundStyle(LpspPrimeVideoTokens.primeTextSecondary)
                                }
                                .frame(width: 80)
                            }
                        }
                    }
                    if let nowPlaying {
                        HStack(spacing: 8) {
                            Image(systemName: "music.note").foregroundStyle(LpspPrimeVideoTokens.primeBlue)
                            Text("Now playing: \(nowPlaying)").font(LpspPrimeVideoFonts.primeMeta).foregroundStyle(.white)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                .background(LpspPrimeVideoTokens.primeSurface2.opacity(0.96))
                .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
                .transition(.move(edge: .bottom))
            }
        }
    }
}

fileprivate struct LpspPrimeVideoCastMember: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    var headshot: Image { Image(systemName: "person.circle.fill") }
}


// MARK: - Écrans showroom

private struct LpspPrimeVideoShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspPrimeVideoSpectrHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspPrimeVideoVideoHomeTabScreen()
                .tabItem { Label("Store", systemImage: "bag.fill") }
                .tag(1)
            LpspPrimeVideoVideoHomeTabScreen()
                .tabItem { Label("Live", systemImage: "dot.radiowaves.left.and.right") }
                .tag(2)
            LpspPrimeVideoVideoHomeTabScreen()
                .tabItem { Label("Find", systemImage: "magnifyingglass") }
                .tag(3)
            LpspPrimeVideoVideoDownloadsTabScreen()
                .tabItem { Label("Downloads", systemImage: "arrow.down.circle.fill") }
                .tag(4)
        }
        .tint(LpspPrimeVideoTokens.primeImdbYellow)
        .preferredColorScheme(.dark)
    }
}


private struct LpspPrimeVideoGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspPrimeVideoTokens.primeImdbYellow.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspPrimeVideoTokens.primeImdbYellow))
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


private struct LpspPrimeVideoDemoPosterURLs {
    static let items: [URL] = [
        URL(string: "https://picsum.photos/seed/nfx1/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx2/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx3/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx4/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx5/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx6/200/300")!,
    ]
}
private struct LpspPrimeVideoDemoProfile: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let isKids: Bool
}

private enum LpspPrimeVideoDemoProfiles {
    static let items: [LpspPrimeVideoDemoProfile] = [
        .init(name: "Lost Phone", color: .red, isKids: false),
        .init(name: "Enfants", color: .orange, isKids: true),
    ]
}

private struct LpspPrimeVideoVideoHomeTabScreen: View {
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
                    LpspPrimeVideoPrimePlayButton(title: "Lecture", action: {})
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

private struct LpspPrimeVideoProfilePickerTabScreen: View {
    var body: some View {
        LpspPrimeVideoDemoProfilePicker()
    }
}

private struct LpspPrimeVideoVideoNewTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    Text("Nouveautés").font(.title2.bold()).foregroundStyle(.white).padding(.horizontal, 12)
                }
                .padding(.vertical, 8)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("New & Hot")
        }
    }
}

private struct LpspPrimeVideoVideoDownloadsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Stranger Things S4E1", "The Crown S6E2"], id: \.self) { title in
                HStack {
                    RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.3)).frame(width: 80, height: 120)
                    VStack(alignment: .leading) {
                        Text(title).font(.headline).foregroundStyle(.white)
                        Text("Téléchargé").font(.caption).foregroundStyle(.secondary)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Downloads")
        }
    }
}

private struct LpspPrimeVideoDemoProfilePicker: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Qui regarde ?").font(.system(size: 32, weight: .bold)).foregroundStyle(.white)
                ForEach(LpspPrimeVideoDemoProfiles.items) { p in
                    VStack(spacing: 8) {
                        Circle().fill(p.color).frame(width: 72, height: 72)
                        Text(p.name).foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}


private struct LpspPrimeVideoSpectrHomeTabScreen: View {
    var body: some View {
        LpspPrimeVideoVideoHomeTabScreen()
    }
}



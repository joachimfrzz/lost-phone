import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/music/apple-music/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/apple-music
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeAppleMusicView: View {
    var body: some View {
        LpspAppleMusicShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspAppleMusicTokens {
    // MARK: - Brand
    static let amRed         = Color(red: 0.980, green: 0.176, blue: 0.282) // #FA2D48
    static let amCoral       = Color(red: 0.988, green: 0.235, blue: 0.267) // #FC3C44
    static let amRedPressed  = Color(red: 0.831, green: 0.129, blue: 0.231) // #D4213B

    // MARK: - Canvas
    static let amCanvasLight   = Color.white                                  // #FFFFFF
    static let amCanvasDark    = Color.black                                  // #000000
    static let amSurface1Light = Color(red: 0.949, green: 0.949, blue: 0.969) // #F2F2F7
    static let amSurface1Dark  = Color(red: 0.110, green: 0.110, blue: 0.118) // #1C1C1E
    static let amSurface2Dark  = Color(red: 0.173, green: 0.173, blue: 0.180) // #2C2C2E
    static let amSurface3Dark  = Color(red: 0.227, green: 0.227, blue: 0.235) // #3A3A3C
    static let amDividerLight  = Color(red: 0.776, green: 0.776, blue: 0.784) // #C6C6C8
    static let amDividerDark   = Color(red: 0.220, green: 0.220, blue: 0.227) // #38383A

    // MARK: - Badges
    static let amAtmosGold     = Color(red: 0.831, green: 0.659, blue: 0.341) // #D4A857
    static let amLosslessSilver = Color(red: 0.557, green: 0.557, blue: 0.576) // #8E8E93

    // MARK: - iOS system colors (prefer native when possible)
    static let amSystemBlue    = Color(red: 0.0,   green: 0.478, blue: 1.0)   // #007AFF
    static let amSystemGreen   = Color(red: 0.204, green: 0.780, blue: 0.349) // #34C759
    static let amSystemRed     = Color(red: 1.0,   green: 0.231, blue: 0.188) // #FF3B30
}

private enum LpspAppleMusicFonts {
    // Display (SF Pro Display — 20pt+ automatic)
    static let amLargeTitle    = Font.system(size: 34, weight: .bold)
    static let amTitle1        = Font.system(size: 28, weight: .bold)
    static let amHeroListen    = Font.system(size: 24, weight: .bold)
    static let amTitle2        = Font.system(size: 22, weight: .bold)
    static let amTitle3        = Font.system(size: 20, weight: .semibold)
    static let amNowPlaying    = Font.system(size: 18, weight: .semibold)

    // Text (SF Pro Text)
    static let amHeadline      = Font.system(size: 17, weight: .regular)
    static let amBody          = Font.system(size: 17, weight: .regular)
    static let amCallout       = Font.system(size: 17, weight: .regular)
    static let amSubheadline   = Font.system(size: 17, weight: .regular)
    static let amFootnote      = Font.system(size: 17, weight: .regular)
    static let amCaption1      = Font.system(size: 17, weight: .regular)
    static let amCaption2      = Font.system(size: 17, weight: .regular)

    static let amButton        = Font.system(size: 17, weight: .semibold)
    static let amTabLabel      = Font.system(size: 10, weight: .medium)

    static let amLyricsCurrent = Font.system(size: 28, weight: .bold)
    static let amLyricsOther   = Font.system(size: 22, weight: .semibold)
}

fileprivate struct LpspAppleMusicApplePlayButton: View {
    let isPlaying: Bool
    var size: CGFloat = 64
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: size * 0.44, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: size, height: size)
                .background(Circle().fill(LpspAppleMusicTokens.amRed))
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isPlaying)
        .buttonStyle(LpspAppleMusicAMPressableStyle(pressedScale: 0.92))
    }
}

fileprivate struct LpspAppleMusicAMPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.75), value: configuration.isPressed)
    }
}

fileprivate struct LpspAppleMusicAMPillButton: View {
    let title: String
    let systemIcon: String
    var tint: Color = LpspAppleMusicTokens.amRed
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemIcon)
                    .font(.system(size: 15, weight: .bold))
                Text(title)
                    .font(LpspAppleMusicFonts.amButton)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            .background(RoundedRectangle(cornerRadius: 8).fill(tint))
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: title)
        .buttonStyle(LpspAppleMusicAMPressableStyle())
    }
}

fileprivate struct LpspAppleMusicAlbumTile: View {
    let artworkURL: URL
    let title: String
    let subtitle: String   // artist or description
    var width: CGFloat = 160
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 6) {
                AsyncImage(url: artworkURL) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    Rectangle().fill(LpspAppleMusicTokens.amSurface1Light)
                }
                .frame(width: width, height: width)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.08), radius: 16, y: 4)

                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.primary)
                    .lineLimit(2)
                    .frame(width: width, alignment: .leading)

                Text(subtitle)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.secondary)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: title)
    }
}

fileprivate struct LpspAppleMusicTrackRow: View {
    let title: String
    let artist: String
    let artwork: Image
    let isPlaying: Bool
    let hasAtmos: Bool
    let explicit: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                artwork
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                if isPlaying {
                    LpspAppleMusicEqualizerBars(color: LpspAppleMusicTokens.amRed)
                        .frame(width: 18, height: 18)
                        .background(Color.black.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    if explicit {
                        Text("E")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 4)
                            .background(RoundedRectangle(cornerRadius: 3).fill(Color.gray))
                    }
                    Text(title)
                        .font(.system(size: 17))
                        .foregroundStyle(Color.primary)
                        .lineLimit(1)
                    if hasAtmos {
                        LpspAppleMusicAtmosBadge()
                    }
                }
                Text(artist)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Button {} label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.secondary)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspAppleMusicAtmosBadge: View {
    var body: some View {
        Text("Dolby Atmos")
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                Capsule().fill(
                    LinearGradient(colors: [LpspAppleMusicTokens.amAtmosGold, LpspAppleMusicTokens.amAtmosGold.opacity(0.85)],
                                   startPoint: .top, endPoint: .bottom)
                )
            )
    }
}

fileprivate struct LpspAppleMusicEqualizerBars: View {
    let color: Color
    @State private var phase: CGFloat = 0
    let bars: [CGFloat] = [0.3, 0.6, 0.4, 0.8]

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<3, id: \.self) { i in
                Capsule()
                    .fill(color)
                    .frame(width: 3)
                    .frame(height: 14 * (0.4 + 0.6 * abs(sin(phase + CGFloat(i) * 0.7))))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: true)) {
                phase = .pi
            }
        }
    }
}

fileprivate struct LpspAppleMusicNowPlayingScreen: View {
    let trackTitle: String
    let artist: String
    let artwork: Image
    let dominantColor: Color
    let complementaryColor: Color
    @Binding var isPlaying: Bool
    @Binding var progress: Double   // 0.0–1.0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [dominantColor, complementaryColor],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()
                artwork
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 340)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.3), radius: 40, y: 20)

                VStack(spacing: 4) {
                    Text(trackTitle)
                        .font(LpspAppleMusicFonts.amNowPlaying)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    Text(artist)
                        .font(.system(size: 15))
                        .foregroundStyle(.white.opacity(0.7))
                        .lineLimit(1)
                }

                LpspAppleMusicAMScrubber(progress: $progress)

                HStack(spacing: 32) {
                    Image(systemName: "backward.fill").font(.system(size: 32)).foregroundStyle(.white)
                    LpspAppleMusicApplePlayButton(isPlaying: isPlaying, size: 64) { isPlaying.toggle() }
                    Image(systemName: "forward.fill").font(.system(size: 32)).foregroundStyle(.white)
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
}

fileprivate struct LpspAppleMusicAMScrubber: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.white.opacity(0.2)).frame(height: 4)
                Capsule().fill(LpspAppleMusicTokens.amRed).frame(width: geo.size.width * progress, height: 4)
                Circle()
                    .fill(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2, y: 1)
                    .frame(width: 16, height: 16)
                    .offset(x: geo.size.width * progress - 8)
            }
        }
        .frame(height: 16)
    }
}

fileprivate struct LpspAppleMusicMiniPlayer: View {
    let trackTitle: String
    let artist: String
    let artwork: Image
    @Binding var isPlaying: Bool
    let onExpand: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            artwork
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(trackTitle)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)
                Text(artist)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Button { isPlaying.toggle() } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.primary)
            }

            Button {} label: {
                Image(systemName: "forward.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.primary)
            }
            .padding(.trailing, 12)
        }
        .padding(.leading, 12)
        .frame(height: 64)
        .background(.regularMaterial)
        .onTapGesture { onExpand() }
    }
}

fileprivate struct LpspAppleMusicLyricsView: View {
    struct LpspAppleMusicLine: Identifiable {
        let id = UUID()
        let start: TimeInterval
        let end: TimeInterval
        let text: String
    }

    let lines: [LpspAppleMusicLine]
    let currentTime: TimeInterval

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(lines) { line in
                        Text(line.text)
                            .font(isCurrent(line) ? LpspAppleMusicFonts.amLyricsCurrent : LpspAppleMusicFonts.amLyricsOther)
                            .foregroundStyle(.white.opacity(opacity(for: line)))
                            .id(line.id)
                            .animation(.spring(response: 0.3, dampingFraction: 0.85), value: isCurrent(line))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 80)
            }
            .onChange(of: currentTime) { _ in
                if let current = lines.first(where: { isCurrent($0) }) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                        proxy.scrollTo(current.id, anchor: .center)
                    }
                }
            }
        }
    }

    private func isCurrent(_ line: LpspAppleMusicLine) -> Bool {
        currentTime >= line.start && currentTime < line.end
    }

    private func opacity(for line: LpspAppleMusicLine) -> Double {
        if isCurrent(line) { return 1 }
        if currentTime < line.start { return 0.6 }   // upcoming
        return 0.3                                    // past
    }
}

import UIKit
import CoreImage

fileprivate enum LpspAppleMusicAMColorExtractor {
    /// Returns (dominant, complementary) colors derived from an album image
    static func extractColors(from image: UIImage) -> (Color, Color) {
        guard let ciImage = CIImage(image: image) else { return (.black, .black) }
        let filter = CIFilter(name: "CIAreaAverage")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(CIVector(x: 0, y: 0, z: ciImage.extent.width, w: ciImage.extent.height),
                        forKey: kCIInputExtentKey)
        guard let output = filter.outputImage else { return (.black, .black) }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let ctx = CIContext(options: [.workingColorSpace: kCFNull as Any])
        ctx.render(output, toBitmap: &bitmap, rowBytes: 4,
                   bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                   format: .RGBA8, colorSpace: nil)

        let r = Double(bitmap[0]) / 255
        let g = Double(bitmap[1]) / 255
        let b = Double(bitmap[2]) / 255

        // Dominant = average; complementary = desaturated + darker variant
        let dominant = Color(.sRGB, red: r, green: g, blue: b)
        let complementary = Color(.sRGB, red: r * 0.4, green: g * 0.4, blue: b * 0.4)
        return (dominant, complementary)
    }
}



// MARK: - Écrans showroom

private struct LpspAppleMusicShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspAppleMusicMusicHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspAppleMusicMusicHomeTabScreen()
                .tabItem { Label("New", systemImage: "music.note.list") }
                .tag(1)
            LpspAppleMusicMusicHomeTabScreen()
                .tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right") }
                .tag(2)
            LpspAppleMusicMusicLibraryTabScreen()
                .tabItem { Label("Library", systemImage: "square.stack.fill") }
                .tag(3)
            LpspAppleMusicMusicSearchTabScreen()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(4)
        }
        .tint(LpspAppleMusicTokens.amCoral)
        .preferredColorScheme(.dark)
    }
}


private struct LpspAppleMusicGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspAppleMusicTokens.amCoral.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspAppleMusicTokens.amCoral))
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


private enum LpspAppleMusicDemoTracks {
    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let artist: String
        let isPlaying: Bool
    }
    static let items: [Item] = [
        .init(title: "Blinding Lights", artist: "The Weeknd", isPlaying: true),
        .init(title: "As It Was", artist: "Harry Styles", isPlaying: false),
        .init(title: "Flowers", artist: "Miley Cyrus", isPlaying: false),
    ]
}
private struct LpspAppleMusicMusicHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Bonsoir").font(.system(size: 28, weight: .bold)).padding(.horizontal)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(0..<4, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 8).fill(LpspAppleMusicTokens.amCoral.opacity(0.15 + Double(i) * 0.05))
                                .frame(height: 100)
                                .overlay(alignment: .bottomLeading) {
                                    Text("Playlist \(i + 1)").font(.subheadline.bold()).padding(8)
                                }
                        }
                    }
                    .padding(.horizontal)
                    Text("Récemment joué").font(.headline).padding(.horizontal)

                    ForEach(LpspAppleMusicDemoTracks.items) { track in
                        LpspAppleMusicTrackRow(
                            title: track.title,
                            artist: track.artist,
                            artwork: Image(systemName: "music.note"),
                            isPlaying: track.isPlaying
                        )
                    }

                }
            }
            .background(LpspAppleMusicTokens.amCanvasLight.ignoresSafeArea())
            .navigationTitle("")
        }
    }
}

private struct LpspAppleMusicMusicSearchTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                    Text("Artistes, titres ou podcasts").foregroundStyle(.secondary)
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
                .padding()
                Spacer()
            }
            .navigationTitle("Rechercher")
        }
    }
}

private struct LpspAppleMusicMusicLibraryTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Titres likés", "Playlists", "Albums", "Artistes"], id: \.self) { item in
                HStack {
                    RoundedRectangle(cornerRadius: 4).fill(LpspAppleMusicTokens.amCoral.opacity(0.2)).frame(width: 48, height: 48)
                    Text(item).font(.body)
                }
            }
            .navigationTitle("Bibliothèque")
        }
    }
}

private struct LpspAppleMusicMusicNowPlayingTabScreen: View {
    var body: some View {
        LpspAppleMusicNowPlayingScreen(
            trackTitle: "Blinding Lights",
            artist: "The Weeknd",
            artwork: Image(systemName: "music.note"),
            dominantColor: LpspAppleMusicTokens.amCoral
        )
    }
}




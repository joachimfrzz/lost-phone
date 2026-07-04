import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/spotify
// Meliwat/awesome-ios-design-md/music/spotify/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeSpotifyView: View {
    var body: some View {
        LpspSpotifyShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspSpotifyFonts {
    static let spotifyTitleLarge  = Font.system(size: 28, weight: .regular)
    static let spotifyTitle       = Font.system(size: 22, weight: .regular)
    static let spotifyPlaylistHero = Font.system(size: 24, weight: .regular)
    static let spotifyTrackTitle  = Font.system(size: 16, weight: .regular)
    static let spotifyCardTitle   = Font.system(size: 15, weight: .regular)
    static let spotifySubtitle    = Font.system(size: 14, weight: .regular)
    static let spotifyBody        = Font.system(size: 15, weight: .regular)
    static let spotifyMeta        = Font.system(size: 12, weight: .regular)
    static let spotifyLabelUpper  = Font.system(size: 11, weight: .regular)
    static let spotifyButton      = Font.system(size: 16, weight: .regular)
    static let spotifyTab         = Font.system(size: 11, weight: .regular)
    static func spotify(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspSpotifyTokens {
    // MARK: - Canvas & Surfaces
    static let spotifyCanvas       = Color(red: 0.07, green: 0.07, blue: 0.07)   // #121212
    static let spotifyDeepBlack    = Color.black                                 // #000000
    static let spotifySurface1     = Color(red: 0.094, green: 0.094, blue: 0.094) // #181818
    static let spotifySurface2     = Color(red: 0.157, green: 0.157, blue: 0.157) // #282828
    static let spotifySurface3     = Color(red: 0.243, green: 0.243, blue: 0.243) // #3E3E3E
    static let spotifyDivider      = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A

    // MARK: - Text
    static let spotifyTextPrimary   = Color.white                                // #FFFFFF
    static let spotifyTextSecondary = Color(red: 0.702, green: 0.702, blue: 0.702) // #B3B3B3
    static let spotifyTextTertiary  = Color(red: 0.416, green: 0.416, blue: 0.416) // #6A6A6A

    // MARK: - Brand
    static let spotifyGreen        = Color(red: 0.114, green: 0.725, blue: 0.329) // #1DB954
    static let spotifyGreenPressed = Color(red: 0.086, green: 0.612, blue: 0.275) // #169C46
    static let spotifyLogoGreen    = Color(red: 0.118, green: 0.843, blue: 0.376) // #1ED760
    static let spotifyErrorRed     = Color(red: 0.945, green: 0.369, blue: 0.424) // #F15E6C
}



// If Spotify Mix is unavailable, register a system fallback once:


fileprivate struct LpspSpotifySpotifyPlayButton: View {
    let isPlaying: Bool
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: size * 0.45, weight: .bold))
                .foregroundStyle(.black) // intentional: black on green
                .frame(width: size, height: size)
                .background(Circle().fill(LpspSpotifyTokens.spotifyGreen))
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: isPlaying)
        .buttonStyle(LpspSpotifySpotifyPressableStyle(pressedScale: 0.92))
    }
}

fileprivate struct LpspSpotifySpotifyPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspSpotifySpotifyPillButton: View {
    let title: String
    var style: LpspSpotifyStyle = .filled
    let action: () -> Void

    enum LpspSpotifyStyle { case filled, outline }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspSpotifyFonts.spotifyButton)
                .foregroundStyle(style == .filled ? .black : .white)
                .padding(.vertical, 10)
                .padding(.horizontal, 32)
                .background(
                    Capsule().fill(style == .filled ? LpspSpotifyTokens.spotifyGreen : .clear)
                )
                .overlay(
                    Capsule().strokeBorder(style == .outline ? LpspSpotifyTokens.spotifyTextSecondary : .clear, lineWidth: 1)
                )
        }
        .buttonStyle(LpspSpotifySpotifyPressableStyle())
    }
}

fileprivate struct LpspSpotifyTrackRow: View {
    let title: String
    let artist: String
    let artwork: Image
    let isPlaying: Bool

    var body: some View {
        HStack(spacing: 12) {
            artwork
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 4))

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(LpspSpotifyFonts.spotifyTrackTitle)
                    .foregroundStyle(isPlaying ? LpspSpotifyTokens.spotifyGreen : .white)
                    .lineLimit(1)
                Text(artist)
                    .font(LpspSpotifyFonts.spotifySubtitle)
                    .foregroundStyle(isPlaying ? LpspSpotifyTokens.spotifyGreen : LpspSpotifyTokens.spotifyTextSecondary)
                    .lineLimit(1)
            }

            Spacer()

            Button { /* menu */ } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspSpotifyNowPlayingScreen: View {
    let trackTitle: String
    let artist: String
    let artwork: Image
    let dominantColor: Color  // extracted upstream via Core Image

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [dominantColor, LpspSpotifyTokens.spotifyCanvas],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()
                artwork
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 340)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.5), radius: 32, y: 12)

                VStack(spacing: 6) {
                    Text(trackTitle)
                        .font(LpspSpotifyFonts.spotifyTitle)
                        .foregroundStyle(.white)
                    Text(artist)
                        .font(LpspSpotifyFonts.spotifySubtitle)
                        .foregroundStyle(LpspSpotifyTokens.spotifyTextSecondary)
                }

                // Scrubber + controls (omitted for brevity)
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
}

import UIKit
import CoreImage

fileprivate enum LpspSpotifyAlbumColorExtractor {
    static func dominantColor(from image: UIImage) -> Color {
        guard let ciImage = CIImage(image: image) else { return LpspSpotifyTokens.spotifyCanvas }
        let extentVector = CIVector(
            x: ciImage.extent.origin.x, y: ciImage.extent.origin.y,
            z: ciImage.extent.size.width, w: ciImage.extent.size.height
        )
        let filter = CIFilter(name: "CIAreaAverage", parameters: [
            kCIInputImageKey: ciImage,
            kCIInputExtentKey: extentVector,
        ])!
        guard let output = filter.outputImage else { return LpspSpotifyTokens.spotifyCanvas }
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(output, toBitmap: &bitmap, rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8, colorSpace: nil)
        return Color(.sRGB,
                     red: Double(bitmap[0]) / 255,
                     green: Double(bitmap[1]) / 255,
                     blue: Double(bitmap[2]) / 255,
                     opacity: 1)
    }
}



// MARK: - Écrans showroom

private struct LpspSpotifyShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspSpotifySpectrHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspSpotifyMusicSearchTabScreen()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
            LpspSpotifyMusicLibraryTabScreen()
                .tabItem { Label("Your Library", systemImage: "books.vertical.fill") }
                .tag(2)
            LpspSpotifyMusicNowPlayingTabScreen()
                .tabItem { Label("Premium", systemImage: "sparkles") }
                .tag(3)
        }
        .tint(LpspSpotifyTokens.spotifyErrorRed)
        .preferredColorScheme(.dark)
    }
}


private struct LpspSpotifyGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspSpotifyTokens.spotifyErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspSpotifyTokens.spotifyErrorRed))
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


private enum LpspSpotifyDemoTracks {
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
private struct LpspSpotifyMusicHomeTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Bonsoir").font(.system(size: 28, weight: .bold)).padding(.horizontal)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(0..<4, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 8).fill(LpspSpotifyTokens.spotifyErrorRed.opacity(0.15 + Double(i) * 0.05))
                                .frame(height: 100)
                                .overlay(alignment: .bottomLeading) {
                                    Text("Playlist \(i + 1)").font(.subheadline.bold()).padding(8)
                                }
                        }
                    }
                    .padding(.horizontal)
                    Text("Récemment joué").font(.headline).padding(.horizontal)

                    ForEach(LpspSpotifyDemoTracks.items) { track in
                        LpspSpotifyTrackRow(
                            title: track.title,
                            artist: track.artist,
                            artwork: Image(systemName: "music.note"),
                            isPlaying: track.isPlaying
                        )
                    }

                }
            }
            .background(LpspSpotifyTokens.spotifyCanvas.ignoresSafeArea())
            .navigationTitle("")
        }
    }
}

private struct LpspSpotifyMusicSearchTabScreen: View {
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

private struct LpspSpotifyMusicLibraryTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Titres likés", "Playlists", "Albums", "Artistes"], id: \.self) { item in
                HStack {
                    RoundedRectangle(cornerRadius: 4).fill(LpspSpotifyTokens.spotifyErrorRed.opacity(0.2)).frame(width: 48, height: 48)
                    Text(item).font(.body)
                }
            }
            .navigationTitle("Bibliothèque")
        }
    }
}

private struct LpspSpotifyMusicNowPlayingTabScreen: View {
    var body: some View {
        LpspSpotifyNowPlayingScreen(
            trackTitle: "Blinding Lights",
            artist: "The Weeknd",
            artwork: Image(systemName: "music.note"),
            dominantColor: LpspSpotifyTokens.spotifyErrorRed
        )
    }
}



private struct LpspSpotifySpectrHomeTabScreen: View {
    var body: some View {
        LpspSpotifyNowPlayingScreen(
            trackTitle: "Playing from Playlist",
            artist: "Mellow Mornings",
            artwork: Image(systemName: "music.note"),
            dominantColor: LpspSpotifyTokens.spotifyErrorRed
        )
        .background(LpspSpotifyTokens.spotifyCanvas.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}



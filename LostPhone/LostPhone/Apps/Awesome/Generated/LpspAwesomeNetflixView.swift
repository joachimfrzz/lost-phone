import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/netflix
// Meliwat/awesome-ios-design-md/video/netflix/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeNetflixView: View {
    var body: some View {
        LpspNetflixShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspNetflixTokens {
    // MARK: - Brand
    static let netflixRed        = Color(red: 0.898, green: 0.035, blue: 0.078)  // #E50914
    static let netflixRedPressed = Color(red: 0.718, green: 0.027, blue: 0.059)  // #B7070F
    static let netflixRedDimmed  = Color(red: 0.514, green: 0.063, blue: 0.063)  // #831010

    // MARK: - Canvas & Surfaces
    static let netflixCanvas    = Color(red: 0.078, green: 0.078, blue: 0.078) // #141414
    static let netflixDeepBlack = Color.black                                   // #000000
    static let netflixSurface1  = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F
    static let netflixSurface2  = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
    static let netflixSurface3  = Color(red: 0.227, green: 0.227, blue: 0.227) // #3A3A3A
    static let netflixDivider   = Color(red: 0.169, green: 0.169, blue: 0.169) // #2B2B2B
    static let netflixInput     = Color(red: 0.2,   green: 0.2,   blue: 0.2)   // #333333

    // MARK: - Text
    static let netflixTextPrimary   = Color.white                                // #FFFFFF
    static let netflixTextSecondary = Color(red: 0.667, green: 0.667, blue: 0.667) // #AAAAAA
    static let netflixTextTertiary  = Color(red: 0.467, green: 0.467, blue: 0.467) // #777777

    // MARK: - Profile Accent Rotation
    static let netflixProfileRed    = Color(red: 0.898, green: 0.035, blue: 0.078) // #E50914
    static let netflixProfileBlue   = Color(red: 0.243, green: 0.243, blue: 0.569) // #3E3E91
    static let netflixProfileYellow = Color(red: 0.961, green: 0.847, blue: 0.361) // #F5D85C
    static let netflixProfileGreen  = Color(red: 0.294, green: 0.541, blue: 0.243) // #4B8A3E
    static let netflixKidsOrange    = Color(red: 0.973, green: 0.596, blue: 0.114) // #F8981D

    // MARK: - Semantic
    static let netflixInfo = Color(red: 0.329, green: 0.725, blue: 0.773) // #54B9C5
}

private enum LpspNetflixFonts {
    // Headlines
    static let netflixTitleHero    = Font.system(size: 32, weight: .regular)
    static let netflixScreenTitle  = Font.system(size: 20, weight: .regular)
    static let netflixRowHeader    = Font.system(size: 17, weight: .regular)

    // Content
    static let netflixEpisodeTitle = Font.system(size: 17, weight: .regular)
    static let netflixBody         = Font.system(size: 14, weight: .regular)
    static let netflixMetadata     = Font.system(size: 13, weight: .regular)
    static let netflixMetadataSm   = Font.system(size: 12, weight: .regular)

    // Buttons & labels
    static let netflixButtonPlay   = Font.system(size: 17, weight: .regular)
    static let netflixButtonSecondary = Font.system(size: 15, weight: .regular)
    static let netflixBadge        = Font.system(size: 11, weight: .regular)
    static let netflixTabLabel     = Font.system(size: 10, weight: .regular)
    static let netflixCert         = Font.system(size: 12, weight: .regular)

    static func netflix(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

fileprivate struct LpspNetflixNetflixPlayButton: View {
    let title: String   // "Play" or "Resume"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                Text(title)
                    .font(LpspNetflixFonts.netflixButtonPlay)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(RoundedRectangle(cornerRadius: 4).fill(LpspNetflixTokens.netflixRed))
        }
        .sensoryFeedback(.impact(flexibility: .rigid), trigger: title)
        .buttonStyle(LpspNetflixNetflixPressableStyle())
    }
}

fileprivate struct LpspNetflixNetflixPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .brightness(configuration.isPressed ? -0.1 : 0)
            .animation(.spring(response: 0.2, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspNetflixNetflixSecondaryButton: View {
    let systemIcon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemIcon)
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                Text(title)
                    .font(LpspNetflixFonts.netflixButtonSecondary)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white.opacity(0.15))
            )
        }
        .buttonStyle(LpspNetflixNetflixPressableStyle())
    }
}

fileprivate struct LpspNetflixPosterTile: View {
    let imageURL: URL
    let width: CGFloat
    var progress: Double? = nil   // 0.0–1.0 — pass for Continue Watching
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottom) {
                AsyncImage(url: imageURL) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    Rectangle().fill(LpspNetflixTokens.netflixSurface1)
                }
                .frame(width: width, height: width * 1.5)
                .clipShape(RoundedRectangle(cornerRadius: 4))

                if let progress {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.white.opacity(0.3)).frame(height: 2)
                            Rectangle().fill(LpspNetflixTokens.netflixRed)
                                .frame(width: geo.size.width * progress, height: 2)
                        }
                    }
                    .frame(height: 2)
                    .padding(.bottom, 4)
                    .padding(.horizontal, 4)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspNetflixPosterRow: View {
    let title: String
    let posters: [URL]
    let tileWidth: CGFloat = 130

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(LpspNetflixFonts.netflixRowHeader)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(posters, id: \.self) { url in
                        LpspNetflixPosterTile(imageURL: url, width: tileWidth) {}
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

fileprivate struct LpspNetflixTop10Row: View {
    let posters: [URL]   // exactly 10

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Top 10 TV Shows in the U.S. Today")
                .font(LpspNetflixFonts.netflixRowHeader)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(Array(posters.prefix(10).enumerated()), id: \.offset) { idx, url in
                        LpspNetflixTop10Item(index: idx + 1, posterURL: url)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

fileprivate struct LpspNetflixTop10Item: View {
    let index: Int
    let posterURL: URL
    let tileWidth: CGFloat = 120

    var body: some View {
        HStack(alignment: .bottom, spacing: -24) {
            // Giant outlined numeral on the left, partially covered by poster
            Text("\(index)")
                .font(.custom("NetflixSans-Black", size: 160).weight(.black))
                .foregroundStyle(LpspNetflixTokens.netflixCanvas)
                .overlay(
                    Text("\(index)")
                        .font(.custom("NetflixSans-Black", size: 160).weight(.black))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white.opacity(0.1), Color.clear],
                                startPoint: .top, endPoint: .bottom
                            )
                        )
                )
                .shadow(color: .white.opacity(0.2), radius: 0, x: 0, y: 0) // subtle inset-like stroke

            LpspNetflixPosterTile(imageURL: posterURL, width: tileWidth) {}
        }
        .padding(.trailing, 8)
    }
}

fileprivate struct LpspNetflixProfilePicker: View {
    let profiles: [Profile]
    let onSelect: (Profile) -> Void

    struct Profile: Identifiable {
        let id = UUID()
        let name: String
        let avatarColor: Color
        let isKids: Bool
    }

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 24), count: 2)

    var body: some View {
        ZStack {
            LpspNetflixTokens.netflixCanvas.ignoresSafeArea()
            VStack(spacing: 48) {
                Text("Who's watching?")
                    .font(LpspNetflixFonts.netflixTitleHero)
                    .foregroundStyle(.white)

                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(profiles) { profile in
                        Button {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                onSelect(profile)
                            }
                        } label: {
                            VStack(spacing: 12) {
                                Circle()
                                    .fill(profile.avatarColor)
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 40))
                                            .foregroundStyle(.white)
                                    )
                                Text(profile.name)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }

                Button("Manage Profiles") {}
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(LpspNetflixTokens.netflixTextSecondary)
            }
        }
    }
}

fileprivate struct LpspNetflixNetflixHeader: View {
    let categoryChips: [String]   // e.g. ["TV Shows", "Movies", "My List"]
    @State private var selectedChip: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // The red NETFLIX wordmark image (your vector asset)
            Image("NetflixWordmark")
                .resizable()
                .scaledToFit()
                .frame(height: 22)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(categoryChips, id: \.self) { chip in
                        Button {
                            selectedChip = selectedChip == chip ? nil : chip
                        } label: {
                            Text(chip)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .overlay(
                                    Capsule().stroke(Color.white.opacity(0.4), lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 12)
    }
}



// MARK: - Écrans showroom

private struct LpspNetflixShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspNetflixSpectrHomeTabScreen()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            LpspNetflixVideoNewTabScreen()
                .tabItem { Label("New & Hot", systemImage: "play.rectangle.on.rectangle.fill") }
                .tag(1)
            LpspNetflixProfilePickerTabScreen()
                .tabItem { Label("My Netflix", systemImage: "person.crop.circle.fill") }
                .tag(2)
            LpspNetflixVideoDownloadsTabScreen()
                .tabItem { Label("Downloads", systemImage: "arrow.down.circle.fill") }
                .tag(3)
        }
        .tint(LpspNetflixTokens.netflixProfileYellow)
        .preferredColorScheme(.dark)
    }
}


private struct LpspNetflixGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspNetflixTokens.netflixProfileYellow.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspNetflixTokens.netflixProfileYellow))
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


private struct LpspNetflixDemoPosterURLs {
    static let items: [URL] = [
        URL(string: "https://picsum.photos/seed/nfx1/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx2/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx3/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx4/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx5/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx6/200/300")!,
    ]
}
private struct LpspNetflixDemoProfile: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let isKids: Bool
}

private enum LpspNetflixDemoProfiles {
    static let items: [LpspNetflixDemoProfile] = [
        .init(name: "Lost Phone", color: .red, isKids: false),
        .init(name: "Enfants", color: .orange, isKids: true),
    ]
}

private struct LpspNetflixVideoHomeTabScreen: View {
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
                    LpspNetflixNetflixPlayButton(title: "Lecture", action: {})
                        .padding(.horizontal, 12)
                    Text("Tendances").font(.system(size: 17, weight: .bold)).foregroundStyle(.white).padding(.horizontal, 12)

                    LpspNetflixPosterRow(title: "Trending Now", posters: LpspNetflixDemoPosterURLs.items)
                    LpspNetflixPosterRow(title: "Continue Watching", posters: LpspNetflixDemoPosterURLs.items)

                    LpspNetflixTop10Row(posters: LpspNetflixDemoPosterURLs.items)

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

private struct LpspNetflixProfilePickerTabScreen: View {
    var body: some View {
        LpspNetflixProfilePicker(
            profiles: LpspNetflixDemoProfiles.items.map {
                LpspNetflixProfilePicker.Profile(name: $0.name, avatarColor: $0.color, isKids: $0.isKids)
            },
            onSelect: { _ in }
        )
    }
}

private struct LpspNetflixVideoNewTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    LpspNetflixPosterRow(title: "Trending Now", posters: LpspNetflixDemoPosterURLs.items)
                    LpspNetflixPosterRow(title: "Continue Watching", posters: LpspNetflixDemoPosterURLs.items)

                    LpspNetflixTop10Row(posters: LpspNetflixDemoPosterURLs.items)

                    Text("Nouveautés").font(.title2.bold()).foregroundStyle(.white).padding(.horizontal, 12)
                }
                .padding(.vertical, 8)
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("New & Hot")
        }
    }
}

private struct LpspNetflixVideoDownloadsTabScreen: View {
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

private struct LpspNetflixDemoProfilePicker: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Qui regarde ?").font(.system(size: 32, weight: .bold)).foregroundStyle(.white)
                ForEach(LpspNetflixDemoProfiles.items) { p in
                    VStack(spacing: 8) {
                        Circle().fill(p.color).frame(width: 72, height: 72)
                        Text(p.name).foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}


private struct LpspNetflixSpectrHomeTabScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [Color(red:0.05,green:0.05,blue:0.08), Color(red:0.15,green:0.05,blue:0.08)], startPoint: .top, endPoint: .bottom).frame(maxWidth: .infinity, maxHeight: .infinity)
            LinearGradient(colors: [.clear, Color(red: 0.078, green: 0.078, blue: 0.078)], startPoint: .top, endPoint: .bottom).frame(height: 120)
            HStack {
                Text("NETFLIX").font(.system(size: 22.0, weight: .black)).foregroundStyle(Color(red: 0.898, green: 0.035, blue: 0.078))
            } .padding(.horizontal, 12).padding(.top, 48)
            HStack(spacing: 6) {
                Text("TOP 10").font(.system(size: 10.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("in the U.S. Today").font(.system(size: 11.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            } .padding(.horizontal, 12)
            VStack(alignment: .leading, spacing: 4) {
                Text("NIGHT WAVE").font(.system(size: 42, weight: .black)).foregroundStyle(.white)
                    Text("Gripping · Dramas · Thrillers").font(.system(size: 11.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("This week's trending").font(.system(size: 12.0, weight: .regular)).foregroundStyle(Color(red: 0.667, green: 0.667, blue: 0.667))
                HStack(spacing: 10) {
                    Text("Play").font(.system(size: 14.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                    Text("My List").font(.system(size: 14.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                } .padding(.horizontal, 12).padding(.bottom, 16)
            } .padding(.horizontal, 12)
            VStack(alignment: .leading, spacing: 8) {
                Text("Continue Watching").font(.system(size: 14.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 4).fill(Color(red:0.15,green:0.15,blue:0.15)).frame(width: 120, height: 68)
                    RoundedRectangle(cornerRadius: 4).fill(Color(red:0.15,green:0.15,blue:0.15)).frame(width: 120, height: 68)
                    RoundedRectangle(cornerRadius: 4).fill(Color(red:0.15,green:0.15,blue:0.15)).frame(width: 120, height: 68)
                    }
                    .padding(.horizontal, 12)
                }
            } .padding(.top, 12)
            VStack(alignment: .leading, spacing: 8) {
                Text("Top 10 in the U.S. Today").font(.system(size: 14.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                HStack(spacing: 8) {
                    HStack(alignment: .bottom, spacing: 4) {
                        Text("1").font(.system(size: 110.0, weight: .black)).foregroundStyle(Color(red: 0.12, green: 0.12, blue: 0.12))
                        RoundedRectangle(cornerRadius: 4).fill(Color(red:0.2,green:0.2,blue:0.22)).frame(width: 90, height: 130)
                    }
                    HStack(alignment: .bottom, spacing: 4) {
                        Text("2").font(.system(size: 110.0, weight: .black)).foregroundStyle(Color(red: 0.12, green: 0.12, blue: 0.12))
                        RoundedRectangle(cornerRadius: 4).fill(Color(red:0.2,green:0.2,blue:0.22)).frame(width: 90, height: 130)
                    }
                    HStack(alignment: .bottom, spacing: 4) {
                        Text("3").font(.system(size: 110.0, weight: .black)).foregroundStyle(Color(red: 0.12, green: 0.12, blue: 0.12))
                        RoundedRectangle(cornerRadius: 4).fill(Color(red:0.2,green:0.2,blue:0.22)).frame(width: 90, height: 130)
                    }
                } .padding(.horizontal, 12)
            } .padding(.top, 8)
        } .frame(height: 420)
            }
        }
        .background(Color(red: 0.078, green: 0.078, blue: 0.078).ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}



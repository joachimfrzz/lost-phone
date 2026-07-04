import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/music/shazam/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/shazam
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeShazamView: View {
    var body: some View {
        LpspShazamShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspShazamFonts {
    static let shazamResultLarge = Font.system(size: 28, weight: .regular)
    static let shazamResult      = Font.system(size: 22, weight: .regular)
    static let shazamSection     = Font.system(size: 20, weight: .regular)
    static let shazamPrompt      = Font.system(size: 18, weight: .regular)
    static let shazamCardTitle   = Font.system(size: 16, weight: .regular)
    static let shazamSubtitle    = Font.system(size: 14, weight: .regular)
    static let shazamBody        = Font.system(size: 15, weight: .regular)
    static let shazamMeta        = Font.system(size: 13, weight: .regular)
    static let shazamLabelUpper  = Font.system(size: 11, weight: .regular)
    static let shazamButton      = Font.system(size: 16, weight: .regular)
    static let shazamButtonSec   = Font.system(size: 14, weight: .regular)
    static func shazam(_ size: CGFloat, weight: Font.Weight = .medium) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspShazamTokens {
    // MARK: - Gradient stops
    static let shazamCore  = Color(red: 0.0,   green: 0.314, blue: 1.0)   // #0050FF
    static let shazamBlue  = Color(red: 0.0,   green: 0.533, blue: 1.0)   // #0088FF
    static let shazamSpace = Color(red: 0.031, green: 0.035, blue: 0.055) // #08090E
    static let shazamBluePressed = Color(red: 0.0, green: 0.435, blue: 0.878) // #006FE0

    // MARK: - Text
    static let shazamTextPrimary   = Color.white                                 // #FFFFFF
    static let shazamTextSecondary = Color(red: 0.722, green: 0.769, blue: 1.0)   // #B8C4FF periwinkle
    static let shazamTextTertiary  = Color(red: 0.722, green: 0.769, blue: 1.0).opacity(0.55)

    // MARK: - Glass
    static let shazamGlass        = Color.white.opacity(0.08)
    static let shazamGlassStrong  = Color.white.opacity(0.14)
    static let shazamDivider      = Color.white.opacity(0.12)

    // MARK: - Semantic
    static let appleMusicPink = Color(red: 0.980, green: 0.141, blue: 0.235) // #FA243C
    static let shazamErrorRed = Color(red: 1.0,   green: 0.271, blue: 0.227) // #FF453A
}

// The signature hero gradient






private enum LpspShazamGradients {
    static var shazamHero: RadialGradient {
            RadialGradient(
                colors: [LpspShazamTokens.shazamBlue, LpspShazamTokens.shazamCore, LpspShazamTokens.shazamSpace],
                center: UnitPoint(x: 0.5, y: 0.42),
                startRadius: 0,
                endRadius: 520
            )
        }
}

fileprivate struct LpspShazamShazamButton: View {
    @Binding var isListening: Bool
    let onTap: () -> Void

    private let size: CGFloat = 132
    @State private var breathe = false

    var body: some View {
        ZStack {
            // Concentric emitting rings (only while listening)
            if isListening {
                ForEach(0..<3) { i in
                    LpspShazamPulseRing(delay: Double(i) * 0.6, base: size)
                }
            }

            // Listening glow
            Circle()
                .fill(LpspShazamTokens.shazamBlue.opacity(isListening ? 0.5 : 0))
                .frame(width: size * 1.4, height: size * 1.4)
                .blur(radius: 60)
                .animation(.easeInOut(duration: 0.5), value: isListening)

            // The button
            Button(action: onTap) {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.white, Color(red: 0.91, green: 0.94, blue: 1.0), Color(red: 0.81, green: 0.88, blue: 1.0)],
                                center: UnitPoint(x: 0.38, y: 0.32),
                                startRadius: 0, endRadius: size * 0.7
                            )
                        )
                        .overlay(Circle().strokeBorder(Color.white.opacity(0.4), lineWidth: 1))
                    LpspShazamShazamGlyph()
                        .fill(LpspShazamTokens.shazamBlue)
                        .frame(width: size * 0.4, height: size * 0.4)
                }
                .frame(width: size, height: size)
                .scaleEffect(breathe && !isListening ? 1.04 : 1.0)
                .shadow(color: LpspShazamTokens.shazamCore.opacity(0.45), radius: 48, y: 16)
            }
            .buttonStyle(LpspShazamShazamPressable())
            .sensoryFeedback(.impact(weight: .heavy), trigger: isListening)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) { breathe = true }
        }
    }
}

fileprivate struct LpspShazamPulseRing: View {
    let delay: Double
    let base: CGFloat
    @State private var animate = false

    var body: some View {
        Circle()
            .strokeBorder(Color.white.opacity(0.22), lineWidth: 2)
            .frame(width: base, height: base)
            .scaleEffect(animate ? 2.6 : 1.0)
            .opacity(animate ? 0 : 0.22)
            .onAppear {
                withAnimation(.easeOut(duration: 1.8).repeatForever(autoreverses: false).delay(delay)) {
                    animate = true
                }
            }
    }
}

fileprivate struct LpspShazamShazamPressable: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

// Stylized Shazam mark — replace with the licensed glyph asset in production
fileprivate struct LpspShazamShazamGlyph: Shape {
    func path(in r: CGRect) -> Path {
        var p = Path()
        let w = r.width, h = r.height
        p.move(to: CGPoint(x: w * 0.62, y: h * 0.18))
        p.addCurve(to: CGPoint(x: w * 0.30, y: h * 0.46),
                   control1: CGPoint(x: w * 0.40, y: h * 0.18),
                   control2: CGPoint(x: w * 0.30, y: h * 0.30))
        p.addCurve(to: CGPoint(x: w * 0.70, y: h * 0.62),
                   control1: CGPoint(x: w * 0.30, y: h * 0.62),
                   control2: CGPoint(x: w * 0.70, y: h * 0.50))
        p.addCurve(to: CGPoint(x: w * 0.38, y: h * 0.86),
                   control1: CGPoint(x: w * 0.70, y: h * 0.78),
                   control2: CGPoint(x: w * 0.58, y: h * 0.86))
        return p.strokedPath(.init(lineWidth: w * 0.13, lineCap: .round))
    }
}

fileprivate struct LpspShazamShazamHome: View {
    @State private var isListening = false

    var body: some View {
        ZStack {
            Rectangle().fill(LpspShazamGradients.shazamHero).ignoresSafeArea()

            VStack {
                HStack {
                    Image(systemName: "person.crop.circle").font(.system(size: 26))
                    Spacer()
                    Image(systemName: "music.note.list").font(.system(size: 26))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 20)

                Spacer().frame(height: 40)

                LpspShazamShazamButton(isListening: $isListening) {
                    isListening.toggle()
                }

                Text(isListening ? "Listening for music…" : "Tap to Shazam")
                    .font(isListening ? LpspShazamFonts.shazamButton : LpspShazamFonts.shazamPrompt)
                    .foregroundStyle(.white)
                    .padding(.top, 24)

                Spacer()
            }
            .padding(.top, 8)
        }
    }
}

fileprivate struct LpspShazamShazamResultCard: View {
    let title: String
    let artist: String
    let artwork: Image

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 16) {
                artwork
                    .resizable().aspectRatio(1, contentMode: .fill)
                    .frame(width: 88, height: 88)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading, spacing: 6) {
                    Text(title).font(LpspShazamFonts.shazamResult).foregroundStyle(.white).lineLimit(2)
                    Text(artist).font(LpspShazamFonts.shazamSubtitle).foregroundStyle(LpspShazamTokens.shazamTextSecondary).lineLimit(1)
                }
                Spacer(minLength: 0)
            }

            Button { } label: {
                HStack(spacing: 8) {
                    Image(systemName: "music.note").foregroundStyle(LpspShazamTokens.appleMusicPink)
                    Text("Open in Apple Music").font(LpspShazamFonts.shazamButton).foregroundStyle(LpspShazamTokens.shazamSpace)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Capsule().fill(.white))
            }
            .buttonStyle(LpspShazamShazamPressable())

            HStack(spacing: 12) {
                LpspShazamGlassAction(icon: "square.and.arrow.up", label: "Share")
                LpspShazamGlassAction(icon: "plus", label: "Add")
                LpspShazamGlassAction(icon: "text.quote", label: "Lyrics")
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LpspShazamTokens.shazamGlass)
                .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(LpspShazamTokens.shazamGlassStrong, lineWidth: 1))
        )
        .padding(.horizontal, 20)
        .transition(.scale(scale: 0.85).combined(with: .opacity))
    }
}

fileprivate struct LpspShazamGlassAction: View {
    let icon: String
    let label: String
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon).font(.system(size: 18)).foregroundStyle(.white)
            Text(label).font(LpspShazamFonts.shazamButtonSec).foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Capsule().fill(LpspShazamTokens.shazamGlass))
        .overlay(Capsule().strokeBorder(Color.white.opacity(0.16), lineWidth: 1))
    }
}

fileprivate struct LpspShazamRecentShazamsSheet: View {
    let items: [(title: String, artist: String, time: String, art: Image)]

    var body: some View {
        VStack(spacing: 0) {
            Capsule().fill(Color.white.opacity(0.4)).frame(width: 36, height: 4).padding(.vertical, 12)
            Text("Your Shazams").font(LpspShazamFonts.shazamSection).foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 16).padding(.bottom, 8)

            ScrollView {
                ForEach(items.indices, id: \.self) { i in
                    let it = items[i]
                    HStack(spacing: 12) {
                        it.art.resizable().aspectRatio(1, contentMode: .fill)
                            .frame(width: 52, height: 52).clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack(alignment: .leading, spacing: 2) {
                            Text(it.title).font(LpspShazamFonts.shazamCardTitle).foregroundStyle(.white).lineLimit(1)
                            Text(it.artist).font(LpspShazamFonts.shazamSubtitle).foregroundStyle(LpspShazamTokens.shazamTextSecondary).lineLimit(1)
                        }
                        Spacer()
                        Text(it.time).font(LpspShazamFonts.shazamMeta).foregroundStyle(LpspShazamTokens.shazamTextSecondary)
                        Image(systemName: "chevron.right").font(.system(size: 14)).foregroundStyle(LpspShazamTokens.shazamTextSecondary)
                    }
                    .padding(.horizontal, 16).frame(height: 68)
                    Divider().overlay(LpspShazamTokens.shazamDivider)
                }
            }
        }
        .background(.ultraThinMaterial)
        .presentationDetents([.height(120), .medium, .large])
        .presentationCornerRadius(24)
    }
}

fileprivate enum LpspShazamShazamState { case idle, listening, matched(track: String), noMatch }

@Observable fileprivate final class LpspShazamShazamModel {
    var state: LpspShazamShazamState = .idle
    func tap() {
        state = .listening
        // start ShazamKit SHSession; on result:
        // state = .matched(track:) → reveal card
        // on failure: state = .noMatch → soft shake + error haptic
    }
}



// MARK: - Écrans showroom

private struct LpspShazamShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspShazamGenericTabScreen(title: "Accueil", tabIndex: 0)
                .tabItem { Label("Accueil", systemImage: "house.fill") }
                .tag(0)
            LpspShazamGenericTabScreen(title: "Explorer", tabIndex: 1)
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
                .tag(1)
        }
        .tint(LpspShazamTokens.shazamErrorRed)
        
    }
}


private struct LpspShazamGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspShazamTokens.shazamErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspShazamTokens.shazamErrorRed))
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


private struct LpspShazamMessagingTabScreen: View {
    let title: String
    var body: some View { LpspShazamGenericTabScreen(title: title, tabIndex: 0) }
}



import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/productivity/zoom/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/zoom
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeZoomView: View {
    var body: some View {
        LpspZoomShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspZoomTokens {
    // MARK: - Canvas & Surfaces (dark / in-call)
    static let zoomCanvas    = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let zoomSurface1  = Color(red: 0.176, green: 0.176, blue: 0.176) // #2D2D2D
    static let zoomSurface2  = Color(red: 0.227, green: 0.227, blue: 0.227) // #3A3A3A
    static let zoomDivider   = Color(red: 0.227, green: 0.227, blue: 0.227) // #3A3A3A

    // MARK: - Light surfaces (outside call)
    static let zoomLightCanvas  = Color.white                                // #FFFFFF
    static let zoomLightSurface = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let zoomLightDivider = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5

    // MARK: - Text (dark)
    static let zoomTextPrimary   = Color.white                                // #FFFFFF
    static let zoomTextSecondary = Color(red: 0.690, green: 0.690, blue: 0.690) // #B0B0B0
    static let zoomTextTertiary  = Color(red: 0.478, green: 0.478, blue: 0.478) // #7A7A7A

    // MARK: - Brand & Semantic
    static let zoomBlue        = Color(red: 0.176, green: 0.549, blue: 1.0)   // #2D8CFF
    static let zoomBluePressed = Color(red: 0.122, green: 0.435, blue: 0.800) // #1F6FCC
    static let zoomRed         = Color(red: 0.878, green: 0.157, blue: 0.157) // #E02828
    static let zoomRedPressed  = Color(red: 0.725, green: 0.122, blue: 0.122) // #B91F1F
    static let zoomHandYellow  = Color(red: 0.961, green: 0.773, blue: 0.094) // #F5C518
    static let zoomSuccess     = Color(red: 0.055, green: 0.541, blue: 0.271) // #0E8A45
}

private enum LpspZoomFonts {
    static let zoomTitleLarge   = Font.system(size: 28, weight: .regular)
    static let zoomMeetingTopic = Font.system(size: 22, weight: .regular)
    static let zoomSection      = Font.system(size: 17, weight: .regular)
    static let zoomListTitle    = Font.system(size: 16, weight: .regular)
    static let zoomBody         = Font.system(size: 15, weight: .regular)
    static let zoomButton       = Font.system(size: 17, weight: .regular)
    static let zoomControlLabel = Font.system(size: 11, weight: .regular)
    static let zoomMetadata     = Font.system(size: 13, weight: .regular)
    static let zoomTileName     = Font.system(size: 13, weight: .regular)
    static let zoomTimer        = Font.system(size: 14, weight: .regular)
    static let zoomTab          = Font.system(size: 10, weight: .regular)
    static let zoomTinyUpper    = Font.system(size: 11, weight: .regular)
}

// System fallback if Lato is unavailable
private enum LpspZoomFonts {
    static func zoom(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

extension View {
    func zoomTabular() -> some View { self.monospacedDigit() }
}

private struct LpspZoomGalleryTile: View {
    let name: String
    let isMuted: Bool
    let isActiveSpeaker: Bool
    var hasVideo: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8).fill(LpspZoomTokens.zoomSurface2)

            if !hasVideo {
                Circle()
                    .fill(LpspZoomTokens.zoomBlue.opacity(0.25))
                    .frame(width: 56, height: 56)
                    .overlay(Text(initials(name))
                        .font(.zoom(20, weight: .semibold))
                        .foregroundStyle(.white))
            }

            VStack {
                Spacer()
                HStack(spacing: 6) {
                    if isMuted {
                        Image(systemName: "mic.slash.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                            .frame(width: 22, height: 22)
                            .background(Circle().fill(LpspZoomTokens.zoomRed))
                    }
                    Text(name)
                        .font(LpspZoomFonts.zoomTileName)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6).padding(.vertical, 3)
                        .background(RoundedRectangle(cornerRadius: 4).fill(Color.black.opacity(0.45)))
                    Spacer()
                }
                .padding(8)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(LpspZoomTokens.zoomBlue, lineWidth: isActiveSpeaker ? 3 : 0)
        )
    }

    private func initials(_ s: String) -> String {
        s.split(separator: " ").prefix(2).compactMap { $0.first }.map(String.init).joined()
    }
}

private struct LpspZoomJoinButton: View {
    var title: String = "Join"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspZoomFonts.zoomButton)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(RoundedRectangle(cornerRadius: 8).fill(LpspZoomTokens.zoomBlue))
        }
        .buttonStyle(LpspZoomZoomPressable(pressedColor: LpspZoomTokens.zoomBluePressed))
    }
}

private struct LpspZoomZoomPressable: ButtonStyle {
    var pressedColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(configuration.isPressed
                ? RoundedRectangle(cornerRadius: 8).fill(pressedColor).blendMode(.multiply)
                : nil)
    }
}

private struct LpspZoomControlBar: View {
    @Binding var micOn: Bool
    @Binding var videoOn: Bool
    let onLeave: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            LpspZoomControlButton(icon: micOn ? "mic.fill" : "mic.slash.fill",
                          label: micOn ? "Mute" : "Unmute",
                          tint: micOn ? .white : LpspZoomTokens.zoomRed) { micOn.toggle() }
            LpspZoomControlButton(icon: videoOn ? "video.fill" : "video.slash.fill",
                          label: videoOn ? "Stop Video" : "Start Video",
                          tint: .white) { videoOn.toggle() }
            LpspZoomControlButton(icon: "square.and.arrow.up", label: "Share", tint: .white) {}
            LpspZoomControlButton(icon: "person.2.fill", label: "Participants", tint: .white) {}
            LpspZoomControlButton(icon: "face.smiling", label: "React", tint: .white) {}

            Button(action: onLeave) {
                Text("Leave")
                    .font(.zoom(15, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18).padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(LpspZoomTokens.zoomRed))
            }
            .padding(.leading, 4)
        }
        .padding(.horizontal, 12)
        .frame(height: 72)
        .background(RoundedRectangle(cornerRadius: 16).fill(LpspZoomTokens.zoomSurface1.opacity(0.96)))
        .shadow(color: .black.opacity(0.4), radius: 24, y: 8)
        .padding(.horizontal, 12)
    }
}

private struct LpspZoomControlButton: View {
    let icon: String; let label: String; let tint: Color; let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon).font(.system(size: 24)).foregroundStyle(tint)
                Text(label).font(LpspZoomFonts.zoomControlLabel).foregroundStyle(tint)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private struct LpspZoomMeetingRow: View {
    let time: String
    let topic: String
    let subtitle: String
    let onJoin: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Text(time)
                .font(LpspZoomFonts.zoomMetadata)
                .foregroundStyle(LpspZoomTokens.zoomTextSecondary)
                .frame(width: 64, alignment: .leading)
                .zoomTabular()

            VStack(alignment: .leading, spacing: 4) {
                Text(topic).font(LpspZoomFonts.zoomListTitle).foregroundStyle(.white)
                Text(subtitle).font(LpspZoomFonts.zoomMetadata).foregroundStyle(LpspZoomTokens.zoomTextSecondary)
            }

            Spacer()

            Button(action: onJoin) {
                Text("Join")
                    .font(.zoom(14, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18)
                    .frame(height: 32)
                    .background(Capsule().fill(LpspZoomTokens.zoomBlue))
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .background(LpspZoomTokens.zoomSurface1)
    }
}

private struct LpspZoomRecordingIndicator: View {
    @State private var pulse = false
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(LpspZoomTokens.zoomRed)
                .frame(width: 10, height: 10)
            Text("RECORDING")
                .font(LpspZoomFonts.zoomTinyUpper)
                .foregroundStyle(.white)
                .tracking(0.4)
        }
        .padding(.horizontal, 10).padding(.vertical, 6)
        .background(Capsule().fill(Color.black.opacity(0.45)))
        .onAppear { pulse = true }
    }
}

private struct LpspZoomGalleryGrid: View {
    let participants: [LpspZoomParticipant]
    var body: some View {
        let columns = gridColumns(for: participants.count)
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(participants) { p in
                LpspZoomGalleryTile(name: p.name, isMuted: p.isMuted, isActiveSpeaker: p.isSpeaking)
                    .aspectRatio(16/9, contentMode: .fit)
            }
        }
        .padding(4)
    }

    private func gridColumns(for n: Int) -> [GridItem] {
        let cols = n <= 1 ? 1 : n <= 4 ? 2 : 3
        return Array(repeating: GridItem(.flexible(), spacing: 4), count: cols)
    }
}

private struct LpspZoomParticipant: Identifiable { let id = UUID(); let name: String; let isMuted: Bool; let isSpeaking: Bool }

private struct LpspZoomRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor { $0.userInterfaceStyle == .dark
            ? UIColor(LpspZoomTokens.zoomSurface1) : UIColor.white }
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            MeetingsView().tabItem  { Label("Meetings",  systemImage: "video.fill") }
            ChatView().tabItem      { Label("Team Chat", systemImage: "bubble.left.and.bubble.right.fill") }
            MailView().tabItem      { Label("Mail",      systemImage: "envelope.fill") }
            PhoneView().tabItem     { Label("Phone",     systemImage: "phone.fill") }
            MoreView().tabItem      { Label("More",      systemImage: "ellipsis") }
        }
        .tint(LpspZoomTokens.zoomBlue)
    }
}

// MARK: - Écrans showroom

private struct LpspZoomShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspZoomGenericTabScreen(title: "Team Chat", tabIndex: 0)
                .tabItem { Label("Team Chat", systemImage: "bubble.left.and.bubble.right.fill") }
                .tag(0)
        }
        .tint(LpspZoomTokens.zoomRed)
        
    }
}


private struct LpspZoomGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspZoomTokens.zoomRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspZoomTokens.zoomRed))
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


private struct LpspZoomMessagingTabScreen: View {
    let title: String
    var body: some View { LpspZoomGenericTabScreen(title: title, tabIndex: 0) }
}



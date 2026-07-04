import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/messaging/whatsapp/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/whatsapp
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeWhatsAppView: View {
    var body: some View {
        LpspWhatsAppShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspWhatsAppTokens {
    // MARK: - Brand
    static let waGreen         = Color(red: 0.145, green: 0.827, blue: 0.400) // #25D366
    static let waGreenPressed  = Color(red: 0.118, green: 0.745, blue: 0.365) // #1EBE5D
    static let waTeal          = Color(red: 0.027, green: 0.369, blue: 0.329) // #075E54
    static let waMidTeal       = Color(red: 0.071, green: 0.549, blue: 0.494) // #128C7E
    static let waDarkTeal      = Color(red: 0.020, green: 0.302, blue: 0.267) // #054D44

    // MARK: - Bubbles
    static let waOutgoingLight = Color(red: 0.851, green: 0.992, blue: 0.827) // #D9FDD3
    static let waOutgoingDark  = Color(red: 0.000, green: 0.361, blue: 0.294) // #005C4B
    static let waIncomingLight = Color.white
    static let waIncomingDark  = Color(red: 0.122, green: 0.173, blue: 0.204) // #1F2C34

    // MARK: - Canvas
    static let waWallpaperLight = Color(red: 0.925, green: 0.898, blue: 0.867) // #ECE5DD
    static let waWallpaperDark  = Color(red: 0.043, green: 0.078, blue: 0.102) // #0B141A
    static let waCanvasLight    = Color.white                                   // #FFFFFF
    static let waCanvasDark     = Color(red: 0.067, green: 0.106, blue: 0.129) // #111B21
    static let waSurface1Light  = Color(red: 0.969, green: 0.973, blue: 0.980) // #F7F8FA
    static let waSurface1Dark   = Color(red: 0.125, green: 0.173, blue: 0.200) // #202C33
    static let waSurface2Dark   = Color(red: 0.165, green: 0.224, blue: 0.259) // #2A3942
    static let waDividerLight   = Color(red: 0.914, green: 0.929, blue: 0.937) // #E9EDEF
    static let waDividerDark    = Color(red: 0.133, green: 0.176, blue: 0.204) // #222D34

    // MARK: - Text
    static let waTextPrimary    = Color(red: 0.067, green: 0.106, blue: 0.129) // #111B21
    static let waTextSecondary  = Color(red: 0.400, green: 0.467, blue: 0.506) // #667781
    static let waTextTertiary   = Color(red: 0.525, green: 0.588, blue: 0.627) // #8696A0
    static let waTextPrimaryDark   = Color(red: 0.914, green: 0.929, blue: 0.937) // #E9EDEF
    static let waTextSecondaryDark = Color(red: 0.525, green: 0.588, blue: 0.627) // #8696A0

    // MARK: - Semantic
    static let waReadBlue      = Color(red: 0.325, green: 0.741, blue: 0.922) // #53BDEB
    static let waErrorRed      = Color(red: 0.945, green: 0.361, blue: 0.427) // #F15C6D
}

private enum LpspWhatsAppFonts {
    static let waLargeTitle    = Font.system(size: 34, weight: .bold)
    static let waNavTitle      = Font.system(size: 17, weight: .semibold)
    static let waContactName   = Font.system(size: 17, weight: .semibold)
    static let waMessagePreview = Font.system(size: 15, weight: .regular)
    static let waBubbleBody    = Font.system(size: 17, weight: .regular)
    static let waGroupSender   = Font.system(size: 13, weight: .semibold)
    static let waTimestampList = Font.system(size: 12, weight: .regular)
    static let waTimestampBubble = Font.system(size: 11, weight: .regular)
    static let waSectionHeader = Font.system(size: 13, weight: .semibold)
    static let waSystemMessage = Font.system(size: 12, weight: .medium)
    static let waTabLabel      = Font.system(size: 10, weight: .medium)
    static let waButton        = Font.system(size: 17, weight: .semibold)
    static let waInputPlaceholder = Font.system(size: 16, weight: .regular)
}

fileprivate struct LpspWhatsAppWASendButton: View {
    let hasText: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: hasText ? "paperplane.fill" : "mic.fill")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(Circle().fill(LpspWhatsAppTokens.waGreen))
                .contentTransition(.symbolEffect(.replace))
        }
        .sensoryFeedback(.impact(flexibility: .soft), trigger: hasText)
        .buttonStyle(LpspWhatsAppWAPressableStyle(pressedScale: 0.92))
    }
}

fileprivate struct LpspWhatsAppWAPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.22, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

fileprivate struct LpspWhatsAppWAOutgoingBubble: View {
    let text: String
    let timestamp: String
    let readState: ReadState

    enum ReadState { case sent, delivered, read }

    var body: some View {
        HStack {
            Spacer(minLength: UIScreen.main.bounds.width * 0.2)
            VStack(alignment: .trailing, spacing: 4) {
                Text(text)
                    .font(LpspWhatsAppFonts.waBubbleBody)
                    .foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
                HStack(spacing: 3) {
                    Text(timestamp)
                        .font(LpspWhatsAppFonts.waTimestampBubble)
                        .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                    tickView
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    bottomLeadingRadius: 12,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 12
                )
                .fill(LpspWhatsAppTokens.waOutgoingLight)
            )
        }
        .padding(.trailing, 8)
    }

    @ViewBuilder
    private var tickView: some View {
        switch readState {
        case .sent:
            Image(systemName: "checkmark")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
        case .delivered:
            HStack(spacing: -4) {
                Image(systemName: "checkmark")
                Image(systemName: "checkmark")
            }
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
        case .read:
            HStack(spacing: -4) {
                Image(systemName: "checkmark")
                Image(systemName: "checkmark")
            }
            .font(.system(size: 12, weight: .bold))
            .foregroundStyle(LpspWhatsAppTokens.waReadBlue)
        }
    }
}

fileprivate struct LpspWhatsAppWAChatListRow: View {
    let avatar: Image
    let name: String
    let preview: String
    let timestamp: String
    let unreadCount: Int
    let hasStatusRing: Bool

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                if hasStatusRing {
                    Circle()
                        .strokeBorder(LpspWhatsAppTokens.waGreen, lineWidth: 2.5)
                        .frame(width: 54, height: 54)
                }
                avatar
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(LpspWhatsAppFonts.waContactName)
                    .foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
                    .lineLimit(1)
                Text(preview)
                    .font(LpspWhatsAppFonts.waMessagePreview)
                    .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(timestamp)
                    .font(LpspWhatsAppFonts.waTimestampList)
                    .foregroundStyle(unreadCount > 0 ? LpspWhatsAppTokens.waGreen : LpspWhatsAppTokens.waTextSecondary)
                if unreadCount > 0 {
                    Text("\(unreadCount)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(LpspWhatsAppTokens.waGreen))
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspWhatsAppWAVoiceWaveformBubble: View {
    let duration: String
    @State private var isPlaying = false
    @State private var progress: Double = 0.0
    // Amplitude samples normalized 0..1
    let amplitudes: [CGFloat] = (0..<48).map { _ in CGFloat.random(in: 0.2...1.0) }

    var body: some View {
        HStack(spacing: 10) {
            Button {
                isPlaying.toggle()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(LpspWhatsAppTokens.waGreen))
            }
            .sensoryFeedback(.impact(flexibility: .soft), trigger: isPlaying)

            GeometryReader { geo in
                HStack(spacing: 2) {
                    ForEach(0..<amplitudes.count, id: \.self) { i in
                        let playedFraction = Double(i) / Double(amplitudes.count)
                        Capsule()
                            .fill(playedFraction <= progress ? LpspWhatsAppTokens.waGreen : LpspWhatsAppTokens.waTextTertiary)
                            .frame(width: 2, height: max(4, amplitudes[i] * 20))
                    }
                }
                .frame(height: 24)
            }
            .frame(height: 24)

            Text(duration)
                .font(LpspWhatsAppFonts.waTimestampBubble)
                .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: 12,
                bottomLeadingRadius: 12,
                bottomTrailingRadius: 0,
                topTrailingRadius: 12
            )
            .fill(LpspWhatsAppTokens.waOutgoingLight)
        )
    }
}

fileprivate struct LpspWhatsAppWAComposeBar: View {
    @State private var text: String = ""

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 10) {
                Button { } label: {
                    Image(systemName: "face.smiling")
                        .font(.system(size: 22))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                }
                TextField("Message", text: $text, axis: .vertical)
                    .font(LpspWhatsAppFonts.waInputPlaceholder)
                    .lineLimit(1...5)
                Button { } label: {
                    Image(systemName: "paperclip")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                        .rotationEffect(.degrees(-45))
                }
                Button { } label: {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(LpspWhatsAppTokens.waTextTertiary)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .background(Capsule().fill(Color.white))

            LpspWhatsAppWASendButton(hasText: !text.isEmpty) {
                text = ""
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(LpspWhatsAppTokens.waSurface1Light)
    }
}

fileprivate struct LpspWhatsAppWAChatScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top nav handled by NavigationStack
            ScrollView {
                LazyVStack(spacing: 2) {
                    LpspWhatsAppWAEncryptionBanner()
                    LpspWhatsAppWAOutgoingBubble(
                        text: "Hey are you around?",
                        timestamp: "10:24",
                        readState: .read
                    )
                    LpspWhatsAppWAIncomingBubble(text: "Yes, about to head out")
                    LpspWhatsAppWAVoiceWaveformBubble(duration: "0:23")
                }
                .padding(.vertical, 8)
            }
            .background(
                LpspWhatsAppTokens.waWallpaperLight
                    .overlay(LpspWhatsAppWADoodleWallpaper().opacity(0.08))
            )
            LpspWhatsAppWAComposeBar()
        }
    }
}

fileprivate struct LpspWhatsAppWAEncryptionBanner: View {
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "lock.fill").font(.system(size: 10))
            Text("Messages are end-to-end encrypted. No one outside this chat, not even WhatsApp, can read or listen to them.")
                .font(LpspWhatsAppFonts.waSystemMessage)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(LpspWhatsAppTokens.waTextSecondary)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Capsule().fill(Color(red: 1.0, green: 0.96, blue: 0.77)))
        .padding(.horizontal, 24)
    }
}

fileprivate struct LpspWhatsAppWAIncomingBubble: View {
    let text: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text).font(LpspWhatsAppFonts.waBubbleBody).foregroundStyle(LpspWhatsAppTokens.waTextPrimary)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 12,
                    topTrailingRadius: 12
                )
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 2, y: 1)
            )
            Spacer(minLength: UIScreen.main.bounds.width * 0.2)
        }
        .padding(.leading, 8)
    }
}

fileprivate struct LpspWhatsAppWADoodleWallpaper: View {
    // Decorative doodle tile — use an Image asset in production
    var body: some View { Color.clear }
}



// MARK: - Écrans showroom

private struct LpspWhatsAppShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspWhatsAppMessagingTabScreen(title: "Updates")
                .tabItem { Label("Updates", systemImage: "circle.dashed") }
                .tag(0)
            LpspWhatsAppCallsTabScreen()
                .tabItem { Label("Calls", systemImage: "phone.fill") }
                .tag(1)
            LpspWhatsAppMessagingTabScreen(title: "Communities")
                .tabItem { Label("Communities", systemImage: "person.3.fill") }
                .tag(2)
            LpspWhatsAppChatsTabScreen()
                .tabItem { Label("Chats", systemImage: "message.fill") }
                .tag(3)
            LpspWhatsAppMessagingTabScreen(title: "Settings")
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
                .tag(4)
        }
        .tint(LpspWhatsAppTokens.waErrorRed)
        .preferredColorScheme(.dark)
    }
}


private struct LpspWhatsAppGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspWhatsAppTokens.waErrorRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspWhatsAppTokens.waErrorRed))
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


private struct LpspWhatsAppDemoChat: Identifiable {
    let id = UUID()
    let name: String
    let preview: String
    let time: String
    let unread: Int
    let hasRing: Bool
}

private enum LpspWhatsAppDemoChats {
    static let chats: [LpspWhatsAppDemoChat] = [
        .init(name: "Alex Martin", preview: "On se voit ce soir ?", time: "10:24", unread: 2, hasRing: true),
        .init(name: "Léa Dupont", preview: "Merci pour hier", time: "Hier", unread: 0, hasRing: false),
        .init(name: "Famille", preview: "Photo: vacances", time: "Lun.", unread: 5, hasRing: true),
    ]
}

private struct LpspWhatsAppChatsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {

                ForEach(LpspWhatsAppDemoChats.chats) { chat in
                    NavigationLink {
                        LpspWhatsAppChatDetailScreen(chat: chat)
                    } label: {
                        LpspWhatsAppWAChatListRow(avatar: Image(systemName: "person.circle.fill"), name: chat.name, preview: chat.preview, timestamp: chat.time, unreadCount: chat.unread, hasStatusRing: chat.hasRing)
                    }
                }

            }
            .listStyle(.plain)
            .navigationTitle("Chats")
        }
    }
}


private struct LpspWhatsAppChatDetailScreen: View {
    let chat: LpspWhatsAppDemoChat
    var body: some View {
        LpspWhatsAppWAChatScreen()
            .navigationTitle(chat.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}


private struct LpspWhatsAppCallsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(LpspWhatsAppDemoChats.chats) { chat in
                HStack {
                    Circle().fill(LpspWhatsAppTokens.waErrorRed.opacity(0.15)).frame(width: 40, height: 40)
                        .overlay(Image(systemName: "phone.fill").foregroundStyle(LpspWhatsAppTokens.waErrorRed))
                    VStack(alignment: .leading) {
                        Text(chat.name).font(.system(size: 17, weight: .semibold))
                        Text("Appel vocal · Hier").font(.subheadline).foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: "info.circle").foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Appels")
        }
    }
}

private struct LpspWhatsAppMessagingTabScreen: View {
    let title: String
    var body: some View { LpspWhatsAppGenericTabScreen(title: title, tabIndex: 0) }
}

private struct LpspWhatsAppDemoBubble: View {
    let text: String
    var outgoing: Bool = true
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 60) }
            Text(text)
                .font(.system(size: 17))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspWhatsAppTokens.waErrorRed.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 8)
    }
}

private struct LpspWhatsAppDemoComposeBar: View {
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Message", text: $text)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill")
                .foregroundStyle(LpspWhatsAppTokens.waErrorRed)
                .font(.title2)
        }
        .padding(8)
        .background(.ultraThinMaterial)
    }
}



import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/signal
// Meliwat/awesome-ios-design-md/messaging/signal/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeSignalView: View {
    var body: some View {
        LpspSignalShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspSignalFonts {
    static let sigLargeTitle    = Font.system(size: 28, weight: .regular)
    static let sigConvoName     = Font.system(size: 17, weight: .regular)
    static let sigThreadTitle   = Font.system(size: 17, weight: .regular)
    static let sigMessageBody   = Font.system(size: 16, weight: .regular)
    static let sigPreview       = Font.system(size: 15, weight: .regular)
    static let sigSectionHeader = Font.system(size: 13, weight: .regular)
    static let sigTimestamp     = Font.system(size: 13, weight: .regular)
    static let sigBubbleMeta    = Font.system(size: 12, weight: .regular)
    static let sigButton        = Font.system(size: 16, weight: .regular)
    static let sigButtonText    = Font.system(size: 16, weight: .regular)
    static let sigTab           = Font.system(size: 10, weight: .regular)
    static let sigTimerChip     = Font.system(size: 12, weight: .regular)
    static let sigSystemNote    = Font.system(size: 13, weight: .regular)
    static let sigSafetyNumber  = Font.system(size: 15, weight: .regular)
    static func signal(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspSignalTokens {
    // MARK: - Canvas & Surfaces (light / dark via asset or scheme)
    static let sigCanvas       = Color(red: 1, green: 1, blue: 1)                // #FFFFFF
    static let sigCanvasDark   = Color(red: 0.106, green: 0.106, blue: 0.106)    // #1B1B1B
    static let sigSurface      = Color(red: 0.961, green: 0.961, blue: 0.961)    // #F5F5F5
    static let sigSurfaceDark  = Color(red: 0.165, green: 0.165, blue: 0.165)    // #2A2A2A
    static let sigDivider      = Color(red: 0.898, green: 0.898, blue: 0.898)    // #E5E5E5
    static let sigDividerDark  = Color(red: 0.227, green: 0.227, blue: 0.227)    // #3A3A3A

    // MARK: - Text
    static let sigTextPrimary   = Color.black                                    // #000000
    static let sigTextPrimaryD  = Color.white                                    // #FFFFFF
    static let sigTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)   // #6B6B6B
    static let sigTextTertiary  = Color(red: 0.604, green: 0.604, blue: 0.604)   // #9A9A9A

    // MARK: - Brand
    static let sigBlue        = Color(red: 0.227, green: 0.463, blue: 0.941)     // #3A76F0
    static let sigBluePressed = Color(red: 0.184, green: 0.373, blue: 0.800)     // #2F5FCC
    static let sigBlueTint    = Color(red: 0.906, green: 0.933, blue: 0.992)     // #E7EEFD

    // MARK: - Message
    static let sigIncoming     = Color(red: 0.914, green: 0.914, blue: 0.922)    // #E9E9EB
    static let sigIncomingDark = Color(red: 0.165, green: 0.165, blue: 0.165)    // #2A2A2A
    static let sigOutMeta      = Color(red: 0.796, green: 0.851, blue: 0.976)    // #CBD9F9

    // MARK: - Semantic
    static let sigError   = Color(red: 0.843, green: 0.149, blue: 0.239)         // #D7263D
    static let sigSuccess = Color(red: 0.227, green: 0.710, blue: 0.290)         // #3AB54A
}





fileprivate struct LpspSignalMessageBubble: View {
    let text: String
    let time: String
    let isOutgoing: Bool
    let isLastInRun: Bool   // tighten the tail corner when true

    private var tail: LpspSignalRoundedCorner {
        LpspSignalRoundedCorner(radius: 18,
                      tightCorner: isOutgoing ? .bottomRight : .bottomLeft,
                      tightRadius: isLastInRun ? 6 : 18)
    }

    var body: some View {
        HStack {
            if isOutgoing { Spacer(minLength: 0) }
            VStack(alignment: .trailing, spacing: 2) {
                Text(text)
                    .font(LpspSignalFonts.sigMessageBody)
                    .foregroundStyle(isOutgoing ? .white : LpspSignalTokens.sigTextPrimary)
                HStack(spacing: 3) {
                    Text(time).font(LpspSignalFonts.sigBubbleMeta)
                    if isOutgoing {
                        Image(systemName: "checkmark").font(.system(size: 10, weight: .bold))
                    }
                }
                .foregroundStyle(isOutgoing ? LpspSignalTokens.sigOutMeta : LpspSignalTokens.sigTextSecondary)
            }
            .padding(.vertical, 9)
            .padding(.horizontal, 13)
            .background(isOutgoing ? LpspSignalTokens.sigBlue : LpspSignalTokens.sigIncoming)
            .clipShape(tail)
            .frame(maxWidth: 280, alignment: isOutgoing ? .trailing : .leading)
            if !isOutgoing { Spacer(minLength: 0) }
        }
        .padding(.horizontal, 12)
    }
}

// Per-corner radius shape for the same-sender tail
fileprivate struct LpspSignalRoundedCorner: Shape {
    var radius: CGFloat
    var tightCorner: UIRectCorner
    var tightRadius: CGFloat
    func path(in rect: CGRect) -> Path {
        let corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        var path = Path()
        for c in [UIRectCorner.topLeft, .topRight, .bottomLeft, .bottomRight] where corners.contains(c) {
            _ = c
        }
        // Simplified: use a UIBezierPath with mixed radii
        let p = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                             cornerRadii: CGSize(width: radius, height: radius))
        path = Path(p.cgPath)
        // Re-round the tight corner smaller
        let tp = UIBezierPath(roundedRect: rect, byRoundingCorners: tightCorner,
                              cornerRadii: CGSize(width: tightRadius, height: tightRadius))
        return Path(tp.cgPath).intersection(path).isEmpty ? Path(p.cgPath) : path
    }
}

fileprivate struct LpspSignalComposerBar: View {
    @State private var text = ""

    private var hasText: Bool { !text.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 22)).foregroundStyle(LpspSignalTokens.sigTextSecondary)
                TextField("Signal message", text: $text, axis: .vertical)
                    .font(LpspSignalFonts.sigMessageBody)
                    .lineLimit(1...5)
                Image(systemName: "camera")
                    .font(.system(size: 20)).foregroundStyle(LpspSignalTokens.sigTextSecondary)
            }
            .padding(.horizontal, 12)
            .frame(minHeight: 36)
            .background(Capsule().fill(LpspSignalTokens.sigSurface))

            // Send circle: only when text exists; mic when empty
            LpspSignalSendCircle(showSend: hasText) {
                text = ""
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .animation(.spring(response: 0.18, dampingFraction: 0.8), value: hasText)
    }
}

fileprivate struct LpspSignalSendCircle: View {
    let showSend: Bool
    let action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle().fill(pressed ? LpspSignalTokens.sigBluePressed : LpspSignalTokens.sigBlue)
                Image(systemName: showSend ? "arrow.up" : "mic.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 32, height: 32)
            .scaleEffect(pressed ? 0.90 : 1)
            .opacity(showSend ? 1 : 0.92)
            .offset(y: showSend ? 0 : 4) // slides up into place when text appears
        }
        .sensoryFeedback(.impact(weight: .light), trigger: showSend)
        .simultaneousGesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in pressed = true }
            .onEnded { _ in pressed = false })
    }
}

fileprivate struct LpspSignalConversationRow: View {
    let name: String
    let preview: String
    let time: String
    let unread: Int
    let disappearing: Bool

    var body: some View {
        HStack(spacing: 12) {
            Circle().fill(LpspSignalTokens.sigSurface).frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 5) {
                    Text(name).font(LpspSignalFonts.sigConvoName).foregroundStyle(LpspSignalTokens.sigTextPrimary)
                    if disappearing {
                        Image(systemName: "timer").font(.system(size: 12))
                            .foregroundStyle(LpspSignalTokens.sigTextSecondary)
                    }
                }
                Text(preview).font(LpspSignalFonts.sigPreview).foregroundStyle(LpspSignalTokens.sigTextSecondary)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Text(time).font(LpspSignalFonts.sigTimestamp).foregroundStyle(LpspSignalTokens.sigTextSecondary)
                if unread > 0 {
                    Text("\(unread)")
                        .font(LpspSignalFonts.sigBubbleMeta).foregroundStyle(.white)
                        .frame(minWidth: 20, minHeight: 20)
                        .background(Circle().fill(LpspSignalTokens.sigBlue))
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(height: 72)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspSignalTimerChip: View {
    let duration: String  // "1w", "8h", "Off"
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "timer").font(.system(size: 12))
            Text(duration).font(LpspSignalFonts.sigTimerChip)
        }
        .foregroundStyle(LpspSignalTokens.sigTextSecondary) // privacy is quiet — neutral, never blue/red
    }
}

fileprivate struct LpspSignalEncryptionNote: View {
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "lock.fill").font(.system(size: 11))
            Text("Messages and calls are end-to-end encrypted.")
                .font(LpspSignalFonts.sigSystemNote)
        }
        .foregroundStyle(LpspSignalTokens.sigTextSecondary)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }
}



// MARK: - Écrans showroom

private struct LpspSignalShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspSignalSpectrHomeTabScreen()
                .tabItem { Label("Chats", systemImage: "message.fill") }
                .tag(0)
            LpspSignalCallsTabScreen()
                .tabItem { Label("Calls", systemImage: "phone.fill") }
                .tag(1)
            LpspSignalMessagingTabScreen(title: "Stories")
                .tabItem { Label("Stories", systemImage: "circle.dashed") }
                .tag(2)
            LpspSignalSettingsTabScreen()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
                .tag(3)
        }
        .tint(LpspSignalTokens.sigTextPrimary)
        
    }
}


private struct LpspSignalGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspSignalTokens.sigTextPrimary.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspSignalTokens.sigTextPrimary))
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


private struct LpspSignalPlaceholderChatRow: View {
    let name: String
    let preview: String
    let time: String
    var body: some View {
        HStack(spacing: 12) {
            Circle().fill(LpspSignalTokens.sigTextPrimary.opacity(0.2)).frame(width: 48, height: 48)
                .overlay(Text(String(name.prefix(1))).font(.headline).foregroundStyle(LpspSignalTokens.sigTextPrimary))
            VStack(alignment: .leading) {
                Text(name).font(.system(size: 17, weight: .semibold))
                Text(preview).font(.system(size: 15)).foregroundStyle(.secondary).lineLimit(1)
            }
            Spacer()
            Text(time).font(.system(size: 12)).foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
    }
}

private struct LpspSignalDemoChat: Identifiable {
    let id = UUID()
    let name: String
    let preview: String
    let time: String
    let unread: Int
    let hasRing: Bool
}

private enum LpspSignalDemoChats {
    static let chats: [LpspSignalDemoChat] = [
        .init(name: "Alex Martin", preview: "On se voit ce soir ?", time: "10:24", unread: 2, hasRing: true),
        .init(name: "Léa Dupont", preview: "Merci pour hier", time: "Hier", unread: 0, hasRing: false),
        .init(name: "Famille", preview: "Photo: vacances", time: "Lun.", unread: 5, hasRing: true),
    ]
}

private struct LpspSignalChatsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {

                ForEach(LpspSignalDemoChats.chats) { chat in
                    NavigationLink {
                        LpspSignalChatDetailScreen(chat: chat)
                    } label: {
                        LpspSignalPlaceholderChatRow(name: chat.name, preview: chat.preview, time: chat.time)
                    }
                }

            }
            .listStyle(.plain)
            .navigationTitle("Chats")
        }
    }
}


private struct LpspSignalChatDetailScreen: View {
    let chat: LpspSignalDemoChat
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 8) {

                    LpspSignalDemoBubble(text: "Salut, tu es dispo ?", outgoing: true)
                    LpspSignalDemoBubble(text: "Oui, j'arrive !", outgoing: false)

                }
                .padding(.vertical, 8)
            }
            .background(LpspSignalTokens.sigCanvas.ignoresSafeArea())
            LpspSignalDemoComposeBar()
        }
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


private struct LpspSignalCallsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(LpspSignalDemoChats.chats) { chat in
                HStack {
                    Circle().fill(LpspSignalTokens.sigTextPrimary.opacity(0.15)).frame(width: 40, height: 40)
                        .overlay(Image(systemName: "phone.fill").foregroundStyle(LpspSignalTokens.sigTextPrimary))
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

private struct LpspSignalMessagingTabScreen: View {
    let title: String
    var body: some View {
        let low = title.lowercased()
        if low.contains("update") { LpspSignalUpdatesTabScreen() }
        else if low.contains("setting") || low.contains("réglage") { LpspSignalSettingsTabScreen() }
        else if low.contains("communit") { LpspSignalCommunitiesTabScreen() }
        else if low.contains("contact") { LpspSignalContactsTabScreen() }
        else { LpspSignalChatsTabScreen() }
    }
}

private struct LpspSignalUpdatesTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(LpspSignalDemoStories.items) { s in
                        VStack(spacing: 4) {
                            Circle().strokeBorder(LpspSignalTokens.sigTextPrimary, lineWidth: 2).frame(width: 66, height: 66)
                            Text(s.name).font(.caption).lineLimit(1).frame(width: 72)
                        }
                    }
                }
                .padding(.horizontal, 12).padding(.vertical, 10)
            }
            .navigationTitle("Updates")
        }
    }
}

private struct LpspSignalDemoStoryItem: Identifiable { let id = UUID(); let name: String }
private enum LpspSignalDemoStories {
    static let items: [LpspSignalDemoStoryItem] = [
        .init(name: "Votre statut"), .init(name: "Alex"), .init(name: "Léa"),
    ]
}

private struct LpspSignalSettingsTabScreen: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Compte") { Label("Profil", systemImage: "person.circle"); Label("Confidentialité", systemImage: "lock") }
                Section("App") { Label("Notifications", systemImage: "bell"); Label("Stockage", systemImage: "internaldrive") }
            }
            .navigationTitle("Settings")
        }
    }
}

private struct LpspSignalCommunitiesTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Famille", "Équipe projet"], id: \.self) { Label($0, systemImage: "person.3") }
            .navigationTitle("Communities")
        }
    }
}

private struct LpspSignalContactsTabScreen: View {
    var body: some View {
        NavigationStack {
            List(["Alex Martin", "Léa Dupont"], id: \.self) { Label($0, systemImage: "person.circle") }
            .navigationTitle("Contacts")
        }
    }
}

private struct LpspSignalDemoBubble: View {
    let text: String
    var outgoing: Bool = true
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 60) }
            Text(text)
                .font(.system(size: 17))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspSignalTokens.sigTextPrimary.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 8)
    }
}

private struct LpspSignalDemoComposeBar: View {
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Message", text: $text)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill")
                .foregroundStyle(LpspSignalTokens.sigTextPrimary)
                .font(.title2)
        }
        .padding(8)
        .background(.ultraThinMaterial)
    }
}


private struct LpspSignalSpectrHomeTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
        HStack(spacing: 10) {
                Text("Renata Vogel").font(.system(size: 17.0, weight: .semibold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("1 week").font(.system(size: 12.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        } .padding(.horizontal, 12).frame(height: 56)
        ScrollView {
            VStack(spacing: 8) {
            Text("Messages and calls are end-to-end encrypted.").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Are we still on for the design review tomorrow?").font(.system(size: 16.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                HStack {
                    Spacer(minLength: 48)
                    Text("Pushed it to 2pm so the whole team can make it.").font(.system(size: 16)).foregroundStyle(.white)
                        .padding(.horizontal, 12).padding(.vertical, 8)
                        .background(Color(red: 0.000, green: 0.584, blue: 0.965)).clipShape(RoundedRectangle(cornerRadius: 18))
                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.horizontal, 12)
                Text("Perfect, 2pm works.").font(.system(size: 16.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                HStack {
                    Spacer(minLength: 48)
                    Text("I'll bring the updated bubble specs and the timer-chip mocks.").font(.system(size: 16)).foregroundStyle(.white)
                        .padding(.horizontal, 12).padding(.vertical, 8)
                        .background(Color(red: 0.000, green: 0.584, blue: 0.965)).clipShape(RoundedRectangle(cornerRadius: 18))
                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.horizontal, 12)
                HStack {
                    Spacer(minLength: 48)
                    Text("See you then 🙌").font(.system(size: 16)).foregroundStyle(.white)
                        .padding(.horizontal, 12).padding(.vertical, 8)
                        .background(Color(red: 0.000, green: 0.584, blue: 0.965)).clipShape(RoundedRectangle(cornerRadius: 18))
                }.frame(maxWidth: .infinity, alignment: .trailing).padding(.horizontal, 12)
            }
            .padding(.vertical, 8)
        }
                Text("Signal message").font(.system(size: 16.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        }
        .background(Color(red: 0.106, green: 0.106, blue: 0.106).ignoresSafeArea())
    }
}



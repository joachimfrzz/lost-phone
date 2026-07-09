import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/zoom
// Meliwat/awesome-ios-design-md/productivity/zoom/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeZoomView: View {
    var body: some View {
        LpspZoomShowroomRoot(store: LpspZoomStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspZoomFonts {
    static let zoomTitleLarge   = Font.system(size: 28, weight: .regular)
    static let zoomMeetingTopic = Font.system(size: 22, weight: .regular)
    static let zoomSection      = Font.system(size: 17, weight: .regular)
    static let zoomListTitle    = Font.system(size: 16, weight: .semibold)
    static let zoomBody         = Font.system(size: 15, weight: .regular)
    static let zoomButton       = Font.system(size: 17, weight: .bold)
    static let zoomControlLabel = Font.system(size: 11, weight: .semibold)
    static let zoomMetadata     = Font.system(size: 13, weight: .regular)
    static let zoomTileName     = Font.system(size: 13, weight: .semibold)
    static let zoomTimer        = Font.system(size: 14, weight: .bold)
    static let zoomTab          = Font.system(size: 10, weight: .regular)
    static let zoomTinyUpper    = Font.system(size: 11, weight: .regular)
    static func zoom(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

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



// System fallback if Lato is unavailable


fileprivate extension View {
    func zoomTabular() -> some View { self.monospacedDigit() }
}

fileprivate struct LpspZoomGalleryTile: View {
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
                        .font(LpspZoomFonts.zoom(20, weight: .semibold))
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
        .animation(.easeInOut(duration: 0.22), value: isActiveSpeaker)
    }

    private func initials(_ s: String) -> String {
        s.split(separator: " ").prefix(2).compactMap { $0.first }.map(String.init).joined()
    }
}

fileprivate struct LpspZoomJoinButton: View {
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
        .sensoryFeedback(.impact(weight: .medium), trigger: title)
    }
}

fileprivate struct LpspZoomZoomPressable: ButtonStyle {
    var pressedColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .overlay(configuration.isPressed
                ? RoundedRectangle(cornerRadius: 8).fill(pressedColor).blendMode(.multiply)
                : nil)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspZoomControlBar: View {
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
                    .font(LpspZoomFonts.zoom(15, weight: .bold))
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

fileprivate struct LpspZoomControlButton: View {
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

fileprivate struct LpspZoomMeetingRow: View {
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
                    .font(LpspZoomFonts.zoom(14, weight: .bold))
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

fileprivate struct LpspZoomRecordingIndicator: View {
    @State private var pulse = false
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(LpspZoomTokens.zoomRed)
                .frame(width: 10, height: 10)
                .scaleEffect(pulse ? 0.7 : 1.0)
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulse)
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

fileprivate struct LpspZoomGalleryGrid: View {
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
        .animation(.easeInOut(duration: 0.3), value: participants.count)
    }

    private func gridColumns(for n: Int) -> [GridItem] {
        let cols = n <= 1 ? 1 : n <= 4 ? 2 : 3
        return Array(repeating: GridItem(.flexible(), spacing: 4), count: cols)
    }
}

fileprivate struct LpspZoomParticipant: Identifiable {
    let id: String
    let name: String
    let initials: String
    var isMuted: Bool
    var isSpeaking: Bool
}

// MARK: - Données & état (showroom Lost Phone)

fileprivate struct LpspZoomShowroomMeeting: Identifiable {
    let id: String
    let time: String
    let topic: String
    let subtitle: String
    let meetingID: String
    let isSpectrDemo: Bool
}

fileprivate struct LpspZoomShowroomChatMessage: Identifiable {
    let id: String
    let author: String
    let text: String
    let time: String
}

private enum LpspZoomMobileTab: CaseIterable {
    case meetings, teamChat, mail, phone, more

    var label: String {
        switch self {
        case .meetings: "Meetings"
        case .teamChat: "Team Chat"
        case .mail: "Mail"
        case .phone: "Phone"
        case .more: "More"
        }
    }

    var icon: String {
        switch self {
        case .meetings: "video.fill"
        case .teamChat: "bubble.left.and.bubble.right.fill"
        case .mail: "envelope.fill"
        case .phone: "phone.fill"
        case .more: "ellipsis"
        }
    }
}

@MainActor
fileprivate final class LpspZoomStore: ObservableObject {
    @Published var selectedTab: LpspZoomMobileTab = .meetings
    @Published var inCall = false
    @Published var activeMeetingID: String?
    @Published var participants: [LpspZoomParticipant] = []
    @Published var micOn = false
    @Published var videoOn = true
    @Published var controlsVisible = true
    @Published var isRecording = false
    @Published var callElapsedSeconds = 754
    @Published var meetingIDInput = ""
    @Published var showJoinSheet = false
    @Published var chats: [LpspZoomShowroomChatMessage]

    let meetings: [LpspZoomShowroomMeeting]

    init() {
        self.meetings = LpspZoomShowroomData.meetings
        self.chats = LpspZoomShowroomData.chats
    }

    var callTimerLabel: String {
        let minutes = callElapsedSeconds / 60
        let seconds = callElapsedSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    func joinMeeting(_ meeting: LpspZoomShowroomMeeting) {
        activeMeetingID = meeting.id
        participants = meeting.isSpectrDemo
            ? LpspZoomShowroomData.spectrParticipants
            : LpspZoomShowroomData.storyParticipants
        isRecording = meeting.isSpectrDemo
        callElapsedSeconds = meeting.isSpectrDemo ? 754 : 0
        micOn = false
        videoOn = true
        controlsVisible = true
        inCall = true
        selectedTab = .meetings
    }

    func joinWithID() {
        let trimmed = meetingIDInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        activeMeetingID = "adhoc"
        participants = LpspZoomShowroomData.storyParticipants
        isRecording = false
        callElapsedSeconds = 0
        micOn = true
        videoOn = true
        inCall = true
        showJoinSheet = false
        meetingIDInput = ""
    }

    func leaveCall() {
        inCall = false
        activeMeetingID = nil
        participants = []
        isRecording = false
    }

    func revealControls() {
        controlsVisible = true
    }

    func toggleActiveSpeaker() {
        guard let index = participants.firstIndex(where: \.isSpeaking) else { return }
        var updated = participants
        let next = (index + 1) % updated.count
        for i in updated.indices {
            updated[i].isSpeaking = i == next
        }
        participants = updated
    }

    func sendChat(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        chats.insert(
            LpspZoomShowroomChatMessage(id: UUID().uuidString, author: "Mathieu G.", text: trimmed, time: "Now"),
            at: 0
        )
    }
}

private enum LpspZoomShowroomData {
    static let spectrParticipants: [LpspZoomParticipant] = [
        .init(id: "ar", name: "Alex Rivera", initials: "AR", isMuted: false, isSpeaking: true),
        .init(id: "mk", name: "Mia Kado", initials: "MK", isMuted: true, isSpeaking: false),
        .init(id: "jt", name: "Jon Tao", initials: "JT", isMuted: false, isSpeaking: false),
        .init(id: "sp", name: "Sam Park", initials: "SP", isMuted: true, isSpeaking: false),
    ]

    static let storyParticipants: [LpspZoomParticipant] = [
        .init(id: "nk", name: "Nadia K.", initials: "NK", isMuted: false, isSpeaking: true),
        .init(id: "vm", name: "Vincent Morel", initials: "VM", isMuted: true, isSpeaking: false),
        .init(id: "mg", name: "Mathieu G.", initials: "MG", isMuted: false, isSpeaking: false),
        .init(id: "sr", name: "Sam R.", initials: "SR", isMuted: false, isSpeaking: false),
    ]

    static let meetings: [LpspZoomShowroomMeeting] = [
        .init(
            id: "weekly-sync",
            time: "10:00 AM",
            topic: "Weekly Sync",
            subtitle: "45 min · Zoom Meeting",
            meetingID: "842 115 9033",
            isSpectrDemo: true
        ),
        .init(
            id: "brief-s7",
            time: "6:00 PM",
            topic: "Brief vitrine S7",
            subtitle: "Mer 18 juin · EventsCult",
            meetingID: "718 442 1190",
            isSpectrDemo: false
        ),
        .init(
            id: "logistique",
            time: "9:30 PM",
            topic: "Point logistique Gennevilliers",
            subtitle: "Sam R. · 30 min",
            meetingID: "555 902 4412",
            isSpectrDemo: false
        ),
    ]

    static let chats: [LpspZoomShowroomChatMessage] = [
        .init(id: "c1", author: "Nadia K.", text: "Plus de photos dans les salles — on arrête les repérages.", time: "09:14"),
        .init(id: "c2", author: "Vincent Morel", text: "Badge périmé mais couloirs Denon OK.", time: "Hier"),
        .init(id: "c3", author: "Sam R.", text: "Camionnette validée côté Gennevilliers.", time: "2 juin"),
    ]
}

// MARK: - Écrans showroom

private struct LpspZoomShowroomRoot: View {
    @ObservedObject var store: LpspZoomStore

    var body: some View {
        ZStack {
            if store.inCall {
                LpspZoomInCallScreen(store: store)
                    .transition(.opacity)
            } else {
                VStack(spacing: 0) {
                    Group {
                        switch store.selectedTab {
                        case .meetings:
                            LpspZoomMeetingsScreen(store: store)
                        case .teamChat:
                            LpspZoomTeamChatScreen(store: store)
                        case .mail:
                            LpspZoomMailScreen()
                        case .phone:
                            LpspZoomPhoneScreen()
                        case .more:
                            LpspZoomMoreScreen()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    LpspZoomMobileTabBar(store: store)
                }
                .background(LpspZoomTokens.zoomLightCanvas.ignoresSafeArea())
            }
        }
        .sheet(isPresented: $store.showJoinSheet) {
            LpspZoomJoinSheet(store: store)
        }
    }
}

private struct LpspZoomMobileTabBar: View {
    @ObservedObject var store: LpspZoomStore

    var body: some View {
        HStack(spacing: 0) {
            ForEach(LpspZoomMobileTab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) { store.selectedTab = tab }
                } label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18, weight: store.selectedTab == tab ? .semibold : .regular))
                        Text(tab.label)
                            .font(LpspZoomFonts.zoomTab)
                    }
                    .foregroundStyle(store.selectedTab == tab ? LpspZoomTokens.zoomBlue : LpspZoomTokens.zoomTextTertiary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(LpspZoomTokens.zoomLightCanvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspZoomTokens.zoomLightDivider).frame(height: 0.5)
        }
    }
}

private struct LpspZoomInCallScreen: View {
    @ObservedObject var store: LpspZoomStore
    @State private var hideTask: Task<Void, Never>?

    var body: some View {
        ZStack {
            LpspZoomTokens.zoomCanvas.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    if store.isRecording {
                        LpspZoomRecordingIndicator()
                    }
                    Spacer()
                    Text(store.callTimerLabel)
                        .font(LpspZoomFonts.zoomTimer)
                        .foregroundStyle(LpspZoomTokens.zoomTextPrimary)
                        .zoomTabular()
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                LpspZoomShowroomGalleryGrid(participants: store.participants)
                    .padding(.top, 8)
                    .onTapGesture {
                        store.revealControls()
                        scheduleHide()
                    }

                Spacer()

                if store.controlsVisible {
                    LpspZoomControlBar(
                        micOn: $store.micOn,
                        videoOn: $store.videoOn,
                        onLeave: { store.leaveCall() }
                    )
                    .padding(.bottom, 16)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear { scheduleHide() }
        .onChange(of: store.controlsVisible) { _, visible in
            if visible { scheduleHide() }
        }
        .onDisappear { hideTask?.cancel() }
    }

    private func scheduleHide() {
        hideTask?.cancel()
        hideTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: 4_000_000_000)
            guard !Task.isCancelled else { return }
            withAnimation(.easeOut(duration: 0.25)) {
                store.controlsVisible = false
            }
        }
    }
}

private struct LpspZoomShowroomGalleryGrid: View {
    let participants: [LpspZoomParticipant]

    var body: some View {
        let columns = gridColumns(for: participants.count)
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(participants) { participant in
                LpspZoomGalleryTile(
                    name: participant.name,
                    isMuted: participant.isMuted,
                    isActiveSpeaker: participant.isSpeaking
                )
                .aspectRatio(1, contentMode: .fit)
            }
        }
        .padding(8)
        .animation(.easeInOut(duration: 0.3), value: participants.map(\.id))
    }

    private func gridColumns(for count: Int) -> [GridItem] {
        let cols = count <= 1 ? 1 : 2
        return Array(repeating: GridItem(.flexible(), spacing: 8), count: cols)
    }
}

private struct LpspZoomMeetingsScreen: View {
    @ObservedObject var store: LpspZoomStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    LpspZoomJoinButton(title: "Join a meeting") {
                        store.showJoinSheet = true
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                    LpspZoomJoinButton(title: "New meeting") {
                        if let demo = store.meetings.first(where: \.isSpectrDemo) {
                            store.joinMeeting(demo)
                        }
                    }
                    .padding(.horizontal, 16)

                    Text("Upcoming")
                        .font(LpspZoomFonts.zoomSection.weight(.semibold))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                    ForEach(store.meetings) { meeting in
                        LpspZoomMeetingRow(
                            time: meeting.time,
                            topic: meeting.topic,
                            subtitle: meeting.subtitle,
                            onJoin: { store.joinMeeting(meeting) }
                        )
                    }
                }
                .padding(.bottom, 16)
            }
            .background(LpspZoomTokens.zoomCanvas.ignoresSafeArea())
            .navigationTitle("Meetings")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

private struct LpspZoomJoinSheet: View {
    @ObservedObject var store: LpspZoomStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Meeting ID", text: $store.meetingIDInput)
                    .keyboardType(.numberPad)
                    .font(LpspZoomFonts.zoomBody)
                    .padding(12)
                    .background(LpspZoomTokens.zoomLightSurface, in: RoundedRectangle(cornerRadius: 8))

                LpspZoomJoinButton(title: "Join") {
                    store.joinWithID()
                    dismiss()
                }

                Spacer()
            }
            .padding(16)
            .navigationTitle("Join")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

private struct LpspZoomTeamChatScreen: View {
    @ObservedObject var store: LpspZoomStore
    @State private var draft = ""

    var body: some View {
        NavigationStack {
            List(store.chats) { message in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(message.author)
                            .font(LpspZoomFonts.zoomListTitle)
                        Spacer()
                        Text(message.time)
                            .font(LpspZoomFonts.zoomMetadata)
                            .foregroundStyle(LpspZoomTokens.zoomTextTertiary)
                    }
                    Text(message.text)
                        .font(LpspZoomFonts.zoomBody)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
            .listStyle(.plain)
            .navigationTitle("Team Chat")
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 8) {
                    TextField("Message…", text: $draft)
                        .textFieldStyle(.roundedBorder)
                    Button("Send") {
                        store.sendChat(draft)
                        draft = ""
                    }
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(12)
                .background(.bar)
            }
        }
    }
}

private struct LpspZoomMailScreen: View {
    var body: some View {
        NavigationStack {
            List(["Inbox", "Sent", "Drafts"], id: \.self) { item in
                Label(item, systemImage: "envelope")
            }
            .navigationTitle("Mail")
        }
    }
}

private struct LpspZoomPhoneScreen: View {
    var body: some View {
        NavigationStack {
            List(["Nadia K.", "Vincent Morel", "Sam R."], id: \.self) { name in
                Label(name, systemImage: "phone")
            }
            .navigationTitle("Phone")
        }
    }
}

private struct LpspZoomMoreScreen: View {
    var body: some View {
        NavigationStack {
            List(["Settings", "Help", "Sign out"], id: \.self) { item in
                Label(item, systemImage: item == "Settings" ? "gearshape" : item == "Help" ? "questionmark.circle" : "rectangle.portrait.and.arrow.right")
            }
            .navigationTitle("More")
        }
    }
}


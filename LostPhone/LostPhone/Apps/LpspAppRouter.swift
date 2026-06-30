import SwiftUI

struct LpspAppContainerView: View {
    let appName: String
    @EnvironmentObject private var phone: PhoneViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject private var volumeObserver = VolumeObserver()
    @State private var initialVolume: Float = 0

    var body: some View {
        LpspAppRouter(appName: appName)
            .environment(\.lpspReadOnly, true)
            .environment(\.deviceOwner, phone.deviceOwner)
            .onAppear { initialVolume = volumeObserver.volume }
            .onChange(of: volumeObserver.volume) { _, newVolume in
                if abs(newVolume - initialVolume) > 0.001 {
                    phone.closeApp()
                    dismiss()
                }
                initialVolume = newVolume
            }
    }
}

struct LpspAppRouter: View {
    let appName: String
    @EnvironmentObject private var phone: PhoneViewModel

    private var contacts: [PhoneContact] {
        LpspCloneBridge.phoneContacts(from: LpspAdapters.contacts(from: phone.contactsPayload()))
    }

    var body: some View {
        let payload = phone.appData(for: appName)

        Group {
            if CloneAppCatalog.isCloneApp(appName) {
                cloneView(named: appName, payload: payload)
            } else {
                switch appName {
                case "WhatsApp":
                    LpspWhatsAppView(conversations: LpspAdapters.whatsApp(from: payload))
                case "Signal":
                    LpspSignalView(conversations: LpspAdapters.signal(from: payload))
                case "Contacts":
                    ContactsView(contacts: contacts)
                default:
                    GenericLpspAppView(appName: appName, payload: payload)
                }
            }
        }
    }

    @ViewBuilder
    private func cloneView(named appName: String, payload: AnyCodable?) -> some View {
        switch appName {
        case "Messages":
            MessagesView(viewModel: LpspCloneBridge.messagesViewModel(from: LpspAdapters.messages(from: payload)))
        case "Telephone":
            PhoneView(
                recentCalls: LpspCloneBridge.recentCalls(from: LpspAdapters.phoneRecents(from: payload)),
                contacts: contacts
            )
        case "Photos":
            PhotosView(library: LpspCloneBridge.photoLibrary(from: LpspAdapters.photos(from: payload)))
        case "Safari":
            SafariView(model: LpspCloneBridge.safariViewModel(
                tabs: LpspAdapters.safariTabs(from: payload),
                history: LpspAdapters.safariHistory(from: payload)
            ))
        case "Mail":
            MailView(manager: LpspCloneBridge.mailManager(from: LpspAdapters.mail(from: payload)))
        case "Notes":
            NotesView(manager: LpspCloneBridge.notesManager(from: LpspAdapters.notes(from: payload)))
        case "Calendrier":
            CalendarView(events: LpspCloneBridge.calendarEvents(from: LpspAdapters.calendar(from: payload)))
        case "Réglages", "Settings":
            SettingsView()
        case "Météo", "Weather":
            WeatherView()
        case "Horloge", "Clock":
            ClockView()
        case "Calculatrice", "Calculator":
            CalculatorView()
        case "Appareil photo", "Camera", "Caméra":
            CameraView()
        case "App Store":
            AppStoreView()
        case "Musique", "Music":
            MusicView(manager: LpspCloneBridge.musicManager(from: payload))
        default:
            if let type = CloneAppCatalog.appType(for: appName) {
                legacyCloneView(type, payload: payload)
            } else {
                GenericLpspAppView(appName: appName, payload: payload)
            }
        }
    }

    @ViewBuilder
    private func legacyCloneView(_ type: AppType, payload: AnyCodable?) -> some View {
        switch type {
        case .weather: WeatherView()
        case .calculator: CalculatorView()
        case .settings: SettingsView()
        case .appStore: AppStoreView()
        case .clock: ClockView()
        case .calendar:
            CalendarView(events: LpspCloneBridge.calendarEvents(from: LpspAdapters.calendar(from: payload)))
        case .camera: CameraView()
        case .music: MusicView(manager: LpspCloneBridge.musicManager(from: payload))
        default:
            GenericLpspAppView(appName: appName, payload: payload)
        }
    }
}

struct GenericLpspAppView: View {
    let appName: String
    let payload: AnyCodable?

    var body: some View {
        NavigationStack {
            ScrollView {
                if let payload {
                    Text(prettyJSON(payload))
                        .font(.system(.footnote, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                } else {
                    ContentUnavailableView(
                        appName,
                        systemImage: "app.fill",
                        description: Text("Contenu LPSP absent pour cette app.")
                    )
                }
            }
            .navigationTitle(appName)
        }
    }

    private func prettyJSON(_ value: AnyCodable) -> String {
        guard let data = try? JSONEncoder().encode(value),
              let string = String(data: data, encoding: .utf8) else {
            return "Contenu illisible"
        }
        return string
    }
}

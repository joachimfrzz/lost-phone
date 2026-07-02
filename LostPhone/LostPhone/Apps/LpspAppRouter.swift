import SwiftUI

struct LpspAppContainerView: View {
    let appName: String
    @EnvironmentObject private var phone: PhoneViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject private var volumeObserver = VolumeObserver()
    @State private var initialVolume: Float = 0

    var body: some View {
        ZStack {
            Group {
                if phone.isCloneShowroom {
                    LpspAppRouter(appName: appName, useShowroomDefaults: true)
                } else {
                    LpspAppRouter(appName: appName)
                }
            }
            .environment(\.lpspReadOnly, !phone.isCloneShowroom)
            .environment(\.lpspStoryId, phone.currentStoryId)
            .environment(\.deviceOwner, phone.deviceOwner)

            if phone.isCloneShowroom {
                VStack {
                    HStack {
                        Button {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            phone.closeApp()
                            dismiss()
                        } label: {
                            Text("◀ Home")
                                .font(.system(size: 12))
                                .foregroundStyle(.primary)
                                .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 1)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 8)
                        }
                        .buttonStyle(.plain)
                        .padding(.leading, 12)
                        .padding(.top, 4)

                        Spacer()
                    }
                    Spacer()
                }
            }
        }
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
    var useShowroomDefaults = false
    @EnvironmentObject private var phone: PhoneViewModel

    private var contacts: [PhoneContact] {
        LpspCloneBridge.phoneContacts(from: LpspAdapters.contacts(from: phone.contactsPayload()))
    }

    var body: some View {
        let payload = phone.appData(for: appName)

        Group {
            if CloneAppCatalog.isCloneApp(appName) {
                if useShowroomDefaults {
                    showroomCloneView(named: appName)
                } else {
                    cloneView(named: appName, payload: payload)
                }
            } else {
                thirdPartyView(named: appName, payload: payload)
            }
        }
    }

    @ViewBuilder
    private func thirdPartyView(named appName: String, payload: AnyCodable?) -> some View {
        switch LpspAppAliases.canonical(appName) {
        case "WhatsApp":
            LpspWhatsAppView(conversations: LpspAdapters.whatsApp(from: payload))
        case "Signal":
            LpspSignalView(conversations: LpspAdapters.signal(from: payload))
        case "Contacts":
            ContactsView(contacts: contacts)
        case "Uber":
            LpspUberView(rides: LpspAdapters.uber(from: payload))
        case "Banque":
            LpspBanqueView(data: LpspAdapters.banque(from: payload))
        case "Plans":
            LpspPlansView(data: LpspAdapters.plans(from: payload))
        case "Fichiers":
            LpspFichiersView(files: LpspAdapters.fichiers(from: payload))
        case "Rappels":
            LpspRappelsView(lists: LpspAdapters.rappels(from: payload))
        case "Instagram":
            LpspInstagramView(profile: LpspAdapters.instagram(from: payload))
        case "Spotify":
            LpspSpotifyView(data: LpspAdapters.spotify(from: payload))
        case "Netflix":
            LpspNetflixView(data: LpspAdapters.netflix(from: payload))
        case "Apple Music":
            LpspAppleMusicView(data: LpspAdapters.appleMusic(from: payload))
        default:
            GenericLpspAppView(appName: appName, payload: payload)
        }
    }

    @ViewBuilder
    private func showroomCloneView(named appName: String) -> some View {
        switch appName {
        case "Messages":
            MessagesView()
        case "Telephone":
            PhoneView()
        case "Photos":
            PhotosView()
        case "Safari":
            SafariView()
        case "Mail":
            MailView()
        case "Notes":
            NotesView()
        case "Calendrier":
            CalendarView()
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
            MusicView()
        default:
            cloneView(named: appName, payload: nil)
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
            PhotosView(library: LpspCloneBridge.photoLibrary(
                from: LpspAdapters.photos(from: payload),
                albums: LpspAdapters.photoAlbums(from: payload)
            ))
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
            .navigationTitle(LpspAppCatalog.displayName(appName))
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

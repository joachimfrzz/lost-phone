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

    var body: some View {
        let payload = phone.appData(for: appName)

        Group {
            switch appName {
            case "Messages":
                MessagesView(viewModel: LpspCloneBridge.messagesViewModel(from: LpspAdapters.messages(from: payload)))
            case "WhatsApp":
                LpspWhatsAppView(conversations: LpspAdapters.whatsApp(from: payload))
            case "Signal":
                LpspSignalView(conversations: LpspAdapters.signal(from: payload))
            case "Notes":
                NotesView(manager: LpspCloneBridge.notesManager(from: LpspAdapters.notes(from: payload)))
            case "Photos":
                PhotosView(library: LpspCloneBridge.photoLibrary(from: LpspAdapters.photos(from: payload)))
            case "Mail":
                MailView(manager: LpspCloneBridge.mailManager(from: LpspAdapters.mail(from: payload)))
            case "Telephone":
                PhoneView(recentCalls: LpspCloneBridge.recentCalls(from: LpspAdapters.phoneRecents(from: payload)))
            case "Safari":
                SafariView(model: LpspCloneBridge.safariViewModel(
                    tabs: LpspAdapters.safariTabs(from: payload),
                    history: LpspAdapters.safariHistory(from: payload)
                ))
            default:
                if let clone = LpspAppCatalog.cloneType(for: appName) {
                    cloneAppView(clone)
                } else {
                    GenericLpspAppView(appName: appName, payload: payload)
                }
            }
        }
    }

    @ViewBuilder
    private func cloneAppView(_ type: AppType) -> some View {
        switch type {
        case .weather: WeatherView()
        case .calculator: CalculatorView()
        case .settings: SettingsView()
        case .appStore: AppStoreView()
        case .clock: ClockView()
        case .calendar: CalendarView()
        case .camera: CameraView()
        case .music: MusicView()
        default:
            GenericLpspAppView(appName: appName, payload: phone.appData(for: appName))
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

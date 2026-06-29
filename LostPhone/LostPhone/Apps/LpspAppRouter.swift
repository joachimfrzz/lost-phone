import SwiftUI

struct LpspAppContainerView: View {
    let appName: String
    @EnvironmentObject private var phone: PhoneViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject private var volumeObserver = VolumeObserver()
    @State private var initialVolume: Float = 0

    var body: some View {
        ZStack {
            LpspAppRouter(appName: appName)

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
                            .shadow(color: .black.opacity(0.25), radius: 3, y: 1)
                    }
                    .buttonStyle(.plain)
                    .padding(.leading, 12)
                    .padding(.top, 8)
                    Spacer()
                }
                Spacer()
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
    @EnvironmentObject private var phone: PhoneViewModel

    var body: some View {
        let payload = phone.appData(for: appName)

        Group {
            switch appName {
            case "Messages":
                LpspMessagesView(conversations: LpspAdapters.messages(from: payload))
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
        case .notes: NotesView()
        case .settings: SettingsView()
        case .mail: MailView()
        case .appStore: AppStoreView()
        case .clock: ClockView()
        case .calendar: CalendarView()
        case .photos: PhotosView()
        case .phone: PhoneView()
        case .camera: CameraView()
        case .safari: SafariView()
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
                        description: Text("Contenu LPSP absent pour cette app. Éditez stories/j3-louvre/lpsp.json")
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
